Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "Sin RP" 							-- Bot Username
Config.avatar = "https://cdn.discordapp.com/attachments/730133424014360582/761612979833405480/sin_logo_1_dbbb_1.webp"				-- Bot Avatar
Config.communtiyName = "Sin RP"					-- Icon top of the Embed
Config.communtiyLogo = "https://cdn.discordapp.com/attachments/730133424014360582/761612979833405480/sin_logo_1_dbbb_1.webp"		-- Icon top of the Embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.weaponLogDelay = 1000		-- delay to wait after someone fired a weapon to check again in ms (put to 0 to disable) Best to keep this at atleast 1000

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs


-- Change color of the default embeds here
-- It used Decimal color codes witch you can get and convert here: https://jokedevil.com/colorPicker
Config.joinColor = "3863105" 		-- Player Connecting
Config.leaveColor = "15874618"		-- Player Disconnected
Config.chatColor = "10592673"		-- Chat Message
Config.shootingColor = "10373"		-- Shooting a weapon
Config.deathColor = "000000"		-- Player Died
Config.resourceColor = "15461951"	-- Resource Stopped/Started



Config.webhooks = {
	all = "https://discordapp.com/api/webhooks/769962966070067211/lRDtMWmZAatYimawVmqNyljxozwfBF-OXWsm3dlAugTe1Dhfh2u6s_xdraXVFEt4u51e",
	chat = "https://discordapp.com/api/webhooks/769962918132842557/FGPc_AzMOunhabZSFyXeU07pJEsSRL5sglezeIkEpwGuIwziLqqzQf4VXYpnRKDPzDVl",
	joins = "https://discordapp.com/api/webhooks/769962857688203264/ZnKbErcnwvmtBCD-z4TZvdkgNan2blcwyLTy49nr1rklWOVsBO7kuBUSup2xUrj1PPmo",
	leaving = "https://discordapp.com/api/webhooks/769962857688203264/ZnKbErcnwvmtBCD-z4TZvdkgNan2blcwyLTy49nr1rklWOVsBO7kuBUSup2xUrj1PPmo",
	deaths = "https://discordapp.com/api/webhooks/769962750469734400/dyfrs89JhKrcen4N9VTC_BO6cNIogDbnTMak7uu7ctvx_orzQROKWJfcYnOZyssxNGE8",
	shooting = "https://discordapp.com/api/webhooks/769962750469734400/dyfrs89JhKrcen4N9VTC_BO6cNIogDbnTMak7uu7ctvx_orzQROKWJfcYnOZyssxNGE8",
	resources = "https://discordapp.com/api/webhooks/769962705452007454/ntLJLNcJ1ZiD18wZbnOUWuFW_m8of8hiZdpmUFJHIs-xLvzKCfGTabBoVvh0KMDYQB3z",

  }


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.1.0"
