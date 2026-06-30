--================================--
--       POLICE TOOLS v1.1.7      --
--            by GIMI             --
--      License: GNU GPL 3.0      --
--================================--
local isOnDuty = false

RegisterNetEvent("policetools:dutyStatus")
AddEventHandler("policetools:dutyStatus", function(state, name)
    isOnDuty = state

    if isOnDuty then    
		TriggerEvent('police:updateBlips')
        -- e.g. exports['mythic_notify']:SendAlert('inform', 'You are now ON duty')
    else
        -- e.g. exports['mythic_notify']:SendAlert('inform', 'You are now OFF duty')
    end
end)

-- open locations
local GetAllClockonlocations = {
    {x = 1853.38, y = 3687.95, z = 34.27}, -- <-- Sandy Shores -->
    {x = -447.66, y = 6013.56, z = 31.72}, -- <-- Paleto Bay -->
    {x = 440.85, y = -981.11, z = 30.69}, -- <-- Mission Row --
	-- EMS_Places
	{x = -379.95, y = 6118.63, z = 31.85},
    {x = 1690.08, y = 3581.64, z = 35.62},
    {x = 356.9, y = -593.86, z = 28.7},
	
	-- Prison_Places
    {x = 1832.66, y = 2602.86, z = 45.89}, -- <-- Prison Front Gate --
    {x = 0.00, y = 0.00, z = 0.00},
    {x = 1902.38, y = 2606.42, z = 45.97}, -- <-- Prison other gate --
	
	-- PublicWorks
	{x = 915.36, y = -1514.49, z = 31.21}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)
        local nearClockIn = false

        for _, place in ipairs(GetAllClockonlocations) do
            local distance = #(playerCoords - vector3(place.x, place.y, place.z))

            if distance <= 2.0 then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to clock on/off duty")
                nearClockIn = true

                if IsControlJustPressed(0, 38) then -- E key
                    ExecuteCommand("clockon")
                end

                break
            end
        end
    end
end)


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--================================--
--          BLIP MANAGER          --
--================================--

UnitsRadar = {
    serverID = GetPlayerServerId(PlayerId()),
    sentCallsign = false,
    active = {},
    distant = {},
    _panic = {},
	__index = self
}

function UnitsRadar:updateAll(activeBlips)
    if not self.sentCallsign then
        self.sentCallsign = true
        self:sendCallsign()
    end

    activeBlips[self.serverID] = nil

    for k, v in pairs(activeBlips) do
        self:update(k, v.coords.x, v.coords.y, v.coords.z, v.heading, v.type, v.number)
    end
end

function UnitsRadar:update(playerID, x, y, z, heading, type, number)
    local color = Config.UnitsRadar.colors[type] or Config.UnitsRadar.colors[1]
    local player = nil

    if Config.UnitsRadar.usePlayerBlips then
        player = GetPlayerFromServerId(playerID)
        local wasDistant = self.distant[playerID]
        self.distant[playerID] = (player == -1)
        if (wasDistant and not self.distant[playerID]) or (not wasDistant and self.distant[playerID]) then
            self:remove(playerID, false) -- The player's gotten into your scope / outside your scope -> remove the existing blip, it'll be re-created below with the new parameters
        end
    end

    if self.active[playerID] == nil then
        self.active[playerID] = self.distant[playerID] and AddBlipForCoord(x, y, z) or AddBlipForEntity(GetPlayerPed(player))
        SetBlipScale(self.active[playerID], 1.2)
        SetBlipSprite(self.active[playerID], 1)
        SetBlipCategory(self.active[playerID], 1)
        SetBlipHiddenOnLegend(self.active[playerID], true)
        SetBlipShrink(self.active[playerID], true)
        SetBlipPriority(self.active[playerID], 10)
        ShowHeightOnBlip(self.active[playerID], false)
        if heading then
            ShowHeadingIndicatorOnBlip(self.active[playerID], true)
            SetBlipRotation(self.active[playerID], heading)
        end
    elseif self.distant[playerID] then
        SetBlipCoords(self.active[playerID], x, y, z)
        if heading then
            SetBlipRotation(self.active[playerID], heading)
        end
    end

    if number then
        ShowNumberOnBlip(self.active[playerID], number)
    end

    SetBlipColour(self.active[playerID], color)
