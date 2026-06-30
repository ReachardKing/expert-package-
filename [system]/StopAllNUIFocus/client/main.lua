
AddEventHandler("playerSpawned", function()

	Citizen.CreateThread(function()
		while true do Citizen.Wait(3000)    
			SetMouseCursorVisibleInMenus(false)
			SetNuiFocus(false, false)
		end
	end)

	RegisterCommand("close", function()
		Citizen.CreateThread(function()
			while true do Citizen.Wait(3000)    
				SetMouseCursorVisibleInMenus(false)
				SetNuiFocus(false, false)
			end
		end)
	end)

	function ClearObject(obname, hash, cleartime)
		DeleteEntity(obname)
		DeleteEntity(hash)
		Citizen.Wait(cleartime)
		SetMouseCursorVisibleInMenus(false)
		SetNuiFocus(false, false)
	end

	Citizen.CreateThread(ClearObject)
end)

RegisterCommand("close", function()
	SetMouseCursorVisibleInMenus(false)
	SetNuiFocus(false, false)
end)