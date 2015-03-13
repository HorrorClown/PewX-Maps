local pt = {powerups = 0} --PewX _ table

function pt.doAction(p)
	pt.powerups = pt.powerups + 1
	local rnd = math.random(1, 30)

	if rnd == 1 then
		if pt.steve and isElement(pt.steve.o) then return false end
		if pt.slender and isElement(pt.slender.o) then return false end
		pt.steve = {}
		pt.steve.o = createObject(7606, 592.7, -2126.7, -30, 0, 270, 0)
		moveObject(pt.steve.o, 20000, 592.7, -2126.7, 19.6, 0, 0, -720)
		setObjectScale(pt.steve.o, 20)
		triggerClientEvent("onPlaySound", root, "tarzan.mp3")
		triggerClientEvent("onClientCreateEffect", root, "prt_wheeldirt", 592.7, -2126.7, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "smoke_flare", 592.7, -2126.7, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 592.7, -2126.7, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 599.4, -2127.4, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 591.4, -2134.6, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 584.1, -2124.9, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 591.7, -2119.4, 1.2)

		setTimer(function()
			if isTimer(pt.steve.rpTimer) then killTimer(pt.steve.rpTimer) end
			if isElement(pt.steve.o) then setTimer(createExplosion, 250, 5, 592.7, -2126.7, 1.2, 10) destroyElement(pt.steve.o) end
		end, 120000, 1)
		
		pt.steve.rpTimer = setTimer(pt.selectRP, 20000, -1)
		pt.steve.rp = getRandomPlayer()
		triggerClientEvent("onSteveSelectedNewPlayer", root, pt.steve.o, pt.steve.rp)
		outputChatBox("|Map| " .. getPlayerName(p) .. "#dd5500 called steve!", root, 255, 255, 255, true)
		
		for _, o in ipairs(pt.woodmid) do
			if o.source then
				moveObject(o.source, 10000, o.x, o.y, -50)
			end
		end
	elseif rnd == 2 then
		if pt.steve and isElement(pt.steve.o) then return false end
		if pt.slender and isElement(pt.slender.o) then return false end
		pt.slender = {}
		pt.slender.o = createObject(1337, 592.7, -2126.7, -20, 0, 270, 0)
		moveObject(pt.slender.o, 20000, 592.7, -2126.7, 14.6, 0, 0, -720)
		setObjectScale(pt.slender.o, 20)
		triggerClientEvent("onPlaySound", root, "tarzan.mp3")
		triggerClientEvent("onClientCreateEffect", root, "prt_wheeldirt", 592.7, -2126.7, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "smoke_flare", 592.7, -2126.7, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 592.7, -2126.7, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 599.4, -2127.4, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 591.4, -2134.6, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 584.1, -2124.9, 1.2)
		triggerClientEvent("onClientCreateEffect", root, "riot_smoke", 591.7, -2119.4, 1.2)
		triggerClientEvent("toggleShader", root, true)
		
		setTimer(function()
			if isTimer(pt.slender.rpTimer) then killTimer(pt.slender.rpTimer) end
			if isElement(pt.slender.o) then setTimer(createExplosion, 250, 5, 592.7, -2126.7, 1.2, 10) destroyElement(pt.slender.o) end
			triggerClientEvent("toggleShader", root, false)
		end, 120000, 1)
		
		pt.slender.rpTimer = setTimer(pt.selectSlenderPlayer, 20000, -1)
		
		
		for _, o in ipairs(pt.woodmid) do
			if o.source then
				moveObject(o.source, 10000, o.x, o.y, -50)
			end
		end
	elseif rnd == 3 then
		outputChatBox("|Map| " .. getPlayerName(p) .. "#dd5500 is a map builder!", root, 255, 255, 255, true)
		for _, o in ipairs(pt.woodmid) do
			if not o.source then
				o.source = createObject(o.id, o.x, o.y, o.z, o.rx, o.ry, o.rz)
				moveObject(o.source, 10000, o.x, o.y, -4.7)
			else
				moveObject(o.source, 10000, o.x, o.y, -4.7)
			end
		end
	elseif rnd == 4 then
		if pt.isWallride then return false end
		pt.isWallride = true
		for i, o in ipairs(pt.wallride) do
			local rx, ry, rz = math.random(0, 360), math.random(0, 360), math.random(0, 360)
			o.source = createObject(o.id, o.x + math.random(-500, 500), o.y  + math.random(-500, 500), o.z+ math.random(-50, 500), rx, ry, rz)
			setElementCollisionsEnabled(o.source, false)
			setTimer(setElementCollisionsEnabled, 10000, 1, o.source, true)
			moveObject(o.source, 10000, o.x, o.y, o.z, o.rx - rx, o.ry - ry, o.rz - rz, "InOutQuad")
			setTimer(function(element)
				if isElement(element) then destroyElement(element) end
				pt.isWallride = false
			end, 120000, 1, o.source)
		end
		outputChatBox("|Map| " .. getPlayerName(p) .. "#dd5500 is building a wallride o:", root, 255, 255, 255, true)
	elseif rnd == 5 then
		triggerClientEvent("onClientVehicleGravityConfusion", root)
		outputChatBox("|Map| " .. getPlayerName(p) .. "#dd5500 will change the gravity :>", root, 255, 255, 255, true)
	elseif rnd >= 10 and rnd <= 15 then
		local vehs = {480,407, 599,506,565,560,535,470,500,579,589,424,444,573,490,601,411,415,477,541}
		local veh = getPedOccupiedVehicle(p)
		local pos = {getElementPosition(veh)}
		setElementModel(veh, vehs[math.random(1,#vehs)])
		setElementPosition(veh, pos[1], pos[2], pos[3]+1)
	elseif rnd >= 16 and rnd <= 18 then
		fixVehicle(getPedOccupiedVehicle(p))
	elseif rnd >= 19 and rnd <= 20 then
		addVehicleUpgrade(getPedOccupiedVehicle(p), 1010)
	else
		outputChatBox("|Map| " .. getPlayerName(p) .. "#dd5500 hit a useless power up :<", root, 255, 255, 255, true)
	end
	return true
end

function pt.getRandomPlayer()
	local c = {}
	for _, p in ipairs(getElementsByType"player") do
		if getElementData(p, "state") == "alive" then
			if not getElementData(p, "AFK") then
				table.insert(c, p)
			end
		end
	end
	return c[math.random(1, #c)]
end

function pt.selectRP()
	pt.steve.rp = pt.getRandomPlayer()
	triggerClientEvent("onSteveSelectedNewPlayer", root, pt.steve.o, pt.steve.rp)
end

function pt.selectSlenderPlayer()
	pt.slender.rp = pt.getRandomPlayer()
	local pos = {getElementPosition(pt.slender.rp)}
	triggerClientEvent("onSlenderGotNewPosition", root, pt.slender.o, pos)
	setTimer(function(pos, rp)
		triggerClientEvent("onSlenderGotNewPosition", root)
		createExplosion(pos[1], pos[2], 1, 2)
		local ped = createPed(115, pos[1], pos[2], 0.8, 0, true)
		local o = createObject(1337, pos[1], pos[2], 0.8)
		setElementCollisionsEnabled(o, false)
		setElementAlpha(o, 0)
		attachElements(ped, o)
		local lp = {getElementPosition(rp)}
		local lr = {getElementRotation(rp)}
		moveObject(o, 350, lp[1], lp[2], lp[3], lr[1], lr[2], lr[3])
		setTimer(function(o, ped, p)
			triggerClientEvent(p, "showSlenderScreen", p)
			triggerClientEvent(p, "onPlaySound", p, "slender.mp3")
			destroyElement(o)
			destroyElement(ped)
		end, 400, 1, o, ped, rp)
	end, 5000, 1, pos, pt.slender.rp)
end

addEvent("onClientHitEffect", true)
addEventHandler("onClientHitEffect", getResourceRootElement(),
	function(x, y, z)
		createExplosion(x, y, z, 1)
	end
)

function pt.spawnPowerUp()
	if pt.powerup and isElement(pt.powerup.object) then destroyElement(pt.powerup.object) end
	if pt.powerup and isElement(pt.powerup.colshape) then destroyElement(pt.powerup.colshape) end
	if pt.powerup and isElement(pt.powerup.marker) then destroyElement(pt.powerup.marker) end
	if pt.powerup and isElement(pt.powerup.blip) then destroyElement(pt.powerup.blip) end
	
	local p = pt.getRandomSpawn()
	pt.powerup = {}
	pt.powerup.object = createObject(1271, p[1], p[2], p[3])
	pt.powerup.colshape = createColSphere(p[1], p[2], p[3], 0.8)
	pt.powerup.marker = createMarker(p[1], p[2], p[3], "corona", 1, 255, 255, 255)
	pt.powerup.blip = createBlip(p[1], p[2], p[3], 0, 2, 255, 80, 0)
	triggerClientEvent("sendPowerUp", getRootElement(), true, pt.powerup.object)
	attachElements(pt.powerup.marker, pt.powerup.object)
	
	setElementCollisionsEnabled(pt.powerup.object, false)
	addEventHandler("onColShapeHit", pt.powerup.colshape, pt.onPowerupHit)
end

function pt.onPowerupHit(e)
	if getElementType(e) ~= "player" then return end
    if pt.powerup and isElement(pt.powerup.object) then destroyElement(pt.powerup.object) end
	if pt.powerup and isElement(pt.powerup.colshape) then destroyElement(pt.powerup.colshape) end
	if pt.powerup and isElement(pt.powerup.marker) then destroyElement(pt.powerup.marker) end
	if pt.powerup and isElement(pt.powerup.blip) then destroyElement(pt.powerup.blip) end
	triggerClientEvent("sendPowerUp", getRootElement(), false)

	if not pt.doAction(e) then
		outputChatBox("|Map| " .. getPlayerName(e) .. "#dd5500 hit a useless power up!", root, 255, 255, 255, true)
	end
	
	setTimer(function()
		pt.spawnPowerUp()
	end, 5000, 1)
end
	
function pt.getRandomSpawn()
	local tbl = math.random(1, #pt.spawns)
	local x = math.random(pt.spawns[tbl][1][1], pt.spawns[tbl][2][1])
	local y = math.random(pt.spawns[tbl][1][2], pt.spawns[tbl][2][2])
	local z = math.random(pt.spawns[tbl][1][3], pt.spawns[tbl][2][3])
	return {x, y, z}
end

function pt.pos(p)
	outputChatBox(("{%s, %s, %s}"):format(getElementPosition(p)))
end
addCommandHandler("p", pt.pos)

setTimer(function()
	pt.spawnPowerUp()
end, 10000, 1)




pt.woodmid = {	
			{id = 2371, x = 591.900390625, y = -2085.6000976563, z = -10.89999997615814, rx = 0, ry = 0, rz = 270},
			{id = 2371, x = 632, y = -2127.6943359375, z = -10.89999997615814, rx = 0, ry = 0, rz = 180},
			{id = 2371, x = 591.900390625, y = -2145.7001953125, z = -10.89999997615814, rx = 0, ry = 0, rz = 270},
			{id = 2371, x = 571.79998779297, y = -2127.6943359375, z = -10.89999997615814, rx = 0, ry = 0, rz = 179.99499511719}
			}

pt.wallride = {
			{id = 2371, x = 611.8349609375, y = -1988.0455322266, z = 4.4000000953674, rx = 0, ry = 270, rz = 261.705078125},
			{id = 2371, x = 621.67163085938, y = -1989.8453369141, z = 4.4000000953674, rx = 0, ry = 270, rz = 257.5576171875},
			{id = 2371, x = 631.3525390625, y = -1992.3515625, z = 4.4000000953674, rx = 0, ry = 270, rz = 253.41015625},
			{id = 2371, x = 640.826171875, y = -1995.5517578125, z = 4.4000000953674, rx = 0, ry = 270, rz = 249.2626953125},
			{id = 2371, x = 650.044921875, y = -1999.4287109375, z = 4.4000000953674, rx = 0, ry = 270, rz = 245.11517333984},
			{id = 2371, x = 658.9580078125, y = -2003.9619140625, z = 4.4000000953674, rx = 0, ry = 270, rz = 240.9677734375},
			{id = 2371, x = 667.51989746094, y = -2009.1285400391, z = 4.4000000953674, rx = 0, ry = 270, rz = 236.8203125},
			{id = 2371, x = 675.68597412109, y = -2014.9005126953, z = 4.4000000953674, rx = 0, ry = 270, rz = 232.67272949219},
			{id = 2371, x = 683.41320800781, y = -2021.2479248047, z = 4.4000000953674, rx = 0, ry = 270, rz = 228.525390625},
			{id = 2371, x = 690.6611328125, y = -2028.1376953125, z = 4.4000000953674, rx = 0, ry = 270, rz = 224.37786865234},
			{id = 2371, x = 697.39178466797, y = -2035.5334472656, z = 4.4000000953674, rx = 0, ry = 270, rz = 220.23046875},
			{id = 2371, x = 703.56994628906, y = -2043.3967285156, z = 4.4000000953674, rx = 0, ry = 270, rz = 216.08294677734},
			{id = 2371, x = 709.16320800781, y = -2051.6862792969, z = 4.4000000953674, rx = 0, ry = 270, rz = 211.93548583984},
			{id = 2371, x = 714.14233398438, y = -2060.3583984375, z = 4.4000000953674, rx = 0, ry = 270, rz = 207.78802490234},
			{id = 2371, x = 718.48114013672, y = -2069.3681640625, z = 4.4000000953674, rx = 0, ry = 270, rz = 203.64050292969},
			{id = 2371, x = 722.15698242188, y = -2078.66796875, z = 4.4000000953674, rx = 0, ry = 270, rz = 199.49310302734},
			{id = 2371, x = 725.15063476563, y = -2088.2094726563, z = 4.4000000953674, rx = 0, ry = 270, rz = 195.34558105469},
			{id = 2371, x = 727.44635009766, y = -2097.9423828125, z = 4.4000000953674, rx = 0, ry = 270, rz = 191.19818115234},
			{id = 2371, x = 729.03216552734, y = -2107.8159179688, z = 4.4000000953674, rx = 0, ry = 270, rz = 187.05072021484},
			{id = 2371, x = 729.89971923828, y = -2117.7780761719, z = 4.4000000953674, rx = 0, ry = 270, rz = 182.90325927734},
			{id = 2371, x = 730.04449462891, y = -2127.7770996094, z = 4.4000000953674, rx = 0, ry = 270, rz = 178.75579833984},
			{id = 2371, x = 729.46569824219, y = -2137.7602539063, z = 4.4000000953674, rx = 0, ry = 270, rz = 174.60827636719},
			{id = 2371, x = 728.16644287109, y = -2147.6755371094, z = 4.4000000953674, rx = 0, ry = 270, rz = 170.46081542969},
			{id = 2371, x = 726.15344238281, y = -2157.4709472656, z = 4.4000000953674, rx = 0, ry = 270, rz = 166.31335449219},
			{id = 2371, x = 723.43731689453, y = -2167.0949707031, z = 4.4000000953674, rx = 0, ry = 270, rz = 162.16589355469},
			{id = 2371, x = 720.0322265625, y = -2176.4973144531, z = 4.4000000953674, rx = 0, ry = 270, rz = 158.01843261719},
			{id = 2371, x = 715.9560546875, y = -2185.62890625, z = 4.4000000953674, rx = 0, ry = 270, rz = 153.87097167969},
			{id = 2371, x = 711.23010253906, y = -2194.4416503906, z = 4.4000000953674, rx = 0, ry = 270, rz = 149.72351074219},
			{id = 2371, x = 705.87915039063, y = -2202.8896484375, z = 4.4000000953674, rx = 0, ry = 270, rz = 145.57604980469},
			{id = 2371, x = 699.93127441406, y = -2210.9284667969, z = 4.4000000953674, rx = 0, ry = 270, rz = 141.42852783203},
			{id = 2371, x = 693.41754150391, y = -2218.5158691406, z = 4.4000000953674, rx = 0, ry = 270, rz = 137.28112792969},
			{id = 2371, x = 686.37213134766, y = -2225.6125488281, z = 4.4000000953674, rx = 0, ry = 270, rz = 133.13363647461},
			{id = 2371, x = 678.83184814453, y = -2232.1811523438, z = 4.4000000953674, rx = 0, ry = 270, rz = 128.98617553711},
			{id = 2371, x = 670.83636474609, y = -2238.1870117188, z = 4.4000000953674, rx = 0, ry = 270, rz = 124.83874511719},
			{id = 2371, x = 662.42736816406, y = -2243.5988769531, z = 4.4000000953674, rx = 0, ry = 270, rz = 120.69122314453},
			{id = 2371, x = 653.64898681641, y = -2248.388671875, z = 4.4000000953674, rx = 0, ry = 270, rz = 116.54382324219},
			{id = 2371, x = 644.54724121094, y = -2252.5307617188, z = 4.4000000953674, rx = 0, ry = 270, rz = 112.39630126953},
			{id = 2371, x = 635.16967773438, y = -2256.0036621094, z = 4.4000000953674, rx = 0, ry = 270, rz = 108.24884033203},
			{id = 2371, x = 625.56555175781, y = -2258.7895507813, z = 4.4000000953674, rx = 0, ry = 270, rz = 104.10137939453},
			{id = 2371, x = 615.78509521484, y = -2260.8732910156, z = 4.4000000953674, rx = 0, ry = 270, rz = 99.953948974609},
			{id = 2371, x = 605.87951660156, y = -2262.2443847656, z = 4.4000000953674, rx = 0, ry = 270, rz = 95.806457519531},
			{id = 2371, x = 595.90069580078, y = -2262.8955078125, z = 4.4000000953674, rx = 0, ry = 270, rz = 91.658966064453},
			{id = 2371, x = 585.90100097656, y = -2262.8229980469, z = 4.4000000953674, rx = 0, ry = 270, rz = 87.511535644531},
			{id = 2371, x = 575.93267822266, y = -2262.0275878906, z = 4.4000000953674, rx = 0, ry = 270, rz = 83.364074707031},
			{id = 2371, x = 566.04797363281, y = -2260.5134277344, z = 4.4000000953674, rx = 0, ry = 270, rz = 79.216613769531},
			{id = 2371, x = 556.29870605469, y = -2258.2880859375, z = 4.4000000953674, rx = 0, ry = 270, rz = 75.069122314453},
			{id = 2371, x = 546.73590087891, y = -2255.3635253906, z = 4.4000000953674, rx = 0, ry = 270, rz = 70.921691894531},
			{id = 2371, x = 537.40960693359, y = -2251.7551269531, z = 4.4000000953674, rx = 0, ry = 270, rz = 66.774200439453},
			{id = 2371, x = 528.36877441406, y = -2247.4816894531, z = 4.4000000953674, rx = 0, ry = 270, rz = 62.626739501953},
			{id = 2371, x = 519.66064453125, y = -2242.5654296875, z = 4.4000000953674, rx = 0, ry = 270, rz = 58.479278564453},
			{id = 2371, x = 511.33090209961, y = -2237.0324707031, z = 4.4000000953674, rx = 0, ry = 270, rz = 54.331787109375},
			{id = 2371, x = 503.42315673828, y = -2230.9113769531, z = 4.4000000953674, rx = 0, ry = 270, rz = 50.184356689453},
			{id = 2371, x = 495.9787902832, y = -2224.234375, z = 4.4000000953674, rx = 0, ry = 270, rz = 46.036865234375},
			{id = 2371, x = 489.0368347168, y = -2217.0366210938, z = 4.4000000953674, rx = 0, ry = 270, rz = 41.889404296875},
			{id = 2371, x = 546.73590087891, y = -2255.3635253906, z = 4.4000000953674, rx = 0, ry = 270, rz = 70.921691894531},
			{id = 2371, x = 537.40960693359, y = -2251.7551269531, z = 4.4000000953674, rx = 0, ry = 270, rz = 66.774200439453},
			{id = 2371, x = 528.36877441406, y = -2247.4816894531, z = 4.4000000953674, rx = 0, ry = 270, rz = 62.626739501953},
			{id = 2371, x = 466.97680664063, y = -2183.8266601563, z = 4.4000000953674, rx = 0, ry = 270, rz = 25.299530029297},
			{id = 2371, x = 463.03326416016, y = -2174.6369628906, z = 4.4000000953674, rx = 0, ry = 270, rz = 21.152099609375},
			{id = 2371, x = 459.7646484375, y = -2165.1862792969, z = 4.4000000953674, rx = 0, ry = 270, rz = 17.004638671875},
			{id = 2371, x = 457.18811035156, y = -2155.5239257813, z = 4.4000000953674, rx = 0, ry = 270, rz = 12.857147216797},
			{id = 2371, x = 455.31713867188, y = -2145.7004394531, z = 4.4000000953674, rx = 0, ry = 270, rz = 8.7096862792969},
			{id = 2371, x = 454.16152954102, y = -2135.767578125, z = 4.4000000953674, rx = 0, ry = 270, rz = 4.5622253417969},
			{id = 2371, x = 453.72735595703, y = -2125.7768554688, z = 4.4000000953674, rx = 0, ry = 270, rz = 0.41476440429688},
			{id = 2371, x = 454.01684570313, y = -2115.7810058594, z = 4.4000000953674, rx = 0, ry = 270, rz = 356.26733398438},
			{id = 2371, x = 455.02853393555, y = -2105.8322753906, z = 4.4000000953674, rx = 0, ry = 270, rz = 352.11981201172},
			{id = 2371, x = 459.19348144531, y = -2086.2841796875, z = 4.4000000953674, rx = 0, ry = 270, rz = 343.82482910156},
			{id = 2371, x = 462.3249206543, y = -2076.787109375, z = 4.4000000953674, rx = 0, ry = 270, rz = 339.67742919922},
			{id = 2371, x = 466.1350402832, y = -2067.5415039063, z = 4.4000000953674, rx = 0, ry = 270, rz = 335.52996826172},
			{id = 2371, x = 470.60385131836, y = -2058.5954589844, z = 4.4000000953674, rx = 0, ry = 270, rz = 331.38250732422},
			{id = 2371, x = 475.70794677734, y = -2049.9963378906, z = 4.4000000953674, rx = 0, ry = 270, rz = 327.23498535156},
			{id = 2371, x = 481.4206237793, y = -2041.7885742188, z = 4.4000000953674, rx = 0, ry = 270, rz = 323.08752441406},
			{id = 2371, x = 487.71197509766, y = -2034.015625, z = 4.4000000953674, rx = 0, ry = 270, rz = 318.94006347656},
			{id = 2371, x = 494.54898071289, y = -2026.7180175781, z = 4.4000000953674, rx = 0, ry = 270, rz = 314.79266357422},
			{id = 2371, x = 501.89590454102, y = -2019.9339599609, z = 4.4000000953674, rx = 0, ry = 270, rz = 310.64514160156},
			{id = 2371, x = 509.71420288086, y = -2013.6990966797, z = 4.4000000953674, rx = 0, ry = 270, rz = 306.49768066406},
			{id = 2371, x = 517.96295166016, y = -2008.0460205078, z = 4.4000000953674, rx = 0, ry = 270, rz = 302.35021972656},
			{id = 2371, x = 526.59899902344, y = -2003.0042724609, z = 4.4000000953674, rx = 0, ry = 270, rz = 298.20275878906},
			{id = 2371, x = 535.57702636719, y = -1998.6003417969, z = 4.4000000953674, rx = 0, ry = 270, rz = 294.05529785156},
			{id = 2371, x = 544.85009765625, y = -1994.8571777344, z = 4.4000000953674, rx = 0, ry = 270, rz = 289.90783691406},
			{id = 2371, x = 554.36956787109, y = -1991.7945556641, z = 4.4000000953674, rx = 0, ry = 270, rz = 285.76037597656},
			{id = 2371, x = 564.08563232422, y = -1989.4284667969, z = 4.4000000953674, rx = 0, ry = 270, rz = 281.61291503906},
			{id = 2371, x = 573.94732666016, y = -1987.7712402344, z = 4.4000000953674, rx = 0, ry = 270, rz = 277.46545410156},
			{id = 2371, x = 583.90307617188, y = -1986.8316650391, z = 4.4000000953674, rx = 0, ry = 270, rz = 273.31799316406},
			{id = 2371, x = 593.90075683594, y = -1986.6145019531, z = 4.4000000953674, rx = 0, ry = 270, rz = 269.17053222656},
			{id = 2371, x = 601.89385986328, y = -1986.9619140625, z = 4.4000000953674, rx = 0, ry = 270, rz = 265.8525390625},
			{id = 2371, x = 466.9765625, y = -2183.826171875, z = 4.4000000953674, rx = 0, ry = 270, rz = 25.299530029297},
			{id = 2371, x = 471.57421875, y = -2192.70703125, z = 4.4000000953674, rx = 0, ry = 270, rz = 29.447021484375},
			{id = 2371, x = 476.802734375, y = -2201.2314453125, z = 4.4000000953674, rx = 0, ry = 270, rz = 33.594482421875},
			{id = 2371, x = 482.63363647461, y = -2209.35546875, z = 4.4000000953674, rx = 0, ry = 270, rz = 37.741943359375},
			{id = 2371, x = 456.75708007813, y = -2095.9829101563, z = 4.4000000953674, rx = 0, ry = 270, rz = 347.97241210938}
			}

pt.spawns = {
			{{557.96862792969, -2083.2204589844, 1}, {623.51300048828, -2046.9645996094, 1}},
			{{514.84085083008, -2160.1005859375, 1}, {548.1953125, -2095.3029785156, 1}},
			{{555.05404663086, -2204.1013183594, 1}, {619.24084472656, -2168.4047851563, 1}},
			{{634.16186523438, -2161.2697753906, 1}, {669.74865722656, -2095.3657226563, 1}}
			}