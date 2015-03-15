local markerSpawns = {
	{["X"]=3645.7265625,["Y"]=-4512.7861328125,["Z"]=7.7726535797119},
	{["X"]=3651.283203125,["Y"]=-4482.5439453125,["Z"]=7.772572517395},
	{["X"]=3677.86328125,["Y"]=-4473.716796875,["Z"]=7.8837490081787},
	{["X"]=3696.701171875,["Y"]=-4486.2646484375,["Z"]=7.7733302116394},
	{["X"]=3702.7666015625,["Y"]=-4509.66796875,["Z"]=7.7009358406067},
	{["X"]=3727.77734375,["Y"]=-4532.599609375,["Z"]=7.6866540908813},
	{["X"]=3776.5244140625,["Y"]=-4542.9462890625,["Z"]=7.6860256195068},
	{["X"]=3797.1669921875,["Y"]=-4530.568359375,["Z"]=7.6868500709534},
	{["X"]=3808.4091796875,["Y"]=-4517.748046875,["Z"]=7.6868996620178},
	{["X"]=3808.888671875,["Y"]=-4503.564453125,["Z"]=7.6875562667847},
	{["X"]=3794.609375,["Y"]=-4507.9326171875,["Z"]=7.6868305206299},
	{["X"]=3776.5693359375,["Y"]=-4518.6669921875,["Z"]=7.6869506835938},
	{["X"]=3760.9765625,["Y"]=-4526.5126953125,["Z"]=7.6871790885925},
	{["X"]=3743.7177734375,["Y"]=-4550.291015625,["Z"]=7.6875748634338},
	{["X"]=3709.6904296875,["Y"]=-4562.5859375,["Z"]=7.771625995636},
	{["X"]=3650.5859375,["Y"]=-4579.4833984375,["Z"]=7.7687225341797},
	{["X"]=3644.779296875,["Y"]=-4556.2236328125,["Z"]=7.7716608047485},
	{["X"]=3654.984375,["Y"]=-4528.955078125,["Z"]=7.7686042785645},
	{["X"]=3671.005859375,["Y"]=-4560.2119140625,["Z"]=7.7690420150757},
	{["X"]=3745.8837890625,["Y"]=-4570.455078125,["Z"]=7.686182975769},
	{["X"]=3757.8486328125,["Y"]=-4501.056640625,["Z"]=7.687442779541},
	{["X"]=3755.2099609375,["Y"]=-4469.5048828125,["Z"]=7.6865119934082},
	{["X"]=3733.69140625,["Y"]=-4447.0400390625,["Z"]=7.6862659454346},
	{["X"]=3703.87890625,["Y"]=-4456.7705078125,["Z"]=7.7700991630554},
	{["X"]=3720.1201171875,["Y"]=-4491.0537109375,["Z"]=7.6883277893066},
	{["X"]=3773.9443359375,["Y"]=-4486.7548828125,["Z"]=7.6876525878906},
	{["X"]=3805.1142578125,["Y"]=-4473.05078125,["Z"]=7.6870064735413},
	{["X"]=3817.7685546875,["Y"]=-4459.59375,["Z"]=7.6876811981201},
	{["X"]=3791.439453125,["Y"]=-4440.1767578125,["Z"]=7.685800075531},
	{["X"]=3793.5107421875,["Y"]=-4460.2724609375,["Z"]=7.6872401237488},
	{["X"]=3735.1484375,["Y"]=-4510.1279296875,["Z"]=7.686897277832},
	{["X"]=3725.1552734375,["Y"]=-4470.724609375,["Z"]=7.6860222816467}
}

local Marker = false
local Blip = false

