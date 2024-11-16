---
layout: post  
title: "Major Milestones"  
date: 2024-11-16 00:30:00 -0000
categories: SQL
---

Over the last nine months, I've done a lot. So much, I forget all the things I did. The first few months were more about getting basic units into the game, getting basic promotions into the game, making solutions to problems that were no longer needed, like a promo_tree column categoriser that i scrapped upon realising I could use Lua to expand the size of the promo tree UI. But from a user perspective, I'll try explain the cool stuff I have implemented.

# Complete
## Barbarian city spawning
As FallFromHeaven didn't have city states, and I needed a way to make barbarian cities, I have made it so any spawning city state from a barb clan declares war on every civ bar the Clan of Embers/Doviello/Infernal, and is locked in permanent war. 

## UnitOperation System
There is now a system in place to allow spells and unit actions in a correct manner. Spells are visible in the panel normally reserved for build options

## Policy Gating
The Crusade policy is banned from every player but the Bannor. Sacrifice the Weak, Arete and Guardian of Nature are available if you have the prerequisite religion policy equipped. Sadly with the current system theres no way to do two changes at the same turn, but in fairness that reflects the original religion system.

## City Maintenance
The Civ IV system of city maintenance based on distance from seat of governance/ number of cities is implemented. It is viewable as a drain to your treasury rather than viewable on a city level, as that was far easier to do. I may add some support to show it in the CityPanel, but its low priority.
## Alignment System
Civ's start off as a certain alignment, and adopting specific religions changes that alignment. Druids, Eidolons and Paladins are locked behind being Neutral, Evil or Good. HOWEVER, it doesn't currently do a diplomacy buff for Good- Good, Evil - Evil civs, as I don't yet understand how diplomacy modifiers work

