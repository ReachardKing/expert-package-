
playerData = {}
Config = {}
inhuntingzone, inNotdispatchzone = false, false 
huntingzones, dispatchzones, huntingBlips = {}, {}, {}

local blips = {}
local radiusBlips = {}
local alertmuted = false
local alertdisabled = false

Config.Locations = {
    ["HuntingZones"] = {
        [1] = {label = "Hunting Zone", radius = 650.0, coords = vector3(-938.61, 4823.99, 313.92)},
    },
    ["NoDispatchZones"] = {
        [1] = {label = "Ammunation 1", coords = vector3(13.53, -1097.92, 29.8), length = 14.0, width = 5.0, heading = 70, minZ = 28.8, maxZ = 32.8},
        [2] = {label = "Ammunation 2", coords = vector3(821.96, -2163.09, 29.62), length = 14.0, width = 5.0, heading = 270, minZ = 28.62, maxZ = 32.62},
    },
}

function Setupdispatch()
    Wait(1000)
    CreateHuntingZone()

    SendNUIMessage({
        action = "setupUI",
        data = {
            player = playerData,
            maxcalllist = Config.maxcalllist,
            shortcalls = Config.shortcalls,
        }
    })
end

function RemoveHuntingZone()
    for i = 1, #huntingBlips do
        RemoveBlip(huntingBlips[i])
    end

    huntingzones, dispatchzones, huntingBlips = {}, {}, {}
end

