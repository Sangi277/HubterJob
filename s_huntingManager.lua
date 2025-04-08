
 local hunter = createPed( 33, -1628.8681640625, -2239.294921875,31.4765625 , 85)
setPedRotation(hunter, 85)

 if not hunter then
        outputChatBox("Error al crear el NPC")
        return
    end
     
    setElementHealth(hunter, 100)
    setPedArmor(hunter, 100)
    setElementFrozen(hunter, true) -- Evita que el NPC se mueva solo
    setElementData(hunter, "npc", true) -- Identificar como NPC

    


function animarHunter()
    setPedAnimation(hunter, "PED", "IDLE_chat")
    setTimer(setPedAnimation, 5000, 1, hunter)

end

addEvent("animarHunter", true)
addEventHandler("animarHunter", root, animarHunter)


