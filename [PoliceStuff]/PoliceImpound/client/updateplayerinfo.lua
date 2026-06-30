RegisterNetEvent("NamelessCore:ReceivePlayerInfo")
AddEventHandler("NamelessCore:ReceivePlayerInfo", function(PlayerInfo)
    -- Basic validation for PlayerInfo structure
    if not PlayerInfo or type(PlayerInfo) ~= 'table' then
        print("NamelessCore:ReceivePlayerInfo received invalid PlayerInfo: Missing or invalid PlayerInfo table.")
        return
    end
    if not PlayerInfo.info or type(PlayerInfo.info) ~= 'table' then
        print("NamelessCore:ReceivePlayerInfo received invalid PlayerInfo: Missing or invalid PlayerInfo.info table.")
        return
    end

    -- Initialize LocalPlayer.state.NamelessCore if it doesn't exist
    -- This creates a dedicated section in the client's state bag for NamelessCore player data.
    LocalPlayer.state.NamelessCore = LocalPlayer.state.NamelessCore or {}

    -- Store the received player information in LocalPlayer.state.NamelessCore.
    -- This makes player data easily accessible to other client scripts in a consistent manner.
    -- Mapping core character data from CharacterCreations / NamelessFramework
    LocalPlayer.state.NamelessCore = {
        firstName = PlayerInfo.info.firstName or "Unknown",
        lastName  = PlayerInfo.info.lastName or "Unknown",
        citizenid = PlayerInfo.info.citizenid or "N/A",
        gender    = PlayerInfo.info.gender or 0,
        dob       = PlayerInfo.info.birthdate or "01-01-1900",
        nationality = PlayerInfo.info.nationality or "Unknown",
        callsign  = (PlayerInfo.metadata and PlayerInfo.metadata.callsign) or "N/A",
        -- Flag to indicate if this is a fresh character creation session
        isNew     = PlayerInfo.isNew or false 
    }
    
    -- Store job details, providing defaults if PlayerInfo.info.job is missing or incomplete.
    LocalPlayer.state.NamelessCore.job = {
        type = PlayerInfo.info.job and PlayerInfo.info.job.type or "unemployed",
        name = PlayerInfo.info.job and PlayerInfo.info.job.name or "unemployed",
        label = PlayerInfo.info.job and PlayerInfo.info.job.label or "Unemployed"
    }

    -- Debug logging for framework integration
    print(("^2[NamelessFramework]^7 Character Loaded: %s %s | CID: %s | Job: %s"):format(
        LocalPlayer.state.NamelessCore.firstName, 
        LocalPlayer.state.NamelessCore.lastName, 
        LocalPlayer.state.NamelessCore.citizenid, 
        LocalPlayer.state.NamelessCore.job.label
    ))

    TriggerServerEvent("GetServerObjects", 1, {
        playerData = {
            charsinfo = {
                firstName = LocalPlayer.state.NamelessCore.firstName,
                lastName  = LocalPlayer.state.NamelessCore.lastName,
                gender    = LocalPlayer.state.NamelessCore.gender,
                dob       = LocalPlayer.state.NamelessCore.dob
            },
            metadata = {
                callsign = LocalPlayer.state.NamelessCore.callsign,
                isNew    = LocalPlayer.state.NamelessCore.isNew
            },
            citizenid = LocalPlayer.state.NamelessCore.citizenid,
            job = LocalPlayer.state.NamelessCore.job
        }
    })

    -- If this is a new character from CharacterCreations, you might want to trigger skin loading here
    if LocalPlayer.state.NamelessCore.isNew then
        TriggerEvent("CharacterCreations:Client:NewCharacterSpawned")
    end
end)