## Item system
Items can be both 0 movement units as well as abilities that empower the unit that has them. Units have an active to take an item from adjacent allies, removing the ability from them and transferring it to them. If a unit kills a unit with an item ability, it gets the item ability, unless it already has the item ability, in which case the item becomes a 0 movement unit and pickable by your other units. The AI wont know how to pick up items, but hopefully that stacking feature will be rare enough it shouldnt matter.`

## Promotion Gating
Promotions are limited as in FFH, like Scourge being unpickable without Way of the Wicked, or Twincast/Heroic Strength needing a Hero unit.

## Free promotions
Traits like Aggressive and Spiritual grant their promotions to units on spawn, as does having an excess of a mana resource for magical units.

## Expand Promotion UI
Made the UI for promotions bigger and changed line transitions to allow dummy promotion precursors.
![Alt text](/Fall-From-Heaven//Images/PromotionTree.png)

## Resource Affinities
Units with a resource affinity like the Shadowrider gain bonus combat strength based on the amount of the resource you have, both improved in your territory and gained via trade/modifiers.

## Victory Conditions
Both the Tower of Mastery and the Altar of Luonnotar are implemented and will win you the game if you complete the final stages of each. In addition the Victory partial screen has been amended to include these two victory types and how far along each player is.

The AI is capable of building the Altars as it is now the activation ability of Great Prophets, however, there is currently no behaviour to incentivise them to do so, same for the Towers. This should be addressable once I learn BehaviourNodes.

## Resource Transformation
Building mana wells on raw mana nodes converts it into the required mana resource.

## Religion Granting/Founding on Tech
## Civs and Leaders
Each of the Civilizations have been implemented, with all their unique units and buildings. Special actives and very unique abilities are being implemented on a case by case basis. We also banned units/buildings where needed.

Also includes special traits of Civ's like Ljosalfar ranged unit extra damage, Sheaim getting Summoner on their magic units etc.

## Racial system
Races implemented for training units for civs like Ljosalfar, Infernal, Khazad, Malakim. Races are smart enough to not work when a race is already set, like Valin Phanuel will always be a human, and so won't be elven if trained by the Ljosalfar.

## Barnaxus and Golem system

## Great Adventurer
System works, but is somewhat hampered by the single upgrade path.
## 

# Partially Complete
## Spawning Hyborem/Basium Midmatch
Hyborem and Basium can spawn just as in FFH, and are banned from being picked normally. BUT you cannot choose to become them. This is a limitation in the Civ VI engine unfortunately. At some point this might be possible using the DLL level mod made by the excellent WildW, and if I don't have other stuff to implement, I will work on implementing civ transfer myself. Yeah it would be great to have, but I dont have the C/decompiler skills to implement it in any decent timeframe. I have made a caveat that the Mercurian Gate cant be built in your capital, as force transferring capitals is a bit messy. Basium starts in a permanent alliance with you, as before. Happy crusading!

Hyborem is similarly without civ transfer. In base FFH, the Infernal spawn on researching Infernal Pact, seem to have the same technology level as the civ that summoned them, and take over the best/not closest barbarian city. As barbarian cities are not really a thing in Civ VI (no, free cities don't count, and they have weird hard coding where they always spawn two of the strongest possible melee units), Hyborem defaults to spawning on a Ruin or Barrows or Goblin Fort. I did then implement Barbarian cities, in a manner of speaking, and if that is an option, he takes over one of those instead.

## Good/Evil unit alignment, Manes and Angel spawning
Units are granted a religion based on the religions in a city, by chance. A religion then defines a units alignment, with dying  Good and Neutral units becoming Angels under the owner of the Mercurian Gate (normally Basium) and Evil units becoming Manes. I have built in the checks that exist like not counting undead units or Nether Blade deaths and even fixed the bug where Animal/Beast units were reincarnated. Due to the issues with multi-path unit upgrades I have not implemented how Angels and Manes upgrade. I have built Manes as a Great Person type, as it allows the AI to use them to increase their city count. Currently this is visible in the UI, but they cost 20'000 Gold each, so isn't an issue really. Later for polish I'll do some work to hide them in the UI.


## Barb camp variants
To implement the Ruins, Barrows, Goblin Forts scattered across Erebus, I have made each of them a different barbarian clan type, where Ruins only spawns Lizardmen, Barrows Skeleton, and Goblin Forts Goblin Archers. The first two are also untreatable with by any clan type (although I may allow Clan of Embers Ruins interaction as they have lizardmen by default? only in a modmod though). These get spawned on map generation, like goodyhuts. These camps are a bit different from vanilla, the only option is to disperse them, and on doing so, you get a random event like you would in FFH. At the moment, I haven't implemented any beyond the dungeon collapsing.

Barb Fort clans can also be treated with to get goblin units if you are the Clan of Embers. Unlike in FFH, you dont need a unit on their spawn however.

## Natural Wonders
I have implemented the mega-Dungeon natural wonders like Pyre of the Seraphic, Broken Sepulcher and Bradelines well. They currently work by having a barbarian camp spawn on them, and an Lua even trigger that rebuilds the camp once it has been dispersed. At the moment this is instantaneous, but the plan is for it to respawn after 3 turns. Natural wonders are currently borrowing existing natural wonder assets. Natural Wonders currently don't have the right yields, or the yields on tech/civic but that should be easy. They also don't grant the resource they normally would, whether it be Mana or the Fruit of Yggdrasil, but that is just a bit of boilerplate SQL easily copied from Terra Mirablis which has a few versions of X natural wonder grants you Y resource.

For now, the special events that occur very rarely have not been implemented (sacrificing angels to make Fire elementals on Pyre, Force Peace from Seven Pines, Brigitte). Those first two should be reasonably easy to do given the UnitOperation system I have implemented.

## LeaderTraits
Most leader traits are implemented, with a few exceptions. Raiders can technically be implemented, but the Commando promotion it grants is basically useless, as civ VI units can always use enemy roads. Charismatic does not provide a flat diplomacy buff as I don't understand those modifiers

## Religion Gating
Units and Buildings are all available only when a unit has a specific Religion Policy in place. Currently there is no abandoning mechanic remove units on leaving a religion though.

## Armageddon Counter
The apocalypse counter is tracking most of the requirements it should, minus a few hard ones like sanctifying city ruins. However there is no UI to display the armageddon counter. There is also currently untested code to spawn in the various armageddon events, although the nice UI text is not implemented (but will probably be a simple notification).

## World Spells
I have made a custom button available at the top left to active your world spell when you have it. It is currently means-tested by you have the right tech for the civ you are, and an internal tracker that you have cast the spell already, reset by Birthright Regained.

## Rituals
Most rituals have been implemented, except a few difficult ones, like Phoenix Rising as we have no proper resurrection one-time use

## Hero System
Unique one of unit where as soon you've built it, no one else can. Hero units also gain experience per turn.

## Spell Sphere access
Adept class Units can gain access to the relevant spell sphere promotions once the player has a copy of that mana resource. Access is limited to the relevant tiers by channeling level as in FFH. The caveat is that there is no way to remove access to this promotion, as the gating is done by requires granting a hidden promotion, and there is no current way to 'ungrant' a promotion.

In addition, there has been some loss of functionality where units that are not nominally 'magic' units cannot access upgrading spell spheres. For example, Vampires/Losha/Vampire Lords/Brujah start with Death I and Body I and Channelling II. But their Promotion Class means they currently cannot select Death II or Body II. This is also the case for some other Hero units. This may be fixable with a few more bespoke promotion classes for each case, but its a pain, and means a lot more tailoring is needed to fix up class based combat bonuses, like Shock, to apply to those custom classes.

This also wouldn't capture how any unit that is GRANTED vampirism should be able to promote into Death I and Body I. It might end up being I add those as promotion options for all classes, but hide them unless they fit the criteria. But that will be a lot of UI work.








