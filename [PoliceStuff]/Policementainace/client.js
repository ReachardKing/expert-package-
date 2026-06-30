
const Delay = (ms) => new Promise(res => setTimeout(res, ms));

let visible = false;

function toggleVisible(force) {
    if (typeof force === 'boolean') {
        visible = force;
    } else {
        visible = !visible;
    }

    SetNuiFocus(visible, visible);

    SendNuiMessage(JSON.stringify({
        visible
    }));
}

toggleVisible(false);

setTick(() => {  
    const [playerX, playerY, playerZ] = GetEntityCoords(PlayerPedId());

    const policeStations = [
        { x: -458.33, y: 6031.84, z: 31.49 },      // Paleto
        { x: 458.09, y: -1017.29, z: 28.26 },     // MRPD
        { x: 565.57, y: 3.71, z: 102.23 },      // MRPD Rooftop
        {x: 463.86, y: -982.43, z: 42.69},      // MRPD Rooftope #2
        { x: 382.97, y: -1611.84, z: 29.29 },      // Davis
        { x: 1859.11, y: 3681.72, z: 33.82 },      // Sandy shores
        { x: 864.89, y: -1337.49, z: 26.03 },      // Lamesa
        { x: -1125.53, y: -832.96, z: 13.37 },     // Vespucci
        { x: 556.70, y: 6.64, z: 103.23 },          // Vinewood
        { x: 535.28, y: -21.83, z: 69.63 },     // Vinewood #2
	]
	const Fixitareas = [
        // fixitarea 
        { x: 445.78, y : -1025.28, z: 28.65}, // MRPD Station.
        { x: 438.3, y: -1027.93, z: 28.8}, // MRPD Station.
        { x: 434.98, y: -1026.61, z: 28.46,  h: 185.99}, // MRPD
        { x: 431.26, y: -1027.31, z: 28.53,  h: 185.59}, // MRPD
        { x: 427.52, y: -1026.84, z:  28.58, h: 184.25}, // MRPD
        { x: 442.22, y: -1026.63, z: 28.72}, // MRPD Shores.
        { x: 579.93,  y: 12.23, z: 103.23}, // MRPD Roof.#2
        { x: 449.1,   y: -981.41, z: 42.69}, // MRPD Rooftop 
        { x: 396.34,  y: -1644.28, z: 28.86,  h: 319.10}, // Davis Garage y: 
        { x: 398.56,  y: -1646.42, z: 28.8616, h: 319.18}, // Davis Garage
        { x: 400.68,  y: -1648.86, z: 28.86, h: 140.78}, // Davis Garage
        { x: 403.32,  y: -1650.54, z:28.86,  h: 319.92}, // Davis Garage
        { x: 403.21,  y: -1650.68, z: 28.86,  h: 139.40}, // Davis Garage
        { x: 1872.08, y:  3687.24, z: 33.31}, // Sandy Station.
        { x: 870.6,  y: -1350.41, z: 26.06}, // La Mesa station
        { x: -474.35,  y:  6034.4, z: 31.11}, // Paleto station
        { x: 533.83,  y: -26.17, z: 70.63}, // Vine wood PD
        { x: 530.74,  y: -29.19, z: 70.63}, // Vine wood PD
        { x: -1107.52, y:  -800.54, z: 17.17}, // Vespucci wood PD
        { x: -1110.42, y:  -802.26, z: 16.91}, // Vespucci wood PD
    ];

    for (const station of policeStations) {
        if (GetDistanceBetweenCoords(playerX, playerY, playerZ, station.x, station.y, station.z, false) <= 2.0) {
            if ( IsControlJustPressed(0, 38)) {
                toggleVisible(true);
            }
        }
    }
	
	for (const fixststus of Fixitareas) {
		if (GetDistanceBetweenCoords(playerX, playerY, playerZ, fixststus.x, fixststus.y, fixststus.z, false) <= 2.0) {
            if (IsControlJustPressed(0, 38) && IsPedInAnyPoliceVehicle(PlayerPedId(), false)) {
                toggleVisible(true);
            }
        }
	}
})

RegisterNuiCallbackType('Click');
on('__cfx_nui:Click', async (data) => {
    toggleVisible(false)

    const hash = GetHashKey(data.hash);
    const playerPed = PlayerPedId();

    RequestModel(hash);

    while (!HasModelLoaded(hash)) {
        await Delay(10)
    }

    if (hash === GetHashKey("polmav")) {

        const heli = CreateVehicle(
            hash,
            449.1,  -981.41, 42.69,
            GetEntityHeading(playerPed),
            true, false
        );

        SetModelAsNoLongerNeeded(hash);
        SetVehicleOnGroundProperly(heli);
        SetVehicleEngineOn(heli, true, false, true);
        SetPedIntoVehicle(playerPed, heli, -1);
        return;   // <// IMPORTANT
    }

    // Assign proper values for number, ModType, Colours, and Mod
    const number = 1;
    const ModType = 0; // Example mod type, adjust as needed
    const Colours = 0; // Example color, adjust as needed
    const Mod = 0;     // Example mod, adjust as needed

    const [playerX, playerY, playerZ] = GetEntityCoords(playerPed);
    const vehicle = CreateVehicle(hash, playerX , playerY, playerZ, GetEntityHeading(playerPed), true, false);
    
    SetVehicleOnGroundProperly(hash)

    SetModelAsNoLongerNeeded(vehicle);
    SetPedIntoVehicle(playerPed, vehicle, -1)
    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 23, -1, false)
    SetVehicleOnGroundProperly(vehicle)
    SetModelAsNoLongerNeeded(vehicle)
    SetVehicleEngineOn(vehicle, true, false, true)
    ClearAreaOfVehicles(playerX, playerY, playerZ, 10.0, false, false, false, false, false)

    SetVehicleColours(vehicle, Colours, Colours)
    SetVehicleXenonLightsColor(vehicle, Mod)

    SetVehRadioStation(vehicle, "OFF")

    const bestMod = GetNumVehicleMods(vehicle, ModType) - 1
    SetVehicleMod(vehicle, ModType, bestMod, false)

    SetVehicleLivery(vehicle, number)

    SetVehicleExtra(vehicle, number, 0)

})

RegisterNuiCallbackType("both")
on('__cfx_nui:both', async (data) => {
    toggleVisible(false)
    const Number = data.others
    const vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleLivery(vehicle, Number)
    SetVehicleExtra(vehicle, Number, 0)
})

RegisterNuiCallbackType('fixit');
on('__cfx_nui:fixit', async () => {
    toggleVisible(false)
    SetVehicleDeformationFixed(GetVehiclePedIsIn(PlayerPedId(), false))
    SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(), false), 0)
    SetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false), 1000.0)
    SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), false))
})
RegisterNuiCallbackType('deleteveh');
on('__cfx_nui:deleteveh', async () => {
    toggleVisible(false)
    const Handle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetEntityAsMissionEntity(Handle, true, true)
    SetEntityAsNoLongerNeeded(Handle)
    DeleteEntity(Handle)
})
RegisterNuiCallbackType('CancelButton');
on('__cfx_nui:CancelButton', async () => {
    toggleVisible(false)
})