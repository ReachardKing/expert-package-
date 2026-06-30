
config = {}

config.ImpoundLocations = {
    [1] = vector4(436.68, -1007.42, 27.32, 180.0),
    [2] = vector4(-436.14, 5982.63, 31.34, 136.0),
}
config.fee = 0

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