function CreateHuntingZone()
    if Config.EnableHuntingBlip then
        for _, hunting in pairs(Config.Locations['HuntingZones']) do
            if hunting then
                local blip = AddBlipForCoord(hunting.coords.x, hunting.coords.y, hunting.coords.z)
                local huntingradius = AddBlipForRadius(hunting.coords.x, hunting.coords.y, hunting.coords.z, hunting.radius)

                SetBlipSprite(blip, 422)
                SetBlipAsShortRange(blip, true)
                SetBlipDisplay(blip, 6)
                SetBlipScale(blip, 0.8)
                SetBlipAlpha(blip, 255)
                SetBlipColour(blip, 2)

                SetBlipColour(huntingradius, 0)
                SetBlipAlpha(huntingradius, 40)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(hunting.label)
                EndTextCommandSetBlipName(blip)

                huntingBlips[#huntingBlips+1] = blip
                huntingBlips[#huntingBlips+1] = huntingradius
            end

            huntingzones[#huntingzones+1] = hunting
        end
    end
end

function Isjobvalidated(data)
    local jobType = Config.JobTypes[data]
    if not jobType then return false end
    playerData.job = Config.JobTypes[data]

    if Config.OnDutyOnly then
		return jobType
	end
end

function Randomoffset(basex, baseY, basez, offset)
    local ranX = basex + math.random(-offset, offset)
    local ranY = baseY + math.random(-offset, offset)
    return ranX, ranY, basez
end

function CreateBlipData(coords, radius, sprite, color, scale, flash)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local radiusblip = AddBlipForRadius(coords.x, coords.y, coords.z, radius)

    SetBlipFlashes(blip, flash)
    SetBlipSprite(blip, sprite or 161)
    SetBlipDisplay(blip, 6)
    SetBlipHighDetail(blip, true)
    SetBlipScale(blip, scale or 1.0)
    SetBlipColour(blip, color or 84)
    SetBlipAlpha(blip, 255)
    SetBlipAsShortRange(blip, false)
    SetBlipCategory(blip, 2)

    SetBlipColour(radiusblip, color or 84)
    SetBlipAlpha(radiusblip, 129)

    return blip, radiusblip
end

function CreateCurrentBlip(data, blippsData)
    local blip, radiusblip
    local sprite = blippsData.sprite or (blippsData.alert and blippsData.alert.sprite) or 161
    local color = blippsData.color or (blippsData.alert and blippsData.alert.color) or 84
    local scale = blippsData.scale or (blippsData.alert and blippsData.alert.scale) or 1.0 
    local flash = blippsData.flash or false 
    local radius = blippsData.radius or (blippsData.alert and blippsData.alert.radius) or 50

    if blippsData.offset then
        local offsetX, offsetY, offsetZ = Randomoffset(data.coords.x, data.coords.y, data.coords.z, blippsData.offset)
        blip, radiusblip = CreateBlipData({x = offsetX, y = offsetY, z = offsetZ}, radius, sprite, color, scale, flash)
    else
        blip, radiusblip = CreateBlipData(data.coords, radius, sprite, color, scale, flash)
    end

    blips[data.id] = blip
    radiusBlips[data.id] = radiusblip

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString((data.code or "") .. " " .. (data.message or ""))
    EndTextCommandSetBlipName(blip)

    -- Fade radius out
    local radiusalpha = 129
    local waitTime = ((blippsData.length or (blippsData.alert and blippsData.alert.length) or 2) * 8000) / radiusalpha

    Citizen.CreateThread(function()
        while radiusalpha > 0 do
            radiusalpha = math.max(0, radiusalpha - 1)
            SetBlipAlpha(radiusblip, radiusalpha)
            Citizen.Wait(waitTime)
        end
        RemoveBlip(radiusblip)
        RemoveBlip(blip)
        blips[data.id] = nil
        radiusBlips[data.id] = nil
    end)
end

function AddCustomBlips(data, blippsData)
    Citizen.CreateThread(function()
        CreateCurrentBlip(data, blippsData)
    end)

    if not alertmuted then 
        if blippsData.sound == "lose_1st" then 
            PlaySound(-1, blippsData.sound, blippsData.sound2 or "GTO_FM_Event_soundset", 0, 0, 1)
        else
            TriggerServerEvent("Sound_sv:playsound", blippsData.sound, blippsData.alert and blippsData.alert.sound or "", 0.25)
        end
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    Setupdispatch()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    RemoveHuntingZone()
end)

RegisterNetEvent("DispatchSystem:Notify", function(data)
    if not data or alertdisabled then return end
    if not data.alertTime then data.alertTime = Config.alertTime end
    if not Isjobvalidated(data.job) then return end

    local timer = data.alertTime * 1000

    SendNUIMessage({
        action = "Status",
        data = {
            data = data,
            timer = timer,
        }
    }) 
    
    AddCustomBlips(data, Config.blips[data.customName] or {})

    local startedTimer = GetGameTimer()
    while GetGameTimer() - startedTimer < timer do
        Citizen.Wait(100)
    end
end)

RegisterNUICallback("ToggleMute", function(data, cb)
    local state = data.boolean
    alertmuted = state
    exports.NamelessNotify:display({type = "success", title = "Alerts", text = "Alerts " .. (state and "muted" or "unmuted"), icon = "fas fa-volume-mute", length = 500})
    cb('ok')
    SendNUIMessage(({type = "closeUI"}))
end)

RegisterNUICallback("clearBlips", function(data, cb)
    for _, v in pairs(blips) do
        RemoveBlip(v)
    end
    for _, v in pairs(radiusBlips) do
        RemoveBlip(v)
    end
    blips, radiusBlips = {}, {}
    exports.NamelessNotify:display({type = "success", title = "Clear", text = "Blips cleared", icon = "fas fa-times", length = 500})
    cb('ok')
    SendNUIMessage(({type = "closeUI"}))
end)

RegisterNUICallback("toggleAlerts", function(data, cb)
    local state = data.boolean
    alertdisabled = state
    exports.NamelessNotify:display({type = "success", title = "Alerts", text = "Alerts " .. (state and "disabled" or "enabled"), icon = "fas fa-bell-slash", length = 500})
    cb('ok')
    SendNUIMessage(({type = "closeUI"}))
end)

RegisterNUICallback("waypoint", function(_, cb)
    if not playerData.job or not playerData.job.type then return end

    TriggerServerEvent("DispatchSystem:GetLatestDispatch")

    RegisterNetEvent("DispatchSystem:SendLatestDispatch", function(data)
        if not data or not data.coords then return end
        if not data.alertTime then data.alertTime = Config.alertTime end

        if table.contains(data.job, playerData.job.type) then
            SetNewWaypoint(data.coords.x, data.coords.y)
            exports.NamelessNotify:display({
                type = "success",
                title = "Waypoint set",
                text = ("%.2f, %.2f"):format(data.coords.x, data.coords.y),
                icon = "fas fa-map-marker-alt",
                length = 500
            })
        end
    end)

     if not Config.EnableHuntingBlip and IsControlJustPressed(0, Config.RespondKeybind) then
        SetNewWaypoint(data.coords.x, data.coords.y, data.coords.z)
    end

    cb('ok')
end)

RegisterNUICallback("refreshAlerts", function(data, cb)
    exports.NamelessNotify:display({type = "success", title = "Refresh", text = "Alerts refreshed", icon = "fas fa-sync", length = 500})
    SendNUIMessage({action = "setupUI", data = data})
    cb('ok')
end)