end

function UnitsRadar:remove(playerID, removeDistant)
    if self.active[playerID] then
        RemoveBlip(self.active[playerID])
        self.active[playerID] = nil
        if removeDistant ~= false then
            self.distant[playerID] = nil
        end
    end
end

function UnitsRadar:removeAll()
    self.sentCallsign = false
    for k, v in pairs(self.active) do
        self:remove(k)
    end
end

function UnitsRadar:setCallsign(callsign)
    callsign = tostring(callsign)

    if callsign and tonumber(callsign) then
        -- valid numeric callsign
        TriggerServerEvent('police:setUnitCallsign', callsign)
        SetResourceKvp("callsign", callsign)
    else
        -- invalid input (not a number)
        TriggerEvent('chat:addMessage', {
            args = { '^1SYSTEM', '❌ Invalid callsign. Please use numbers only (e.g. 12).' }
        })
        return
    end

    -- Update config table with the callsign
    local serverID = GetPlayerServerId(PlayerId())
    Config.UnitsRadar.callsigns[serverID] = callsign

    print("Updated callsign:", Config.UnitsRadar.callsigns[serverID])

    -- Update plate if in a police vehicle
	SetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(),false), callsign)
end


function UnitsRadar:sendCallsign()
    local callsign = GetResourceKvpString("callsign")
    if callsign then
        UnitsRadar:setCallsign(callsign)
    end
end

function UnitsRadar:panic(playerID)
    if self.active[playerID] then
        ClearGpsMultiRoute()
        self._panic[playerID] = true
        SetBlipFlashes(self.active[playerID], true)
        SetBlipFlashInterval(self.active[playerID], 500)
        StartGpsMultiRoute(Config.UnitsRadar.panicColor, true, true)
        AddPointToGpsMultiRoute(GetBlipCoords(self.active[playerID]))
        SetGpsMultiRouteRender(true)
    end
end

function UnitsRadar:clearPanic(playerID)
    playerID = tonumber(playerID)
    if playerID then
        if self._panic[playerID] and self.active[playerID] then
            SetBlipFlashes(self.active[playerID], false)
        end
    else
        for k, v in pairs(self._panic) do
            if self.active[k] then
                SetBlipFlashes(self.active[k], false)
            end
        end
    end
    ClearGpsMultiRoute()
end

--================================--
--            COMMANDS            --
--================================--

RegisterCommand(
    'callsign',
    function(source, args, rawCommand)
        local callsign = tostring(args[1])
        UnitsRadar:setCallsign(callsign)
    end,
    false
)

RegisterCommand(
    'cs',
    function(source, args, rawCommand)
        local callsign = tostring(args[1])
        UnitsRadar:setCallsign(callsign)
    end,
    false
)

RegisterCommand(
    'clearpanic',
    function(source, args, rawCommands)
        local panicID = tonumber(args[1])
        panicID = panicID or nil
        UnitsRadar:clearPanic(panicID)
    end,
    false
)

RegisterCommand(
    'cp',
    function(source, args, rawCommands)
        local panicID = tonumber(args[1])
        panicID = panicID or nil
        UnitsRadar:clearPanic(panicID)
    end,
    false
)

RegisterCommand(
	'policeblip',
	function(source, args, rawCommand)
		local _source = source
		local action = args[1]
		local serverId = tonumber(args[2])

		if not action then
			return
		end

        if action == "add" or action == "remove" or action == "hide" or action == "show" then
            if not serverId or serverId < 1 then
                return
            end

            local identifier = GetPlayerIdentifier(serverId, 0)

            if not identifier then
                sendMessage(source, "Player not on duty.")
                return
            end

            serverId = (serverId and serverId > 0) and serverId or source
        end

        if action == "add" then
            local type = tonumber(args[3]) or 1
			UnitsRadar:addUnit(serverId, type)
			sendMessage(source, ("Subscribed %s to police radar."):format(GetPlayerName(serverId)))
        elseif action == "remove" then
            UnitsRadar:removeUnit(serverId)
            sendMessage(source, ("Unsubscribed %s from police radar."):format(GetPlayerName(serverId)))
        elseif action == "hide" then
            UnitsRadar:hideUnit(serverId)
			sendMessage(source, ("Hidden %s on the police radar."):format(serverId == source and "yourself" or GetPlayerName(serverId)))
        elseif action == "show" then
            UnitsRadar:showUnit(serverId)
			sendMessage(source, ("Shown %s on the police radar."):format(serverId == source and "yourself" or GetPlayerName(serverId)))
        elseif action == "off" then
            UnitsRadar:hide()
        elseif action == "on" then
            UnitsRadar:updateBlips()
        else
			sendMessage(source, "Invalid action.")
		end
	end,
	true
)

