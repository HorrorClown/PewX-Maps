--iR|HorrorClown (PewX) - iRace-mta.de - 22.03.2014
local rroot, root, me = getResourceRootElement(), getRootElement(), getLocalPlayer()
local mainTower, subTowers = nil, nil

addEvent("onCreateMainTower", true)
addEventHandler("onCreateMainTower", root, function(mt, st)
	mainTower = mt
	subTowers = st
	setWaveHeight(1)
	
	addEventHandler("onClientRender", root, function()
		local _, _, rz = getElementRotation(mainTower)
		if rz >= 360 then rz = 0 end
		setElementRotation(mainTower, 0, 0, rz+1)
	end)
end)

addEventHandler("onClientResourceStart", rroot, function()
	triggerServerEvent("onClientRequest", me)
	playSound("http://irace-mta.de/servermusic/mapmusic/pewx_the-revolution.mp3", true)
end)

function rotateSubTowers()
	for i, tower in ipairs(subTowers) do
		local _, _, rz = getElementRotation(tower)
		if rz >= 360 then rz = 0 end
		setElementRotation(tower, 0, 0, rz+1)
	end
end

function drawHypnoticShit()
	if math.random(0,1) == 1 then tR = 200 else tR = 0 end
	if math.random(0,1) == 1 then tG = 200 else tG = 0 end
	if math.random(0,1) == 1 then tB = 200 else tB = 0 end
	if math.random(0,1) == 1 then bR = 200 else bR = 0 end
	if math.random(0,1) == 1 then bG = 200 else bG = 0 end
	if math.random(0,1) == 1 then bB = 200 else bB = 0 end
	setSkyGradient(tR, tG, tB, bR, bG, bB)
	setWaterColor(tR, bG, tB)
end

addEvent("rotateSubTowers", true)
addEventHandler("rotateSubTowers", root, function(state)
	if state then addEventHandler("onClientRender", root, rotateSubTowers) else removeEventHandler("onClientRender", root, rotateSubTowers) end	
end)

addEvent("onHypnoticStateChange", true)
addEventHandler("onHypnoticStateChange", root, function(state)
	if state then addEventHandler("onClientRender", root, drawHypnoticShit) else removeEventHandler("onClientRender", root, drawHypnoticShit) resetSkyGradient() end
end)