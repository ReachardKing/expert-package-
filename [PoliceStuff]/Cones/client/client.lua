-- Created by Physics_is_ki
-- V 1.1
-- Requested by @Dillon_Dobusz on forum.fivem.net

-- Clientside

RegisterNetEvent('Physics_is_ki:cone')
RegisterNetEvent('Physics_is_ki:sbarrier')
RegisterNetEvent('Physics_is_ki:barrier')
RegisterNetEvent('Physics_is_ki:insuffPerms')

AddEventHandler('Physics_is_ki:insuffPerms', function()
	notification('~r~You have insufficient permissions to place this objectS!')
end)

AddEventHandler('Physics_is_ki:cone', function()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	local heading = GetEntityHeading(PlayerPedId())
	
	RequestModel('prop_mp_cone_01')
	
	while not HasModelLoaded('prop_mp_cone_01') do
		Citizen.Wait(1)
	end
	
	local cone = CreateObject('prop_mp_cone_01', x, y, z-2, true, true, true)
	PlaceObjectOnGroundProperly(cone)
	SetEntityHeading(cone, heading)
	notification('~g~The cone has been placed!')
end)

AddEventHandler('Physics_is_ki:sbarrier', function()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	local heading = GetEntityHeading(PlayerPedId())
	
	RequestModel('prop_mp_barrier_02b')
	
	while not HasModelLoaded('prop_mp_barrier_02b') do
		Citizen.Wait(1)
	end
	
	local sbarrier = CreateObject('prop_mp_barrier_02b', x, y, z-2, true, true, true)
	local cone = CreateObject('prop_mp_cone_01', x, y, z-2, true, true, true)
	PlaceObjectOnGroundProperly(sbarrier)
	PlaceObjectOnGroundProperly(cone)
	SetEntityHeading(sbarrier, heading)
	notification('~g~The small barrier has been placed!')
end)

AddEventHandler('Physics_is_ki:barrier', function()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	local heading = GetEntityHeading(PlayerPedId())
	
	RequestModel('prop_barrier_work05')
	
	while not HasModelLoaded('prop_barrier_work05') do
		Citizen.Wait(1)
	end
	
	local barrier = CreateObject('prop_barrier_work05', x, y, z-2, true, true, true)
	local cone = CreateObject('prop_mp_cone_01', x, y, z-2, true, true, true)
	PlaceObjectOnGroundProperly(barrier)
	PlaceObjectOnGroundProperly(cone)
	SetEntityHeading(barrier, heading)
	notification('~g~The barrier has been placed!')
end)

AddEventHandler("Physice_is_ki:Removeprops", function(props, model)
	DeleteObject(props)
	DeleteEntity(props)
	SetEntityAsMissionEntity(props, false, false)
end)

function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end