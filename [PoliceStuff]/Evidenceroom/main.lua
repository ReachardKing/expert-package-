
--[[
    Citizen.CreateThread(function()
    WarMenu.CreateMenu("PE:main", "Personal Essentials")
    WarMenu.SetTitleBackgroundColor("PE:main", 85, 85, 85, 180)
    WarMenu.SetTitleColor("PE:main", 255, 255, 255, 255)

    WarMenu.CreateSubMenu("PE:Storage", "PE:main", "Personal Storage")
    WarMenu.CreateSubMenu("PE:Armory", "PE:main", "Personal Armory")
    WarMenu.CreateSubMenu("PE:Locker", "PE:main", "Personal Locker")
    WarMenu.CreateSubMenu("PE:Trash", "PE:main", "Trash")
end)

-- Main loop
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(15)
        local p = GetEntityCoords(PlayerPedId())
        for _, info in pairs(config.Personal) do 
			display = true
            local distance = #(p - info.loc)
            if distance <= config.setup.distance then   
                DrawText3Ds(info.loc.x, info.loc.y, info.loc.z, "[E] Open Personal Menu")
                
                if IsControlJustPressed(0, config.setup.key) then
                    WarMenu.OpenMenu("PE:main")
                end
            end
        end

        -- Handle menus
        if WarMenu.IsMenuOpened("PE:main") then
            if WarMenu.MenuButton("Personal check Evidence", "PE:checkEvidence") then
            elseif WarMenu.MenuButton("Evidence", "PE:Evidence") then
            elseif WarMenu.MenuButton("Locker", "PE:Locker") then
            elseif WarMenu.MenuButton("Trash", "PE:Trash") then
            end
            WarMenu.Display()
        
        elseif WarMenu.IsMenuOpened("PE:checkEvidence") then
            TriggerServerEvent("inventory:openStorage", {maxWeight = config.maxWeight, maxSpace = config.maxSpace})
            WarMenu.Display()
        
        elseif WarMenu.IsMenuOpened("PE:Evidence") then
            TriggerServerEvent("inventory:buyShopItem", {maxWeight = config.maxWeight, maxSpace = config.maxSpace})
            WarMenu.Display()
        
        elseif WarMenu.IsMenuOpened("PE:Locker") then
            TriggerServerEvent("inventory:openStorage", {maxWeight = config.maxWeight, maxSpace = config.maxSpace})
            WarMenu.Display()
        
        elseif WarMenu.IsMenuOpened("PE:Trash") then
            TriggerServerEvent("inventory:destroyPlayerItem", {maxWeight = config.maxWeight, maxSpace = config.maxSpace})
            WarMenu.Display()
        end
    end
end)
]]

RegisterNUICallback("CheckEvidence", function()
    SendNUIMessage({action = "CheckEvidence", nearModel = false})SetNuiFocus(false, false)
end)

RegisterNUICallback("Evidence", function()
    TriggerServerEvent("inventory:openStorage", -1, {maxWeight = config.maxWeight, maxSpace = config.maxSpace})
    SendNUIMessage({action = "Policebox", nearModel = false})SetNuiFocus(false, false)
end)

RegisterNUICallback("Evidencelocker", function()
    TriggerServerEvent("inventory:openStorage", -1, {maxWeight = config.maxWeight, maxSpace = config.maxSpace})
    SendNUIMessage({action = "Policebox", nearModel = false})SetNuiFocus(false, false)
end)

RegisterNUICallback("Deposcontent", function()
    TriggerServerEvent("inventory:destroyPlayerItem", {maxWeight = config.maxWeight, maxSpace = config.maxSpace})
    SendNUIMessage({action = "Policebox", nearModel = false})SetNuiFocus(false, false)
end)

RegisterNUICallback("close", function()
    SendNUIMessage({action = "Policebox", nearModel = false})SetNuiFocus(false, false)
	SendNUIMessage({action = "CheckEvidence", nearModel = false})SetNuiFocus(false, false)
end)

RegisterNUICallback("hide", function()
    SendNUIMessage({action = "Policebox", nearModel = false})SetNuiFocus(false, false)
	SendNUIMessage({action = "CheckEvidence", nearModel = false})SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    while true do Citizen.Wait(0)
        local p = GetEntityCoords(PlayerPedId())
        for _, info in pairs(config.Zones) do 
            local distance = Vdist2(info.loc.x, info.loc.y, info.loc.z, p.x, p.y,  p.z)
            if distance <= config.setup.distance then  
                DisplayHelpNotification(info.Type)
                if IsControlJustPressed(0, config.setup.key) and IsControlJustPressed(0, config.setup.key) then
                    SendNUIMessage({action = 'Policebox', nearModel = true}) SetNuiFocus(true, true)
                end
            end
        end
    end
end)

function loadAnimDict2(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function DisplayHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
   DrawNotification(true, false)
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do        
        Citizen.Wait(1)
    end
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

config = {}

config.setup = {
    distance = 1,
    key  = 38,
    keyname = "~INPUT_PICKUP~"
}

config.Zones = { -- the type has to match the type defined in config.Weapons
    { Type = "Evidence locker", loc = vector3(1849.15, 3695.38, 34.28)}, -- Sandy Shores
    { Type = "Evidence locker", loc = vector3( 1840.99, 3690.23, 34.28)}, -- Sandy Shores
    { Type = "Evidence locker", loc = vector3(452.47, -979.97, 30.69)}, -- MRPD Station
    { Type = "Evidence locker", loc = vector3(-450.14, 6016.27, 31.72)}, -- Paleto Station
	
	{Type = "recieve Evidence", loc = vector3(000.00, 000.00, 00.00)},
}

config.maxWeight = 600.0
config.maxSpace = 1250

RegisterKeyMapping("policeevidence", "Set up a key event for evidence", "keyboard", config.setup.key)