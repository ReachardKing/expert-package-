fx_version 'bodacious'

game 'gta5'

name "Fivem MDT"

description "FIvemMDT"

author "Physics_is_ki"

version "1.0.0"

ui_page {
    'ui/MDT.html',
    'ui/EMSMDT.html',
}

-- This is a FiveM resource manifest file for a police MDT (Mobile Data Terminal) system.

files {
    'ui/EMSMDT.html',
	'ui/MDT.html',
	'ui/appends.js',
    'ui/dependences/*.js',
    'ui/Required/*js'
}

shared_scripts {
    -- 'shared/*.lua',
    'connection/config.lua'
}

client_scripts {
    'client/*.lua',
    'connection/client.lua'
    
}

server_scripts {
    'server/*.lua',
    'connection/server.lua'
}