local ESX = exports['es_extended']:getSharedObject()
local robberyCD = {} -- Cooldown par joueur
local activeRobberies = {} -- Braquages actifs

-- Fonction pour vérifier le nombre de policiers
local function GetPoliceCount()
    local count = 0
    local players = ESX.GetExtendedPlayers('job', Config.PoliceJobName)
    return #players
end

-- Callback pour vérifier si le joueur peut commencer un braquage
ESX.RegisterServerCallback('zcambu:canStartRobbery', function(source, cb, locationIndex, robberyType)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        cb(false, 'Erreur joueur')
        return
    end

    -- Vérifier le cooldown
    if robberyCD[xPlayer.identifier] and os.time() < robberyCD[xPlayer.identifier] then
        local timeLeft = robberyCD[xPlayer.identifier] - os.time()
        cb(false, string.format('Vous devez attendre encore %d minutes', math.ceil(timeLeft / 60)))
        return
    end

    -- Vérifier le nombre de policiers
    if GetPoliceCount() < Config.MinPoliceOnline then
        cb(false, Config.Locales['not_enough_police'])
        return
    end

    -- Vérifier l'item requis
    local requiredItem = robberyType == 'easy' and Config.Items.easy or Config.Items.hard
    local itemCount = exports.ox_inventory:Search(source, 'count', requiredItem)

    if itemCount < 1 then
        local message = robberyType == 'easy' and Config.Locales['lockpick_needed'] or Config.Locales['advanced_lockpick_needed']
        cb(false, message)
        return
    end

    -- Retirer l'item (le crochet se casse)
    exports.ox_inventory:RemoveItem(source, requiredItem, 1)

    -- Définir le cooldown
    robberyCD[xPlayer.identifier] = os.time() + Config.CooldownTime

    -- Enregistrer le braquage actif
    activeRobberies[source] = {
        locationIndex = locationIndex,
        robberyType = robberyType,
        startTime = os.time()
    }

    cb(true)
end)

-- Event pour collecter un item léger
RegisterNetEvent('zcambu:collectItem', function(robberyType, propIndex)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer or not activeRobberies[source] then
        return
    end

    local robbery = activeRobberies[source]
    local location = Config.Locations[robbery.locationIndex]
    local prop = location.props[robberyType][propIndex]

    if not prop then
        return
    end

    -- Donner la récompense (léger OU lourd)
    local amount = math.random(prop.amount[1], prop.amount[2])

    if prop.reward == 'black_money' then
        local account = xPlayer.getAccount('black_money')
        if account then
            xPlayer.addAccountMoney('black_money', amount)
        end
    else
        exports.ox_inventory:AddItem(source, prop.reward, amount)
    end

    -- Log
    if Config.Debug then
        local heavyText = prop.heavy and ' (LOURD)' or ''
        print(string.format('[ZCAMBU] %s a collecté %dx %s%s', xPlayer.getName(), amount, prop.reward, heavyText))
    end
end)


-- Event pour terminer le braquage
RegisterNetEvent('zcambu:endRobbery', function()
    local source = source

    if activeRobberies[source] then
        -- Log
        if Config.Debug then
            local xPlayer = ESX.GetPlayerFromId(source)
            local duration = os.time() - activeRobberies[source].startTime
            print(string.format('[ZCAMBU] %s a terminé un braquage (durée: %ds)', xPlayer.getName(), duration))
        end

        activeRobberies[source] = nil
    end
end)

-- Nettoyage à la déconnexion
AddEventHandler('playerDropped', function()
    local source = source
    if activeRobberies[source] then
        activeRobberies[source] = nil
    end
end)

-- Commande admin pour reset le cooldown
ESX.RegisterCommand('resetcooldown', 'admin', function(xPlayer, args, showError)
    local targetId = args.playerId

    if not targetId then
        xPlayer.showNotification('Usage: /resetcooldown [player id]')
        return
    end

    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        xPlayer.showNotification('Joueur introuvable')
        return
    end

    robberyCD[xTarget.identifier] = nil
    xPlayer.showNotification(string.format('Cooldown reset pour %s', xTarget.getName()))
    xTarget.showNotification('Votre cooldown de cambriolage a été reset')
end, false, {help = 'Reset le cooldown de cambriolage d\'un joueur', validate = true, arguments = {
    {name = 'playerId', help = 'ID du joueur', type = 'number'}
}})

-- Logs au démarrage
CreateThread(function()
    Wait(1000)
    print('^2[ZCAMBU]^7 Script de cambriolage démarré')
    print(string.format('^2[ZCAMBU]^7 %d locations chargées', #Config.Locations))
end)
