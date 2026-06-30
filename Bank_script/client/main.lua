
local display = false
local nearModel = false
CompanyName = "Fleeca Bank"
CompanyIcon = "CHAR_BANK_FLEECA"
--   ShowAdvancedNotification(companyIcon, companyName, "Bank Services", "The bank has give you a deposite of $ 8000~y~" .. companyName)
local banks = {
    vector3(1175.77, 2706.89, 38.09),
    vector3(149.23, -1040.57, 29.36),
    vector3(-2962.53, 482.25, 15.69),
    vector3(-112.02, 6469.13, 31.62),
    vector3(-351.56, -49.70, 49.02),
    vector3(313.66, -278.90, 54.16),
    vector3(-1213.08, -330.93, 37.77),
    vector3(247.69, 223.13, 106.29), -- Big Bank
    vector3(4477.25, -4464.29, 3.24), -- cayo perico bank
}

local days = {
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
}

-- Get the time
function getTime()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    if hours <= 9 then
        hours = "0" .. hours
    end
    if minutes <= 9 then
        minutes = "0" .. minutes
    end
    return hours .. ":" .. minutes
end

-- Hide/Show ui
function SetDisplay(bool, data, firstname, lastname)
    local playerInfo = exports["money_script"]:getMoney()
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool and "openBankUI" or "closeBankUI",
		playerName = GetPlayerName(PlayerId()),
		balance = "Account Balance: $" .. playerInfo.bank .. ".00",
        date = days[GetClockDayOfWeek() + 1],
        time = getTime()
    })
end

RegisterNUICallback("collectPlaycheck", function(source)
    SetDisplay(false)
end)

-- check if ped is close to a bank coordinate.
function inRange(ped)
    playerCoords = GetEntityCoords(ped)
    for _, bank in pairs(banks) do
        if (#(playerCoords - bank)) < 1.5 then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        ped = PlayerPedId()
        nearModel = inRange(ped)
    end
end)

Citizen.CreateThread(function()
    while true do Citizen.Wait(3500)
        if not display and nearModel then
            SetDisplay(true)
        end
    end
end)

-- close the ui.
RegisterNUICallback("close", function(data)
    SetDisplay(false)
    TriggerScreenblurFadeOut(1000)
end)

-- makes a button sount for when the ui is clicked.
RegisterNUICallback("sound", function(data)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", true)
end)

-- deposit/withdraw
RegisterNUICallback("useATM", function(data)
    local action = string.gsub(data.action, " ", "")
    if action == "WITHDRAW" then
        if data.amount == "" then
            Citizen.Wait(1000)
            SendNUIMessage({
                success = false
            })
            return
        end
        TriggerServerEvent("Nameless_Framework:withdraw", data.amount)
    elseif action == "DEPOSIT" then
        if data.amount == "" then
            Citizen.Wait(1000)
            SendNUIMessage({
                success = false
            })
            return
        end
        TriggerServerEvent("Nameless_Framework:deposit", data.amount)
    elseif action == "TRANSFER" then
        if data.transferAmount == "" or data.transferTarget == "" then
            Citizen.Wait(1000)
            SendNUIMessage({
                success = false
            })
            return
        end
        TriggerServerEvent("Nameless_Framework:transfer", data.transferAmount, data.transferTarget)
    end
end)

-- update the balance on the ui and confirm if the deposit/withdraw was successful.
RegisterNetEvent("Nameless_Framework:update")
AddEventHandler("Nameless_Framework:update", function(status)
    Citizen.Wait(1000)
    local playerInfo = exports["money_script"]:getMoney()
    SendNUIMessage({
        balance = "Account Balance: $" .. playerInfo.bank .. ".00",
    })
end)

RegisterNUICallback("closeUI", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)