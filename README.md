# ZCAMBU - Script de Cambriolage FiveM

Script de cambriolage avec interface NUI tablette, système d'objets légers/lourds, et téléportation vers des instances.

## Dépendances

- **ESX Legacy** (es_extended)
- **ox_lib**
- **ox_target**
- **ox_inventory**

## Installation

1. Placez le script dans votre dossier `resources`
2. Ajoutez `ensure zcambu` dans votre `server.cfg`
3. Ajoutez les items ci-dessous dans votre base de données `ox_inventory`
4. Redémarrez le serveur

## Configuration

Modifiez `config.lua` pour personnaliser :
- Les props disponibles (légers et lourds)
- Les locations de braquage
- Les récompenses
- Le timer et cooldown
- Le nombre de policiers requis

## Fonctionnalités

### Système de Spawn Aléatoire
- **Braquage FACILE** : 10 objets légers aléatoires
- **Braquage DIFFICILE** : 4 objets légers + 6 objets lourds aléatoires

### Items Requis
- **Braquage facile** : `lockpick` (crochet)
- **Braquage difficile** : `lockpick_advanced` (crochet amélioré)

### Objets Lourds
- Le joueur porte l'objet avec animation
- Impossibilité d'utiliser des armes ou sprinter
- L'objet va directement dans l'inventaire
- Le joueur doit le stocker lui-même dans un coffre de véhicule

## Items à ajouter dans ox_inventory

### Items Requis pour Braquage

Ajoutez ces items dans `ox_inventory/data/items.lua` :

```lua
-- Items requis pour le braquage
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
```

### Items Légers (Braquage Facile ET Difficile)

```lua
-- Bijoux et accessoires
['silver_chain'] = {
    label = 'Chaîne en toc',
    weight = 100,
    stack = true,
    close = true,
    description = 'Une chaîne de faible qualité'
},

['bracelet'] = {
    label = 'Bracelet femme',
    weight = 80,
    stack = true,
    close = true,
    description = 'Un bracelet pour femme'
},

['old_coins'] = {
    label = 'Pièces anciennes',
    weight = 150,
    stack = true,
    close = true,
    description = 'Des pièces de collection anciennes'
},

['silver_bar'] = {
    label = 'Lingot argent',
    weight = 500,
    stack = true,
    close = true,
    description = 'Un lingot d\'argent'
},

['fake_watch'] = {
    label = 'Montre contrefaite',
    weight = 120,
    stack = true,
    close = true,
    description = 'Une montre de contrefaçon'
},

-- Électronique
['usb_crypto'] = {
    label = 'Clé USB cryptée',
    weight = 50,
    stack = true,
    close = true,
    description = 'Une clé USB avec des données cryptées'
},

['earpiece'] = {
    label = 'Oreillette volée',
    weight = 60,
    stack = true,
    close = true,
    description = 'Une oreillette sans fil'
},

['tablet_mini'] = {
    label = 'Mini-tablette',
    weight = 300,
    stack = true,
    close = true,
    description = 'Une petite tablette tactile'
},

['tablet_pro'] = {
    label = 'Tablette pro',
    weight = 400,
    stack = true,
    close = true,
    description = 'Une tablette professionnelle haut de gamme'
},

['server_card'] = {
    label = 'Carte serveur',
    weight = 80,
    stack = true,
    close = true,
    description = 'Une carte réseau de serveur'
},

['encrypted_hdd'] = {
    label = 'Disque dur chiffré',
    weight = 250,
    stack = true,
    close = true,
    description = 'Un disque dur avec chiffrement'
},

-- Documents et cartes
['crypto_card'] = {
    label = 'Carte crypto',
    weight = 10,
    stack = true,
    close = true,
    description = 'Une carte de crypto-monnaie'
},

['fake_passport'] = {
    label = 'Passeport volé',
    weight = 50,
    stack = true,
    close = true,
    description = 'Un passeport falsifié'
},

['secret_docs'] = {
    label = 'Malette documents',
    weight = 200,
    stack = true,
    close = true,
    description = 'Une malette contenant des documents secrets'
},

['diamond_key'] = {
    label = 'Clé secrète',
    weight = 30,
    stack = true,
    close = true,
    description = 'Une clé mystérieuse'
},

-- Argent liquide et sacs
['dirty_cash_small'] = {
    label = 'Pochette billets',
    weight = 150,
    stack = true,
    close = true,
    description = 'Une pochette contenant des billets'
},

['wallet'] = {
    label = 'Porte-monnaie',
    weight = 50,
    stack = true,
    close = true,
    description = 'Un porte-monnaie avec de l\'argent'
},

['light_bag'] = {
    label = 'Sacoche légère',
    weight = 200,
    stack = true,
    close = true,
    description = 'Une sacoche de transport légère'
},
```

### Items Lourds (Braquage Difficile uniquement)

