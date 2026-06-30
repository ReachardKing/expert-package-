
-- Use you own or pre made framework
RegisterNUICallback("Freedom", function(data)
    SendNUIMessage({action = 'closeAll', status = false})SetNuiFocus(false, false)
    SetEntityCoords(GetPlayerPed(GetPlayerFromServerId(data.id)), 425.11, -979.55, 30.71, true, false, false, true)
end)

RegisterNUICallback("cancel", function()
    SendNUIMessage({action = 'closeAll', status = false}) SetNuiFocus(false, false)
end)
 
RegisterNUICallback("confirm", function()
    SendNUIMessage({action = 'closeAll', status = false})SetNuiFocus(false, false)
end)
 
RegisterNUICallback("confirm", function()
    SendNUIMessage({action = "closeAll", status = false})SetNuiFocus(false, false)
end)
 
RegisterNUICallback("cancel", function()
    SendNUIMessage({action = "closeAll", status = false})SetNuiFocus(false, false)
end)
 
RegisterNUICallback("close", function()
    SendNUIMessage({type = "Status", status = false})SetNuiFocus(false, false)
end)

RegisterNUICallback("submit",function(data)
	SendNUIMessage({type = "Status", status = false})SetNuiFocus(false, false)
	SetEntityCoords(GetPlayerPed(GetPlayerFromServerId(data.id)), 425.11, -979.55, 30.71, true, false, false, true)
end)