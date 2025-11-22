local ESX = exports['es_extended']:getSharedObject()
local currentRobbery = nil
local robberyActive = false
local timeRemaining = 0
local collectedProps = {}

-- Variables pour la gestion des zones
local entryZones = {}

-- Fonction pour ouvrir la NUI
local function OpenRobberyUI(locationIndex)
    local location = Config.Locations[locationIndex]

    SendNUIMessage({
        type = 'openUI',
        locationName = location.name,
        hasEasyItem = exports.ox_inventory:Search('count', Config.Items.easy) > 0,
        hasHardItem = exports.ox_inventory:Search('count', Config.Items.hard) > 0
    })

    SetNuiFocus(true, true)
end

-- Callback NUI pour le choix du type de braquage
RegisterNUICallback('startRobbery', function(data, cb)
    SetNuiFocus(false, false)

    local robberyType = data.type -- 'easy' ou 'hard'

    -- Vérifier avec le serveur si le joueur peut commencer le braquage
    ESX.TriggerServerCallback('zcambu:canStartRobbery', function(canStart, message)
        if canStart then
            StartRobbery(currentRobbery, robberyType)
        else
            lib.notify({
                title = 'Cambriolage',
                description = message or Config.Locales['no_item'],
                type = 'error'
            })
        end
    end, currentRobbery, robberyType)

    cb('ok')
end)

-- Callback NUI pour fermer l'interface
RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Fonction pour démarrer le braquage
function StartRobbery(locationIndex, robberyType)
    local location = Config.Locations[locationIndex]
    local playerPed = PlayerPedId()

    robberyActive = true
    collectedProps = {}

    -- Supprimer la zone d'entrée
    RemoveEntryZone(locationIndex)

    -- Notifier la police
    TriggerServerEvent('zcambu:notifyPolice', location.name, location.doorCoords)

    -- Animation cinématique
    lib.notify({
        title = 'Cambriolage',
        description = 'Début du cambriolage...',
        type = 'info'
    })

    -- Téléportation dans l'IPL
    DoScreenFadeOut(1000)
    Wait(1000)

    SetEntityCoords(playerPed, location.ipl.interior.x, location.ipl.interior.y, location.ipl.interior.z)
    SetEntityHeading(playerPed, location.doorHeading)

    Wait(500)
    DoScreenFadeIn(1000)

    -- Démarrer le timer
    timeRemaining = Config.RobberyTimer
    StartRobberyTimer(locationIndex)

    -- Spawner les props
    SpawnRobberyProps(locationIndex, robberyType)
end

-- Fonction pour le timer
function StartRobberyTimer(locationIndex)
    CreateThread(function()
        while timeRemaining > 0 and robberyActive do
            Wait(1000)
            timeRemaining = timeRemaining - 1

            -- Afficher le temps restant
            if timeRemaining % 10 == 0 or timeRemaining <= 10 then
                lib.notify({
                    title = 'Temps restant',
                    description = string.format('%d secondes', timeRemaining),
                    type = 'info'
                })
            end
        end

        if timeRemaining <= 0 and robberyActive then
            lib.notify({
                title = 'Cambriolage',
                description = 'Le temps est écoulé !',
                type = 'warning'
            })
            -- Terminer automatiquement le braquage
            Wait(1000)
            EndRobbery(locationIndex)
        end
    end)
end

-- Fonction pour spawner les zones de collecte (SANS props visibles)
function SpawnRobberyProps(locationIndex, robberyType)
    local location = Config.Locations[locationIndex]
    local counts = Config.PropsCount[robberyType]
    local selectedProps = {}

    -- Sélectionner les props légers aléatoirement
    for i = 1, counts.light do
        local randomIndex = math.random(#Config.AvailableProps.light)
        local randomProp = Config.AvailableProps.light[randomIndex]
        table.insert(selectedProps, randomProp)
    end

    -- Sélectionner les props lourds aléatoirement
    for i = 1, counts.heavy do
        local randomIndex = math.random(#Config.AvailableProps.heavy)
        local randomProp = Config.AvailableProps.heavy[randomIndex]
        table.insert(selectedProps, randomProp)
    end

    -- Créer des ZONES OX_TARGET invisibles (pas de props physiques)
    for i, prop in ipairs(selectedProps) do
        local coords = location.spawnPositions[i]

        -- Créer une zone ox_target invisible
        local zoneName = 'zcambu_collect_' .. locationIndex .. '_' .. i
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = 1.5,
            debug = false,
            options = {
                {
                    name = zoneName,
                    label = 'Récupérer ' .. prop.name,
                    icon = 'fas fa-hand-paper',
                    onSelect = function()
                        CollectProp(locationIndex, robberyType, i, prop)
                    end
                }
            }
        })

        -- Stocker les informations
        table.insert(collectedProps, {
            zoneName = zoneName,
            collected = false,
            propData = prop,
            coords = coords
        })
    end
end

