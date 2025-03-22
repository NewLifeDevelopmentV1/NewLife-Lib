nl_lib = {}

exports("import", function()
    return nl_lib
end)

--FRAMEWORKS

local qb = GetResourceState('qb-core') == 'started'
local qbx = GetResourceState('qbx_core') == 'started'
local esx = GetResourceState('es_extended') == 'started'
local ox = GetResourceState('ox_core') == 'started'

if ox == 'started' then 
    lib.print.warn('ox_core support for nl_lib is experimental, use with care.')
end

local framework = qbx and 'qbx_core' or qb and 'qb-core' or esx and 'es_extended' or ox and 'ox_core' or nil

if not framework  then
    return error('[NewLife Library] Unable to find framework, This could be because you are using a modified framework name')
end

if framework then
    print('[NewLife Library] is started on '..framework)
end

nl_lib.framework = framework

local file_path = ('bridge/frameworks/%s/server.lua'):format(framework)

local resourceFile = LoadResourceFile(cache.resource, file_path)

if not resourceFile then
    return error(("Unable to find file at path '%s'"):format(file_path))
end

local ld, err = load(resourceFile, ('@@%s/%s'):format(cache.resource, file_path))

if not ld or err then
    return error(err)
end

ld()
----------------------------------------------------------------------------------------------------------------------------------