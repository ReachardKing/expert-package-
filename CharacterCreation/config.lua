config = {}
config = {}

config.permissions = {
    ["SAHP"] = {
        "1218173199477375067",
        "1218173199477375067",
    },
    
    ["SASP"] = {
        "1218173449596440647",
        "1218173449596440647"
    },
    ["LSPD"] = {
        "1218173006866546761",
        "1218173006866546761",
    },
    
    ["BCSO"] = {
        "1218185033165312071",
        "1218185033165312071",
    },
    
    ["LSFD"] = {
        "1218185279102255186",
        "1218185279102255186",
    }
}

config.salaries = {
    ["default"] = {-- default salary characters receive with none of these jobs.
        enabled = true,
        interval = 24,
        amount = 300
    },
    ["sahp"] = {
        enabled = true,
        interval = 24,
        amount = 700
    },
    ["lspd"] = {
        enabled = true,
        interval = 24,
        amount = 600
    },
    ["bcso"] = {
        enabled = true,
        interval = 24,
        amount = 500
    },
    ["lsfd"] = {
        enabled = true,
        interval = 24,
        amount = 800
    }
}

config.spawns = {
    ["default"] = {-- default spawns will show for everyone, if a character has a job it will show job spawns and this.
        {label = "Dream View Motel (Paleto Bay)", coords = vec3(-102.78, 6336.28, 31.49)},
        {label = "Eastern Motel (Sandy Shores)", coords = vec3(343.53, 2636.94, 43.94)},
        {label = "Legion Square", coords = vec3(196.96, -934.54, 29.69)},
        {label = "Del Perro Pier", coords = vec3(-1616.69, -1073.81, 12.15)},
        {label = "LSIA", coords = vec3(-1039.65, -2741.02, 12.89)}
    },
    
    ["SAHP"] = {
        {label = "Mission Row Police Department", coords = vec3(445.202, 6014.36, 31.7164)}, -- MRPD
        {label = "Paleto Bay Police Department", coords = vec3(445.202, 6014.36, 31.7164)}, -- Paleto Bay Station
        {label = "Sandy Shores Police Department", coords = vec3(1854.21, 3685.51, 34.2671)}, -- Sand Shores Station
        {label = "VineWood Police Department", coords = vec3(535.85, 21.64, 70.63)}, -- VineWood Station
        {label = "Vespucci Police Department", coords = vec3(-1125.53, -832.96, 13.37)}, -- Vespucci Station
        {label = "Davis Police Department", coords = vec3(360.624, 1584.47, 29.2919)}, -- Davis Station
        {label = "Lamesa Police Department", coords = vec3(825.987, 1290.03, 28.2407)}, -- Lamesa Station
        {label = "Mission Row Police Department", coords = vec3(1853.16, 3687.39, 34.27)}, -- MRPD Station
        -- { x=-445.71, y=6013.67, z=31.72}, -- Paire Station
        -- { x=446.19, y=-984.9, z=30.69}, -- Senora Station
        {label = "Island Police Department", coords = vec3(-1633.48, -1020.35, 13.15)}, -- Island Station
        {label = "Park Rangers Head Quarters", coords = vec3(2744.73, 3473.68, 55.65)}, -- Park Rangers HQ
        {label = "Rockford Hills Head Quarters", coords = vec3(-331.58, -2792.3, 5.18)}, -- Rockford Station
        {label = "FIB Station", coords = vec3(379.13, 792.57, 190.41)}, -- FIB Station
    -- { x=-562.19, y=-131.18, z=38.43}, -- Highway Station
    -- { x=2475.65, y=-384.43, z=94.4}, -- GrapeSeed Station
    },
    
    ["LSPD"] = {
        {label = "Mission Row Police Department", coords = vec3(445.202, 6014.36, 31.7164)}, -- MRPD
        {label = "Paleto Bay Police Department", coords = vec3(445.202, 6014.36, 31.7164)}, -- Paleto Bay Station
        {label = "Sandy Shores Police Department", coords = vec3(1854.21, 3685.51, 34.2671)}, -- Sand Shores Station
        {label = "VineWood Police Department", coords = vec3(535.85, 21.64, 70.63)}, -- VineWood Station
        {label = "Vespucci Police Department", coords = vec3(-1125.53, -832.96, 13.37)}, -- Vespucci Station
        {label = "Davis Police Department", coords = vec3(360.624, 1584.47, 29.2919)}, -- Davis Station
        {label = "Lamesa Police Department", coords = vec3(825.987, 1290.03, 28.2407)}, -- Lamesa Station
        {label = "Mission Row Police Department", coords = vec3(1853.16, 3687.39, 34.27)}, -- MRPD Station
        -- { x=-445.71, y=6013.67, z=31.72}, -- Paire Station
        -- { x=446.19, y=-984.9, z=30.69}, -- Senora Station
        {label = "Island Police Department", coords = vec3(-1633.48, -1020.35, 13.15)}, -- Island Station
        {label = "Park Rangers Head Quarters", coords = vec3(2744.73, 3473.68, 55.65)}, -- Park Rangers HQ
        {label = "Rockford Hills Head Quarters", coords = vec3(-331.58, -2792.3, 5.18)}, -- Rockford Station
        {label = "FIB Station", coords = vec3(379.13, 792.57, 190.41)}, -- FIB Station
    -- { x=-562.19, y=-131.18, z=38.43}, -- Highway Station
    -- { x=2475.65, y=-384.43, z=94.4}, -- GrapeSeed Station
    },
    
    ["BCSO"] = {
        {label = "Mission Row Police Department", coords = vec3(445.202, 6014.36, 31.7164)}, -- MRPD
        {label = "Paleto Bay Police Department", coords = vec3(445.202, 6014.36, 31.7164)}, -- Paleto Bay Station
        {label = "Sandy Shores Police Department", coords = vec3(1854.21, 3685.51, 34.2671)}, -- Sand Shores Station
        {label = "VineWood Police Department", coords = vec3(535.85, 21.64, 70.63)}, -- VineWood Station
        {label = "Vespucci Police Department", coords = vec3(-1125.53, -832.96, 13.37)}, -- Vespucci Station
        {label = "Davis Police Department", coords = vec3(360.624, 1584.47, 29.2919)}, -- Davis Station
        {label = "Lamesa Police Department", coords = vec3(825.987, 1290.03, 28.2407)}, -- Lamesa Station
        {label = "Mission Row Police Department", coords = vec3(1853.16, 3687.39, 34.27)}, -- MRPD Station
        -- { x=-445.71, y=6013.67, z=31.72}, -- Paire Station
        -- { x=446.19, y=-984.9, z=30.69}, -- Senora Station
        {label = "Island Police Department", coords = vec3(-1633.48, -1020.35, 13.15)}, -- Island Station
        {label = "Park Rangers Head Quarters", coords = vec3(2744.73, 3473.68, 55.65)}, -- Park Rangers HQ
        {label = "Rockford Hills Head Quarters", coords = vec3(-331.58, -2792.3, 5.18)}, -- Rockford Station
        {label = "FIB Station", coords = vec3(379.13, 792.57, 190.41)}, -- FIB Station
    -- { x=-562.19, y=-131.18, z=38.43}, -- Highway Station
    -- { x=2475.65, y=-384.43, z=94.4}, -- GrapeSeed Station
    },
    
    ["LSFD"] = {
        {label = "Davis Fire Station", x = 215.786, y = -1642.49, z = 29.7138}, -- Davis Fire Station
        {label = "Fire Station Srven", x = 1202.38, y = -1460.13, z = 34.7642}, -- Fire Station Srven
        {label = "Los Santos City Fire Department", x = -1087.93, y = -2374.1, z = 13.9451}, -- Los Santos City Fire Department
        {label = "Paleto Fire Station NO1", x = -379.942, y = 6118.73, z = 31.8456}, -- Paleto Fire Station NO1
        {label = "Fire Department Head Quarters", x = -635.992, y = -121.635, z = 39.0138}, -- Fire Department Head Quarters
        {label = "Sandy Fire Station", x = 1697.26, y = 3585.46, z = 35.5443}, -- Sandy Fire Station
        {label = "Fort Zancudo Fire Station ", x = -2113.74, y = 2831.58, z = 32.8093}, -- Fort Zancudo Fire Station
        {label = "Grapeseed Fire Station", x = 1778.85, y = 4601.99, z = 37.72}, -- Grapeseed Fire Station
    }
}