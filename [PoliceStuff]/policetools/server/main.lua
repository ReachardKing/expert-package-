isLocked = nil

RegisterServerEvent('mDoorLocks:update')
AddEventHandler('mDoorLocks:update', function(id, isLocked)
    if (id ~= nil and isLocked ~= nil) then
		TriggerClientEvent('mDoorLocks:state', -1, id, isLocked)
		
    end
end)