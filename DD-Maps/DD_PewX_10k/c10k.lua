--PewX - 12.03.2015
local k10 = {}

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		engineImportTXD(engineLoadTXD ("files/1271.txd"), 1271)
		engineImportTXD(engineLoadTXD("files/648.txd"), 648)
		engineReplaceModel(engineLoadDFF("files/648.dff", 0) , 648)
		engineImportTXD(engineLoadTXD("files/622.txd"), 622 )
		engineReplaceModel(engineLoadDFF("files/622.dff", 0) , 622)
		engineImportTXD(engineLoadTXD("files/vgncarshade1.txd"), 8557)
		engineImportTXD(engineLoadTXD("files/vgncarshade1.txd"), 3458)
		engineReplaceModel(engineLoadDFF("files/brown.dff", 8557), 8557)
		engineReplaceModel(engineLoadDFF ( "files/grey.dff", 3458), 3458)
		engineSetModelLODDistance(1271, 500)
		k10.music = playSound("http://irace-mta.de/servermusic/mapmusic/pewx_10k.mp3", true)
	end
)

addEvent("sendPowerUp", true)
addEventHandler("sendPowerUp", localPlayer,
	function(state, o)
		if not state then removeEventHandler("onClientRender", root, k10.rotatePowerUp) k10.render = false return end
	
		k10.object = o
		if not k10.render then
			k10.render = true
			addEventHandler("onClientRender", root, k10.rotatePowerUp)
			k10.moveUpDown()
		end
	end
)

local startTick = getTickCount()
function k10.rotatePowerUp()
	if isElement(k10.object) then
		local angle = math.fmod((getTickCount() - startTick) * 360 / 3000, 360)
		setElementRotation(k10.object, 0, 0, angle)
	else
		removeEventHandler("onClientRender", root, k10.rotatePowerUp)
	end
end

local mT, st = {}, 0
function k10.moveUpDown()
	mT = {}
	local function render()
		local progress = (getTickCount()-mT.sT)/(mT.eT-mT.sT)
		local height = interpolateBetween(mT.sH, 0, 0, mT.eH, 0, 0, progress, "InOutQuad")
		
		if not isElement(k10.object) then removeEventHandler("onClientRender", root, k10.rotatePowerUp) removeEventHandler("onClientRender", root, render) st = 0 return end
		local x, y = getElementPosition(k10.object)
		setElementPosition(k10.object, x, y, height)
		if progress >= 1 then removeEventHandler("onClientRender", root, render) k10.moveUpDown() end
	end
	
	if not isElement(k10.object) then removeEventHandler("onClientRender", root, k10.rotatePowerUp) removeEventHandler("onClientRender", root, render) st = 0 return end
	local _, _, sH = getElementPosition(k10.object)
	mT.sH = sH
	if st == 0 then
		mT.eH = mT.sH + 0.5
		st = 1
	else
		mT.eH = mT.sH - 0.5
		st = 0
	end
	mT.sT = getTickCount()
	mT.eT = mT.sT + 2000
	addEventHandler("onClientRender", root, render)
end