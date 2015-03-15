--PewX - 12.03.2015
local k10 = {}
k10.vehicles = {496,504,402,541,415,542,589,480,507,562,587,533,565,474,434,494,502,503,579,545,411,559,400,500,603,489,505,534,495,567,535,458,561,409,560,506,549,420,583,451,558,555,477,509,581,481,462,521,463,510,522,561,448,468,586,416,523,427,490,528,407,544,596,598,599,597,601,422,482,483,588,444,556,557,523,582,470,543,574,525,552,478,554,433,431,524,437,573,455,568,424,457,486,406,530,571,572,471,531,605}  

addEventHandler("onResourceStart", resourceRoot,
	function()
		k10.mainShades = {}
		for _, o in ipairs(getElementsByType("object", resourceRoot)) do
			local oID = getElementModel(o)
			if oID == 3458 then
				table.insert(k10.mainShades, o)
			elseif k10.isDeco(oID) then
				setElementCollisionsEnabled(o, false)
			end
		end
	end
)

addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging", root,
	function(ns)
		if ns == "Running" then
			for _, p in ipairs(getElementsByType"player") do
				local v = getPedOccupiedVehicle(p)
				if v then
					local vv = {getElementVelocity(v)}
					setElementVelocity(v, 0, 0, 1.4)
					local _, _, zr = getElementRotation(v)
					setVehicleTurnVelocity(v, math.random(-1,1)/10, math.random(-1,1)/10, 0)
					
					setTimer(function(v, zr)
						setVehicleDamageProof(v, true)
						local vp = {getElementPosition(v)}
						local vr = {getElementRotation(v)}
						local o = createObject(2932, vp[1], vp[2], vp[3], vr[1], vr[2], vr[3])
						setObjectScale(o, 0)
						attachElements(v, o)

						moveObject(o, 5500, vp[1], vp[2], 109.5, vr[1] < 0 and vr[1] or -vr[1], vr[2] < 0 and vr[2] or -vr[2], vr[3] < 0 and vr[3] or -vr[3], "InOutQuad")
						setTimer(destroyElement, 5500, 1, o)
						setTimer(setVehicleDamageProof, 5500, 1, v, false)
					end, 5000, 1, v, zr)
				end
			end
			k10.moveShades()
			setTimer(k10.createMap, 3000, 1)
		end
	end
)

function k10.moveShades()
	for i, o in ipairs(k10.mainShades) do
		local t = k10.shades[i]
		local rx, ry, rz = getElementRotation(o)
		moveObject(o, 10500, t.x, t.y, t.z, t.rx - rx, t.ry - ry, t.rz - rz, "InOutQuad")
		setElementCollisionsEnabled(o, true)
	end
end

function k10.createMap()
	for i, o in ipairs(k10.towers) do
		local rx, ry, rz = 0,0, math.random(0, 360)
		o.source = createObject(o.id, o.x + math.random(-100, 100), o.y  + math.random(-100, 100), -150, rx, ry, rz)
		setElementCollisionsEnabled(o.source, false)
		setTimer(setElementCollisionsEnabled, 7500, 1, o.source, true)
		moveObject(o.source, 7500, o.x, o.y, o.z, o.rx - rx, o.ry - ry, o.rz - rz, "InOutQuad")
	end
end

k10.decoIDs = {16118, 17026, 621, 622}
function k10.isDeco(oID)
	if not oID then return false end
	for _, dID in ipairs(k10.decoIDs) do
		if dID == oID then
			return true
		end
	end
end

