--================================--
--       POLICE TOOLS v1.1.0      --
--            by GIMI             --
--      License: GNU GPL 3.0      --
--================================--

--================================--
--              CHAT              --
--================================--

-- TriggerEvent("chat:addTemplate", "policetools", '<div style="text-indent: 0 !important; padding: 0.5vw; margin: 0.05vw; color: rgba(255,255,255,0.9);background-color: rgba(3, 165, 252, 0.8); border-radius: 4px;"><b>{0}</b> {1} </div>')

Config = Config or {}
	
doorList = (Config and Config.resources.doorList) or (Config and Config.resources.doorList) or {}

local state = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerId = GetPlayerServerId(PlayerId())
        local playerCoords = GetEntityCoords(PlayerPedId())
        for i = 1, #doorList do
            local closeDoor = GetClosestObjectOfType(doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], 1.0, GetHashKey(doorList[i]["objName"]), false, false, false)
            local playerDistance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], true)

            -- ensure the door entry and its distance exist before comparing
            if doorList[i] and doorList[i]["distance"] and playerDistance <= doorList[i]["distance"] then
                if doorList[i]["locked"] == true then
                    DrawText3d(doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], "[E] - Locked")
                    SendNUIMessage({ type = "Lock", id = i, locked = true })
                else
                    DrawText3d(doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], "[E] - Unlocked")
                    SendNUIMessage({ type = "Lock", id = i, locked = false })
                end
            
                
                -- Control input for door locking.
                if IsControlJustReleased(0, 51) then
                    TriggerEvent('mDoorLocks:anim')
                    Citizen.Wait(850)
                    
                    if doorList[i]["locked"] == true then
                        FreezeEntityPosition(closeDoor, false)
                        doorList[i]["locked"] = false
                        Citizen.CreateThread(function()
                            Citizen.Wait(2000)
                            if not doorList[i]["locked"] then
                                doorList[i]["locked"] = true
                                TriggerServerEvent('mDoorLocks:update', i, true)
                            end
                        end)
                    else
                        FreezeEntityPosition(closeDoor, true)
                        doorList[i]["locked"] = true
                    end
                    TriggerServerEvent('mDoorLocks:update', i, doorList[i]["locked"])
                end
            else
                -- only try to freeze if we found a valid object and a door entry exists
                if closeDoor and doorList[i] then
                    FreezeEntityPosition(closeDoor, doorList[i]["locked"])
                end
            end
		end
	end
end)



function DrawText3d(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 100)
		ClearDrawOrigin()
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('mDoorLocks:anim')
AddEventHandler('mDoorLocks:anim', function()
    ClearPedSecondaryTask(GetPlayerPed(-1))
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim(GetPlayerPed(-1), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    Citizen.Wait(850)
    ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('mDoorLocks:state')
AddEventHandler('mDoorLocks:state', function(id, isLocked)
    if doorList[id] ~= nil then
        doorList[id]["locked"] = isLocked
    end
end)

if Config.resources.whitelisted then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local playerId = GetPlayerServerId(PlayerId())
            if not IsWhitelisted(playerId) then
                state = false
            else
                state = true
            end
        end
    end)
end

function IsWhitelisted(playerId)
    for i = 1, #Config.resources.whitelisted do
        if playerId == Config.resources.whitelisted[i] then
            return true
        end
    end
    return false
end