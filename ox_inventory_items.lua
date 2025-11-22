--[[
    ITEMS OX_INVENTORY POUR ZCAMBU

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
    description = 'Un smartphone haut de gamme'
},

['apple_headset'] = {
    label = 'AirPods',
    weight = 100,
    stack = true,
    close = true,
    description = 'Des écouteurs Apple AirPods'
},

['nintendo_switch'] = {
    label = 'Nintendo Switch',
    weight = 800,
    stack = true,
    close = true,
    description = 'Console portable Nintendo Switch'
},

-- Vêtements et accessoires
['designer_cap'] = {
    label = 'Casquette Designer',
    weight = 150,
    stack = true,
    close = true,
    description = 'Une casquette de marque de luxe'
},

['yeezy_slide'] = {
    label = 'Yeezy Slide',
    weight = 300,
    stack = true,
    close = true,
    description = 'Paire de Yeezy Slide'
},

['nike_shoes'] = {
    label = 'Chaussures Nike',
    weight = 500,
    stack = true,
    close = true,
    description = 'Paire de chaussures Nike dans sa boîte'
},

-- Articles de luxe
['versace_box'] = {
    label = 'Boîte Versace',
    weight = 400,
    stack = true,
    close = true,
    description = 'Une boîte Versace contenant des articles de luxe'
},

['bape_box'] = {
    label = 'Boîte Bape',
    weight = 350,
    stack = true,
    close = true,
    description = 'Une boîte de vêtements Bape'
},

['lv_bag_small'] = {
    label = 'Petit Sac Louis Vuitton',
    weight = 600,
    stack = true,
    close = true,
    description = 'Un petit sac à main Louis Vuitton'
},

-- Consommables
['vape'] = {
    label = 'Vape',
    weight = 120,
    stack = true,
    close = true,
    description = 'Une cigarette électronique'
},

['fiji_water'] = {
    label = 'Fiji Water',
    weight = 200,
    stack = true,
    close = true,
    description = 'Bouteille d\'eau de luxe Fiji'
},

['prime_drink'] = {
    label = 'Prime Drink',
    weight = 180,
    stack = true,
    close = true,
    description = 'Boisson énergisante Prime'
},

['monster_energy'] = {
    label = 'Monster Energy',
    weight = 170,
    stack = true,
    close = true,
    description = 'Boisson énergisante Monster'
},

-- Divers
['skateboard'] = {
    label = 'Skateboard',
    weight = 800,
    stack = true,
    close = true,
    description = 'Un skateboard de marque'
},

['kaws_figure_small'] = {
    label = 'Figurine Kaws',
    weight = 300,
    stack = true,
    close = true,
    description = 'Une petite figurine de collection Kaws'
},

['lighter'] = {
    label = 'Briquet de Luxe',
    weight = 50,
    stack = true,
    close = true,
    description = 'Un briquet design'
},

['candy_bag'] = {
    label = 'Sac de Bonbons',
    weight = 150,
    stack = true,
    close = true,
    description = 'Un sac rempli de bonbons'
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
['ps5_console'] = {
    label = 'PlayStation 5',
    weight = 4500,
    stack = false,
    close = true,
    description = 'Console de jeux PlayStation 5'
},

['ps4_console'] = {
    label = 'PlayStation 4',
    weight = 3800,
    stack = false,
    close = true,
    description = 'Console de jeux PlayStation 4'
},

['xbox_console'] = {
    label = 'Xbox',
    weight = 4200,
    stack = false,
    close = true,
    description = 'Console de jeux Xbox'
},

-- Informatique
['macbook'] = {
    label = 'MacBook',
    weight = 5500,
    stack = false,
    close = true,
    description = 'Ordinateur portable MacBook'
},

['gaming_setup'] = {
    label = 'Setup Gaming',
    weight = 12000,
    stack = false,
    close = true,
    description = 'Setup gaming complet avec écrans'
},

-- Articles de luxe lourds
['lv_bag_large'] = {
    label = 'Grand Sac Louis Vuitton',
    weight = 6000,
    stack = false,
    close = true,
    description = 'Un grand sac de voyage Louis Vuitton'
},

['gucci_bag'] = {
    label = 'Sac Gucci',
    weight = 5500,
    stack = false,
    close = true,
    description = 'Un sac Gucci de luxe'
},

-- Objets de collection
['kaws_statue'] = {
    label = 'Statue Kaws',
    weight = 8000,
    stack = false,
    close = true,
    description = 'Une grande statue de collection Kaws'
},

['designer_rug'] = {
    label = 'Tapis Designer',
    weight = 7000,
    stack = false,
    close = true,
    description = 'Un tapis de créateur de luxe'
},

-- Note: L'argent sale (black_money) est géré par ESX et n'a pas besoin d'être ajouté ici
