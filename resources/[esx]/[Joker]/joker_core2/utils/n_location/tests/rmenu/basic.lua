ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
DecorRegister("Yay", 4)
pedHash = "s_m_m_security_01"
zone = vector3(-253.33, -341.24, 28.95)
Heading = 279.8
Ped = nil
HeadingSpawn = 279.61288452148


local zoneDeSpawn = {
    {pos = vector3(-255.71, -343.98, 29.15),heading = 6.7,},
}

function SelectSpawnPoint()
    local found = false
    for k,v in pairs(zoneDeSpawn) do
        local clear = ESX.Game.IsSpawnPointClear(v.pos, 5.0)
        if clear and not found then
            found = true
            return v.pos, v.heading
        end
    end
    return false
end

local dejaSortie = false


Citizen.CreateThread(function()
    LoadModel(pedHash)
    Ped = CreatePed(2, GetHashKey(pedHash), zone, Heading, 0, 0)
    DecorSetInt(Ped, "Yay", 5431)
    FreezeEntityPosition(Ped, 1)
    TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, 1)

    local blip = AddBlipForCoord(zone)
    SetBlipSprite(blip, 464)
    SetBlipScale(blip, 0.85)
    SetBlipShrink(blip, true)
    SetBlipColour(blip, 11)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Véhicule sans permis")
    EndTextCommandSetBlipName(blip)
end)



function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end



RMenu.Add('location', 'main', RageUI.CreateMenu("Location véhicule", " "))
RMenu:Get('location', 'main'):SetSubtitle("~b~LOCATION VEHICULE CIVIL")
RMenu:Get('location', 'main').EnableMouse = false;
RMenu:Get('location', 'main').Closed = function()
    RenderScriptCams(0, 0, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

local veh = {
    "blista",
    "faggio3",
    "Rhapsody",
}

local index = {
    sourie = false,
    veh = 1,
}



RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone, true)
    if distance <= 20.0 then
        DrawMarker(32, zone.x, zone.y, zone.z+2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.15, 0.15, 0.15, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
    end
    if distance <= 3.0 then
        HelpMsg("Appuyer sur ~b~E~w~ pour parler avec la personne.")
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('location', 'main'), not RageUI.Visible(RMenu:Get('location', 'main')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('location', 'main')) then
        RageUI.Text({
            message = string.format("Mmh ? Nouveau en ville ? Ouais j'ai quelques véhicule de location pour les nouveaux comme toi."),
            time_display = 100,
        })
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            ---Items

            RageUI.List("Véhicule", veh, index.veh, "Séléctionner votre véhicule de location.", {}, true, function(Hovered, Active, Selected, Index)
                if Selected then
                    if not dejaSortie then
                        dejaSortie = true
                        RageUI.Visible(RMenu:Get('location', 'main'), not RageUI.Visible(RMenu:Get('location', 'main')))
                        RenderScriptCams(0, 0, 1500, 1, 1)
                        DestroyCam(cam, 1)
                        LoadModel(veh[index.veh])
                        local spawnCo, spawnHeading = SelectSpawnPoint()
                        if spawnCo ~= false then
                            --TriggerEvent("XNL_NET:AddPlayerXP", math.random(100,200))
                            local veh = CreateVehicle(GetHashKey(veh[index.veh]), spawnCo, spawnHeading, true, true)
                            SetEntityAsMissionEntity(veh, 1, 1)
                            SetVehicleHasBeenOwnedByPlayer(veh, 1)
                            SetVehicleNumberPlateText(veh, "GRATUIT")
                            SetVehicleMaxSpeed(veh, 23.0)
                            TriggerEvent("RS_KEY:GiveKey", GetVehicleNumberPlateText(veh))
                            RageUI.Popup({
                                colors = 140,
                                message = "Véhicule de location sortie. Soit prudent sur la route.",
                            })
                            RageUI.Popup({
                                colors = 140,
                                message = "Attention, les véhicule gratuit on leur moteur bridé",
                            })

                            local NotNear = true
                            while NotNear do
                                Citizen.Wait(1)
                                local pVehC = GetEntityCoords(veh)
                                local pCoords = GetEntityCoords(GetPlayerPed(-1))
                                local dst = GetDistanceBetweenCoords(pVehC, pCoords, true)
                                if dst >= 3.0 then
                                    DrawMarker(0, pVehC.x, pVehC.y, pVehC.z+0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 245, 224, 0, 220, 1, 0, 2, 0, nil, nil, 0)
                                else
                                    NotNear = false
                                end
                            end
                        else
                            RageUI.Popup({
                                colors = 140,
                                message = "Aucun point de sortie disponible",
                            })
                        end
                    else
                        RageUI.Popup({
                            colors = 140,
                            message = "Vous avez déja sortie un véhicule gratuit pendant votre session de jeu.",
                        })

                    end
                end
                index.veh = Index;
            end)

        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('location', 'submenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()
            ---Items
        end, function()
            ---Panels
        end)
    end

end, 1)




