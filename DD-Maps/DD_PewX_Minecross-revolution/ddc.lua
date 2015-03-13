setDevelopmentMode(true)
local pt = {steve = {}, slender = {}, effects = {}}

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		engineImportTXD(engineLoadTXD ("1271.txd"), 1271)
		engineSetModelLODDistance(1271, 500)
		pt.music = playSound("http://irace-mta.de/servermusic/mapmusic/DD_pewx_minecross-revolution.mp3", true)
	end
)

addEvent("sendPowerUp", true)
addEventHandler("sendPowerUp", localPlayer,
	function(state, o)
		if not state then removeEventHandler("onClientRender", root, pt.rotatePowerUp) pt.render = false return end
	
		pt.object = o
		if not pt.render then
			pt.render = true
			addEventHandler("onClientRender", root, pt.rotatePowerUp)
			pt.moveUpDown()
		end
	end
)

addEvent("onPlaySound", true)
addEventHandler("onPlaySound", localPlayer,
	function(sound)
		setSoundPaused(pt.music, true)
		
		local sound = playSound(sound, false)
		setTimer(setSoundPaused, getSoundLength(sound)*1000, 1, pt.music, false)
	end
)

addEvent("onSteveSelectedNewPlayer", true)
addEventHandler("onSteveSelectedNewPlayer", localPlayer,
	function(steve, rp)
		pt.steve.o = steve
		pt.steve.rp = rp
		createEffect("blood_heli", getElementPosition(rp))
		setTimer(function(x, y, z)
			pt.createFire(x, y, z)
		end, 1000, 1, getElementPosition(rp)
		)
		
		--
		if not pt.steve.isRender then pt.steve.isRender = true addEventHandler("onClientRender", root, pt.steve.render)  end
	end
)

addEvent("onSlenderGotNewPosition", true)
addEventHandler("onSlenderGotNewPosition", localPlayer,
	function(slender, pos)
		pt.slender.o = slender
		pt.slender.pos = pos
		if not pt.slender.isRender then pt.slender.isRender = true addEventHandler("onClientRender", root, pt.slender.render)  end
	end
)

function pt.slender.render()
	if not isElement(pt.slender.o) or not pt.slender.pos then pt.slender.isRender = false removeEventHandler("onClientRender", root, pt.slender.render) return end
	local sx, sy, sz = getElementPosition(pt.slender.o)
	local px, py, pz = unpack(pt.slender.pos)
	dxDrawLine3D(sx-2, sy-2, sz + 8, px, py, 0.5, tocolor(255, 0, 0), 2)
	dxDrawLine3D(sx+2, sy+2, sz + 8, px, py, 0.5, tocolor(255, 0, 0), 2)
	local rot = ( 360 - math.deg ( math.atan2 ( ( px - sx ), ( py - sy ) ) ) ) % 360 
	setElementRotation(pt.slender.o, 0, 270, rot)
end

function pt.steve.render()
	if not isElement(pt.steve.o) or not isElement(pt.steve.rp) then pt.steve.isRender = false removeEventHandler("onClientRender", root, pt.steve.render) return end
	local sx, sy, sz = getElementPosition(pt.steve.o)
	local px, py, pz = getElementPosition(pt.steve.rp)
	dxDrawLine3D(sx-2, sy-2, sz + 16, px, py, pz, tocolor(255, 0, 0), 2)
	dxDrawLine3D(sx+2, sy+2, sz + 16, px, py, pz, tocolor(255, 0, 0), 2)
	
	local rot = ( 360 - math.deg ( math.atan2 ( ( px - sx ), ( py - sy ) ) ) ) % 360 
	setElementRotation(pt.steve.o, 0, 270, rot)
end

addEvent("onClientCreateEffect", true)
addEventHandler("onClientCreateEffect", localPlayer,
	function(e, x, y, z)
		local effect = createEffect(e, x, y, z, 0, 0, 0, 500)
		setTimer(function(e) destroyElement(e) end, 20000, 1, effect)
	end
)

addEvent("showSlenderScreen", true)
addEventHandler("showSlenderScreen", localPlayer,
	function()
		local x, y = guiGetScreenSize()
		local r = true
		local function render()
			if r then r = not r return end
			r = true
			dxDrawImage(0, 0, x, y, "slender.jpg", 0, 0, 0, tocolor(255, 255, 255), true)
		end
		addEventHandler("onClientHUDRender", root, render)
		setTimer(function() removeEventHandler("onClientHUDRender", root, render) end, 6000, 1)
	end
)

