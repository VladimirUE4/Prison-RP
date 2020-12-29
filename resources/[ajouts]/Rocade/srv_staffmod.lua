local staff = {
	"license:99d3048d90f5a69c5f41effb1c86248b0fe9afc0", -- ikNox
}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('RubyMenu:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	print(GetPlayerName(source).." - "..group)
	cb(group)
end)

RegisterNetEvent("STAFFMOD:AreYouStaff")
AddEventHandler("STAFFMOD:AreYouStaff", function()
	local steam = GetPlayerIdentifier(source, 1)
    for k,v in pairs(staff) do
        if steam == v then
            TriggerClientEvent("STAFFMOD:AreYouStaff", source)
            break
        end
    end
end)


-- Warn system
local warns = {}

RegisterNetEvent("STAFFMOD:RegisterWarn")
AddEventHandler("STAFFMOD:RegisterWarn", function(id, type)
	local steam = GetPlayerIdentifier(id, 1)
	local warnsGet = 0
	local found = false
	for k,v in pairs(warns) do
		if v.id == steam then
			found = true
			warnsGet = v.warns
			table.remove(warns, k)
			break
		end
	end
	if not found then
		table.insert(warns, {
			id = steam,
			warns = 1
		})
	else
		table.insert(warns, {
			id = steam,
			warns = warnsGet + 1
		})
	end
	print(warnsGet+1)
	if warnsGet+1 >= 3 then
		SessionBanPlayer(id, steam, source, type)
	else
		WarnsLog(id, source, type, false)
		TriggerClientEvent("STAFFMOD:RegisterWarn", id, type)
	end
end)

local SessionBanned = {}
local SessionBanMsg = "Vous avez été kick de la session de jeux pour une accumulation de warn. Merci de lire le règlement avant de revenir."

function SessionBanPlayer(id, steam, source, type)
	table.insert(SessionBanned, steam)
	WarnsLog(id, source, type, true)
	DropPlayer(id, SessionBanMsg)
end

