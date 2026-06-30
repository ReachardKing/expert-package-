
local nearModel = false

local atmModels = {
    "-870868698",  -- older atm's
    "-1126237515",  -- blue atm's
    "-1364697528",  -- red atm's
    "506770882",  -- green atm's
}

local days = {
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Staturday"
}

function GetTime()
    local hours = GetClockHours()
    local minuts = GetClockMinutes()

    if hours <= 9 then
        hours = "0".. hours
    end

    if minuts <= 9 then
        minuts = "0".. minuts
    end
    return hours.. ":" .. minuts
end

function SetAtmDispaly(bool)
	local playerinfo = exports["money_script"]:getMoney()

    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool and "ShowATM" or "HideATM",
        Playername = GetPlayerName(PlayerId()),
        balamcce = "Account blaance: $" .. playerinfo.bank .. "0",
        date = days[GetClockDayOfWeek() + 1],
        time = GetTime()
    })
end

RegisterNUICallback("useATM", function(data)
    local action string.gsub(data.action, "", "")
    if action == "WITHDRAW" then
        if data.ammount == "" then
            Citizen.Wait(1000)
            SendNUIMessage({
                success = false
            })
            return
        end
        TriggerServerEvent("Nameless_Framework:withdraw", data.ammount)
    elseif action == "DEPOSIT" then
        if data.ammount == "" then
            Citizen.Wait(1000)
            SendNUIMessage({
                success = false
            })
            return
        end
        TriggerServerEvent("Nameless_Framework:deposit", data.ammount)
    end
end)

function inrange(ped)
    coords = GetEntityCoords(PlayerPedId())
    for _, atm in pairs(atmModels) do
        object, outposition, outrotation = GetCoordsAndRotationOfClosestObjectOfType(coords.x, coords.y, coords.z, 0.7, tonumber(atm), 0)
        if object == 1 then
            return true
        end
    end
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(500)
        nearModel = inrange(PlayerPedId())
        if nearModel and IsControlJustPressed(0, 38) then
            SetAtmDispaly(true)
        end
    end
end)

RegisterNUICallback("close", function()
    SetAtmDispaly(false)
end)

RegisterNUICallback("sound", function()
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUND", true)
end)

RegisterCommand("ATM", function() SetAtmDispaly(true) end)
RegisterKeyMapping("ATM", "", "keyboard", "")