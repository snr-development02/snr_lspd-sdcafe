local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('soner:icecekyap')
AddEventHandler('soner:icecekyap', function(id, item, count, label)
  local _source = source
  local xPlayer = QBCore.Functions.GetPlayer(source)
  		
	TriggerClientEvent('icecekhazirladim', _source)
	Citizen.Wait(9700)
	xPlayer.Functions.AddItem(item, count)		
end)

