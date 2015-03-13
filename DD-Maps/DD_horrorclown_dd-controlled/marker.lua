-----------------------------------
-- (c) 2013 by [VioR]HorrorClown --
-----------------------------------
outputChatBox("- - -", getRootElement(), 0, 100, 255, true)
outputChatBox("Map and Script by HorrorClown. Have Fun ;D", getRootElement(), 255, 100, 0, true)
outputChatBox("- - -", getRootElement(), 0, 100, 255, true)

vehicles = {415,542,589,432,447,425,573,444,556,557,406,423,448,574,583,588,496,504,402,541,415,542,589,480,507,562,587,533,565,474,434,494,502,503,579,545,411,559,400,500,603,489,505,534,495,567,535,458,561,409,560,506,549,420,583,451,558,555,477,509,581,481,462,521,463,510,522,561,448,468,586,416,523,427,490,528,407,544,596,598,599,597,601,422,482,483,588,444,556,557,523,582,470,543,574,525,552,478,554,433,431,524,437,578,573,455,568,424,457,486,406,530,571,572,471,531,605,476,497,520,487,488,469}  
local VehMarker
local MarkerBlip
local MarkerPosX
local MarkerPosY
local wait = false
local RandomAction
local Markers = 0

---
local SaveTower = createObject(4585, 126.8984375, 364, -99.599998474121)
local level = -5
local WaterTimer
---

function CreateMarker()
	Markers = Markers + 1
	local RandomLayer = math.random(1, 6)
	
	if wait == false then
		RandomAction = math.random(1, 6)
	else
		RandomAction = 10
	end

	if RandomLayer == 1 then -- Layer 1 = towerlan(2); Airportland (23); towerlan (3)
		MarkerPosX = math.random(12, 242)
		MarkerPosY = math.random(256, 287)
	elseif RandomLayer == 2 then -- Layer 2 = Airportland (19); towerlan(6); Airportland(3)
		MarkerPosX = math.random(12, 242)
		MarkerPosY = math.random(345, 383)
	elseif RandomLayer == 3 then -- Layer 3 = towerlan(1); Airportland(21); towerlan(4)
		MarkerPosX = math.random(12, 242)
		MarkerPosY = math.random(440, 472)
	elseif RandomLayer == 4 then -- Layer 4 = Airportland (22)
		MarkerPosX = math.random(206, 244)
		MarkerPosY = math.random(296, 432)
	elseif RandomLayer == 5 then -- Layer 5 = Airportland (5)
		MarkerPosX = math.random(108, 146)
		MarkerPosY = math.random(296, 432)
	elseif RandomLayer == 6 then -- Layer 6 = Airportland (5)
		MarkerPosX = math.random(12, 47)
		MarkerPosY = math.random(296, 432)
	end
	
	if RandomAction == 1 then
		VehMarker = createMarker(MarkerPosX, MarkerPosY, 1, "checkpoint", 2, 0, 150, 255)
		MarkerBlip = createBlip (MarkerPosX, MarkerPosY,  1, 0, 2, 0, 150, 255)
		addEventHandler( "onMarkerHit", VehMarker, setRandomAction)
		addEventHandler( "onMarkerHit", VehMarker, setNewMarker)
	else
		VehMarker = createMarker(MarkerPosX, MarkerPosY, 1, "checkpoint", 2, 255, 100, 0)
		MarkerBlip = createBlip (MarkerPosX, MarkerPosY, 1, 0, 2, 255, 100, 0)
		addEventHandler( "onMarkerHit", VehMarker, setNewMarker)
		addEventHandler( "onMarkerHit", VehMarker, setRandomVehicle)
	end
end

function setNewMarker(player)
	if getElementType(player)=="player" then
		destroyElement(VehMarker)
		destroyElement(MarkerBlip)
		CreateMarker()
	end
end

function setRandomVehicle(thePlayer)
	if getElementType ( thePlayer ) == "player" then
		local veh = getPedOccupiedVehicle (thePlayer)
		num = tonumber(vehicles[math.random( #vehicles )])
		setElementModel(veh, num)
		fixVehicle(veh)
		
		local VehicleName = getVehicleName(veh)
		local PlayerName = getPlayerName (thePlayer)
		if (num == 432) or (num == 447) or (num == 425) or (num == 520) or (num == 476) then
			outputChatBox("|Map| Warning: " .. PlayerName .. " #FF0000has gotten a " .. VehicleName .. "!", getRootElement(), 255, 0, 0, true)
		end
	end
end

function setRandomAction(player)
	if getElementType(player) == "player" then
		
		local PlayerName = getPlayerName(player)
		outputChatBox("#616161[Map]#00DDffAction Marker activated by " .. PlayerName, getRootElement(), 0, 150, 255, true)
		local Action = math.random(1,6)
		outputDebugString(PlayerName .. " activated Action: " .. Action)
		if Action == 1 then
			WaterTimer = setTimer(setNewLevel, 50, 0)
			waitAction(10000)
		elseif Action == 2 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
			triggerClientEvent ( player, "ActionDarkness", player )
			triggerClientEvent ( player, "ActionSkidmarks", player )
			triggerClientEvent ( player, "ActionNitro", player )
			end
		elseif Action == 3 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
			triggerClientEvent ( player, "ActionDiscoSlow", player )
			waitAction(94000)
			end
		elseif Action == 4 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
			triggerClientEvent ( player, "ActionCartoon", player )
			end
		elseif Action == 5 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
			triggerClientEvent ( player, "ActionDiscoSpeed", player )
			waitAction(73000)
			end
		elseif Action == 6 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
			triggerClientEvent ( player, "ActionBrightness", player )
			end
		end
	end
end

function showMarkers()
	outputChatBox("- - -", getRootElement(), 0, 100, 255)
	outputChatBox("The end of DD Controlled. Total " .. Markers .. " markers were created!", getRootElement(), 255, 100, 0)
	outputChatBox("- - -", getRootElement(), 0, 100, 255)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), CreateMarker)
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), showMarkers)

function waitAction(duration)
	wait = true
	setTimer(function()
		wait = false
	end, duration, 1)
end

---------------------------------------------------------------------------------------------------------------
------------------------------------------Actions--------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function setNewLevel()
	level = level + 0.01
	level = math.round(level, 3)
	setWeather(16)
	setWaveHeight(2)

	if level > 0 then
		setWaterLevel(level)
	end
	if level == 0 then
		outputChatBox("#616161[Map]#ff0000You can only survive on the Tower!!", getRootElement(), 255, 0,0, true)
		moveObject(SaveTower, 60000, 126.8984375, 364, -89.599998474121)
	elseif level == 10 then
		moveObject(SaveTower, 10000, 126.8984375, 364, -99.599998474121)
		killTimer ( WaterTimer )
		setWaterLevel(0)
		setWaveHeight(0)
		setWeather(0)
		level = -5
	end
end