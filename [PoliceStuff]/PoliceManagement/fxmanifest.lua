
fx_version 'bodacious'

name 'Police Management'

description "Police Management"

author "Physics_is_ki"

version "1.0.0"

game 'gta5'

ui_page 'html/RoughDraft.html'

files {
    'html/RoughDraft.html',
    'html/RoughDraft.js',
}

shared_scripts  {
    "shared/*.lua"
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}