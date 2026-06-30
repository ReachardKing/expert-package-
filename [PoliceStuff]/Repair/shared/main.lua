
function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function SpawnInputVeicle(veh, Name)
    local Ped = GetPlayerPed( -1 )
    if (DoesEntityExist(Ped) and not IsEntityDead(Ped)) then 
        local pos = GetEntityCoords(Ped)
        if (IsPedSittingInAnyVehicle(Ped)) then 
            local Vehicle = GetVehiclePedIsIn(Ped, false)
            if (GetPedInVehicleSeat(Vehicle, -1) == Ped) then 
                SetEntityAsMissionEntity(Vehicle, true, true )
                SetVehicleOnGroundProperly(Vehicle)
                DeleteVehicle(Vehicle)
            end
        end
    end

    local WaitTime = 0
    local Model = GetHashKey(veh)
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        RequestModel(Model)
        Citizen.Wait(100)

        WaitTime = WaitTime + 1

        if WaitTime == 600 then
            CancelEvent()
            Notify('~r~Unable to load vehicle, please contact development!')
            return
        end
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local Vehicle = CreateVehicle(Model, x + 3, y + 3, z + 1, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), Vehicle, -1)
    SetVehicleDirtLevel(Vehicle, 0)
    SetVehicleModKit(Vehicle, 0)
    SetVehicleMod(Vehicle, 23, -1, false)
    SetVehicleOnGroundProperly(Vehicle)
    SetModelAsNoLongerNeeded(Model)
    SetVehicleLivery(Vehicle, tonumber(args[1]))
    SetVehicleExtra(Vehicle, tonumber(args[1]), true)

    for Colours = 0, 20 do
        SetVehicleColours(Vehicle, Colours, Colours)
    end
    
    for Mod = 0, 12 do
        SetVehicleXenonLightsColor(Vehicle, Mod)
    end

    for ModType = 0, 10, 1 do
        local bestMod = GetNumVehicleMods(Vehicle, ModType)-1
        SetVehicleMod(Vehicle, ModType, bestMod, false)
    end
end