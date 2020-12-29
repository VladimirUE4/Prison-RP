ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
    --TriggerServerEvent("STAFFMOD:AreYouStaff")
end)


local allowed = false
local StaffMod = false
local NoClip = false
local NoClipSpeed = 2.0
local invisible = false
local PlayerInZone = 0
local ShowName = false
local gamerTags = {}
local pBlips = {}
local armor = 0

local info = {
    NOCLIP = {"Activer/Désactiver le NoClip", 164},
    INVISIBLE = {"Activer/Désactiver l'invisibilité", 160},
    NOM = {"Activer/Désactiver les noms", 158},
    COULEUR = {"Changer de couleur", 157},
}


RegisterNetEvent("STAFFMOD:AreYouStaff")
AddEventHandler("STAFFMOD:AreYouStaff", function()
    allowed = true
end)

RegisterCommand("staffmod", function(source, args, rawCommand)
    --if allowed then
    ESX.TriggerServerCallback('RubyMenu:getUsergroup', function(group)
        playergroup = group
        if playergroup ~= "user" then
            if not StaffMod then
                StaffMod = true
                local couleur = math.random(0,9)
                local model = GetEntityModel(GetPlayerPed(-1))
                armor = GetPedArmour(GetPlayerPed(-1))
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if model == GetHashKey("mp_m_freemode_01") then
                        clothesSkin = {
                            ['bags_1'] = 0, ['bags_2'] = 0,
                            ['tshirt_1'] = 15, ['tshirt_2'] = 2,
                            ['torso_1'] = 178, ['torso_2'] = couleur,
                            ['arms'] = 31,
                            ['pants_1'] = 77, ['pants_2'] = couleur,
                            ['shoes_1'] = 55, ['shoes_2'] = couleur,
                            ['mask_1'] = 0, ['mask_2'] = 0,
                            ['bproof_1'] = 0,
                            ['chain_1'] = 0,
                            ['helmet_1'] = 91, ['helmet_2'] = couleur,
                        }
                    else
                        clothesSkin = {
                            ['bags_1'] = 0, ['bags_2'] = 0,
                            ['tshirt_1'] = 31, ['tshirt_2'] = 0,
                            ['torso_1'] = 180, ['torso_2'] = couleur,
                            ['arms'] = 36, ['arms_2'] = 0,
                            ['pants_1'] = 79, ['pants_2'] = couleur,
                            ['shoes_1'] = 58, ['shoes_2'] = couleur,
                            ['mask_1'] = 0, ['mask_2'] = 0,
                            ['bproof_1'] = 0,
                            ['chain_1'] = 0,
                            ['helmet_1'] = 90, ['helmet_2'] = couleur,
                        }
                    end
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end)
            else
                StaffMod = false
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0
                    TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                            TriggerEvent('esx:restoreLoadout')
                        end)
                    end)
                end)
                SetPedArmour(GetPlayerPed(-1), armor)

                FreezeEntityPosition(GetPlayerPed(-1), false)
                NoClip = false

                SetEntityVisible(GetPlayerPed(-1), 1, 0)
                NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)

                for _, v in pairs(GetActivePlayers()) do
                    RemoveMpGamerTag(gamerTags[v])
                end

                for k,v in pairs(pBlips) do
                    RemoveBlip(v)
                end
            end
        end
    end)
end, false)



Citizen.CreateThread(function()
    AddTextEntry("NOCLIP", info['NOCLIP'][1])
    AddTextEntry("INVISIBLE", info['INVISIBLE'][1])
    AddTextEntry("NOM", info['NOM'][1])
    AddTextEntry("COULEUR", info['COULEUR'][1])
    TriggerServerEvent("STAFFMOD:AreYouStaff")
end)

local pPed = GetPlayerPed(-1)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        pPed = GetPlayerPed(-1)
        if StaffMod then
            local players = GetActivePlayers()
            for k,v in pairs(pBlips) do
                RemoveBlip(v)
            end
            for k,v in pairs(players) do
                local ped = GetPlayerPed(v)
                local blip = AddBlipForEntity(ped)
                table.insert(pBlips, blip)
                SetBlipScale(blip, 0.85)
                if IsPedOnAnyBike(ped) then
                    SetBlipSprite(blip, 226)
                elseif IsPedInAnyHeli(ped) then
                    SetBlipSprite(blip, 422)
                elseif IsPedInAnyPlane(ped) then
                    SetBlipSprite(blip, 307)
                elseif IsPedInAnyVehicle(ped, false) then
                    SetBlipSprite(blip, 523)
                else
                    SetBlipSprite(blip, 1)
                end

                if IsPedInAnyPoliceVehicle(ped) then
                    SetBlipSprite(blip, 56)
                    SetBlipColour(blip, 3)
                end
                SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
            end
        end
    end
