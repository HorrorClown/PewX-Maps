addEventHandler('onClientResourceStart', resourceRoot, 
	function() 
		engineImportTXD(engineLoadTXD('files/grass.txd',true), 2052)
		engineImportTXD(engineLoadTXD('files/cobblestone.txd',true), 2380)
		engineImportTXD(engineLoadTXD('files/stone.txd',true), 2652)
		engineImportTXD(engineLoadTXD('files/wood.txd',true), 2371)
		engineImportTXD(engineLoadTXD('files/steve.txd',true), 7606)
		engineImportTXD(engineLoadTXD('files/slenderman.txd',true), 1337)
		engineImportTXD(engineLoadTXD('files/slenderman.txd',true), 115)

		
		local dff = engineLoadDFF('files/block.dff', 0) 
		engineReplaceModel(dff, 2052)
		engineReplaceModel(dff, 2380)
		engineReplaceModel(dff, 2652)
		engineReplaceModel(dff, 2371)

		engineReplaceModel(engineLoadDFF('files/steve.dff', 0) , 7606)
		engineReplaceModel(engineLoadDFF('files/slenderman.dff', 0) , 1337)
		engineReplaceModel(engineLoadDFF('files/slenderman.dff', 0) , 115)
		
		local col = engineLoadCOL('files/block.col') 
		engineReplaceCOL(col, 2052)
		engineReplaceCOL(col, 2380)
		engineReplaceCOL(col, 2652)
		engineReplaceCOL(col, 2371)

			
		engineSetModelLODDistance(2052, 500)
		engineSetModelLODDistance(2380, 500)
		engineSetModelLODDistance(2652, 500)
		engineSetModelLODDistance(2371, 500)
		engineSetModelLODDistance(7606, 500)
		engineSetModelLODDistance(1337, 500)
		engineSetModelLODDistance(115, 500)
	end 
)