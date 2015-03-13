-- * Collision/Scale object Manager * --
noCollsTab = {}
noScaleTab = {}
addEventHandler("onClientResourceStart", resourceRoot, function()
	local i = 1
	while(i <= #noCollsTab)do
		setElementCollisionsEnabled(noCollsTab[i], false)
		i=i+1
	end
	local j = 1
	while(j <= #noScaleTab)do
		setObjectScale(noScaleTab[j], 0)
		j=j+1
	end
end
)
table.insert(noScaleTab, createObject(8355,-1313.9000244141,1114,91.199996948242,270,0,0))
table.insert(noScaleTab, createObject(8355,-1273.9000244141,1114,91.199996948242,269.99450683594,0,0))
table.insert(noScaleTab, createObject(8355,-1265.8000488281,1132.8000488281,91.199996948242,270,180,270))
table.insert(noScaleTab, createObject(8355,-1265.8000488281,1172.8000488281,91.199996948242,270,179.99450683594,270))
table.insert(noScaleTab, createObject(8355,-1285.8000488281,1182,91.199996948242,270,180,0))
table.insert(noScaleTab, createObject(8355,-1325.8000488281,1182,91.199996948242,270,179.99450683594,0))
table.insert(noScaleTab, createObject(8355,-1333.8000488281,1162.6999511719,91.199996948242,270,180,90))
table.insert(noScaleTab, createObject(8355,-1333.8000488281,1122.6999511719,91.199996948242,270,179.99450683594,90))
