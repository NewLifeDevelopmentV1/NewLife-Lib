
local Ox = require '@ox_core.lib.init'
local player = Ox.GetPlayer()
local isDead

function nl_lib.bridgeNotify(msg, type, duration)
    -- ox_lib is a dependency of ox_core, `lib` will always be available
    lib.notify({
        description = msg,
        type = type,
        duration = duration
    })
end

function nl_lib.GetPlayerGroups()
    return player.get('activeGroup'), false
end

function nl_lib.GetPlayerGroupInfo()
    local activeGroup = player.get('activeGroup')
    local jobInfo = {
        name = activeGroup,
        grade = player.getGroup(activeGroup),
        label = Ox.GetGroup(activeGroup).label
    }

    return jobInfo
end

function nl_lib.GetSex()
    -- ! ox_core has non_binary as a gender. for backwards compatibility non binary will return female
    return player.get('gender') == 'male' and 1 or 2
end

function nl_lib.IsDead()
    return isDead
end

---@deprecated ox_core does not have built in support for outfits
function nl_lib.SetOutfit() end

AddEventHandler('ox:playerRevived', function()
    isDead = nil
end)

AddEventHandler('ox:playerDeath', function()
    isDead = true
    TriggerEvent('nl_lib:playerDied')
end)

AddEventHandler('ox:playerLoaded', function()
    player = Ox.GetPlayer()
    TriggerEvent('nl_lib:playerLoaded')
end)
