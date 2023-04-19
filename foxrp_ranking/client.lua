
ESX = nil








CreateThread(function()
	while ESX == nil do
		TriggerEvent('fox:getsharedobject', function(obj) 
			ESX = obj 
		end)
		
		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end

		Wait(250)
	end
end)


Wampir = {}

Wampir.init = function()
	
	ESX.TriggerServerCallback("topleaksfoxrp:getData", function(data)
		SendNUIMessage({
			action = "data",
			data = data
		})

		Citizen.Wait(1000)
		Wampir.setDisplay(true)
	end)
end

Wampir.setDisplay = function(bool)
    SetNuiFocus(bool, bool)
	cameraLocked = true
    SendNUIMessage({
        action = "showPanel",
        status = bool
    })


end








RegisterNUICallback('close', function(data, cb)
	Wampir.setDisplay(false)

end)








RegisterCommand("topka", function(source, args, rawCommand)
	Citizen.Wait(50)
	Wampir.init()
end, false)

RegisterKeyMapping('topka', 'Pokaż Ranking', 'keyboard', 'F11')

local canOpen = true

local rndm
CreateThread(function()
	while true do
		rndm = math.random(1,5)
		updatePlaytime(rndm)
		Wait(60 * 1000 * rndm)
	end
end)


function updatePlaytime(input)
	TriggerServerEvent('simba-ranking:updatePlaytime', input)
end

AddEventHandler('gameEventTriggered', function(name,args)

	if (name ~= 'CEventNetworkEntityDamage') then return end;

	if (args[6] == 1) then
		killEvent(args[1], args[2])
	end


end)





function killEvent(victim, killer)

	if (victim == PlayerPedId()) then 
		TriggerServerEvent('death:event')
		return
	end; -- players own death, returning.
	local victimsvid = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim))
	if (victimsvid == 0) then return end; -- victim is not a player
	local killersvid = GetPlayerServerId(NetworkGetPlayerIndexFromPed(killer))
	if (killersvid == 0) then return end; -- killer is not a player
	
	

	TriggerServerEvent('kill:event')
	TriggerServerEvent('simbasimba:addCoin', math.random (1, 5))
	exports['foxrp_notify']:Alert('Ranking', 'Otrzymałeś coinsy za zabójstwo', 2000, 'info')
end

RegisterCommand('stats', function(source)
    if canOpen then
        ESX.TriggerServerCallback('foxrp_ranking:getPlayerStats', function(ranking, faktury, napady, kile, aktywnosc)
            if ranking and faktury and napady and kile and aktywnosc then
                ESX.UI.Menu.CloseAll()
                local rank = 'Iron'
                if ranking >= 5000 then
                    rank = 'Challenger'
                elseif ranking >= 4000 then
                    rank = 'GrandMaster'
                elseif ranking >= 3500 then
                    rank = 'Master'
                elseif ranking >= 3000 then
                    rank = 'Diamond'
                elseif ranking >= 2500 then
                    rank = 'Platinum'
                elseif ranking >= 2000 then
                    rank = 'Gold'
                elseif ranking >= 1500 then
                    rank = 'Silver'
                elseif ranking >= 1200 then
                    rank = 'Bronze'
                end

                local elements = {
                    {label = 'Aktywność: ' .. aktywnosc .. ' godzin', value = 'nil'},
                    {label = 'Kille: ' .. kile .. ' ', value = 'nil'},
                    {label = 'Ranking: ' .. ranking .. ' punktów (' .. rank .. ')', value = 'nil'},
                    {label = 'Sprawdź rangi na serwerze', value = 'check_ranks'},
                }

                ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'statystyki',
                {
                    title    = 'STATYSTYKI',
                    align    = 'center',
                    elements = elements
                }, function(data, menu)
                    if data.current.value == 'check_ranks' then
                        local rank_elements = {
                            {label = 'Iron: 0-1199 punktów', value = 'nil'},
                            {label = 'Bronze: 1200-1499 punktów', value = 'nil'},
                            {label = 'Silver: 1500-1999 punktów', value = 'nil'},
                            {label = 'Gold: 2000-2499 punktów', value = 'nil'},
                            {label = 'Platinum: 2500-2999 punktów', value = 'nil'},
                            {label = 'Diamond: 3000-3499 punktów', value = 'nil'},
                            {label = 'Master: 3500-3999 punktów', value = 'nil'},
                            {label = 'GrandMaster: 4000-4999 punktów', value = 'nil'},
                            {label = 'Challenger: 5000+ punktów', value = 'nil'},
                        }
                        
                        ESX.UI.Menu.Open(
                        'default', GetCurrentResourceName(), 'server_ranks',
                        {
                            title    = 'Rangi na serwerze',
                            align    = 'center',
                            elements = rank_elements
                        }, function(rank_data, rank_menu)
                        end, function(rank_data, rank_menu)
                            rank_menu.close()
                        end)
                    end
                end, function(data, menu)
                    menu.close()
                end)
                canOpen = false
                Citizen.Wait(5000)
                canOpen = true
            else
                ESX.ShowNotification('Brak danych!')
            end
        end)
    else
        ESX.ShowNotification('Poczekaj chwile!')
    end
end)
