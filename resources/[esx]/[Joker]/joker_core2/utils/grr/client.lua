Citizen.CreateThread(function()
    while true do

    SetDiscordAppId(696016410828341268)
  

    SetDiscordRichPresenceAsset('sans_titre-2')
        

    SetDiscordRichPresenceAssetSmallText('Rejoins nous !')
    
    players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive( i ) then
            table.insert( players, i )
        end
    end
    SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. #players .. " Joueurs -  💨 discord.gg/Cv6KY3F")
  
    Citizen.Wait(60000)
    end
  end)