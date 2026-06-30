fx_version 'bodacious'

game 'gta5'

name "CharacterCreation"

description "CharacterCreation"

author "Reachard King"

version "1.0.0"

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

ui_page "CharacterCreation.html"

files {
	"CharacterCreation.html",
	'CharacterCreation.js',
	'html/NFLogo.png',
	'html/path.png'
}