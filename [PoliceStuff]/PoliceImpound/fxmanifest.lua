
fx_version 'bodacious'
game 'gta5'

name "Impound"

description "Impound"

author "Physics_is_ki"

version "1.0.0"

ui_page {
    "ui/Impound.html",
    "ui/SelectImpound.html"

}

files {
    'ui/Impound.html',
    'ui/Impound.js',
    'ui/SelectImpound.html',
	'ui/SelectImpound.js'
}

shared_scripts {
    'shared/*.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}