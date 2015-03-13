local DiscoMarker

function CreateDiscoMarker()
local Marker = math.random(1,3)
	if (Marker == 1) then
		outputChatBox("|Map| Disco marker is available for 10 seconds!", getRootElement(), 255, 100, 0)
		DiscoMarker = createMarker((math.random(4060, 4095)), (math.random(270, 310)), 100, "checkpoint", 2, 255, 100, 0)
		setTimer ( DestroyMarker, 30000, 1)
		addEventHandler("onMarkerHit", DiscoMarker, PlayDisco)
	end
end

		

function DestroyMarker()
	destroyElement(DiscoMarker)
	setTimer( CreateDiscoMarker, 120000, 1)
end

function PlayDisco(player)
	if getElementType(player) == "player" then
		local PlayerName = getPlayerName(player)
		outputChatBox("|Map| " .. PlayerName .. " #FF6600has activated disco!", getRootElement(), 255, 100, 0, true)
		destroyElement(DiscoMarker)
		setWeather(19)
		setSkyGradient(255, 100, 0, 255, 100, 0)
		setWaterColor(0, 0, 0)

		local RandomMusic = math.random(1,4)
		if RandomMusic == 1 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
				triggerClientEvent ( player, "PlayDiscoMusic1", player )
			end
		elseif RandomMusic == 2 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
				triggerClientEvent ( player, "PlayDiscoMusic2", player )
			end
		elseif RandomMusic == 3 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
				triggerClientEvent ( player, "PlayDiscoMusic3", player )
			end
		elseif RandomMusic == 4 then
			for i, player in pairs ( getElementsByType( "player" ) ) do
				triggerClientEvent ( player, "PlayDiscoMusic4", player )
			end
		end
	end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), CreateDiscoMarker)