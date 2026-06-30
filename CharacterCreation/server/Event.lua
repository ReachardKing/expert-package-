
-- server.lua

RegisterNetEvent("NamelessCore:fetchallcharacters", function()
    local src = source
    local characters = FetchCharactersFromDB(src)
    TriggerClientEvent("NamelessCore:returncharacters", src, characters)
end)