function createNewMarker()

	if (Marker and isElement(Marker)) then
		destroyElement(Marker)
	end
	
	if (Blip and isElement(Blip)) then
		destroyElement(Blip)
	end
	
	local spawn = markerSpawns[math.random(1, #markerSpawns)]
	Marker = createMarker(spawn["X"], spawn["Y"], spawn["Z"]-1, "cylinder", 4, 255,255,255,255,getRootElement())
	Blip = createBlip(spawn["X"], spawn["Y"], spawn["Z"], 0, 2, 255,0,0,255, 0, 99999, getRootElement())
	addEventHandler("onMarkerHit", Marker, markerHit)
end

function markerHit(hitElement, matching)
	if (getElementType(hitElement) == "vehicle") then
		destroyElement(Marker)
		destroyElement(Blip)
		setTimer(createNewMarker, markerAction(getVehicleOccupant(hitElement, 0)), 1)
	end
end

function markerAction(thePlayer)
	local Action = math.random(1,10)
	
	if (Action > 9) then
		setGameSpeed(getGameSpeed()*1.5)
		triggerClientEvent("onSonic", getRootElement())
		return 15000
	else
		if (Action > 8) then
			triggerClientEvent("onSad", getRootElement(), thePlayer)
			fixVehicle(getPedOccupiedVehicle(thePlayer))
			return 100
		else
			if (Action > 6) then
				triggerClientEvent("onAirhorn", getRootElement())
				letThemJump()
				return 1000
			else
				if (Action > 4) then
					triggerClientEvent("onIlluminati", getRootElement())
					setTimer(switchPlayersRandom, 250, 28)
					return 10000
				else
					if (Action > 1) then
						triggerClientEvent("onWeed", getRootElement())
						for i=1,5,1 do
							giveRandomCar(getElementDimension(thePlayer))
						end
						
						return 100
					else
						--Darude Sandstorm lel
						triggerClientEvent("onDarude", getRootElement())
						setWeather(19)
						setGameSpeed(getGameSpeed()*2)
						
						setTimer(
							function()
								setWeather(0)
								setGameSpeed(getGameSpeed()/2)
							end
						, 24000, 1)
						
						return 25000
					end
				end
			end
			
		end
	end
	
	return 100
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
	function()
		createNewMarker()
	end
)

function switchPlayersRandom()
       local cacheTable = {}
       for i, player in ipairs(getElementsByType("player")) do
                if getElementData(player, "state") == "alive" then
                        local pV = getPedOccupiedVehicle(player)
                        if pV then
                                local vID = getElementModel(pV)
                                local vP = {getElementPosition(pV)}
                                local vR = {getElementRotation(pV)}
                                local vV = {getElementVelocity(pV)}
                                local vTV = {getVehicleTurnVelocity(pV)}
                                local ID = #cacheTable + 1
                                cacheTable[ID] = {}
                                cacheTable[ID].player = player
                                cacheTable[ID].vID = vID
                                cacheTable[ID].pos = vP
                                cacheTable[ID].rot = vR
                                cacheTable[ID].velocity = vV
                                cacheTable[ID].turnVelocity = vTV
                                cacheTable[ID].done = false
                        end
                end
        end
        for i, player in ipairs(getElementsByType("player")) do
                if getElementData(player, "state") == "alive" then
                        local pV = getPedOccupiedVehicle(player)
                        if pV then
                                local rnd = math.random(1, #cacheTable)
                                while cacheTable[rnd].done do
                                        rnd = math.random(1, #cacheTable)
                                end
                               
                                local targetPlayer = cacheTable[rnd].player
                                local vehicleID = cacheTable[rnd].vID
                                local x, y, z = unpack(cacheTable[rnd].pos)
                                local xr, yr, zr = unpack(cacheTable[rnd].rot)
                                local xv, yv, zv = unpack(cacheTable[rnd].velocity)
                                local xtv, ytv, ztv = unpack(cacheTable[rnd].turnVelocity)
                               
                                setElementModel(pV, vehicleID)
                                setElementPosition(pV, x, y, z)
                                setElementRotation(pV, xr, yr, zr)
                                setElementVelocity(pV, xv, yv, zv)
                                setVehicleTurnVelocity(pV, xtv, ytv, ztv)
                                cacheTable[rnd].done = true
                        end
                end
        end
end

vehicleIDS = { 602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585,
405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 488, 511, 497, 548, 563, 512, 476, 593, 447, 425, 519, 460,
417, 469, 487, 513, 581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 463, 586, 485, 552, 431, 
438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 432, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 
423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 
567, 535, 576, 412, 402, 542, 603, 475, 568, 557, 424, 471, 504, 495, 457, 483, 508, 571, 500, 
444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458}

function giveRandomCar(dim)
	local cars = {}
	for k,v in ipairs(getElementsByType("vehicle")) do
		if (getElementDimension(v) == dim) then
			if (getVehicleOccupant(v) and getElementType(getVehicleOccupant(v)) == "player") then
				table.insert(cars, v)
			end
		end
	end
	
	setElementModel(cars[math.random(1, #cars)], vehicleIDS[math.random(1, #vehicleIDS)])
end

function letThemJump()
	for k,v in ipairs(getElementsByType("vehicle")) do
		local x,y,z = getElementVelocity(v)
		setElementVelocity(v, x, y, z+0.6)
	end
end