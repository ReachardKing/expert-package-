RegisterCommand("police_mechanic", function()
    TriggerEvent("Repair:mech")
end, false)

RegisterNetEvent("Repair:mech")
AddEventHandler("Repair:mech", function()
    player = PlayerPedId()
    playerPos = GetEntityCoords(player)
    
    local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0)
    
    local targetVeh = GetTargetVehicle(player, inFrontOfPlayer)
    
    GetMechPed()
    
    local driverhash = GetHashKey(mechPedPick.model)
    RequestModel(driverhash)
    local vehhash = GetHashKey(mechPedPick.vehicle)
    RequestModel(vehhash)
    
    loadAnimDict("cellphone@")
    
    while not HasModelLoaded(driverhash) and RequestModel(driverhash) or not HasModelLoaded(vehhash) and RequestModel(vehhash) do
        RequestModel(driverhash)
        RequestModel(vehhash)
        Citizen.Wait(0)
    end
    
    if DoesEntityExist(targetVeh) then
        if DoesEntityExist(mechVeh) then
            DeleteVeh(mechVeh, mechPed)
            SpawnVehicle(playerPos.x, playerPos.y, playerPos.x, vehhash, driverhash)
        else
            SpawnVehicle(playerPos.x, playerPos.y, playerPos.x, vehhash, driverhash)
        end
        playRadioAnim(player)
        GoToTarget(GetEntityCoords(targetVeh).x, GetEntityCoords(targetVeh).y, GetEntityCoords(targetVeh).z, mechVeh, mechPed, vehhash, targetVeh)
    end
end)

function SpawnVehicle(x, y, z, vehhash, driverhash)--Spawning Function
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(x + math.random(-spawnRadius, spawnRadius), y + math.random(-spawnRadius, spawnRadius), z, 0, 3, 0)
    
    if found and HasModelLoaded(vehhash) and HasModelLoaded(vehhash) then
        mechVeh = CreateVehicle(vehhash, spawnPos, spawnHeading, true, false)--Car Spawning.
        ClearAreaOfVehicles(GetEntityCoords(mechVeh), 5000, false, false, false, false, false);
        SetVehicleOnGroundProperly(mechVeh)
        SetVehicleColours(mechVeh, mechPedPick.colour, mechPedPick.colour)
        
        mechPed = CreatePedInsideVehicle(mechVeh, 26, driverhash, -1, true, false)--Driver Spawning.
        
        mechBlip = AddBlipForEntity(mechVeh)--Blip Spawning.
        SetBlipFlashes(mechBlip, true)
        SetBlipColour(mechBlip, 5)
    end
end

function DeleteVeh(vehicle, driver)
    SetEntityAsMissionEntity(vehicle, false, false)--Car Removal
    DeleteEntity(vehicle)
    SetEntityAsMissionEntity(driver, false, false)--Driver Removal
    DeleteEntity(driver)
    RemoveBlip(mechBlip)--Blip Removal
end

function GoToTarget(x, y, z, vehicle, driver, vehhash, target)
    TaskVehicleDriveToCoord(driver, vehicle, x, y, z, 17.0, 0, vehhash, drivingStyle, 1, true)
    ShowAdvancedNotification(companyIcon, companyName, "Mechanic Dispatched", "A mechanic has been dispatched to your location. Thanks for using ~y~" .. companyName)
    enroute = true
    while enroute do
        Citizen.Wait(500)
        distanceToTarget = GetDistanceBetweenCoords(GetEntityCoords(target), GetEntityCoords(vehicle).x, GetEntityCoords(vehicle).y, GetEntityCoords(vehicle).z, true)
        if simplerRepair then
            if distanceToTarget < 20 then
                TaskVehicleTempAction(driver, vehicle, 27, 6000)
                Citizen.Wait(3000)
                RepairVehicle(target, vehicle, driver)
            end
        else
            if distanceToTarget < 20 then
                TaskVehicleTempAction(driver, vehicle, 27, 6000)
                SetVehicleUndriveable(vehicle, true)
                GoToTargetWalking(target, vehicle, driver)
            end
        end
    end
end

function GoToTargetWalking(target, vehicle, driver)
    while enroute do
        Citizen.Wait(500)
        engine = GetWorldPositionOfEntityBone(target, GetEntityBoneIndexByName(target, "engine"))
        TaskGoToCoordAnyMeans(driver, engine, 2.0, 0, 0, 786603, 0xbf800000)
        distanceToTarget = GetDistanceBetweenCoords(engine, GetEntityCoords(driver).x, GetEntityCoords(driver).y, GetEntityCoords(driver).z, true)
        norunrange = false
        if distanceToTarget <= 10 and not norunrange then -- stops ai from sprinting when close
            TaskGoToCoordAnyMeans(driver, engine, 1.0, 0, 0, 786603, 0xbf800000)
            norunrange = true
        end
        if distanceToTarget <= 2 then
            SetVehicleUndriveable(target, true)
            TaskTurnPedToFaceCoord(driver, GetEntityCoords(target), -1)
            Citizen.Wait(1000)
            TaskStartScenarioInPlace(driver, "PROP_HUMAN_BUM_BIN", 0, 1)
            SetVehicleDoorOpen(target, 4, false, false)
            Citizen.Wait(10000)
            ClearPedTasks(driver)
            RepairVehicle(target, vehicle, driver)
        end
    
    end
end

