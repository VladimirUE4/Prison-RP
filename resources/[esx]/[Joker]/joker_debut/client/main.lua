ESX = nil
HaveThermal                     = true
local BoxContainerModel         = nil
local InteractNPC               = nil
local InteractNPC_CurrentAction = nil
local blip = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while InteractNPC == nil do		
		TriggerEvent('genesis_heist_thermal:createPed')
		Citizen.Wait(2500)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		TriggerEvent('genesis-holdUp:thermalSync', HaveThermal)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.InteractionZones, 1 do 
			if GetDistanceBetweenCoords(playerCoords, Config.InteractionZones[i].x, Config.InteractionZones[i].y, Config.InteractionZones[i].z, true) <= 2.0 then
				--StartThermalPickupProcess()
				StartThermalBuyProcess() --
				Loading()
				Teleport()
				Citizen.Wait(500) --
			--	DoScreenFadeOut(500)
				Citizen.Wait(500)
				DoScreenFadeIn(300)
			end
		end
	end
end)

local cinema = false
local blockinput = false
function ToggleHUD(bool)
	if bool == true then
		blockinput = true
		cinema = true
		TriggerEvent('es:setMoneyDisplay', 0.0)
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
		DisplayRadar(false)
	else
		blockinput = false
		cinema = false
		TriggerEvent('es:setMoneyDisplay', 1.0)
		ESX.UI.HUD.SetDisplay(1.0)
		TriggerEvent('esx_status:setDisplay', 1.0)
	end
end

function StartThermalPickupProcess()
	RemoveBlip(blip)
	--TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 1, true)
--	DoScreenFadeOut(300)
---	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.5, 'crateOpen', 0.5)
	Wait(500)
	--TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.5, 'crateOpen', 0.8)