```lua
-- Objets lourds
['mini_safe'] = {
    label = 'Coffre miniature',
    weight = 5000,
    stack = false,
    close = true,
    description = 'Un petit coffre-fort portable'
},

['bronze_statue'] = {
    label = 'Statue bronze',
    weight = 4000,
    stack = false,
    close = true,
    description = 'Une statue en bronze de valeur'
},

['smart_tv'] = {
    label = 'TV Connecté',
    weight = 6000,
    stack = false,
    close = true,
    description = 'Une télévision connectée haut de gamme'
},

['old_painting'] = {
    label = 'Tableau ancien',
    weight = 3000,
    stack = false,
    close = true,
    description = 'Un tableau de maître ancien'
},

['luxury_couch'] = {
    label = 'Canapé',
    weight = 8000,
    stack = false,
    close = true,
    description = 'Un canapé de luxe'
},

['tech_box'] = {
    label = 'Box électronique',
    weight = 4500,
    stack = false,
    close = true,
    description = 'Une box électronique sophistiquée'
},

['gaming_console'] = {
    label = 'Console de jeux',
    weight = 2500,
    stack = false,
    close = true,
    description = 'Une console de jeux dernière génération'
},

['gaming_pc'] = {
    label = 'Ordinateur Gamer',
    weight = 7000,
    stack = false,
    close = true,
    description = 'Un PC de gaming haut de gamme'
},

['military_bag'] = {
    label = 'Sac militaire',
    weight = 3500,
    stack = false,
    close = true,
    description = 'Un sac militaire tactique'
},

['gold_bar_box'] = {
    label = 'Caisse lingots',
    weight = 10000,
    stack = false,
    close = true,
    description = 'Une caisse contenant des lingots d\'or'
},
```

## Liste Complète des Props

### Props Légers (20 items)
1. **Petite liasse** - `prop_cash_pile_02` → black_money (120-280$)
2. **Chaîne en toc** - `prop_jewel_02a` → silver_chain
3. **Clé USB cryptée** - `prop_usb_drive_01` → usb_crypto
4. **Montre contrefaite** - `p_watch_03` → fake_watch
5. **Pochette billets** - `prop_money_bag_01` → dirty_cash_small (180-250$)
6. **Bracelet femme** - `prop_jewel_04b` → bracelet
7. **Oreillette volée** - `prop_cs_hand_radio` → earpiece
8. **Mini-tablette** - `prop_tablet_02` → tablet_mini
9. **Carte crypto** - `prop_credit_card_01` → crypto_card
10. **Porte-monnaie** - `prop_ld_wallet_01` → wallet (50-120$)
11. **Sacoche légère** - `prop_cs_shopping_bag` → light_bag
12. **Grosse liasse** - `prop_cash_case_01` → black_money (380-700$)
13. **Carte serveur** - `prop_raspberry_pi` → server_card
14. **Passeport volé** - `prop_ld_passcard_01` → fake_passport
15. **Tablette pro** - `prop_tablet_01` → tablet_pro
16. **Pièces anciennes** - `prop_coins_01` → old_coins
17. **Lingot argent** - `prop_ingot_01` → silver_bar
18. **Malette documents** - `prop_ld_case_01` → secret_docs
19. **Clé secrète** - `prop_cs_key_01` → diamond_key
20. **Disque dur chiffré** - `prop_cs_hard_drive` → encrypted_hdd

### Props Lourds (10 items)
1. **Coffre miniature** - `prop_ld_int_safe_01` → mini_safe
2. **Statue bronze** - `prop_bronze_horse` → bronze_statue
3. **TV Connecté** - `prop_tv_flat_01` → smart_tv
4. **Tableau ancien** - `prop_painting_01` → old_painting
5. **Canapé** - `prop_couch_01` → luxury_couch
6. **Box électronique** - `prop_elecbox_12` → tech_box
7. **Console de jeux** - `prop_arcade_01` → gaming_console
8. **Ordinateur Gamer** - `prop_dyn_pc_02` → gaming_pc
9. **Sac militaire** - `prop_cs_heist_bag_01` → military_bag
10. **Caisse lingots** - `hei_prop_heist_cash_pile` → gold_bar_box

## Locations

### 1. Maison Grove Street
- Porte : `-9.35, -1438.51, 31.10`
- Intérieur : Franklin House IPL
- 10 positions de spawn

### 2. Villa Vinewood
- Porte : `-174.35, 502.66, 137.42`
- Intérieur : Vinewood House IPL
- 10 positions de spawn

### 3. Appartement Eclipse
- Porte : `-773.41, 312.45, 85.70`
- Intérieur : Eclipse Towers IPL
- 10 positions de spawn

## Paramètres

- **Timer de braquage** : 3 minutes (180 secondes)
- **Cooldown** : 30 minutes (1800 secondes)
- **Policiers minimum requis** : 0 (configurable)
- **Job police** : `police`

## Commandes Admin

- `/resetcooldown [player_id]` - Reset le cooldown de cambriolage d'un joueur

## Support

Pour toute question ou problème, ouvrez une issue sur GitHub.

## Crédits

Script développé pour FiveM avec ESX Legacy.
