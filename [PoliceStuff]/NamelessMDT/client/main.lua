
local guiEnabled = false
local tab = nil

function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    guiEnabled = bool

    SendNUIMessage({
        type = bool and "MDT" or "remove",
        action = bool and "MDT" or "remove"
    })
end

function SetEMSDisplay(bool, playerId)
   if exports["policetools"]:IsOnDuty(playerId)then 
        SetNuiFocus(bool, bool)
        guiEnabled = bool

        SendNUIMessage({
            type = bool and "EMSMDT" or "remove",
            action = bool and "EMSMDT" or "remove"
        })
    end
end

RegisterCommand("MDT", function(source, args, raw)
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

RegisterCommand("EMSMDT", function()
    SetEMSDisplay(not guiEnabled)
end)

RegisterNUICallback("remove", function()
    SetEMSDisplay(false)
    SetDisplay(false)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
	SetDisplay(false)
	SetEMSDisplay(false)
	ClearPedTasks(PlayerPedId())  -- Safer cleanup
    if DoesEntityExist(tab) then
		DeleteEntity(tab)
	end
	tab = nil
end)


RegisterKeyMapping("MDT", "Mobile Data Terminal", "keyboard", "")
RegisterKeyMapping("EMSMDT", "Emergency Medical Services MDT", "keyboard", "")