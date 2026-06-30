
-- Command handler for /anpr


local CameraTech = {
	plateinfo = {},
	mysqlready = false
}

-- Whitelist toggle
local useWhitelist = false

-- List of authorized Steam identifiers
local authorizedIdentifiers = {
    "steam:176561198263129997"
}

-- Authorization check function
function isAuthorized(player, callback)
    if not useWhitelist then return callback(true) end

    for _, id in ipairs(authorizedIdentifiers) do
        for _, pid in ipairs(GetPlayerIdentifiers(player)) do
            if pid == id then
                return callback(true)
            end
        end
    end

    return callback(false)
end

TriggerClientEvent("police:runCommand", playerId, "anpr")

function anprinterfacefunc(source, args, rawCommand)
    isAuthorized(source, function(auth, veh)
        if auth then
            TriggerClientEvent("CameraTech:MasterInterfaceToggle", source)
        else
            print(GetPlayerName(source) .. " is not ANPR trained.")
        end
    end)
end

function checkplatefunc(source, args, rawCommand)
	local plate = string.upper(table.concat(args, " "))
	plate = string.gsub(plate, "%s+", "")
	local markers = CameraTech.plateinfo[plate]
	if markers ~= nil then
		exports.NamelessNotify:display({type = "sucess", title = "SYSTEM", text = "Plate: " .. plate .. ". Markers: ".. markers, length = 4000})
	else
		exports.NamelessNotify:display({type = "sucess", title = "SYSTEM", text = "Plate: " .. plate .. ". No markers.", length = 4000})
	end	
end

function fixedanprfunc(source)
	isAuthorized(source, function(auth)
		if auth then
			TriggerClientEvent("CameraTech:FixedANPRToggle", source)
		else
			print(GetPlayerName(source) .. " is not ANPR trained.")
		end
	end)
end
 
function vehicleanprfunc(source)
	isAuthorized(source, function(auth)
		if auth then
			TriggerClientEvent("CameraTech:VehicleANPRToggle", source)
		else
			print(GetPlayerName(source) .. " is not ANPR trained.")
		end
	end)
end

function readplatefunc(source, args, rawCommand)
	TriggerClientEvent("CameraTech:ReadPlateInFront", source)
end

function focusanprfunc(source, args, rawCommand)
	if next(args) == nil then
		TriggerClientEvent("CameraTech:FocusANPR", source, nil)
	else
		local plate = string.upper(table.concat(args, " "))
		plate = string.gsub(plate, "%s+", "")
		TriggerClientEvent("CameraTech:FocusANPR", source, plate)
	end
end

function SanitizePlate(input)
	local plate = string.upper(input)
	plate = string.sub(plate, "")
end

function setplateinfofunc(source, args, rawCommand)
	local plateinfo = stringsplit(table.concat(args, " "), ";")
	plateinfo[1] = string.upper(plateinfo[1])
	plateinfo[1] = string.gsub(plateinfo[1], "%s+", "")
	if plateinfo[2] ~= nil then
		CameraTech.plateinfo[plateinfo[1]] = plateinfo[2]
		exports.NamelessNotify:display({type = "sucess", title = "SYSTEM", text = "Plate: " .. plateinfo[1] .. ". Info: " .. plateinfo[2], length = 4000})
		TriggerClientEvent("CameraTech:SyncPlateInfo", -1, CameraTech.plateinfo)
	elseif CameraTech.plateinfo[1] ~= nil then
		CameraTech.plateinfo = removeKey(CameraTech.plateinfo, plateinfo[1])
		if CameraTech.plateinfo == nil then
			CameraTech.plateinfo = {}
			exports.NamelessNotify:display({type = "error", title = "SYSTEM", text = "Plate: " .. plateinfo[1] .. ". No info.", length = 4000})
		end
		TriggerClientEvent("CameraTech:SyncPlateInfo", -1, CameraTech.plateinfo)
	end
end

function setvehinfofunc(source, args, rawCommand)	
	if next(args) == nil then
		TriggerClientEvent("CameraTech:ClUpdateVehicleInfo", source, nil)
	else
		local plateinfo = table.concat(args, " ")
		TriggerClientEvent("CameraTech:ClUpdateVehicleInfo", source, plateinfo)
	end
end

RegisterServerEvent("CameraTech:UpdateVehicleInfo")
AddEventHandler('CameraTech:UpdateVehicleInfo', function(plate, info)
	if info ~= nil then
		plateinfos[plate] = info
		TriggerEvent("CameraTech:PlateMarkerUpdate", source, plate, info)
		TriggerClientEvent("CameraTech:SyncPlateInfo", -1, plateinfos)
	else
		plateinfos = removeKey(plateinfos, plate)
		if plateinfos == nil then
			plateinfos = {}
		end
		TriggerEvent("CameraTech:PlateMarkerUpdate", source, plate, nil)
		TriggerClientEvent("CameraTech:SyncPlateInfo", -1, plateinfos)
	end
end)

RegisterServerEvent("CameraTech:UpdateAllPlateInfo")
AddEventHandler('CameraTech:UpdateAllPlateInfo', function(plateinfo)
	local newplateinfos = {}
	for _, v in ipairs(plateinfo) do
		if (v == nil or v.plate == nil or v.marker == nil) then
			print("CameraTech:UpdateAllPlateInfo error: no plate or marker specified")
		else
			local plate = string.upper(string.gsub(v.plate, "%s+", ""))
			newplateinfos[plate] = v.marker
		end
	end
	
	plateinfos = newplateinfos
	TriggerClientEvent("CameraTech:SyncPlateInfo", -1, plateinfos)
end)

print("CameraTech by Albo1125 (FiveM)")

function platesync()
	TriggerClientEvent("CameraTech:SyncPlateInfo", -1, plateinfos)
	SetTimeout(30000, platesync)
end
SetTimeout(1000, platesync)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

-- Remove key k (and its value) from table t. Return a new (modified) table.
function removeKey(t, k)
	local i = 0
	local keys, values = {},{}
	for k,v in pairs(t) do
		i = i + 1
		keys[i] = k
		values[i] = v
	end
 
	while i>0 do
		if keys[i] == k then
			table.remove(keys, i)
			table.remove(values, i)
			break
		end
		i = i - 1
	end
 
	local a = {}
	for i = 1,#keys do
		a[keys[i]] = values[i]
	end
 
	return a
end