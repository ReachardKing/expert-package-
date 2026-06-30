--================================--
--       POLICE TOOLS v1.1.6      --
--            by GIMI             --
--      License: GNU GPL 3.0      --
--================================--

Config = {}

Config.Tint = {
    allowed = { -- Set any of these to false to be shown as illegal by the script
        true, -- Stock
        true, -- None
        false, -- Pure Black
        true, -- Dark Smoke
        true, -- Light Smoke
        true, -- Stock
        true, -- Limo
        true -- Green
    }
}

Config.UnitsRadar = {
    callsigns = { -- callsign will be shown on the map and remains empty until set
    },
    colors = {
        63, -- Type 1 (set above to callsign prefix "L")
        25, -- Type 2
        18, -- etc.
        82,
        65
    },
    panicColor = 10, -- The color of the route to a panic - set to false or nil if you don't want to enable /panic; See "HUD Colors" (https://wiki.rage.mp/index.php?title=Fonts_and_Colors)
    customworks = false, -- Set to either false || true
    bigmapKey = false, -- Set to a specific key to automatically bind the extend / shrink functionality of the minimap; Set to false if you don't want to use the functionality; Set to true if you don't want to set default keybind
    usePlayerBlips = true, -- When true, the script will only show blips for distant players (OneSync Infinity/Beyond)
    announceDuty = false, -- Set to true if you want to send every unit a message about other units going on/off duty
}

