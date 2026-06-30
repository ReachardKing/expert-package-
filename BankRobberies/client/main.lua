
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local Bankroberies = {vector3(00.00, 000.00, 00.00)}
            
            
        for _, location in pairs(Bankroberies) do

            local playercords = GetEntityCoords(PlayerPedId())

            if IsControlJustPressed(0, 38) and GetDistanceBetweenCoords(playercords.x, playercords.y, playercords.z, location.x, location.y, location.z,true) < 2.0 then -- check if player is within 2 units of the location
                SendNUIMessage({action = "BillThis", visible = true})
            end
        end
    end
end)


RegisterNUICallback('close', function(cb)
    SendNUIMessage({action = "BillThis", visible = false})
    cb('ok')
end)