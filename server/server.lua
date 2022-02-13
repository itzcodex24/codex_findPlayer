--================================--
--      POLICE FIND MENU v1.0.0   --
--            by CODEX.EXE        --
--================================--

--================================--
--          SERVER SIDE           --
--================================--

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local codexS = {}
Tunnel.bindInterface("vrp_codex", codexS)
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","codex_findplayer")

function codexS.getPlayerId(licensePlate)
    local player = source
    if licensePlate ~= nil then
        local rows = exports.ghmattimysql:executeSync("SELECT user_id FROM vrp_user_vehicles WHERE vehicle_plate = @licensePlate", {licensePlate = licensePlate})
        if #rows > 0 then
            local id = rows[1].user_id
                local data = exports.ghmattimysql:executeSync("SELECT firstname,name,age FROM vrp_user_identities WHERE user_id = @id", {id = id})
                local first = data[1].firstname
                local age = data[1].age
                local last = data[1].name
                local masini = exports.ghmattimysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {id = id})
                local count = 0
                if first ~= nil then
                    return id, first,last,age, count
                end 
        else
            TriggerClientEvent('okokNotify:Alert', player, "Find Player", Config.licenceNotFound, 5000, 'error')
        end
    end
    return nil
end

RegisterServerEvent('codex:findplayer_checkPolice')
AddEventHandler('codex:findplayer_checkPolice', function()
    local player = source
	local user_id = vRP.getUserId({player})

	if vRP.hasPermission({user_id, Config.policeGroup})  then
		TriggerClientEvent('codex:findplayer_openMenu', source)

	else
        TriggerClientEvent('okokNotify:Alert', source, "Find Player", Config.noAccessToCommand, 5000, 'error')
	end
end)

RegisterServerEvent('codex:findAndTrack')
AddEventHandler('codex:findAndTrack', function(target)
    local player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= target then
        local target_src = vRP.getUserSource({target})
        TriggerClientEvent('codex:findPlayer', player, target_src)
    else
        print("test")
        TriggerClientEvent('okokNotify:Alert', player, "Find Player", Config.cantTrackYourself, 5000, 'error')
    end
end)