Config.resources = {
	whitelisted = {
		"974695925735903303", -- Police
		"974695925735903303", -- EMS
		"1314247106600636568", -- Publick works
	},
	doorList = {
		---------------------
		-- Sandy Shores PD --
		---------------------
		-- Right Door to Stairs
		[1] = { 
			["objName"] = "v_ilev_rc_door2", 
			["x"] = 1849.982, 
			["y"] = 3684.115, 
			["z"] = 34.41656, 
			["locked"] = true, 
			["distance"] = 2
		},
		-- Left Door to Stairs
		[2] = { 
			["objName"] = "v_ilev_rc_door2", 
			["x"] = 1851.288, 
			["y"] = 3681.87, 
			["z"] = 34.41656, 
			["locked"] = true, 
			["distance"] = 2
		},
		-- Cell Gate to Cell Block
		[3] = { 
			["objName"] = "v_ilev_ph_cellgate", 
			["x"] = 1859.697, 
			["y"] = 3686.644, 
			["z"] = 30.40922, 
			["locked"] = true, 
			["distance"] = 2
		},
		-- Cell 1
		[4] = { 
			["objName"] = "v_ilev_ph_cellgate", 
			["x"] = 1862.763, 
			["y"] = 3688.414, 
			["z"] = 30.40922, 
			["locked"] = true, 
			["distance"] = 2
		},
		-- Cell 2
		[5] = { 
			["objName"] = "v_ilev_ph_cellgate", 
			["x"] = 1860.898, 
			["y"] = 3691.643, 
			["z"] = 30.40922, 
			["locked"] = true, 
			["distance"] = 2
		},
		-- Cell 3
		[6] = { 
			["objName"] = "v_ilev_ph_cellgate", 
			["x"] = 1858.998, 
			["y"] = 3694.937, 
			["z"] = 30.40922, 
			["locked"] = true, 
			["distance"] = 2
		},
		-- Single Door to Back
		[7] = { 
			["objName"] = "v_ilev_rc_door2", 
			["x"] = 1857.254, 
			["y"] = 3690.296, 
			["z"] = 34.41842, 
			["locked"] = true, 
			["distance"] = 2
		},
		-- Right Door to Back
		[8] = { 
			["objName"] = "v_ilev_rc_door2", 
			["x"] = 1849.4, 
			["y"] = 3691.206, 
			["z"] = 34.41842, 
			["locked"] = true, 
			["distance"] = 2
		},
		-- Left Door to Back
		[9] = { 
			["objName"] = "v_ilev_rc_door2", 
			["x"] = 1847.133, 
			["y"] = 3689.946, 
			["z"] = 34.41842, 
			["locked"] = true, 
			["distance"] = 2
		},
		
		---------------------
		-- MRPD Station --
		---------------------
		-- Mission Row To locker room & roof
		[10] = { ["objName"] = "v_ilev_ph_gendoor004", ["x"]= 449.69815063477, ["y"]= -986.46911621094,["z"]= 30.689594268799,["locked"]= true,["txtX"]=450.104,["txtY"]=-986.388,["txtZ"]=31.739},
		-- Mission Row Armory
		[11] = { ["objName"] = "v_ilev_arm_secdoor", ["x"]= 452.61877441406, ["y"]= -982.7021484375,["z"]= 30.689598083496,["locked"]= true,["txtX"]=453.079,["txtY"]=-982.600,["txtZ"]=31.739},
		-- Mission Row Captain Office
		[12] = { ["objName"] = "v_ilev_ph_gendoor002", ["x"]= 447.23818969727, ["y"]= -980.63006591797,["z"]= 30.689598083496,["locked"]= true,["txtX"]=447.200,["txtY"]=-980.010,["txtZ"]=31.739},
		-- Mission Row To downstairs right
		[13] = { ["objName"] = "v_ilev_ph_gendoor005", ["x"]= 443.97, ["y"]= -989.033,["z"]= 30.6896,["locked"]= true,["txtX"]=444.020,["txtY"]=-989.445,["txtZ"]=31.739},
		-- Mission Row To downstairs left
		[14] = { ["objName"] = "v_ilev_ph_gendoor005", ["x"]= 445.37, ["y"]= -988.705,["z"]= 30.6896,["locked"]= true,["txtX"]=445.350,["txtY"]=-989.445,["txtZ"]=31.739},
		-- Mission Row Main cells
		[15] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 463.815, ["y"]= -992.686,["z"]= 24.9149,["locked"]= true,["txtX"]=463.815,["txtY"]=-992.686,["txtZ"]=25.064},
		-- Mission Row Cell 1
		[16] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.381, ["y"]= -993.651,["z"]= 24.9149,["locked"]= true,["txtX"]=461.806,["txtY"]=-993.308,["txtZ"]=25.064},
		-- Mission Row Cell 2
		[17] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.331, ["y"]= -998.152,["z"]= 24.9149,["locked"]= true,["txtX"]=461.806,["txtY"]=-998.800,["txtZ"]=25.064},
		-- Mission Row Cell 3
		[18] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.704, ["y"]= -1001.92,["z"]= 24.9149,["locked"]= true,["txtX"]=461.806,["txtY"]=-1002.450,["txtZ"]=25.064},
		-- Mission Row Backdoor in
		[19] = { ["objName"] = "v_ilev_gtdoor", ["x"]= 464.126, ["y"]= -1002.78,["z"]= 24.9149,["locked"]= true,["txtX"]=464.100,["txtY"]=-1003.538,["txtZ"]=26.064},
		-- Mission Row Backdoor out
		[20] = { ["objName"] = "v_ilev_gtdoor", ["x"]= 464.18, ["y"]= -1004.31,["z"]= 24.9152,["locked"]= true,["txtX"]=464.100,["txtY"]=-1003.538,["txtZ"]=26.064},
		-- Mission Row Rooftop In
		[21] = { ["objName"] = "v_ilev_gtdoor02", ["x"]= 465.467, ["y"]= -983.446,["z"]= 43.6918,["locked"]= true,["txtX"]=464.361,["txtY"]=-984.050,["txtZ"]=44.834},
		-- Mission Row Rooftop Out
		[22] = { ["objName"] = "v_ilev_gtdoor02", ["x"]= 462.979, ["y"]= -984.163,["z"]= 43.6919,["locked"]= true,["txtX"]=464.361,["txtY"]=-984.050,["txtZ"]=44.834},
		-- Mission Row Locker room
		[23] = { ["objName"] = "v_ilev_rc_door2", ["x"]= 451.98, ["y"]= -987.266,["z"]= 30.69,["locked"]= true,["txtX"]=451.98,["txtY"]=-987.266,["txtZ"]=31.30},
		-- SANDY SHORES MAIN DOOR
		[24] = { ["objName"] = "v_ilev_shrfdoor", ["x"]= 1855.105, ["y"]= 3683.516,["z"]= 34.266,["locked"]= true,["txtX"]=1854.605,["txtY"]=3683.516,["txtZ"]=34.30},
		-- Paleto Bay MAIN DOORS
		[25] = { ["objName"] = "v_ilev_shrf2door", ["x"]= -443.14, ["y"]= 6015.685,["z"]= 31.716,["locked"]= true,["txtX"]=-443.14,["txtY"]=6015.685,["txtZ"]=32.00},
		[26] = { ["objName"] = "v_ilev_shrf2door", ["x"]= -443.951, ["y"]= 6016.622,["z"]= 31.716,["locked"]= true,["txtX"]=-443.951,["txtY"]=6016.622,["txtZ"]=32.00}, 
		-- Mission Row Back Double Doors
		[27] = { ["objName"] = "v_ilev_rc_door2", ["x"]= 467.3716, ["y"]= -1014.452,["z"]= 26.5362,["locked"]= true,["txtX"]=468.09,["txtY"]=-1014.452,["txtZ"]=27.1362},
		[28] = { ["objName"] = "v_ilev_rc_door2", ["x"]= 469.9679, ["y"]= -1014.452,["z"]= 26.5362,["locked"]= true,["txtX"]=469.35,["txtY"]=-1014.452,["txtZ"]=27.1362},
		-- others police stations
		[29] = {["objName"] = 'prop_lrggate_02_ld', ['x'] = 827.84, ['y'] = -1290.45, ['z'] = 2825, ["locked"] = true, ['txtX'] = 827.84, ['txtY'] = -1290.45, ['txtZ'] = 2825}, -- La mesa Left door
		[30] = {["objName"] = 'prop_lrggate_02_ld', ['x'] = 828.17, ['y'] = -1289.55, ['z'] = 28.25, ["locked"] = true, ['txtX'] = 828.17, ['txtY'] = -1289.55, ['txtZ'] = 28.25}, -- La mesa right door
		[31] = {["objName"] = 'prop_lrggate_02_ld', ['x'] = 816.89, ['y'] = -1321.05, ['z'] = 26.08, ["locked"] = true, ['txtX'] = 816.89, ['txtY'] = -1321.05, ['txtZ'] = 26.08}, -- La Mesa Gate
		[32] = {["objName"] = 'prop_lrggate_02_ld', ['x'] = -1092.73, ['y'] = -810.59, ['z'] = 19.29, ["locked"] = true,['txtX'] = -1092.73, ['txtY'] = -810.59, ['txtZ'] = 19.29 }, -- Vespucci left door
		[33] = {["objName"] = 'prop_lrggate_02_ld', ['x'] = -1092.27, ['y'] = -809.89, ['z'] = 19.27, ["locked"] = true, ['txtX'] = -1092.27, ['txtY'] = -809.89, ['txtZ'] = 19.27}, -- vespucci right door 
		
		[34] = {["objName"] = "v_ilev_arm_secdoor", ["x"] = 452.69, ["y"] = -982.07, ["z"] = 30.689, ["locked"] = true, ["txtX"] = 452.69, ["txtY"] = -982.07, ["txtZ"] = 29.69}, -- Mission row armory door
		[35] = {["objName"] = "v_ilev_arm_secdoor", ["x"] = 443.61, ["y"] = -993.45, ["z"]= 29.69, ["locked"] = true, ["textX"] = 443.61, ["textY"]= -993.61, ["textZ"]= 29.69}, -- Mission row bierfroom door
		[36] = {["objName"] = "v_ilev_arm_secdoor", ["x"] = 464.25, ["y"] = -983.73, ["z"]= 42.7, ["locked"] = true, ["textX"] = 464.25, ["textY"]= -983.73, ["textZ"]= 42.7}, -- Sandy shores armory door
	
	
		---------------------
		-- EMS Station --
		---------------------
		[37] = { ["objName"] = "v_ilev_ph_gendoor004", ["x"]= 449.69815063477, ["y"]= -986.46911621094,["z"]= 30.689594268799,["locked"]= true,["txtX"]=450.104,["txtY"]=-986.388,["txtZ"]=31.739},
		
		---------------------
		-- Publick Works --
		---------------------
		
		---------------------
		-- Rangers station  --
		---------------------
	}
}