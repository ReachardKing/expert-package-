
local MaxTazer = 3
local longerTazerTime = true

Citizen.CreateThread(function()
    while true do Citizen.Wait(0)
        if not HasStreamedTextureDictLoaded("mpweaponsgang0") then
            RequestStreamedTextureDict("mpweaponsgang0", true)
            while not HasStreamedTextureDictLoaded("mpweaponsgang0") do
                Citizen.Wait(0)
            end
        end

        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(`weapon_stungun`) then
            if IsPedShooting(PlayerPedId()) then
                MaxTazer = MaxTazer - 1
            end
            
            if longerTazerTime then
                SetPedMinGroundTimeForStungun(PlayerPedId(), 20 * 1000)
            end
        end

        if MaxTazer <= 0 then
           return 0
        end
    end
end)

RegisterCommand("refil", function()
    if MaxTazer <= 0 and IsPedInAnyPoliceVehicle(PlayerPedId()) then
        MaxTazer = MaxTazer + 3
    end
end)


function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end