function MusikAn()
    song = playSound("http://www.vio-race.de/servermusic/mapmusic/horrorclown_kill-everybody-III.mp3",true)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),MusikAn)