local w, h = guiGetScreenSize( );
local enable = false;
local screenShader
local stopCartoonTimer

function DoActionCartoon()
		killTimer(stopCartoonTimer)
		screenShader = dxCreateShader( "files/PixelShad.fx" );
		screenSrc = dxCreateScreenSource( w, h );
		if screenShader and screenSrc then
			dxSetShaderValue( screenShader, "PixelShadTexture", screenSrc );
			addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
		end
		stopCartoonTimer = setTimer(stopCartoonShader, 30000, 1)
end

function renderEffect( )
	dxSetRenderTarget( );
	dxUpdateScreenSource( screenSrc );
	dxDrawImage( 0, 0, w, h, screenShader );
end

function stopCartoonShader()
	destroyElement( screenShader );
	destroyElement( screenSrc );
	screenShader, screenSrc = nil, nil;
	removeEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
end

addEvent( "ActionCartoon", true )
addEventHandler( "ActionCartoon", getRootElement(), DoActionCartoon)