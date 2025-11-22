--[[
    ITEMS OX_INVENTORY POUR ZCAMBU (SANS MARQUES)

    Copiez ce contenu dans votre fichier ox_inventory/data/items.lua
    ou ajoutez-les à votre configuration ox_inventory existante
]]--

-- ============================================
-- ITEMS REQUIS POUR LANCER LE BRAQUAGE
-- ============================================

['lockpick'] = {
    label = 'Crochet',
    weight = 160,
    stack = true,
    close = true,
    description = 'Permet de crocheter les portes (braquage facile)'
},

['lockpick_advanced'] = {
    label = 'Crochet Amélioré',
    weight = 160,
    stack = true,
    close = true,
    description = 'Permet de crocheter les portes renforcées (braquage difficile)'
},

-- ============================================
-- OBJETS LÉGERS (Braquage Facile ET Difficile)
-- ============================================

-- Électronique
['smartphone'] = {
    label = 'Smartphone',
    weight = 250,
    stack = true,
    close = true,
    description = 'Un smartphone récent'
},

['bluetooth_earbuds'] = {
    label = 'Écouteurs Bluetooth',
    weight = 100,
    stack = true,
    close = true,
    description = 'Des écouteurs sans fil'
},

['handheld_console'] = {
    label = 'Console portable',
    weight = 800,
    stack = true,
    close = true,
    description = 'Une console de jeu portable'
},

-- Vêtements et accessoires
['cap'] = {
    label = 'Casquette',
    weight = 150,
    stack = true,
    close = true,
    description = 'Une casquette'
},

['sport_shoes'] = {
    label = 'Chaussures de sport',
    weight = 300,
    stack = true,
    close = true,
    description = 'Une paire de chaussures de sport'
},

['shoebox'] = {
    label = 'Boîte de chaussures',
    weight = 400,
    stack = true,
    close = true,
    description = 'Une boîte contenant des chaussures'
},

['clothing_box'] = {
    label = 'Boîte de vêtements',
    weight = 350,
    stack = true,
    close = true,
    description = 'Une boîte contenant des vêtements'
},

['handbag'] = {
    label = 'Sac à main',
    weight = 400,
    stack = true,
    close = true,
    description = 'Un sac à main'
},

['watch'] = {
    label = 'Montre',
    weight = 150,
    stack = true,
    close = true,
    description = 'Une montre'
},

['perfume'] = {
    label = 'Parfum',
    weight = 200,
    stack = true,
    close = true,
    description = 'Un flacon de parfum'
},

['jewelry'] = {
    label = 'Bijoux',
    weight = 100,
    stack = true,
    close = true,
    description = 'Des bijoux'
},

-- Consommables
['vape'] = {
    label = 'Vape',
    weight = 120,
    stack = true,
    close = true,
    description = 'Une cigarette électronique'
},

['water_bottle'] = {
    label = 'Bouteille d\'eau',
    weight = 150,
    stack = true,
    close = true,
    description = 'Une bouteille d\'eau'
},

['energy_drink'] = {
    label = 'Boisson énergétique',
    weight = 170,
    stack = true,
    close = true,
    description = 'Une boisson énergisante'
},

-- Divers
['skateboard'] = {
    label = 'Skateboard',
    weight = 800,
    stack = true,
    close = true,
    description = 'Un skateboard'
},

['collectible_figure'] = {
    label = 'Figurine de collection',
    weight = 300,
    stack = true,
    close = true,
    description = 'Une figurine de collection'
},

['lighter'] = {
    label = 'Briquet',
    weight = 50,
    stack = true,
    close = true,
    description = 'Un briquet'
},

['remote_control'] = {
    label = 'Télécommande',
    weight = 100,
    stack = true,
    close = true,
    description = 'Une télécommande universelle'
},

-- ============================================
-- OBJETS LOURDS (Braquage Difficile uniquement)
-- ============================================

-- Consoles de jeux
['game_console'] = {
    label = 'Console de jeux',
    weight = 4500,
    stack = false,
    close = true,
    description = 'Une console de jeux vidéo'
},

['game_console_pro'] = {
    label = 'Console de jeux Pro',
    weight = 4200,
    stack = false,
    close = true,
    description = 'Une console de jeux haut de gamme'
},

['retro_console'] = {
    label = 'Console rétro',
    weight = 3800,
    stack = false,
    close = true,
    description = 'Une console de jeux rétro'
},

-- Informatique
['laptop'] = {
    label = 'Ordinateur portable',
    weight = 5500,
    stack = false,
    close = true,
    description = 'Un ordinateur portable'
},

['gaming_setup'] = {
    label = 'Setup Gaming',
    weight = 12000,
    stack = false,
    close = true,
    description = 'Un setup gaming complet avec écrans'
},

-- Sacs et bagages
['travel_bag'] = {
    label = 'Sac de voyage',
    weight = 6000,
    stack = false,
    close = true,
    description = 'Un grand sac de voyage'
},

['sport_bag'] = {
    label = 'Sac de sport',
    weight = 5500,
    stack = false,
    close = true,
    description = 'Un sac de sport'
},

-- Objets de décoration
['sculpture'] = {
    label = 'Sculpture',
    weight = 8000,
    stack = false,
    close = true,
    description = 'Une sculpture de valeur'
},

['carpet'] = {
    label = 'Tapis',
    weight = 7000,
    stack = false,
    close = true,
    description = 'Un tapis de qualité'
},

-- Note: L'argent sale (black_money) est géré par ESX et n'a pas besoin d'être ajouté ici
