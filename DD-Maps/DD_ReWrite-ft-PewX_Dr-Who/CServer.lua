CServer = {}
 
function CServer:constructor()

		self.Daleks = {}

        self.MarkerPositions = {
                {["X"]=3228.8000488281,["Y"]=362.29998779297, ["Z"]=24.60000038147},
                {["X"]=3207.5,["Y"]=337.20001220703, ["Z"]=24.60000038147},
               
                {["X"]=3205.1000976563,["Y"]=283, ["Z"]=24.60000038147},
                {["X"]=3206.1000976563,["Y"]=258, ["Z"]=24.60000038147},
               
                {["X"]=3305.6999511719,["Y"]=251.60000610352, ["Z"]=24.60000038147},
                {["X"]=3317.8000488281,["Y"]=250.80000305176, ["Z"]=24.60000038147},
               
                {["X"]=3325.6000976563,["Y"]=182.10000610352, ["Z"]=24.60000038147},
                {["X"]=3310,["Y"]=166.5, ["Z"]=24.60000038147},
               
                {["X"]=3308.3000488281,["Y"]=338.89999389648, ["Z"]=24.60000038147},
                {["X"]=3325.1000976563,["Y"]=365, ["Z"]=24.60000038147},
               
                {["X"]=3326.8999023438,["Y"]=430, ["Z"]=24.60000038147},
                {["X"]=3323.8000488281,["Y"]=458.79998779297, ["Z"]=24.60000038147},
               
                {["X"]=3380.5,["Y"]=433, ["Z"]=24.60000038147},
                {["X"]=3396.1000976563,["Y"]=454, ["Z"]=24.60000038147},
               
                {["X"]=3404.3999023438,["Y"]=367, ["Z"]=24.60000038147},
                {["X"]=3389.5,["Y"]=345, ["Z"]=24.60000038147},
               
                {["X"]=3386.6000976563,["Y"]=253, ["Z"]=24.60000038147},
                {["X"]=3403,["Y"]=273, ["Z"]=24.60000038147},
               
                {["X"]=3402,["Y"]=187, ["Z"]=24.60000038147},
                {["X"]=3391.1000976563,["Y"]=163, ["Z"]=24.60000038147},
               
                {["X"]=3506,["Y"]=257, ["Z"]=24.60000038147},
                {["X"]=3487.1000976563,["Y"]=281, ["Z"]=24.60000038147},
               
                {["X"]=3486.1000976563,["Y"]=340, ["Z"]=24.60000038147},
                {["X"]=3506.1000976563,["Y"]=358, ["Z"]=24.60000038147}
        }
        
		self.Tardis = createObject(10377, 3355.7998046875, 309.099609375, 12.300000190735)
		setObjectScale(self.Tardis, 18)
		setElementCollisionsEnabled(self.Tardis, false)
		
		self.Marker = createMarker(0,0,0,"corona", 4, 255, 255, 255, 255, getRootElement())
        addEventHandler("onMarkerHit", self.Marker,
                function(hitElement, matchingDim)
					if ( not (getElementData(source, "AlreadyHit"))) then
						if (getElementType(hitElement) == "vehicle") then
							setElementData(source, "AlreadyHit", true)
							local thePlayer = getVehicleOccupant(hitElement)
							setElementAlpha(self.Marker, 0)
							destroyElement(self.Blip)
							
							local Action = math.random(1,100)
							if (Action < 33) then
								-- Tardis materalisiert
								outputChatBox(getPlayerName(thePlayer).." activated the tardis!", getRootElement(), 125,0,0, true)
								triggerClientEvent(getRootElement(), "playClientSound", getRootElement(), "tardis")

								local starttick = getTickCount()
								self.TardisTimer = setTimer(function()
									local x = interpolateBetween(160,0,0,255,0,0, ((getTickCount()-starttick)%2000)/2000, "CosineCurve")
									setElementAlpha(self.Tardis, x)
								end, 50, 240)
								
								setTimer(
									function() 
										if (math.random(1,4) == 4) then
											switchPlayersRandom()
										end
										if (math.random(1,2) == 2) then
											giveRandomCar(getElementDimension(self.Tardis))
										end
									end
								, 4000, 4)
								
								local x,y,z = getElementPosition(self.Tardis)
								moveObject(self.Tardis, 14000, x,y,z, 0, 0, 720)
								setTimer(
									function()
										if (self.TardisTimer and isTimer(self.TardisTimer)) then
											killTimer(self.TardisTimer)
										end
										setElementAlpha(self.Tardis, 255) 
										self:changeMarkerPosition() 
										
										local tx,ty,tz = getElementPosition(self.Tardis)
										for k,v in ipairs(getElementsByType("vehicle")) do
											if (getElementDimension(v) == getElementDimension(self.Tardis)) then
												if (getVehicleOccupant(v) and getElementType(getVehicleOccupant(v)) == "player") then
													local px,py,pz = getElementPosition(v)
													if (getDistanceBetweenPoints3D(px,py,pz, tx, ty, tz)> 300) then
														setElementHealth(v, 0)
													end
												end
											end
										end
									end
								, 14000,1 )
							else
								if (Action < 50) then
									-- Doctor
									triggerClientEvent(getRootElement(), "playClientSound", getRootElement(), "geronimo")
									if (not (getVehicleOccupants(getPedOccupiedVehicle(thePlayer))[1])) then
										warpPedIntoVehicle(createPed(52,0,0,0), getPedOccupiedVehicle(thePlayer), 1)
									end
									triggerClientEvent(thePlayer, "StartDoctorEvent", getRootElement())
									outputChatBox("The Doctor joined "..getPlayerName(thePlayer).."'s vehicle! He can fly!", getRootElement(), 125,0,0, true)
									self:changeMarkerPosition()
								else
									if (Action < 66) then
										-- Daleks
										
										outputChatBox(getPlayerName(thePlayer).." found Daleks! Care about them!", getRootElement(), 125,0,0, true)
										
										for k,v in ipairs(getElementsByType("player")) do
											local x,y,z = getElementPosition(v)
											local veh = createVehicle(520, x,y,z+5,0,0,math.random(1,359),"")
											setElementFrozen(veh, true)
											table.insert(self.Daleks, veh)
										end
										
										for k,v in ipairs(self.MarkerPositions) do
											local veh = createVehicle(520, v["X"],v["Y"],v["Z"]+5,0,0,math.random(1,359),"")
											setElementFrozen(veh, true)
											table.insert(self.Daleks, veh)
										end
										
										triggerClientEvent(getRootElement(), "playClientSound", getRootElement(), "dalek")
										
										setTimer(
											function() 
												for k,v in ipairs(self.Daleks) do
													local x,y,z = getElementPosition(v)
													createExplosion(x,y,z-5, 2, nil) 
													destroyElement(v) 
												end
												self.Daleks = {}
												self:changeMarkerPosition()
											end
										, 2000, 1)
									else
										if (Action < 85) then
										-- Sonic Screwdriver
										outputChatBox(getPlayerName(thePlayer).." used a sonic screwdriver!", getRootElement(), 125,0,0, true)
										fixVehicle(getPedOccupiedVehicle(thePlayer))
										triggerClientEvent(getRootElement(), "playClientSound", getRootElement(), "sonic")
										self:changeMarkerPosition()
										else
											if (Action < 95) then
												--Silence
												outputChatBox(getPlayerName(thePlayer).." found the silence! Do not lose focus!", getRootElement(), 125,0,0, true)
												triggerClientEvent(getRootElement(), "playClientSound", getRootElement(), "silence")
												local x,y,z = getElementPosition(thePlayer)
												self.Silence = createPed(53, x+1,y,z+0.2)
												setElementCollisionsEnabled(self.Silence, false)
												setElementFrozen(self.Silence, true)
												triggerClientEvent(getRootElement(), "StartSilenceEvent", getRootElement(), self.Silence)
												setTimer(function() destroyElement(self.Silence) self:changeMarkerPosition() end, 20000, 1)
											else
												--Angel
												outputChatBox(getPlayerName(thePlayer).." found an angry angel! Do not blink! Don't loose focus!", getRootElement(), 125,0,0)
												triggerClientEvent(getRootElement(), "playClientSound", getRootElement(), "angels")
												
												triggerClientEvent(getRootElement(), "StartAngelEvent", getRootElement(), thePlayer)
												
												setTimer(function() triggerClientEvent(getRootElement(), "playClientSound", getRootElement(), "blink") end, 3000, 1)
												setTimer(function() self:changeMarkerPosition() end, 50000, 1)
											end
										end
									end
								end
							end
						end
					end
                end
        )
        self:changeMarkerPosition()
end
 
function CServer:destructor()
end
 
function CServer:changeMarkerPosition()
        local newPosition = self.MarkerPositions[math.random(1, #self.MarkerPositions)]
        setElementPosition(self.Marker, newPosition["X"], newPosition["Y"], newPosition["Z"])
        setElementData(self.Marker, "AlreadyHit", false)
		setElementAlpha(self.Marker, 255)
		self.Blip = createBlipAttachedTo(self.Marker)
end
 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function() Server = new(CServer) end)
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), function() delete(Server) end)

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
                                outputChatBox("|Map| #55aaffYou are now at the position from " .. getPlayerName(targetPlayer), player, 255, 255, 255, true)
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