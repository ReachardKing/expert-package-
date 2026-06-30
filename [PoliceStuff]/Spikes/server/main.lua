RegisterNetEvent("Police_Spikes_addSpikes", function(position)
    local spikes = CreateObject(SpikesModel, position.x, position.y, position.z, true, false)

    SetEntityHeading(spikes, position.w)
    FreezeEntityPosition(spikes, true)

    spikes[NetworkGetEntityFromNetworkId(spikes)] = position 

    TriggerClientEvent("Police_Spikes_sync", -1, spikes)
end)

RegisterNetEvent("Police_Spikes_remove", function(id, remove)

    if spikes[id] then
        DeleteEntity(NetworkGetEntityFromNetworkId(id))
        spikes[id] = nil

        TriggerClientEvent("Police_Spikes_sync", -1, spikes)
    end
end)