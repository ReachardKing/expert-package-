
citizen = {}

RegisterNUICallback("choosetest", function(bool)
    SendNUIMessage({action = "hide", openlicesedID = bool})SetNuiFocus(false, false)
end)

RegisterNUICallback("revoke", function(character, remove)
    citizen[character] = nil

    local characters = citizen[character]
    for _, characters in pairs(characters) do
        if characters.firstname == firstname and characters.lastname == lastname then
            characters = remove
        end
    end
end)

RegisterNUICallback("Grant", function(character, Grant)

    local characters = citizen[character]
    for _, characters in pairs(characters) do
        if characters.firstname == firstname and characters.lastname == lastname then
            characters = Grant
        end
    end
end)

RegisterNUICallback("Grant2", function(character, Grant)
    local characters = citizen[character]
    for _, characters in pairs(characters) do
        if characters.firstname == firstname and characters.lastname == lastname then
            characters = Grant
        end
    end
end)

RegisterNUICallback("revoke2", function(character, remove)
    local characters = citizen[character]
    for _, characters in pairs(characters) do
        if characters.firstname == firstname and characters.lastname == lastname then
            characters = remove
        end
    end
end)

RegisterNUICallback("Grant3", function(character, Grant)
    local characters = citizen[character]
    for _, characters in pairs(characters) do
        if characters.firstname == firstname and characters.lastname == lastname then
            characters = Grant
        end
    end
end)

RegisterNUICallback("revoke3", function(character, remove)

    local characters = citizen[character]
    for _, characters in pairs(characters) do
        if characters.firstname == firstname and characters.lastname == lastname then
            characters = remove
        end
    end
end)

RegisterNUICallback("updatelicense", function(firstname, lastname, DOB)
    SendNuiMessage("updatelicense", {firstname = firstname, lastname = lastname, DOB = DOB})

end)

RegisterCommand("Gunlicense", function()
    SendNUIMessage({action = "show", openlicesedID = bool})
end)

RegisterNUICallback("choosetest", function(bool)
    SendNUIMessage({action = "hide", openlicesedID = bool})SetNuiFocus(false, false)
end)

function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = bool and "show" or "hide",
        action = bool and "show" or "hide"
    })
end

RegisterCommand("ShowLicenseUI", function(bool, hash)
    SetDisplay(not bool)
end, false)

-- vector3(273.38, -278.48, 53.94) 