-- Fonction pour collecter un item (TOUS vont dans l'inventaire directement)
function CollectProp(locationIndex, robberyType, propIndex, propData)
    -- Vérifier si déjà collecté
    if collectedProps[propIndex] and collectedProps[propIndex].collected then
        lib.notify({
            title = 'Erreur',
            description = 'Objet déjà récupéré',
            type = 'error'
        })
        return
    end

    -- Animation de récupération (mechanic4)
    ExecuteCommand('e mechanic4')

    if lib.progressBar({
        duration = 3000,
        label = 'Récupération en cours...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true
        }
    }) then
        -- Stopper l'animation après avoir ramassé l'objet
        ExecuteCommand('e c')

        -- Supprimer la zone ox_target
        if collectedProps[propIndex] and collectedProps[propIndex].zoneName then
            pcall(function()
                exports.ox_target:removeZone(collectedProps[propIndex].zoneName)
            end)
        end

        -- Marquer comme collecté
        collectedProps[propIndex].collected = true

        -- Tout va direct dans l'inventaire (léger ou lourd)
        TriggerServerEvent('zcambu:collectItem', propData)
        lib.notify({
            title = 'Collecté',
            description = 'Objet ajouté à l\'inventaire',
            type = 'success'
        })
    else
        ExecuteCommand('e c')
        lib.notify({
            title = 'Annulé',
            description = 'Récupération annulée',
            type = 'error'
        })
    end
end

-- Fonction pour terminer le braquage (appelée par le timer)
function EndRobbery(locationIndex)
    local location = Config.Locations[locationIndex]
    local playerPed = PlayerPedId()

    robberyActive = false

    -- Fade out
    DoScreenFadeOut(1000)
    Wait(1000)

    -- Nettoyer les zones ox_target restantes
    for _, prop in pairs(collectedProps) do
        if prop.zoneName and not prop.collected then
            pcall(function()
                exports.ox_target:removeZone(prop.zoneName)
            end)
        end
    end
    collectedProps = {}

    -- TP le joueur dehors
    SetEntityCoords(playerPed, location.doorCoords.x, location.doorCoords.y, location.doorCoords.z)
    SetEntityHeading(playerPed, location.doorHeading)

    Wait(500)
    DoScreenFadeIn(1000)

    -- Recréer la zone d'entrée
    CreateEntryZone(locationIndex)

    -- Notifier le serveur
    TriggerServerEvent('zcambu:endRobbery')

    lib.notify({
        title = 'Braquage terminé',
        description = 'Vous avez quitté le braquage',
        type = 'success'
    })
end

-- Fonction pour créer la zone d'entrée
function CreateEntryZone(locationIndex)
    local location = Config.Locations[locationIndex]

    local zoneName = 'zcambu_entry_' .. locationIndex
    exports.ox_target:addBoxZone({
        coords = location.doorCoords,
        size = vec3(2, 2, 2),
        rotation = location.doorHeading,
        debug = Config.Debug,
        options = {
            {
                name = zoneName,
                label = 'Commencer le cambriolage',
                icon = 'fas fa-mask',
                distance = 2.0,
                onSelect = function()
                    currentRobbery = locationIndex
                    OpenRobberyUI(locationIndex)
                end
            }
        }
    })

    entryZones[locationIndex] = zoneName
end

-- Fonction pour supprimer la zone d'entrée
function RemoveEntryZone(locationIndex)
    if entryZones[locationIndex] then
        pcall(function()
            exports.ox_target:removeZone(entryZones[locationIndex])
        end)
        entryZones[locationIndex] = nil
    end
end

-- Initialisation des zones ox_target et blips
CreateThread(function()
    for index, location in ipairs(Config.Locations) do
        -- Créer la zone d'entrée au démarrage
        CreateEntryZone(index)

        -- Créer le blip si configuré
        if location.blip then
            local blip = AddBlipForCoord(location.doorCoords.x, location.doorCoords.y, location.doorCoords.z)
            SetBlipSprite(blip, location.blip.sprite)
            SetBlipColour(blip, location.blip.color)
            SetBlipScale(blip, location.blip.scale)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(location.blip.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)


-- Event pour créer un blip temporaire pour la police
RegisterNetEvent('zcambu:createPoliceBlip', function(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 161) -- Icône de cambriolage
    SetBlipColour(blip, 1) -- Rouge
    SetBlipScale(blip, 1.2)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Cambriolage en cours')
    EndTextCommandSetBlipName(blip)

    -- Flash le blip
    SetBlipFlashes(blip, true)

    -- Supprimer le blip après 5 minutes
    SetTimeout(300000, function()
        RemoveBlip(blip)
    end)
end)

-- Nettoyage à la déconnexion
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    -- Nettoyer les props
    for _, prop in pairs(collectedProps) do
        if DoesEntityExist(prop.object) then
            DeleteObject(prop.object)
        end
    end

    lib.hideTextUI()
end)
