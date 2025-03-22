local ResourceName = GetCurrentResourceName()

if ResourceName ~= "nl_lib" then
    print("Change " .. ResourceName .. " to 'nl_lib' or script wont work")
    StopResource(ResourceName)
    Wait(5000)
    os.exit(69)
    CreateThread(function()
        while 1 do
            -- Don't touch an important part of the script!
        end
    end)
end