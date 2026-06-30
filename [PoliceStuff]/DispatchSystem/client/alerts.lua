-- alerts.lua (cleaned & fixed)
local Inventory = exports['inventory']

function GetPlayerHeading()
    local heading = GetEntityHeading(cache.ped)
	local direction = "Unknown"
    
	if heading >= 315 or heading < 45 then
		direction = "North"
	elseif heading >= 45 and heading < 135 then
		direction = "East"
	elseif heading >= 135 and heading < 225 then
		direction = "South"
	elseif heading >= 225 and heading < 315 then
        direction = "West"
    end
end

function GetLocalGender()
    local gender = 'male'
    if not gender then
       return gender == 'female'
    end
end

function GetIsHandcuffed()
    return IsPedHandcuffed(PlayerPedId())
end

function IsOnDuties(playerId)
  return exports["policetools"]:IsOnDuty(playerId)
end

---@return boolean
local function HasPhone()
    for _, item in ipairs(Config.PhoneItems) do
        if Inventory:tryToUseItem(item) then
            return true
        end
    end
    return false
end

---@param coords table
---@return string
function FoundStreet(coords)
    local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    return street .. ", " .. zone
end

---@param vehicle string
---@return string
local function getVehicleColor(vehicle)
    local vehicleColor1, vehicleColor2 = GetVehicleColours(vehicle)
    local color1 = Config.Colors[tostring(vehicleColor1)]
    local color2 = Config.Colors[tostring(vehicleColor2)]

    if color1 and color2 then
        return color2 .. " on " .. color1
    elseif color1 then
        return color1
    elseif color2 then
        return color2
    else
        return "Unknown"
    end
end

---@param vehicle string
---@return string
local function getVehicleDoors(vehicle)
    local doorCount = GetVehicleNumberOfDoors(vehicle)

    if doorCount == 2 then
        return locale('two_door')
    elseif doorCount == 3 then
        return locale('three_door')
    elseif doorCount == 4 then
        return locale('four_door')
    elseif doorCount == 5 then
        return locale('five_door')
    end

    return locale('unknown') or 'unknown'
end


---@param vehicle string
---@return table
function GetVehicleData(vehicle)
    local data = {}

    local vehicleClass = {
        [0] = 'compact',
        [1] = 'sedan',
        [2] = 'suv',
        [3] = 'coupe',
        [4] = 'muscle',
        [5] = 'sports_classic',
        [6] = 'sports',
        [7] = 'super',
        [8] = 'motorcycle',
        [9] = 'offroad',
        [10] = 'industrial',
        [11] = 'utility',
        [12] = 'van',
        [17] = 'service',
        [19] = 'military',
        [20] = 'truck'
    }

    data.class = vehicleClass[GetVehicleClass(vehicle)] or "Unknown"
    data.name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    data.plate = GetVehicleNumberPlateText(vehicle)
    data.doors = getVehicleDoors(vehicle)
    data.color = getVehicleColor(vehicle)
    data.id = NetworkGetNetworkIdFromEntity(vehicle)

    return data
end

function PhoneAnimation()
    lib.requestAnimDict("cellphone@in_car@ds", 500)

    if not IsEntityPlayingAnim(cache.ped, "cellphone@in_car@ds", "cellphone_call_listen_base", 3) then
        TaskPlayAnim(cache.ped, "cellphone@in_car@ds", "cellphone_call_listen_base", 3.0, 3.0, -1, 50, 0, false, false, false)
    end

    Wait(2500)
    StopEntityAnim(cache.ped, "cellphone_call_listen_base", "cellphone@in_car@ds", 3)
end

---@param message string
---@return boolean
function IsCallAllowed(message)
    local msgLength = string.len(message)

    if msgLength == 0 then return false end
    if GetIsHandcuffed() then return false end
    if Config.PhoneRequired and not HasPhone() then return false end

    return true
end

