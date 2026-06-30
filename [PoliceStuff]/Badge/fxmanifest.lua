fx_version 'cerulean'
game 'gta5'

name "Badge"

description "Badge"

author "Reachard King"

version "1.0.0"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}


ui_page 'web/PoliceBadge.html'

files {
	'web/PoliceBadge.html',
	'web/PoliceBadge.js'
}