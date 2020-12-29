ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Vato_Shops:buy')
AddEventHandler('Vato_Shops:buy', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		xPlayer.addInventoryItem(item, 1)
    end
end)

