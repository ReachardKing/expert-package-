
--[[AddEventHandler("CameraTech:CheckMyAuthorization", function()
    -- Register commands

end)]]

RegisterNetEvent("police:runCommand")
AddEventHandler("police:runCommand", function(cmd)
    if cmd == "anpr" then anprinterfacefunc()
    elseif cmd == "checkplate" then checkplatefunc()
    elseif cmd == "fixedanpr" then fixedanprfunc()
    elseif cmd == "focusanpr" then focusanprfunc()
    elseif cmd == "vehicleanpr" then vehicleanprfunc()
    elseif cmd == "readplate" then readplatefunc()
    elseif cmd == "setplateinfo" then setplateinfofunc()
    elseif cmd == "setvehinfo" then setvehinfofunc()
    end
end)

RegisterCommand('anpr', anprinterfacefunc, true)
RegisterCommand('checkplate', checkplatefunc, true)
RegisterCommand('fixedanpr', fixedanprfunc, true)
RegisterCommand('focusanpr', focusanprfunc, true)
RegisterCommand('focusplate', focusanprfunc, true)
RegisterCommand('vehicleanpr', vehicleanprfunc, true)
RegisterCommand('rp', readplatefunc, true)
RegisterCommand('readplate', readplatefunc, true)
RegisterCommand('setplateinfo', setplateinfofunc, true)
RegisterCommand('setvehinfo', setvehinfofunc, true)

