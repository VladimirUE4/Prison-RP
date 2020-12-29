local logs = "https://discordapp.com/api/webhooks/769943875380707349/i2IWZIaDAq_zDKtCMBHgAlsJPO1SLWvaBRsTD-Yw_RKrJPy2FnnzzPPgo0q2HCnmCIU5"
local communityname = "JOKER"
---local communtiylogo = "https://i.imgur.com/e8VsdLL.jpg" --Must end with .png or .jpg

AddEventHandler('playerConnecting', function()
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "La personne ce connecte sur le serveur",
            ["description"] = "Player: **"..name.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "JOKER LOGS", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(reason)
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local disconnect = {
        {
            ["color"] = "8663711",
            ["title"] = "La personne à déconnecter du serveur pour la raison suivante",
            ["description"] = "Player: **"..name.."** \nReason: **"..reason.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "JOKER LOGS", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)
