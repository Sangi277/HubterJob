
marcador = createMarker ( -1630.025390625, -2239.4326171875, 30 ,"cylinder", 1.0,255, 162, 51, 255 )

function animacion(hitPlayer)
  
      if hitPlayer == localPlayer then
         
        triggerServerEvent("animarHunter",localPlayer) -- Pide al servidor que anime al ped
      
    triggerEvent("panelWindowHunt", resourceRoot)
    end
  
end

addEventHandler("onClientMarkerHit", marcador, animacion)