local sx,sy = guiGetScreenSize()
setTime(12,00)
playSound("sounds/music.mp3" , true)
setSkyGradient(255,255,255,255,255,255)
setWaterColor(255,255,255,255)
setWaveHeight(2)

addEventHandler("onClientRender", getRootElement(),
	function()		
		dxDrawImage(0,(sy/2)-(sx/24),sx/12, sx/14, "images/mlg.png",0,0,0,tocolor(255,255,255,175), false)
	end
)

local Sonichit = 0

addEvent("onSonic", true)
addEventHandler("onSonic", getRootElement(), 
	function()
		playSound("sounds/SANIC.mp3" , false)
		Sonichit = getTickCount()
	end
)

local Illuminatihit = 0

addEvent("onIlluminati", true)
addEventHandler("onIlluminati", getRootElement(), 
	function()
		for k,v in ipairs(getElementsByType("sound")) do
			setSoundVolume(v, 0.2)
		end
		setTimer(
			function()
				for k,v in ipairs(getElementsByType("sound")) do
					setSoundVolume(v, 1)
				end
			end
		, 7000, 1)
	
		playSound("sounds/SPOOKY.mp3" , false)
		Illuminatihit = getTickCount()
	end
)

local Airhornhit = 0

addEvent("onAirhorn", true)
addEventHandler("onAirhorn", getRootElement(), 
	function()
		playSound("sounds/AIRHORN.mp3" , false)
		Airhornhit = getTickCount()
	end
)

local snoop = new(CSprite, "images/snoop.png", 1168, 2400, 8, 8, 58, 50)

addEvent("onWeed", true)
addEventHandler("onWeed", getRootElement(), 
	function()
		playSound("sounds/WEED.mp3" , false)
		snoop:startRender(1, (sx/2)-146, sy-600, 146*2, 300*2)
	end
)

local sniper = new(CSprite, "images/sniper.png", 3500, 1967, 7, 7, 48, 50)

addEvent("onSad", true)
addEventHandler("onSad", getRootElement(), 
	function(thePlayer)
		for k,v in ipairs(getElementsByType("sound")) do
			setSoundVolume(v, 0.2)
		end
		setTimer(
			function()
				for k,v in ipairs(getElementsByType("sound")) do
					setSoundVolume(v, 1)
				end
			end
		, 6000, 1)
		
		sniper:startRender(1, 0, 0, sx, sy)
	
		setTimer(function() playSound("http://soundboard.panictank.net/intervention%20420.mp3", false) end, 1000, 1)
		setTimer(function() playSound("http://translate.google.com/translate_tts?tl=en&q="..removeColorCode(getPlayerName(thePlayer)).."%20is%20a%20mlg%20quickscoper" , false) end, 2000, 1)
	end
)

addEvent("onDarude", true)
addEventHandler("onDarude", getRootElement(), 
	function()
		playSound("sounds/SANDSTORM.mp3" , false)
	end
)

local HitmarkerTime = 0

addEventHandler("onClientVehicleCollision", getRootElement(), 
	function()
		if (source == getCameraTarget()) then
			HitmarkerTime = getTickCount()
			playSound("sounds/HIT.mp3", false)
		end
	end
)

local img1 = dxCreateTexture ( "images/mlg.png")
local img2 = dxCreateTexture ( "images/illuminati.png")
local img3 = dxCreateTexture ( "images/car.jpg")
local img4 = dxCreateTexture ( "images/irace.png")
local img5 = dxCreateTexture ( "images/doritos.jpg")
local img6 = dxCreateTexture ( "images/mountaindew.jpg")

addEventHandler("onClientRender", getRootElement(),
	function()
		if (getTickCount()- HitmarkerTime ) < 1000 then
			dxDrawImage((sx/2)-25, (sy/2)-25, 50, 50, "images/hit.png")
		end
		
		if (getTickCount()- Sonichit ) < 1800 then
			for i=0, 10, 1 do
				dxDrawImage(math.random(0,(sx-150)), math.random(0,(sy-150)), 150, 150, "images/sonic.png")
			end
		end
		
		if (getTickCount()- Illuminatihit ) < 7000 then
			for i=0, 10, 1 do
				local size = 150 + (150-(math.random(1,300)))
				dxDrawImage(math.random(0,(sx-size)), math.random(0,(sy-size)), size, size, "images/illuminati.png")
			end
		end
		
		if (getTickCount()- Airhornhit ) < 1700 then
			local rot = 30 - ((math.random(1,60)))
			dxDrawImage((sx/2)-150, (sy/2)-130, 200, 260, "images/airhorn.png", rot, 0,0)
		end
		
		dxDrawMaterialLine3D ( 3724.2136230469, -4647.0981445313, 53.032691955566, 3724.2136230469, -4647.0981445313, 13.032691955566, img1, 65)
		dxDrawMaterialLine3D ( 3834.5744628906, -4596.6640625, 53.032691955566, 3834.5744628906, -4596.6640625, 3.032691955566, img2, 50)
		dxDrawMaterialLine3D ( 3863.2485351563, -4455.1748046875, 53.032691955566, 3863.2485351563, -4455.1748046875, 3.032691955566, img3, 75)
		dxDrawMaterialLine3D( 3734.6079101563, -4366.9370117188 , 53.032691955566, 3734.6079101563, -4366.9370117188 , 3.032691955566, img4, 50)
		dxDrawMaterialLine3D( 3611.9020996094, -4450.4345703125 , 53.032691955566, 3611.9020996094, -4450.4345703125 , 3.032691955566, img5, 75)
		dxDrawMaterialLine3D( 3564.373046875 , -4587.0756835938 , 53.032691955566, 3564.373046875 , -4587.0756835938 , 3.032691955566, img6, 50)
		--3611.9020996094, -4450.4345703125 [number], 47.473472595215 [number]
		--3564.373046875 , -4587.0756835938 [number], 47.718040466309 [number]
	end
)

function removeColorCode( s )
    return s:gsub( '#%x%x%x%x%x%x', '' )
end