end)


Citizen.CreateThread(function()
    local attente = 500
    while true do
        Wait(attente)
        if StaffMod then
            attente = 1
            if IsControlJustReleased(1, 164) then
                if not NoClip then
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                    NoClip = true
                else
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    SetEntityCollision(pPed, 1, 1)
                    NoClip = false
                end
            end

            if NoClip then
                
                local pCoords = GetEntityCoords(pPed, false)
                local camCoords = getCamDirection()
                SetEntityVelocity(pPed, 0.01, 0.01, 0.01)
                SetEntityCollision(pPed, 0, 1)
            
                if IsControlPressed(0, 32) then
                    pCoords = pCoords + (NoClipSpeed * camCoords)
                end
            
                if IsControlPressed(0, 269) then
                    pCoords = pCoords - (NoClipSpeed * camCoords)
                end

                if IsControlPressed(1, 15) then
                    NoClipSpeed = NoClipSpeed + 0.5
                end
                if IsControlPressed(1, 14) then
                    NoClipSpeed = NoClipSpeed - 0.5
                    if NoClipSpeed < 0 then
                        NoClipSpeed = 0
                    end
                end
                SetEntityCoordsNoOffset(pPed, pCoords, true, true, true)
            end

            if IsControlJustReleased(1, 160) then
                if not invisible then
                    invisible = true
                else
                    invisible = false
                end
            end

            if invisible then
                SetEntityVisible(pPed, 0, 0)
                NetworkSetEntityInvisibleToNetwork(pPed, 1)
            else
                SetEntityVisible(pPed, 1, 0)
                NetworkSetEntityInvisibleToNetwork(pPed, 0)
            end

            if IsControlJustReleased(1, 158) then
                if not ShowName then
                    ShowName = true
                else
                    ShowName = false
                end
            end

            if ShowName then
                local pCoords = GetEntityCoords(pPed, false)
                for _, v in pairs(GetActivePlayers()) do
                    local otherPed = GetPlayerPed(v)
                
                    if otherPed ~= pPed then
                        if #(pCoords - GetEntityCoords(otherPed, false)) < 250.0 then
                            gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
                            SetMpGamerTagVisibility(gamerTags[v], 4, 1)
                        else
                            RemoveMpGamerTag(gamerTags[v])
                            gamerTags[v] = nil
                        end
                    end
                end
            else
                for _, v in pairs(GetActivePlayers()) do
                    RemoveMpGamerTag(gamerTags[v])
                end
            end

            for k,v in pairs(GetActivePlayers()) do
                if NetworkIsPlayerTalking(v) then
                    local pPed = GetPlayerPed(v)
                    local pCoords = GetEntityCoords(pPed)
                    DrawMarker(0, pCoords.x, pCoords.y, pCoords.z+1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 1, 2, 0, nil, nil, 0)
                end
            end

            if IsControlJustReleased(1, 157) then
                local couleur = math.random(0,9)
                TriggerEvent('skinchanger:getSkin', function(skin)
                    local clothesSkin = {
                        ['torso_2'] = couleur,
                        ['pants_2'] = couleur,
                        ['shoes_2'] = couleur,
                        ['helmet_2'] = couleur,
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end)
            end

            SetInstructionalButton("NOCLIP", info['NOCLIP'][2], true)
            SetInstructionalButton("INVISIBLE", info['INVISIBLE'][2], true)
            SetInstructionalButton("NOM", info['NOM'][2], true)
            SetInstructionalButton("COULEUR", info['COULEUR'][2], true)
        else
            SetInstructionalButton("NOCLIP", info['NOCLIP'][2], false)
            SetInstructionalButton("INVISIBLE", info['INVISIBLE'][2], false)
            SetInstructionalButton("NOM", info['NOM'][2], false)
            SetInstructionalButton("COULEUR", info['COULEUR'][2], false)
            attente = 500
        end
    end
end)


RMenu.Add('STAFF', 'main', RageUI.CreateMenu("STAFF", " "))
RMenu:Get('STAFF', 'main'):SetSubtitle("~b~Menu intéraction STAFF")
RMenu:Get('STAFF', 'main').EnableMouse = false
RMenu:Get('STAFF', 'main').Closed = function()
    -- TODO Perform action
end;

local ServersIdSession = {}

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(ServersIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(ServersIdSession, GetPlayerServerId(v))
            end
        end
    end
end)

RMenu.Add('STAFF', 'joueurs', RageUI.CreateSubMenu(RMenu:Get('STAFF', 'main'), "Citoyen", "~b~Intéraction citoyen"))
RMenu.Add('STAFF', 'sanction', RageUI.CreateSubMenu(RMenu:Get('STAFF', 'joueurs'), "Sanction", "~b~Intéraction citoyen"))

local WarnType = {
    "Freekill",
    "Provocation inutile LSPD (ForceRP)",
    "HRP VOCAL",
    "Conduite HRP",
    "NoFear",
    "NoPain",
    "Parle coma, les mort ça parle pas.",
    "Troll",
    "PowerGaming",
    "Insultes",
    "Non respect du staff",
    "MetaGaming",
    "ForceRP",
    "FreeShoot",
    "FreePunch",
    "Tire en zone safe",
    "Non respect du mass RP",
    "Rentre dans les quartiers",
    "Vole de véhicule en zone safe",
    "Vole de véhicule de fonction (LSPD, EMS etc...)",
    "Autre...(Entrer la raison)",
}

local IdSelected = 0
RageUI.CreateWhile(1.0, function()
    if not StaffMod then Wait(500) end
    if IsControlJustPressed(1, 38) and StaffMod then
        RageUI.Visible(RMenu:Get('STAFF', 'main'), not RageUI.Visible(RMenu:Get('STAFF', 'main')))
    end

    if RageUI.Visible(RMenu:Get('STAFF', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Joueurs en session", "Ouvre le menu avec la liste des joueurs présent dans votre session", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('STAFF', 'joueurs'))
        
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('STAFF', 'joueurs')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()
            for k,v in ipairs(ServersIdSession) do
                if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(ServersIdSession, k) end
                RageUI.Button("["..v.."] - "..GetPlayerName(GetPlayerFromServerId(v)), nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        IdSelected = v
                    end
                end, RMenu:Get('STAFF', 'sanction'))
            end
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('STAFF', 'sanction')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()
            RageUI.Button("Joueur: ["..IdSelected.."] - "..GetPlayerName(GetPlayerFromServerId(IdSelected)), nil, {}, true, function(Hovered, Active, Selected)
            end)

            for k,v in pairs(WarnType) do
                RageUI.Button("Warn: "..v, nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if v == "Autre...(Entrer la raison)" then
                            AddTextEntry("Entrer la raison", "")
                            DisplayOnscreenKeyboard(1, "Entrer la raison", '', "", '', '', '', 128)
                        
                            while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                                Citizen.Wait(0)
                            end
                        
                            if UpdateOnscreenKeyboard() ~= 2 then
                                raison = GetOnscreenKeyboardResult()
                                Citizen.Wait(1)
                            else
                                Citizen.Wait(1)
                            end
                            TriggerServerEvent("STAFFMOD:RegisterWarn", IdSelected, raison)
                        else
                            TriggerServerEvent("STAFFMOD:RegisterWarn", IdSelected, v)
                        end
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end

end, 1)



RegisterNetEvent("STAFFMOD:RegisterWarn")
AddEventHandler("STAFFMOD:RegisterWarn", function(reason)
    SetAudioFlag("LoadMPData", 1)
    PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    ShowFreemodeMessage("Avertissement", "Tu à été warn pour: "..reason, 5)
end)



function ShowFreemodeMessage(title, msg, sec)
	local scaleform = _RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

	BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
	PushScaleformMovieMethodParameterString(title)
	PushScaleformMovieMethodParameterString(msg)
	EndScaleformMovieMethod()

	while sec > 0 do
		Citizen.Wait(1)
		sec = sec - 0.01

		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function _RequestScaleformMovie(movie)
	local scaleform = RequestScaleformMovie(movie)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	return scaleform
end

function Popup(txt)
	ClearPrints()
	SetNotificationBackgroundColor(140)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(txt)
	DrawNotification(false, true)
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(pPed)
	local pitch = GetGameplayCamRelativePitch()
	local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

	if len ~= 0 then
		coords = coords / len
	end

	return coords
end


local connected = false

AddEventHandler("playerSpawned", function()
	if not connected then
		TriggerServerEvent("rocademption:playerConnected")
		connected = true
	end
end)