ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('genesis-thermal:take')
AddEventHandler('genesis-thermal:take', function()
    TriggerClientEvent('esx:showAdvancedNotification', source, 'Witney', '~r~Tu es détenu ?', '~g~Prends la tenue de détenu, celle-ci doit être adapter à ta corpulence.', 'CHAR_TAXI_LIZ', 3)
end)