addEvent("onClientVehicleGravityConfusion", true)
addEventHandler("onClientVehicleGravityConfusion", localPlayer,
	function()		
		local function confusion(stop)
			local veh = getPedOccupiedVehicle(localPlayer)
			local x, y, z = getVehicleGravity(veh)
			local t = {}
			local function render()
				local p = (getTickCount()-t.sT)/(t.eT-t.sT)
				local vx, vy, vz = interpolateBetween(t.se[1], t.se[2], t.se[3], t.se[4], t.se[5], t.se[6], p, "OutInBack")				
				setVehicleGravity(veh, vx, vy, vz)
				if p >= 1 then removeEventHandler("onClientRender", root, render) end
			end
			t.sT = getTickCount()
			t.eT = t.sT + 9800
			t.se = {x, y, z, math.random(-6, 6)/10, math.random(-5, 5)/10, math.random(-13, -7)/10}
			if stop then t.se[4], t.se[5], t.se[6] = 0, 0, -1 end
			addEventHandler("onClientRender", root, render)
		end
		
		setTimer(confusion, 10000, 6)
		setTimer(confusion, 65000, 1, true)
	end
)

function pt.createFire(x, y, z)
	local e = createEffect("fire_large", x, y, z)
	local c = createColSphere(x, y, z, 1)
	local p = createPed(0, x, y, z)
	
	setElementCollidableWith(p, root, false)
	setElementAlpha(p, 0)
	table.insert(pt.effects, {effect = e, colshape = c, ped = p})
	setTimer(function(id, x, y, z) if not isElement(pt.effects[id].colshape) then return end createFire(x, y, z-1, .8) destroyElement(pt.effects[id].effect) destroyElement(pt.effects[id].colshape) destroyElement(pt.effects[id].ped) end, 180000, 1, #pt.effects, x, y, z)
end

addEventHandler("onClientColShapeHit", resourceRoot,
	function(elem)
		if elem ~= localPlayer then return end
		for _, e in ipairs(pt.effects) do
			if e.colshape == source then
				triggerServerEvent("onClientHitEffect", resourceRoot, getElementPosition(e.colshape))
			end
		end
	end
)

addEventHandler("onClientPedHitByWaterCannon", root,
	function(ped)
		for i, e in ipairs(pt.effects) do
			if e.ped == ped then
				local x, y, z = getElementPosition(ped)
				createFire(x, y, z-1, 1.8)
				destroyElement(e.colshape)
				destroyElement(e.ped)
				destroyElement(e.effect)
			end
		end
	end
)

local startTick = getTickCount()
function pt.rotatePowerUp()
	if isElement(pt.object) then
		local angle = math.fmod((getTickCount() - startTick) * 360 / 3000, 360)
		setElementRotation(pt.object, 0, 0, angle)
	else
		removeEventHandler("onClientRender", root, pt.rotatePowerUp)
	end
end

local mT, st = {}, 0
function pt.moveUpDown()
	mT = {}
	local function render()
		local progress = (getTickCount()-mT.sT)/(mT.eT-mT.sT)
		local height = interpolateBetween(mT.sH, 0, 0, mT.eH, 0, 0, progress, "InOutQuad")
		
		if not isElement(pt.object) then removeEventHandler("onClientRender", root, pt.rotatePowerUp) removeEventHandler("onClientRender", root, render) st = 0 return end
		local x, y = getElementPosition(pt.object)
		setElementPosition(pt.object, x, y, height)
		if progress >= 1 then removeEventHandler("onClientRender", root, render) pt.moveUpDown() end
	end
	
	if not isElement(pt.object) then removeEventHandler("onClientRender", root, pt.rotatePowerUp) removeEventHandler("onClientRender", root, render) st = 0 return end
	local _, _, sH = getElementPosition(pt.object)
	mT.sH = sH
	if st == 0 then
		mT.eH = mT.sH + 0.3
		st = 1
	else
		mT.eH = mT.sH - 0.3
		st = 0
	end
	mT.sT = getTickCount()
	mT.eT = mT.sT + 2000
	addEventHandler("onClientRender", root, render)
end