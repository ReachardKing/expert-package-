
-- Hire
AddEventHandler("onResourceStart", function(resource)
    if resource ~= GetCurrentResourceName() then return end
end)

local guiEnabled = false
local tab = nil

function SetDisplay(bool, department, callsign)
    guiEnabled = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool and "FTOInfo" or "Hide",
        playerName = GetPlayerName(PlayerPedId()),
        clockedIn = GetClockMinutes(),
        totalhours = GetClockHours(),
        totalEmployees = GetTotalEmployees(department),
        callsignValue = callsign
    })
end

RegisterCommand("ERP", function()
    SetDisplay(not guiEnabled)
    
    if guiEnabled then
        RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
        while not HasAnimDictLoaded("amb@world_human_seat_wall_tablet@female@base") do
            Citizen.Wait(5)
        end
        TaskPlayAnim(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base", 8.0, -8.0, -1, 50, 0, false, false, false)
        tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
        AttachEntityToEntity(tab, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
    end
end)

RegisterNUICallback("remove", function()
    SetDisplay(false)
    SetNuiFocus(false, false)
end)

RegisterNUICallback("Hide", function()
    SetDisplay(false)
    SetNuiFocus(false, false)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
	SetDisplay(false)
	ClearPedTasks(PlayerPedId())  -- Safer cleanup
    if DoesEntityExist(tab) then
		DeleteEntity(tab)
        DetachEntity(tab, true, true)
	end
	tab = nil
end)

RegisterKeyMapping("ERP Management", "Some one new?", "keyboard", "")