
config = {}

config.setup = {
    distance = 2.5,
    key = 38,
}

config.Zones = { -- the type has to match the type defined in config.Weapons
    --{ Type = "Changing room", loc = vector3(454.07, -980.03, 30.69), h = 89.46 }, -- Example
    { Type = "Changing room", loc = vector3(1862.1, 3688.73, 34.28)}, -- Sandy Shores
    { Type = "Changing room", loc = vector3(454.39, -991.07, 30.69)}, -- MRPD Station
    { Type = "Changing room", loc = vector3(-448.31, 6007.89, 31.72)}, -- Paleto Station
    { Type = "Changing room", loc = vector3(834.67, -1295.02, 28.35)}, -- La Mesa
    { Type = "Changing room", loc = vector3(-1096.83, -843.06, 19.31)}, -- Vespucci

    -- EMS

    -- Everyone else for Civlians
    {Type = "Changing room", loc = vector3( 72.3,  -1399.1,  28.4) }, -- Strawberry
    {Type = "Changing room", loc = vector3( -703.8, -152.3, 36.4) }, -- Rockford Hills
    {Type = "Changing room", loc = vector3( -167.9, -299.0, 38.7) }, -- Burton
    {Type = "Changing room", loc = vector3( 428.7, -800.1, 28.5 )},-- Textile city
    {Type = "Changing room", loc = vector3( -829.4, -1073.7, 10.3) }, -- Vespucci canals / palomino
    -- {Type = "Changing room", loc = vector3( -1447.8, -242.5, 48.8)}, 
    {Type = "Changing room", loc = vector3( 11.6, 6514.2, 30.9 )},  -- Paleto Bay
    {Type = "Changing room", loc = vector3( 123.6, -219.4, 53.6) }, -- Alta street
    {Type = "Changing room", loc = vector3( 1696.3, 4829.3, 41.1) }, -- Grapeseed
    {Type = "Changing room", loc = vector3( 618.1, 2759.6, 41.1 )}, -- Harmony
    {Type = "Changing room", loc = vector3( 1190.6, 2713.4, 37.2) }, -- Grand Senora Desert
    {Type = "Changing room", loc = vector3( -1193.4, -772.3, 16.3) }, -- Del Perro Beach
    {Type = "Changing room", loc = vector3( -3172.5, 1048.1, 19.9 )}, -- Chumash
    {Type = "Changing room", loc = vector3( -1108.4, 2708.9, 18.1 )}, -- Zancudo River
    {Type = "Changing room", loc = vector3( -1338.1, -1278.2, 3.8 )}, -- San Andreas Ave / vitus street
    {Type = "Changing room", loc = vector3( -1633.01, -1100.84, 13.02)}, --- Pacific Ocean / Del Perro
    {Type = "Changing room", loc = vector3(  -1124.13, -1442.92, 5.22)}, -- La puerta / City ave
}

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(500)

        local p = GetEntityCoords(PlayerPedId())

        local inZone = false
        local zoneType = nil
        for _, info in ipairs(config.Zones) do 
            local distance = #(p - info.loc)  -- MUCH cleaner
            if distance <= config.setup.distance then
                inZone = true
                zoneType = info.Type
                -- Only show help when inside the zone
                DisplayHelpNotification("~INPUT_PICKUP~" .. " to open " .. info.Type)
                break
            end
            -- Only open if the player is inside any zone
            if inZone and IsControlJustPressed(0, config.setup.key) then
                Changingroom(true)
            end
        end
    end
end)

function Changingroom(bool)
    SetCursorLocation(0.917, 0.873)
    SetNuiFocus(bool, bool)
	SendNUIMessage({
		type = 'HUD', 
		visible = bool
	})
end

function DisplayHelpNotification(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

RegisterCommand("Changingroom", function() Changingroom(true) end)
RegisterKeyMapping("Changingroom", "", "keyboard", "")