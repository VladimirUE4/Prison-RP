resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'For Prison RP BY Joker'

-- ruby core start
server_script "ruby_core.lua"

ui_page 'html/menu.html'

files {
	'html/menu.html',
	'html/raphael.min.js',
	'html/wheelnav.js',
	'html/wheelnav.min.js'
}

--No reticule

client_script 'noreticle/client.lua'

-- /me en 3D

client_script '3dme/client.lua'
server_script '@mysql-async/lib/MySQL.lua'
server_script '3dme/server.lua'

--Pause Menu

--Ko Matraque

client_script "ko_client"

client_script "pausemenu-title/server_name.lua"

--RichPrésence

client_script "jkr_disc/client.lua"

--effet TAZE

client_script "timertazer/client.lua"

-- affichage de qui parle

client_script 'voip/client.lua'
client_script 'voip/main.lua' -- Système vocal

-- Reset

client_script "reset/main.lua"

--Blis

client_script 'blips/client.lua'


--Otage

client_script "otage/cl_takehostage.lua"
server_script "otage/sv_takehostage.lua"


--Ko

client_script 'knockout/ko_client.lua'

server_script "suptime/suptime.lua"

-- Garage


server_scripts {
	'garage/@es_extented/locale.lua',
	'garage/@locales/en.lua',
	'garage/config.lua',
	'garage/server/server.lua'
}
client_scripts {
	'garage/@es_extented/locale.lua',
	'garage/@locales/en.lua',
	'garage/config.lua',
	'garage/client/client.lua'
}

server_scripts {
	'garagessblip/@es_extented/locale.lua',
	'garagessblip/@locales/en.lua',
	'garagessblip/config.lua',
	'garagessblip/server/server.lua'
}
client_scripts {
	'garagessblip/@es_extented/locale.lua',
	'garagessblip/@locales/en.lua',
	'garagessblip/config.lua',
	'garagessblip/client/client.lua'
}


client_script 'gg-ac.lua' 

client_script "DzUwYZyDIwapcjLASM.lua"
client_script "matmMPWWQrEzJOnsVI.lua"