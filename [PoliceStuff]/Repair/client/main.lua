
config = {}

config.setup = {
    distance = 2,
    key  = 38,
    key = 51,
}

config.Ped = {
    PedModel = "s_m_y_cop_01",
    AnimDictionary = "anim@amb@nightclub@peds@",
    Animation = "rcmme_amanda1_stand_loop_cop"
}

config.Zones = { -- the type has to match the type defined in config.Weapons
    { Type = "Police mechanic", loc = vector3(445.78, -1025.28, 28.65)}, -- MRPD Station.
	{ Type = "Police mechanic", loc = vector3(438.3, -1027.93, 28.8)}, -- MRPD Station.
    { Type = "Police mechanic", loc = vector4(434.98, -1026.61, 28.46, 185.99)}, -- MRPD
    { Type = "Police mechanic", loc = vector4(431.26, -1027.31, 28.53, 185.59)}, -- MRPD
    { Type = "Police mechanic", loc = vector4(427.52, -1026.84, 28.58, 184.25)}, -- MRPD
    { Type = "Police mechanic", loc = vector3(442.22, -1026.63, 28.72)}, -- MRPD Shores.
	{ Type = "Police mechanic", loc = vector3(579.93, 12.23, 103.23)}, -- MRPD Roof.#2
    { Type = "Police meachnic", loc = vector3(449.1,  -981.41, 42.69)}, -- MRPD Rooftop 
    { Type = "Police mechanic", loc = vector4(396.34, -1644.28, 28.86, 319.10)}, -- Davis Garage
    { Type = "Police mechanic", loc = vector4(398.56, -1646.42, 28.8616, 319.18)}, -- Davis Garage
    { Type = "Police mechanic", loc = vector4(400.68, -1648.86, 28.86, 140.78)}, -- Davis Garage
    { Type = "Police mechanic", loc = vector4(403.32, -1650.54, 28.86, 319.92)}, -- Davis Garage
    { Type = "Police mechanic", loc = vector4(403.21, -1650.68, 28.86, 139.40)}, -- Davis Garage
    { Type = "Police mechanic", loc = vector3(1872.08, 3687.24, 33.31)}, -- Sandy Station.
    { Type = "Police mechanic", loc = vector3(870.6, -1350.41, 26.06)}, -- La Mesa station
    { Type = "Police mechanic", loc = vector3(-474.35,  6034.4, 31.11)}, -- Paleto station
    { Type = "Police mechanic", loc = vector3(533.83, -26.17, 70.63)}, -- Vine wood PD
    { Type = "Police mechanic", loc = vector3(530.74, -29.19, 70.63)}, -- Vine wood PD
    { Type = "Police mechanic", loc = vector3(-1107.52, -800.54, 17.17)}, -- Vespucci wood PD
    { Type = "Police mechanic", loc = vector3(-1110.42, -802.26, 16.91)}, -- Vespucci wood PD
}

RegisterNUICallback("Checked", function(source, args)  
    for Extranumber = 0, 20 do
        SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), Extranumber, 0)
        SendNUIMessage({type = "HUD", visible = false})
        SetNuiFocus(false, false)
    end
    Citizen.CreateThread(function()
        while true do Citizen.Wait(300) SendNUIMessage({type = "HUD", visible = false}) 
            SetNuiFocus(false, false) 
        end
    end)
end)

RegisterNUICallback("Store", function()
    local Handle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetEntityAsMissionEntity(Handle, true, true)
    SetEntityAsNoLongerNeeded(Handle)
    DeleteEntity(Handle)
    SendNUIMessage({type = "HUD", visible = false}) SetNuiFocus(false, false)
end)

RegisterNUICallback("local", function()
    SendNUIMessage({type = "HUD", visible = false}) SetNuiFocus(false, false)
    ExecuteCommand("KNBtow")
end)

RegisterNUICallback("cash", function()
    SendNUIMessage({type = "HUD", visible = false}) SetNuiFocus(false, false)
    exports['progressBars']:startUI(3000, "Fixing.. cleaning...") Citizen.Wait(3000)
    SetVehicleDeformationFixed(GetVehiclePedIsIn(PlayerPedId(), false))
    SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(), false), 0)
    SetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false), 1000.0)
    SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), false))
end)

RegisterNUICallback("bank", function()
    SendNUIMessage({type = "HUD", visible = false}) SetNuiFocus(false, false)
    exports['progressBars']:startUI(3000, "Fixing.. cleaning...") Citizen.Wait(3000)
    SetVehicleDeformationFixed(GetVehiclePedIsIn(PlayerPedId(), false))
    SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(), false), 0)
    SetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false), 1000.0)
    SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), false))
end)

RegisterNUICallback("Cancel", function()
    SendNUIMessage({type = "HUD", visible = false}) 
    SetNuiFocus(false, false)
end)


RegisterNUICallback("remove", function()
    SendNUIMessage({type = "HUD", visible = false}) 
    SetNuiFocus(false, false)
end)


local display = false

Citizen.CreateThread(function()
    while true do Citizen.Wait(0)
        local p = GetEntityCoords(PlayerPedId())
        for _, info in pairs(config.Zones) do 
            local distance = GetDistanceBetweenCoords(info.loc.x, info.loc.y, info.loc.z, p.x,  p.y,  p.z)
            if distance <= config.setup.distance then 
                --ShowNotification(info.Type.. "~INPUT_PICKUP~ ")
                display = true
                if IsControlJustPressed(0, config.setup.key) and IsControlJustPressed(0, config.setup.key)and IsPedInAnyPoliceVehicle(PlayerPedId(), false) then
                   SetNuiFocus(true, true)
				   SendNUIMessage({type = "HUD", visible = true})
                end
            end
        end
    end
end)

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end