--	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.5, 'zip', 0.8)
	--DeleteObject(BoxContainerModel)
	--BoxContainerModel = nil

	TriggerEvent('skinchanger:getSkin',function(skin)
	
		if skin.sex == 0 then
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 5, ['torso_2'] = 0,
				['pants_1'] = 9, ['pants_2'] = 4,
				['shoes_1'] = 61,    ['shoes_2'] = 0,
				['bags_1'] = 41, ['bags_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		else
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 23, ['torso_2'] = 0,
				['pants_1'] = 3, ['pants_2'] = 15,
				['arms'] = 15,
				['shoes_1'] = 64,    ['shoes_2'] = 0,
				['bags_1'] = 41, ['bags_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)	
	HaveThermal = true
	DoScreenFadeIn(1000)
	ClearPedTasks(GetPlayerPed(-1))
end

function StartThermalBuyProcess()
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(cam, 465.1441345214844, -993.0123291015625, 26.6514209594727) -- Position de la caméra
	SetCamRot(cam, -20.0, 0.0, 130.72, 0)
	RenderScriptCams(1, 0, 0, 1, 1)
	ToggleHUD(true) -- Bandes noir

	TaskGoToCoordAnyMeans(GetPlayerPed(-1), 463.857421875, -1008.852783203125, 24.589622497558594, 1.0, 0, 0, 786603, 1.0) -- Ou il s'arette avant de repartir
	Wait(4000)
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(cam, 469.8723449707031, -1011.2083129882812, 27.91393661499027) -- Position de la caméra 2
	SetCamRot(cam, -20.0, 0.0, 66.36, 0)
	RenderScriptCams(1, 0, 0, 1, 1)
	--
	Citizen.Wait(1000)
	ESX.ShowNotification("~r~Convoyeur~s~\nRadio : Le détenu est sorti du commissariat ! Préparer le convoi !")
	ClearPedTasks(InteractNPC)
	Citizen.Wait(3000)
	SetEntityHeading(InteractNPC, 135.08)
	Citizen.Wait(1000)	
	Citizen.Wait(1000)
	DoScreenFadeOut(100)
	DestroyCam(cam, 0)
	RenderScriptCams(0, 0, 1, 1, 1)
	TaskGoToCoordAnyMeans(GetPlayerPed(-1), 468.6607971191406, -1013.4789428710938, 25.413963317871094, 1.0, 0, 0, 786603, 1.0) --termine
	DoScreenFadeIn(600)
	Citizen.Wait(4000)
	ToggleHUD(false)
	EnableControls()	
	SetEntityHeading(InteractNPC, Config.NPCSpawn.Heading)
	InteractNPC_CurrentAction = nil
	TriggerServerEvent('genesis_heist_thermal:buyDrill')

	--ToggleHUD(true) -- Bandes noir
 
end


--RegisterNetEvent('genesis_heist_thermal:notif')
--AddEventHandler('genesis_heist_thermal:notif', function(msg)
--	ESX.ShowNotification(msg)
--end)

--function RichNotif()	
--	SetNotificationTextEntry("STRING")
--    AddTextComponentString('~w~Tytuł: ~y~••••• \n~w~Usługa: ~y~•••••. \n~w~Kwota: ~g~'..Config.ThermalDrillCost..'$')
--	Citizen.InvokeNative(0x92F0DA1E27DB96DC, 200)
--	Citizen.InvokeNative(0x1E6611149DB3DB6B, 'CHAR_BANK_FLEECA', 'CHAR_BANK_FLEECA', true, 7, '-Fleeca Bank-', '~g~Nowa transakcja', 2.0)
--    DrawNotification_4(true, true)
--end
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

	vehicle = CreateVehicle(vehHash, 503.61419677734, -1019.391418457, 27.043809890747, 357.98797607422, true, 1)
	SetVehicleDoorsLocked(vehicle, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	vehicle2 = CreateVehicle(vehHash, 1692.033, 2605.94, 45.56, 96.43, true, 1)
	SetVehicleDoorsLocked(vehicle2, 4)
	TaskWarpPedIntoVehicle(pPed, vehicle2, 2)

	Wait(2000)

	DoScreenFadeOut(2000)
	Wait(2000)
	DoScreenFadeIn(2000)

	DeleteEntity(vehicle)
	DeleteEntity(vehicle2)
end

function Teleport()
	local pPed = PlayerPedId()

    ESX.Game.Teleport(pPed, {x = 1689.18, y = 2529.29, z = 45.56}, function()
	end)

	ESX.ShowNotification("~g~Personnage~s~\nBienvenue en Prison !")
    	pPed.addInventoryItem('cartebanque', 1) 
 	ESX.ShowNotification("~g~Banque~s~\nVoici ta carte bancaire !")
end


function EnableControls()
	EnableAllControlActions(0)
	EnableAllControlActions(1)
	EnableAllControlActions(2)
	EnableAllControlActions(3)
	EnableAllControlActions(4)
	EnableAllControlActions(5)
	EnableAllControlActions(6)
	EnableAllControlActions(7)
	EnableAllControlActions(8)
	EnableAllControlActions(9)
	EnableAllControlActions(10)
	EnableAllControlActions(11)
	EnableAllControlActions(12)
	EnableAllControlActions(13)
	EnableAllControlActions(14)
	EnableAllControlActions(15)
	EnableAllControlActions(16)
	EnableAllControlActions(17)
	EnableAllControlActions(18)
	EnableAllControlActions(19)
	EnableAllControlActions(20)
	EnableAllControlActions(21)
	EnableAllControlActions(22)
	EnableAllControlActions(23)
	EnableAllControlActions(24)
	EnableAllControlActions(25)
	EnableAllControlActions(26)
	EnableAllControlActions(27)
	EnableAllControlActions(28)
	EnableAllControlActions(29)
	EnableAllControlActions(30)
	EnableAllControlActions(31)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if cinema then
		local hasCinema = false
			while cinema do
				Wait(5)
				DrawRect(0.5, 0.075, 1.0, 0.15, 0, 0, 0, 255)
				DrawRect(0.5, 0.925, 1.0, 0.15, 0, 0, 0, 255)
				SetDrawOrigin(0.0, 0.0, 0.0, 0)
				DisplayRadar(false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	local count
	while true do
		Citizen.Wait(0)
		if blockinput then
			count = 1
			DisableAllControlActions(0)
			DisableAllControlActions(1)
			DisableAllControlActions(2)
			DisableAllControlActions(3)
			DisableAllControlActions(4)
			DisableAllControlActions(5)
			DisableAllControlActions(6)
			DisableAllControlActions(7)
			DisableAllControlActions(8)
			DisableAllControlActions(9)
			DisableAllControlActions(10)
			DisableAllControlActions(11)
			DisableAllControlActions(12)
			DisableAllControlActions(13)
			DisableAllControlActions(14)
			DisableAllControlActions(15)
			DisableAllControlActions(16)
			DisableAllControlActions(17)
			DisableAllControlActions(18)
			DisableAllControlActions(19)
			DisableAllControlActions(20)
			DisableAllControlActions(21)
			DisableAllControlActions(22)
			DisableAllControlActions(23)
			DisableAllControlActions(24)
			DisableAllControlActions(25)
			DisableAllControlActions(26)
			DisableAllControlActions(27)
			DisableAllControlActions(28)
			DisableAllControlActions(29)
			DisableAllControlActions(30)
			DisableAllControlActions(31)
		else
		Citizen.Wait(500)
		end
	end
end)

--NPC
AddEventHandler('genesis_heist_thermal:createPed', function()
	if InteractNPC ~= nil then
		return
	end

	local model = GetHashKey(Config.NPCModelName)
	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end

		InteractNPC = CreatePed(5, model, Config.NPCSpawn.Pos.x, Config.NPCSpawn.Pos.y, Config.NPCSpawn.Pos.z-1, 0.0, false, true)
		Citizen.Wait(440)
		SetEntityHeading(InteractNPC, Config.NPCSpawn.Heading)
		FreezeEntityPosition(InteractNPC, true)
		SetEntityInvincible(InteractNPC, true)
		SetBlockingOfNonTemporaryEvents(InteractNPC, true)
		TaskStartScenarioInPlace(InteractNPC, 'WORLD_HUMAN_SMOKING', 0, false)
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if InteractNPC ~= nil and InteractNPC_CurrentAction == nil then
			if not IsPedUsingScenario(InteractNPC, 'WORLD_HUMAN_SMOKING') then
				TaskStartScenarioInPlace(InteractNPC, 'WORLD_HUMAN_SMOKING', 0, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)