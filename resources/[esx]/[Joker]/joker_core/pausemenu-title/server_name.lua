function SetData()
	players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		table.insert( players, player )
end

	
	local name = GetPlayerName(PlayerId())
	local id = GetPlayerServerId(PlayerId())
	--Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~y~AltisCity ~t~| ~g~Discord: w5yD9Mp~t~ | ~w~ID: ' .. id .. ' ~t~| ~w~Nom: ~w~' .. name .. " ~t~| ~r~Joueurs: " .. #players .. "/80")
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', "• Prison-~w~RP  ~w~• ~w~ID: "..id.." ~w~• ".. #players .." ~w~connecté(e)s")
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SetData()
	end
end)


Citizen.CreateThread(function()
	AddTextEntry('FE_THDR_GTAO', '~w~• Bienvenue, vous êtes sur **server name**.')
	AddTextEntry('PM_PANE_LEAVE', '~w~• ~w~Se déconnecter Prison~w~RP')
	AddTextEntry('PM_PANE_QUIT', '~w~• ~w~Quitter ~w~FiveM')
	AddTextEntry('PM_SCR_MAP', '~w~Carte de la Prison')
	AddTextEntry('PM_SCR_GAM', '• ~w~Prendre l\'avion')
	AddTextEntry('PM_SCR_INF', '• ~w~Logs')
	AddTextEntry('PM_SCR_SET', '• ~w~Configuration')
	AddTextEntry('PM_SCR_STA', '• ~w~Statistiques')
	AddTextEntry('PM_SCR_RPL', '• ~w~Fermé')
  end)

Citizen.CreateThread(function()
    AddTextEntry("PM_PANE_LEAVE", "~w~• ~w~Se déconnecter de Prison~w~RP")
end)

Citizen.CreateThread(function()
    AddTextEntry("PM_PANE_QUIT", "~r~• ~w~Quitter ~w~FiveM")
end)

