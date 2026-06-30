
local impoundDisplay = false
local PlateInfo = {}

RegisterNUICallback("chosen", function(daa)
    SendNUIMessage("select", nil)

    local plateinfo = stringsplit(data.plate or "")
    plateinfo[1] = string.upper(plateinfo[1] or "")
    plateinfo[1] = string.gsub(plateinfo[1], "%s", "")

    if plateinfo[1] and plateinfo[2] then
        PlateInfo[1] = plateinfo[1]
        SpawnSelectedVehicle(plateinfo[1])
    end
end)

RegisterNUICallback("manageitemselect", function(data)
    SendNUIMessage("lists", {
        model = GetDisplayNameFromVehicleModel(data.model),
        bodyhealth = GetVehicleBodyHealth(data.model),
        plate = GetVehicleNumberPlateText(data.model),
        name = GetLabelText(GetDisplayNameFromVehicleModel(data.model)),
        bodyclass = GetVehicleClass(data.model),
    })
    SpawnSelectedVehicle(data.model)
end)

RegisterNUICallback("close", function()
    SendNUIMessage("Select", nil)
end)

RegisterCommand("close", function()
    SendNUIMessage("Select", nil)
end)

RegisterNUICallback("remove", function(cb)
    SetMouseCursorVisibleInMenus(false)
    SetNuiFocus(false, false)
    SendNUIMessage({type = "remove"})
    cb('ok')
end)

RegisterCommand("remove", function()
    SetMouseCursorVisibleInMenus(false)
    SetNuiFocus(false, false)
	SendNUIMessage("Select", nil)
end)

RegisterNUICallback("cancel", function()
    SetMouseCursorVisibleInMenus(false)
    SetNuiFocus(false, false)
	SendNUIMessage("Select", nil)
end)

RegisterNUICallback("submit", function()
    SetMouseCursorVisibleInMenus(false)
    SetNuiFocus(false, false)
	SendNUIMessage("Select", nil)
end)

RegisterCommand("close", function()
    SetMouseCursorVisibleInMenus(false)
    SetNuiFocus(false, false)
	SendNUIMessage("Select", nil)
end) 

SendNUIMessage({type = "remove", visible = false}) SetNuiFocus(false, false)

RegisterKeyMapping("PoliceImpound", "", "keyboard", "")


config = {}

config.setup = {
    distance = 1,
    key = 38 or 51
}

config.Zones = { -- the type has to match the type defined in config.Weapons
    { Type = "Police Impound", loc = vector3(-1112.79, -848.49, 13.44)}, -- VESPUCCI POLICE DEPT
    { Type = "Police Impound", loc = vector3(1853.19, 3689.14, 34.27)}, -- Sandy Shores
    { Type = "Police Impound", loc = vector3(459.27, -1007.7, 28.26)}, -- MRPD Station
    { Type = "Police Impound", loc = vector3(407.99, -1624.74, 29.29)}, -- Davis second lot
    { Type = "Police Impound", loc = vector3(-458.33, 6031.84, 31.49)}, -- Paleto Station
    { Type = "Police Impound", loc = vector3(838.03, -1375.33, 26.31)}, -- La mesa
    { Type = "Police Impound", loc = vector3(529.68, -23.51, 70.63)}, -- Vine Wood DP
}

Citizen.CreateThread(function()
    while true do
        local sleep = 1000 -- reduce CPU usage when far
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)

        for _, zone in ipairs(config.Zones) do
            local dist = #(pCoords - zone.loc)
            
            if dist <= config.setup.distance then
                sleep = 0
                DisplayHelpNotification(("Press ~INPUT_CONTEXT~ to access %s"):format(zone.Type))

                if (IsControlJustPressed(0, config.setup.key)) then
                    SendNUIMessage({type = "Select"})
                    SetNuiFocus(true, true)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function DisplayHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
   DrawNotification(false, false)
end

function SpawnSelectedVehicle(model)
    RequestModel(model)
    while not HasModelLoaded(model) do 
        Citizen.Wait(1)
    end

    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed))
    local vehicle = CreateVehicle(model, x + 2, y + 3, z + 1, GetEntityHeading(playerPed), true, false)
    SetPedIntoVehicle(PlayerId(), vehicle, -1)
    SetVehicleOnGroundProperly(vehicle)
    SetModelAsNoLongerNeeded(model)
    SetVehicleHasBeenOwnedByPlayer(vehicle)
    ClearAreaOfObjects(x, y, z, 10.0, false) -- Adjust radius if needed
end