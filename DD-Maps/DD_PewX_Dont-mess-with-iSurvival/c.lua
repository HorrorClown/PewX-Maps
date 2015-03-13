--iR|HorrorClown (PewX) - iRace-mta.de - 24.05.2014 --
local root, resroot, me = getRootElement(), getResourceRootElement(), getLocalPlayer()
local targetLost, theTarget = true, nil
local killers = {}

addEvent("onClientAimTargetFound", true)
addEventHandler("onClientAimTargetFound", me, function(ped, target)
	killers[ped] = target
end)

addEvent("onClientAimTargetLost", true)
addEventHandler("onClientAimTargetLost", me, function(ped)
	killers[ped] = false
end)

addEventHandler("onClientPreRender", root, function()
	for ped, target in pairs(killers) do
		if target then
			if isElement(target) then
				if not isPedDead(target) then
					local kX, kY, kZ = getElementPosition(ped)
					local tX, tY, tZ = getElementPosition(target)
					if isLineOfSightClear(kX, kY, kZ, tX, tY, tZ, true, true, false, true, false, false, false) then
						setPedAimTarget(ped, tX, tY, tZ + 0.5)
						if not getPedControlState(ped, "aim_weapon") then setPedControlState(ped, "aim_weapon", true) end
						if not getPedControlState(ped, "fire") then setPedControlState(ped, "fire", true) end
					end
				else
					killers[ped] = false
				end
			else
				killers[ped] = false
			end
		else
			if getPedControlState(ped, "aim_weapon") then setPedControlState(ped, "aim_weapon", false) end
			if getPedControlState(ped, "fire") then setPedControlState(ped, "fire", false) end
		end	
	end
end)

addEventHandler("onClientPedDamage", root, function() triggerServerEvent("checkPedKills", source) end)

local t = {lA = 0}
local x, y = guiGetScreenSize()
function renderLogo()
	dxDrawImage((x/2)-(492/2), (y/2)-(292/2), 492, 292, "files/logo.png", 0, 0, 0, tocolor(255, 255, 255, t.lA))
end

function setLogoAlpha(nA)
	local function render()
		local progress = (getTickCount()-t.sT)/(t.eT-t.sT)
		t.lA = interpolateBetween(t.sA, 0, 0, t.eA, 0, 0, progress, "OutQuad")
		if progress >= 1  then removeEventHandler("onClientRender", root, render) end
	end
	
	t.sA = t.lA
	t.eA = nA
	t.sT = getTickCount()
	t.eT = t.sT + 2500
	addEventHandler("onClientRender", root, render)		
end

local zombiePedSkins = {9, 10, 13, 14, 16, 20, 195, 196, 197, 199, 200, 203, 204, 205, 234, 235, 236, 237, 238, 241, 242, 243, 244, 245, 264}
addEvent("startShowLogo", true)
addEventHandler("startShowLogo", resroot, function()
	playSound("http://irace-mta.de/servermusic/mapmusic/pewx_dont-mess-with-isurvival.mp3", true)
	addEventHandler("onClientRender", root, renderLogo)
	setTimer(function() setLogoAlpha(255)										end, 1000, 1)	
	setTimer(function() setLogoAlpha(0) 										end, 10000, 1)	
	setTimer(function() removeEventHandler("onClientRender", root, renderLogo)	end, 15000, 1)	
end)

addEventHandler("onClientResourceStart", resroot, function()
	--[[for i, skin in ipairs(zombiePedSkins) do
		local txd = engineLoadTXD("skins/" .. tostring(skin) .. ".txd", skin)
		engineImportTXD(txd, skin)
		if skin ~= 264 then
			local dff = engineLoadDFF("skins/" .. tostring(skin) .. ".dff", skin)
			engineReplaceModel(dff, skin)
		end
	end]]
end)