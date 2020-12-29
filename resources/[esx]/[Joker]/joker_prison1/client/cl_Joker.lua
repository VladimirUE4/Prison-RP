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

	vehicle = CreateVehicle(vehHash, -597.29, 2112.36, 128.07, 3.98797607422, true, 1)
	SetVehicleDoorsLocked(vehicle, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle2 = CreateVehicle(vehHash, -728.11, 2286.84, 75.56, 36.43, true, 1)
	SetVehicleDoorsLocked(vehicle2, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle2, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle3 = CreateVehicle(vehHash, 626.63, 2695.92, 41.422, 270.98797607422, true, 1)
	SetVehicleDoorsLocked(vehicle3, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle3, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle4 = CreateVehicle(vehHash, 1853.35, 2608.53, 45.672, 89.98797607422, true, 1)
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

	ESX.ShowNotification("~g~Garde~s~\nBienvenue à la prison !")
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

	ESX.ShowNotification("~r~Convoyeur~s~\nRadio : Le convoi a démarré !")

	vehicle = CreateVehicle(vehHash, -597.29, 2112.36, 128.07, 3.98797607422, true, 1)
	SetVehicleDoorsLocked(vehicle, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle2 = CreateVehicle(vehHash, 353.66, 2086.82, 100.25, 274.31, true, 1)
	SetVehicleDoorsLocked(vehicle2, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle2, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle3 = CreateVehicle(vehHash, 1357.65, 2682.97, 37.705, 283.25, true, 1)
	SetVehicleDoorsLocked(vehicle3, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle3, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle4 = CreateVehicle(vehHash, 2560.64, 2707.22, 42.04, 292.40, true, 1)
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

    ESX.Game.Teleport(pPed, {x = 2953.855, y = 2806.94, z = 41.72}, function()
	end)

	ESX.ShowNotification("~g~Garde~s~\nBienvenue à la mine !")
end

function ShowJailListingMenu(data)	

		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'jaillisting',
			{
				title    = _U('jail_center'),
				elements = {
				{label = _U('jail_convoi'), value = 'prison'},
				{label = _U('jail_convoi1'), value = 'prison1'},
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
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_prisguard_01",-595.42, 2087.90, 130.56, 189.4106185436249, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end) 