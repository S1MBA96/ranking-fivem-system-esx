







ESX = nil
TriggerEvent('fox:getsharedobject', function(obj) ESX = obj end)

sfg = {
    servername = "FoxRP",
    events = {
        napad = "napad:event",
        faktura = "faktura:event",
        kill = "kill:event",
        elorank = "elorank:event",
        orgrank = "orgrank:event",
        playtimerank = "playtime:event"
    }

}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
 
    local result = MySQL.query.await('SELECT * FROM simba_topleaks_ranks WHERE identifier = ?', {ESX.GetPlayerFromId(source).getIdentifier()})

    if(result[1] ~= nil) then return end;
    MySQL.query('INSERT INTO simba_topleaks_ranks (identifier,name) VALUES (?,?)', {ESX.GetPlayerFromId(source).getIdentifier(), GetPlayerName(source)})
    if (ESX.GetPlayerFromId(source).thirdjob.name == 'unemployed') then return end;
    local result2 = MySQL.query.await('SELECT * FROM simba_topleaks_ranks_orgs WHERE org = ?', {ESX.GetPlayerFromId(source).thirdjob.name})

    if (result2[1] ~= nil) then return end;
    MySQL.query('INSERT INTO simba_topleaks_ranks_orgs (org,orglabel) VALUES (?,?)', {ESX.GetPlayerFromId(source).thirdjob.name, ESX.GetPlayerFromId(source).thirdjob.label})

end)










RegisterNetEvent(sfg.events.faktura)
AddEventHandler(sfg.events.faktura, function()
    local src = source
    local identifier = ESX.GetPlayerFromId(src).getIdentifier()
    local oldfaktury = MySQL.query.await('SELECT faktury FROM simba_topleaks_ranks WHERE identifier = ?', {identifier})

    local newfaktury = oldfaktury[1].faktury + 1

    MySQL.Async.execute('UPDATE simba_topleaks_ranks SET faktury = ? WHERE identifier = ?', {newfaktury, identifier}, function(result)
        print('Zaktualizowano Faktury Gracza ' .. src)
    end)

end)

RegisterNetEvent(sfg.events.napad)
AddEventHandler(sfg.events.napad, function()
    local src = source
    local identifier = ESX.GetPlayerFromId(src).getIdentifier()
    local oldrobs = MySQL.query.await('SELECT napady FROM simba_topleaks_ranks WHERE identifier = ?', {identifier})

    local newrobs = oldrobs[1].napady + 1

    MySQL.Async.execute('UPDATE simba_topleaks_ranks SET napady = ? WHERE identifier = ?', {newrobs, identifier}, function(result)
        print('Zaktualizowano Napady Gracza ' .. src)
    end)

end)

RegisterNetEvent(sfg.events.kill)
AddEventHandler(sfg.events.kill, function()
    local src = source
    local identifier = ESX.GetPlayerFromId(src).getIdentifier()
    local oldkills = MySQL.query.await('SELECT kills FROM simba_topleaks_ranks WHERE identifier = ?', {identifier})
    local oldelo = MySQL.query.await('SELECT elo FROM simba_topleaks_ranks WHERE identifier = ?', {identifier})

    local newkills = oldkills[1].kills + 1
    local newelo = oldelo[1].elo + 20

    MySQL.Async.execute('UPDATE simba_topleaks_ranks SET elo = ? WHERE identifier = ?', {newelo, identifier}, function(result)
        TriggerClientEvent('esx:showNotification', src, 'Zdobywasz 20 punktów Rankingowych za Zabójstwo!')
    end)

    MySQL.Async.execute('UPDATE simba_topleaks_ranks SET kills = ? WHERE identifier = ?', {newkills, identifier}, function(result)
    end)

end)

