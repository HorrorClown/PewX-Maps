local peds = {{3074.3, -2472.1, 4.9, 0}, {3079.1, -2472.3, 4.9, 0}, {3080.5, -2476.3, 4.9, 0}, {3082.6, -2472.8, 4.9, 0}, {3079.5, -2462.1, 4.9, 0}, {3089.1, -2457, 4.9, 0}, {3074.1, -2462.39, 4.9, 0}, {3073.5, -2188.19, 4.9, 180}, {3077.6, -2188.39, 4.9, 180}, {3079.8, -2185.3, 4.9, 180}, {3083.1, -2189.3, 4.9, 180}, {3085.69, -2186.69, 4.9, 180}, {3089.8, -2187.1, 4.9, 180}}
local zombieKillers = {{3108.19, -2356.8, 5.9, 45}, {3107, -2376.1, 6.19, 130}, {3127, -2376.69, 6.19, 215}, {3127.6, -2357, 6, 305}, {3050.39, -2300.8, 5.6, 215}, {3051.19, -2280.8, 5.59, 305}, {3031.19, -2279.8, 5.9, 35}, {3030.39, -2300.3, 5.8, 125}}
local spawns = {}
local zombiePedSkins = {9, 10, 13, 14, 16, 20, 195, 196, 197, 199, 200, 203, 204, 205, 234, 235, 236, 237, 238, 241, 242, 243, 244, 245, 264}
local killerPedSkins = {282, 283, 285, 286, 287, 288}

