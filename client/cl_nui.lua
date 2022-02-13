--================================--
--      POLICE FIND MENU v1.0.0   --
--            by CODEX.EXE        --
--================================--

--================================--
--          CLIENT SIDE           --
--================================--

local vRP = Proxy.getInterface('vRP')
local codexS = Tunnel.getInterface("vrp_codex","vrp_codex")

local display = false
local fontId

local isBlipDrawn = false
local waypointBlip = nil
local targetPlayer = nil


local menuCoords = {
	{450.3974609375,-975.62884521484,30.689577102661}
}

local timeCheck = 1000

Citizen.CreateThread(function()
    RegisterFontFile('wmk')
    fontId = RegisterFontId('Freedom Font')
    while true do 
        Wait(timeCheck)
        local ped = PlayerPedId()
        local peddcoord = GetEntityCoords(ped)
            local Distanta = GetDistanceBetweenCoords(peddcoord.x, peddcoord.y, peddcoord.z,Config.menuCoords, true)
            if Distanta < Config.distanceForText then 
                timeCheck = 0
                DrawMarker(Config.menuMarker,Config.menuCoords, 0, 0, 0, 0, 0, 0, 0.7001,0.7001,0.7001, 38, 188, 247, 200, 0, 0, 0, 1, 0, 0, 0)
                if Distanta < Config.distaceForBlip then 
                    Draw3DText(peddcoord.x,peddcoord.y,peddcoord.z, Config.openMenuText, 0.3)
                    if IsControlJustPressed(0, Config.menuOpenButton) then 
                        TriggerServerEvent('codex:findplayer_checkPolice')
                    end
                end
            else
                timeCheck = 1000
            end

        if display then
            Citizen.Wait(0)
            DisableControlAction(0, 1, display)
            DisableControlAction(0, 2, display)
            DisableControlAction(0, 142, display)
            DisableControlAction(0, 18, display)
            DisableControlAction(0, 322, display)
            DisableControlAction(0, 106, display)
        end
    end
 
end)

RegisterNetEvent("codex:findplayer_openMenu")
AddEventHandler("codex:findplayer_openMenu", function()
	SetDisplay(true)
end)


function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(1.0*scale, 2.1*scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(""..text)
        DrawText(_x,_y)
    end
end

RegisterNUICallback("exit", function()
    SetDisplay(false)
    -- menuOpen = false
end)


RegisterNUICallback('track', function(data)
    TriggerServerEvent('codex:findAndTrack', data.target)
end)


isBlipDrawn = false
waypointBlip = nil
targetPlayer = nil


function drawRouteToPlayer()
	if (isBlipDrawn == false) then
		isBlipDrawn = true
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(targetPlayer), false))
		if(waypointBlip)then
			RemoveBlip(waypointBlip)
			waypoint = AddBlipForCoord(x, y, z)
			SetBlipSprite(waypoint, 280)
			SetBlipColour(waypoint, 49)
			SetNewWaypoint(x, y)
			waypointBlip = waypoint
		else
			waypoint = AddBlipForCoord(x, y, z)
			SetBlipSprite(waypoint, 280)
			SetBlipColour(waypoint, 49)
			SetNewWaypoint(x, y)
			waypointBlip = waypoint
		end
	else
        exports["okokNotify"]:Alert('Success', Config.trackOffMessage, Config.displayNotiTime, "success")
		isBlipDrawn = false
		SetWaypointOff()
		RemoveBlip(waypointBlip)
		waypointBlip = nil
		targetPlayer = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if(targetPlayer)then
			isBlipDrawn = false
			drawRouteToPlayer()
		end
	end
end)

RegisterNetEvent('codex:findPlayer')
AddEventHandler('codex:findPlayer', function(target)
	for i = 0, 32 do
		if NetworkIsPlayerConnected(i) then
			local serverID = GetPlayerServerId(i)
			if(serverID == target)then
				targetPlayer = i
			end
		end
	end
	drawRouteToPlayer()
    exports["okokNotify"]:Alert('Success!', Config.trackSuccessMessage, Config.displayNotiTime, 'success')

end)





function GetHeadshot(ped)
    local texture
    local timeout = 10
    local headshot = RegisterPedheadshot(ped)

    while (timeout > 0) and (not IsPedheadshotReady(headshot) or not IsPedheadshotValid(headshot)) do Citizen.Wait(200) end
    texture = GetPedheadshotTxdString(headshot)
    UnregisterPedheadshot(headshot)
    return texture
end


RegisterNUICallback('getInfo', function(data)
        codexS.getPlayerId({data.lincensePlate}, function (target, first,last,age,count)
            print(target)
            local ped = GetPlayerPed(GetPlayerFromServerId(target))
            SetNuiFocus(true, true)
            SendNUIMessage({
                status = true,
                type = "ui",
                action = "updatePlayerInfo",
                firstname = first,
                lastname = last,
                age = age,
                masini = count,
                id = target,
                texture = GetHeadshot(ped),
            })
    end)
    
end)

RegisterNUICallback('errordetails', function(data)
    exports['okokNotify']:Alert("Error!", Config.errorTextDetails, Config.displayNotiTime, "error")
end)

RegisterNUICallback('errorinfo', function(data)
    exports['okokNotify']:Alert("Error!", data.error, Config.displayNotiTime, "error")
end)


function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end


