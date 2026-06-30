
local display = false
local nearmodel = false

config = {}

config.setup = {
    distance = 1,
    key = 51, -- E
    keyname = "~INPUT_PICKUP~"
}

config.maxWeight = 600.0
config.maxSpace = 1250

config.Personal = {
    { Type = "Personal locker", loc = vector3(461.39, -979.01, 30.69)}, -- Personal Locker at MRPD station
}

-- Create menus once
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
                DisplayHelpNotification(config.Personal.Type)
                DrawText3d(info.loc.x, info.loc.y, info.loc.z, "[E] Open Personal Menu")
                
                if IsControlJustPressed(0, config.setup.key) then
                    WarMenu.OpenMenu("PE:main")
                end
            end
        end

        -- Handle menus
        if WarMenu.IsMenuOpened("PE:main") then
            if WarMenu.MenuButton("Personal Storage", "PE:Storage") then
            elseif WarMenu.MenuButton("Armory", "PE:Armory") then
            elseif WarMenu.MenuButton("Locker", "PE:Locker") then
            elseif WarMenu.MenuButton("Trash", "PE:Trash") then
            end
            WarMenu.Display()
        
        elseif WarMenu.IsMenuOpened("PE:Storage") then
            TriggerServerEvent("inventory:openStorage", {maxWeight = config.maxWeight, maxSpace = config.maxSpace})
            WarMenu.Display()
        
        elseif WarMenu.IsMenuOpened("PE:Armory") then
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


--[[ 
   


    
]]
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

function DrawText3d(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 100)
        ClearDrawOrigin()
    end
end