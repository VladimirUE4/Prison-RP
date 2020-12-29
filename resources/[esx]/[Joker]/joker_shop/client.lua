ESX = nil
menuOpen = false


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

-- Ca fait spawn le ped, vous pouvez changer le model du ped si vous le souhaitez.
Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_prisoner_01")
    
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end

    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_prisoner_01", 1671.50, 2694.62, 44.56, 81.90, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)


local appleshopmenu = {
    Base = { Title = "~r~Shop Illégal" },
    Data = { currentMenu = "~r~Acheter un objet illégal" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
        -- si vous voulez rajouter un boutton pour close le menu:    self:CloseMenu(true)
              if btn.name == "Iphone X" then
                    TriggerServerEvent('Vato_AppleStore:buy', 1500, "phone", "téléphone")
              end
              if btn.name == "Radio" then
                TriggerServerEvent('Vato_AppleStore:buy', 250, "radio", "radio")
          end
              if btn.name == "Fermer" then
                self:CloseMenu(true)  	
              end
        end,
    },

    Menu = {
        ["~r~Acheter un objet illégal"] = {
            b = {
                {name = "Téléphone", ask = "→", askX = true},
                {name = "Fermer"},
            }
        },

        ["téléphone"] = {
            b = {
                {name = "Iphone X", ask = "~r~1500$", askX = true},
                {name = "Fermer"},
            }
        },

        ["autres"] = {
            b = {
                {name = "Radio", ask = "~g~250$", askX = true},
                {name = "Fermer"},
            }
        },

    }
    
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- on check si le joueur est assez proche du ped
            if Vdist2(GetEntityCoords(PlayerPedId(), false), 1671.50, 2694.62, 44.56) < 5.2 then
              if not menuOpen then
                  ESX.ShowHelpNotification('~r~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu du Shop Illégal', false, true, 1000)
                  if IsControlJustPressed(1,51) then  -- 51 = E
                    CreateMenu(appleshopmenu)
                    menuOpen = true
                  end
              else
            end
        else
            menuOpen = false
        end
    end
end)
