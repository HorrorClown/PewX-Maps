sx,sy = guiGetScreenSize()
StartTick = getTickCount()
AngelPlayer = getLocalPlayer()
AngelSeen = false
CClient = {}
 
function CClient:constructor()
	self.Sound = playSound( "http://irace-mta.de/servermusic/mapmusic/rewrite-ft-pewx_dr-who.mp3" , true)
	setSoundVolume(self.Sound, 0.6)
	
	addEvent("playClientSound", true)
	addEventHandler("playClientSound", getRootElement(),
		function(str)
			local sound = playSound("sounds/"..str..".mp3")
			addEventHandler("onClientSoundStop", getRootElement(), function() outputChatBox(tostirng(#getElementsByType("sound"))) end)
		end
	)
	
	addEvent("StartDoctorEvent", true)
	addEventHandler("StartDoctorEvent", getRootElement(), bind(CClient.StartDoctorEvent, self))
	
	addEvent("StartSilenceEvent", true)
	addEventHandler("StartSilenceEvent", getRootElement(), bind(CClient.StartSilenceEvent, self))
	
	addEvent("StartAngelEvent", true)
	addEventHandler("StartAngelEvent", getRootElement(), bind(CClient.StartAngelEvent, self))
	
	engineImportTXD(engineLoadTXD("mods/tardis.txd"), 10377) 
	engineReplaceModel(engineLoadDFF("mods/tardis.dff", 10377), 10377)

	engineImportTXD(engineLoadTXD("mods/dalek.txd"), 520) 
	engineReplaceModel(engineLoadDFF("mods/dalek.dff", 520), 520)

	engineImportTXD(engineLoadTXD("mods/doctor10.txd"), 52) 
	engineReplaceModel(engineLoadDFF("mods/doctor10.dff", 52), 52)	
	
	engineImportTXD(engineLoadTXD("mods/silence.txd"), 53) 
	engineReplaceModel(engineLoadDFF("mods/silence.dff", 53), 53)	
	
	setMinuteDuration(0)
	setTime(01,00)
end 
 
function CClient:destructor()
	destroyElement(self.Sound)
end
 
function CClient:StartAngelEvent(thePlayer)
	self.AngelCounter = 1
	AngelCounter = 1
	self.Angel = thePlayer
	AngelPlayer = thePlayer
	AngelSeen = false
	StartTick = getTickCount()
	addEventHandler("onClientRender", getRootElement(), drawAngel)
end

function CClient:StartSilenceEvent(theSilence)
	self.SawSilence = false
	
	StartTick = getTickCount()
	
	local x,y,z = getElementPosition(theSilence)
	
	setTimer(
	function()
		local cx,cy = getScreenFromWorldPosition (x,y,z)
		if (cx) then
			self.SawSilence = true
		else
			if (self.SawSilence) and not (isTimer(self.SilenceTimer)) and ( (StartTick-getTickCount()) < 20000 ) then
				self.SawSilence = false
				triggerEvent("playClientSound", getRootElement(), "silence")
				setElementHealth(getPedOccupiedVehicle(localPlayer), 300)
				addEventHandler("onClientRender", getRootElement(), drawSilence)
				self.SilenceTimer = setTimer(
					function()
						self.SawSilence = false
						removeEventHandler("onClientRender", getRootElement(), drawSilence)
						killTimer(self.SilenceTimer) self.SilenceTimer = nil 
					end
				, 15000, 1)
			end
		end
	end
	, 500, 40)

end

function CClient:StartDoctorEvent()
	StartTick = getTickCount()
	setWorldSpecialPropertyEnabled("aircars", true)
	addEventHandler("onClientRender", getRootElement(), drawFlyCountdown)
	setTimer(
		function() 
			setWorldSpecialPropertyEnabled("aircars", false) 
			removeEventHandler("onClientRender", getRootElement(), drawFlyCountdown, starttick)
		end
	, 30000, 1)
	
end
 
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function() Client = new(CClient) end)
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), function() delete(Client) end)

function drawFlyCountdown()
	if (math.floor(((getTickCount()- StartTick)/1000)) >= 0) then
		dxDrawText(tostring(30-math.floor(((getTickCount()- StartTick)/1000))), 0, 0, sx, 50, white, 5, "default-bold", "center", "center", false, false, false)
	end
end

function drawSilence()
	dxDrawImage(0,0,sx,sy, "images/silence.jpg")
end

function drawAngel()
	if (isPedInVehicle(AngelPlayer)) then
		local px,py,pz = getElementPosition(getPedOccupiedVehicle(AngelPlayer))
		local x,y,z = getCameraMatrix()
		local cx, cy = getScreenFromWorldPosition(px,py,pz+2)
		if ( isLineOfSightClear(px, py, pz+2, x, y, z) and (cx and cy)) then
			AngelSeen = true
			dxDrawImage(cx-50,cy-25,100,50, "images/"..tostring(AngelCounter)..".jpg")
		else
			if (AngelSeen) then
				if (AngelCounter < 4) then
					AngelCounter = AngelCounter+1
					AngelSeen = false
				else
					if (isPedInVehicle(localPlayer)) then
						blowVehicle(getPedOccupiedVehicle(localPlayer))
						addEventHandler("onClientRender", getRootElement(), drawDeadAngel)
					end
					removeEventHandler("onClientRender", getRootElement(), drawAngel)
					return
				end
			end
		end
	end
	if ((getTickCount() - StartTick) > 50000) then
		removeEventHandler("onClientRender", getRootElement(), drawAngel)
	end
end


local sx, sy = guiGetScreenSize()
local deadAngelStartTick = false
function drawDeadAngel()
	if (not deadAngelStartTick) then
		deadAngelStartTick = getTickCount()
	end
	
	if (getTickCount()-deadAngelStartTick < 4000) then
		dxDrawImage(0,0,sx,sy, "images/"..(math.floor((getTickCount()-deadAngelStartTick) / 1000)+1)..".jpg", 0,0,0,tocolor(255,255,255,255), true)
	else
		deadAngelStartTick = false
		removeEventHandler("onClientRender", getRootElement(), drawDeadAngel)
	end

end