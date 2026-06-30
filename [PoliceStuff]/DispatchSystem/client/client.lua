local ShowMenu = false
tab = nil

Citizen.CreateThread(function()
    while true do Citizen.Wait(1) 
        if IsControlJustPressed(1, 246) then
            DispatchTablet()

            ShowMenu = true
            SendNUIMessage({
                type = "Dispatch",
                status = true
            })

            SetCursorLocation(0.917, 0.873)
            SetNuiFocus(true, true)

            PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", true)

            while ShowMenu == true do Citizen.Wait(100) end
            Citizen.Wait(100)
            while IsControlJustPressed(0, 246) do Citizen.Wait(100) end
        end
    
    end 
end)

RegisterNUICallback("close", function() 
    SendNUIMessage({type = "Dispatch", status = false})
    SendNUIMessage({action = "dispatchview", type = "dispatchview", visible = false})
    ShowMenu = false
    SetNuiFocus(false, false)
end)

RegisterCommand("Dispatchview", function()
    SendNUIMessage({type = "DispatchView", visible = true})
    SetNuiFocus(true, true)
    ShowMenu = true
end)

RegisterCommand("DispatchCall", function() 
    SendNUIMessage({type = "Dispatch", status = true})
    SetNuiFocus(true, true)
    ShowMenu = true
end)

------------------------------------------------------------

RegisterKeyMapping("DispatchCall", "view Dispatch Calls", "keyboard", "Y")
RegisterKeyMapping("Dispatchview", "Dispatch view", "keyboard", " ")
RegisterKeyMapping("DispatchCall", "Dispatch view", "keyboard", " ")
-- Functions
function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DispatchTablet(department, current_rank)
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local dict = "amb@world_human_seat_wall_tablet@female@base"
        local anim = "base"

        -- Load animation dictionary
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        -- Create the tablet prop
        local tab = CreateObject(GetHashKey("prop_cs_tablet"), 0.0, 0.0, 0.0, true, true, false)

        -- Attach the prop to player's right hand
        AttachEntityToEntity(tab, ped, GetPedBoneIndex(ped, 57005), 0.14, 0.02, -0.02, 20.0, 150.0, 200.0, true, true, false, true, 1, true)

        -- Play the animation
        TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)

        -- Let the animation run for 5 seconds
        Citizen.Wait(5000)

        -- Clear animation and remove tablet
        ClearPedSecondaryTask(ped)
        DetachEntity(tab, false, false)
        DeleteEntity(tab)
    end)
end