local weaponTable = {
    [584646201]   = "CLASS 2: AP-Pistol",
    [453432689]   = "CLASS 1: Pistol",
    [3219281620]  = "CLASS 1: Pistol MK2",
    [1593441988]  = "CLASS 1: Combat Pistol",
    [-1716589765] = "CLASS 1: Heavy Pistol",
    [-1076751822] = "CLASS 1: SNS-Pistol",
    [-771403250]  = "CLASS 2: Desert Eagle",
    [137902532]   = "CLASS 2: Vintage Pistol",
    [-598887786]  = "CLASS 2: Marksman Pistol",
    [-1045183535] = "CLASS 2: Revolver",
    [911657153]   = "Taser",
    [324215364]   = "CLASS 2: Micro-SMG",
    [-619010992]  = "CLASS 2: Machine-Pistol",
    [736523883]   = "CLASS 2: SMG",
    [2024373456]  = "CLASS 2: SMG MK2",
    [-270015777]  = "CLASS 2: Assault SMG",
    [171789620]   = "CLASS 2: Combat PDW",
    [-1660422300] = "CLASS 4: Combat MG",
    [3686625920]  = "CLASS 4: Combat MG MK2",
    [1627465347]  = "CLASS 4: Gusenberg",
    [-1121678507] = "CLASS 2: Mini SMG",
    [-1074790547] = "CLASS 3: Assaultrifle",
    [961495388]   = "CLASS 3: Assaultrifle MK2",
    [-2084633992] = "CLASS 3: Carbinerifle",
    [4208062921]  = "CLASS 3: Carbinerifle MK2",
    [-1357824103] = "CLASS 3: Advancedrifle",
    [-1063057011] = "CLASS 3: Specialcarbine",
    [2132975508]  = "CLASS 3: Bulluprifle",
    [1649403952]  = "CLASS 3: Compactrifle",
    [100416529]   = "CLASS 4: Sniperrifle",
    [205991906]   = "CLASS 4: Heavy Sniper",
    [177293209]   = "CLASS 4: Heavy Sniper MK2",
    [-952879014]  = "CLASS 4: Marksmanrifle",
    [487013001]   = "CLASS 2: Pumpshotgun",
    [2017895192]  = "CLASS 2: Sawnoff Shotgun",
    [-1654528753] = "CLASS 3: Bullupshotgun",
    [-494615257]  = "CLASS 3: Assaultshotgun",
    [-1466123874] = "CLASS 3: Musket",
    [984333226]   = "CLASS 3: Heavyshotgun",
    [-275439685]  = "CLASS 2: Doublebarrel Shotgun",
    [317205821]   = "CLASS 2: Autoshotgun",
    [-1568386805] = "CLASS 5: GRENADE LAUNCHER",
    [-1312131151] = "CLASS 5: RPG",
    [125959754]   = "CLASS 5: Compactlauncher"
}

function GetWeaponName()
    local currentWeapon = GetSelectedPedWeapon(cache.ped)
    return weaponTable[currentWeapon] or "Unknown"
end

local function safeBool(a, b)
    if a ~= nil then return a end
    if b ~= nil then return b end
    return false
end

-- Helper to safely get player name/callsign if PlayerInfo not available
local function getPlayerInfoFields(data)
    local name = ""
    local callsign = nil
    if data and data.PlayerInfo then
        local p = data.PlayerInfo
        name = (p.firstname or "") .. " " .. (p.lastname or "")
        if p.metaData then callsign = p.metaData["callsign"] end
    end
    return name, callsign
end

-- Main dispatcher (keeps original signature)
function DispatchAlerts(data)
    data = data or {}
    local coords = data.coords or vector3(0.0,0.0,0.0)
    local gender = data.gender or GetLocalGender()
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = data.customName or "",
        message = data.message or "",
        icon = data.icon or "fa-question",
        priority = data.priority or 2,
        callID = data.callID or nil,
        Enmergency = data.Enmergency,
		Street = FoundStreet(coords),
        camId = data.camId or nil,
        RadioCode = data.RadioCode or " ",
        coords = coords,
        gender = gender,
        color = data.color or nil,
        callsign = data.callsign or nil,
        officername = data.officername or nil,
        vehiclename = data.vehiclename or nil,
        vehmodel = data.model or nil,
        plate = data.plate or nil,
        alerttime = data.alertTime or config and config.alertTime or 10,
        doorcount = data.doorcount or nil,
        alert = {
            radius = data.radius or 0,
            recipientList = ispolice,
            sprite = data.sprite or 1,
            color = data.color or 1,
            scale = data.scale or 0.5,
            length = data.length or 2,
            sound = data.sound or "lose_1st",
            sound2 = data.sound2 or "GTO_FM_Event_soundset",
            offset = data.offset or false,
            flash = data.flash or false,
        }
    }
    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end

exports("DispatchAlerts", DispatchAlerts)

-- Stolen vehicle
function StolenVehicle(data, vehicle)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local v = vehicle or {}
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Vehicle Theft",
        message = "Stolen vehicle",
        RadioCode = "10-16",
        icon = "fas fa-car-burst",
        priority = 2,
        coords = coords,
        street = FoundStreet(coords),
        heading = GetEntityHeading(PlayerPedId()) or 0.0,
        vehicle = v.name or v.model or "unknown",
        plate = v.plate or nil,
        color = data.color or v.color,
        class = data.class or v.class,
        doors = data.doors or v.doors,
        alerttime = data.alertTime or config and config.alertTime or 10,
        ispolice = ispolice
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("StolenVehicle", StolenVehicle)