function RepairVehicle(target, vehicle, driver)
    enroute = false
    norunrange = false
    FreezeEntityPosition(driver, false)
    SetVehicleDoorShut(target, 4, false, false)
    Citizen.Wait(500)
    ShowAdvancedNotification(mechPedPick.icon, mechPedPick.name, "Vehicle Repaired", mechPedPick.lines[math.random(#mechPedPick.lines)])
    if repairComsticDamage then
        SetVehicleFixed(target)
    else
        SetVehicleEngineHealth(target, 1000.0)
    end
    if flipVehicle then
        SetVehicleOnGroundProperly(target)
    end
    SetVehicleUndriveable(target, false)
    Citizen.Wait(5000)
    LeaveTarget(vehicle, driver)
end

function LeaveTarget(vehicle, driver)
    TaskVehicleDriveWander(driver, vehicle, 17.0, drivingStyle)
    SetEntityAsNoLongerNeeded(vehicle)
    SetPedAsNoLongerNeeded(driver)
    RemoveBlip(mechBlip)
    mechVeh = nil
    mechPed = nil
    targetVeh = nil
end

function GetTargetVehicle(player, dir)
    if IsPedSittingInAnyVehicle(player) then
        dmgVeh = GetVehiclePedIsIn(player, false)
    else
        dmgVeh = GetVehicleInDirection(GetEntityCoords(player), dir)
    end
    
    if DoesEntityExist(dmgVeh) then
        return dmgVeh
    else
        ShowNotification("Failed to find a vehicle.")
    end
end

function GetMechPed()
    mechPedPick = mechPeds[math.random(#mechPeds)]
end

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function playRadioAnim(player)
    Citizen.CreateThread(function()
        RequestAnimDict(arrests)
        TaskPlayAnim(player, "cellphone@", "cellphone_call_in", 1.5, 2.0, -1, 50, 2.0, 0, 0, 0)
        Citizen.Wait(6000)
        ClearPedTasks(player)
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function ShowAdvancedNotification(icon, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- C o n f i g s --
companyName = "DVTowing"
companyIcon = "CHAR_PROPERTY_TOWING_IMPOUND" -- https://wiki.gtanet.work/index.php?title=Notification_Pictures

spawnRadius = 50 -- Default value: 500

drivingStyle = 786603 -- Change the driving behaviour of the truck: https://vespura.com/drivingstyle/

-- To change the chat command (def. /tow), see line 1 of client.lua
-- You can add more vehicle models to the two existing categories.
towTruckModels = {
        
        ['emergency'] = {
            model = 'Police', -- Change the model here (https://wiki.gtanet.work/index.php?title=Vehicle_Models)
            ['offset'] = {['x'] = -0.5, ['y'] = -5.0, ['z'] = 1.0}, }, -- Edit the offset of where the vehicle gets attached
        
        
        ['emergency'] = {
            model = 'police3',
            ['offset'] = {['x'] = 0.5, ['y'] = 2.0, ['z'] = 1.0}, },
}


-- Edit / Add Drivers and their information here!
towTruckDrivers = {
        
        [1] = {name = "Driver Bob", icon = "CHAR_MP_ARMY_CONTACT", ped = "S_M_M_TRUCKER_01", colour = 88,
            [1] = {"I wont charge you a arm and a leg! ~n~ I only want your tows.",
                "Howdy partner! I'll get it towed!",
                "You called the right guy, ~n~ because I got puns from head to tow.",
                "Tow'nt worry about it, ~n~ I'll get it towed!",
                "Do you even lift bro? ~n~ Because I do!",
                "You want too hook up ~n~ some time?",
                "Sorry I took so long!",
                "We have some of the best ~n~ hookers in town!",
                "There ya go!",
                "Bob's here to the rescue!",
                "That will look good in the impound!",
                "No worries, I've got this!",
                "Can't wait to see my wife and kids...",
                "I love my job!",
                "I'll be taking that...",
                "Good Morning! What do we have here?",
                "You're coming with me!", }},
        
        [2] = {name = "Driver Joe", icon = "CHAR_JOE", ped = "MP_M_WAREMECH_01", colour = 27,
            [1] = {"Fuck you.",
                "I hate my job.",
                "You could've at least sent me a good looking one...",
                "I'll take it from here.",
                "What do we have here...",
                "I've got it.",
                "It will be at the compound.",
                "Oh, was I late?",
                "No need to thank me.",
                "You're lucky I'm doing this for free...",
                "So how's your day going?",
                "I wanna go home...",
                "I'm tired of this shit.",
                "Guess who!",
                "I'll be taking that.",
                "When will my shift end...", }},


-- You can use this template to make your own driver.
--  * Find the icons here:      https://wiki.gtanet.work/index.php?title=Notification_Pictures
--  * Find the ped models here: https://wiki.gtanet.work/index.php?title=Peds
--  * Find the colours here:    https://wiki.gtanet.work/index.php?title=Vehicle_Colors
--  * Driver ID needs to be a number (in sequential order from the previous one. In this example it would be 3).
--[[

--Edit the NAME, ICON, PED MODEL and TRUCK COLOUR here:
[driver_ID] = {name = "driver_name", icon = "driver_icon", ped = "ped_model", color = 'driver_colour',

--You can add or edit any existing vehicle pickup lines here:
[1] = {"Sample text 1","Sample text 2",}}, -- lines of dialogue. use ~n~ to separate long ones.


]]
}
