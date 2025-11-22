local ESX = exports['es_extended']:getSharedObject()
local currentRobbery = nil
local robberyActive = false
local carryingObject = nil
local carryingProp = nil
local timeRemaining = 0
local collectedProps = {}

-- Variables pour la gestion des zones
local targetZones = {}

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
    StartRobberyTimer()

    -- Spawner les props
    SpawnRobberyProps(locationIndex, robberyType)

    -- Créer la zone de sortie
    CreateExitZone(locationIndex)
end

-- Fonction pour le timer
function StartRobberyTimer()
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
        end
    end)
end

-- Fonction pour spawner les props
function SpawnRobberyProps(locationIndex, robberyType)
    local location = Config.Locations[locationIndex]
    local props = location.props[robberyType]

    for i, prop in ipairs(props) do
        local propHash = GetHashKey(prop.model)
        lib.requestModel(propHash, 5000)

        local propObj = CreateObject(propHash, prop.coords.x, prop.coords.y, prop.coords.z, false, false, false)
        FreezeEntityPosition(propObj, true)
        SetEntityAsMissionEntity(propObj, true, true)

        -- Créer l'interaction ox_target
        exports.ox_target:addLocalEntity(propObj, {
            {
                name = 'collect_prop_' .. i,
                label = 'Récupérer ' .. prop.name,
                icon = 'fas fa-hand-paper',
                distance = 2.0,
                onSelect = function()
                    CollectProp(locationIndex, robberyType, i, propObj, prop)
                end
            }
        })

        table.insert(collectedProps, {
            object = propObj,
            collected = false
        })
    end
end

