--Shader by Samake
local screenWidth, screenHeight = guiGetScreenSize()
local myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)
local flickerStrength = 10
local blurStrength = 0.001 
local noiseStrength = 0.001
local oldFilmShader

addEvent("toggleShader", true)
addEventHandler("toggleShader", localPlayer,
	function(state)
		if state then addEventHandler("onClientPreRender", root, updateShader) else removeEventHandler("onClientPreRender", root, updateShader) end
	end
)

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		oldFilmShader = dxCreateShader("shaders/old_film.fx")
	end
)

function updateShader() 
    dxUpdateScreenSource(myScreenSource)

    if (oldFilmShader) then
        local flickering = math.random(100 - flickerStrength, 100)/100
        dxSetShaderValue(oldFilmShader, "ScreenSource", myScreenSource);
        dxSetShaderValue(oldFilmShader, "Flickering", flickering);
        dxSetShaderValue(oldFilmShader, "Blurring", blurStrength);
        dxSetShaderValue(oldFilmShader, "Noise", noiseStrength);
        dxDrawImage(0, 0, screenWidth, screenHeight, oldFilmShader)
    end
end

