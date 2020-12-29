
print("test")

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        for i = 1, #v.LegalPos, 1 do

            local hash = GetHashKey("csb_burgerdrug")
            while not HasModelLoaded(hash) do
                RequestModel(hash)
                Wait(20)
            end

            ped = CreatePed("PED_TYPE_CIVMALE", "csb_burgerdrug", v.LegalPos[i].x, v.LegalPos[i].y, v.LegalPos[i].z, v.LegalPos[i].angle, false, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
        end

    end
end)

_menuPool = NativeUI.CreatePool()
legalmenu = NativeUI.CreateMenu("Food Truck","Bievenue au Food Truck ~w~!")
_menuPool:Add(legalmenu)

function AddLegalMenu(menu)

    local nourrituremenu = _menuPool:AddSubMenu(menu, "Nourritures", "Acheter de la Nourriture")
    nourrituremenu.Item:RightLabel("→→")
    
    local boissonmenu = _menuPool:AddSubMenu(menu, "Boissons", "Acheter des Boissons")
    boissonmenu.Item:RightLabel("→→")
    

    
    local pain = NativeUI.CreateItem("Pain", "Acheter du ~b~pain ~w~pour ~r~1$")
    nourrituremenu.SubMenu:AddItem(pain)
    pain:RightLabel("~g~1$")

    local eau = NativeUI.CreateItem("Bouteille D'eau", "Acheter une ~b~bouteille d'eau ~w~pour ~r~1$")
    boissonmenu.SubMenu:AddItem(eau)
    eau:RightLabel("~g~1$")


    nourrituremenu.SubMenu.OnItemSelect = function(menu, item)
        if item == pain then
            TriggerServerEvent('Vato_Shops:buy', 1, "bread", "Pain")
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Banque", "Vous avez payé ~r~1$", "", "CHAR_BANK_MAZE", 1)
    	end
	end

    boissonmenu.SubMenu.OnItemSelect = function(menu, item)
        if item == eau then
            TriggerServerEvent('Vato_Shops:buy', 1, "water", "Eau")
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Banque", "Vous avez payé ~r~1$", "", "CHAR_BANK_MAZE", 1)

        end
    end  
        
end

AddLegalMenu(legalmenu)
_menuPool:RefreshIndex()




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false)

        for k,v in pairs(Config.Zones) do

            for i = 1, #v.LegalPos, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.LegalPos[i].x, v.LegalPos[i].y, v.LegalPos[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec Le vendeur~w~.')
                    if IsControlJustPressed(1,51) then
                        legalmenu:Visible(not legalmenu:Visible())
                    end
                end
            end

        end
    end
end)