-- Fonction pour collecter un prop
function CollectProp(locationIndex, robberyType, propIndex, propObj, propData)
    local playerPed = PlayerPedId()

    -- Vérifier si le joueur porte déjà un objet lourd
    if carryingObject then
        lib.notify({
            title = 'Erreur',
            description = 'Vous portez déjà un objet',
            type = 'error'
        })
        return
    end

    -- Animation de récupération
    lib.requestAnimDict('pickup_object', 5000)
    TaskPlayAnim(playerPed, 'pickup_object', 'pickup_low', 8.0, -8.0, 1000, 0, 0, false, false, false)

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
        -- Supprimer le prop du monde
        DeleteObject(propObj)
        collectedProps[propIndex].collected = true

        if propData.heavy then
            -- Objet lourd : le joueur doit le porter
            AttachHeavyObject(propData)
            lib.notify({
                title = 'Objet lourd',
                description = Config.Locales['put_in_trunk'],
                type = 'warning'
            })
        else
            -- Objet léger : ajout direct à l'inventaire
            TriggerServerEvent('zcambu:collectItem', robberyType, propIndex)
            lib.notify({
                title = 'Collecté',
                description = Config.Locales['item_picked_up'],
                type = 'success'
            })
        end
    else
        lib.notify({
            title = 'Annulé',
            description = Config.Locales['cancelled'],
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
    AttachEntityToEntity(carryingProp, playerPed, GetPedBoneIndex(playerPed, 60309), 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    -- Charger l'animation de portage
    lib.requestAnimDict(Config.Animations.carry.dict, 5000)
    TaskPlayAnim(playerPed, Config.Animations.carry.dict, Config.Animations.carry.anim, 8.0, -8.0, -1, Config.Animations.carry.flag, 0, false, false, false)

    -- Réduire la vitesse de marche
    SetPedMoveRateOverride(playerPed, Config.HeavyObjectSpeed.walkSpeed)

    -- Ajouter ox_target sur les véhicules pour déposer
    CreateThread(function()
        while carryingObject do
            Wait(1000)
            local coords = GetEntityCoords(playerPed)
            local vehicles = lib.getNearbyVehicles(coords, 10.0, true)

            for _, vehicle in pairs(vehicles) do
                local vehNetId = NetworkGetNetworkIdFromEntity(vehicle.vehicle)

                -- Ajouter target seulement si pas déjà ajouté
                exports.ox_target:addLocalEntity(vehicle.vehicle, {
                    {
                        name = 'deposit_heavy_item_' .. vehNetId,
                        label = 'Déposer dans le coffre',
                        icon = 'fas fa-box',
                        distance = 3.0,
                        onSelect = function()
                            DepositHeavyObject(vehicle.vehicle)
                        end
                    }
                })
            end
        end

        -- Nettoyer les targets quand on ne porte plus rien
        local coords = GetEntityCoords(playerPed)
        local vehicles = lib.getNearbyVehicles(coords, 10.0, true)
        for _, vehicle in pairs(vehicles) do
            exports.ox_target:removeLocalEntity(vehicle.vehicle, 'deposit_heavy_item_' .. NetworkGetNetworkIdFromEntity(vehicle.vehicle))
        end
    end)

    -- Thread pour empêcher certaines actions
    CreateThread(function()
        while carryingObject do
            Wait(0)
            DisableControlAction(0, 24, true) -- Attaque
            DisableControlAction(0, 25, true) -- Viser
            DisableControlAction(0, 47, true) -- Arme
            DisableControlAction(0, 58, true) -- Arme
            DisableControlAction(0, 140, true) -- Combat léger
            DisableControlAction(0, 141, true) -- Combat moyen
            DisableControlAction(0, 142, true) -- Combat lourd
            DisableControlAction(0, 143, true) -- Combat alternatif
            DisableControlAction(0, 263, true) -- Mêlée 1
            DisableControlAction(0, 264, true) -- Mêlée 2
            DisableControlAction(0, 257, true) -- Mêlée 3

            -- Empêcher de sprinter
            if IsPedSprinting(playerPed) then
                SetPedMoveRateOverride(playerPed, Config.HeavyObjectSpeed.runSpeed)
            end
        end
    end)
end

-- Fonction pour déposer un objet lourd dans le coffre
function DepositHeavyObject(vehicle)
    if not carryingObject then return end

    local playerPed = PlayerPedId()

    -- Animation de dépôt
    if lib.progressBar({
        duration = 2000,
        label = 'Dépôt dans le coffre...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true
        }
    }) then
        -- Détacher et supprimer le prop
        if DoesEntityExist(carryingProp) then
            DetachEntity(carryingProp, true, true)
            DeleteObject(carryingProp)
        end
        carryingProp = nil

        -- Réinitialiser la vitesse
        SetPedMoveRateOverride(playerPed, 1.0)
        ClearPedTasks(playerPed)

        -- Donner la récompense
        TriggerServerEvent('zcambu:depositHeavyItem', carryingObject)

        -- Nettoyer les targets
        local coords = GetEntityCoords(playerPed)
        local vehicles = lib.getNearbyVehicles(coords, 10.0, true)
        for _, veh in pairs(vehicles) do
            exports.ox_target:removeLocalEntity(veh.vehicle, 'deposit_heavy_item_' .. NetworkGetNetworkIdFromEntity(veh.vehicle))
        end

        carryingObject = nil

        lib.notify({
            title = 'Déposé',
            description = 'Objet déposé dans le coffre',
            type = 'success'
        })
    end
end

-- Fonction pour créer la zone de sortie
function CreateExitZone(locationIndex)
    local location = Config.Locations[locationIndex]

    -- Créer un point de sortie
    local exitPoint = lib.points.new({
        coords = location.ipl.exit,
        distance = 2.0,
        onEnter = function()
            lib.showTextUI('[E] Sortir du bâtiment', {
                position = 'left-center',
                icon = 'door-open'
            })
        end,
        onExit = function()
            lib.hideTextUI()
        end,
        nearby = function()
            if IsControlJustPressed(0, 38) then -- E
                ExitRobbery(locationIndex)
            end

            -- Option pour déposer l'objet lourd
            if carryingObject then
                if IsControlJustPressed(0, 47) then -- G
                    DepositHeavyObject()
                end

                lib.showTextUI('[E] Sortir | [G] Déposer dans le coffre', {
                    position = 'left-center',
                    icon = 'door-open'
                })
            end
        end
    })
end

-- Fonction pour sortir du braquage
function ExitRobbery(locationIndex)
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

        -- Nettoyer les targets de véhicules
        local coords = GetEntityCoords(playerPed)
        local vehicles = lib.getNearbyVehicles(coords, 20.0, true)
        for _, veh in pairs(vehicles) do
            local vehNetId = NetworkGetNetworkIdFromEntity(veh.vehicle)
            pcall(function()
                exports.ox_target:removeLocalEntity(veh.vehicle, 'deposit_heavy_item_' .. vehNetId)
            end)
        end

        -- Donner l'objet au joueur automatiquement
        TriggerServerEvent('zcambu:depositHeavyItem', carryingObject)

        carryingObject = nil
        carryingProp = nil
    end

    -- TP à la sortie
    SetEntityCoords(playerPed, location.doorCoords.x, location.doorCoords.y, location.doorCoords.z)
    SetEntityHeading(playerPed, location.doorHeading)

    Wait(500)
    DoScreenFadeIn(1000)

    -- Nettoyer les props restants
    for _, prop in pairs(collectedProps) do
        if prop.object and DoesEntityExist(prop.object) then
            DeleteObject(prop.object)
        end
    end
    collectedProps = {}

    lib.hideTextUI()

    robberyActive = false

    -- Notifier le serveur
    TriggerServerEvent('zcambu:endRobbery')

    lib.notify({
        title = 'Cambriolage',
        description = Config.Locales['robbery_complete'],
        type = 'success'
    })
end

-- Initialisation des zones ox_target
CreateThread(function()
    for index, location in ipairs(Config.Locations) do
        -- Créer la zone ox_target sur la porte
        exports.ox_target:addBoxZone({
            coords = location.doorCoords,
            size = vec3(2, 2, 2),
            rotation = location.doorHeading,
            debug = Config.Debug,
            options = {
                {
                    name = 'robbery_door_' .. index,
                    label = 'Cambrioler ' .. location.name,
                    icon = 'fas fa-mask',
                    distance = 2.0,
                    onSelect = function()
                        currentRobbery = index
                        OpenRobberyUI(index)
                    end
                }
            }
        })

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

-- Commande pour déposer un objet lourd (alternative)
RegisterCommand('deposer', function()
    if carryingObject then
        DepositHeavyObject()
    else
        lib.notify({
            title = 'Erreur',
            description = 'Vous ne portez aucun objet',
            type = 'error'
        })
    end
end, false)

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
