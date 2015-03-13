function DoActionDiscoSlow()
	playSound("http://www.vio-race.de/servermusic/mapmusic/horrorclown_dd-controlled-discoslow.mp3", false)
	setGameSpeed(0.5)
	setWeather(1)
	setTimer(function()
		setGameSpeed(1)
		setWeather(19)
		setTimer(function()
			local r,g,b,r1,g1,b1 = math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255)
			setSkyGradient(r, g, b, r1, g1, b1)
			for i, car in ipairs(getElementsByType("vehicle")) do
				setVehicleColor (car, r, g, b, r1, g1, b1, r, g, b, r1, g1, b1)
				setVehicleOverrideLights (car, 2)
				setVehicleHeadLightColor(car, r, g, b)
			end
		end, 500, 112)
	end, 38000, 1)
	setTimer(setGameSpeed, 94000, 1, 1)
	setTimer(setWeather, 94000, 1, 1)
end

addEvent( "ActionDiscoSlow", true )
addEventHandler( "ActionDiscoSlow", getRootElement(), DoActionDiscoSlow)