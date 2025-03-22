
local qbx_core = exports['qbx_core']
local ox_inventory = exports['ox_inventory']

function nl_lib.GetIdentifier(source)
    local player = qbx_core:GetPlayer(source)
    return player.PlayerData.citizenid
end

function nl_lib.GetName(source)
    local player = qbx_core:GetPlayer(source)
    return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
end

function nl_lib.GetJobCount(source, job)
    local amount = 0
    local players = qbx_core:GetQBPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.name == job then
            amount = amount + 1
        end
    end
    return amount
end

function nl_lib.GetPlayers()
    local players = qbx_core:GetQBPlayers()
    local formattedPlayers = {}
    for _, v in pairs(players) do
        local player = {
            job = v.PlayerData.job.name,
            gang = v.PlayerData.gang.name,
            source = v.PlayerData.source
        }
        table.insert(formattedPlayers, player)
    end
    return formattedPlayers
end

function nl_lib.GetPlayerGroups(source)
    local player = qbx_core:GetPlayer(source)
    return player.PlayerData.job, player.PlayerData.gang
end

function nl_lib.GetPlayerJobInfo(source)
    local player = qbx_core:GetPlayer(source)
    local job = player.PlayerData.job
    return {
        name = job.name,
        label = job.label,
        grade = job.grade,
        gradeName = job.grade.name,
    }
end

function nl_lib.GetPlayerGangInfo(source)
    local player = qbx_core:GetPlayer(source)
    local gang = player.PlayerData.gang
    return {
        name = gang.name,
        label = gang.label,
        grade = gang.grade,
        gradeName = gang.grade.name,
    }
end

function nl_lib.GetDob(source)
    local player = qbx_core:GetPlayer(source)
    return player.PlayerData.charinfo.birthdate
end

function nl_lib.GetSex(source)
    local player = qbx_core:GetPlayer(source)
    return player.PlayerData.charinfo.gender
end

function nl_lib.RemoveItem(source, item, count)
    return ox_inventory:RemoveItem(source, item, count)
end

function nl_lib.AddItem(source, item, count)
    return ox_inventory:AddItem(source, item, count)
end

function nl_lib.HasItem(source, _item)
    local player = qbx_core:GetPlayer(source)
    local item = player.Functions.GetItemByName(_item)
    return item and (item.count or item.amount) or 0
end

function nl_lib.GetInventory(source)
    local items = {}
    local data = ox_inventory:GetInventoryItems(source)
    for slot, item in pairs(data) do
        table.insert(items, {
            name = item.name,
            label = item.label,
            count = item.count,
            weight = item.weight,
            metadata = item.metadata
        })
    end
    return items
end

function nl_lib.SetJob(source, jobName, jobGrade)
    local player = qbx_core:GetPlayer(source)
    local job = tostring(jobName)
    local grade = tonumber(jobGrade) or 0 
    return player.Functions.SetJob(job, grade)
end

function nl_lib.RegisterUsableItem(item, cb)
    qbx_core:CreateUseableItem(item, cb)
end

function nl_lib.GetMoney(source, type)
    local player = qbx_core:GetPlayer(source)
    local amount

    if type == 'money' then 
        amount = player.PlayerData.money.cash
    else 
        amount =  player.PlayerData.money.bank
    end

    return amount
end

function nl_lib.RemoveMoney(source, type, amount) 
    local player = qbx_core:GetPlayer(source)
    local type = type == 'money' and 'cash' or 'bank'
    
    return player.Functions.RemoveMoney(type, amount)
end
