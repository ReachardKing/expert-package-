
local impoundedVehicles = {}


function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool and "init" or "remove",
        action = bool and "init" or "remove"
    })
end

RegisterCommand("PoliceImpound", function()
    SetDisplay(not guiEnabled)
end)

RegisterNUICallback("impoundVehicle", function(plate, source, firstname, lastname)
    local player = ("%s %s"):format(firstname, lastname)
    if not impoundedVehicles[plate] then
        impoundedVehicles[plate] = {player = player}
        exports.NamelessNotify:display({type = "success", title = impoundedVehicles[plate].player, text = impoundedVehicles[plate].player.. " was impounded", length = 100})
    else
        exports.NamelessNotify:display({type = "error", title = impoundedVehicles[plate].player, text = impoundedVehicles[plate].player.. " not found", length = 100})
        Citizen.Wait(50000)
    end
	SendNUIMessage({type = 'init', visible = false})
end)

RegisterNUICallback("removeImpound", function(plate, hash)
    for locations in each(config.ImpoundLocations) do
        if impoundedVehicles[plate] then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vehicleModel = GetHashKey(hash[plate]) -- Replace with actual saved vehicle model
            RequestModel(vehicleModel)
            while not HasModelLoaded(vehicleModel) do
                Wait(0)
            end
            local vehicle = CreateVehicle(vehicleModel, coords.x, coords.y, coords.z, 0.0, true, false)
            SetVehicleNumberPlateText(vehicle, impondedvehicles[plate])
            SetPedIntoVehicle(ped, vehicle, -1)
        end
    end
	SendNUIMessage({type = 'init', visible = false})
end)


