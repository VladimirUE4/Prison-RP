resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'esx_base - Mowgli'

version '1.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/classes/addonaccount.lua',
	'server/classes/addoninventory.lua',
	'server/classes/datastore.lua',
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'server/main.lua',
	'billing/config.lua',
	'billing/server/main.lua',
	'cron/server/main.lua',
	'service/server/main.lua',
	'society/config.lua',
	'society/server/main.lua',
	'instance/config.lua',
	'instance/server/main.lua',
	'accessories/config.lua',
	'accessories/server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'client/main.lua',
	'billing/config.lua',
	'billing/client/main.lua',
	'billing/AC-Sync.lua',
	'service/client/main.lua',
	'society/config.lua',
	'society/client/main.lua',
	'instance/config.lua',
	'instance/client/main.lua',
	'accessories/config.lua',
	'accessories/client/main.lua'
}

dependencies {
	'es_extended',
	'esx_skin',
	'esx_base'
}

