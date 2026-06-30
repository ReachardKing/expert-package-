-- Created by Physics_is_ki
-- V 1.1
-- Requested by @Dillon_Dobusz on forum.fivem.net

-- Serverside

------ CONFIG ------

local everyoneAllowed = false -- If true, everyone is allowed and you do not need to add steam/ip identifiers. If false, you need to add steam/ip identifiers so they can use the command.
local allowed =
{
	"steam:1100001120d578d",
	"steam:",
	"steam:",
	"ip:192.168.1.1",
	"ip:192.168.1.2",
}

------ CODE DO NOT TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING :) ------

AddEventHandler('chat:addMessage', function(source, n, msg)
	local msg = string.lower(msg)
	local identifier = GetPlayerIdentifiers(source)[1]
	
	if msg == '/cone' then
		CancelEvent()
		
		if everyoneAllowed then
			TriggerClientEvent('Physics_is_ki:cone', source)
		else
			if CheckAllowed(identifier) then
				TriggerClientEvent('Physics_is_ki:cone', source)
			else
				TriggerClientEvent('Physics_is_ki:insuffPerms', source)	
			end
		end
		
	elseif msg == '/sbarrier' then
	
		CancelEvent()
		
		if everyoneAllowed then
			TriggerClientEvent('Physics_is_ki:sbarrier', source)
		else
			if CheckAllowed(identifier) then
				TriggerClientEvent('Physics_is_ki:sbarrier', source)
			else
				TriggerClientEvent('Physics_is_ki:insuffPerms', source)	
			end
		end
		
	elseif msg == '/barrier' then
	
		CancelEvent()
		
		if everyoneAllowed then
			TriggerClientEvent('Physics_is_ki:barrier', source)
		else
			if CheckAllowed(identifier) then
				TriggerClientEvent('Physics_is_ki:barrier', source)
			else
				TriggerClientEvent('Physics_is_ki:insuffPerms', source)	
			end
		end
		
	elseif msg == "/PorpsRemove" then
		if everyoneAllowed then
			TriggerClientEvent("Physice_is_ki:Removeprops", source)
		else
			if CheckAllowed(identifier) then
				TriggerClientEvent("Physice_is_ki:Removeprops", source)
			else
				TriggerClientEvent('Physics_is_ki:insuffPerms', source)	
			end
		end
	end
end)

function CheckAllowed(id)
	for k, v in pairs(allowed) do
		if id == v then
			return true
		end
	end
	return false
end