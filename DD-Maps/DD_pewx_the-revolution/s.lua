--iR|HorrorClown (PewX) - iRace-mta.de - 22.03.2014
local rroot, root = getResourceRootElement(), getRootElement()
local mainTower, subTowers = nil, {{-2305.8, 1864.4, -95.6, 0, 0, 306}, {-2305.8, 1975.6, -95.6, 0, 0, 234}, {-2153.7, 1975.1, -95.6, 0, 0, 306}, {-2153.9, 1864.8, -95.6, 0, 0, 234}}
local pillars = {{-2177.30, 1959.30, -55, 0, 0, 125.99667358398}, {-2209.80, 1982.30, -55, 0, 0, 161.99}, {-2250.60, 1982.30, -55, 0, 0, 197.97}, {-2282.80, 1959.19, -55, 0, 0, 233.99}, {-2295.5, 1919.69, -55, 0, 0, 270}, {-2282.89, 1881.3, -55, 0, 0, 306}, {-2251.1, 1857.69, -55, 0, 0, 342}, {-2209.69, 1857.8, -55, 0, 0, 18}, {-2177, 1881.5, -55, 0, 0, 54}, {-2164.69, 1920.19, -55, 0, 0, 90}}
local mainMarker, mainBlip = nil, nil
local m = 0

addEventHandler("onResourceStart", rroot, function()
	--Tower
	mainTower = createObject(4585, -2230, 1920, -95.6)
	local subTowersPosCache = subTowers
	subTowers = {}
	for i, tower in ipairs(subTowersPosCache) do
		local t = createObject(4585, unpack(tower))
		table.insert(subTowers, t)
	end
	--Pillars
	local pillarsCache = pillars
	pillars = {}
	for i, pillar in ipairs(pillarsCache) do
		local p = createObject(8397, unpack(pillar))
		table.insert(pillars, p)
	end	
	--Marker
	local x, y = getRandomTowerPos()
	mainMarker = createMarker(x, y, 5.3, "arrow", 1, 80, 100, 200)
	mainBlip = createBlip(x, y, 5, 0, 2, 80, 100, 200)
end)

addEvent("onClientRequest", true)
addEventHandler("onClientRequest", root, function()
	triggerClientEvent("onCreateMainTower", client, mainTower, subTowers)
end)

addEventHandler("onMarkerHit", root, function(elem)
	if getElementType(elem) == "player" then
		if source == mainMarker then
			m = m + 1
			local x, y = getRandomTowerPos()
			setElementPosition(mainMarker, x, y, 5.3)
			setElementPosition(mainBlip, x, y, 5)
			doRandomShit(elem)
		end
	end
end)

addEventHandler("onResourceStop", rroot, function()
	outputChatBox("|Map| " .. m .. " #55aaffaction markers were used!", root, 255, 255, 255, true)
end)

------------------------------------------------------------------------------------------------------
local playerActions, playerInActions = {4, 9}, {}
function isPlayerAction(n)
	for i, action in ipairs(playerActions) do if action == n then return true end end return false
end

local rndShit, skipTable = false, {1, 2, 12, 13}
function isInSkipTable(n)
	for i, v in ipairs(skipTable) do if v == n then	return true	end end return false
end

function doRandomShit(player)
	local rnd = math.random(1, 20)
	
	while (rndShit and isInSkipTable(rnd)) or (isPlayerAction(rnd) and playerInActions[player]) do
		rnd = math.random(1, 20)
	end
	
	if rnd == 1 then
		rndShit = true
		setTimer(moveSubTowersUp, 5000, 1)
		outputChatBox("|Map| #55aaffSub towers will be up in 5 seconds by " .. getPlayerName(player), root, 255, 255, 255, true)
	elseif rnd == 2 then
		rndShit = true
		setTimer(moveMainTowerUp, 5000, 1)
		outputChatBox("|Map| #55aaffMain tower will be up in 5 seconds by " .. getPlayerName(player), root, 255, 255, 255, true)
	elseif rnd == 3 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffenabled Hypnotic for 30 seconds :>" , root, 255, 255, 255, true)
		hypnoticMode()
	elseif rnd == 4 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffis now in over power mode for 60 seconds :3" , root, 255, 255, 255, true)
		overPoweredMode(player)
	elseif rnd == 5 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffenabled explosions for 30 seconds O:" , root, 255, 255, 255, true)
		explosiveMode()
	elseif rnd == 6 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffhit the marker and all players jump >.>" , root, 255, 255, 255, true)
		jumpPlayers()
	elseif rnd == 7 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffhealed all players <3" , root, 255, 255, 255, true)
		healAllPlayers()
	elseif rnd == 8 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffenabled over power mode for all :DD" , root, 255, 255, 255, true)
		overPoweredModeAll()
	elseif rnd == 9 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aafflikes random cars C:" , root, 255, 255, 255, true)
		randomCarFuck(player)
	elseif rnd == 10 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffhit the marker and all players are now on a new position XD" , root, 255, 255, 255, true)
		switchPlayersRandom()
	elseif rnd == 11 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffhit the marker and changed the weather :P" , root, 255, 255, 255, true)
		changeWeatherRandom()
	elseif rnd == 12 then
		rndShit = true
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffhit the marker and all pillars moved up :X" , root, 255, 255, 255, true)
		movePillarsUp()
	elseif rnd == 13 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aafffeels like a bitch </3" , root, 255, 255, 255, true)
		setTimer(createBitches, 500, 250)
	elseif rnd == 14 then
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffchanged the water level D:" , root, 255, 255, 255, true)
		changeWaterLevel()
	else
		outputChatBox("|Map| " .. getPlayerName(player) .. " #55aaffhit the marker but nothing happend -.-" , root, 255, 255, 255, true)
	end
