
print("I created this !!! !!  !!!")

local calls = {}

RegisterNetEvent("DispatchSystem:Notify", function(data)
    callouts = callouts + 1
    data.time = os.time * 1000
    data.units = {}
    data.respons = {}

    if #calls > config.maxcalllist then
        table.remove(calls, 1)
    end
    calls[#calls + 1] = data
    
    TriggerClientEvent("DispatchSystem:notify", -1, data)
end)

RegisterServerEvent("DispatchSystem:attach", function(calldata)
	table.insert(calls, calldata)
end)

RegisterServerEvent("DispatchSystem:dettach", function(id, player)
    for i = 1, #calls, -1 do
        if calls[i]['id'] == id then
            if calls[i]['units'] and (#calls[i]['units'] or 0) > 0 then
                for k = #calls[i]['units'], 1, -1 do 
                    if calls[i]['units']['citizenid'] == player.citizenid then
                        table.remove(calls[i]['units'], i)
                    end
                end
            end
            return
        end
    end
end)

RegisterNetEvent("DispatchSystem:GetLatestDispatch", function(source)
     local src = source
    local latest = calls[#calls]
    if latest then
        TriggerClientEvent("DispatchSystem:SendLatestDispatch", src, latest)
    end
end)

RegisterNetEvent("DispatchSystem:Getcalls", function()
    return calls
end)