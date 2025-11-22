Config = {}

--[[
    PROPS DISPONIBLES (100% testés et fonctionnels)

    SYSTÈME DE SPAWN ALÉATOIRE :
    - Braquage FACILE : 10 objets légers aléatoires
    - Braquage DIFFICILE : 4 objets légers + 6 objets lourds aléatoires

    Les props sont choisis aléatoirement dans la liste ci-dessous
    et spawnés aux positions définies pour chaque location
]]--

-- LISTE DES PROPS DISPONIBLES (SANS MARQUES - Objets réalistes de maison)
Config.AvailableProps = {
    -- OBJETS LÉGERS (pour facile ET difficile) - Petits objets de valeur
    light = {
        {name = 'Smartphone', model = 'rm-phone-1', reward = 'smartphone', amount = {1, 1}},
        {name = 'Écouteurs Bluetooth', model = 'rm-appleheadset-1', reward = 'bluetooth_earbuds', amount = {1, 1}},
        {name = 'Casquette', model = 'rm-cap-1', reward = 'cap', amount = {1, 1}},
        {name = 'Chaussures sport', model = 'rm-yeezyslide', reward = 'sport_shoes', amount = {1, 1}},
        {name = 'Vape', model = 'rm-vape-1', reward = 'vape', amount = {1, 1}},
        {name = 'Bouteille eau', model = 'rm-fiji-bottle', reward = 'water_bottle', amount = {2, 4}},
        {name = 'Petite liasse', model = 'rm-cashspread-1', reward = 'black_money', amount = {150, 350}},
        {name = 'Stack de billets', model = 'rm-dollarstack-1', reward = 'black_money', amount = {200, 450}},
        {name = 'Skateboard', model = 'rm-skate-1', reward = 'skateboard', amount = {1, 1}},
        {name = 'Console portable', model = 'rm-switch', reward = 'handheld_console', amount = {1, 1}},
        {name = 'Briquet deluxe', model = 'rm-bic-1', reward = 'lighter_deluxe', amount = {1, 1}},
        {name = 'Télécommande TV', model = 'rm-backwoods-1', reward = 'remote_control', amount = {1, 1}},
        {name = 'Clé USB', model = 'rm-usb', reward = 'usb_key', amount = {1, 1}},
        {name = 'Fausse montre', model = 'rm-watch-generic', reward = 'fake_watch', amount = {1, 1}},
        {name = 'Tablette tactile', model = 'rm-tablet', reward = 'tablet', amount = {1, 1}},
        {name = 'Appareil photo', model = 'rm-camera', reward = 'camera', amount = {1, 1}},
        {name = 'Manette de jeu', model = 'rm-controller', reward = 'game_controller', amount = {1, 1}},
        {name = 'Enceinte Bluetooth', model = 'rm-speaker', reward = 'bluetooth_speaker', amount = {1, 1}},
        {name = 'Chargeur portable', model = 'rm-powerbank', reward = 'powerbank', amount = {1, 1}},
        {name = 'Calculatrice', model = 'rm-calculator', reward = 'calculator', amount = {1, 1}},
    },

    -- OBJETS LOURDS (uniquement pour difficile) - Électronique et meubles
    heavy = {
        {name = 'Console de jeux', model = 'rm-ps5', reward = 'game_console', amount = {1, 1}},
        {name = 'Console de jeux Pro', model = 'rm-ps4', reward = 'game_console_pro', amount = {1, 1}},
        {name = 'Console rétro', model = 'rm-xbox', reward = 'retro_console', amount = {1, 1}},
        {name = 'Ordinateur portable', model = 'rm-mac', reward = 'laptop', amount = {1, 1}},
        {name = 'Setup Gaming', model = 'rm-screensetup', reward = 'gaming_setup', amount = {1, 1}},
        {name = 'Télévision', model = 'rm-tv', reward = 'television', amount = {1, 1}},
        {name = 'Micro-ondes', model = 'rm-microwave', reward = 'microwave', amount = {1, 1}},
        {name = 'Chaise design', model = 'rm-chair', reward = 'designer_chair', amount = {1, 1}},
        {name = 'Grand sac voyage', model = 'rm-bag-travel', reward = 'travel_bag', amount = {1, 1}},
        {name = 'Grosse liasse', model = 'rm-money-pile-1', reward = 'black_money', amount = {800, 1500}},
    }
}

-- Nombre d'objets par type de braquage
Config.PropsCount = {
    easy = {
        light = 10, -- 10 objets légers
        heavy = 0   -- 0 objets lourds
    },
    hard = {
        light = 4,  -- 4 objets légers
        heavy = 6   -- 6 objets lourds
    }
}

-- Paramètres généraux
Config.Debug = false
Config.RobberyTimer = 180 -- Durée du braquage en secondes (3 minutes)
Config.CooldownTime = 1800 -- Temps d'attente entre deux braquages (30 minutes)
Config.PoliceJobName = 'police'
Config.MinPoliceOnline = 0 -- Nombre minimum de policiers requis

-- Items requis
Config.Items = {
    easy = 'lockpick', -- Crochet pour braquage facile
    hard = 'lockpick_advanced' -- Crochet amélioré pour braquage difficile
}

-- Vitesse de marche avec objet lourd (1.0 = normal, 0.5 = 50% plus lent)
Config.HeavyObjectSpeed = {
    walkSpeed = 0.5,  -- Marche à 50% de la vitesse normale
    runSpeed = 0.5    -- Pas de sprint, même vitesse que la marche
}

-- Animations
Config.Animations = {
    cinematic = {
        dict = 'anim@heists@ornate_bank@grab_cash',
        anim = 'intro',
        duration = 3000
    },
    carry = {
        dict = 'anim@heists@box_carry@',
        anim = 'idle',
        flag = 49
    }
}

