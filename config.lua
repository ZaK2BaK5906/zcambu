Config = {}

--[[
    PROPS DISPONIBLES (100% testés et fonctionnels)

    SYSTÈME DE SPAWN ALÉATOIRE :
    - Braquage FACILE : 10 objets légers aléatoires
    - Braquage DIFFICILE : 4 objets légers + 6 objets lourds aléatoires

    Les props sont choisis aléatoirement dans la liste ci-dessous
    et spawnés aux positions définies pour chaque location
]]--

-- LISTE DES PROPS DISPONIBLES (configurables)
Config.AvailableProps = {
    -- OBJETS LÉGERS (pour facile ET difficile)
    light = {
        {name = 'Petite liasse', model = 'prop_cash_pile_02', reward = 'black_money', amount = {120, 280}},
        {name = 'Chaîne en toc', model = 'prop_jewel_02a', reward = 'silver_chain', amount = {1, 1}},
        {name = 'Clé USB cryptée', model = 'prop_usb_drive_01', reward = 'usb_crypto', amount = {1, 1}},
        {name = 'Montre contrefaite', model = 'p_watch_03', reward = 'fake_watch', amount = {1, 1}},
        {name = 'Pochette billets', model = 'prop_money_bag_01', reward = 'dirty_cash_small', amount = {180, 250}},
        {name = 'Bracelet femme', model = 'prop_jewel_04b', reward = 'bracelet', amount = {1, 2}},
        {name = 'Oreillette volée', model = 'prop_cs_hand_radio', reward = 'earpiece', amount = {1, 1}},
        {name = 'Mini-tablette', model = 'prop_tablet_02', reward = 'tablet_mini', amount = {1, 1}},
        {name = 'Carte crypto', model = 'prop_credit_card_01', reward = 'crypto_card', amount = {1, 1}},
        {name = 'Porte-monnaie', model = 'prop_ld_wallet_01', reward = 'wallet', amount = {50, 120}},
        {name = 'Sacoche légère', model = 'prop_cs_shopping_bag', reward = 'light_bag', amount = {1, 2}},
        {name = 'Grosse liasse', model = 'prop_cash_case_01', reward = 'black_money', amount = {380, 700}},
        {name = 'Carte serveur', model = 'prop_raspberry_pi', reward = 'server_card', amount = {1, 1}},
        {name = 'Passeport volé', model = 'prop_ld_passcard_01', reward = 'fake_passport', amount = {1, 1}},
        {name = 'Tablette pro', model = 'prop_tablet_01', reward = 'tablet_pro', amount = {1, 1}},
        {name = 'Pièces anciennes', model = 'prop_coins_01', reward = 'old_coins', amount = {2, 5}},
        {name = 'Lingot argent', model = 'prop_ingot_01', reward = 'silver_bar', amount = {1, 2}},
        {name = 'Malette documents', model = 'prop_ld_case_01', reward = 'secret_docs', amount = {1, 1}},
        {name = 'Clé secrète', model = 'prop_cs_key_01', reward = 'diamond_key', amount = {1, 1}},
        {name = 'Disque dur chiffré', model = 'prop_cs_hard_drive', reward = 'encrypted_hdd', amount = {1, 1}},
    },

    -- OBJETS LOURDS (uniquement pour difficile)
    heavy = {
        {name = 'Coffre miniature', model = 'prop_ld_int_safe_01', reward = 'mini_safe', amount = {1, 1}},
        {name = 'Statue bronze', model = 'prop_bronze_horse', reward = 'bronze_statue', amount = {1, 1}},
        {name = 'TV Connecté', model = 'prop_tv_flat_01', reward = 'smart_tv', amount = {1, 1}},
        {name = 'Tableau ancien', model = 'prop_painting_01', reward = 'old_painting', amount = {1, 1}},
        {name = 'Canapé', model = 'prop_couch_01', reward = 'luxury_couch', amount = {1, 1}},
        {name = 'Box électronique', model = 'prop_elecbox_12', reward = 'tech_box', amount = {1, 1}},
        {name = 'Console de jeux', model = 'prop_arcade_01', reward = 'gaming_console', amount = {1, 1}},
        {name = 'Ordinateur Gamer', model = 'prop_dyn_pc_02', reward = 'gaming_pc', amount = {1, 1}},
        {name = 'Sac militaire', model = 'prop_cs_heist_bag_01', reward = 'military_bag', amount = {1, 1}},
        {name = 'Caisse lingots', model = 'hei_prop_heist_cash_pile', reward = 'gold_bar_box', amount = {1, 1}},
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

-- Vitesse de marche avec objet lourd
Config.HeavyObjectSpeed = {
    walkSpeed = 1.0,
    runSpeed = 2.0
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
            interior = vector3(-13.5, -1439.5, 31.1)
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
            interior = vector3(-170.0, 493.0, 137.4)
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
            interior = vector3(-780.0, 315.0, 85.7)
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