end

function moveSubTowersUp()
	for i, tower in ipairs(subTowers) do
		local x, y, z = getElementPosition(tower)
		moveObject(tower, 20000, x, y, z + 30)
		setTimer(moveObject, 40000, 1, tower, 20000, x, y, z)
	end
	
	triggerClientEvent("rotateSubTowers", root, true)
	setTimer(function() rndShit = false triggerClientEvent("rotateSubTowers", root, false) end, 55000, 1)
end

function moveMainTowerUp()
	local x, y, z = getElementPosition(mainTower)
	moveObject(mainTower, 20000, x, y, z + 40)
	setTimer(moveObject, 40000, 1, mainTower, 20000, x, y, z)
	setTimer(function() rndShit = false end, 60000, 1)
end

function movePillarsUp()
	for i, pillar in ipairs(pillars) do
		local x, y, z = getElementPosition(pillar)
		moveObject(pillar, 10000, x, y, z + 10)
		setTimer(moveObject, 50000, 1, pillar, 10000, x, y, z)
		setTimer(function() rndShit = false end, 60000, 1)
	end
end


local hypnoticTimer = nil
function hypnoticMode()
	if not isTimer(hypnoticTimer) then
		triggerClientEvent("onHypnoticStateChange", root, true)
		hypnoticTimer = setTimer(triggerClientEvent, 30000, 1, "onHypnoticStateChange", root, false)
	else
		killTimer(hypnoticTimer)
		hypnoticTimer = setTimer(triggerClientEvent, 30000, 1, "onHypnoticStateChange", root, false)
	end
end

function overPoweredMode(player)
	playerInActions[player] = true
	local pV = getPedOccupiedVehicle(player)
	local aO = createObject(13645, 0, 0, 0)
	setElementAlpha(aO, 0)
	attachElements(aO, pV, 0, 2, 0, 0, 0, 180)
	setVehicleDamageProof(pV, true)
	setTimer(function(vehicle, object, player) setVehicleDamageProof(vehicle, false) destroyElement(object) playerInActions[player] = false end, 60000, 1, pV, aO, player)
end

local oPM = {timer, objects = {}}
function overPoweredModeAll()
	if not isTimer(oPM.timer) then
		for i, player in ipairs(getElementsByType("player")) do
			local pV = getPedOccupiedVehicle(player)
			local aO = createObject(13645, 0, 0, 0)
			setElementAlpha(aO, 0)
			attachElements(aO, pV, 0, 2, 0, 0, 0, 180)
			table.insert(oPM.objects, aO)
			oPM.timer = setTimer(function() for i, object in ipairs(oPM.objects) do destroyElement(object) table.remove(oPM.objects, i) end end, 30000, 1)		
		end
	else
		killTimer(oPM.timer)
		oPM.timer = setTimer(function() for i, object in ipairs(oPM.objects) do destroyElement(object) table.remove(oPM.objects, i) end end, 30000, 1)		
	end
end

local explosiveTimer = nil
function explosiveMode()
	function createTowerExplosion()
		local x, y = getRandomTowerPos()
		createExplosion(x, y, 5.5, 10)
	end

	if not isTimer(explosiveTimer) then
		explosiveTimer = setTimer(createTowerExplosion, 1000, 30)
	else
		killTimer(explosiveTimer)
		explosiveTimer = setTimer(createTowerExplosion, 1000, 30)
	end
end

