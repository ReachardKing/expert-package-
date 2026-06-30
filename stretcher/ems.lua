-- Coded by Xerxes468893#0001 (Peter Greek) For BCDOJRP, released to the public

strNames = { 'v_med_bed1', 'v_med_bed2','prop_ld_binbag_01'} -- Add more model strings here if you'd like
strHashes = {}
animDict = 'missfbi5ig_0'
animName = 'lyinginpain_loop_steve'
isOnstr = false
local strTable = {}
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
    for k,v in ipairs(strNames) do
        table.insert( strHashes, GetHashKey(v))
    end
end) 

function VehicleInFront()
  local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

local open = false
RegisterNetEvent("ARPF-EMS:opendoors")
AddEventHandler("ARPF-EMS:opendoors", function()
veh = VehicleInFront()
if open == false then
    open = true
    SetVehicleDoorOpen(veh, 2, false, false)
    Citizen.Wait(1000)
    SetVehicleDoorOpen(veh, 3, false, false)
elseif open == true then
    open = false
    SetVehicleDoorShut(veh, 2, false)
    SetVehicleDoorShut(veh, 3, false)
end
end)

local incar = false
RegisterNetEvent("ARPF-EMS:togglestrincar")
AddEventHandler("ARPF-EMS:togglestrincar", function()
	
	local veh = VehicleInFront()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if IsEntityAttachedToAnyVehicle(closestObject) then
    	incar = true
    elseif IsEntityAttachedToEntity(closestObject, veh) then 
    	incar = true
    end
    if incar == false then 
        StreachertoCar()
        incar = true
    elseif incar == true then
        incar = false
        StretcheroutCar()
    end
end)



function StreachertoCar()
    local veh = VehicleInFront()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            AttachEntityToEntity(closestObject, veh, 0.0, 0.0, -3.7, 0.0, 0.0, 0.0, 90.0, false, false, true, false, 2, true)
            FreezeEntityPosition(closestObject, true)
        else
            print("car dose not exist ")
        end
    else
        print("nothing around here dumb ass")
    end
end

function StretcheroutCar()
    local veh = VehicleInFront()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            DetachEntity(closestObject, true, true)
            FreezeEntityPosition(closestObject, false)
            local coords = GetEntityCoords(closestObject, false)
            SetEntityCoords(closestObject, coords.x - 3.0, coords.y, coords.z)
            PlaceObjectOnGroundProperly(closestObject)
        else
            print("vehicle does not exist")
        end
    else
        print("nothing around here")
    end
end
-----------------------------------------------------------------------------------------------------------------------
--[[
test sync to server 
attchedStr = {}

if then 
	table.insert('attchedStr',['obj'] = closestObject, ['to'] = veh)
end 
TriggerServerEvent('stretcher:table:update',attchedStr)

ARPF-EMS:stretcherSync
ARPF-EMS:server:stretcherSync

strTable
]]

RegisterCommand('spawnstr', function() 
    LoadModel('prop_ld_binbag_01')
    local str = CreateObject(GetHashKey('prop_ld_binbag_01'), GetEntityCoords(PlayerPedId()), true)
end, false)

RegisterCommand('delStr', function(source, args)
	local object = GetHashKey('prop_ld_binbag_01')
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 2.5, object, true) then
        local obj = GetClosestObjectOfType(x, y, z, 2.5, object, false, false, false)
        for q,d in ipairs(strTable) do
        	if d['obj'] == obj then
        		local attachedToWhat = GetEntityAttachedTo(obj) and not nil or "none" 
        		DeleteObject(obj)
        		TriggerServerEvent("ARPF-EMS:server:stretcherSync",3,q,attachedToWhat,false)
        	end
        end
    end

end, false)


RegisterNetEvent("ARPF-EMS:stretcherSync")
AddEventHandler("ARPF-EMS:stretcherSync", function(tableUpdate)
	strTable = tableUpdate
end)

