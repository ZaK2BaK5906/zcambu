# ZCAMBU - Script de Cambriolage de Maisons de Luxe

Script de cambriolage avec interface NUI tablette, système d'objets légers/lourds, et téléportation vers des instances. Utilise le **Ultimate Props Pack** pour des objets réalistes de maisons modernes.

## ⚠️ Prérequis

### Pack de Props REQUIS
**Ultimate Props Pack** - Ce script utilise des props customs du pack Ultimate Props. Assurez-vous d'avoir installé ce pack dans votre serveur.

### Dépendances Framework
- **ESX Legacy** (es_extended)
- **ox_lib**
- **ox_target**
- **ox_inventory**

## 📦 Installation

### 1. Installer le Pack de Props
Placez le dossier du pack Ultimate Props dans votre dossier `stream` ou suivez les instructions du pack.

### 2. Installer le script
1. Placez le dossier `zcambu` dans votre répertoire `resources`
2. Ajoutez `ensure zcambu` dans votre `server.cfg`
3. Ajoutez les items dans ox_inventory (voir section ci-dessous)
4. Redémarrez le serveur

### 3. Ajouter les items ox_inventory
Copiez le contenu du fichier `ox_inventory_items.lua` dans votre `ox_inventory/data/items.lua`

## 🎮 Fonctionnalités

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

## 📋 Liste des Objets

### 💡 Objets Légers (20 items)

#### Électronique
- **Smartphone** (`rm-phone-1`) → smartphone
- **AirPods** (`rm-appleheadset-1`) → apple_headset
- **Nintendo Switch** (`rm-switch`) → nintendo_switch

#### Vêtements & Accessoires
- **Casquette Designer** (`rm-cap-1`) → designer_cap
- **Yeezy Slide** (`rm-yeezyslide`) → yeezy_slide
- **Chaussures Nike** (`rm-nikebox-1`) → nike_shoes

#### Articles de Luxe
- **Boîte Versace** (`rm-versace-box-1`) → versace_box
- **Boîte Bape** (`rm-bape-box`) → bape_box
- **Petit Sac LV** (`rm-lvbag-1`) → lv_bag_small

#### Consommables
- **Vape** (`rm-vape-1`) → vape (1-2x)
- **Fiji Water** (`rm-fiji-bottle`) → fiji_water (2-4x)
- **Prime Drink** (`rm-prime-1`) → prime_drink (1-3x)
- **Monster Energy** (`rm-monster`) → monster_energy (1-2x)

#### Argent
- **Petite Liasse** (`rm-cashspread-1`) → black_money (150-350$)
- **Stack de Billets** (`rm-dollarstack-1`) → black_money (200-450$)

#### Divers
- **Skateboard** (`rm-skate-1`) → skateboard
- **Figurine Kaws** (`rm-kaws-1`) → kaws_figure_small
- **Briquet Luxe** (`rm-bic-1`) → lighter (1-3x)
- **Sac de Bonbons** (`rm-candybag`) → candy_bag (1-2x)
- **Télécommande** (`rm-backwoods-1`) → remote_control

### 🏋️ Objets Lourds (10 items)

#### Consoles de Jeux
- **PlayStation 5** (`rm-ps5`) → ps5_console
- **PlayStation 4** (`rm-ps4`) → ps4_console
- **Xbox** (`rm-xbox`) → xbox_console

#### Informatique
- **MacBook** (`rm-mac`) → macbook
- **Setup Gaming** (`rm-screensetup`) → gaming_setup

#### Articles de Luxe Lourds
- **Grand Sac LV** (`rm-lvbag-13`) → lv_bag_large
- **Sac Gucci** (`rm-gucci-bag`) → gucci_bag

#### Argent
- **Grosse Liasse** (`rm-money-pile-1`) → black_money (800-1500$)

#### Objets de Collection
- **Statue Kaws** (`rm-kaws-2`) → kaws_statue
- **Tapis Designer** (`rm-bape-rug1`) → designer_rug

## 🗺️ Locations

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

## ⚙️ Configuration

Modifiez `config.lua` pour personnaliser :
- Les props disponibles (légers et lourds)
- Les locations de braquage
- Les récompenses
- Le timer et cooldown
- Le nombre de policiers requis

### Paramètres par défaut
- **Timer de braquage** : 3 minutes (180 secondes)
- **Cooldown** : 30 minutes (1800 secondes)
- **Policiers minimum requis** : 0 (configurable)
- **Job police** : `police`

## 🎯 Utilisation

### Pour les joueurs
1. Trouvez une location sur la carte (blips rouges)
2. Approchez-vous de la porte et utilisez ox_target (œil)
3. Choisissez le type de braquage (facile ou difficile)
4. Vous serez téléporté à l'intérieur
5. Collectez les objets dans les 3 minutes
   - **Objets légers** : Vont directement dans l'inventaire
   - **Objets lourds** : Vous les portez et devez les stocker dans un coffre de véhicule
6. Sortez de l'instance avant la fin du timer (appuyez sur E à la sortie)

## 👨‍💼 Commandes Admin

- `/resetcooldown [player_id]` - Reset le cooldown de cambriolage d'un joueur

## 📝 Items ox_inventory

Tous les items sont définis dans le fichier `ox_inventory_items.lua`. Copiez-collez ce contenu dans votre `ox_inventory/data/items.lua`.

### Catégories d'items
- **2 items requis** : lockpick, lockpick_advanced
- **18 objets légers** : smartphone, airpods, casquettes, chaussures, boîtes de luxe, consommables, etc.
- **9 objets lourds** : consoles, macbook, setup gaming, sacs de luxe, statues, tapis

## 🎨 Thème du Script

Ce script est conçu pour des **cambriolages de maisons modernes/luxueuses**. Les objets sont cohérents avec ce qu'on trouverait dans une maison de joueur riche :
- Électronique haut de gamme (consoles, Mac, setup)
- Articles de luxe (sacs LV, Gucci, Versace, Bape)
- Objets de collection (figurines Kaws)
- Consommables premium (Fiji, Prime, Monster)
- Argent liquide

**Pas d'armes** ni de **bijoux** (réservés pour un futur script de bijouterie).

## 🔧 Support

Pour toute question ou problème :
1. Vérifiez que le pack Ultimate Props est bien installé
2. Vérifiez que tous les items sont ajoutés dans ox_inventory
3. Consultez les logs du serveur pour les erreurs

## 📄 Crédits

- Script développé pour FiveM avec ESX Legacy
- Utilise le pack Ultimate Props Pack
- Compatible avec ox_lib, ox_target, ox_inventory

## 📜 Licence

Ce script est fourni tel quel. Libre d'utilisation et de modification.
