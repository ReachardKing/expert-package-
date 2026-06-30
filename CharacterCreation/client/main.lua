
local firstTime, characters, playersById, players = true, {}, {}, {}

AddEventHandler('onClientResourceStart', function (resourceName)
  if(GetCurrentResourceName() ~= resourceName) then
    return
  end
  PreparePlayerPed(false)
end)
 
-- FIB ROOF TOP LOCATION -144.67, -593.61, 210.78

AddEventHandler("playerSpawned", function()
    PreparePlayerPed(false)
end)

RegisterCommand("logout", function()
    ShowDisplay(true)
end, false)

local config = {
    characterLimit = 2500
}

function ShowDisplay(bool, chars)
	local characterAmount = chars or characters
	if not characterAmount then characterAmount = {} end
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "Setchars",
        status = bool,
        servername = "The Nameless",
        characterAmount = ("%d/%d"):format(tablelength(characterAmount), config.characterLimit),
        firstTime = firstTime
    })
   
end

TriggerServerEvent("NamelessCore:fetchallcharacters")
RegisterNetEvent('NamelessCore:returncharacters', function(chars)
	SendNUIMessage({
        type = "refresh",
        characters = json.encode(characters)
    })  
end)
    
function PreparePlayerPed(ped)
	SwitchOutPlayer(0, 1, 1)
	
	while GetPlayerSwitchState() ~= 5 do 
		Citizen.Wait(0)
	end
	
	FreezeEntityPosition(ped, true)
	SetEntityVisible(ped, false, false)
	
	ShowDisplay(true)
		SendNUIMessage({
        type = "refresh",
        characters = json.encode(characters)
    })
	TriggerServerEvent("NamelessCore:fetchallcharacters")
end

function tablelength(tbl)
    local count = 0
    for _, ignore in pairs(tbl) do 
        count = count + 1
    end
    return count
end

function Spawnsort(chars, id)
    local player = chars[id]

    if not player then return end

	local defualtSpawn = config.spawns["Defaults"] or config.spawns["defaults"]
    local spawns = {}

    for _, spawn in pairs(defualtSpawn) do
        spawns[#spawns + 1] = spawn
    end

    local job = ValidateJob()
    if not job then return spawns end

    local jobspawns = {}

    for k, v in pairs(config.spawns) do
        if k:lower() == job:lower() then
            jobspawns = v
            break
        end
    end

    for _, newSpawn in pairs(jobspawns) do
        spawns[#spawns + 1] = newSpawn
    end
    return spawns
end

function ValidateJob(source, job)

	if not job then return end

	local jobExist = config.permissions[string.upper(job)]
	if not jobExist then return end

	local info = GetPlayersServerInfo(source)
	if not info then return end

	local roles = exports.snipe-queue:getUserRoles(source)
	if not roles then return end
	for _, roleId in pairs(jobExist) do
		if table.contains(roles, tostring(roleId)) then
			return true
		end
	end
	return false
end

RegisterNUICallback("close", function()
   ShowDisplay(false)
   SetNuiFocus(false, false)
end)

RegisterNUICallback("close", function()
    ShowDisplay(false)
	SetNuiFocus(false, false)
end)

RegisterNUICallback("setMainCharacter", function(data)
	local id = tonumber(data.id)
	local spawns = Spawnsort(characters, id)
	
	if not spawns then return end
	
	SendNUIMessage({
		type = "setSpawns", 
		spawn = json.encode(spawns),
		id = id
	})
	
	SetEntityVisible(ped, true, false)
	FreezeEntityPosition(ped, false)
	SwitchInPlayer(ped)

end)

RegisterNUICallback("newCharacter", function(data)
	if tablelength(characters) > config.characterLimit then return end
	
	TriggerServerEvent("NamelessCore:newcharacter", function(player)
		if not player then
			print('character unsuccessful')
		end
		character[player.id] = player
		
		SendNUIMessage({
			type ="refresh",
			characters = json.encode(characters),
			characterAmount = ("%d/%d"):format(tablelength(characterAmount), config.characterLimit)
		})
	end, {
		firstname = data.firstname,
		lastname = data.lastname,
		dob = data.dob,
		ethnicity = data.ethnicity
	})
end)

RegisterNUICallback("editCharacter", function(data)
	TriggerServerEvent("NamelessCore:EditCharacter", function(player)
		if not player then
			print('character unsuccessful')
		end
		character[player.id] = player
		
		SendNUIMessage({
			type ="refresh",
			character = json.encode(characters),
			characterAmount = ("%d/%d"):format(tablelength(characterAmount), config.characterLimit)
		})
	end, {
		firstname = data.firstname,
		lastname = data.lastname,
		dob = data.dob,
		ethnicity = data.ethnicity
	})
end)

RegisterNUICallback("delCharacter", function()
	TriggerServerEvent("NamelessCore:deleteCharacters", function(success)
		if not success then
			print('character unsuccessful')
		end
		character[player.characters] = nil
		
		SendNUIMessage({
			type ="refresh",
			character = json.encode(characters),
			characterAmount = ("%d/%d"):format(tablelength(characterAmount), config.characterLimit)
		})
	end, data.characters)
end)

-- client.lua
RegisterNUICallback("exitGame", function(cb)

    AddEventHandler('playerDropped', function()
        local player = playersById[tostring(source)]
        if player then
            playersById[tostring(player.id)] = nil
        end
        players[tostring(source)] = nil
    end)
end)

RegisterNUICallback("tpToLocation", function(data, ped)
    local character = characters[data.id]
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, tonumber(data.x), tonumber(data.y), tonumber(data.z), false, false, false, false)
    SwitchInPlayer(ped)

    Citizen.Wait(500)
    ShowDisplay(false)
    while not HasCollisionLoadedAroundEntity(ped) do
        Citizen.Wait(0)
    end
    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true, 0)
    TriggerServerEvent("NamelessCore:select", data.id)

    SetTimeout(10000, function()
        if firstSpawn then
            firstSpawn = false
            SendNUIMessage({
                type = "firstSpawn"   
            })
        end
    end)
end)

