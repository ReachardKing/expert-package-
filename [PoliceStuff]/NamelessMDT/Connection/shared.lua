
function GetResources()
    for resource, framework in pairs(mergeResource) do
        if GetResourceState(resource) then
            return ("bridge.standalone.%s.%s"):format(framework, lib.content), resource
        end
    end
    return ("bridge.standalone.%s.%s"):format(framework), "standalone"
end


local bridge, resource = GetResources
local blib = ox_lib

if lib.content == "server" then
    local resourceName = GetCurrentResourceName()
    local database = {
        "Connection/NamelessCore/records.sql",
        "Connection/NamelessCore/reports.sql",
        "Connection/NamelessCore/weapons.sql"
    }

    for i = 1, #database do
        local file = LoadResourceFile(resourceName, database)
        if file then MySQL.query(file) end
    end
end

Bridge = requires(bridge)