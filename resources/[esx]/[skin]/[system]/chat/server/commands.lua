--[[ COMMANDS ]]--
Config        = {}

Config.EnableESXIdentity = true
Config.OnlyFirstname     = false

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end
--]]