RegisterNUICallback("tpDoNot", function(data)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    local character = characters[data.id]
    if firstSpawn then
        local data = character and character.metadata
        if data and data.location then
            SetEntityCoords(ped, data.location.x, data.location.y, data.location.z)
            if data.location.w then
                SetEntityHeading(ped, data.location.w)
            end
        end
        SetTimeout(1000, function()
            firstSpawn = false
            SendNUIMessage({
                type = "firstSpawn"
            })
        end)
    end
    SwitchInPlayer(ped)
    Wait(500)
    ShowDisplay(false)
    Wait(500)
    while not HasCollisionLoadedAroundEntity(ped) do
        Wait(100)
    end
    SetEntityVisible(ped, true, 0)
    FreezeEntityPosition(ped, false)
    Wait(100)
    setCharacterClothes(character)
    TriggerServerEvent("NamelessCore:select", data.id)
end)

RegisterNUICallback("close", function()
    ShowDisplay(false)
end)

RegisterCommand("CharacterCreation", function(source, args, raw)
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    PreparePlayerPed(true)
end, false)


function tablelength(tbl)
    local count = 0
    for i in ipairs(tbl) do
        count = count + 1
    end
    return count
end

AddEventHandler("CharacterCreation:newCharacter", function(player)

	if not player then print('creating a new character was unsuccessful') return end

	characters[player.id] = player
    
	SendNUIMessage({
        type = "refresh",
        characters = json.encode(characters),
        characterAmount = ("%d/%d"):format(tablelength(characters), config.characterLimit)
    })
end)

AddEventHandler("CharacterCreation:EditCharacter", function(player)
    if not player then print('Editing character was unsuccessful') return end

    characters[player.id] = player
    
    SendNUIMessage({
        type = "refresh",
        characters = json.encode(characters),
        characterAmount = ("%d/%d"):format(tablelength(characters), config.characterLimit)
    })
end)

exports("PreparePlayerPed", PreparePlayerPed)