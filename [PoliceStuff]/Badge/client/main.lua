
AddEventHandler("Mackenzie_Rich:Badge", function()
    local ped = PlayerPedId()
    local cords = GetEntityCoords(ped)
    local badgeprop = CreateObject(GetHashKey('prop_fbi_badge'), cords.x, cords.y, cords.z + 0.2, true, true, true)
    local boneindx = GetPedBoneIndex(ped, 28422)

    AttachEntityToEntity(badgeprop, ped, boneindx, 0.065, 0.029, -0.035, -1.90, 75.0, 1.0, true, true, false, true, 1, true)
    RequestAnimDict('paper_1_rcm_alt1-9')
    TaskPlayAnim(ped, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 8.0, -8, 10.0, 49, 0, false, false, false)
    SetNuiFocus(false, false)
    SendNUIMessage({type = "Status", visible = true })
    Wait(15000)
    SetNuiFocus(false, false)
    SendNUIMessage({type = "hide", visible = false})
    SetNuiFocus(false, false)
    SendNUIMessage({type = "hide", visible = false})
    ClearPedSecondaryTask(ped)
    DeleteObject(badgeprop)
end)


RegisterCommand("badge", function()
    TriggerEvent("Mackenzie_Rich:Badge")
end, false)

RegisterKeyMapping("Badge", 'Gonvenment Issued', 'keyboard', '')

RegisterCommand("close", function()
    SendNUIMessage({type = "Status", visible = false})
    SendNUIMessage({type = "Status", visible = false})
    SetNuiFocus(false, false)
end)