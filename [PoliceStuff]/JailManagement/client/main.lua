
Citizen.CreateThread(function()
    while true do Citizen.Wait(500)
        for _, Info in pairs(config.zones) do
			DisplayHelpNotification(Info.Type)
            local p = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(Info.loc.x, Info.loc.y, Info.loc.z, 2, p.x, p.y, true)
            if distance <= config.setup.distance then
                if IsControlJustPressed(0, config.setup.key) and IsControlJustPressed(0, config.setup.key) then
                    SendNUIMessage({type = "Jailindex", status = true})SetNuiFocus(false, false)
                end
            end
        end
    end
end)
function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool and "Jail" or "remove",
        action = bool and "Jail" or "remove"
    })
end

RegisterCommand("Jail", function()
    SetDisplay(not guiEnabled)
end)

config = {}

config.setup = {
    distance = 1,
    key = 38,
    keyname = "~INPUT_PICKUP~"
}

config.zones = {
    {Type = "Bolinbrook Penetentuary", loc = vector3(0.00, 00.00, 0.00)}
}

RegisterKeyMapping("Jail", "Jailling System", "keyboard", config.setup.key)

function DisplayHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
   DrawNotification(true, false)
end
