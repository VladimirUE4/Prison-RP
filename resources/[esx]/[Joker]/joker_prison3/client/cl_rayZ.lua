local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

local menuIsShowed	= false
local hasAlreadyEnteredMarker = false
local lastZone = nil
local isInjaillistingMarker = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function Loading()
	local pPed = PlayerPedId()
	local vehHash = -2007026063
	
	while not HasModelLoaded(vehHash) do RequestModel(vehHash)
		Wait(0)
	end
	
	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	ESX.ShowNotification("~r~Convoyeur~s~\nRadio : Le convoi a démarré !")

	vehicle = CreateVehicle(vehHash, -845.54, 5440.25, 34.26, 300.42, true, 1)
	SetVehicleDoorsLocked(vehicle, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle2 = CreateVehicle(vehHash, 2491.891, 5511.68, 44.71, 192, true, 1)
	SetVehicleDoorsLocked(vehicle2, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle2, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle3 = CreateVehicle(vehHash, 2410.89, 2911.53, 49.29, 34.57, true, 1)
	SetVehicleDoorsLocked(vehicle3, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle3, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle4 = CreateVehicle(vehHash, 1907.95, 2609.313, 45.77, 87.02, true, 1)
	SetVehicleDoorsLocked(vehicle4, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle4, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)
	DeleteEntity(vehicle)
	DeleteEntity(vehicle2)
	DeleteEntity(vehicle3)
	DeleteEntity(vehicle4)
end

function Teleport()
	local pPed = PlayerPedId()

    ESX.Game.Teleport(pPed, {x = 1753.73, y = 2566.03, z = 45.38}, function()
	end)

	ESX.ShowNotification("~g~Détenue~s~\nBa alors de retour en Prison ?")
end


function ShowJailListingMenu(data)	

		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'jaillisting',
			{
				title    = _U('jail_center'),
				elements = {
				{label = _U('jail_convoi'), value = 'prison'},
			},
			},
			function(data, menu)
			local ped = GetPlayerPed(-1)
			menu.close()

			if data.current.value == 'prison' then 
				Loading()
				Teleport()
			end
		end,
			function(data, menu)
				menu.close()
			end
		)
end

AddEventHandler('rayZ_prison:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- Ouvrir menu quand joueur est sur position --
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		isInJaillistingMarker = false
		local currentZone = nil
		for i=1, #Config.Zones, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.ZoneSize.x) then
				isInJaillistingMarker  = true
				SetTextComponentFormat('STRING')
            	AddTextComponentString(_U('access_jail_center'))
            	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		end
		if isInJaillistingMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isInJaillistingMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('rayZ_prison:hasExitedMarker')
		end
	end
end)



-- Menu Controls --
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, Keys['E']) and isInJaillistingMarker and not menuIsShowed then
			ShowJailListingMenu()
		end
	end
end)

-- Ped --

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_m_prisguard_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_prisguard_01",-841.35, 5401.35, 33.615, 301.02, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end) 
