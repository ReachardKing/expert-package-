fx_version "cerulean"
game "gta5"

lua54 "yes"

export "registerWeapon"
server_export "registerWeapon"

client_scripts {
	"@menu/menu.lua",
	"register_weapons.lua"
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
}