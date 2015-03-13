local pt = {}
pt.vehicles = {496,504,402,541,415,542,589,480,507,562,587,533,565,474,434,494,502,503,579,545,411,559,400,500,603,489,505,534,495,567,535,458,561,409,560,506,549,420,583,451,558,555,477,509,581,481,462,521,463,510,522,561,448,468,586,416,523,427,490,528,407,544,596,598,599,597,601,422,482,483,588,444,556,557,523,582,470,543,574,525,552,478,554,433,431,524,437,573,455,568,424,457,486,406,530,571,572,471,531,605}  

function pt.doAction(ePlayer, eVehicle)
	local a = math.random(1, 25)
	
	if a == 1 then
		local rnd = pt.vehicles[math.random(1, #pt.vehicles)]
		setElementModel(eVehicle, rnd)
		pt.message("You got a new vehicle!", ePlayer)
		return true
	elseif a == 2 then
		local rnd = pt.vehicles[math.random(1, #pt.vehicles)]
		for _, p in ipairs(getElementsByType"player") do
			if getElementData(p, "state") == "alive" then
				local v = getPedOccupiedVehicle(p)
				setElementModel(v, rnd)
			end
		end
		pt.message("Everyone got the same random vehicle by " .. getPlayerName(ePlayer), root)
		return true
	elseif a == 3 then
		for _, p in ipairs(getElementsByType"player") do
			if getElementData(p, "state") == "alive" then
				setElementModel(getPedOccupiedVehicle(p), pt.vehicles[math.random(1, #pt.vehicles)])
			end
		end
		pt.message("Everyone got a random vehicle by " .. getPlayerName(ePlayer), root)
		return true
	elseif a == 4 then
		local p = pt.getRandomAlivePlayer()
		local v = getPedOccupiedVehicle(p)
		setElementModel(v, pt.vehicles[math.random(1, #pt.vehicles)])
		pt.message("You gives a random vehicle to " .. getPlayerName(p), ePlayer)
		pt.message("You got a random vehicle by " .. getPlayerName(ePlayer), p)
		return true
	elseif a == 5 then
		setVehicleEngineState(eVehicle, false)
		pt.message("Your engine is currupted", ePlayer)
		setTimer(function(v) setVehicleEngineState(v, false) end, 200, 50, eVehicle)
		return true
	elseif a == 6 then
		local mass = math.random(1, 10000)
		setVehicleHandling(eVehicle, "mass", mass)
		setVehicleHandling(eVehicle, "turnMass", mass)
		pt.message("Your vehicle mass was set to " .. mass, ePlayer)
	elseif a == 7 then
		local com = getVehicleHandling(eVehicle)["centerOfMass"]
		setVehicleHandling(eVehicle, "centerOfMass", {com[1], com[2], com[3] + 1})
		pt.message("Your vehicle.. eh- ok..! idk, but it is funny :>", ePlayer)
		return true
	elseif a == 8 then
		local acc = math.random(1, 10000)
		setVehicleHandling(eVehicle, "engineAcceleration", acc)
		pt.message("Your vehicle acceleration was changed to " .. acc, ePlayer)
		return true
	elseif a == 9 then
		local trac = math.random(-100, 5000)
		setVehicleHandling(eVehicle, "tractionMultiplier", trac)
		pt.message("Your vehicle traction was changed to " .. trac, ePlayer)
		return true
	elseif a == 10 then
		if pt.isSeccond then return false end
		pt.isSeccond = true
		for i, o in ipairs(pt.seccond) do
			local rx, ry, rz = math.random(0, 360), math.random(0, 360), math.random(0, 360)
			o.source = createObject(o.id, o.x + math.random(-500, 500), o.y  + math.random(-500, 500), o.z+ math.random(-50, 500), rx, ry, rz)
			setElementCollisionsEnabled(o.source, false)
			setTimer(setElementCollisionsEnabled, 10000, 1, o.source, true)
			moveObject(o.source, 10000, o.x, o.y, o.z, o.rx - rx, o.ry - ry, o.rz - rz, "InOutQuad")
			setTimer(function(element)
				if isElement(element) then destroyElement(element) end
				pt.isSeccond = false
			end, 120000, 1, o.source)
		end
		pt.message("Uh, look!")
		return true
	elseif a == 11 then
		if pt.isWaterT then return false end
		pt.isWaterT = true
		for i, o in ipairs(pt.waterTowers) do
			local rx, ry, rz = math.random(0, 360), math.random(0, 360), math.random(0, 360)
			o.source = createObject(o.id, o.x + math.random(-500, 500), o.y  + math.random(-500, 500), o.z+ math.random(-50, 500), rx, ry, rz)
			setElementCollisionsEnabled(o.source, false)
			setTimer(setElementCollisionsEnabled, 10000, 1, o.source, true)
			moveObject(o.source, 10000, o.x, o.y, o.z, o.rx - rx, o.ry - ry, o.rz - rz, "InOutQuad")
			setTimer(function(element)
				if isElement(element) then destroyElement(element) end
				pt.isWaterT = false
			end, 120000, 1, o.source)
		end
		pt.message("Uh, look!")
		return true
	elseif a == 12 then
		if pt.isWaterJ then return false end
		pt.isWaterJ = true
		for i, o in ipairs(pt.waterjumps) do
			if math.random(1,4) == 1 then
				local rx, ry, rz = math.random(0, 360), math.random(0, 360), math.random(0, 360)
				o.source = createObject(o.id, o.x + math.random(-500, 500), o.y  + math.random(-500, 500), o.z + math.random(-50, 500), rx, ry, rz)
				setElementCollisionsEnabled(o.source, false)
				setTimer(setElementCollisionsEnabled, 10000, 1, o.source, true)
				moveObject(o.source, 10000, o.x, o.y, o.z, o.rx - rx, o.ry - ry, o.rz - rz, "InOutQuad")
				setTimer(function(element)
					if isElement(element) then destroyElement(element) end
					pt.isWaterJ = false
				end, 120000, 1, o.source)
			end
		end
		pt.message("Uh, look!")
		return true
	elseif a == 13 then
		triggerClientEvent("actionBlack", root)
		pt.message("Blackscreen.")
		return true
	elseif a >= 14 and a <= 18 then
		fixVehicle(eVehicle)
		pt.message("Your vehicle was fixed.", ePlayer)
		return true
	end
end

function pt.spawnPowerUp()
	if pt.powerup and isElement(pt.powerup.object) then destroyElement(pt.powerup.object) end
	if pt.powerup and isElement(pt.powerup.colshape) then destroyElement(pt.powerup.colshape) end
	--if pt.powerup and isElement(pt.powerup.marker) then destroyElement(pt.powerup.marker) end
	if pt.powerup and isElement(pt.powerup.blip) then destroyElement(pt.powerup.blip) end
	
	local p = pt.getRandomSpawn()
	pt.powerup = {}
	pt.powerup.object = createObject(1271, p[1], p[2], p[3])
	pt.powerup.colshape = createColSphere(p[1], p[2], p[3], 2)
	--pt.powerup.marker = createMarker(p[1], p[2], p[3], "corona", 1, 255, 255, 255)
	pt.powerup.blip = createBlip(p[1], p[2], p[3], 0, 2, 255, 80, 0)
	triggerClientEvent("sendPowerUp", getRootElement(), true, pt.powerup.object)
	--attachElements(pt.powerup.marker, pt.powerup.object)
	
	setElementCollisionsEnabled(pt.powerup.object, false)
	addEventHandler("onColShapeHit", pt.powerup.colshape, pt.onPowerupHit)
end

function pt.onPowerupHit(e)
	if getElementType(e) ~= "vehicle" then return end
    if pt.powerup and isElement(pt.powerup.object) then destroyElement(pt.powerup.object) end
	if pt.powerup and isElement(pt.powerup.colshape) then destroyElement(pt.powerup.colshape) end
	--if pt.powerup and isElement(pt.powerup.marker) then destroyElement(pt.powerup.marker) end
	if pt.powerup and isElement(pt.powerup.blip) then destroyElement(pt.powerup.blip) end
	triggerClientEvent("sendPowerUp", getRootElement(), false)
	
	local p = getVehicleController(e)
	if not pt.doAction(p, e) then
		outputChatBox("|Map| " .. getPlayerName(p) .. "#dd5500 hit a useless power up!", root, 255, 255, 255, true)
	end
	
	setTimer(function()
		pt.spawnPowerUp()
	end, 5000, 1) --5000
end
	

function pt.message(sMessage, toElement)
	outputChatBox("|Map|#dd5500 " .. sMessage, toElement or root, 255, 255, 255, true)
end

function pt.getRandomAlivePlayer()
	local t = {}
	for _, p in ipairs(getElementsByType"player") do
		if getElementData(p, "state") == "alive" then table.insert(t, p) end
	end
	return t[math.random(1, #t)]
end

function pt.getRandomSpawn()
	local tbl = math.random(1, #pt.spawns)
	local x = math.random(pt.spawns[tbl][1][1], pt.spawns[tbl][2][1])
	local y = math.random(pt.spawns[tbl][1][2], pt.spawns[tbl][2][2])
	local z = 1.6--math.random(pt.spawns[tbl][1][3], pt.spawns[tbl][2][3])
	return {x, y, z}
end

setTimer(function()
	pt.spawnPowerUp()
end, 10000, 1) --10000

pt.spawns = {
			{{3142, -2047, 2}, {3180, -2011, 2}}
			}
			
pt.seccond = {
	{id = 8397, x = 3212.1000976563, y = -2079.3000488281, z = -20.89999961853, rx = 49.998779296875, ry = 0, rz = 224.99456787109, scale = 1, ds = true, col = true, dim = 200},
	{id = 6959, x = 3161, y = -2029, z = 15.60000038147, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 8397, x = 3212.1000976563, y = -1978.5, z = -20.89999961853, rx = 49.998779296875, ry = 0, rz = 315, scale = 1, ds = true, col = true, dim = 200},
	{id = 8397, x = 3110, y = -1978.5999755859, z = -20.89999961853, rx = 50, ry = 0, rz = 45, scale = 1, ds = true, col = true, dim = 200},
	{id = 8397, x = 3110, y = -2079.3999023438, z = -20.89999961853, rx = 49.998779296875, ry = 0, rz = 134.99996948242, scale = 1, ds = true, col = true, dim = 200}
}

pt.waterTowers = {
	{id = 18284, x = 3166.3999023438, y = -2063.1000976563, z = -2.0999999046326, rx = 0, ry = 0, rz = 179.99450683594, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3155.6000976563, y = -2063.6000976563, z = -2.0999999046326, rx = 0, ry = 0, rz = 180, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3161, y = -2053.1000976563, z = -2, rx = 0, ry = 0, rz = 270, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3161, y = -2074.5, z = -2, rx = 0, ry = 0, rz = 270, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3185.8000488281, y = -2029, z = -2, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3197.3000488281, y = -2034.4000244141, z = -2.0999999046326, rx = 0, ry = 0, rz = 270, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3197.3999023438, y = -2023.5999755859, z = -2.0999999046326, rx = 0, ry = 0, rz = 270, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3208.1000976563, y = -2029, z = -2, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3166.3999023438, y = -1992.9000244141, z = -2.0999999046326, rx = 0, ry = 0, rz = 180, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3155.6000976563, y = -1993.9000244141, z = -2.0999999046326, rx = 0, ry = 0, rz = 179.99450683594, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3161, y = -2004.8000488281, z = -2, rx = 0, ry = 0, rz = 270, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3161, y = -1983.3000488281, z = -2, rx = 0, ry = 0, rz = 270, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3126.1000976563, y = -2034.3000488281, z = -2.0999999046326, rx = 0, ry = 0, rz = 270, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3136.3000488281, y = -2029, z = -2, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3124.8999023438, y = -2023.5999755859, z = -2.0999999046326, rx = 0, ry = 0, rz = 270, scale = 1, ds = true, col = true, dim = 200},
	{id = 18284, x = 3113.8000488281, y = -2029, z = -2, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200}
}

pt.waterjumps = {
	{id = 1632, x = 3145.6999511719, y = -1974, z = 1.8999999761581, rx = 0, ry = 0, rz = 269.99450683594, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3176.6999511719, y = -1974, z = 1.8999999761581, rx = 0, ry = 0, rz = 89.994476318359, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3141, y = -2009.4000244141, z = 1.8999999761581, rx = 0, ry = 0, rz = 224.99456787109, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3104.6000976563, y = -2013.0999755859, z = 1.8999999761581, rx = 0, ry = 0, rz = 180, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3104.6000976563, y = -2044.4000244141, z = 1.8999999761581, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3140.3000488281, y = -2049.8000488281, z = 1.8999999761581, rx = 0, ry = 0, rz = 319.98358154297, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3145.1999511719, y = -2083.8000488281, z = 1.8999999761581, rx = 0, ry = 0, rz = 269.98895263672, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3176.1999511719, y = -2083.8000488281, z = 1.8999999761581, rx = 0, ry = 0, rz = 89.989013671875, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3181.3000488281, y = -2048.6999511719, z = 1.8999999761581, rx = 0, ry = 0, rz = 44.994506835938, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3217.3000488281, y = -2044.8000488281, z = 1.8999999761581, rx = 0, ry = 0, rz = 359.99450683594, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3217.3999023438, y = -2013.3000488281, z = 1.8999999761581, rx = 0, ry = 0, rz = 179.99450683594, scale = 1, ds = true, col = true, dim = 200},
	{id = 1632, x = 3181.3000488281, y = -2009.3000488281, z = 1.8999999761581, rx = 0, ry = 0, rz = 134.99996948242, scale = 1, ds = true, col = true, dim = 200}
}