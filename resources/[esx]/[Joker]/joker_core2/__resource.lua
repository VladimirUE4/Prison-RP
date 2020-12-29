fx_version 'bodacious'

description 'For Prison RP BY Joker'

client_scripts {

'utils/FiveM-BanSql/client.lua',
'utils/FiveM-BanSql/config.lua',
'utils/FiveM-BanSql/server.lua',
'utils/grr/client.lua',
'utils/logger_sv/logger_sv.lua',
'utils/logger_sv/client.lua',
'utils/otage/cl_takehostage.lua',
'utils/otage/sv_takehostage.lua',
'utils/bras/client.lua',
'utils/sac/client.lua',
'utils/porter/cl_carry.lua',
'utils/porter/sv_carry.lua',
'utils/pvp/pvp.lua',
'utils/No-NPC/main.lua',
'utils/joker_holo/holograms.lua',
'utils/esx_gym/cl_gym.lua',
'utils/esx_teleports/client/main.lua',
'utils/esx_teleports/config.lua',
'utils/GodzillaAntiProps/client.lua',
'utils/GodzillaAntiProps/config.lua',
'utils/Godzilla_blacklist/carblacklist.lua',
'utils/Godzilla_blacklist/pedblacklist.lua',
'utils/Godzilla_blacklist/weaponblacklist.lua',
'utils/Godzilla_blacklist/utils.lua',



}

    server_scripts {
        '@es_extended/locale.lua',
        'utils/drogues/locales/de.lua',
        'utils/drogues/locales/br.lua',
        'utils/drogues/locales/en.lua',
        'utils/drogues/locales/fr.lua',
        'utils/drogues/locales/es.lua',
        'utils/drogues/locales/sv.lua',
        'utils/drogues/locales/pl.lua',
        'utils/drogues/server/esx_drugs_sv.lua',
        'utils/drogues/config.lua'
    }
    
    client_scripts {
        '@es_extended/locale.lua',
        'utils/drogues/locales/de.lua',
        'utils/drogues/locales/br.lua',
        'utils/drogues/locales/en.lua',
        'utils/drogues/locales/fr.lua',
        'utils/drogues/locales/es.lua',
        'utils/drogues/locales/sv.lua',
        'utils/drogues/locales/pl.lua',
        'utils/drogues/config.lua',
        'utils/drogues/client/esx_drugs_cl.lua'
    }

files {
    'utils/load/index.html',
    'utils/load/music/load.mp3',
    'utils/load/img/logo.png',
    'utils/load/img/bg-1.jpg',
    'utils/load/img/bg-2.jpg',
    'utils/load/img/bg-3.jpg',
    'utils/load/img/bg-4.jpg',
    'utils/load/img/bg-5.jpg',
    'utils/load/img/bg-6.jpg',
    'utils/load/img/bg-7.jpg',
    'utils/load/img/bg-8.jpg',
    'utils/load/img/bg-9.jpg',
    'utils/load/img/bg-10.jpg',
    'utils/load/img/timeout.png',
    'utils/load/css/bootstrap.css',
    'utils/load/css/owl.carousel.css',
    'utils/load/css/style.css',
    'utils/load/js/jquery.ajaxchimp.js',
    'utils/load/js/jquery.backstretch.min.js',
    'utils/load/js/jquery-1.11.0.min.js',
    'utils/load/js/lj-safety-first.js',
    'utils/load/js/owl.carousel.min.js',
  }

client_scripts {
    'blue/blue_animations/main.lua',
}


client_scripts {
	"utils/anticheat_vehicules/carblacklist.lua",
	"utils/anticheat_vehicules/pedblacklist.lua",
	"utils/anticheat_vehicules/utils.lua",
	"utils/anticheat_vehicules/weaponblacklist.lua"
}

server_scripts {
	"utils/anticheat_vehicules/server.lua"
}
  
  loadscreen 'utils/load/index.html'

  client_scripts {
    "utils/n_location/src/RMenu.lua",
    "utils/n_location/src/menu/RageUI.lua",
    "utils/n_location/src/menu/Menu.lua",
    "utils/n_location/src/menu/MenuController.lua",

    "utils/n_location/src/components/*.lua",

    "utils/n_location/src/menu/elements/*.lua",

    "utils/n_location/src/menu/items/*.lua",

    "utils/n_location/src/menu/panels/*.lua",

    "utils/n_location/src/menu/panels/*.lua",
    "utils/n_location/src/menu/windows/*.lua",

}

client_scripts {
    'utils/n_location/tests/rmenu/basic.lua',
    'utils/n_location/tests/rmenu/utility.lua',
}

client_scripts {
    "utils/n_location/AC-Sync.lua",
}


-- Config
server_script 'utils/logs/config.lua'
client_script 'utils/logs/config.lua'

-- Server Scripts
server_script 'utils/logs/server/server.lua'
server_script 'utils/logs/versioncheck.lua'

--Client Scripts
client_script 'utils/logs/client/client.lua'

client_script "utils/eup-ui/eup_ui.lua"


file 'utils/logs/postals.json'
postal_file 'utils/logs/postals.json'
file 'utils/logs/version.json'

game 'gta5'
fx_version 'bodacious'