function initialiseScript(state)
	if state == "Running" then
		triggerClientEvent("startShowLogo", getRootElement())
		killerPeds()
		
		for i, p in ipairs(peds) do
			local x, y, z, r = unpack(p)
			local ped = createPed(zombiePedSkins[math.random(1, #zombiePedSkins)], x, y, z, r, false)
			setElementData(ped, "zombie", true, false)
			setPedAnimation(ped, "ped", "Run_old", -1, true, true, true)
		end	
		
		peds = {}
		setTimer(doZombieAction, 50, -1)
		setTimer(spawnZombie, 5000, -1)
		setTimer(checkAnimation, 1000, -1)
	end
end
addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging", getRootElement(), initialiseScript)

function checkAnimation()
	for i, ped in ipairs(peds) do
		if not isPedDead(ped) then
			setPedAnimation(ped, "ped", "Run_old", -1, true, true, true)
		end
	end
end


function spawnZombie()
	if #peds < 30 then
		local x, y, z = getRandomTowerPos()
		local ped = createPed(zombiePedSkins[math.random(1, #zombiePedSkins)], x, y, z, math.random(1,360), true)
		setElementData(ped, "zombie", true, false)
		setPedAnimation(ped, "ped", "Run_old", -1, true, true, false)
		table.insert(peds, ped)
	end
end

function doZombieAction()
	for i, ped in ipairs(peds) do
		local zX, zY, zZ = getElementPosition(ped)	
		if zZ <= 1 then
			table.remove(peds, i)
			createExplosion(zX, zY, 0, 1, getRootElement())
			destroyElement(ped)
		elseif isPedDead(ped) then
			setTimer(function(ped) destroyElement(ped) end, 5000, 1, ped)
			table.remove(peds, i)
		else
			local lowDis, lowPl = 10000000, nil
			for i, pl in ipairs(getElementsByType"player") do
				if getElementData(pl, "state") == "alive" then
					local pX, pY, pZ = getElementPosition(getPedOccupiedVehicle(pl))
					local dis = getDistanceBetweenPoints3D(zX, zY, zZ, pX, pY, pZ)
					
					if dis < lowDis then 
						lowDis, lowPl = dis, pl
					end
				end
			end
			
			if lowDis > 3 then
				local pX, pY = getElementPosition(lowPl)
				local rot = ( 360 - math.deg ( math.atan2 ( ( pX - zX ), ( pY - zY ) ) ) ) % 360 
				setPedRotation(ped, rot)
			else
				if math.random(1,100) == 25 then
					table.remove(peds, i)
					addSpecial1(ped)
					destroyElement(ped)
				end
			end
		end
	end
end

function addSpecial1(pl) --Altes Script verbessern vor release!!!!!
	local pos = {getElementPosition(pl)}
	local height = 0
	local marker = createMarker(pos[1], pos[2], pos[3], "corona", 10, 255, 0, 0)
	local marker2 = createMarker(pos[1], pos[2], pos[3], "corona", 3, 255, 255, 255)
	local smoke = createObject(2780, pos[1], pos[2], pos[3])
	setElementCollisionsEnabled(smoke, false)
	setElementAlpha(smoke, 0)
	
	setTimer(function(marker, marker2)
		if not isElement(marker) then return end
		if not isElement(marker2) then return end
		
			local r, g, b, a = getMarkerColor(marker)
			setMarkerColor(marker, r, g, b, a-2.5)
			local r, g, b, a = getMarkerColor(marker2)
			setMarkerColor(marker2, r, g, b, a-2.5)
		end	, 50, 100, marker, marker2)
	
	setTimer(function(marker, marker2, smoke)
		local pos = {getElementPosition(marker)}
		setTimer(function(pos)
			createExplosion(pos[1]+math.random(-3, 3), pos[2]+math.random(-3, 3), pos[3]+math.random(1, 3), 0)
			if isElement(marker) then
				destroyElement(marker)
				destroyElement(marker2)
				destroyElement(smoke)
			end
		end, 200, 10, pos)
	end, 5000, 1, marker, marker2, smoke)
end

function killerPeds()
	local cache = {}
	for i, k in ipairs(zombieKillers) do
		local x, y, z, r = unpack(k)
		local ped = createPed(killerPedSkins[math.random(1,#killerPedSkins)], x, y, z, r, true)
		giveWeapon(ped, 31, 50000, true)
		setPedStat(ped, 78, 1000)
		table.insert(cache, ped)
	end
	zombieKillers = cache
	setTimer(doPedAction, 50, -1)
end

function doPedAction()
	for _, ped in ipairs(zombieKillers) do
		local zX, zY, zZ = getElementPosition(ped)
		local lowDis, lowPl = 10000000, nil
		for _, zP in ipairs(getElementsByType"ped") do
			if getElementData(zP, "zombie") and not isPedDead(zP) and isElement(zP) then
				local pX, pY, pZ = getElementPosition(zP)
					local dis = getDistanceBetweenPoints3D(zX, zY, zZ, pX, pY, pZ)
					if dis < lowDis then 
						lowDis, lowPl = dis, zP
					end
			end
		end
		if lowDis < 50 then
			local pX, pY = getElementPosition(lowPl)
			local rot = ( 360 - math.deg ( math.atan2 ( ( pX - zX ), ( pY - zY ) ) ) ) % 360 
			setPedRotation(ped, rot)
			--giveWeapon(ped, 31, 50000, true)							--Because MTA Bug -.-
			setWeaponAmmo(ped, 31, 5000, 500)
			setPedStat(ped, 78, 1000)
			triggerClientEvent("onClientAimTargetFound", getRootElement(), ped, lowPl)
		else
			triggerClientEvent("onClientAimTargetLost", getRootElement(), ped)
		end
	end
end

addEvent("checkPedKills", true)
addEventHandler("checkPedKills", root, function() killPed(source) end)

---------------------------------------------------------------------------------------------
local markerTable = {	{["xa"] = 2960,["xe"] = 3001,["ya"] = -2347, ["ye"] = -2312},
						{["xa"] = 3063,["xe"] = 3095,["ya"] = -2250, ["ye"] = -2210,},
						{["xa"] = 3063,["xe"] = 3098,["ya"] = -2450, ["ye"] = -2410},
						{["xa"] = 3160,["xe"] = 3200,["ya"] = -2347, ["ye"] = -2312},
						{["xa"] = 3074,["xe"] = 3087,["ya"] = -2337, ["ye"] = -2323}
					}

function getRandomTowerPos()
	local rnd, z = math.random(1, #markerTable), 4.9
	if rnd == 5 then z = 8.3 end
	return math.random(markerTable[rnd]["xa"], markerTable[rnd]["xe"]), math.random(markerTable[rnd]["ya"], markerTable[rnd]["ye"]), z
end