ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('powx_joblisting:setJobMineur')
AddEventHandler('powx_joblisting:setJobMineur', function(job)

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("miner", 0)

end)
RegisterServerEvent('powx_joblisting:setJobBucheron')
AddEventHandler('powx_joblisting:setJobBucheron', function(job)

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("lumberjack", 0)

end)
RegisterServerEvent('powx_joblisting:setJobCuisinier')
AddEventHandler('powx_joblisting:setJobCuisinier', function(job)

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("burgershot", 0)

end)
RegisterServerEvent('powx_joblisting:setJobCouturier')
AddEventHandler('powx_joblisting:setJobCouturier', function(job)

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("tailor", 0)

end)
RegisterServerEvent('powx_joblisting:setJobChômeur')
AddEventHandler('powx_joblisting:setJobChômeur', function(job)

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("unemployed", 0)

end)


-- By PowX#2629