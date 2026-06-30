
-- For All work mod

function GetHeavyBodyDamage(vehicle, class, number)
    SendNUIMessage({
        action = "display",
        bodyhealth = GetVehicleBodyHealth(vehicle),
        bodyclass = GetVehicleClass(class),
        bodyfuel = GetVehicleFuelLevel(vehicle),
        ExtamateSpeed = GetVehicleClassEstimatedMaxSpeed(number),
        Doors = GetNumberOfVehicleDoors(vehicle),
        Wheels = GetVehicleNumberOfWheels(vehicle),
        Seats = GetVehicleModelNumberOfSeats(number),
        Agility = GetVehicleClassMaxAgility(number),
        Breaking = GetVehicleClassMaxBraking(number),
        Traction = GetVehicleClassMaxTraction(number),
        Name = GetDisplayNameFromVehicleModel(vehicle),
        Plate = GetVehicleNumberPlateText(vehicle),
        Gear = GetVehicleCurrentGear(number),
        VehicleRPM = GetVehicleCurrentRpm(number),
        Dirt = GetVehicleDirtLevel(number)

    })
end

-- Citizen.CreateThread( function()
--     while true do Citizen.Wait(0) 
--         local pl = GetEntityCoords(PlayerPedId())
--         if GetDistanceBetweenCoords(pl.x, pl.y, pl.z, 0.00, 0.00, 0.00) < 1.5 then
--             if IsPedInAnyVehicle(GetVehiclePedIsIn(PlayerPedId()), true) then
--             end
--         end
--     end
-- end)