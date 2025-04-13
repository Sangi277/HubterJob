

function animarHunter()
    setPedAnimation(hunter, "PED", "IDLE_chat")
    setTimer(setPedAnimation, 5000, 1, hunter)

end

addEvent("animarHunter", true)
addEventHandler("animarHunter", root, animarHunter)


