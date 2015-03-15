CClient = {}
 
function CClient:constructor()
       self.Sound = playSound( "http://irace-mta.de/servermusic/mapmusic/pewx-ft-rewrite_special-for-dirtkuh.mp3" , true)
       setSoundVolume(self.Sound, 0.6)
	   
        addEvent("playClientMoo3D", true)
        addEventHandler("playClientMoo3D", getRootElement(),
                function(Element)
                        local x,y,z = getElementPosition(Element)
                        attachElements(playSound3D("moo.mp3", x,y,z), Element)
                end
        )
end
 
function CClient:destructor()
        destroyElement(self.Sound)
end
 
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function() Client = new(CClient) end)
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), function() delete(Client) end)