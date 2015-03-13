local interval = 5000
local BombTimer
local ExploX
local ExploY
local Type = 11

function start()
	setTimer(function()
		for i, player in pairs ( getElementsByType( "player" ) ) do
			triggerClientEvent ( player, "startMusic", player )
		end
		activator()
	end, 20000, 1)
end

function startExplosions()
	BombTimer = setTimer(function()
		ExploX = math.random(-1332, -1267)
		ExploY = math.random(1116, 1180)
		createExplosion(ExploX, ExploY, 89.699996948242, Type)
		if interval > 400 then
			interval = interval - 100
		end
	end, interval, 1)
end

function activator()
	setTimer(function()
		if isTimer(BombTimer) == false then
			startExplosions()
		end
	end, 50, 0)
end

setTimer(function()
Type = 2
outputChatBox("#616161[Map]: #00ddffWarning: New bomb type set ;D", getRootElement(), 255, 0, 0, true)
end, 240000, 1)


addEventHandler("onResourceStart", getRootElement(), start)
