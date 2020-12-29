local lastdata = nil
ESX = nil
if Config.ESX then
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = "Bot " .. Config.BotToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

Citizen.CreateThread(function()
while true do 
  Citizen.Wait(600000)
  PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = Config.ReplyUserName, content = "Discord Bot Heart Beat Received ", avatar_url = Config.AvatarURL}), { ['Content-Type'] = 'application/json' })
end
end)


function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end



function GetRealPlayerName(playerId)
    if Config.ESX then
	local xPlayer = ESX.GetPlayerFromId(playerId)
	return xPlayer.getName()
	else
	return "ESX NOT ENABLED"
	end
end

function ExecuteCOMM(command)
if string.starts(command,Config.Prefix) then


-- Get Player Count
     if string.starts(command,Config.Prefix .. "playercount") then

       sendToDiscord("Nombre de joueur","✔️ • Total de joueur sur le serveur : " .. GetNumPlayerIndices(),16711680)

-- Kick Someone

     elseif string.starts(command,Config.Prefix .. "kick") then
	 
	     local t = mysplit(command," ")
	 
	     if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
	     sendToDiscord("KICKED Succesfully", "✔️ • Le joueur a bien été KICK " .. GetPlayerName(t[2]),16711680)
	     DropPlayer(t[2],"KICKED FROM DISCORD CONSOLE")
	    
	 
	 
	     else
	  
	     sendToDiscord("❌ • La Commande est invalide","❌ • La commande n'est pas valide ou l'ID du joueur n'est pas correcte.",16711680)
	 
	     end
		 
		 
-- revive
    elseif string.starts(command,Config.Prefix .. "revive") then
	
	if Config.ESX then
	
	 local t = mysplit(command," ")
     if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
          TriggerClientEvent("esx_ambulancejob:revive",t[2])   
          sendToDiscord("Revived Succesfully", "✔️ • Le joueur a bien été revive " .. GetPlayerName(t[2]),16711680)
   
     else
   
	     sendToDiscord("❌ • La Commande est invalide","❌ • La commande n'est pas valide ou l'ID du joueur n'est pas correcte.",16711680)
	  
	 end
	 
	else
	 
	 sendToDiscord("Discord BOT","ESX Is not enable",16711680)
	 
    end

-- Command Not Found
     else

	     sendToDiscord("❌ • La Commande est invalide","❌ • La commande n'est pas valide ou l'ID du joueur n'est pas correcte.",16711680)

     end
  end
	 
end









Citizen.CreateThread(function()

   PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = Config.ReplyUserName, content = "Discord Bot En Ligne", avatar_url = Config.AvatarURL}), { ['Content-Type'] = 'application/json' })
   while true do   


	local chanel = DiscordRequest("GET","channels/" .. Config.ChannelID,{})
if chanel.data then
	local data = json.decode(chanel.data)
	local lst = data.last_message_id
	local lastmessage = DiscordRequest("GET","channels/" .. Config.ChannelID .. "/messages/" .. lst,{})
     if lastmessage.data then
	local lstdata = json.decode(lastmessage.data)
	if lastdata == nil then	 
	lastdata = lstdata.id
	end

	if lastdata ~= lstdata.id and lstdata.author.username ~= Config.ReplyUserName then
	
	
	ExecuteCOMM(lstdata.content)
	lastdata = lstdata.id
--	sendToDiscord('New Message Recived',lstdata.content,16711680)
	
	end
    end
end
	Citizen.Wait(Config.WaitEveryTick)
	end
end)


function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Prison RP | By Vato",
            },
        }
    }
  PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = Config.ReplyUserName, embeds = connect, avatar_url = Config.AvatarURL}), { ['Content-Type'] = 'application/json' })
end
