
local money = nil

AddEventHandler("Nameless_Framework:ATM:loaded", function(moneyObject)
    money = moneyObject
end)

RegisterNetEvent("Nameless_Framework:withdraw")
AddEventHandler("Nameless_Framework:withdraw", function(ammount)

    local player = source
    local update = money.functions.withdraw(ammount, player)
    TriggerClientEvent("Nameless_Framework:update", player, update)

end)

RegisterNetEvent("Nameless_Framework:deposit")
AddEventHandler("Nameless_Framework:deposit", function(ammount)

    local player = source
    local update = money.functions.deposit(ammount, player, traget)
    TriggerClientEvent("Nameless_Framework:update", player, update)

end)