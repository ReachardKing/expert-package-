
local characters = {}
local config = {
	characterLimit = 2500
}

RegisterNetEvent("NamelessCore:newcharacter", function(src, newcharacter)
	local count = 0
	
	local character = NamelessCore.FetchAllCharacters(src)
	
	for _, __ in pairs(character) do
		count =  count + 1
	end
	
	if count >= config.characterLimit then return end
	
	local player = NamelessCore.NewCharacter(src, {
		firstname = newcharacter.firstname,
		lastname = newcharacter.lastname,
		dob =  newcharacter.dob,
		gender = newcharacter.gender,
		ethnicity = newcharacter.ethnicity
	})
	return player
end)

RegisterNetEvent("NamelessCore:EditCharacter", function(src, newcharacter)
	local player = NamelessCore.FetchCharacters(newcharacter.id, src)
	
	
	player.SetData({
		firstname = newcharacter.firstname,
		lastname = newcharacter.lastname,
		dob =  newcharacter.dob,
		gender = newcharacter.gender,
		ethnicity = newcharacter.ethnicity
	})
	return player
end)

RegisterNetEvent("NamelessCore:SetActiveCharacters", function(player)

    if not player then print('could not set main character. Try again!') return end

    NamelessCore.SetActiveCharacter(player)
end)

AddEventHandler("NamelessCore:deleteCharacters", function(player, src, characterId)
	player = NamelessCore.FetchCharacters(characterId, src)
	
	return player.Delete()
end)

AddEventHandler("NamelessCore:fetchallcharacters", function(source)
	local characters = NamelessCore.FetchAllCharacters(source)
	
	return characters
end)