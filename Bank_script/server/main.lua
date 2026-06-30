

local money = nil
local dutystatus = {}

RegisterNetEvent("Nameless_Framework:withdraw")
AddEventHandler("Nameless_Framework:withdraw", function(ammount)

    local player = source
    local update = money.functions.withdraw(ammount, player)
    TriggerClientEvent("Nameless_Framework:Updatemoney", player, update)

end)

RegisterNetEvent("Nameless_Framework:deposit")
AddEventHandler("Nameless_Framework:deposit", function(ammount)

    local player = source
    local update = money.functions.deposit(ammount, player, traget)
    TriggerClientEvent("Nameless_Framework:Updatemoney", player, update)

end)

local dutyStart = {} -- stores os.time() for each player

RegisterNetEvent("policeTools:OnDutyChanged")
AddEventHandler("policeTools:OnDutyChanged", function(isOnDuty)
    local src = source

    if isOnDuty then
        dutyStart[src] = os.time()
    else
        dutyStart[src] = nil
    end
end)

CreateThread(function()
    while true do
        Wait(5 * 60 * 1000) -- 5 minutes

        for _, playerId in ipairs(GetPlayers()) do
            local isOnDuty = exports.policeTools:IsOnDuty(playerId)

            if isOnDuty then
                local start = dutyStart[playerId]

                if start then
                    local now = os.time()
                    local minutes = math.floor((now - start) / 60)

                    -- PAY FORMULA
                    local pay = minutes * 50 -- $50 per minute (example)

                    -- Give money (adjust for your framework)
                   exports.money.functions:add(math.random(0, pay), source, "bank")

                    -- Reset timer
                    dutyStart[playerId] = os.time()
                end
            end
        end
    end
end)