function jumpPlayers()
	for i, player in ipairs(getElementsByType("player")) do
		local pV = getPedOccupiedVehicle(player)
		if pV then
			local x, y, z = getElementVelocity(pV)
			setElementVelocity(pV, x, y, z + 0.5)
		end
	end
end

function switchPlayersRandom()
	local cacheTable = {}
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player, "state") == "alive" then
			local pV = getPedOccupiedVehicle(player)
			if pV then
				local vID = getElementModel(pV)
				local vP = {getElementPosition(pV)}
				local vR = {getElementRotation(pV)}
				local vV = {getElementVelocity(pV)}
				local vTV = {getVehicleTurnVelocity(pV)}
				local ID = #cacheTable + 1
				cacheTable[ID] = {}
				cacheTable[ID].player = player
				cacheTable[ID].vID = vID
				cacheTable[ID].pos = vP
				cacheTable[ID].rot = vR
				cacheTable[ID].velocity = vV
				cacheTable[ID].turnVelocity = vTV
				cacheTable[ID].done = false
			end
		end
	end
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player, "state") == "alive" then
			local pV = getPedOccupiedVehicle(player)
			if pV then
				local rnd = math.random(1, #cacheTable)
				while cacheTable[rnd].done do
					rnd = math.random(1, #cacheTable)
				end
				
				local targetPlayer = cacheTable[rnd].player
				local vehicleID = cacheTable[rnd].vID
				local x, y, z = unpack(cacheTable[rnd].pos)
				local xr, yr, zr = unpack(cacheTable[rnd].rot)
				local xv, yv, zv = unpack(cacheTable[rnd].velocity)
				local xtv, ytv, ztv = unpack(cacheTable[rnd].turnVelocity)
				
				setElementModel(pV, vehicleID)
				setElementPosition(pV, x, y, z)
				setElementRotation(pV, xr, yr, zr)
				setElementVelocity(pV, xv, yv, zv)
				setVehicleTurnVelocity(pV, xtv, ytv, ztv)
				outputChatBox("|Map| #55aaffYou are now at the position from " .. getPlayerName(targetPlayer), player, 255, 255, 255, true)
				cacheTable[rnd].done = true
			end
		end
	end
end

local weatherIDs = {1, 8, 9, 16, 19}
function changeWeatherRandom()
	local rnd = math.random(1, #weatherIDs)
	setWeather(weatherIDs[rnd])
end

local wl = 0
function changeWaterLevel()
	 local n = math.random(-1, 3)
	 wl = wl + n
	 setWaterLevel(wl)
end

local femaleSkins, strips = {63, 87, 138, 178, 244, 246, 251, 256, 257}, {"strip_A", "strip_B", "strip_C", "strip_D", "strip_E", "strip_F", "strip_G"}
function createBitches()
	local x, y = getRandomTowerPos()
	local ped = createPed(femaleSkins[math.random(1, #femaleSkins)], x, y, 5.5, math.random(1, 360), true)
	setPedAnimation(ped, "STRIP", strips[math.random(1, #strips)], 30000, true, false, false, false)
	setTimer(destroyElement, 30000, 1, ped)
end

function healAllPlayers()
	for i, player in ipairs(getElementsByType("player")) do
		local pV = getPedOccupiedVehicle(player)
		if pV then fixVehicle(pV) end
	end
end

local vehicleIDs = {507, 554, 536, 567, 412, 589, 533, 545, 424, 471, 495, 500, 568, 529, 541, 415, 559, 480, 560, 562, 506, 565, 506, 451, 434, 555, 579, 400, 589, 458}
function randomCarFuck(player)
	function changeCar(vehicle)
		if isElement(vehicle) then
			setElementModel(vehicle, vehicleIDs[math.random(1, #vehicleIDs)])
		end
	end
	
	local vP = getPedOccupiedVehicle(player)
	if vP then
		playerInActions[player] = true
		setTimer(changeCar, 50, 20, vP)
		setTimer(function(player) playerInActions[player] = false end, 2000, 1, player)
	end
end
----------------------------------------------------------------------------------------------------
local markerTable = {	{["xa"] = -2132,["xe"] = -2168,["ya"] = 1855, ["ye"] = 1985},
						{["xa"] = -2293,["xe"] = -2328,["ya"] = 1855,["ye"] = 1985,},
						{["xa"] = -2132,["xe"] = -2328,["ya"] = 1902,["ye"] = 1938}
					}

function getRandomTowerPos()
	--math.randomseed(getRealTime().timestamp)
	local rnd = math.random(1, #markerTable)
	return math.random(markerTable[rnd]["xe"], markerTable[rnd]["xa"]), math.random(markerTable[rnd]["ya"], markerTable[rnd]["ye"])
end