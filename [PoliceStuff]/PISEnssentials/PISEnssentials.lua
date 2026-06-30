local IsPIS = false

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

--------------------------------------------------------------------------------
------------------------------Police System-------------------------------------
--------------------------------------------------------------------------------

function PISonduty()
    IsPIS = true
    ShowNotification("~w~[~g~Success~w~] You are now on duty")

    local model = GetHashKey("s_m_y_sheriff_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    local playerPed = PlayerPedId()
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)

    SetEntityInvincible(playerPed, true)
    GiveWeaponToPed(playerPed, GetHashKey("WEAPON_STUNGUN"), 9999, false, false)
end

function PIsoffduty()
    IsPIS = false
    ShowNotification("~w~[~r~Success~w~] You are now off duty")

    local playerPed = PlayerPedId()
    ClearPedTasksImmediately(playerPed)
    ClearPedTasks(playerPed)
    SetEntityInvincible(playerPed, false)
    RemoveAllPedWeapons(playerPed, true)
end

--------------------------------------------------------------------------------
--------------------------------On/Off Duty Logic-------------------------------
--------------------------------------------------------------------------------

--[[Citizen.CreateThread(function()
	WarMenu.CreateMenu("PE:main", "Personal Essentials")
	WarMenu.SetTitleBackgroundColor("PE:main", 85, 85, 85, 180)
	WarMenu.SetTitleColor("PE:main", 255, 255, 255, 255)

	WarMenu.CreateSubMenu("PE:clockon", "PE:main", "clock on / off")
end)

-- Main loop
Citizen.CreateThread(function()
    while true do Citizen.Wait(15)
        -- Handle menus
        if WarMenu.IsMenuOpened("PE:main") then
            if WarMenu.MenuButton("clock on duty", "PE:checkEvidence") then
            end
            WarMenu.Display()
        
		elseif WarMenu.IsMenuOpened("PE:checkEvidence") then
			if IsControlJustReleased(1, 38) and IsPIS == false then
				PISonduty()
			elseif IsControlJustReleased(1, 38) and IsPIS == true then
				PISonduty()
			end
            WarMenu.Display()
		end
    end
end)]]


Citizen.CreateThread(function()
	while true do
		local player = PlayerPedId()
		local pl = GetEntityCoords(player)
			Citizen.Wait(0)
				if Vdist(pl.x, pl.y, pl.z, -265.21, -954.9, 30.22) < 1.0 and IsPIS == false then -- <-- Alta st,  Pilbox Hill--
				   DrawText3Ds(-265.21, -954.9, 30.22, "~w~Press [~g~E~w~] To Go on duty as a local cop")
				if IsControlJustReleased(1, 38) then
					PISonduty()
			end
		elseif 
			Vdist2(pl.x, pl.y, pl.z, 000.00, 000.00, 000.00) < 1.0 and IsPIS == false then -- <-- Mission Row --
				 DrawText3Ds(000.00, 000.00, 000.00, "~w~Press [~g~E~w~] To Go on duty as a local cop")
				if IsControlJustReleased(1, 38) then 
					PISonduty()
				end
		elseif 
			Vdist2(pl.x, pl.y, pl.z, 1902.38, 2606.42, 45.97) < 1.0 and IsPIS == false then -- < -- Prison other gate --
				DrawText3Ds(440.85, 1902.38, 2606.42, 45.97, "~w~Press [~g~E~w~] To Go on duty as a local cop")
				if IsControlJustReleased(1, 38) then 
					PISonduty()
				end				
				elseif Vdist2(pl.x, pl.y, pl.z, -265.21, -954.9, 30.22) < 1.0 and IsPIS == true then  -- <-- Alta st,  Pilbox Hill--
				DrawText3Ds(-265.21, -954.9, 30.22, "~w~Press [~g~E~w~] To Go off duty")
			if IsControlJustReleased(1, 38) then 
				PISceoffduty()
			end
			elseif Vdist2(pl.x, pl.y, pl.z, 1902.38, 2606.42, 45.97) < 1.0 and IsPIS == true then -- < -- Prison other gate --
				DrawText3Ds(1902.38, 2606.42, 45.97, "~w~Press [~g~E~w~] To Go off duty")
			if IsControlJustReleased(1, 38) then 
				PISceoffduty()
			end
			elseif Vdist2(pl.x, pl.y, pl.z, 000.00, 000.00, 000.00) < 1.0 and IsPIS == true then 
				DrawText3Ds(000.00, 000.00, 000.00, "~w~Press [~g~E~w~] To Go off duty")
			if IsControlJustReleased(1, 38) then 
				PISceoffduty()
			end 		
		end
	end
end)