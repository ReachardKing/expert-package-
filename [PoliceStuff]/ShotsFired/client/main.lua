
RegisterNetEvent("custom:location")
AddEventHandler("custom:location", function(x, y, z, department, current_rank)
    if IsPedInAnyPoliceVehicle(PlayerPedId()) then
        local ShotsBlip = AddBlipForRadius(x, y, z, config.BlipRadius)
        SetBlipSprite(ShotsBlip, 161)
        SetBlipColour(ShotsBlip, config.BlipColour)
        SetBlipAsShortRange(ShotsBlip, false)
        Citizen.Wait(config.BlipTime)
        RemoveBlip(ShotsBlip)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15)
        local weapon = GetSelectedPedWeapon(PlayerPedId())
        local Silance = IsPedCurrentWeaponSilenced(PlayerPedId())
        local pos = GetEntityCoords(PlayerPedId())
        local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
        local street = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)

        if IsPedShooting(PlayerPedId()) and not Silance and not IsBlacklisted(weapon) then
            TriggerServerEvent("custom:Shots", pos.x, pos.y, pos.z)
            if s2 == 0 then
                TriggerServerEvent('ShotsInProgress', street)
            elseif s2 ~= 0 then
                TriggerServerEvent('ShotsInProgress2', street, street2)
            end
            Citizen.Wait(config.AlertCooldown)
        end
    end
end)

RegisterNetEvent("ShotsNotify")
AddEventHandler("ShotsNotify", function(spotted)
    Wait(config.NotifyTime)
    if IsPedInAnyPoliceVehicle(PlayerPedId()) or IsPedOnFoot(PlayerPedId()) then
        PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true)
        Notify(spotted)
    end
end)

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
 

function IsBlacklisted(model)
    for _, blacklisted in pairs(config.Blacklist) do
        if model ==  blacklisted then
            return true
        end
    end
    return false
end