-- Shots fired (fixed names/typos)
function IsPedShoting(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        message = "Shots fired",
        icon = 'fas fa-gun',
        priority = 1,
        street = FoundStreet(coords),
        weapon = GetWeaponName and GetWeaponName() or nil,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10,
        coords = coords
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("IsPedShoting", IsPedShoting)

-- Hunting (shots reported while hunting)
function Hunting(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        message = "I heard shots fired",
        RadioCode = "10-13",
        icon = 'fas fa-gun',
        priority = 2,
        weapon = GetWeaponName and GetWeaponName(PlayerPedId()) or nil,
        gender = GetLocalGender(),
        coords = coords,
        street = FoundStreet(coords),
        alerttime = data.alertTime or config and config.alertTime or 10,
        ispolice = ispolice
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("Hunting", Hunting)

-- Speeding vehicle
function SpeedingVehicle(data)
    data = data or {}
    local coords = GetEntityCoords(cache and cache.ped or PlayerPedId())
    local vehicle = data.vehicle or {}
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Speeding Vehicle",
        message = "Speeding vehicle",
        RadioCode = "10-80",
        icon = 'fas fa-car',
        priority = 2,
        coords = coords,
        heading = GetEntityHeading(cache and cache.ped or PlayerPedId()) or 0.0,
        vehicle = vehicle.name or vehicle.model or "unknown",
        plate = vehicle.plate or nil,
        color = vehicle.color or nil,
        class = vehicle.class or nil,
        doors = vehicle.doors or nil,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("SpeedingVehicle", SpeedingVehicle)

-- Fight in progress
function FightInProgress(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Fight in progress",
        message = "People are fighting",
        RadioCode = "10-10",
        icon = 'fas fa-hand-fist',
        priority = 2,
        coords = coords,
        street = FoundStreet(coords),
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("FightInProgress", FightInProgress)

-- Prison break
function PrisonBreak(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Prison Break",
        message = "Prison Break",
        RadioCode = "10-21",
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        street = FoundStreet(coords),
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("PrisonBreak", PrisonBreak)

-- Store robbery
function StoreRobbery(data, camid)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        message = "Store robbery in progress",
        RadioCode = "10-68",
        icon = 'fas fa-store',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        camid = camid,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("StoreRobbery", StoreRobbery)

-- Fleeca bank robbery
function FleecaBankRobbery(data, camid)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
		codeName = "Fleeca bank",
        message = "The Fleeca is being robbed!",
        RadioCode = "10-68",
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        camid = camid,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }
    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("FleecaBankRobbery", FleecaBankRobbery)

-- Paleto bank robbery
function PaletoBankRobbery(data, camid)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Paleto Bank",
        message = "Paleto Bank robbery in progress",
        RadioCode = "10-68",
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        camid = camid,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("PaletoBankRobbery", PaletoBankRobbery)

-- Pacific bank robbery
function pacificbankrobbery(data, camid)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
		codeName = "Pacific standard Bank",
        message = "Robbery in progress",
        RadioCode = "10-68",
        icon = 'fas fa-vault',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        camid = camid,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }
    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("pacificbankrobbery", pacificbankrobbery)

-- Vangelico robbery
function VangelicoRobbery(data, camid)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Vangelico Robbery",
        message = "Robbery in progress",
        RadioCode = "10-68",
        icon = 'fas fa-ring',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        camid = camid,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }
    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("VangelicoRobbery", VangelicoRobbery)

-- House robbery
function HouseRobbery(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "House Robbery",
        message = "Robbery in progress",
        RadioCode = "10-68",
        icon = 'fas fa-house',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }
    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("HouseRobbery", HouseRobbery)

-- Drug sales
function DrugSales(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Drug Sales",
        message = "Suspicious hand off",
        RadioCode = "10-17",
        icon = 'fas fa-tablets',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }
    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("DrugSales", DrugSales)

-- Suspicious activity
function SuspiciousActivity(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Suspicious Activity",
        message = "Someone is being suspicious",
        RadioCode = "10-17",
        icon = 'fas fa-user-secret',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("SuspiciousActivity", SuspiciousActivity)

-- Carjacking
function CarJacking(data, vehicle)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local v = vehicle or {}
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        message = "Someone is stealing a vehicle",
        RadioCode = "10-16",
        icon = 'fas fa-car',
        priority = 2,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        vehiclename = v.name or v.model,
        plate = v.plate or nil,
        color = v.color or nil,
        class = v.class or nil,
        doors = v.doors or nil,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("CarJacking", CarJacking)

-- Injured person
function InjuriedPerson(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Injured person",
        message = "I think someone might be dead!",
        RadioCode = "10-44",
        icon = 'fas fa-face-dizzy',
        priority = 1,
        coords = coords,
        gender = GetLocalGender(),
        Street = FoundStreet(coords),
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("InjuriedPerson", InjuriedPerson)

-- Deceased person
function DeceasedPerson(data)
    data = data or {}
    local coords = GetEntityCoords(cache and cache.ped or PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Deceased Person",
        message = "Someone has died",
        RadioCode = "11-44",
        icon = 'fas fa-skull',
        coords = coords,
        street = FoundStreet(coords),
        alerttime = data.alertTime or 10,
        ispolice = ispolice
    }
    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("DeceasedPerson", DeceasedPerson)

-- Explosion
function Explosion(data)
    data = data or {}
    local coords = GetEntityCoords(PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Use of explosives",
        message = "I saw someone with materials in their hands.",
        RadioCode = "10-17",
        priority = 1,
        coords = coords,
        Street = FoundStreet(coords),
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("Explosion", Explosion)

-- Officer downed
function Officerdowned(data)
    data = data or {}
    local coords = GetEntityCoords(cache and cache.ped or PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)
    local name, callsign = getPlayerInfoFields(data)

    local dispatch_data = {
        CodeName = "Officer Down",
        message = "Officer down",
        RadioCode = "10-44",
        priority = 1,
        coords = coords,
        gender = GetLocalGender(),
        street = FoundStreet(coords),
        name = name,
        callsign = callsign or data.callsign,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("Officerdowned", Officerdowned)

-- EMS down (same signature as Officerdowned)
function EMSDown(data)
    data = data or {}
    local coords = GetEntityCoords(cache and cache.ped or PlayerPedId())
    local ispolice = safeBool(data.ispolice, data.police)
    local name, callsign = getPlayerInfoFields(data)

    local dispatch_data = {
        CodeName = "EMS Down",
        message = "EMS down",
        RadioCode = "10-44",
        priority = 1,
        coords = coords,
        gender = GetLocalGender(),
        street = FoundStreet(coords),
        name = name,
        callsign = callsign or data.callsign,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("EMSDown", EMSDown)

-- Car boosting
function CarBoosting(data, vehicle)
    data = data or {}
    local coords = GetEntityCoords(cache and cache.ped or PlayerPedId())
    local v = vehicle or {}
    local ispolice = safeBool(data.ispolice, data.police)

    local dispatch_data = {
        CodeName = "Car Boosting",
        message = "Car boosting in progress",
        RadioCode = "10-17",
        priority = 1,
        coords = coords,
        gender = GetLocalGender(),
        street = FoundStreet(coords),
        heading = GetEntityHeading(cache and cache.ped or PlayerPedId()) or 0.0,
        vehiclename = v.name or v.model,
        color = v.color,
        class = v.class,
        doors = v.doors,
        ispolice = ispolice,
        alerttime = data.alertTime or config and config.alertTime or 10
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end
exports("CarBoosting", CarBoosting)

-- Phone call helper (cleaned)
function PhoneCall(message, anonymousNumber, jobFlag, callType)
    local coords = GetEntityCoords(cache and cache.ped or PlayerPedId())

    -- Play phone animation twice like original
    if PhoneAnimation then
        PhoneAnimation()
        PhoneAnimation()
    end

    -- CodeName from type (callType)
    local codeName = nil
    if callType == "311" then codeName = "311" end
    if callType == "911" then codeName = "911" end
    if callType == "211" then codeName = "211" end

    local dispatch_data = {
        message = message or "",
        CodeName = codeName or "",
        icon = "fas fa-phone",
        priority = 2,
        coords = coords,
        number = anonymousNumber,
        information = message,
        street = FoundStreet(coords),
        alerttime = config and config.alertTime or 10,
        job = jobFlag
    }

    TriggerServerEvent("DispatchSystem:Notify", dispatch_data)
end

-- Event handler wrapper kept, fixed job table and call to PhoneCall
AddEventHandler("DispatchSystem:sendMessage", function(data, callType, anonymous)
    data = data or {}
    local job = { ["911"] = data.ispolice, ["311"] = not data.ispolice, ["211"] = not data.ispolice }
    PhoneCall(data.message or "", anonymous or data.number or "", job[callType], callType)
end)

-- Register 311 command (fixed function name and capitalization)
RegisterCommand("311r", function()
    -- call PhoneCall with a sample 311 message if needed; preserve original behavior to show notification
    PhoneCall("311 report", "anonymous", false, "311")
    TriggerEvent("show311Notification")
end)
