-- Variables globales
local window = nil
local imageLabels = {}
local selectedImage = nil
local screenWidth, screenHeight = guiGetScreenSize()

-- Función para abrir la ventana
function openImageWindow()
    -- Crear la ventana (centrada en la pantalla)
    local windowWidth, windowHeight = 650, 450
    local windowX = (screenWidth - windowWidth) / 2
    local windowY = (screenHeight - windowHeight) / 2
    window = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "Selecciona una imagen", false)
    guiWindowSetSizable(window, false)

    -- Crear las imágenes (escaladas para que quepan)
    local imageWidth, imageHeight = 200, 300 -- Escala de 1024x1536 a un tamaño manejable
    local imageFiles = { "img/grupo.png", "img/ciervo.png", "img/caracal.png" }

    for i, imageFile in ipairs(imageFiles) do
        -- Posición de cada imagen en la ventana
        local x = 20 + (i - 1) * (imageWidth + 10)
        local y = 40

        -- Crear un label como contenedor para la imagen (para simular selección)
        local label = guiCreateLabel(x, y, imageWidth, imageHeight, "", false, window)
        guiLabelSetColor(label, 255, 255, 255)

        -- Crear la imagen dentro del label
        local image = guiCreateStaticImage(0, 0, imageWidth, imageHeight, imageFile, false, label)

        -- Almacenar el label y su ID
        imageLabels[i] = { label = label, image = image, id = i }

        -- Manejar el clic en la IMAGEN (no en el label)
        addEventHandler("onClientGUIClick", image, function()
            -- Desmarcar todas las imágenes
            for _, imgData in ipairs(imageLabels) do
                guiSetProperty(imgData.label, "NormalTextColour", "FF000000") -- Borde negro (sin selección)
            end
            -- Marcar la imagen seleccionada
            guiSetProperty(label, "NormalTextColour", "FF00FF00")     -- Borde verde (seleccionada)
            selectedImage = i
          
        end, false)
    end

    -- Crear el botón de "Aceptar"
    local buttonX = (windowWidth - 100) / 2
    local buttonY = windowHeight - 60
    local acceptButton = guiCreateButton(buttonX, buttonY, 100, 40, "Aceptar", false, window)

    -- Manejar el clic en el botón
    addEventHandler("onClientGUIClick", acceptButton, function()
        if selectedImage then
          

            triggerServerEvent("createAnimal", localPlayer, selectedImage)
            
            closeImageWindow()
        else
          
        end
    end, false)

    -- Mostrar el cursor
    showCursor(true)
end

-- Función para cerrar la ventana
function closeImageWindow()
    if window then
        destroyElement(window)
        window = nil
        imageLabels = {}
       -- selectedImage = nil
        showCursor(false)
    end
end


addCommandHandler("openimages", openImageWindow)

addEventHandler("onClientResourceStop", resourceRoot, closeImageWindow)


addEvent("panelWindowHunt", true)
addEventHandler("panelWindowHunt",resourceRoot, openImageWindow)
