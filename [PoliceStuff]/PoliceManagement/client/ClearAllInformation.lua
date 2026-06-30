
local hascallvalue, hascallbackvalue = nil, false
employees = {}


Citizen.CreateThread(function()
    while hascallbackvalue do
        Citizen.Wait(500)
    end
end)

RegisterNUICallback("Suspension", function(src, NewEmployees)
    hascallvalue = data.value
    hascallbackvalue = true
end)

RegisterNUICallback("Treminate", function(src, NewEmployees)
    hascallvalue = data.value
    hascallbackvalue = true
end)

RegisterNUICallback("PermanentlyTreminated", function(src, NewEmployees)
    hascallvalue = data.value
    hascallbackvalue = true
end)

RegisterNUICallback("setCallsign", function(src, data)
    hascallvalue = data.value
    hascallbackvalue = true
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(500)
        SendNUIMessage({
            action = "updateEmployeeList",
            employees = employees
        })
    end
end)