-- Attachement du prop dans les mains (AJUSTABLE)
Config.PropAttachment = {
    bone = 60309, -- IK_R_Hand (main droite)
    offset = {
        x = 0.05,  -- Devant/Derrière (+ = devant, - = derrière)
        y = 0.05,  -- Gauche/Droite (+ = droite, - = gauche)
        z = 0.0    -- Haut/Bas (+ = haut, - = bas)
    },
    rotation = {
        pitch = 0.0,  -- Rotation X
        roll = 90.0,  -- Rotation Y (90 = tourné de côté)
        yaw = 0.0     -- Rotation Z
    }
}

-- Locations de braquage
Config.Locations = {
    -- Maison Grove Street
    {
        name = 'Maison Grove Street',
        doorCoords = vector3(-9.35, -1438.51, 31.10),
        doorHeading = 180.0,
        blip = {
            sprite = 40,
            color = 1,
            scale = 0.8,
            label = 'Maison à cambrioler'
        },
        ipl = {
            name = 'FranklinHouse',
            enter = vector3(-9.35, -1438.51, 31.10),
            exit = vector3(-14.53, -1440.10, 31.10),
            interior = vector3(-13.5, -1439.5, 31.1),
            exitDoorCoords = vector3(-14.53, -1440.10, 31.10) -- Porte intérieure pour sortir
        },
        -- POSITIONS DE SPAWN (10 objets max)
        spawnPositions = {
            vector3(-11.5318, -1431.8981, 31.1168),
            vector3(-12.1142, -1433.9563, 31.1018),
            vector3(-11.3585, -1429.7806, 31.1015),
            vector3(-13.1412, -1428.7836, 31.1015),
            vector3(-17.6738, -1439.6672, 31.1016),
            vector3(-10.5, -1430.5, 31.1),
            vector3(-14.2, -1436.8, 31.1),
            vector3(-15.5, -1438.2, 31.1),
            vector3(-9.5, -1432.8, 31.1),
            vector3(-19.2, -1438.5, 31.1)
        },
        requiredItem = {
            easy = 'lockpick',
            hard = 'lockpick_advanced'
        }
    },

    -- Maison Vinewood Hills
    {
        name = 'Villa Vinewood',
        doorCoords = vector3(-174.35, 502.66, 137.42),
        doorHeading = 190.0,
        blip = {
            sprite = 40,
            color = 1,
            scale = 0.8,
            label = 'Villa à cambrioler'
        },
        ipl = {
            name = 'VinewoodHouse',
            enter = vector3(-174.35, 502.66, 137.42),
            exit = vector3(-168.52, 487.93, 137.44),
            interior = vector3(-170.0, 493.0, 137.4),
            exitDoorCoords = vector3(-168.52, 487.93, 137.44) -- Porte intérieure pour sortir
        },
        spawnPositions = {
            vector3(-173.5, 493.2, 137.4),
            vector3(-169.8, 490.5, 137.4),
            vector3(-171.2, 495.8, 137.4),
            vector3(-175.2, 491.5, 137.4),
            vector3(-167.8, 489.2, 137.4),
            vector3(-172.5, 488.8, 137.4),
            vector3(-170.5, 492.1, 137.4),
            vector3(-174.1, 494.3, 137.4),
            vector3(-168.9, 493.7, 137.4),
            vector3(-176.2, 489.8, 137.4)
        },
        requiredItem = {
            easy = 'lockpick',
            hard = 'lockpick_advanced'
        }
    },

    -- Appartement Eclipse Towers
    {
        name = 'Appartement Eclipse',
        doorCoords = vector3(-773.41, 312.45, 85.70),
        doorHeading = 270.0,
        blip = {
            sprite = 40,
            color = 1,
            scale = 0.8,
            label = 'Appartement à cambrioler'
        },
        ipl = {
            name = 'EclipseApartment',
            enter = vector3(-773.41, 312.45, 85.70),
            exit = vector3(-777.12, 319.78, 85.66),
            interior = vector3(-780.0, 315.0, 85.7),
            exitDoorCoords = vector3(-777.12, 319.78, 85.66) -- Porte intérieure pour sortir
        },
        spawnPositions = {
            vector3(-781.5, 316.2, 85.7),
            vector3(-779.2, 313.5, 85.7),
            vector3(-782.8, 318.9, 85.7),
            vector3(-783.5, 312.8, 85.7),
            vector3(-780.5, 319.5, 85.7),
            vector3(-778.9, 314.8, 85.7),
            vector3(-782.1, 317.3, 85.7),
            vector3(-784.2, 315.6, 85.7),
            vector3(-779.7, 318.2, 85.7),
            vector3(-781.8, 313.9, 85.7)
        },
        requiredItem = {
            easy = 'lockpick',
            hard = 'lockpick_advanced'
        }
    }
}

-- Messages
Config.Locales = {
    ['no_item'] = 'Vous n\'avez pas l\'objet requis',
    ['lockpick_needed'] = 'Vous avez besoin d\'un crochet',
    ['advanced_lockpick_needed'] = 'Vous avez besoin d\'un crochet amélioré',
    ['not_enough_police'] = 'Pas assez de policiers en service',
    ['robbery_in_progress'] = 'Cambriolage en cours',
    ['robbery_complete'] = 'Cambriolage terminé',
    ['robbery_failed'] = 'Cambriolage échoué',
    ['item_too_heavy'] = 'Cet objet est trop lourd, vous devez le porter',
    ['item_picked_up'] = 'Objet récupéré',
    ['put_in_trunk'] = 'Mettez l\'objet dans le coffre de votre véhicule',
    ['cooldown'] = 'Vous devez attendre avant de cambrioler à nouveau',
    ['cancelled'] = 'Action annulée'
}