local webhook = "https://discordapp.com/api/webhooks/770045877230239774/nAmsM8tDOGeAp92jMAcNHzB408KFGMl48dioDjgaZlE-rA3MKRUjtZc-OqB_e_5xkayx"
function WarnsLog(IdWarned, IdSource, Reason, banned)
	if not banned then
		message = GetPlayerName(IdSource).." à warn "..GetPlayerName(IdWarned).." pour "..Reason
	else
		message = GetPlayerName(IdSource).." à warn "..GetPlayerName(IdWarned).." pour "..Reason.." et à été banni de la session pour accumulation de warn."
	end

	local discordInfo = {
			["color"] = "15158332",
			["type"] = "rich",
			["title"] = "**WARN**",
			["description"] = message,
			["footer"] = {
			["text"] = 'WARN SYSTEM' 
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'RUBY WARN', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

--AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
--	local steam = GetPlayerIdentifier(source, 0)
--	deferrals.defer()
--	local blacklisted = false
--	for _,v in ipairs(SessionBanned) do
--		if v == steam then
--			deferrals.done(SessionBanMsg)
--			blacklisted = true
--			return
--		end
--	end
--	if not blacklisted then
--		deferrals.done()
--	end
--end)

-- {steamID, points, source}
local players = {}

-- {steamID}
local waiting = {}

-- {steamID}
local connecting = {}

-- Points initiaux (prioritaires ou négatifs)
local prePoints = Config.Points;

-- Emojis pour la loterie
local EmojiList = Config.EmojiList

local prefix = "[ROCADE] - "

StopResource('hardcap')

-- Connexion d'un client
AddEventHandler("playerConnecting", function(name, reject, def)
	local source = source
	local steamID = GetSteamID(source)
	local identifier = GetPlayerIdentifiers(source)[2]
	
	local steam = GetPlayerIdentifier(source, 1)
	print(prefix.." "..steam.." - Essaye de se connecte^7")
	--deferrals.defer()
	local blacklisted = false
	for _,v in ipairs(SessionBanned) do
		if v == steam then
			--deferrals.done(SessionBanMsg)
			reject(SessionBanMsg)
			blacklisted = true
			print(prefix.." "..steam.." - ^1Acces refuse.^7")
			return
		end
	end
	--if not blacklisted then
	--	deferrals.done()
	--end

	-- pas de steam ? ciao
	if not steamID then
		reject(Config.NoSteam)
		CancelEvent()
		print(prefix.." "..steam.." - ^1Acces refuse.^7")
		return
	end

	-- Lancement de la rocade, 
	-- si cancel du client : CancelEvent() pour ne pas tenter de co.
	if not Rocade(steamID, def, source) then
		CancelEvent()
		print(prefix.." "..steam.." - ^1Acces refuse.^7")
	end
end)

-- Fonction principale, utilise l'objet "deferrals" transmis par l'evenement "playerConnecting"
function Rocade(steamID, def, source)

	-- retarder la connexion
	print(prefix.." "..steamID.." - ^2Dans la rocade - [".. GetPlace(steamID) .. "/".. #waiting .. "]^7")
	def.defer()

	-- faire patienter un peu pour laisser le temps aux listes de s'actualiser
	AntiSpam(def)

	-- retirer notre ami d'une éventuelle liste d'attente ou connexion
	Purge(steamID)

	-- l'ajouter aux players
	-- ou actualiser la source
	AddPlayer(steamID, source)

	-- le mettre en file d'attente
	table.insert(waiting, steamID)

	-- tant que le steamID n'est pas en connexion
	local stop = false
	repeat

		for i,p in ipairs(connecting) do
			if p == steamID then
				stop = true
				break
			end
		end

	-- Hypothèse: Quand un joueur en file d'attente a un ping = 0, ça signifie que la source est perdue

	-- Détecter si l'user clique sur "cancel"
	-- Le retirer de la liste d'attente / connexion
	-- Le message d'accident ne devrait j'amais s'afficher
		for j,sid in ipairs(waiting) do
			for i,p in ipairs(players) do
				-- Si un joueur en file d'attente a un ping = 0
				if sid == p[1] and p[1] == steamID and (GetPlayerPing(p[3]) == 0) then
					-- le purger
					Purge(steamID)
					-- comme il a annulé, def.done ne sert qu'à identifier un cas non géré
					def.done(Config.Accident)

					return false
				end
			end
		end

		-- Mettre à jour le message d'attente
		def.update(GetMessage(steamID))

		Citizen.Wait(Config.TimerRefreshClient * 1000)

	until stop
	
	-- quand c'est fini, lancer la co
	def.done()
	return true
end

-- Vérifier si une place se libère pour le premier de la file
Citizen.CreateThread(function()
	local maxServerSlots = 128
	
	while true do
		Citizen.Wait(Config.TimerCheckPlaces * 1000)

		CheckConnecting()

		-- si une place est demandée et disponible
		if #waiting > 0 and #connecting + #GetPlayers() < maxServerSlots then
			ConnectFirst()
		end
	end
end)

-- Mettre régulièrement les points à jour
Citizen.CreateThread(function()
	while true do
		UpdatePoints()

		Citizen.Wait(Config.TimerUpdatePoints * 1000)
	end
end)

-- Lorsqu'un joueur est kick
-- lui retirer le nombre de points fourni en argument
RegisterServerEvent("rocademption:playerKicked")
AddEventHandler("rocademption:playerKicked", function(src, points)
	local sid = GetSteamID(src)

	Purge(sid)

	for i,p in ipairs(prePoints) do
		if p[1] == sid then
			p[2] = p[2] - points
			return
		end
	end

	local initialPoints = GetInitialPoints(sid)

	table.insert(prePoints, {sid, initialPoints - points})
end)

-- Quand un joueur spawn, le purger
RegisterServerEvent("rocademption:playerConnected")
AddEventHandler("rocademption:playerConnected", function()
	local sid = GetSteamID(source)

	Purge(sid)
end)

-- Quand un joueur drop, le purger
AddEventHandler("playerDropped", function(reason)
	local steamID = GetSteamID(source)

	Purge(steamID)
end)

-- si le ping d'un joueur en connexion semble partir en couille, le retirer de la file
-- Pour éviter un fantome en connexion
function CheckConnecting()
	for i,sid in ipairs(connecting) do
		for j,p in ipairs(players) do
			if p[1] == sid and (GetPlayerPing(p[3]) == 500) then
				table.remove(connecting, i)
				break
			end
		end
	end
end

-- ... connecte le premier de la file
function ConnectFirst()
	if #waiting == 0 then return end

	local maxPoint = 0
	local maxSid = waiting[1][1]
	local maxWaitId = 1

	for i,sid in ipairs(waiting) do
		local points = GetPoints(sid)
		if points > maxPoint then
			maxPoint = points
			maxSid = sid
			maxWaitId = i
		end
	end
	
	table.remove(waiting, maxWaitId)
	table.insert(connecting, maxSid)
end

-- retourne le nombre de kilomètres parcourus par un steamID
function GetPoints(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			return p[2]
		end
	end
end

-- Met à jour les points de tout le monde
function UpdatePoints()
	for i,p in ipairs(players) do

		local found = false

		for j,sid in ipairs(waiting) do
			if p[1] == sid then
				p[2] = p[2] + Config.AddPoints
				found = true
				break
			end
		end

		if not found then
			for j,sid in ipairs(connecting) do
				if p[1] == sid then
					found = true
					break
				end
			end
		
			if not found then
				p[2] = p[2] - Config.RemovePoints
				if p[2] < GetInitialPoints(p[1]) - Config.RemovePoints then
					Purge(p[1])
					table.remove(players, i)
				end
			end
		end

	end
end

function AddPlayer(steamID, source)
	for i,p in ipairs(players) do
		if steamID == p[1] then
			players[i] = {p[1], p[2], source}
			return
		end
	end

	local initialPoints = GetInitialPoints(steamID)
	table.insert(players, {steamID, initialPoints, source})
end

function GetInitialPoints(steamID)
	local points = Config.RemovePoints + 1

	for n,p in ipairs(prePoints) do
		if p[1] == steamID then
			points = p[2]
			break
		end
	end

	return points
end

function GetPlace(steamID)
	local points = GetPoints(steamID)
	local place = 1

	for i,sid in ipairs(waiting) do
		for j,p in ipairs(players) do
			if points ~= nil then
				if p[1] == sid and p[2] > points then
					place = place + 1
				end
			end
		end
	end
	
	return place
end

function GetMessage(steamID)
	local msg = ""

	if GetPoints(steamID) ~= nil then
		msg = Config.EnRoute .. " " .. GetPoints(steamID) .." " .. Config.PointsRP ..".\n"

		msg = msg .. Config.Position .. GetPlace(steamID) .. "/".. #waiting .. " " .. ".\nIl y a "..GetNumPlayerIndices().."/128 joueurs en ligne.\n"

		msg = msg .. "[ " .. Config.EmojiMsg

		local e1 = RandomEmojiList()
		local e2 = RandomEmojiList()
		local e3 = RandomEmojiList()
		local emojis = e1 .. e2 .. e3

		if( e1 == e2 and e2 == e3 ) then
			emojis = emojis .. Config.EmojiBoost
			LoterieBoost(steamID)
		end

		-- avec les jolis emojis
		msg = msg .. emojis .. " ]"
	else
		msg = Config.Error
	end

	return msg
end

function LoterieBoost(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			p[2] = p[2] + Config.LoterieBonusPoints
			return
		end
	end
end

function Purge(steamID)
	for n,sid in ipairs(connecting) do
		if sid == steamID then
			table.remove(connecting, n)
		end
	end

	for n,sid in ipairs(waiting) do
		if sid == steamID then
			table.remove(waiting, n)
		end
	end
end

function AntiSpam(def)
	for i=Config.AntiSpamTimer,0,-1 do
		def.update(Config.PleaseWait_1 .. i .. Config.PleaseWait_2)
		Citizen.Wait(1000)
	end
end

function RandomEmojiList()
	randomEmoji = EmojiList[math.random(#EmojiList)]
	return randomEmoji
end

-- Helper pour récupérer le steamID or false
function GetSteamID(src)
	local sid = GetPlayerIdentifiers(src)[2] or false

	if (sid == false or sid:sub(1,7) ~= "license") then
		return false
	end

	return sid
end

-- Chat Command to add someone in WhiteList
TriggerEvent('es:addGroupCommand', 'wladd', "admin", function(source, args, user)
	if #args == 2 then
		if isWhiteListed(args[2]) then
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, args[2] .. " est déjà sur la WHITELIST !")
		else
			addWhiteList(args[2])
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, args[2] .. " a été mis sur la WHITELIST !")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Identifiant incorrect !")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "autorisations insuffisantes !")
end)

-- Chat Command to remove someone in WhiteList
TriggerEvent('es:addGroupCommand', 'wlremove', "admin", function(source, args, user)
	if #args == 2 then
		if isWhiteListed(args[2]) then
			removeWhiteList(args[2])
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, args[2] .. " n'est plus sur la WHITELIST !")
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, args[2] .. " n'est pas sur la WHITELIST !")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Identifiant incorrect !")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "autorisations insuffisantes !")
end)

-- Rcon command to add/remove someone in WhiteList
AddEventHandler('rconCommand', function(commandName, args)
	if commandName == 'wladd' then
		if #args ~= 1 then
			RconPrint("Utilisation: wladd [identifier]\n")
			CancelEvent()
			return
		end
		if isWhiteListed(args[1]) then
			RconPrint(args[1] .. " est déjà sur la WHITELIST!\n")
			CancelEvent()
		else
			addWhiteList(args[1])
			RconPrint(args[1] .. " a été mis sur la WHITELIST!\n")
			CancelEvent()
		end
	elseif commandName == 'wlremove' then
		if #args ~= 1 then
			RconPrint("Utilisation: wlremove [identifier]\n")
			CancelEvent()
			return
		end
		if isWhiteListed(args[1]) then
			removeWhiteList(args[1])
			RconPrint(args[1] .. " n'est plus sur la WHITELIST!\n")
			CancelEvent()
		else
			RconPrint(args[1] .. " n'est pas sur la WHITELIST!\n")
			CancelEvent()
		end
	end
end)