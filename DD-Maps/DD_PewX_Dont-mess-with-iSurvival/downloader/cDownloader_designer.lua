--iR|HorrorClown (PewX) - iRace-mta.de - 07.06.2014--
local x, y = guiGetScreenSize()
local w, h = 500, 60
local x1, y1 = x/2-w/2, y - 200

local function renderDownloadProgress()
	local index, item, maxFiles = getDownloadState()
	dxDrawWindow(x1, y1, w, h, "Download (" .. math.round(100/maxFiles*index) .. "%)")
	
	dxDrawRectangle(x1 + 5, y1 + 25, (w-10)/maxFiles*index, 30, tocolor(255, 100, 0, 120))
	dxDrawLine(x1 + 5, y1 + 25, x1 + 5 + (w-10)/maxFiles*index, y1 + 25, tocolor(255, 80, 0, 150), 2)
	dxDrawLine(x1 + 5, y1 + 54, x1 + 5 + (w-10)/maxFiles*index, y1 + 54, tocolor(255, 80, 0, 150), 2)
	dxDrawText("[" .. item .. "]", x1, y1 + 20, x1 + w, y1 + h, tocolor(255, 255, 255, 120), 1, "default", "center", "center")
end

addEvent("onClientStartDownload", true)
addEventHandler("onClientStartDownload", me, function(tFiles)
	addEventHandler("onClientRender", root, renderDownloadProgress)
end)

function downloadFinished()
	removeEventHandler("onClientRender", root, renderDownloadProgress)
end

function dxDrawWindow(sx, sy, width, height, title, close, aFunction)
	dxDrawRectangle(sx, sy, width, height, tocolor(40, 40, 40, 240))
	dxDrawRectangle(sx, sy, width, 20, tocolor(200, 0, 0))
	dxDrawText(title, sx, sy, sx + width, sy + 20, tocolor(255, 255, 255), 1, "default", "center", "center")
	dxDrawDoubleLine(sx, sy + 20, width)
	
	--Close
	if close then if isHover(sx + width - 18, sy + 2, 16, 16) then dxDrawImage(sx + width - 18, sy + 2, 16, 16, "files/images/gui/close.png", 0, 0, 0, tocolor(0, 0, 0)) if click then aFunction() end else dxDrawImage(sx + width - 18, sy + 2, 16, 16, "files/images/gui/close.png", 0, 0, 0, tocolor(50, 50, 50))	end	end
end

function dxDrawDoubleLine(lx, ly, lwidth)
	ly, lx, lwidth = math.floor(ly), math.floor(lx), math.floor(lwidth)
	dxDrawLine(lx, ly, lx+lwidth, ly, tocolor(20, 20, 20, 255), 1)
	dxDrawLine(lx, ly+1, lx+lwidth, ly+1, tocolor(100, 100, 100, 255), 1)
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end