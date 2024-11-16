---
layout: post  
title: "Thorny DLL problems"  
date: 2024-11-16 00:30:00 -0000
categories: DLL  
---

These were stuff on my Todo List that are quite hard, and I will probably need some DLL changes to implement.

## Immortal promotion
While there does exist ways to make a unit immortal, so they respawn in your capital, the difficulty is making it a one time thing. This seems like a reasonably easy thing to do in the DLL, a check if the unit has the ability, if so, respawn. Then we can check on the respawn and remove the ability in Lua. This affects the Immortal unit, Vampire Lord, Losha and the Phoenix Rising Ritual.

## Kuriotates Sprawl
As Civ VI by default has a 3 tile radius on cities, the Kuriotates should have a 4 tile radius on their cities. It is possible to do different size workable tiles, there are two implementations, CypRyan's Tall and Wide, done in Lua, which definitely could do it on a single civ level, but is buggy, or Phantom_J's 4th tile ring mod, which is DLL bound, and quite scary to look at, as it is both written in C, and also the author is Chinese, so communication may be difficult.

## Transferring player
A very much DLL bound problem. No ideas on how I will solve this, although its definitely got a bounty where other modders want to find a way to do this too

# Tolerant Trait
Civ VI really doesn't play nice with unlocking units locally in one city, but thats what tolerant does. Need to be able to produce units/buildings of original city owner, and only in that city.

## Movement on Enemy Roads (Commando promotion)
Again very hard to do, there is not much on route movement we can alter.

## Contributory TechPrereqs
FFH had techs like Sorcery that have multiple possible Prereqs to choose from. Unfortunately, in Civ VI, techPrereqs means you need all those techs, rather than just one of them. This is fixable with a dummy Tech that is the only prereq for Sorcery.