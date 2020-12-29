fx_version 'adamant'
game 'gta5'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'srv_staffmod.lua'
}

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",

    "src/components/*.lua",

    "src/menu/elements/*.lua",

    "src/menu/items/*.lua",

    "src/menu/panels/*.lua",

    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

}

client_script 'cl_esc.lua'
client_script 'cl_instructions.lua'



client_scripts {
    "AC-Sync.lua",
}