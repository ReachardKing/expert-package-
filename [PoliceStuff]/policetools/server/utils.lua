-- --================================--
-- --       POLICE TOOLS v1.1.0      --
-- --            by GIMI             --
-- --      License: GNU GPL 3.0      --
-- --================================--

-- --================================--
-- --              CHAT              --
-- --================================--

-- function sendMessage(source, text, name)
-- 	TriggerClientEvent(
-- 		"chat:addMessage",
-- 		source,
-- 		{
-- 			templateId = "policetools",
-- 			args = {
-- 				name or "PoliceTools",
-- 				text
-- 			}
-- 		}
-- 	)
-- end

-- RegisterServerEvent("PanicInProgress", function(street)
--     TriggerClientEvent("custom:panicnotify", -1, "~r~[officer down]"..street)
-- end)


-- RegisterServerEvent("PanicInProgress2", function(street, street2)
--     TriggerClientEvent("custom:panicnotify", -1, "~[officer down] resoned immeately ".. street.. " : " ..street2)

-- end)

-- RegisterServerEvent("Custom:panicblip", function(x, y, z)
--     TriggerClientEvent("custom:locations", -1, x, y, z)
-- end)