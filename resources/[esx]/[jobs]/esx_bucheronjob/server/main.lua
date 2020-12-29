ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local copper = 1
local iron = 1
local gold = 1 
local gold = 1

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'lumberjack', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'lumberjack', _U('lumberjack_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'lumberjack', 'bûcheron', 'society_lumberjack', 'society_lumberjack', 'society_lumberjack', {type = 'private'})
local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "MineFarm" or zone == "MineFarm2"then
			local itemQuantity = xPlayer.getInventoryItem('wood').count
			if itemQuantity >= 50 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1800, function()
					xPlayer.addInventoryItem('wood', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_bucheronjob:startHarvest')
AddEventHandler('esx_bucheronjob:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('stone_taken'))  
		Harvest(_source,zone)
	end
end)


RegisterServerEvent('esx_bucheronjob:stopHarvest')
AddEventHandler('esx_bucheronjob:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TraitementFoundry" then
			local itemQuantity = xPlayer.getInventoryItem('washed_wood').count
			
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_stonew'))
				return
			else
				local rand = math.random(0,100)
				if (rand <= 100) then
					SetTimeout(1800, function()
						xPlayer.removeInventoryItem('washed_wood', 4)
						xPlayer.addInventoryItem('cutted_wood', 1)
						--TriggerClientEvent('esx:showNotification', source, _U('not_enough_stonew'))
						Transform(source, zone)
					end)
				end
			end
		elseif zone == "TraitementStoneW" then
			local itemQuantity = xPlayer.getInventoryItem('wood').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_stone'))
				return
			else
				SetTimeout(1800, function()
					xPlayer.removeInventoryItem('wood', 1)
					xPlayer.addInventoryItem('washed_wood', 1)
					Transform(source, zone)	  
				end)
			end
		end
	end	
end	

RegisterServerEvent('esx_bucheronjob:startTransform')
AddEventHandler('esx_bucheronjob:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_bucheronjob:stopTransform')
AddEventHandler('esx_bucheronjob:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre petrol')
		PlayersTransforming[_source]=true
		
	end
end)

local function SellC(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		local NombreDeCoppter = xPlayer.getInventoryItem('cutted_wood').count
		
		if zone == 'SellCopper' then
			if xPlayer.getInventoryItem('cutted_wood').count <= 0 then
				copper = 0
			else
				copper = 1
			end
			
		
			if copper == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('cutted_wood').count <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_ore_sale'))
				copper = 0
				return
			else
				if (copper == 1) then
					SetTimeout(1100, function()
						local argent = math.random(5,8)
						local argentTotal = argent * NombreDeCoppter
						local money = math.random(5,8)
						local moneyTotal = money * NombreDeCoppter
						xPlayer.removeInventoryItem('cutted_wood', NombreDeCoppter)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_lumberjack', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
						
							xPlayer.addMoney(argentTotal)
							societyAccount.addMoney(moneyTotal)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argentTotal)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. moneyTotal)
						end
						SellC(source,zone)
					end)
				end
				
			end
		end
	end
end



RegisterServerEvent('esx_bucheronjob:startSell')
AddEventHandler('esx_bucheronjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		SellC(_source, zone)
	end

end)

AddEventHandler('esx_bucheronjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		SellI(_source, zone)
	end

end)

AddEventHandler('esx_bucheronjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		SellG(_source, zone)
	end

end)

AddEventHandler('esx_bucheronjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		SellD(_source, zone)
	end

end)

RegisterServerEvent('esx_bucheronjob:stopSell')
AddEventHandler('esx_bucheronjob:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_bucheronjob:getStockItem')
AddEventHandler('esx_bucheronjob:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lumberjack', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_bucheronjob:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lumberjack', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_bucheronjob:putStockItems')
AddEventHandler('esx_bucheronjob:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lumberjack', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_bucheronjob:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)
