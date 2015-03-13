function ClientStarted ()
txd = engineLoadTXD ( "gta_tree_palm.txd" )
engineImportTXD ( txd, 622 )
dff = engineLoadDFF ( "veg_palm03.dff", 622 )
engineReplaceModel ( dff, 622 )

txd = engineLoadTXD ( "vgncarshade1.txd" )
engineImportTXD ( txd, 8558 )
txd = engineLoadTXD ( "luxorpillar1.txd" )
engineImportTXD( txd, 8397 )
txd = engineLoadTXD  ( "excalibursign.txd" )
engineImportTXD( txd, 8620 )
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )