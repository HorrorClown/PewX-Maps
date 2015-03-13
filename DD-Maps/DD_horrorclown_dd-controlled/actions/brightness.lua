local shaderList = {}
local myShader
local StopBrightTimer

function DoActionBrightness()
		destroyElement(myShader)
		myShader = dxCreateShader ( "files/block_world.fx" )
		shaderList = {}
		killTimer(StopBrightTimer)
			for c=65,96 do
				engineApplyShaderToWorldTexture ( myShader, string.format( "%c*", c + 32 ))
				shaderList[#shaderList+1] = myShader
			end
			colorize()
			StopBrightTimer = setTimer(stopBrightShader, 30000, 1)
end


function colorize()
		for _,shader in ipairs(shaderList) do
		local r,g,b = 9,9,9
		dxSetShaderValue ( shader, "COLORIZE", r, g, b)
		end
end

function stopBrightShader()
	destroyElement(myShader)
end

addEvent( "ActionBrightness", true )
addEventHandler( "ActionBrightness", getRootElement(), DoActionBrightness)