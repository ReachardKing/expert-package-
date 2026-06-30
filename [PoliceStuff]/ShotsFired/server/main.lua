
RegisterNetEvent("ShotsInProgress")
AddEventHandler("ShotsInProgress", function(street)
    TriggerClientEvent("ShotsNotify", -1, "~r~[Shots Firered] ~w~Gunshot detected: "..street)
end)

RegisterNetEvent("ShotsInProgress2")
AddEventHandler("ShotsInProgress2", function(street, street2)
    TriggerClientEvent("ShotsNotify", -1, "~r~[Shots Firered] ~w~Gunshot detected: "..street.. " , "..street2)
end)

RegisterNetEvent("custom:Shots")
AddEventHandler("custom:Shots", function(x, y, z)
    TriggerClientEvent("custom:location", -1, x,  y, z)
end)