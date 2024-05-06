# Welcome
Mod to faithfully recreate the glorious Civ IV FallFromHeaven mod by Kael in Civ VI. This project builds a Civ VI mod from an unhosted folder of the xml of FallFromHeaven.

To "build from source", the user will need to install [FallFromHeaven](https://www.moddb.com/members/kaelffh/downloads/fall-from-heaven-ii1), install [Patch O](kael.civfanatics.net/files/FfH2041o.exe) on top of it, and
then take the Assets/xml folder and place the contents in this project under data/XML.
Yes the install is an .exe. I would like to distribute the folders myself, but am unsure of copyright.

To download the mod, go to the Releases page, and select the highest number, for most recent. Put the downloaded folder in your Sid Meier's Civilization VI/Sid Meier's Civilization VI/Mods/ folder.
One the mod is out of Alpha (probably when art assets for three civilizations are done), I will publish on Steam Workshop.

# Features needed:
## Magic System:
  ### Mana System
  - [ ] promotions based on resource availabilty, ie can only learn Death 1 with access to Death Mana resource
  - [ ] resource transformation, ie can build Death Well improvement on raw mana node and it becomes Death mana
  - [ ] free promotions depending on mana amount controlled
### Spell System
- [x] damage spells in aoe around caster
- [ ] debuff effects : dont really exist, there is the Fear -5 Strength effect, but thats an aura. maybe as promotion
- [ ] buff effects : ditto as before
- [x] Summons
- [ ] Summoning Buildings : This was always a bit hacky in civ iv, a unit being present in a city does have modifiers, with Garrison affecting combat. Another issue is that the nonstacking makes keeping a mage on the city less feasible. Could we do a single charge based system, and allow a city to unbuild a building, if it has the prerequisite building, and that would give the charge back to the unit? if we can have two active abilities, (himiko), then could have one ability that adds it,            with a single charge, and one context dependant ability that only works on cities with the building, that removes the building and adds a charge back.
  
## Hero System:
- [x] Done via Isolationism ban unit modifier attached to all civs globally by an ability the hero has
- [ ] XP per turn: multiple types of xp gain exist, notice scouts get it for spotting natural wonders. Care that base Heroes do not get xp
- [ ] Resurrection System
- [ ] hero abandonment if leave religion

## Alignment System:
- [ ] limit units depending on alignment
- [ ] diplomacy penalties, advantages

## Armageddon Counter:
- [ ] Conversion of global warming system
- [ ] actions that happen once counter reaches certain value : we just piggyback off of global warming system, right?

## Item system:
in civ iv, act as promotions that give buffs, and allow the dropping of item, to be picked up by someone else. can also be dropped on death, and captured. Also spawnable via event
- [ ] ability that can be removed by lua on button press
- [ ] 0 movement ingame unit that is destroyed/summoned, support class?
- [ ] Need to distribute hidden ability to all combat units, to be able to pick up any of the items implemeneted.

## Lairs:
like barbarian encampments but with different classes that spawn different units, can be explored, that will trigger random event from deck, may spawn enemies, like existing raid encampment bonus feature, to add to natural wonders like Pyre of the Seraphic, have to build map generator to add these
- [ ] Implement multiple barbarian factions (animal, orc/goblin, skeletons, lizardmen)
- [ ] Implement random chance effect (look into goody hut mechanics)
- [ ] Implement "deck" of different events that can happen when a lair is explored

## Event System:
dialogue boxes with a choice that appear randomly, if the conditions satisfy the event. ex. library burning if u have library : tricky, as ui elements involved, choice will lead to lua script execution. Low priority.
- [ ] Implement UI dialogue box with clicking.

## Per Civ Features:
  ### Difficulty:
  #### Easy:
  ##### Amurite: Nothing, they are ez
  ##### Hippus:  unique abilty buffing heavy and light cavalry : adjusted Genghis Khan modifier
  ##### Khazad:
  - [x] lots of banned units
  - [ ] cities have buffs/ nerfs depending on current gold / number of cities
  - [x] Dwarven units moving fast on hills
  ##### Ljolsfar:
  - [ ] elven workers can build in forest without chopping
  - [x] all archer units are stronger, Genghis style
  #### Medium:
  ##### Elohim: 
  tolerant, can build conquered cities civ unique stuff.
  - [ ] needs to implement some concept of inherent city identity, check civ conquer mode?
  ##### Lanun:
  - [ ] coast tiles get +1 food    : ez, just a variant of auckland
  - [ ] unique resource others cant access or see, pearls. Basically a strategic resource reveal, piggyback off leylines
  - [ ] pirate cove, water improvement that have to be 3 tiles from another, and get upgraded as they get worked, like cottage
  ##### Malakim:
  most units have Nomad, double movement on desert, could apply on civ level, but then would include stuff like StoneWardens who are dwarves. desert tiles get + 1 coin : maybe hard as mali doesnt have anything like this. Then again, there is auckland who modifies Coast with +1 prod
  - [ ] +1 gold per desert is easy, adapt Mario civpass modifier
  - [x] Nomad race, part of promotion -> ability modifier. Adapt Genghis cav modifier.
  ##### Balseraph:
  slave and slave cages, puppets summons that inherit magic promotions units, affecting neutral cities, arenas, chance of killing unit but otherwise free xp
  - [ ] Create building in city if matches unit type, not present already, and city has carnival
  - [x] Slavery mechanic taken from Aztec civ

  ##### Sheaim
  - [ ] aoe explosion damage from death of pyre zombie
  - [ ] planar gates randomly summon units
  #### Hard:
  ##### Luichuirp:
  Golems being promotion lacking, slow healers, but mendable by mages with enchant 1, Barnaxus, passing buffs onto other golems globally may be awkward
  - [ ] modifier to reduce healing on golem units
  - [ ] lua event for mages with enchant 1 to repair
  - [ ] Golem Modifier like Cause Dissent of Cultist, where its value is adjusted. For the Barnaxus stuff.
  ##### Grigori:
  plural unit upgrade paths (archer, warrior, scout, cavalry) possible for Adventurer, blocked religous units, unique great person type
  - [ ] Plural upgrade paths for a unit
  - [x] Blocked units (as opposed to replaced)
  - [ ] Great adventurer spawning system, just replace Great Writers with it?
   ##### Sidar:
  Level 6 + units can retire as shades, who can act as free Great Person Specialist, so a repeatable building that provides yields and gp points
  - [ ] no concept of added specialist in civ vi, maybe as non-unique buildings, or a building with yields, then multiplied by number of specialists

  ##### Clan of embers
  - [ ] -10% science, lie Babylon 50% reduction
  - [ ] warrens building makes all units in city be doubled, like Scythia for light cavalry
  - [ ] Peace with barbarians trait, shared with doviello

  ##### Doviello
  - [ ] Free starting hero Lucian
  - [ ] can upgrade outside borders
  - [ ] Peace with barbarians trait, shared with embers
  - [ ] some units can do duels with another unit for xp

  ##### Calabim
  Vampirism, a unit on a city can cast feed, reducing the pop of the city by one, and gaining xp. also causes unhappiness, building that gets prod from unhappiness.
  - [ ] An ability that allows giving an ability to another unit, if it has enough promotions
  - [ ] promotion counter
  - [ ] active to reduce population in a city
  - [ ] building that does Required Amenities * int = prod

  ##### Ilians
  - [ ] The Deepening project to add tundra and snow
  - [ ] The Draw project to force war to you from everyone, half city population, half unit health
  - [ ] extra yields on snow terrain, like Auckland, Canada
  - [ ] Blizzard weather, (implement like GS blizzard but gives snow)

  ##### Svartalfar
  - [ ] summoned units being "illusions", heal after combat, but cant kill enemy units, only damage up to 90%
  - [x] Recon units (scout, skirmisher etc.) get a damage buff on attack, but not on defense
  - [ ] Rework of "can kidnap great people in cities, as not a thing in civ vi"
      
  #### BullshitHard:
  ##### Mercurians:
  Not directly playable, needs Wonder completed to summon, and then takes over that city. Needs to also be switchable to that player via ui prompt Units spawn on mercurian gate when Good units die, that whole headache as with Infernal
  - [ ] New Civ spawned midgame
  - [ ] Forced city transfer to the civ
  - [ ] Switch player midgame
  - [ ] UI prompt from events to do switch
  - [ ] Ability modifier of "Good" unit applied to other civs units
  - [ ] lua event when "Good" unit dies to spawn angels for this civ
  ##### Infernals
  - [ ] Evil units globally reborn as manes, like Mercurians
  - [ ] Summoned through first to tech, takes over a barbarian city
  - [ ] UI prompt option to play as them, basically Mercurians but we need more work to make the city
  - [ ] cannot gain or lose pops with food, manes add population to a city
  ##### Kuriotates:
  Sprawling, have bigger cities, 3 distance, but only allowed 3 cities. Other cities founded are Settlements, which have 0 yields and only allow access to resources. This seems very hard.
  - [ ] 4 tile workable cities, seems fucking impossible, dll bound as fuck. Then again, Yaxchilan?
  - [ ] 0 yield cities, seems doable, just have a modifier that any city past the first 3 gets a "settlement" building that multiplies all yields by 0. Unsure if requirement exists of count cities, check Sprawling historic moment?
  - [ ] Dynamic allowed city count, based on map size


  ## World Spell:
  a one time cast spell with often global effects, in civ iv is available to most units to cast, we can just have it be like a 0 prod project? or buyable
  - [ ] When doing iterations on hide ability in Lua, can just do multiple checks. Is owner of unit x civ? Does owner of unit have x tech? Has owner cast spell before? Storing that internal state might suck though, maybe it can attach a modifier on the civ?

  ## Races:
  - [x] different movements for dif races, double on desert, hills, forests for Nomads, dwarves, elves
  - [x] buffs, debuffs to certain combat conditions


# Design choices and required changes:
## Tech System:
  - [x] Tech tree is now vastly different, being split into two, need to decide what techs go where and even pare techs apart.
  - [ ] come up with eurekas
  - [ ] Use eurekas as proxies for techs where soft requirements (i.e. Trade uses something from Sailing or Horseback riding to Eureka? problem is has to be only opposing )


## Leader Trait System:
  - civ iv had boilerplate leader traits, civ vi has bespoke traits per leader that are far more specific.
  - [ ] Implement modifiers for each of the civ iv leader traits (organized etc.) Apply to relevant leaders
## City System:
  - [x] District system means we need to change a lot of buildings, categorise them by District, 
  - [ ] Reexamine if that buildings path makes sense.
## Religion System:
  - [ ] due to custom religions being a thing, how do we incorporate the veil, Order, kilmorph?  : this will need a lot of research, see how other grand conversions deal with this. Could implement it as Secret Societies.
## Governer System:
  - [ ] Make sure governers arent broken
  - [ ] existing governers arent very flavourful to the ffh universe, but this is an added extra
## Great People System:
  - [ ] Duplicate Great people so they all are basically the same, as for civ iv.
  - [ ] Use name list from xml/Text to generate names
  - [ ] Grigori Great Adventurer issue, put under Great Writer, and then change its requirements
## City State System:
  - [ ] didnt exist in civ iv, so dont know how i would approach it? Could just have them be a generic race (orc, human, dwarf, elf), or inherit the governance of nearby civs, like Age of Wonders
## Wonder System:
  - [ ] Find why we cant find filter wonders in buildinginfos
  - [ ] Extra: port existing wonders to outside the city and adjust as needed.
## Over/Undercouncil:
  - world congress but without inclusive participation : bonus feature really
## Agendas for leaders:

### New Victory types:
#### Altar of Luonnotar
seems ez, A series of buildings, then a final project that requires last building. Only difficulty is making building not buildable, but still grantable by Great Person (like Hypatia)
#### Tower of Mastery
Attach modifier that allows each tower to be built, if req_set: has_mana_1, has_mana_2... Tower of Mastery attach modifier has req_set: has_tower_1, ... Then victory condition on Tower of Mastery.