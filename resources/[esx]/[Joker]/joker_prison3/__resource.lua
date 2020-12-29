resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'For Prison RP BY Joker'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/fr.lua',
	'server/srv_rayZ.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/fr.lua',
	'client/cl_rayZ.lua'
}

client_script 'gg-ac.lua' 
