local stopNitroTimer
local nitroShader

function DoActionNitro()
	killTimer(stopNitroTimer)
	nitroShader = dxCreateShader("files/nitro.fx")
	setTimer(function()
	local r,g,b = math.random(0,255),math.random(0,255),math.random(0,255)
		updateNitroColor(r,g,b)
	end, 250, 120)
	stopNitroTimer = setTimer(resetNitroColor, 30000, 1)		
end

function updateNitroColor(r,g,b)
	engineApplyShaderToWorldTexture (nitroShader,"smoke")
	dxSetShaderValue (nitroShader, "gNitroColor", r/255, g/255, b/255 )
end

function resetNitroColor()
	if nitroShader then
		engineRemoveShaderFromWorldTexture(nitroShader,"smoke")
		destroyElement(nitroShader)
	end
end

addEvent( "ActionNitro", true )
addEventHandler( "ActionNitro", getRootElement(), DoActionNitro)