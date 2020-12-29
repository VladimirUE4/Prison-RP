Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 25 -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'fr'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 8 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = false

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(1790.05, 2578.734, 45.91), heading = 92.93 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(1790.05, 2578.734, 45.91),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(1782.262, 2584.202, 45.91)
		},

		Pharmacies = {
			vector3(1780.002, 2578.617, 45.9177)
		},

		Vehicles = {
			{
				Spawner = vector3(1792.04, 2552.083, 45.56),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					--{ coords = vector3(297.2, -1429.5, 29.8), heading = 227.6, radius = 4.0 },
					--{ coords = vector3(294.0, -1433.1, 29.8), heading = 227.6, radius = 4.0 },
					{ coords = vector3(1690.905, 2583.609, 50.78), heading = 227.6, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1678.451, 2574.949, 50.61978),
				InsideShop = vector3(1868.1104, 3654.50, 33.87),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					--{ coords = vector3(313.5, -1465.1, 46.5), heading = 142.7, radius = 10.0 },
					{ coords = vector3(1868.1104, 3654.50, 33.87), heading = 302.15, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			{
				From = vector3(468.81634521484375, -1016.63720703125, 26.413936614990234),
				To = { coords = vector3(1690.601806640625, 2599.32080078125, 45.568321228027344), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = -15.0, r = 102, g = 0, b = 0, a = 0, rotate = false }
			}
		}

	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 5000}
	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 4500}
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 3000}
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 2000}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 }
	},

	chief_doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 300000 }
	},

	boss = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 250000 }
	}

}
