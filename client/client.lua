local ESX = exports['es_extended']:getSharedObject()
local currentRobbery = nil
local robberyActive = false
local carryingObject = nil
local carryingProp = nil
local timeRemaining = 0
local collectedProps = {}

-- Variables pour la gestion des zones
local targetZones = {}
local entryZones = {}
local currentExitZone = nil
local reenterZone = nil
local isOutside = false

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

    -- Charger l'animation
    lib.requestAnimDict(Config.Animations.cinematic.dict, 5000)
    TaskPlayAnim(playerPed, Config.Animations.cinematic.dict, Config.Animations.cinematic.anim, 8.0, -8.0, Config.Animations.cinematic.duration, 0, 0, false, false, false)

    Wait(Config.Animations.cinematic.duration)

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

    -- Créer la zone de sortie
    CreateExitZone(locationIndex)
end

-- Fonction pour le timer
function StartRobberyTimer(locationIndex)
    CreateThread(function()
        while timeRemaining > 0 and robberyActive do
            Wait(1000)
            timeRemaining = timeRemaining - 1

            -- Afficher le temps restant
            if timeRemaining % 30 == 0 or timeRemaining <= 10 then
                lib.notify({
                    title = 'Temps restant',
                    description = string.format('%d:%02d', math.floor(timeRemaining / 60), timeRemaining % 60),
                    type = 'info'
                })
            end
        end

        if timeRemaining <= 0 and robberyActive then
            lib.notify({
                title = 'Cambriolage',
                description = 'Le temps est écoulé ! Sortez rapidement !',
                type = 'warning'
            })
            -- Terminer automatiquement le braquage et recréer la zone d'entrée
            Wait(2000)
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
        table.insert(selectedProps, {
            prop = randomProp,
            heavy = false
        })
    end

    -- Sélectionner les props lourds aléatoirement
    for i = 1, counts.heavy do
        local randomIndex = math.random(#Config.AvailableProps.heavy)
        local randomProp = Config.AvailableProps.heavy[randomIndex]
        table.insert(selectedProps, {
            prop = randomProp,
            heavy = true
        })
    end

    -- Créer des ZONES OX_TARGET invisibles (pas de props physiques)
    for i, selected in ipairs(selectedProps) do
        local coords = location.spawnPositions[i]

        -- Créer une zone ox_target invisible
        local zoneName = 'zcambu_collect_' .. locationIndex .. '_' .. i
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = 1.5,
            debug = false, -- Pas de debug visuel
            options = {
                {
                    name = zoneName,
                    label = 'Récupérer ' .. selected.prop.name,
                    icon = 'fas fa-hand-paper',
                    onSelect = function()
                        CollectProp(locationIndex, robberyType, i, nil, selected.prop, selected.heavy)
                    end
                }
            }
        })

        -- Stocker les informations
        table.insert(collectedProps, {
            zoneName = zoneName,
            collected = false,
            propData = selected.prop,
            heavy = selected.heavy,
            coords = coords
        })
    end
end

