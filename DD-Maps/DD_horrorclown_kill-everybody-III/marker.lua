vehicles = {496,504,402,541,415,542,589,480,507,562,587,533,565,474,434,494,502,503,579,545,411,559,400,500,603,489,505,534,495,567,535,458,561,409,560,506,549,420,583,451,558,555,477,509,581,481,462,521,463,510,522,561,448,468,586,416,523,427,490,528,407,544,596,598,599,597,601,422,482,483,588,444,556,557,523,582,470,543,574,525,552,478,554,433,431,524,437,573,455,568,424,457,486,406,530,571,572,471,531,564,605}  
outputChatBox("- - -", getRootElement(), 0, 100, 255)
outputChatBox("Map and Script by HorrorClown", getRootElement(), 0, 100, 255, true)
outputChatBox("- - -", getRootElement(), 0, 100, 255)


local VehMarker
local BlipMarker
local destroyMarker_Timer
local MarkerPosX,MarkerPosY,MarkerPosZ

function CreateMarker()
if isTimer ( destroyMarker_Timer ) then killTimer ( destroyMarker_Timer ) end
local RandomMarker = math.random(1, 7)
if RandomMarker == 1 then
	MarkerPosX,MarkerPosY,MarkerPosZ = 3586.3000488281,-1678.0999755859,17.39999961853
elseif RandomMarker == 2 then
	MarkerPosX,MarkerPosY,MarkerPosZ = 3586.3000488281,-1678.0999755859,30.5
elseif RandomMarker == 3 then
	MarkerPosX,MarkerPosY,MarkerPosZ = 3586.3000488281,-1678.0999755859,3.5
elseif RandomMarker == 4 then
	MarkerPosX,MarkerPosY,MarkerPosZ = 3480.1999511719,-1678.0999755859,3.5
elseif RandomMarker == 5 then
	MarkerPosX,MarkerPosY,MarkerPosZ = 3692.3999023438,-1678.0999755859,3.5
elseif RandomMarker == 6 then
	MarkerPosX,MarkerPosY,MarkerPosZ = 3586.2646484375,-1572,3.5
elseif RandomMarker == 7 then
	MarkerPosX,MarkerPosY,MarkerPosZ = 3586.2646484375,-1784.1999511719,3.5
end

VehMarker = createMarker(MarkerPosX,MarkerPosY,MarkerPosZ,"arrow",3,0,35,255, 0)
BlipMarker = createBlip(MarkerPosX,MarkerPosY, 1, 0)
addEventHandler("onMarkerHit", VehMarker, setNewMarker)
addEventHandler("onMarkerHit", VehMarker, setRandomVehicle)
destroyMarker_Timer = setTimer(destroyMarker, 60000, 1)
end

function destroyMarker()
	destroyElement(VehMarker)
	destroyElement(BlipMarker)
	CreateMarker()
end

function setRandomVehicle(thePlayer)
	if getElementType ( thePlayer ) == "player" then
		local veh = getPedOccupiedVehicle (thePlayer)
		num = tonumber(vehicles[math.random( #vehicles )])
		setElementModel(veh, num)
		fixVehicle(veh)
	end
end

function setNewMarker(player)
	if getElementType(player) == "player" then
		destroyElement(VehMarker)
		destroyElement(BlipMarker)
		CreateMarker()
	end
end

addEventHandler("onResourceStart", getRootElement(), CreateMarker)
