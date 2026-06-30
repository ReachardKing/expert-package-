-- Functions
-- displays nornal notification above HUD
function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end
 
-- Shows a notification on the player's screen 
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do        
        Citizen.Wait(1)
    end
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function Notify(string)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringKeyboardDisplay(string)
    EndTextCommandThefeedPostTicker(true, true)
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawText3Ds(x, y, z, width, height, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        DrawRect(_x, _y, width, height, 255, 129, 200, 255)
        local factor = (string.len(text)) / 350
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
    end
end


function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function SpawnPedVeicle(veh, Name, Livery, Extras)
    local Ped = GetPlayerPed( -1 )
    if (DoesEntityExist(Ped) and not IsEntityDead(Ped)) then 
        local pos = GetEntityCoords(Ped)
        if (IsPedSittingInAnyVehicle(Ped)) then 
            local Vehicle = GetVehiclePedIsIn(Ped, false)
            if (GetPedInVehicleSeat(Vehicle, -1) == Ped) then 
                SetEntityAsMissionEntity(Vehicle, true, true )
                SetVehicleOnGroundProperly(Vehicle)
                DeleteVehicle(Vehicle)
            end
        end
    end

    local WaitTime = 0
    local Model = GetHashKey(veh)
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        CancelEvent()
        RequestModel(Model)
        Citizen.Wait(100)

        WaitTime = WaitTime + 1

        if WaitTime == 8000 then
            CancelEvent()
            notify('~r~Unable to load vehicle, please contact development!')
            return
        end
    end
    
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local Vehicle = CreateVehicle(Model, x + 3, y + 3, z + 1, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), Vehicle, -1)
    SetVehicleDirtLevel(Vehicle, 0)
    SetVehicleModKit(Vehicle, 0)
    SetVehicleMod(Vehicle, 23, -1, false)
    SetVehicleOnGroundProperly(Vehicle)
    SetModelAsNoLongerNeeded(Model)
    if Livery then
        SetVehicleLivery(Vehicle, Livery)
    end
    if Extras then
        for extraId = 0, 30 do
            if DoesExtraExist(Vehicle, extraId) then
                SetVehicleExtra(Vehicle, extraId, true)
            end
        end
        for _, extra in pairs(Extras) do
            SetVehicleExtra(Vehicle, extra, false)
        end
    end

    if Name then
        notify('~b~Vehicle Spawned: ~g~' .. Name)
    else
        notify('~b~Vehicle Spawned!')
    end
end