TriggerEvent("chat:addSuggestion", "policeblip",  "Enable  policeblip",  {
	{
	
		name = "Add, remove,  hide, show, off, on",
		help =  "simple units commands to toggle policeblip"
	}
})

TriggerEvent('chat:addSuggestion', '/callsign', 'Changes your callsign shown on the map', {
	{
		name = "callsign",
		help = "Your callsign  numbers only"
	}
})

TriggerEvent('chat:addSuggestion', '/cs', 'Changes your callsign shown on the map', {
	{
		name = "callsign",
		help = "Your callsign numbers soon tm"
	}
})

if Config.UnitsRadar.panicColor then
    TriggerEvent('chat:addSuggestion', '/panic', 'Triggers the panic button')

    TriggerEvent('chat:addSuggestion', '/clearpanic', 'Clears the panicked units from the map', {
        {
            name = "panicID",
            help = "Specify the panic ID if you only want to remove specific panic from the map"
        }
    })

    TriggerEvent('chat:addSuggestion', '/cp', 'Clears the panicked units from the map', {
        {
            name = "panicID",
            help = "Specify the panic ID if you only want to remove specific panic from the map"
        }
    })
	
	TriggerEvent('chat:addSuggestion', '/clockon', 'clockon on duty ', {
		{
			name = "clockon",
			help = "clockons on / off duty"
		}
	})
end

--================================--
--             BIGMAP             --
--================================--

if Config.UnitsRadar.bigmapKey then
    RegisterCommand(
        '+bigmap',
        function()
            SetBigmapActive(true, false)
        end,
        false
    )

    RegisterCommand(
        '-bigmap',
        function()
            SetBigmapActive(false, false)
        end,
        false
    )

    Config.UnitsRadar.bigmapKey = Config.UnitsRadar.bigmapKey == true and nil or Config.UnitsRadar.bigmapKey
    RegisterKeyMapping('+bigmap', 'Expand / shrink minimap', 'keyboard', Config.UnitsRadar.bigmapKey)
end

RegisterCommand("livery", function(source, args, callsign)
    if callsign[1] then
        local livery = tonumber(args[1])
        SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), false), livery)
    end
end, false)

--================================--
--              SYNC              --
--================================--

RegisterNetEvent('police:removeUnit')
AddEventHandler(
    'police:removeUnit',
    function(playerID, unsubscribe)
        UnitsRadar:remove(playerID)
    end
)

RegisterNetEvent('police:removeBlips')
AddEventHandler(
    'police:removeBlips',
    function()
        UnitsRadar:removeAll()
    end
)

RegisterNetEvent('police:updateBlips')
AddEventHandler(
    'police:updateBlips',
    function(blips)
        UnitsRadar:updateAll(blips)
    end
)

RegisterNetEvent('police:requestUnitInfo')
AddEventHandler(
    'police:requestUnitInfo',
    function()
        UnitsRadar:sendCallsign()
    end
)

if Config.UnitsRadar.panicColor then
    RegisterNetEvent('police:panic')
    AddEventHandler(
        'police:panic',
        function(playerID)
            UnitsRadar:panic(playerID)
        end
    )
end

--================================--
--            CLEAN-UP            --
--================================--

RegisterNetEvent('onResourceStart')
AddEventHandler(
    'onResourceStart',
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            ClearGpsMultiRoute()
        end
    end
)