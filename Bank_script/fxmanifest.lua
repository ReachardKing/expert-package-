fx_version 'bodacious'

game 'gta5'

name "CustomBank_script"

description "CustomBank_script"

author "Reachard King"

version "1.0.0"

ui_page 'customBank.html'

files {
    'custom.js',
    'customBank.html',
    'customBank.js',
    'NFLogo.png',
    'fleeca_tar.png'
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

dependency 'money_script'