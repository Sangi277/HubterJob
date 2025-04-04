-- Definir la matriz de posiciones y rotaciones
 local posiciones = {
     {-1754.935546875, -1864.0048828125, 88.095001220703, 0},  -- Posición 1
     {-1125.248046875, -2421.1162109375, 80.637603759766, 0},
    {-1696.2158203125, -1946.3994140625, 104.8030166626, 0},
    {-1371.9326171875, -2738.560546875, 87.689270019531, 0},
    {-910.8251953125, -2520.9287109375, 119.1298828125, 0},
    {-975.6396484375, -2187.984375, 41.6252784729, 0},
    {-847.453125, -2315.23046875, 30.323818206787, 0},
    {-1684.869140625, -2422.1982421875, 103.75692749023, 0},
    {-1307.486328125, -2438.8271484375, 23.657644271851, 0}  
}

 
accion = {"WALK_old","WALK_civi","RUN_civi","SPRINT_civi"}


--funciones
local removeProximitySensor
local createProximitySensor
local calcRotationNew
local causeOfDeath
local huntingBounty
local checkLife
local calcRotation
local changeAnimation
local createBlipPed
local removeBlip
local crearPedEnPosicion
local crearYMoverPeds
local firstWarning
local deletePed
--funciones


function createAndSetTimer(ped,marker,blip)
    local timer = setTimer(function()
      
      removeProximitySensor(marker)
      removeBlip(blip)
      deletePed(ped)
   
    end
   ,300000,1)
    setElementData(ped, "deleteTimer", timer)
    outputChatBox("SE CREO EL TIMER espera ")
end

function huntingTime(ped)
    local timer = setTimer(function()
        deletePed(ped)
    end,300000,1)
    outputChatBox("SE CREO EL TIMER CAZA")
    setElementData(ped, "deleteTimer", timer)
end


function cancelTimer(ped)
    local Auxtimer = getElementData(ped, "deleteTimer")
    if Auxtimer then
        killTimer(Auxtimer)
        setElementData(ped, "deleteTimer", nil)
        outputChatBox("SE ELIMINO EL timer")
    end
end

function deletePed(ped)
     setTimer(function()
        if isElement(ped) then
            destroyElement(ped)
        end
    end, 10000, 1) -- 5 segundos de delay

end

function removeProximitySensor(marker)
    if not marker then
        outputDebugString("Error: El marcador es nil", 2)
        return false
    end
    
    if not isElement(marker) then
        outputDebugString("Error: El marcador ya no existe como elemento", 2)
        return false
    end
    
    local destruccionExitosa = destroyElement(marker)
    if destruccionExitosa then
        outputDebugString("Sensor de proximidad eliminado con éxito")
        return true
    else
        outputDebugString("Error al intentar destruir el sensor", 2)
        return false
    end

end

function createProximitySensor(ped, marker, blip,player)
    attachElements(marker, ped, 0, 0, 0)
    
    addEventHandler("onMarkerHit", marker, function(hitElement, matchingDimension)
        -- Verificar que quien entró sea un jugador y esté en la misma dimensión
        if not matchingDimension then return end
        if getElementType(hitElement) ~= "player" then return end
        firstWarning(ped, blip, marker, 3,player)
        outputChatBox("jugador entro en el area del ped")
        
    end)
end

local angulos={30,-30,60,-60,90,-90}

function calcRotationNew(ped, player)
    local _,_,playerRot = getElementRotation(player)
    local i = math.random(1, 6)
    local opRot= (playerRot + angulos[i]) % 360
    setElementRotation(ped, 0, 0, opRot)

end


function causeOfDeath(killer)
    local bonus = 0
    if killer and getElementType(killer) == "player" then
        local killerName = getPlayerName(killer)
        outputChatBox("El ped fue cazado por: " .. killerName)
        bonus = 20
        return bonus
    else
        outputChatBox("El ped murió por causas naturales")
        bonus = 10
        return bonus
    end
end

function huntingBounty(cause,ped,source)
    --aqui se entregara la reconpenza

    local x, y, z = getElementPosition(ped)    
    local money = createPickup(x, y, z, 3, 1212)
    
     addEventHandler("onPickupHit", money, function(source)
    
        givePlayerMoney(source, cause)
        destroyElement(money)
        
    end)
     

