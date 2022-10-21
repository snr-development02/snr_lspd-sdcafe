local PlayerData = {}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
	PlayerData = QBCore.Functions.GetPlayerData()

end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
	PlayerData.job = job
end)


exports["qb-target"]:AddBoxZone(
    "beanmachinesnr",
    vector3(122.8125, -1041.64, 29.277),
    2,
    2,
    {
        name = "beanmachinesnr",
        heading = 118.60,
        debugPoly = false,
        minZ = 18.669,
        maxZ = 999.87834
    },
    {
        options = {
            {
                type = "Client",
                event = "sonerbeys:beanmachine",
                icon = "fas fa-circle",
                label = "Kahve Makinesi"
            }
        },
        distance = 1.5
    }
)

exports["qb-target"]:AddBoxZone(
    "beanmachinesnrsd",
    vector3(-693.554, 5791.855, 17.331),
    2,
    2,
    {
        name = "beanmachinesnrsd",
        heading = 118.60,
        debugPoly = false,
        minZ = 10.669,
        maxZ = 999.87834
    },
    {
        options = {
            {
                type = "Client",
                event = "sonerbeys:beanmachine",
                icon = "fas fa-circle",
                label = "Bir şeyler hazırla"
            }
        },
        distance = 1.5
    }
)

RegisterNetEvent('sonerbeys:beanmachine')
AddEventHandler('sonerbeys:beanmachine', function()
	if PlayerData.job and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
	icecekhazirla()
	else
		print("pd deilsin")
	end
end)

function icecekhazirla()
	QBCore.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.Items, 1 do
			table.insert(elements, {labels =  Config.Items[i].label, label =  Config.Items[i].label .. ' ',	value = Config.Items[i].item})
		end

		QBCore.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'icecekbm',
			{
			title    = 'İçecek Hazırla',
			align    = 'right',
			elements = elements
			},
			function(data, menu)
				menu.close()
				QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'icecekbema', {
				title = 'Kaç tane hazırlayacaksın?(Maks 2)'
				}, function(data2, menu2)
					menu2.close()
					local yazilanmiktar = tonumber(data2.value)
					if yazilanmiktar < 2 then
						TriggerServerEvent('soner:icecekyap', id, data.current.value, tonumber(data2.value), data.current.labels)
					else
						QBCore.Functions.Notify("nabıyorsun!", "error")
					end
				end, function(data2, menu2)
					menu2.close()
				end)

		end,
		function(data, menu)
		menu.close()
	end)
end


RegisterNetEvent('icecekhazirladim')
AddEventHandler('icecekhazirladim', function()
	local playerPed = PlayerPedId()
	ClearPedSecondaryTask(playerPed)
	TaskPlayAnim( playerPed, "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )

		QBCore.Functions.Progressbar("fixing_a_ped", "İçecek hazırlanıyor", 20000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done

	ClearPedTasks(playerPed)
	end)
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(123.4956, -1035.16, 29.277)
	SetBlipSprite(blip, 106)
	SetBlipScale(blip, 0.4)
	SetBlipColour(blip, 0)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('PD Machine')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	local sdblip = AddBlipForCoord(-693.553, 5791.851, 17.331)
	SetBlipSprite(sdblip, 106)
	SetBlipScale(sdblip, 0.4)
	SetBlipColour(sdblip, 0)
	SetBlipAsShortRange(sdblip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('SD Machine')
	EndTextCommandSetBlipName(sdblip)
end)

