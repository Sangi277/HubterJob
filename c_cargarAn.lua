list3D = { "Lobo", "Ciervo", "Caracal"}
listIds ={300,301,311,1}


function cargarSkin()

   
    for i, valor in pairs(list3D) do
 
        local txd = engineLoadTXD("Animal/"..valor..".txd")
        local dff = engineLoadDFF("Animal/"..valor..".dff")
    
        local newId =listIds[i]
    
        engineImportTXD(txd, newId)
        engineReplaceModel(dff, newId)
     
    end

end


addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()), cargarSkin)


