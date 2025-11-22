--[[
    ITEMS OX_INVENTORY POUR ZCAMBU (SANS MARQUES)

    Copiez ce contenu dans votre fichier ox_inventory/data/items.lua
    ou ajoutez-les à votre configuration ox_inventory existante

    IMPORTANT : Tous les objets sont génériques sans marques (compatible FiveM)
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

['usb_key'] = {
    label = 'Clé USB',
    weight = 20,
    stack = true,
    close = true,
    description = 'Clé USB de stockage'
},

['tablet'] = {
    label = 'Tablette tactile',
    weight = 500,
    stack = false,
    close = true,
    description = 'Tablette tactile moderne'
},

['camera'] = {
    label = 'Appareil photo',
    weight = 800,
    stack = false,
    close = true,
    description = 'Appareil photo numérique'
},

['game_controller'] = {
    label = 'Manette de jeu',
    weight = 200,
    stack = true,
    close = true,
    description = 'Manette pour console de jeux'
},

['bluetooth_speaker'] = {
    label = 'Enceinte Bluetooth',
    weight = 600,
    stack = false,
    close = true,
    description = 'Enceinte sans fil portable'
},

['powerbank'] = {
    label = 'Chargeur portable',
    weight = 300,
    stack = true,
    close = true,
    description = 'Batterie externe pour smartphone'
},

['calculator'] = {
    label = 'Calculatrice',
    weight = 150,
    stack = true,
    close = true,
    description = 'Calculatrice scientifique'
},

['remote_control'] = {
    label = 'Télécommande TV',
    weight = 100,
    stack = true,
    close = true,
    description = 'Télécommande pour télévision'
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

['fake_watch'] = {
    label = 'Fausse montre',
    weight = 150,
    stack = true,
    close = true,
    description = 'Une montre de contrefaçon'
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

['lighter_deluxe'] = {
    label = 'Briquet deluxe',
    weight = 50,
    stack = true,
    close = true,
    description = 'Un briquet de luxe'
},

-- Divers
['skateboard'] = {
    label = 'Skateboard',
    weight = 800,
    stack = true,
    close = true,
    description = 'Un skateboard'
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

-- Électroménager et meubles
['television'] = {
    label = 'Télévision',
    weight = 12000,
    stack = false,
    close = true,
    description = 'Télévision grand écran'
},

['microwave'] = {
    label = 'Micro-ondes',
    weight = 14000,
    stack = false,
    close = true,
    description = 'Four à micro-ondes'
},

['designer_chair'] = {
    label = 'Chaise design',
    weight = 8000,
    stack = false,
    close = true,
    description = 'Chaise de designer haut de gamme'
},

-- Sacs et bagages
['travel_bag'] = {
    label = 'Grand sac de voyage',
    weight = 6000,
    stack = false,
    close = true,
    description = 'Un grand sac de voyage'
},

-- Note: L'argent sale (black_money) est géré par ESX et n'a pas besoin d'être ajouté ici
