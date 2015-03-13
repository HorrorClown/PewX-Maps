-----------------------------------
-- (c) 2013 by [VioR]HorrorClown --
------ and [VioR]ScaredChaos ------
-----------------------------------

vehicles = {400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,418,419,420,421,422,423,424,425,426,427,428,429,431,432,433,434,436,437,438,439,440,442,443,444,445,447,448,451,455,456,457,458,459,461,462,463,466,467,468,470,471,474,475,476,477,478,479,480,482,483,485,486,487,489,490,491,492,494,495,496,498,499,500,502,503,504,505,506,507,508,514,515,516,517,518,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,540,541,542,543,544,545,546,547,549,550,551,552,554,555,556,557,558,559,560,561,562,565,566,567,568,571,572,573,574,757,576,578,579,580,581,582,583,585,586,587,588,589,596,597,598,599,600,601,602,603,604,605,609}  
local TowerMarker
local MarkerPosX
local MarkerPosY

function CreateMarker()
	local RandomTower = math.random(1, 5)
	
	if RandomTower== 1 then --towerlan2 (3)
		MarkerPosX = math.random(4060, 4095)
		MarkerPosY = math.random(270, 310)
	elseif RandomTower== 2 then
		MarkerPosX = math.random(4060, 4095)
		MarkerPosY = math.random(350, 392)
	elseif RandomTower== 3 then
		MarkerPosX = math.random(4060, 4095)
		MarkerPosY = math.random(190, 230)
	elseif RandomTower== 4 then
		MarkerPosX = math.random(3985, 4021)
		MarkerPosY = math.random(270, 310)
	elseif RandomTower== 5 then
		MarkerPosX = math.random(4132, 4166)
		MarkerPosY = math.random(270, 310)
	end

	TowerMarker = createMarker(MarkerPosX, MarkerPosY, 100, "checkpoint", 2, 255, 0, 0)
	addEventHandler( "onMarkerHit", TowerMarker, setNewMarker)
	addEventHandler( "onMarkerHit", TowerMarker, setRandomVehicle)
end

function setNewMarker(player)
	if getElementType(player)=="vehicle" then
		destroyElement(TowerMarker)
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
		elseif (num == 573) or (num == 444) or (num == 556) or (num == 557) or (num == 406) then
			outputChatBox("|Map| Warning: " .. PlayerName .. " #FF6600has gotten a " .. VehicleName .. "!", getRootElement(), 255, 100, 0, true)
		elseif (num == 423) or (num == 448) or (num == 574) or (num == 583) or (num == 588) then
			outputChatBox("|Map| " .. PlayerName .. " #00FF00has gotten a " .. VehicleName .. " :D", getRootElement(), 0, 255, 0, true)
		end
	end
end

function initialising()
	outputChatBox("Five Towers reloaded started. Script by [VioR]HorrorClown", getRootElement(), 0, 100, 255, true)
	CreateMarker()
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), initialising)