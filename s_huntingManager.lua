local Hunter = createPed(33,-1628.8681640625, -2239.294921875,31.4765625)

    setPedRotation(Hunter,90)
    setElementHealth(Hunter, 100)
    setPedArmor(Hunter, 100)
    setElementFrozen(Hunter, true) -- Evita que el NPC se mueva solo
    setElementData(Hunter, "npc", true) -- Identificar como NPC

    

function animarHunter()
    setPedAnimation(hunter, "PED", "IDLE_chat")
    setTimer(setPedAnimation, 5000, 1, hunter)

end

addEvent("animarHunter", true)
addEventHandler("animarHunter", root, animarHunter)


