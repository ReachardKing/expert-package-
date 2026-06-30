

local playerInfo = {
    charsinfo = {
        firstname = "",
        lastname  = "",
    },
    metadata = {
        callsign = "",
        rank = "",
        job = ""
    },
    citizenid = ""
}

RegisterNetEvent("NamelessCore:ReceiveplayerInfo")
AddEventHandler("NamelessCore:ReceiveplayerInfo", function()
    SendNUIMessage({
        type = "Status",
        visible = true,

        name = playerInfo.charsinfo.firstName .. " " .. playerInfo.charsinfo.lastName,
        job = playerInfo.metadata.job, -- if you have one
        rank = playerInfo.metadata.rank,

        signature = playerInfo.metadata.callsign or ('%s %s'):format(playerInfo.charsinfo.firstName, playerInfo.charsinfo.lastName),
        
        date = os.date("%d/%m/%Y"),
        time = os.date("%H:%M:%S"),
--        day = days[os.date("*t").wday]
    })
end)
