function nl_lib.Notify(msg, type, duration)

	if not duration then duration = 3000 end
		
	if Config.Notify == 'qb' or Config.Notify == 'ESX' or Config.Notify == 'QBOX' then
		if nl_lib.framework == Config.Notify then 
			nl_lib.bridgeNotify(msg, type, duration) 
		else 
			return error('[NewLife Library] Config.Notify = '..Config.Notify..' but server is not '..Config.Notify..'') 
		end 
	end


	if Config.Notify == 'ox' then
		lib.notify({
			title = msg,
			type = type,
			duration = duration
		})
		return true
	elseif Config.Notify == 'okok' then
		exports['okokNotify']:Alert("NOTIFY", msg, duration, type)
		return true
	elseif Config.Notify == 'custom' then
		return error('Config.Notify = custom but no custom Notify was added.') -- Remove me if using custom notify.
	end
end

function nl_lib.displayTextUI(text)
	if Config.TextUI == 'ox' then
		lib.showTextUI(text)
	end

	if Config.TextUI == 'okok' then
		exports['okokTextUI']:Open(text, 'lightblue', 'left', playSound)
	end

	if Config.TextUI == 'custom' then
		return error('Config.TextUI = custom but no custom TextUI was added.') -- Remove me if using custom textui.
	end
end

function nl_lib.hideTextUI()
	if Config.TextUI == 'ox' then
		lib.hideTextUI()
	end

	if Config.TextUI == 'okok' then
		exports['okokTextUI']:Close()
	end

	if Config.TextUI == 'custom' then
		return error('Config.TextUI = custom but no custom TextUI was added.') -- Remove me if using custom textui.
	end
end


