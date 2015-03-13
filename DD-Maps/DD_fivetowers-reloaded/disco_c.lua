function PlayDisco1()
    _G["song"] = playSound( "http://www.vio-race.de/servermusic/mapmusic/fivetowers-reloaded_disco1.mp3", false )
	setTimer(
	function()
	setTimer(
        function()
			r = math.random(0, 255)
			g = math.random(0, 255)
			b = math.random(0, 255)
			r1 = math.random(0, 255)
			g1 = math.random(0, 255)
			b1 = math.random(0, 255)
			setSkyGradient(r, g, b, r1, g1, b1)
			setWaterColor(r, g, b)
			for i, car in ipairs(getElementsByType("vehicle")) do
				setVehicleColor (car, r, g, b, r1, g1, b1, r, g, b, r1, g1, b1)
				setVehicleOverrideLights (car, 2)
				setVehicleHeadLightColor(car, r, g, b)
			end
        end
    , 500, 188)
	end
	, 26000, 1, 1)
	setGameSpeed(0.5)
	setWeather(19)
	setTimer(setGameSpeed, 26000, 1, 1)
	setTimer(setWeather, 26000, 1, 0)
end

function PlayDisco2()
    _G["song"] = playSound( "http://www.vio-race.de/servermusic/mapmusic/fivetowers-reloaded_disco2.mp3", false )
	setTimer(
	function()
	setTimer(
        function()
			r = math.random(0, 255)
			g = math.random(0, 255)
			b = math.random(0, 255)
			r1 = math.random(0, 255)
			g1 = math.random(0, 255)
			b1 = math.random(0, 255)
			setSkyGradient(r, g, b, r1, g1, b1)
			setWaterColor(r, g, b)
			for i, car in ipairs(getElementsByType("vehicle")) do
				setVehicleColor (car, r, g, b, r1, g1, b1, r, g, b, r1, g1, b1)
				setVehicleOverrideLights (car, 2)
				setVehicleHeadLightColor(car, r, g, b)
			end
        end
    , 500, 56)
	end
	, 58000, 1, 1)
	setGameSpeed(0.5)
	setWeather(19)
	setTimer(setGameSpeed, 58000, 1, 1)
	setTimer(setWeather, 58000, 1, 0)
end

function PlayDisco3()
    _G["song"] = playSound( "http://www.vio-race.de/servermusic/mapmusic/fivetowers-reloaded_disco3.mp3", false )
	setTimer(
	function()
	setTimer(
        function()
			r = math.random(0, 255)
			g = math.random(0, 255)
			b = math.random(0, 255)
			r1 = math.random(0, 255)
			g1 = math.random(0, 255)
			b1 = math.random(0, 255)
			setSkyGradient(r, g, b, r1, g1, b1)
			setWaterColor(r, g, b)
			for i, car in ipairs(getElementsByType("vehicle")) do
				setVehicleColor (car, r, g, b, r1, g1, b1, r, g, b, r1, g1, b1)
				setVehicleOverrideLights (car, 2)
				setVehicleHeadLightColor(car, r, g, b)
			end
        end
    , 500, 90)
	end
	, 61500, 1, 1)
	setGameSpeed(0.5)
	setWeather(19)
	setTimer(setGameSpeed, 61500, 1, 1)
	setTimer(setWeather, 61500, 1, 0)
end

function PlayDisco4()
    _G["song"] = playSound( "http://www.vio-race.de/servermusic/mapmusic/fivetowers-reloaded_disco4.mp3", false )
	setTimer(
	function()
	setTimer(
        function()
			r = math.random(0, 255)
			g = math.random(0, 255)
			b = math.random(0, 255)
			r1 = math.random(0, 255)
			g1 = math.random(0, 255)
			b1 = math.random(0, 255)
			setSkyGradient(r, g, b, r1, g1, b1)
			setWaterColor(r, g, b)
			for i, car in ipairs(getElementsByType("vehicle")) do
				setVehicleColor (car, r, g, b, r1, g1, b1, r, g, b, r1, g1, b1)
				setVehicleOverrideLights (car, 2)
				setVehicleHeadLightColor(car, r, g, b)
			end
        end
    , 500, 188)
	end
	, 61000, 1, 1)
	setGameSpeed(1.5)
	setWeather(19)
	setTimer(setGameSpeed, 61000, 1, 1)
	setTimer(setWeather, 61000, 1, 0)
end

addEvent( "PlayDiscoMusic1", true )
addEventHandler( "PlayDiscoMusic1", getRootElement(), PlayDisco1)

addEvent( "PlayDiscoMusic2", true )
addEventHandler( "PlayDiscoMusic2", getRootElement(), PlayDisco2)

addEvent( "PlayDiscoMusic3", true )
addEventHandler( "PlayDiscoMusic3", getRootElement(), PlayDisco3)

addEvent( "PlayDiscoMusic4", true )
addEventHandler( "PlayDiscoMusic4", getRootElement(), PlayDisco4)