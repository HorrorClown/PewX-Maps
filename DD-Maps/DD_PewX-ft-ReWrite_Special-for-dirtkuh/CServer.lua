CServer = {}
 
function CServer:constructor()
        self.Cows = {}
 
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
        self.Marker = createMarker(0,0,0,"corona", 4, 255, 255, 255, 255, getRootElement())
        setElementAlpha(self.Marker, 0)
        addEventHandler("onMarkerHit", self.Marker,
                function(hitElement, matchingDim)
                        if ( not (getElementData(source, "AlreadyHit"))) then
                                if (getElementType(hitElement) == "vehicle") then
                                        setElementData(source, "AlreadyHit", true)
                                        local thePlayer = getVehicleOccupant(hitElement)
                                        if (getObjectScale(self.Cows[getPlayerName(thePlayer)]) < 1.45) then
                                                setObjectScale(self.Cows[getPlayerName(thePlayer)], getObjectScale(self.Cows[getPlayerName(thePlayer)])+0.1)
                                        end
                                        if (getVehicleHandling(hitElement)["mass"] < 40000) then
                                                setVehicleHandling(hitElement, "mass", getVehicleHandling(hitElement)["mass"]*1.1)
                                        end
                                        local x,y,z = getElementPosition(self.Marker)
                                        triggerClientEvent(getRootElement(), "playClientMoo3D", getRootElement(), hitElement)
                                        self:changeMarkerPosition()
                                end
                        end
                end
        )
        self.Grass = createObject(3409,0,0,-1,0,0,0)
        setElementCollisionsEnabled(self.Grass, false)
        self:changeMarkerPosition()
 
        self.Blip = createBlipAttachedTo(self.Marker)
       
        addEventHandler("onVehicleEnter", getRootElement(),
                function(thePlayer, seat)
                        if (not self.Cows[getPlayerName(thePlayer)]) then
                                local x,y,z = getElementPosition(source)
                                local rx,ry,rz = getElementRotation(source)
                                self.Cows[getPlayerName(thePlayer)] = createObject(16442, x,y,z+2, 0, 0, 0)
                                setElementCollisionsEnabled(self.Cows[getPlayerName(thePlayer)], false)
                                setElementAlpha(source, 0)
                                setElementAlpha(getPedOccupiedVehicle(thePlayer), 0)
                                setElementAlpha(thePlayer,0)
                                attachElements(self.Cows[getPlayerName(thePlayer)], source, 0,0,1, 0, 0, 90)
                                setObjectScale(self.Cows[getPlayerName(thePlayer)],0.7)
                        end
                end
        )
       
        addEventHandler("onVehicleExit", getRootElement(),
                function(thePlayer, seat)
                        if (self.Cows[getPlayerName(thePlayer)]) then  
                                destroyElement(self.Cows[getPlayerName(thePlayer)])
                                self.Cows[getPlayerName(thePlayer)] = nil
                                setElementAlpha(thePlayer,255)
                        end
                end
        )
       
        addEvent("onRaceStateChanging")
        addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
                if newState == "Running" then
                        for k,v in ipairs(getElementsByType("vehicle")) do setElementAlpha(v,0) setVehicleOverrideLights ( v, 1 ) end
                        for k,v in ipairs(getElementsByType("player")) do setElementAlpha(v,0) end
                end
        end)
       
        self.VehTimer = setTimer(function() for k,v in ipairs(getElementsByType("vehicle")) do setElementAlpha(v,0) setVehicleOverrideLights ( v, 1 ) end end, 2500, 0)
        self.PlayerTimer = setTimer(function() for k,v in ipairs(getElementsByType("player")) do setElementAlpha(v,0) end end, 2500, 0)
       
        self.CowTimer = setTimer(
                function()
                        for k,v in pairs(self.Cows) do
                                if ( not getPlayerFromName(k)) or (getElementData(getPlayerFromName(k), "state") == "dead") then
                                        destroyElement(self.Cows[k])
                                        self.Cows[k] = nil
                                end
                        end
                end
        , 2500, 0)
end
 
function CServer:destructor()
        if (isTimer(self.Timer)) then
                killTimer(self.Timer)
        end
end
 
function CServer:changeMarkerPosition()
        local newPosition = self.MarkerPositions[math.random(1, #self.MarkerPositions)]
        setElementPosition(self.Marker, newPosition["X"], newPosition["Y"], newPosition["Z"])
        setElementPosition(self.Grass, newPosition["X"], newPosition["Y"], newPosition["Z"]-2)
        setElementData(self.Marker, "AlreadyHit", false)
end
 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function() Server = new(CServer) end)
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), function() delete(Server) end)