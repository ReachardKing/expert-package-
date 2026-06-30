

RegisterCommand("tacconnection", function()
    SendNUIMessage({type = "tacsettings"})
end)

RegisterNUICallback("close", function()
    SendNUIMessage({type = "hide"})
end)

RegisterNUICallback("animatiion", function(playerPed, defualt, chatter, chest, earpiece)
    if defualt then
        IsEntityPlayingAnim(playerPed, "random@arrests", "generic_radio_chatter", 3)
    end
    if chatter then
        TaskPlayAnim(playerPed, "random@arrests", "generic_radio_chatter", 8.0, -8.0, -1, 49, 0, false, false, false)
    end
    if chest then
        TaskPlayAnim(playerPed, "random@arrests", "radio_chatter", 8.0, -8.0, -1, 49, 0, false, false, false)
    end
    if earpiece then
        TaskPlayAnim(playerPed, "random@arrests", "radio_earpiece_chatter", 8.0, -8.0, -1, 49, 0, false, false, false)
    end
end)