local changed = false
Citizen.CreateThreadNow(function()
	while true do 
		Citizen.Wait(10)
		TableID = 0 
		local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_ld_binbag_01"), false)
        if DoesEntityExist(closestObject) then
            local strCoords = GetEntityCoords(closestObject)
            for i,v in ipairs(strTable) do
			 	local strobj = v['obj']
				if strobj == closestObject then
					TableID = i 
				elseif strobj ~= closestObject and TableID <= 0 then 
					TableID = -1 -- this means that the new stretcher is not in the table and after checking all of the stretches it will then add the new one to the table and then send it to the server to then update all the clients on the server
					print("not the right stretcher")
				end  
			end
			if TableID == -1 then -- add to server table 
				local attachedToWhat = GetEntityAttachedTo(closestObject) and not nil or "none" 
				local state = 2
				local tableNum = -1
				local what = attachedToWhat
				local sync = false
				TriggerServerEvent("ARPF-EMS:server:stretcherSync",state,tableNum,what,sync)
			elseif TableID > 0 then -- check if the stretcher has a changed state
			end 

			for k,u in pairs(strTable) do
        		local strobj = strTable[k]['obj']
        		--local strobj = u['obj'] -- one of these are faster 
        		if DoesEntityExist(strobj) then
        		 	local pedCoords = GetEntityCoords(ped)
					local strCoords = GetEntityCoords(closestObject)
					local distances = GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, strCoords.x, strCoords.y, strCoords.z, true)
        			local attachedToWhat = GetEntityAttachedTo(strobj) and not nil or "none"
			        if 	distances < 5 then 
			        	if IsEntityAttachedToAnyPed(strobj) or IsEntityAttachedToAnyVehicle(strobj) or IsEntityAttachedToAnyObject(strobj) then 
							if attachedToWhat ~= v['to'] then -- even if somehow v['to'] == nil then it will change to "none"
								v['to'] = attachedToWhat
								local changed = true
							end
						else
							if attachedToWhat == v['to'] then 
								local change = false
							else 
								print(attachedToWhat)
								print("this fucked up if it gets here and nothing is shown")
							end
						end
					end
	        	else
	        	-- insert deleting into the deleting command TriggerServerEvent("ARPF-EMS:server:stretcherSync",state,tableNum,what,sync)	
	        	end
        	end  
        end
	end
end)
		
--[[if IsEntityAttachedToAnyPed(strobj) then 
	newWhat = GetEntityAttachedTo(strobj)
	if newWhat ~= v['to'] then 
		v['to'] = newWhat
		local changed = true
	end
elseif IsEntityAttachedToAnyVehicle(strobj) then
	newWhat = GetEntityAttachedTo(strobj)
	if newWhat ~= v['to'] then 
		v['to'] = newWhat
		local changed = true
	end
elseif IsEntityAttachedToAnyObject(strobj) then 
	newWhat = GetEntityAttachedTo(strobj)
	if newWhat ~= v['to'] then 
		v['to'] = newWhat
		local changed = true
	end
else
	if GetEntityAttachedTo(strobj) == nil or GetEntityAttachedTo(strobj) == v['to'] then 
		local change = false 
	end
end]]

RegisterNetEvent("ARPF-EMS:pushstreacherss")
AddEventHandler("ARPF-EMS:pushstreacherss", function()
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
        if DoesEntityExist(closestObject) then
            local strCoords = GetEntityCoords(closestObject)
            local strVecForward = GetEntityForwardVector(closestObject)
            local sitCoords = (strCoords + strVecForward * - 0.5)
            local pickupCoords = (strCoords + strVecForward * 0.3)
            if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 2.0 then
                PickUp(closestObject)
            end
        end 
end)


RegisterNetEvent("ARPF-EMS:getintostretcher")
AddEventHandler("ARPF-EMS:getintostretcher", function()
 local pP = PlayerPedId()
 local ped = PlayerPedId()
 local pedCoords = GetEntityCoords(ped)
 local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
     local strCoords = GetEntityCoords(closestObject)
     local strVecForward = GetEntityForwardVector(closestObject)
     local sitCoords = (strCoords + strVecForward * - 0.5)
     local pickupCoords = (strCoords + strVecForward * 0.3)
        if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 then
            TriggerEvent('sit', closestObject) 
        end
    end
end)


function revivePed(ped)
  local playerPos = GetEntityCoords(ped, true)

  NetworkResurrectLocalPlayer(playerPos, true, true, false)
  SetPlayerInvincible(ped, false)
  ClearPedBloodDamage(ped)
end

