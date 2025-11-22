# ZCambu - Script de Cambriolage pour FiveM

Script de cambriolage avancé avec interface NUI moderne, système d'objets lourds/légers et téléportation dans les instances.

## Fonctionnalités

- **Interface NUI moderne** avec effet de blur pour voir le jeu en arrière-plan
- **2 types de braquage** : Facile (objets légers) et Difficile (objets lourds + légers)
- **Système d'objets lourds** : Le joueur doit porter les objets lourds, marche plus lentement et doit les déposer dans un coffre
- **Téléportation dans les instances/IPLs** avec animation cinématique
- **Timer de 3 minutes** pour chaque braquage
- **Système de cooldown** entre les braquages
- **Full OX Target** pour toutes les interactions
- **Full OX Inventory** pour la gestion des items
- **Multiple locations** préconfigurées

## Dépendances

### Obligatoires (Gratuites)

1. **ESX Legacy** - [Télécharger](https://github.com/esx-framework/esx_core)
2. **ox_lib** - [Télécharger](https://github.com/overextended/ox_lib)
3. **ox_target** - [Télécharger](https://github.com/overextended/ox_target)
4. **ox_inventory** - [Télécharger](https://github.com/overextended/ox_inventory)
5. **oxmysql** - [Télécharger](https://github.com/overextended/oxmysql)

## Installation

### 1. Télécharger et installer les dépendances

Assurez-vous que toutes les dépendances ci-dessus sont installées et démarrées avant ce script.

### 2. Installer le script

1. Placez le dossier `zcambu` dans votre répertoire `resources/[esx]` ou `resources/[custom]`
2. Ajoutez `ensure zcambu` dans votre `server.cfg` **APRÈS** les dépendances

```cfg
# Dépendances
ensure ox_lib
ensure ox_target
ensure ox_inventory
ensure es_extended

# Script de cambriolage
ensure zcambu
```

### 3. Ajouter les items dans ox_inventory

Ajoutez les items suivants dans votre fichier `ox_inventory/data/items.lua` :

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

-- Récompenses (objets légers)
['jewel'] = {
    label = 'Bijoux',
    weight = 100,
    stack = true,
    close = true,
    description = 'Des bijoux volés'
},

['luxury_watch'] = {
    label = 'Montre de Luxe',
    weight = 50,
    stack = true,
    close = true,
    description = 'Une montre de luxe'
},

['phone'] = {
    label = 'Smartphone',
    weight = 200,
    stack = true,
    close = true,
    description = 'Un smartphone dernier cri'
},

['laptop'] = {
    label = 'Ordinateur Portable',
    weight = 1000,
    stack = true,
    close = true,
    description = 'Un laptop haut de gamme'
},

-- Récompenses (objets lourds)
['painting'] = {
    label = 'Tableau de Maître',
    weight = 5000,
    stack = false,
    close = true,
    description = 'Un tableau de grande valeur'
},

['gold_bar'] = {
    label = 'Lingot d\'Or',
    weight = 8000,
    stack = true,
    close = true,
    description = 'Un lingot d\'or pur'
},

['diamond'] = {
    label = 'Diamant',
    weight = 100,
    stack = true,
    close = true,
    description = 'Un diamant précieux'
},

['antique_sculpture'] = {
    label = 'Sculpture Antique',
    weight = 10000,
    stack = false,
    close = true,
    description = 'Une sculpture antique de grande valeur'
},

['rare_painting'] = {
    label = 'Tableau Rare',
    weight = 7000,
    stack = false,
    close = true,
    description = 'Un tableau rare et recherché'
},

['tv_4k'] = {
    label = 'TV 4K',
    weight = 12000,
    stack = false,
    close = true,
    description = 'Une télévision 4K haut de gamme'
},
```

### 4. IPLs utilisés (Déjà intégrés dans GTA V)

Les IPLs suivants sont utilisés par le script et sont **GRATUITS** (natifs dans GTA V) :

- **Franklin's House** (Grove Street)
- **Vinewood Hills House**
- **Eclipse Towers Apartment**

Aucune dépendance supplémentaire n'est requise pour les IPLs.

### 5. Configuration

Modifiez le fichier `config.lua` selon vos besoins :

```lua
Config.RobberyTimer = 180 -- Durée du braquage (secondes)
Config.CooldownTime = 1800 -- Cooldown entre braquages (secondes)
Config.MinPoliceOnline = 0 -- Nombre minimum de policiers
```

## Utilisation

### Pour les joueurs

1. **Trouver une location** : Cherchez les blips sur la carte (icône de masque rouge)
2. **Approchez-vous de la porte** : Utilisez ox_target (œil) pour interagir
3. **Choisir le type de braquage** :
   - **Facile** : Nécessite un crochet, objets légers uniquement
   - **Difficile** : Nécessite un crochet amélioré, objets lourds et légers
4. **Collecter les objets** dans les 3 minutes :
   - **Objets légers** : Stockés directement dans l'inventaire
   - **Objets lourds** : Doivent être portés et déposés dans un coffre de véhicule
5. **Sortir de l'instance** avant la fin du timer

### Commandes

- `/deposer` : Déposer un objet lourd dans le coffre du véhicule proche
- `/resetcooldown [player_id]` : (Admin) Reset le cooldown d'un joueur

## Ajouter des locations

Modifiez le fichier `config.lua` et ajoutez une nouvelle entrée dans `Config.Locations` :

```lua
{
    name = 'Nom de la location',
    doorCoords = vector3(x, y, z),
    doorHeading = 180.0,
    blip = {
        sprite = 40,
        color = 1,
        scale = 0.8,
        label = 'Maison à cambrioler'
    },
    ipl = {
        name = 'NomIPL',
        enter = vector3(x, y, z),
        exit = vector3(x, y, z),
        interior = vector3(x, y, z)
    },
    props = {
        easy = { -- Props pour le mode facile
            {name = 'Nom', model = 'prop_model', coords = vector3(x, y, z), reward = 'item_name', amount = {min, max}, heavy = false}
        },
        hard = { -- Props pour le mode difficile
            -- Mêmes props que easy + objets lourds
        }
    }
}
```

## Système d'objets lourds

Les objets marqués comme `heavy = true` :
- Doivent être portés en main (visible sur le personnage)
- Ralentissent la vitesse de marche du joueur
- Doivent être déposés dans le coffre d'un véhicule
- Ne peuvent pas être stockés directement dans l'inventaire
- Le joueur ne peut porter qu'un objet lourd à la fois

## Support

Pour toute question ou bug, ouvrez une issue sur GitHub.

## Crédits

- Développé par ZaK2BaK5906
- Utilise ox_lib, ox_target, ox_inventory
- Compatible ESX Legacy

## Licence

Ce script est fourni tel quel. Libre d'utilisation et de modification.
