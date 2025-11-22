Config = {}

--[[
    PROPS DISPONIBLES (100% testés et fonctionnels)

    Props validés qui marchent :
    - prop_cs_heist_bag_01     - Sac de braquage
    - hei_prop_heist_cash_pile - Pile d'argent
    - prop_cs_tablet_01        - Tablette

    OBJETS LOURDS :
    - Le joueur porte l'objet avec animation
    - L'objet est ajouté à l'inventaire
    - Le joueur NE PEUT RIEN faire d'autre (pas d'arme, pas courir)
    - Il doit le mettre dans son coffre de véhicule LUI-MÊME via ox_inventory
    - Il peut quand même sortir de l'instance (E)

    CONFIGURATION :
    - Braquage facile : 15 objets
    - Braquage difficile : 20 objets (dont 8 lourds)
    - Tous les objets sont configurables ci-dessous
]]--

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
            -- BRAQUAGE FACILE : 15 objets légers
            easy = {
                {name = 'Argent liquide 1', model = 'hei_prop_heist_cash_pile', coords = vector3(-11.5318, -1431.8981, 31.1168), reward = 'black_money', amount = {200, 400}, heavy = false},
                {name = 'Argent liquide 2', model = 'hei_prop_heist_cash_pile', coords = vector3(-12.1142, -1433.9563, 31.1018), reward = 'black_money', amount = {200, 400}, heavy = false},
                {name = 'Argent liquide 3', model = 'hei_prop_heist_cash_pile', coords = vector3(-11.3585, -1429.7806, 31.1015), reward = 'black_money', amount = {200, 400}, heavy = false},
                {name = 'Argent liquide 4', model = 'hei_prop_heist_cash_pile', coords = vector3(-13.1412, -1428.7836, 31.1015), reward = 'black_money', amount = {200, 400}, heavy = false},
                {name = 'Argent liquide 5', model = 'hei_prop_heist_cash_pile', coords = vector3(-17.6738, -1439.6672, 31.1016), reward = 'black_money', amount = {200, 400}, heavy = false},
                {name = 'Tablette 1', model = 'prop_cs_tablet_01', coords = vector3(-10.5, -1430.5, 31.1), reward = 'laptop', amount = {1, 1}, heavy = false},
                {name = 'Tablette 2', model = 'prop_cs_tablet_01', coords = vector3(-11.8, -1432.2, 31.1), reward = 'phone', amount = {1, 2}, heavy = false},
                {name = 'Tablette 3', model = 'prop_cs_tablet_01', coords = vector3(-13.5, -1434.5, 31.1), reward = 'phone', amount = {1, 2}, heavy = false},
                {name = 'Sac 1', model = 'prop_cs_heist_bag_01', coords = vector3(-14.2, -1436.8, 31.1), reward = 'jewel', amount = {3, 6}, heavy = false},
                {name = 'Sac 2', model = 'prop_cs_heist_bag_01', coords = vector3(-15.5, -1438.2, 31.1), reward = 'jewel', amount = {3, 6}, heavy = false},
                {name = 'Sac 3', model = 'prop_cs_heist_bag_01', coords = vector3(-16.8, -1437.5, 31.1), reward = 'jewel', amount = {3, 6}, heavy = false},
                {name = 'Sac 4', model = 'prop_cs_heist_bag_01', coords = vector3(-18.1, -1436.3, 31.1), reward = 'jewel', amount = {3, 6}, heavy = false},
                {name = 'Sac 5', model = 'prop_cs_heist_bag_01', coords = vector3(-12.5, -1435.7, 31.1), reward = 'jewel', amount = {3, 6}, heavy = false},
                {name = 'Sac 6', model = 'prop_cs_heist_bag_01', coords = vector3(-10.8, -1434.3, 31.1), reward = 'diamond', amount = {1, 3}, heavy = false},
                {name = 'Sac 7', model = 'prop_cs_heist_bag_01', coords = vector3(-9.5, -1432.8, 31.1), reward = 'diamond', amount = {1, 3}, heavy = false}
            },
            -- BRAQUAGE DIFFICILE : 20 objets (12 légers + 8 lourds)
            hard = {
                -- 12 objets légers
                {name = 'Argent 1', model = 'hei_prop_heist_cash_pile', coords = vector3(-11.5318, -1431.8981, 31.1168), reward = 'black_money', amount = {300, 600}, heavy = false},
                {name = 'Argent 2', model = 'hei_prop_heist_cash_pile', coords = vector3(-12.1142, -1433.9563, 31.1018), reward = 'black_money', amount = {300, 600}, heavy = false},
                {name = 'Argent 3', model = 'hei_prop_heist_cash_pile', coords = vector3(-11.3585, -1429.7806, 31.1015), reward = 'black_money', amount = {300, 600}, heavy = false},
                {name = 'Tablette 1', model = 'prop_cs_tablet_01', coords = vector3(-10.5, -1430.5, 31.1), reward = 'laptop', amount = {1, 1}, heavy = false},
                {name = 'Tablette 2', model = 'prop_cs_tablet_01', coords = vector3(-11.8, -1432.2, 31.1), reward = 'phone', amount = {1, 2}, heavy = false},
                {name = 'Tablette 3', model = 'prop_cs_tablet_01', coords = vector3(-13.5, -1434.5, 31.1), reward = 'phone', amount = {1, 2}, heavy = false},
                {name = 'Petit sac 1', model = 'prop_cs_heist_bag_01', coords = vector3(-14.2, -1436.8, 31.1), reward = 'jewel', amount = {5, 10}, heavy = false},
                {name = 'Petit sac 2', model = 'prop_cs_heist_bag_01', coords = vector3(-15.5, -1438.2, 31.1), reward = 'jewel', amount = {5, 10}, heavy = false},
                {name = 'Petit sac 3', model = 'prop_cs_heist_bag_01', coords = vector3(-16.8, -1437.5, 31.1), reward = 'jewel', amount = {5, 10}, heavy = false},
                {name = 'Petit sac 4', model = 'prop_cs_heist_bag_01', coords = vector3(-18.1, -1436.3, 31.1), reward = 'diamond', amount = {2, 4}, heavy = false},
                {name = 'Petit sac 5', model = 'prop_cs_heist_bag_01', coords = vector3(-12.5, -1435.7, 31.1), reward = 'diamond', amount = {2, 4}, heavy = false},
                {name = 'Petit sac 6', model = 'prop_cs_heist_bag_01', coords = vector3(-10.8, -1434.3, 31.1), reward = 'diamond', amount = {2, 4}, heavy = false},
                -- 8 objets LOURDS
                {name = 'GROS SAC 1', model = 'prop_cs_heist_bag_01', coords = vector3(-13.1412, -1428.7836, 31.1015), reward = 'gold_bar', amount = {1, 2}, heavy = true},
                {name = 'GROS SAC 2', model = 'prop_cs_heist_bag_01', coords = vector3(-17.6738, -1439.6672, 31.1016), reward = 'gold_bar', amount = {1, 2}, heavy = true},
                {name = 'GROS SAC 3', model = 'prop_cs_heist_bag_01', coords = vector3(-9.5, -1432.8, 31.1), reward = 'gold_bar', amount = {1, 2}, heavy = true},
                {name = 'GROS SAC 4', model = 'prop_cs_heist_bag_01', coords = vector3(-19.2, -1438.5, 31.1), reward = 'painting', amount = {1, 1}, heavy = true},
                {name = 'GROS SAC 5', model = 'prop_cs_heist_bag_01', coords = vector3(-8.8, -1431.2, 31.1), reward = 'painting', amount = {1, 1}, heavy = true},
                {name = 'GROS SAC 6', model = 'prop_cs_heist_bag_01', coords = vector3(-20.5, -1437.8, 31.1), reward = 'rare_painting', amount = {1, 1}, heavy = true},
                {name = 'GROS SAC 7', model = 'prop_cs_heist_bag_01', coords = vector3(-7.9, -1429.9, 31.1), reward = 'rare_painting', amount = {1, 1}, heavy = true},
                {name = 'GROS SAC 8', model = 'prop_cs_heist_bag_01', coords = vector3(-21.3, -1435.6, 31.1), reward = 'antique_sculpture', amount = {1, 1}, heavy = true}
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
                {name = 'Gros sac de valeur', model = 'prop_cs_heist_bag_01', coords = vector3(-175.2, 491.5, 137.4), reward = 'antique_sculpture', amount = {1, 1}, heavy = true},
                {name = 'Sac d\'argent lourd', model = 'prop_cs_heist_bag_01', coords = vector3(-167.8, 489.2, 137.4), reward = 'diamond', amount = {3, 6}, heavy = true},
                {name = 'Sac de braquage', model = 'prop_cs_heist_bag_01', coords = vector3(-172.5, 488.8, 137.4), reward = 'rare_painting', amount = {1, 1}, heavy = true}
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
                {name = 'Gros sac d\'or', model = 'prop_cs_heist_bag_01', coords = vector3(-783.5, 312.8, 85.7), reward = 'gold_bar', amount = {3, 5}, heavy = true},
                {name = 'Sac de diamants', model = 'prop_cs_heist_bag_01', coords = vector3(-780.5, 319.5, 85.7), reward = 'diamond', amount = {2, 4}, heavy = true}
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