-- Anim Taken from bed script from FFourms
local inBedDicts = "anim@gangops@morgue@table@"
local inBedAnims = "ko_front"
RegisterNetEvent('sit')
AddEventHandler('sit', function(strObject)
    local _, closestPlayerDist = GetClosestPlayer()
    local playPed = PlayerPedId()
    if closestPlayerDist ~= -1 and closestPlayerDist <= 1.5 then
        local closestPlayerPed = GetPlayerPed(GetClosestPlayer())
        if IsEntityPlayingAnim(closestPlayerPed, inBedDicts, inBedAnims, 3) then
            ShowNotification("Somebody is already using the Stretcher!")
            return
        end
    end

    LoadAnim(inBedDicts)
    if IsPedDeadOrDying(playPed) then
        revivePed(playPed)
        wasdead = true
    else
        wasdead = false
    end

    AttachEntityToEntity(playPed, strObject, 0, 0.0, 0.2, 0.95, 0.0, 0.0, 180.0, false, false, false, false, 2, true)
    
    while IsEntityAttachedToEntity(playPed, strObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(playPed) then
            DetachEntity(playPed, true, true)
            break
        end

        if not IsEntityPlayingAnim(playPed, inBedDicts, inBedAnims, 3) then
            TaskPlayAnim(playPed, inBedDicts, inBedAnims, 8.0, 8.0, -1, 49, 0, false, false, false)
        end

        if IsControlJustPressed(0, 73) then -- 73 = X
            TriggerEvent("unsit", strObject)
            break
        end
    end 
end)


RegisterNetEvent('unsit')
AddEventHandler('unsit', function(strObject)   
    local ped = PlayerPedId()
    DetachEntity(ped, true, true)
    ClearPedTasks(ped)
    local x, y, z = table.unpack(GetEntityCoords(strObject) + GetEntityForwardVector(strObject) * -1.0)
    SetEntityCoords(ped, x,y,z)
    if wasdead then
        local currentHealth = GetEntityHealth(ped)
        SetEntityHealth(ped, currentHealth - 200) -- This will likely put the player in a downed state again.
        wasdead = false
    end
end)

-------------------------------- FUNCTIONS ----------------------------------------------------------------------------

function PickUp(strObject)
    local _, closestPlayerDist = GetClosestPlayer()

    if closestPlayerDist ~= -1 and closestPlayerDist <= 1.5 then
        local closestPlayerPed = GetPlayerPed(GetClosestPlayer())
        if IsEntityPlayingAnim(closestPlayerPed, 'anim@heists@box_carry@', 'idle', 3) then
            ShowNotification("Somebody is already pushing the Stretcher!")
            return
        end
    end

    NetworkRequestControlOfEntity(strObject)
    LoadAnim("anim@heists@box_carry@")
    local pedid = PlayerPedId()
    AttachEntityToEntity(strObject, pedid, GetPedBoneIndex(pedid, 28422), 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    
    -- Inform server about the state change
    TriggerServerEvent("ARPF-EMS:server:stretcherAttach", ObjToNet(strObject), PedToNet(pedid))

    while IsEntityAttachedToEntity(strObject, pedid) do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(pedid, 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(pedid, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        DisableControlAction(0, 21, true) -- Disable sprint

        if IsPedDeadOrDying(pedid) or IsControlJustPressed(0, 73) then -- 73 = X
            DetachEntity(strObject, true, true)
            ClearPedTasks(pedid)
            -- Inform server about the state change
            TriggerServerEvent("ARPF-EMS:server:stretcherAttach", ObjToNet(strObject), 0)
            break
        end
    end
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, false)
    
    for _, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if target ~= ply then
            local targetCoords = GetEntityCoords(target, false)
            local distance = #(plyCoords - targetCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function LoadAnim(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(1)
    end
end

function ShowNotification(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(false, true)
end

-- Key Mappings
RegisterCommand("pushstr", function() TriggerEvent("ARPF-EMS:pushstreacherss") end, false)
RegisterCommand("getintostr", function() TriggerEvent("ARPF-EMS:getintostretcher") end, false)
RegisterCommand("openbaydoors", function() TriggerEvent("ARPF-EMS:opendoors") end, false)
RegisterCommand("togglestr", function() TriggerEvent("ARPF-EMS:togglestrincar") end, false)

RegisterKeyMapping("spawnstr", "Spawn Stretcher", 'keyboard', "F6") -- Example key
RegisterKeyMapping("delStr", "Delete Stretcher", 'keyboard', "F7") -- Example key
RegisterKeyMapping("pushstr", "Push Stretcher", 'keyboard', "G")
RegisterKeyMapping("getintostr", "Get on Stretcher", 'keyboard', "E")
RegisterKeyMapping("openbaydoors", "Open Ambulance Doors", 'keyboard', "H")
RegisterKeyMapping("togglestr", "Put Stretcher in/out of Vehicle", 'keyboard', "B")