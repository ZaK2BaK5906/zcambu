Config = {}

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
        props = {
            easy = {
                {name = 'Sac de bijoux', model = 'prop_cs_heist_bag_01', coords = vector3(-16.5, -1443.5, 31.6), reward = 'jewel', amount = {5, 10}, heavy = false},
                {name = 'Argent liquide', model = 'hei_prop_heist_cash_pile', coords = vector3(-13.5, -1441.0, 32.1), reward = 'black_money', amount = {500, 1000}, heavy = false},
                {name = 'Tablette', model = 'prop_cs_tablet_01', coords = vector3(-17.2, -1438.8, 31.6), reward = 'laptop', amount = {1, 1}, heavy = false}
            },
            hard = {
                {name = 'Sac de bijoux', model = 'prop_cs_heist_bag_01', coords = vector3(-16.5, -1443.5, 31.6), reward = 'jewel', amount = {5, 10}, heavy = false},
                {name = 'Argent liquide', model = 'hei_prop_heist_cash_pile', coords = vector3(-13.5, -1441.0, 32.1), reward = 'black_money', amount = {500, 1000}, heavy = false},
                {name = 'Tablette', model = 'prop_cs_tablet_01', coords = vector3(-17.2, -1438.8, 31.6), reward = 'laptop', amount = {1, 1}, heavy = false},
                {name = 'Caisse de valeur', model = 'prop_box_wood02a', coords = vector3(-11.8, -1437.5, 32.5), reward = 'painting', amount = {1, 1}, heavy = true},
                {name = 'Valise d\'or', model = 'prop_ld_case_01', coords = vector3(-19.5, -1440.2, 30.6), reward = 'gold_bar', amount = {2, 4}, heavy = true}
            }
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
        props = {
            easy = {
                {name = 'Argent liquide', model = 'hei_prop_heist_cash_pile', coords = vector3(-173.5, 493.2, 138.0), reward = 'black_money', amount = {800, 1500}, heavy = false},
                {name = 'Sac de bijoux', model = 'prop_cs_heist_bag_01', coords = vector3(-169.8, 490.5, 138.2), reward = 'jewel', amount = {8, 15}, heavy = false},
                {name = 'Tablette', model = 'prop_cs_tablet_01', coords = vector3(-171.2, 495.8, 137.9), reward = 'laptop', amount = {1, 1}, heavy = false}
            },
            hard = {
                {name = 'Argent liquide', model = 'hei_prop_heist_cash_pile', coords = vector3(-173.5, 493.2, 138.0), reward = 'black_money', amount = {800, 1500}, heavy = false},
                {name = 'Sac de bijoux', model = 'prop_cs_heist_bag_01', coords = vector3(-169.8, 490.5, 138.2), reward = 'jewel', amount = {8, 15}, heavy = false},
                {name = 'Tablette', model = 'prop_cs_tablet_01', coords = vector3(-171.2, 495.8, 137.9), reward = 'laptop', amount = {1, 1}, heavy = false},
                {name = 'Boîte antique', model = 'v_res_tre_storagebox', coords = vector3(-175.2, 491.5, 137.4), reward = 'antique_sculpture', amount = {1, 1}, heavy = true},
                {name = 'Grand sac', model = 'prop_big_bag_01', coords = vector3(-167.8, 489.2, 136.9), reward = 'diamond', amount = {3, 6}, heavy = true},
                {name = 'Caisse de valeur', model = 'prop_box_wood02a', coords = vector3(-172.5, 488.8, 138.5), reward = 'rare_painting', amount = {1, 1}, heavy = true}
            }
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
        props = {
            easy = {
                {name = 'Tablette', model = 'prop_cs_tablet_01', coords = vector3(-781.5, 316.2, 86.3), reward = 'laptop', amount = {1, 1}, heavy = false},
                {name = 'Argent', model = 'hei_prop_heist_cash_pile', coords = vector3(-779.2, 313.5, 86.2), reward = 'black_money', amount = {600, 1200}, heavy = false},
                {name = 'Sac de bijoux', model = 'prop_cs_heist_bag_01', coords = vector3(-782.8, 318.9, 86.0), reward = 'jewel', amount = {5, 8}, heavy = false}
            },
            hard = {
                {name = 'Tablette', model = 'prop_cs_tablet_01', coords = vector3(-781.5, 316.2, 86.3), reward = 'laptop', amount = {1, 1}, heavy = false},
                {name = 'Argent', model = 'hei_prop_heist_cash_pile', coords = vector3(-779.2, 313.5, 86.2), reward = 'black_money', amount = {600, 1200}, heavy = false},
                {name = 'Sac de bijoux', model = 'prop_cs_heist_bag_01', coords = vector3(-782.8, 318.9, 86.0), reward = 'jewel', amount = {5, 8}, heavy = false},
                {name = 'Valise d\'or', model = 'prop_ld_case_01', coords = vector3(-783.5, 312.8, 85.2), reward = 'gold_bar', amount = {3, 5}, heavy = true},
                {name = 'Boîte de stockage', model = 'v_res_tre_storagebox', coords = vector3(-780.5, 319.5, 86.8), reward = 'diamond', amount = {2, 4}, heavy = true}
            }
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
