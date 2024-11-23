---
layout: post  
title: "What needs doing"  
date: 2024-11-16 00:30:00 -0000
categories: SQL, Lua
---

While I have made quite a lot of progress on this mod, there are still lots of things that need done. Mostly art and unit assets, but some coding stuff that was either hard or repetitive, so I left for later. My main focus has been 'can I do this?' and then when I find a way, I don't fill in the details.  For example, this is why the only event possible from exploring a Ruin, Barrow or Goblin Fort is the collapse event where the unit loses 20-ish damage. I could implement som of the other ones, in Lua, but I can fill that in later, at the moment its all about building the systems for implementing these features.

# Upgrade System
## Multi-path unit upgrades

The system in Fall From Heaven let you upgrade units along several different paths. A warrior could become an Axemen, an Archer. A Priest could upgrade to a Paladin, or a Druid or a High Priest.

This nuance is lost unfortunately in Civ VI. A unit has only one upgrade possibility, and also it will attempt to skip over existing possible units on the upgrade path to get to the last one. So for example a warrior wouldn't be able to upgrade to an archer after you have discovered Marksmanship and have Crossbowman, they would upgrade straight to that.

This is a MAJOR headache to deal with. I suspect I will need to implement a custom upgrade system, which would involve making a perfect copy of a unit including its health, experience, promotions, and abilities. I actually need to do that already for some of the summoning stuff like Hall of Mirrors, the Black Mirror, and have implemented Lua Buttons like it already, but the problem is, the AI will not use it. I can override stuff manually and trigger the AI to use the button in certain circumstances, but I have no idea what those circumstances should be.

## Unit Obselence applying on PreReqBuilding Units
Civ VI made the decision to remove access to units that are not the most updated. For example warriors are only available if you can't build swordsmen. This works quite well and given the one unit per tile system is probably better for the AI. Whats nice is that if the Swordsman is unlocked, but you don't have the necessary iron, the unit is untrainble. What isn't good is that if I unlock the Axemen, that obsoletes the Warrior, but I need a Training Yard to then build the Axeman unit, so now I'm locked out from the melee class. A similar problem happens at the Hunting Lodge and Grove.

## Unit Upgrades only being available when a unit is X level.
I can reasonably block this for human players by interfering with the UnitPanel file. I can't think of a way to reliably do it for the AI. The only real gate for promotions is strategic resources.

## Doviello upgrading outside of unit borders


# National Units

It would be reasonably easy to simply ban production of these national units once you have 4 of them. The pain is that upgrading to them is not forbidden. I did some trials with giving a civ 4 of a Strategic resource for each national unit type, think Warhorses for Knights, and upgrading to a Knight or building a Knight would cost 1 of these, and a Knight dying would give you one back. In principal, this solves the issue. However, players can freely trade these strategics amongst one another, both hobbling stupid AI and allowing players to field far more than they should of a unit. If i could find a way to make sure players couldnt trade this resource, it would work well.

# Barbarians

## Barbarian Peace with Clan/Doviello/Infernal

Without some DLL help, it seems as though peace with the barbarians is impossible. What I have done as a stopgap measure is to use the vanilla treat with barb clans to bribe them to not go into their borders, and make it only doable by these civs, and its free.

## Acheron City

## Orthus spawn


# UnitOperations

## Spells
A lot of spells are now requirement tested and only are allowed in the scenarios they should be, like adjacent to an enemy unit for a damage spell. A lot of buff/debuff spells have been implemeneted, BUT they currently last forever, need to do some work to do chance based loss every turn.

While spells have effects, they do not have any visual effects, or sound effects. For now, the next steps are to make a placeholder sound/visual effect, probably OyaStorm for offensive effects, and Hippolyta's sound and visual effect for buffs.

## Resurrection system
How to preserve experience/level/promotions of resurrected unit. How to limit caster for the 7 turns required.

## Spells as Buildings 
Casting spells like Hope/Inspiration seems quite fraught given the one unit per turn changes. Having it Lua bound means I have to do checks everytime a unit moves to see if it is a unit with that promo, and if it left or entered a city.

So ideally we have it just as a modifier. Problem is, there is a within X range of unitType modifier i could apply to a city, but it has to work agnostic of unitType or Tag. Is it possible to do it as a promotion that grants an ability, and the ability is what is tested against? I suspect not, but we'll see.

## Great People Spells
## Tech Bulbing priorities

## Golden Age granting
I have fully set out the great person sacrifice for Golden Ages. However, I cannot do the whole, +1 gold/prod per tile with them. SO this currently doesnt work.

# Armageddon
## Armageddon bespoke events
System is implemented, but the actual Lua events are not.

## Notifications
The cool armageddon notifications.

## Hell Terrain
Hell terrain algorithm technically implemented, but changing of terrain visuals does not happen. Resource changning has been done. The Flame Feature should be reasonably easy using the DangerLevel column, still need to implement the spread of it.

## Spell Terrain Changes
Again visual changes dont show up, and Lua is currently buggy too.

# Music

## Get the music assets for FFH if copyright no issue

## Trigger custom music based on alignment
Probably can look to Maples music mod for how to trigger music

# Event system

## UI Dialog box
There is an existing framework for this, as seen in DLC and also a guy did one on Discord. Hopefully we can just adapt it

## Data mining relevant events
There are a lot of events in FFH that can occur semi-randomly. I need to mine the FFH python/XML system to get out the probabilities and the conditions under which these events occur

## Fancy Traits

### Cassiel Adaptive
Very doable, just needs a modifier on his capital for each possible trait, and a PLOT_PROPERTY_MATCHES requirement on it. Does also need a little UI prompt for when you can change it.

### Perpentach Insane
Same as Adaptive, just done at random. Needs notification prompt though

### Financial 
+1 gold on tiles with 2 already is beyond the civ engine currently.

# UI Work
## Maintenance
City maintenance only shows at a global level, as its subtracting from the treasury.
## SuperSpecialist City Display
Great People can be added to cities, we should show this amount.

## Tech Tree UI adjustments
The Civ VI tech Tree screen is narrow and long, it only has 6 possible columns. Whereas there needs to be a lot more than that for the FFH tree. We can fix this in the UI.

When I did the tree calculation for eras, to compensate for this. The problem this caused is the buildings then were too advanced, as Industrial/Atomic/Modern techs existed. We need to either limit it to the Renaissance era, or replace the Industrial/Atomic/Modern building stuffs.

When I do this, could also decide if we want to get rid of the civic tree and make it all techs again.

