
local SpawnSpikes = {}
local SpikesModel = 'P_ld_stringer_s'
local closeSpikes = false

Citizen.CreateThread(function()
    while true do Citizen.Wait(0)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                local vehiclepos = GetEntityCoords(vehicle)
                local spikes = GetClosestObjectOfType(vehiclepos.x, vehiclepos.y, vehiclepos.z, 80.0, GetHashKey(SpikesModel), 1, 1, 1)
                local spikespos = GetEntityCoords(spikes, false)
                local distance = Vdist(vehiclepos.x, vehiclepos.y, vehiclepos.z, spikespos.x, spikespos.y, spikespos.z)
                
                if spikes ~= 0 then
                    closeSpikes = true
                else
                    closeSpikes = false
                end
            else
                closeSpikes = false
            end
        else
            closeSpikes = false
        end
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do Citizen.Wait(0)
        if closeSpikes then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local tires = {
                    {bone = "wheel_lf", index = 0},
                    {bone = "wheel_rf", index = 1},
                    {bone = "wheel_lm", index = 2},
                    {bone = "wheel_rm", index = 3},
                    {bone = "wheel_lr", index = 4},
                    {bone = "wheel_rr", index = 5},
                }
                local vehiclepos = GetEntityCoords(vehicle, false)
                local spikes = GetClosestObjectOfType(vehiclepos.x, vehiclepos.y, vehiclepos.z, 80.0, GetHashKey(SpikesModel), 1, 1, 1)
                if spikes ~= 0 then
                    local spikespos = GetEntityCoords(spikes, false)
                    local distance = Vdist(vehiclepos.x, vehiclepos.y, vehiclepos.z, spikespos.x, spikespos.y, spikespos.z)
                    if distance < 2.0 then
                        for b = 1, #tires do
                            if not IsVehicleTyreBurst(vehicle, tires[b].index, false) then
                                SetVehicleTyreBurst(vehicle, tires[b].index, false, 100.0)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)

RegisterNUICallback("SetSpikes", function()
    if CheckPedrestricktion(PlayerPedId()) then
        createSpikes(max)
    else
        createSpikes(max)
    end
end)

RegisterNUICallback("PickupSpikes", function(id)
    exports["progressBars"]:StartUI(3000, "Picking up Spikes..")
    Citizen.Wait(3000)
    local spikes = NetworkGetEntityFromNetworkId(id)
    DeleteEntity(spikes)
end)


function createSpikes(amount)
    exports["progressBars"]:StartUI(3000, "Setting up Spikes..")
    Citizen.Wait(3000)

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    local spawnCount = tonumber(amount) or 1
    local Spawncoords = vector3(coords.x + forward.x * 2.0, coords.y + forward.y * 2.0, coords.z)

    for c = 1, spawnCount do
        local spike = CreateObject(GetHashKey(SpikesModel), Spawncoords.x, Spawncoords.y, Spawncoords.z, true, true, true)
        local id = ObjToNet(spike)
        SetNetworkIdExistsOnAllMachines(id, true)
        SetNetworkIdCanMigrate(id, false)
        SetEntityHeading(spike, GetEntityHeading(ped))
        PlaceObjectOnGroundProperly(spike)
        Spawncoords = GetOffsetFromEntityGivenWorldCoords(spike, 0.0, 4.0, 0.0)
        table.insert(SpawnSpikes, id)
    end
    closeSpikes = true
end

RegisterCommand("Spikes", function(department, current_rank)
    SetNuiFocus(false, false)
    SendNUIMessage({action = "SpikesIt", visible = true, Spikes = "Set up Spikes"})
end)

RegisterCommand("Spikesremove", function(department, current_rank)
    SetNuiFocus(false, false)
    SendNUIMessage({action = "SpikesIt", visible = true, pickup = "pick up Spikes"})
end)

RegisterKeyMapping("Spikes", "Set Spikes", "keyboard", "")
RegisterKeyMapping("Spikesremove", "Remove Spikes", "keyboard", "")