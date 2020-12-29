ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Vato_AppleStore:buy')
AddEventHandler('Vato_AppleStore:buy', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
	xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(item, 1)
    	xPlayer.showNotification('Vous avez acheté 1 ' .. label .. " pour ~g~" .. price .. "$ !")
    else
    	xPlayer.showNotification('Vous n\'avez pas assez d\'argent sur vous !')
    end
end)
