NamelessCore = nil
TriggerEvent("NamelessCore:GetServerObjects", function(Core)
    NamelessCore = core
end)

local connect = {}

function Playerinfo()
    local player = NamelessCore.GetPlayer() or {}
    return {
        firstname = player.firstname or "",
        lastname = player.lastname or "",
        dob = player.dob or "",
        gender = player.gender or "",
    }
end

function GetcitizenID(id, info)
    return {
        characterid = id,
        firstname = info.firstname,
        lastname = info.lastname,
        dob = info.dob,
        gender = info.gender,
    }
end

return connect