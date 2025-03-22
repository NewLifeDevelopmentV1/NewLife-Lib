local function animdictRequest(animDict)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Wait(0) end
	return animDict
end

----------------------------------------------------------

function nl_lib.playAnim(ped, clip, anim, time)

	local dict = animdictRequest(clip)

 	TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 49, 0, true, true, true)

	if time then 
		Wait(time)
		ClearPedTasks(ped)
	end

	RemoveAnimDict(dict)
end

function nl_lib.playAudio(params) -- Native PlaySound logic from qbx_core
	local audioName = params.audioName
	local audioRef = params.audioRef
	local returnSoundId = params.returnSoundId or false
	local source = params.audioSource
	local range = params.range or 5.0

	local soundId = GetSoundId()

	local sourceType = type(source)
	if sourceType == 'vector3' then
		local coords = source
		PlaySoundFromCoord(soundId, audioName, coords.x, coords.y, coords.z, audioRef, false, range, false)
	elseif sourceType == 'number' then
		PlaySoundFromEntity(soundId, audioName, source, audioRef, false, false)
	else
		PlaySoundFrontend(soundId, audioName, audioRef, true)
	end

	if returnSoundId then
	   return soundId
	end

	ReleaseSoundId(soundId)
end

function nl_lib.CreatePed(modelHash, coords, heading)
	RequestModel(modelHash)

	local ped = CreatePed(4, modelHash, coords, heading, false, false)
	SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
	return ped
end

function nl_lib.CreateBlip(label,pos,sprite,color,scale)
	local blip =  AddBlipForCoord(pos.x, pos.y, pos.z)
	SetBlipSprite (blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, scale)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)
	return blip
end

----------------------------------------------------------
