
Config.DefaultAlertsDelay = 5 -- Delay between each default alert, prevent spamming

local timer = {}

-- Ensure GetPedInVehicleSeat is defined or imported
function GetPlayerSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false) -- false = don't get last vehicle
    if vehicle == 0 then return nil end

    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)

    -- Loop through all possible seats, including driver seat (-1)
    for i = -1, maxSeats - 1 do
        if GetPedInVehicleSeat(vehicle, i) == ped then
            return i -- This is the seat the player is in
        end
    end

    return nil -- Not found
end


function WaitTimer(name, action, ...)
    if type(Config) ~= "table" or type(Config.DefaultAlerts) ~= "table" or not Config.DefaultAlerts[name] then return end

    if not timer[name] then
        timer[name] = true
        action(...)
        Wait(Config.DefaultAlertsDelay * 1000)
        timer[name] = false
    end
end

function isPedAWitness(witnesses, ped)
    for _, v in pairs(witnesses or {}) do
        if v == ped then return true end
    end
    return false
end

local function BlacklistedWeapon(ped)
    if type(Config) ~= "table" or type(Config.WeaponWhitelist) ~= "table" then
        return false
    end

    local weaponHashes = {}
    for i = 1, #Config.WeaponWhitelist do
        weaponHashes[i] = joaat(Config.WeaponWhitelist[i])
    end

    for i = 1, #weaponHashes do
        if GetSelectedPedWeapon(ped) == weaponHashes[i] then
            return true
        end
    end

    return false
end

AddEventHandler('CEventGunShot', function(witnesses, ped, department)
    if not witnesses or not witnesses[1] then return end
    if IsPedCurrentWeaponSilenced(ped) then return end
    if BlacklistedWeapon(ped) then return end

    WaitTimer('Shooting', function(inHuntingZone)
        if not witnesses or witnesses[1] ~= ped then return end

        if exports["characterjobs"]:GetOnDutyJobData(department) and not Config.Debug then
            return
        end

        if inHuntingZone then
            exports['DispatchSystem']:Hunting()
            return
        end

        if witnesses and not isPedAWitness(witnesses, ped) then return end

        exports['DispatchSystem']:IsPedShoting()
    end)
end)

AddEventHandler('CEventShockingSeenMeleeAction', function(witnesses, ped)
    WaitTimer('Melee', function(cache)
        if witnesses and not isPedAWitness(witnesses, ped) then return end
        if not IsPedInMeleeCombat(ped) then return end

        exports['DispatchSystem']:FightInProgress()
    end)
end)

AddEventHandler('CEventPedJackingMyVehicle', function(_, ped)
    WaitTimer('Autotheft', function(cache)
        local vehicle = GetVehiclePedIsUsing(ped, true)
        exports['DispatchSystem']:CarJacking(vehicle)
    end)
end)

AddEventHandler('CEventShockingCarAlarm', function(_, ped)
    WaitTimer('Autotheft', function(cache)
        local vehicle = GetVehiclePedIsUsing(ped, true)
        exports['DispatchSystem']:StolenVehicle(vehicle)
    end)
end)

AddEventHandler('CEventExplosionHeard', function(witnesses, ped)
    if witnesses and not isPedAWitness(witnesses, ped) then return end
    WaitTimer('Explosion', function()
        exports['DispatchSystem']:Explosion()
    end)
end)

AddEventHandler('gameEventTriggered', function(name, args, number)
    if name ~= 'CEventNetworkEntityDamage' then return end
    local victim = args[1]
    local isDead = args[6] == 1

    WaitTimer('PlayerDowned', function(ped)
        if not ped ~= victim then return end
        if not isDead then return end

        if exports["characterjobs"]:GetTotalEmployees(number) then
            exports['DispatchSystem']:Officerdowned()
            exports['DispatchSystem']:EMSDown()
        else
            exports['DispatchSystem']:InjuriedPerson()
        end
    end)
end)

-- Speeding event listeners
local SpeedingEvents = {
    'CEventShockingCarChase',
    'CEventShockingDrivingOnPavement',
    'CEventShockingBicycleOnPavement',
    'CEventShockingMadDriverBicycle',
    'CEventShockingMadDriverExtreme',
    'CEventShockingEngineRevved',
}

for _, event in ipairs(SpeedingEvents) do
    AddEventHandler(event, function(_, ped, number, cache, vehicle)
        WaitTimer('Speeding', function()
            if not cache or cache ~= ped then return end

            local currentTime = GetGameTimer()
            if currentTime - SpeedTrigger < 10000 then return end

            if exports["characterjobs"]:GetTotalEmployees(number) and not Config.Debug then
                if not vehicle or GetEntitySpeed(vehicle) * 3.6 < (80 + math.random(0, 30)) then return end
                if GetPlayerSeat() then return end

                exports['DispatchSystem']:SpeedingVehicle({ vehicle = vehicle })
                SpeedTrigger = GetGameTimer()
            end
        end)
    end)
end

-- Robbery event dispatch (uses dynamic dispatching based on event name)
local robberyEvents = {
    "prisonbreak",
    "StoreRobbery",
    "FleecaBankRobbery",
    "PaletoBankRobbery",
    "pacificbankrobbery",
    "VangelicoRobbery",
    "HouseRobbery"
}

for _, event in ipairs(robberyEvents) do
    AddEventHandler(event, function(_, ped, department, witnesses, number)
        WaitTimer("Robbing", function(cache)
            if not cache or cache ~= ped then return end
            if witnesses and not isPedAWitness(witnesses, ped) then return end

			if exports["characterjobs"]:GetTotalEmployees(number) then
				if exports["DispatchSystem"][event] then
					exports["DispatchSystem"][event]()
				end
			end
        end)
    end)
end
