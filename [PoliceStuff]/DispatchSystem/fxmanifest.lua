fx_version 'cerulean'

game 'gta5'
lua54 "yes"

name "Dispatch System"

description "Dispatch System"

author "Physics_is_ki"

version "1.0.0"

shared_scripts {
    'shared/config.lua',
    'sounds/*ogg'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page 'html/DispatchSystem.html'

files {
    'html/DispatchSystem.html',
    'html/DispatchSystem.js',
    'html/DispatchCallouts.js',
	'html/DispatchView.js',
	'html/DispatchView.jpeg',
}

exports {
	'DispatchAlerts',
	'StolenVehicle',
	'IsPedShoting',
	'Hunting',
	'SpeedingVehicle',
	'FightInProgress',
	'PrisonBreak',
	'StoreRobbery',
	'FleecaBankRobbery',
	'PaletoBankRobbery',
	'pacificbankrobbery',
	'VangelicoRobbery',
	'HouseRobbery',
	'DrugSales',
	'SuspiciousActivity',
	'CarJacking',
	'InjuriedPerson',
	'DeceasedPerson',
	'Explosion',
	'Officerdowned',
	'EMSDown',
	'CarBoosting'
}