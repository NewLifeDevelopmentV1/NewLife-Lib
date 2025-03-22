fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'GABO'
description 'Simple library script for your fivem servers'

client_scripts {
    'modules/init/client.lua',
    'modules/functions/client.lua',
    'customize.lua'
}

server_scripts {
    'modules/init/server.lua',
    'modules/functions/server.lua',
    '@oxmysql/lib/MySQL.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

files {
    'bridge/**/**/*.lua'
}

dependencies {
    'ox_lib',
    'oxmysql'
}