-- Fonction pour collecter un item (depuis zone ox_target)
function CollectProp(locationIndex, robberyType, propIndex, propObj, propData, isHeavy)
    local playerPed = PlayerPedId()

    -- Vérifier si déjà collecté
    if collectedProps[propIndex] and collectedProps[propIndex].collected then
        lib.notify({
            title = 'Erreur',
            description = 'Objet déjà récupéré',
            type = 'error'
        })
        return
    end

    -- Vérifier si le joueur porte déjà un objet lourd
    if carryingObject and isHeavy then
        lib.notify({
            title = 'Erreur',
            description = 'Vous portez déjà un objet lourd',
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
            exports.ox_target:removeZone(collectedProps[propIndex].zoneName)
        end

        -- Marquer comme collecté
        collectedProps[propIndex].collected = true

        if isHeavy then
            -- Objet lourd : prop en main + inventaire + restrictions
            AttachHeavyObject(propData)
            TriggerServerEvent('zcambu:collectItem', propData)
            lib.notify({
                title = 'Objet lourd',
                description = 'Sortez-le de votre inventaire pour le déposer',
                type = 'warning'
            })
        else
            -- Objet léger : direct dans l'inventaire (pas de props)
            TriggerServerEvent('zcambu:collectItem', propData)
            lib.notify({
                title = 'Collecté',
                description = 'Objet ajouté à l\'inventaire',
                type = 'success'
            })
        end
    else
        lib.notify({
            title = 'Annulé',
            description = 'Récupération annulée',
            type = 'error'
        })
    end
end

-- Fonction pour attacher un objet lourd
function AttachHeavyObject(propData)
    local playerPed = PlayerPedId()

    carryingObject = propData

    -- Charger le modèle
    local propHash = GetHashKey(propData.model)
    lib.requestModel(propHash, 5000)

    -- Créer le prop dans les mains
    carryingProp = CreateObject(propHash, 0, 0, 0, true, true, true)

    -- Attacher le prop à la main (configuration dans config.lua)
    local attach = Config.PropAttachment
    AttachEntityToEntity(
        carryingProp,
        playerPed,
        GetPedBoneIndex(playerPed, attach.bone),
        attach.offset.x,
        attach.offset.y,
        attach.offset.z,
        attach.rotation.pitch,
        attach.rotation.roll,
        attach.rotation.yaw,
        true, true, false, true, 1, true
    )

    -- Charger l'animation de portage
    lib.requestAnimDict(Config.Animations.carry.dict, 5000)
    TaskPlayAnim(playerPed, Config.Animations.carry.dict, Config.Animations.carry.anim, 8.0, -8.0, -1, Config.Animations.carry.flag, 0, false, false, false)

    -- Réduire la vitesse de marche
    SetPedMoveRateOverride(playerPed, Config.HeavyObjectSpeed.walkSpeed)

    -- Bloquer le sprint complètement
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    SetSwimMultiplierForPlayer(PlayerId(), 1.0)

    -- Thread pour empêcher certaines actions ET vérifier l'inventaire
    CreateThread(function()
        while carryingObject do
            Wait(500) -- Vérifier toutes les 500ms au lieu de 0ms

            local playerPed = PlayerPedId()

            -- VÉRIFIER SI L'ITEM EST TOUJOURS DANS L'INVENTAIRE
            local hasItem = exports.ox_inventory:Search('count', carryingObject.reward) > 0
            if not hasItem then
                -- L'item n'est plus dans l'inventaire, enlever le prop
                print('^3[ZCAMBU]^7 Item removed from inventory, cleaning up prop')
                RemoveCarriedObject()
                break
            end

            -- Maintenir la vitesse lente
            SetPedMoveRateOverride(playerPed, Config.HeavyObjectSpeed.walkSpeed)

            -- Désactiver le sprint
            DisableControlAction(0, 21, true) -- Sprint (Shift)
            DisableControlAction(0, 22, true) -- Saut (Espace)

            -- Désactiver les armes et combat
            DisableControlAction(0, 24, true) -- Attaque
            DisableControlAction(0, 25, true) -- Viser
            DisableControlAction(0, 37, true) -- Arme (TAB)
            DisableControlAction(0, 47, true) -- Arme
            DisableControlAction(0, 58, true) -- Arme
            DisableControlAction(0, 140, true) -- Combat léger
            DisableControlAction(0, 141, true) -- Combat moyen
            DisableControlAction(0, 142, true) -- Combat lourd
            DisableControlAction(0, 143, true) -- Combat alternatif
            DisableControlAction(0, 263, true) -- Mêlée 1
            DisableControlAction(0, 264, true) -- Mêlée 2
            DisableControlAction(0, 257, true) -- Mêlée 3

            -- Empêcher de monter dans un véhicule
            DisableControlAction(0, 23, true) -- F (entrer véhicule)
        end

        -- Réinitialiser les multiplicateurs quand on arrête de porter
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        SetSwimMultiplierForPlayer(PlayerId(), 1.0)
    end)
end

-- Fonction pour retirer l'objet porté (appelée quand l'item est déposé/donné/mis dans coffre)
function RemoveCarriedObject()
    if not carryingObject then return end

    local playerPed = PlayerPedId()

    -- Détacher et supprimer le prop
    if carryingProp and DoesEntityExist(carryingProp) then
        DetachEntity(carryingProp, true, true)
        DeleteObject(carryingProp)
    end

    -- Réinitialiser l'état du joueur
    SetPedMoveRateOverride(playerPed, 1.0)
    ClearPedTasks(playerPed)
    ClearPedSecondaryTask(playerPed)

    -- Nettoyer les variables
    carryingObject = nil
    carryingProp = nil

    lib.notify({
        title = 'Objet déposé',
        description = 'Vous avez déposé l\'objet lourd',
        type = 'info'
    })
end

-- Event pour détecter le retrait d'un objet lourd de l'inventaire
RegisterNetEvent('zcambu:removeCarriedObject', function()
    RemoveCarriedObject()
end)

-- Fonction pour créer la zone de sortie (ox_target sur la porte intérieure)
function CreateExitZone(locationIndex)
    local location = Config.Locations[locationIndex]

    -- Créer une zone ox_target sur la porte intérieure
    local zoneName = 'zcambu_exit_' .. locationIndex
    exports.ox_target:addSphereZone({
        coords = location.ipl.exitDoorCoords,
        radius = 1.5,
        debug = false,
        options = {
            {
                name = zoneName .. '_temp',
                label = 'Sortir temporairement',
                icon = 'fas fa-door-open',
                onSelect = function()
                    TemporaryExit(locationIndex)
                end
            },
            {
                name = zoneName .. '_end',
                label = 'Arrêter le braquage',
                icon = 'fas fa-times-circle',
                onSelect = function()
                    EndRobbery(locationIndex)
                end
            }
        }
    })

    -- Stocker le nom de la zone pour la supprimer plus tard
    currentExitZone = zoneName
end

-- Fonction pour sortir temporairement (pour déposer objets lourds dans véhicule)
function TemporaryExit(locationIndex)
    local location = Config.Locations[locationIndex]
    local playerPed = PlayerPedId()

    DoScreenFadeOut(1000)
    Wait(1000)

    -- Téléporter à la porte extérieure
    SetEntityCoords(playerPed, location.doorCoords.x, location.doorCoords.y, location.doorCoords.z)
    SetEntityHeading(playerPed, location.doorHeading)

    isOutside = true

    Wait(500)
    DoScreenFadeIn(1000)

    -- Créer une zone pour rentrer à nouveau
    local reenterZoneName = 'zcambu_reenter_' .. locationIndex
    exports.ox_target:addSphereZone({
        coords = location.doorCoords,
        radius = 1.5,
        debug = false,
        options = {
            {
                name = reenterZoneName,
                label = 'Rentrer dans la maison',
                icon = 'fas fa-door-closed',
                onSelect = function()
                    ReenterRobbery(locationIndex)
                end
            }
        }
    })

    reenterZone = reenterZoneName

    lib.notify({
        title = 'Sortie temporaire',
        description = 'Vous pouvez rentrer à nouveau. Timer continue !',
        type = 'info'
    })
end

-- Fonction pour rentrer à nouveau dans la maison
function ReenterRobbery(locationIndex)
    local location = Config.Locations[locationIndex]
    local playerPed = PlayerPedId()

    -- Supprimer la zone de rentrée
    if reenterZone then
        exports.ox_target:removeZone(reenterZone)
        reenterZone = nil
    end

    DoScreenFadeOut(1000)
    Wait(1000)

    -- Téléporter à l'intérieur
    SetEntityCoords(playerPed, location.ipl.interior.x, location.ipl.interior.y, location.ipl.interior.z)

    isOutside = false

    Wait(500)
    DoScreenFadeIn(1000)

    lib.notify({
        title = 'De retour',
        description = 'Vous êtes rentré dans la maison',
        type = 'success'
    })
end

-- Fonction pour terminer le braquage (définitif)
function EndRobbery(locationIndex)
    local location = Config.Locations[locationIndex]
    local playerPed = PlayerPedId()

    DoScreenFadeOut(1000)
    Wait(1000)

    -- Nettoyer l'objet porté
    if carryingObject then
        -- Détacher et supprimer le prop
        if carryingProp and DoesEntityExist(carryingProp) then
            DetachEntity(carryingProp, true, true)
            DeleteObject(carryingProp)
        end

        -- Réinitialiser l'état du joueur
        SetPedMoveRateOverride(playerPed, 1.0)
        ClearPedTasks(playerPed)
        ClearPedSecondaryTask(playerPed)

        -- L'objet est déjà dans l'inventaire, on nettoie juste les variables
        carryingObject = nil
        carryingProp = nil
    end

    -- TP à la sortie
    SetEntityCoords(playerPed, location.doorCoords.x, location.doorCoords.y, location.doorCoords.z)
    SetEntityHeading(playerPed, location.doorHeading)

    Wait(500)
    DoScreenFadeIn(1000)

    -- Nettoyer les zones ox_target restantes
    for _, prop in pairs(collectedProps) do
        if prop.zoneName and not prop.collected then
            exports.ox_target:removeZone(prop.zoneName)
        end
    end
    collectedProps = {}

    -- Supprimer la zone de sortie
    if currentExitZone then
        exports.ox_target:removeZone(currentExitZone)
        currentExitZone = nil
    end

    -- Supprimer la zone de rentrée si elle existe
    if reenterZone then
        exports.ox_target:removeZone(reenterZone)
        reenterZone = nil
    end

    robberyActive = false
    isOutside = false

    -- NE PAS recréer la zone d'entrée (cooldown géré par le serveur)
    -- CreateEntryZone(locationIndex) -- SUPPRIMÉ pour éviter les re-entrées

    -- Notifier le serveur
    TriggerServerEvent('zcambu:endRobbery')

    lib.notify({
        title = 'Braquage terminé',
        description = 'Vous avez quitté le braquage',
        type = 'success'
    })
end

-- Fonction pour sortir du braquage (appelée par le timer)
function ExitRobbery(locationIndex)
    -- Appeler la fonction EndRobbery
    EndRobbery(locationIndex)
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
        exports.ox_target:removeZone(entryZones[locationIndex])
        entryZones[locationIndex] = nil
    end
end

-- Initialisation des zones ox_target et blips
CreateThread(function()
    for index, location in ipairs(Config.Locations) do
        -- NE PAS créer de zone d'entrée automatiquement au démarrage
        -- La zone sera créée uniquement quand le joueur peut braquer (pas de cooldown)
        -- CreateEntryZone(index) -- SUPPRIMÉ

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

-- Thread pour gérer les zones d'entrée dynamiques (avec cooldown)
CreateThread(function()
    while true do
        Wait(1000) -- Vérifier toutes les secondes

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        -- Si un braquage est actif, ne rien faire
        if not robberyActive then
            -- Vérifier chaque location
            for index, location in ipairs(Config.Locations) do
                local distance = #(playerCoords - location.doorCoords)

                -- Si le joueur est proche de la porte (< 10m)
                if distance < 10.0 then
                    -- Vérifier si la zone existe déjà
                    if not entryZones[index] then
                        -- Vérifier le cooldown côté serveur avant de créer la zone
                        ESX.TriggerServerCallback('zcambu:canShowEntryZone', function(canShow)
                            if canShow and not entryZones[index] and not robberyActive then
                                CreateEntryZone(index)
                            end
                        end, index)
                    end
                else
                    -- Si le joueur est loin, supprimer la zone pour économiser les ressources
                    if entryZones[index] then
                        RemoveEntryZone(index)
                    end
                end
            end
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

    if carryingProp and DoesEntityExist(carryingProp) then
        DeleteObject(carryingProp)
    end

    lib.hideTextUI()
end)