function k10.doAction(ePlayer , eVehicle)
	local a = math.random(1, 50)
	
	if a >= 1 and a <= 47 then
		local rnd = k10.vehicles[math.random(1, #k10.vehicles)]
		setElementModel(eVehicle, rnd)
		k10.fixZPosition(eVehicle)
		return true
	elseif a == 48 then
		local rnd = k10.vehicles[math.random(1, #k10.vehicles)]
		for _, p in ipairs(getElementsByType"player") do
			local v = getPedOccupiedVehicle(p)
			if getElementData(p, "state") == "alive" and v then
				setElementModel(v, rnd)
				k10.fixZPosition(v)
			end
		end
		k10.message("Everyone got the same random vehicle by " .. getPlayerName(ePlayer), root)
		return true
	elseif a == 49 then
		for _, p in ipairs(getElementsByType"player") do
			local v = getPedOccupiedVehicle(p)
			if getElementData(p, "state") == "alive" and v then
				setElementModel(v, k10.vehicles[math.random(1, #k10.vehicles)])
				k10.fixZPosition(v)
			end
		end
		k10.message("Everyone got a random vehicle by " .. getPlayerName(ePlayer), root)
		return true
	elseif a == 50 then
		local p = k10.getRandomAlivePlayer()
		local v = getPedOccupiedVehicle(p)
		setElementModel(v, k10.vehicles[math.random(1, #k10.vehicles)])
		k10.message("You gives a random vehicle to " .. getPlayerName(p), ePlayer)
		k10.message("You got a random vehicle by " .. getPlayerName(ePlayer), p)
		k10.fixZPosition(v)
		return true
	end
end

function k10.fixZPosition(eVehicle)
	local vx, vy, vz = getElementPosition(eVehicle)
	setElementPosition(eVehicle, vx, vy, vz + 1)
end

function k10.getRandomAlivePlayer()
	local t = {}
	for _, p in ipairs(getElementsByType"player") do
		if getElementData(p, "state") == "alive" then table.insert(t, p) end
	end
	return t[math.random(1, #t)]
end

function k10.spawnPowerUp()
	if k10.powerup and isElement(k10.powerup.object) then destroyElement(k10.powerup.object) end
	if k10.powerup and isElement(k10.powerup.colshape) then destroyElement(k10.powerup.colshape) end
	--if k10.powerup and isElement(k10.powerup.marker) then destroyElement(k10.powerup.marker) end
	if k10.powerup and isElement(k10.powerup.blip) then destroyElement(k10.powerup.blip) end
	
	local p = k10.getRandomSpawn()
	k10.powerup = {}
	k10.powerup.object = createObject(1271, p[1], p[2], p[3])
	k10.powerup.colshape = createColSphere(p[1], p[2], p[3], 2)
	--k10.powerup.marker = createMarker(p[1], p[2], p[3], "corona", 1, 255, 255, 255)
	k10.powerup.blip = createBlip(p[1], p[2], p[3], 0, 2, 255, 80, 0)
	triggerClientEvent("sendPowerUp", getRootElement(), true, k10.powerup.object)
	--attachElements(k10.powerup.marker, k10.powerup.object)
	
	setElementCollisionsEnabled(k10.powerup.object, false)
	addEventHandler("onColShapeHit", k10.powerup.colshape, k10.onPowerupHit)
end

function k10.onPowerupHit(e)
	if getElementType(e) ~= "vehicle" then return end
    if k10.powerup and isElement(k10.powerup.object) then destroyElement(k10.powerup.object) end
	if k10.powerup and isElement(k10.powerup.colshape) then destroyElement(k10.powerup.colshape) end
	--if k10.powerup and isElement(k10.powerup.marker) then destroyElement(k10.powerup.marker) end
	if k10.powerup and isElement(k10.powerup.blip) then destroyElement(k10.powerup.blip) end
	triggerClientEvent("sendPowerUp", getRootElement(), false)
	
	local p = getVehicleController(e)
	if not k10.doAction(p, e) then
		outputChatBox("|Map| " .. getPlayerName(p) .. "#dd5500 hit a useless power up!", root, 255, 255, 255, true)
	end
	setTimer(function()
		k10.spawnPowerUp()
	end, 5000, 1) --5000
end

function k10.message(sMessage, toElement)
	outputChatBox("|Map|#dd5500 " .. sMessage, toElement or root, 255, 255, 255, true)
end

function k10.getRandomSpawn()
	local tbl = math.random(1, #k10.spawns)
	local x = math.random(k10.spawns[tbl][1][1], k10.spawns[tbl][2][1])
	local y = math.random(k10.spawns[tbl][1][2], k10.spawns[tbl][2][2])
	local z = 109 --math.random(k10.spawns[tbl][1][3], k10.spawns[tbl][2][3])
	return {x, y, z}
end

setTimer(function()
	k10.spawnPowerUp()
end, 15000, 1) --10000

k10.spawns = {
			{{3061, -1238, 2}, {3138, -1195, 2}},
			{{3061, -1174, 2}, {3138, -1132, 2}}
			}

k10.towers = {
	{id = 4585, x = 3079, y = -1215.9000244141, z = 8.1000003814697, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 4585, x = 3079, y = -1152.5999755859, z = 8.1000003814697, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 4585, x = 3119.6999511719, y = -1152.5999755859, z = 8.1000003814697, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 4585, x = 3119.6999511719, y = -1215.9000244141, z = 8.1000003814697, rx = 0, ry = 0, rz = 0, scale = 1, ds = true, col = true, dim = 200},
	{id = 4585, x = 3018.6000976563, y = -1152.5999755859, z = 8.1000003814697, rx = 0, ry = 0, rz = 315, scale = 1, ds = true, col = true, dim = 200},
	{id = 4585, x = 3018.3000488281, y = -1215.9000244141, z = 8.1000003814697, rx = 0, ry = 0, rz = 45, scale = 1, ds = true, col = true, dim = 200},
	{id = 4585, x = 3180, y = -1152.5999755859, z = 8.1000003814697, rx = 0, ry = 0, rz = 45, scale = 1, ds = true, col = true, dim = 200},
	{id = 4585, x = 3180, y = -1215.900390625, z = 8.1000003814697, rx = 0, ry = 0, rz = 315, scale = 1, ds = true, col = true, dim = 200}
}

k10.shades = {
	{id = 3458, x = 3182.3999023438, y = -1185.4000244141, z = 106.40000152588, rx = 0, ry = 0, rz = 89.989013671875, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3159.6999511719, y = -1184.0999755859, z = 106.40000152588, rx = 0, ry = 0, rz = 0.009033203125, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3137.1000976563, y = -1185.5, z = 106.40000152588, rx = 0, ry = 0, rz = 89.994476318359, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3131.1000976563, y = -1185, z = 106.40000152588, rx = 0, ry = 0, rz = 269.98895263672, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3146, y = -1215.8000488281, z = 106.40000152588, rx = 0, ry = 0, rz = 359.98358154297, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3145.1000976563, y = -1220.9000244141, z = 106.40000152588, rx = 0, ry = 0, rz = 179.98352050781, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3156.6999511719, y = -1238.9000244141, z = 106.40000152588, rx = 0, ry = 0, rz = 351.98785400391, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3145.3000488281, y = -1152.5999755859, z = 106.40000152588, rx = 0, ry = 0, rz = 179.98901367188, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3145.8000488281, y = -1147.5, z = 106.40000152588, rx = 0, ry = 0, rz = 359.98901367188, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3156.6000976563, y = -1129.6999511719, z = 106.40000152588, rx = 0, ry = 0, rz = 8.009033203125, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3099.1000976563, y = -1184.9000244141, z = 106.39700317383, rx = 0, ry = 0, rz = 74, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3099.6000976563, y = -1184.6999511719, z = 106.40000152588, rx = 0, ry = 0, rz = 285.99450683594, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3067.6000976563, y = -1184, z = 106.40000152588, rx = 0, ry = 0, rz = 89.995788574219, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3061.6000976563, y = -1184, z = 106.40000152588, rx = 0, ry = 0, rz = 269.99450683594, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3038.8999023438, y = -1184.3000488281, z = 106.40000152588, rx = 0, ry = 0, rz = 0.0054931640625, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3016.1999511719, y = -1183.4000244141, z = 106.40000152588, rx = 0, ry = 0, rz = 89.989013671875, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3050.6999511719, y = -1152.6999511719, z = 106.40000152588, rx = 0, ry = 0, rz = 179.98901367188, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3050.6000976563, y = -1147.5999755859, z = 106.40000152588, rx = 0, ry = 0, rz = 359.98901367188, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3041.6000976563, y = -1130, z = 106.40000152588, rx = 0, ry = 0, rz = 351.98785400391, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3051.3999023438, y = -1215.8000488281, z = 106.40000152588, rx = 0, ry = 0, rz = 359.98901367188, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3051.5, y = -1220.9000244141, z = 106.40000152588, rx = 0, ry = 0, rz = 179.98901367188, scale = 1, ds = true, col = true, dim = 200},
	{id = 3458, x = 3041.1999511719, y = -1238.5999755859, z = 106.40000152588, rx = 0, ry = 0, rz = 8.0145263671875, scale = 1, ds = true, col = true, dim = 200}
}