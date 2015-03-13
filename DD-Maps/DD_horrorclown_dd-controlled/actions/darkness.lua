local shaderList = {}
local myShader
local StopDarkTimer

function DoActionDarkness()
		destroyElement(myShader)
		myShader = dxCreateShader ( "files/block_world.fx" )
		shaderList = {}
		killTimer(StopDarkTimer)
			for c=65,96 do
				engineApplyShaderToWorldTexture ( myShader, string.format( "%c*", c + 32 ))
				shaderList[#shaderList+1] = myShader
			end
			colorize()
			StopDarkTimer = setTimer(stopDarkShader, 30000, 1)
end


function colorize()
		for _,shader in ipairs(shaderList) do
		local r,g,b = 0,0,0
		dxSetShaderValue ( shader, "COLORIZE", r, g, b)
		end
end

function stopDarkShader()
	destroyElement(myShader)
end

addEvent( "ActionDarkness", true )
addEventHandler( "ActionDarkness", getRootElement(), DoActionDarkness)