
local Hunter = createPed(33,-1628.8681640625, -2239.294921875,31.4765625)

    setPedRotation(Hunter,90)
    setElementHealth(Hunter, 100)
    setPedArmor(Hunter, 100)
    setElementFrozen(Hunter, true) -- Evita que el NPC se mueva solo
    setElementData(Hunter, "npc", true) -- Identificar como NPC

    


marcador = createMarker ( -1630.025390625, -2239.4326171875, 30 ,"cylinder", 1.0,255, 162, 51, 255 )

function animacion(hitPlayer)
  
      if hitPlayer == localPlayer then
         
         setPedAnimation(Hunter, "PED", "IDLE_chat")
         setTimer(setPedAnimation, 5000, 1, Hunter)

        

    triggerEvent("panelWindowHunt", resourceRoot)
    end
  
end

addEventHandler("onClientMarkerHit", marcador, animacion)