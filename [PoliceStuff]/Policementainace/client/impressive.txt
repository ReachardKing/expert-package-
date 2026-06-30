
RegisterNuiCallback("spawn", function()
    SendNUIMessage({type = "HUD", visible = false, SetNuiFocus(false, false)}) 
end)

RegisterNuiCallback("Cancel", function()
    SendNUIMessage({type = "HUD", visible = false, SetNuiFocus(false, false)}) 
end)

RegisterCommand("extra", function(source, args, raw0)
    local extra = args[1]
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleExtra(vehicle, extra, 0)
end)

RegisterCommand("liveries", function(source, args, raw) 
    local liveries = args[1]
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleLivery(vehicle, liveries)
end)