local x, y = guiGetScreenSize()
local pt = {}

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		engineImportTXD(engineLoadTXD ("files/1271.txd"), 1271)
		engineImportTXD(engineLoadTXD("files/648.txd"), 648)
		engineReplaceModel(engineLoadDFF("files/648.dff", 0) , 648)
		engineImportTXD(engineLoadTXD("files/622.txd"), 622 )
		engineReplaceModel(engineLoadDFF("files/622.dff", 0) , 622)
		engineSetModelLODDistance(1271, 500)
		pt.music = playSound("http://irace-mta.de/servermusic/mapmusic/pewx_collapse.mp3", true)
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

local count = 30
function pt.renderBlack()
	count = count - 1
	if count == 0 then count = math.random(2,60) return end
	dxDrawRectangle(0, 0, x, y, tocolor(0, 0, 0), true)
end

addEvent("actionBlack", true)
addEventHandler("actionBlack", root,
	function()
		addEventHandler("onClientRender", root, pt.renderBlack)
		setTimer(function()
			removeEventHandler("onClientRender", root, pt.renderBlack)
		end, 20000, 1)
	end
)