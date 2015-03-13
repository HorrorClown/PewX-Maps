function DoActionDiscoSpeed()
	playSound("http://www.vio-race.de/servermusic/mapmusic/horrorclown_dd-controlled-discospeed.mp3", false)
	setGameSpeed(1)
	setWeather(1)
	setTimer(function()
		setGameSpeed(2)
		setWeather(19)
		setTimer(function()
			local r,g,b,r1,g1,b1 = math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255)
			setSkyGradient(r, g, b, r1, g1, b1)
			for i, car in ipairs(getElementsByType("vehicle")) do
				setVehicleColor (car, r, g, b, r1, g1, b1, r, g, b, r1, g1, b1)
				setVehicleOverrideLights (car, 2)
				setVehicleHeadLightColor(car, r, g, b)
			end
		end, 1000, 60)
	end, 13000, 1)
	setTimer(setGameSpeed, 73000, 1, 1)
	setTimer(setWeather, 73000, 1, 1)
end

addEvent( "ActionDiscoSpeed", true )
addEventHandler( "ActionDiscoSpeed", getRootElement(), DoActionDiscoSpeed)