end


function checkLife(ped)
 local vida = getElementHealth(ped)
    if vida and vida <= 70 then
        changeAnimation(ped,4)
        local b=true
        return b
    else
        outputDebugString("Error: No se pudo obtener la vida del ped.", 2)
        return false
    end

end



function calcRotation(ped)
    x1, y1, a = getElementPosition(ped)
    
    local indiceAleatorio = math.random(1, #posiciones)
    local x2,y2,a,b =unpack(posiciones[indiceAleatorio])  

    local angulo = math.deg(math.atan2(x2 - x1, y2 - y1))
    local rotacion = (angulo + 180) % 360
        outputChatBox("la rotacion es: "..rotacion)
        setElementRotation(ped, 0, 0, rotacion)
end



function changeAnimation(ped,i)
    outputChatBox(i)

    if i<=4 then
             outputChatBox("se cambio: "..accion[i])

                 --setElementHealth(ped, 100)  
                 setPedAnimation(
                   ped,--ped 
                 "ped",-- bloque
                 accion[i],-- animacion
                 -1,-- tiempo
                 true,-- loop
                 true,-- updatePosition 
                 false,-- interruptible 
                 true )-- freezeLastFrame
     
    else 
         outputChatBox("se exedio con el incrementador")   

    end
    
end

function createBlipPed(x,y,z)
    local blip = createBlip(x, y, z)
            setBlipColor(blip, 0, 255, 0, 255)
            setBlipSize(blip, 2)
            return blip
end

function removeBlip(blip)
    if blip and isElement(blip) then

      destroyElement(blip)
    
      outputChatBox("El bot sufrio daño, blip eliminado.", root)

    end

end


function crearPedEnPosicion(x1, y1, z1, rotacion,player,radio)
    
     local ped = createPed(1, x1, y1, z1)
     local typeAn=0
     setElementHealth(ped, 100)
    
    local i=1
    
    if ped then

           -- calcRotation(ped)
        
          setElementData(ped, "npc", player)
            
        local marker = createMarker(x1, y1, z1, "cylinder", radio, 255, 162, 51, 0)
             
                --validadores
         local blip = createBlipPed(x1, y1, z1)
            createProximitySensor(ped, marker,blip,player)
            createAndSetTimer(ped,marker,blip)

            local warningBool=false
            local  warning=false
       
            addEventHandler("onPedDamage", ped, function()
                 --se cancela el timer anterior
                outputChatBox("¡Ped dañado!")
               
                if  not warningBool  then 
                
                 warningBool=firstWarning(ped,blip,marker,3,player)
                    
                else  

                    if not warning then
                        outputChatBox("ped corre peligro")
                         warning=checkLife(ped)
                         calcRotationNew(ped, player)

                        
                     else
                        outputChatBox("ped al borde de la muerte")
                        calcRotation(ped)

                        
                    end

                end

                     --se inicia otro timmmer
            end)
            
            addEventHandler("onPedWasted", ped, function(totalAmmo, killer, killerWeapon, bodypart)
                cancelTimer(ped)
               local cause =  causeOfDeath(killer)
                huntingBounty(cause,ped,source)
                  
                 deletePed(ped)
            end)

        
            
            return ped
        
        else
        outputDebugString("Error al crear el ped.", 2)
        return false
        
    end
end



function crearYMoverPeds(player)
         local indiceAleatorio = math.random(1, #posiciones)
         local x1, y1, z1, rotacion = unpack(posiciones[indiceAleatorio]) 
         local radio=50.0
         local  ped = crearPedEnPosicion(x1, y1, z1, rotacion,player,radio)  
      
        outputChatBox("ped comenzo a moverse. . . ")
end

function firstWarning(ped,blip,marker,i,player)
    cancelTimer(ped) --se cancela el timer anterior de espera
    removeBlip(blip)
    calcRotation(ped)
     
    changeAnimation(ped, i)
    checkLife(ped)
    removeProximitySensor(marker)
    outputChatBox("se creao UNA advertencia")
    huntingTime(ped) --se cancela el timer de espera y se crea uno nuevo de caza
   return true
end


-- Comando para ejecutar la función principal
addCommandHandler("crear", crearYMoverPeds)







