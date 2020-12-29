ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RMenu.Add('poleemploi', 'main', RageUI.CreateMenu("Petit JOB", "~b~Menu~s~ Petit JOB"))
RMenu.Add('poleemploi', 'metier', RageUI.CreateMenu("Petit JOB", "~b~Menu~s~ Metier"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('poleemploi', 'main'), true, true, true, function()
            RageUI.Button("---------------------- Liste des Métiers -------------------------", "Liste des Métiers", {}, true, function(Hovered, Active, Selected)
            if (Selected) then
            end
        end)
      -------------------------------------- Sous Menu ------------------------------------
      RageUI.Button("Métiers", "Liste des Métiers", {RightLabel = "→→→"}, true, function()
      end, RMenu:Get('poleemploi', 'metier'))


      RageUI.Button("------------------- Choisissez votre metier ---------------------", "Choisissez votre metier", {}, true, function(Hovered, Active, Selected)
            if (Selected) then
            end
        end)

    end, function()
    end)

    ------------------------------- Metier --------------------------------------------------------

    RageUI.IsVisible(RMenu:Get('poleemploi', 'metier'), true, true, true, function()
        RageUI.Button("~g~Travaillé~s~ : Mineur", "Travaillé Mineur", {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                TriggerServerEvent('powx_joblisting:setJobMineur')

                PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)

                ESX.ShowAdvancedNotification('Petit JOB', '~b~Annonce Petit JOB', 'Vous etes désormais ~b~Mineur.', 'CHAR_ALL_PLAYERS_CONF', 8)
            end
        end)
            RageUI.Button("~g~Travaillé~s~ : Bucheron", "Travaillé Bucheron", {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                TriggerServerEvent('powx_joblisting:setJobBucheron')

                PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)

                ESX.ShowAdvancedNotification('Petit JOB', '~b~Annonce Petit JOB', 'Vous etes désormais ~b~Bucheron.', 'CHAR_ALL_PLAYERS_CONF', 8)
            end
        end)
        RageUI.Button("~g~Redevenir~s~ : Prisonnier", "Depart a la retraite", {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                TriggerServerEvent('powx_joblisting:setJobChômeur')

                PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)

                ESX.ShowAdvancedNotification('Petit JOB', '~b~Annonce Petit JOB', 'Vous etes de nouveau Prisonnier', 'CHAR_ALL_PLAYERS_CONF', 8)
            end
        end)


        end, function()
        end, 1)
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

     if Vdist2(GetEntityCoords(PlayerPedId(), false), 1669.16, 2517.44, 45.56) < 1.0 then
        ESX.ShowHelpNotification('Appuyez sur [E] pour acceder au ~b~Petit JOB')
         if IsControlJustPressed(1,51) then 
            RageUI.Visible(RMenu:Get('poleemploi', 'main'), not RageUI.Visible(RMenu:Get('poleemploi', 'main')))
         end
        end
    end
end)

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)



-- By PowX#2629