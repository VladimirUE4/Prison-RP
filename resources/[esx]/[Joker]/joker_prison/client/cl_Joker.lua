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

	ESX.ShowNotification("~r~Convoyeur~s~\nRadio : Le convoi a démarré ! Sécurisez l'entrée de la Prison")

	vehicle = CreateVehicle(vehHash, 1801.20, 2605.99, 45.56, 269.26, true, 1)
	SetVehicleDoorsLocked(vehicle, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle2 = CreateVehicle(vehHash, 1875.56, 2952.76, 45.74, 279.32, true, 1)
	SetVehicleDoorsLocked(vehicle2, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle2, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle3 = CreateVehicle(vehHash, 2401.505, 2913.46, 49.32, 208.26, true, 1)
	SetVehicleDoorsLocked(vehicle3, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle3, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle4 = CreateVehicle(vehHash, 2887.84, 2809.16, 54.63, 240.25, true, 1)
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

    ESX.Game.Teleport(pPed, {x = 2963.1701, y = 2748.41, z = 43.36}, function()
	end)

	ESX.ShowNotification("~g~Patron Mineur~s~\nAu travaille et plus vite que sa !")
end

function Loading1()
	local pPed = PlayerPedId()
	local vehHash = -2007026063
	
	while not HasModelLoaded(vehHash) do RequestModel(vehHash)
		Wait(0)
	end
	
	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	ESX.ShowNotification("~r~Convoyeur~s~\nRadio : Le convoi a démarré ! Sécurisez l'entrée de la Prison")

	vehicle = CreateVehicle(vehHash, 1897.0350, 2600.87, 45.72, 274.81, true, 1)
	SetVehicleDoorsLocked(vehicle, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle2 = CreateVehicle(vehHash, 1314.72, 2684.95, 37.68, 89.03, true, 1)
	SetVehicleDoorsLocked(vehicle2, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle2, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle3 = CreateVehicle(vehHash, 217.09, 2449.49, 57.21, 171.67, true, 1)
	SetVehicleDoorsLocked(vehicle3, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle3, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle4 = CreateVehicle(vehHash, -605.70, 2113.26, 127.09, 201.64, true, 1)
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

function Teleport1()
	local pPed = PlayerPedId()

    ESX.Game.Teleport(pPed, {x = -595.206, y = 2086.191, z = 131.41}, function()
	end)

	ESX.ShowNotification("~g~Patron Mineur~s~\nAu travaille et plus vite que sa !")
end

function Loading2()
	local pPed = PlayerPedId()
	local vehHash = -2007026063
	
	while not HasModelLoaded(vehHash) do RequestModel(vehHash)
		Wait(0)
	end
	
	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	ESX.ShowNotification("~r~Convoyeur~s~\nRadio : Le convoi a démarré !")

	vehicle = CreateVehicle(vehHash, 1894.87, 2600.61, 45.72, 268.94, true, 1)
	SetVehicleDoorsLocked(vehicle, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle2 = CreateVehicle(vehHash, 2227.70, 2747.51, 45.28, 301.79, true, 1)
	SetVehicleDoorsLocked(vehicle2, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle2, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle3 = CreateVehicle(vehHash, -309.04, 6076.05, 31.20, 130.36, true, 1)
	SetVehicleDoorsLocked(vehicle3, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle3, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle4 = CreateVehicle(vehHash, -782.777, 5431.79, 36.00, 101.08, true, 1)
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

function Teleport2()
	local pPed = PlayerPedId()

    ESX.Game.Teleport(pPed, {x = -803.306, y = 5423.62, z = 34.38}, function()
	end)

	ESX.ShowNotification("~g~Patron Bucheron~s~\nAu travaille et plus vite que sa !")
end

function Loading3()
	local pPed = PlayerPedId()
	local vehHash = -2007026063
	
	while not HasModelLoaded(vehHash) do RequestModel(vehHash)
		Wait(0)
	end
	
	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	ESX.ShowNotification("~r~Convoyeur~s~\nRadio : Le convoi a démarré ! Sécurisez l'entrée de la Prison")

	vehicle = CreateVehicle(vehHash, 1897.0350, 2600.87, 45.72, 274.81, true, 1)
	SetVehicleDoorsLocked(vehicle, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle2 = CreateVehicle(vehHash, 2933.80, 3977.62, 51.65, 6.81, true, 1)
	SetVehicleDoorsLocked(vehicle2, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle2, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle3 = CreateVehicle(vehHash, -76.83, 6309.48, 31.33, 133.26, true, 1)
	SetVehicleDoorsLocked(vehicle3, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle3, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle4 = CreateVehicle(vehHash, -808.17, 5420.24, 34.07, 292.07, true, 1)
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

function Teleport3()
	local pPed = PlayerPedId()

    ESX.Game.Teleport(pPed, {x = -801.83, y = 5403.91, z = 34.15}, function()
	end)

	ESX.ShowNotification("~g~Patron Bucheron~s~\nAu travaille et plus vite que sa !")
end

function ShowJailListingMenu(data)	

		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'jaillisting',
			{
				title    = _U('jail_center'),
				elements = {
				{label = _U('test_test2'), value = 'null'},
				{label = _U('jail_convoi'), value = 'prison'},
				{label = _U('jail_convoi1'), value = 'prison1'},
				{label = _U('test_test'), value = 'null'},
				{label = _U('jail_convoi2'), value = 'prison2'},
				{label = _U('jail_convoi3'), value = 'prison3'},
			},
			},
			function(data, menu)
			local ped = GetPlayerPed(-1)
			menu.close()

			if data.current.value == 'prison' then 
				Loading()
				Teleport()
			end
			if data.current.value == 'prison1' then 
				Loading1()
				Teleport1()
			end
			if data.current.value == 'prison2' then 
				Loading2()
				Teleport2()
			end
			if data.current.value == 'prison3' then 
				Loading3()
				Teleport3()
			end
		end,
			function(data, menu)
				menu.close()
			end
		)
end

AddEventHandler('Joker_prison:hasExitedMarker', function(zone)
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
			TriggerEvent('Joker_prison:hasExitedMarker')
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
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_prisguard_01",1758.69, 2569.18, 44.56, 178.65, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end) 
