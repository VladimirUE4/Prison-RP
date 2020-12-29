ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingCoke    = {}
local PlayersTransformingCoke  = {}
local PlayersSellingCoke       = {}
local PlayersHarvestingMeth    = {}
local PlayersTransformingMeth  = {}
local PlayersSellingMeth       = {}
local PlayersHarvestingWeed    = {}
local PlayersTransformingWeed  = {}
local PlayersSellingWeed       = {}
local PlayersHarvestingOpium   = {}
local PlayersTransformingOpium = {}
local PlayersSellingOpium      = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

--weed
local function HarvestWeed(source)
	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToFarm, function()
		if PlayersHarvestingWeed[source] then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local weed = xPlayer.getInventoryItem('weed')

			if weed.limit ~= -1 and weed.count >= weed.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('inv_full_weed'))
			else
				xPlayer.addInventoryItem('weed', 1)
				HarvestWeed(_source)
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestWeed1')
AddEventHandler('esx_drugs:startHarvestWeed1', function()
	local _source = source

	if not PlayersHarvestingWeed[_source] then
		PlayersHarvestingWeed[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))
		HarvestWeed(_source)
	else
		print(('esx_drugs: %s attempted to exploit the zone!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:stopHarvestWeed1')
AddEventHandler('esx_drugs:stopHarvestWeed1', function()
	local _source = source

	PlayersHarvestingWeed[_source] = false
end)

local function TransformWeed(source)
	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToProcess, function()
		if PlayersTransformingWeed[source] then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local weedQuantity = xPlayer.getInventoryItem('weed').count
			local pooch = xPlayer.getInventoryItem('weed_pooch')

			if pooch.limit ~= -1 and pooch.count >= pooch.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('too_many_pouches'))
			elseif weedQuantity < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_weed'))
			else
				xPlayer.removeInventoryItem('weed', 5)
				xPlayer.addInventoryItem('weed_pooch', 1)

				TransformWeed(_source)
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformWeed1')
AddEventHandler('esx_drugs:startTransformWeed1', function()
	local _source = source

	if not PlayersTransformingWeed[_source] then
		PlayersTransformingWeed[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))
		TransformWeed(_source)
	else
		print(('esx_drugs: %s attempted to exploit the zone!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:stopTransformWeed1')
AddEventHandler('esx_drugs:stopTransformWeed1', function()
	local _source = source

	PlayersTransformingWeed[_source] = false
end)

local function SellWeed(source)
	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToSell, function()
		if PlayersSellingWeed[source] then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('weed_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 20)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_weed'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 40)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_weed'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 50)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_weed'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 60)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_weed'))
				elseif CopsConnected >= 4 then
					xPlayer.addAccountMoney('black_money', 70)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_weed'))
				end

				SellWeed(_source)
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startSellWeed1')
AddEventHandler('esx_drugs:startSellWeed1', function()
	local _source = source

	if not PlayersSellingWeed[_source] then
		PlayersSellingWeed[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		SellWeed(_source)
	else
		print(('esx_drugs: %s attempted to exploit the zone!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:stopSellWeed1')
AddEventHandler('esx_drugs:stopSellWeed1', function()
	local _source = source

	PlayersSellingWeed[_source] = false
end)

--opium
local function HarvestOpium(source)
	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToFarm, function()
		if PlayersHarvestingOpium[source] then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local opium = xPlayer.getInventoryItem('opium')

			if opium.limit ~= -1 and opium.count >= opium.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('inv_full_opium'))
			else
				xPlayer.addInventoryItem('opium', 1)
				HarvestOpium(_source)
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestOpium1')
AddEventHandler('esx_drugs:startHarvestOpium1', function()
	local _source = source

	if not PlayersHarvestingOpium[_source] then
		PlayersHarvestingOpium[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))
		HarvestOpium(_source)
	else
		print(('esx_drugs: %s attempted to exploit the zone!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:stopHarvestOpium1')
AddEventHandler('esx_drugs:stopHarvestOpium1', function()
	local _source = source

	PlayersHarvestingOpium[_source] = false
end)

local function TransformOpium(source)
	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToProcess, function()
		if PlayersTransformingOpium[source] then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local opiumQuantity = xPlayer.getInventoryItem('opium').count
			local pooch = xPlayer.getInventoryItem('opium_pooch')

			if pooch.limit ~= -1 and pooch.count >= pooch.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('too_many_pouches'))
			elseif opiumQuantity < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_opium'))
			else
				xPlayer.removeInventoryItem('opium', 5)
				xPlayer.addInventoryItem('opium_pooch', 1)
			
				TransformOpium(_source)
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformOpium1')
AddEventHandler('esx_drugs:startTransformOpium1', function()
	local _source = source

	if not PlayersTransformingOpium[_source] then
		PlayersTransformingOpium[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))
		TransformOpium(_source)
	else
		print(('esx_drugs: %s attempted to exploit the zone!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:stopTransformOpium1')
AddEventHandler('esx_drugs:stopTransformOpium1', function()
	local _source = source

	PlayersTransformingOpium[_source] = false
end)

local function SellOpium(source)
	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToSell, function()
		if PlayersSellingOpium[source] then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('opium_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 500)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_opium'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 600)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_opium'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 700)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_opium'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 800)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_opium'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 900)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_opium'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_opium'))
				elseif CopsConnected >= 6 then
					xPlayer.addAccountMoney('black_money', 1100)
					TriggerClientEvent('esx:showNotification', _source, _U('sold_one_opium'))
				end

				SellOpium(source)
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startSellOpium1')
AddEventHandler('esx_drugs:startSellOpium1', function()
	local _source = source

	if not PlayersSellingOpium[_source] then
		PlayersSellingOpium[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		SellOpium(_source)
	else
		print(('esx_drugs: %s attempted to exploit the zone!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_drugs:stopSellOpium1')
AddEventHandler('esx_drugs:stopSellOpium1', function()
	local _source = source

	PlayersSellingOpium[_source] = false
end)

RegisterServerEvent('esx_drugs:GetUserInventory')
AddEventHandler('esx_drugs:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_drugs:ReturnInventory',
		_source,
		xPlayer.getInventoryItem('coke').count,
		xPlayer.getInventoryItem('coke_pooch').count,
		xPlayer.getInventoryItem('meth').count,
		xPlayer.getInventoryItem('meth_pooch').count,
		xPlayer.getInventoryItem('weed').count,
		xPlayer.getInventoryItem('weed_pooch').count,
		xPlayer.getInventoryItem('opium').count,
		xPlayer.getInventoryItem('opium_pooch').count,
		xPlayer.job.name,
		currentZone
	)
end)

ESX.RegisterUsableItem('weed', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('weed', 1)

	TriggerClientEvent('esx_drugs:onPot', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_weed'))
end)

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------