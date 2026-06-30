fx_version 'bodacious'
game 'gta5'

name "CustomATM"

description "Custom ATM"

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

ui_page 'CustomATM.html'

files {
	'custom.js',
	'CustomATM.html',
	'customATM.js',
	'NFLogo.png'
}

dependency 'money_script'