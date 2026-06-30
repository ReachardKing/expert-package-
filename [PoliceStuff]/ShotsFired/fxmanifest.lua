fx_version 'cerulean'

game 'gta5'

name "ShotsFired"

description "Shots Fired"

author "Physics_is_ki"

version "1.0.0"

-- client_script 'client/main.lua'
-- server_script 'server/main.lua'
-- shared_script 'config.lua'
-- shared_script 'shared/main.lua'

shared_scripts {
    'shared/*.lua'
}

client_scripts {
    'config.lua',
     'client/*.lua'
   
}

server_scripts {
    'server/*.lua'
}