RegisterNetEvent('death:event')
AddEventHandler('death:event', function()
    local src = source
    local identifier = ESX.GetPlayerFromId(src).getIdentifier()

    local oldelo = MySQL.query.await('SELECT elo FROM simba_topleaks_ranks WHERE identifier = ?', {identifier})

    local newelo = oldelo[1].elo - 20

    MySQL.Async.execute('UPDATE simba_topleaks_ranks SET elo = ? WHERE identifier = ?', {newelo, identifier}, function(result)
        TriggerClientEvent('esx:showNotification', src, 'Tracisz 20 punktów Rankingowych za Smierc.')
    end)

end)


ESX.RegisterServerCallback('topleaksfoxrp:getData', function(source,cb)
    local data = getRankingPlayers(ESX.GetPlayerFromId(source).getIdentifier())
    cb(data)
end)

function getRankingPlayers(identifier)

    local kills = MySQL.query.await('SELECT kills,name FROM simba_topleaks_ranks ORDER BY kills DESC LIMIT 7')
    local faktury = MySQL.query.await('SELECT faktury,name FROM simba_topleaks_ranks ORDER BY faktury DESC LIMIT 7')
    local napady = MySQL.query.await('SELECT napady,name FROM simba_topleaks_ranks ORDER BY napady DESC LIMIT 7')
    local ranking = MySQL.query.await('SELECT elo,name FROM simba_topleaks_ranks ORDER BY elo DESC LIMIT 7')
    local playtime = MySQL.query.await('SELECT playtime,name FROM simba_topleaks_ranks ORDER BY playtime DESC LIMIT 7')

    local killsTable = {}
    for i = 1, #kills do
        killsTable[#killsTable + 1] = {name = kills[i].name, kile = kills[i].kills}
    end
    local playtimeTable = {}
    for i = 1, #playtime do
        playtimeTable[#playtimeTable + 1] = {name = playtime[i].name, id = playtime[i].playtime}
    end
    local fakturyTable = {}
    for i = 1, #faktury do
        fakturyTable[#fakturyTable + 1] = {name = faktury[i].name, faktury = faktury[i].faktury}
    end
    local napadyTable = {}
    for i = 1, #napady do
        napadyTable[#napadyTable + 1] = {name = napady[i].name, napady = napady[i].napady}
    end
    local eloTable = {}
    for i = 1, #ranking do
        eloTable[#eloTable + 1] = {name = ranking[i].name, uranking = ranking[i].elo}
    end
    
    
    local result2 = MySQL.query.await('SELECT wins,orglabel FROM simba_topleaks_ranks_orgs ORDER BY wins DESC LIMIT 7', {something})
    local orgtable = {}
    for i = 1, #result2 do
        orgtable[#orgtable + 1] = {label = result2[i].orglabel, count = result2[i].wins}
    end

    local tableofdata = {
        playerKile = killsTable,
        playerFaktury = fakturyTable,
        playerNapady = napadyTable,
        playerRanking = eloTable,
        playtime = playtimeTable,
        jobs = orgtable,
        playerCount = GetNumPlayerIndices(),
    }
    return tableofdata;

end



RegisterNetEvent('simba-ranking:updatePlaytime')
AddEventHandler('simba-ranking:updatePlaytime', function(input)
    local src = source
    if (input > 5 or input < 1) then DropPlayer(src, 'ZSEC: Nie cheatuj') return end;
    local player = ESX.GetPlayerFromId(src)
    local identifier = player.getIdentifier()
    local oldplytime = MySQL.query.await('SELECT playtime FROM simba_topleaks_ranks WHERE identifier = ?', {identifier})
    
    local newplytime = (input / 60) + oldplytime[1].playtime
    MySQL.Async.execute('UPDATE simba_topleaks_ranks SET playtime = ? WHERE identifier = ?', {string.format('%.2f', newplytime), identifier}, function(result)
        print('Zaktualizowano czas gracza ', src)
    end)

end)
RegisterNetEvent(sfg.events.orgrank)
AddEventHandler(sfg.events.orgrank, function()
    local org = ESX.GetPlayerFromId(source).thirdjob.name
    local result = MySQL.query.await('SELECT wins FROM simba_topleaks_ranks_orgs WHERE org = ?', {org})

    if (result[1] == nil) then 
        MySQL.query('INSERT INTO simba_topleaks_ranks_orgs (org) VALUES (?)', {org})
    end

    local newwins = result[1].wins + 1

    MySQL.Async.execute('UPDATE simba_topleaks_ranks_orgs SET wins = ? WHERE org = ?', {newwins, org}, function(result)
        print('Zaktualizowano bitki organizacji ', org)
    end)

end)

function getPlayerRanking(identifier, cb)

    MySQL.Async.fetchAll('SELECT * FROM simba_topleaks_ranks WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)

        if result[1] then
            local playerData = {
                ranking = result[1].elo,
                faktury = result[1].faktury,
                napady = result[1].napady,
                kile = result[1].kills,
                playtime = result[1].playtime
            }
            cb(playerData)
        else
            cb(nil)
        end
    end)
end


ESX.RegisterServerCallback('foxrp_ranking:getPlayerStats', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    local identifierWithoutPrefix = string.gsub(identifier, "steam:", "")
    local identifierWithoutTwoOnes = string.sub(identifierWithoutPrefix, 3)

    getPlayerRanking(identifier, function(playerData)
        if playerData then
            cb(playerData.ranking, playerData.faktury, playerData.napady, playerData.kile, playerData.playtime)
        else
            cb(nil, nil, nil, nil, nil)
        end
    end)
end)




function rewardPlayerForHoursPlayed(src, hours)
    local player = ESX.GetPlayerFromId(src)
    local rewards = {}

    if hours == 1 then
        rewards = {
            {item = 'zlota', count = 1}
        }
    elseif hours == 2 then
        rewards = {
            {item = 'zlota', count = 1},
            {item = 'srebrna', count = 2}
        }
    elseif hours == 4 then
        rewards = {
            {item = 'zlota', count = 4},
            {item = 'srebrna', count = 2}
        }
    elseif hours == 6 then
        rewards = {
            {item = 'carchest', count = 1},
            {item = 'zlota', count = 1}
        }
    elseif hours == 10 then
        rewards = {
            {item = 'carchest', count = 2},
            {item = 'zlota', count = 2}
        }
    elseif hours == 12 then
        rewards = {
            {item = 'carchest', count = 2},
            {item = 'zlota', count = 4}
        }
    elseif hours == 24 then
        rewards = {
            {item = 'carchest', count = 4},
            {item = 'zlota', count = 10}
        }
    end

    for _, reward in ipairs(rewards) do
        player.addInventoryItem(reward.item, reward.count)
        TriggerClientEvent('esx:showNotification', src, 'Otrzymałeś ' .. reward.count .. 'x ' .. reward.item .. ' za przejście ' .. hours .. 'h w grze.')
    end
end

RegisterCommand('osiagniecia', function(src, args)
    local hours = tonumber(args[1])

    if hours ~= nil and (hours == 1 or hours == 2 or hours == 4 or hours == 6 or hours == 10 or hours == 12 or hours == 24) then
        local player = ESX.GetPlayerFromId(src)
        local identifier = player.identifier

        local playtime = MySQL.query.await('SELECT playtime FROM simba_topleaks_ranks WHERE identifier = ?', {identifier})
        local currentPlaytime = playtime[1].playtime
        print(currentPlaytime)
        if currentPlaytime >= hours then
            rewardPlayerForHoursPlayed(src, hours)

            local newPlaytime = currentPlaytime - hours
            MySQL.Async.execute('UPDATE simba_topleaks_ranks SET playtime = ? WHERE identifier = ?', {string.format('%.2f', newPlaytime), identifier}, function(result)
                print("Zaktualizowano czas gracza o id "..src.." ")
            end)
        else
            TriggerClientEvent('esx:showNotification', src, 'Nie spełniłeś wymagań, aby odebrać nagrodę za ' .. hours .. 'h.')
        end
    else
        TriggerClientEvent('esx:showNotification', src, 'Wprowadź poprawną wartość godzin (1, 2, 4, 6, 10, 12 lub 24).')
    end
end, false)
