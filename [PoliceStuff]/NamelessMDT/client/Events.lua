
citizenData = {}
result = {}
RegisterNUICallback("close", function() SendNUIMessage({type = "remove"}) end) SetNuiFocus(false, false)

RegisterNUICallback("searchProfile", function(character, cb, result)
    citizenData[character] = result
    -- Callback to confirm the function executed
end)

RegisterNUICallback('searchVehicles', function(character)
    citizenData[character] = result

end)

RegisterNUICallback("SearchWeapons", function(character, result)
    citizenData[character] = result

end)

RegisterNUICallback("getIncidentData", function(cam)
    -- This wil get saved incidents created from MSQL In a fivem hosting interface
end)

RegisterNUICallback("openevidencelocker", function()
    local EvidenceLockerLocations = {
        vector3(1849.15, 3695.38, 34.28), -- Sandy Shores
        vector3(1840.99, 3690.23, 34.28), -- Sandy Shores
        vector3(452.47, -979.97, 30.69),  -- MRPD Station
        vector3(-450.14, 6016.27, 31.72)  -- Paleto Station
    }

    local closestDistance = math.huge
    local closestLocation = nil
    local playercoords = GetEntityCoords(PlayerPedId())
    
    for _, location in pairs(EvidenceLockerLocations) do
        local distance = #(playercoords - location)
        if distance < closestDistance then
            closestDistance = distance
            closestLocation = location
        end
    end
    
    if closestDistance <= 2.0 then
        TriggerServerEvent("inventory:openStorage", source, { maxWeight =  500, maxSpace = 5000})
    else
        print("You're too far from any evidence locker.") -- Debugging message
    end    
end)

RegisterNUICallback("SaveIncident", function()
-- Sends the info to a SQL Database
end)

RegisterNUICallback("Processed", function(data)
    if not data or not data.id then
        print("Error: No player ID provided.")
        return
    end

    local targetPlayer = GetPlayerFromServerId(data.id)
    if targetPlayer == -1 then
        print("Error: Invalid player ID.")
        return
    end

    local targetPed = GetPlayerPed(targetPlayer)
    if DoesEntityExist(targetPed) then
        SetEntityCoords(targetPed, 1677.233, 2658.618, 45.216, true, false, false, true)
        print("Player successfully teleported.")
    else
        print("Error: Target player not found.")
    end
end)

RegisterNUICallback("PointSystem", function(character, data, cb, vehicle, result)
    citizenData[character] = result
end)