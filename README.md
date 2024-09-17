# Welcome
Mod to faithfully recreate the glorious Civ IV FallFromHeaven mod by Kael in Civ VI. 

To download the mod, git clone or go to the Releases page, and select the highest number, for most recent. Put the downloaded folder in your Sid Meier's Civilization VI/Sid Meier's Civilization VI/Mods/ folder.
One the mod is out of Alpha (probably when art assets for three civilizations are done), I will publish on Steam Workshop.

## Features needed:
- [ ] promotions based on resource availabilty, ie can only learn Death 1 with access to Death Mana resource, Lua: HasResource, GetBonusResourcePerTurn, GetResourceAmount, Monopolies support stuff?
- [ ] resource transformation, ie can build Death Well improvement on raw mana node and it becomes Death mana
- [ ] Resurrection System  For Hero level, Use pPlayer:SetProperty() on UnitRemovedFromMap (assuming thats the death event). Then on casting Resurrection, check unit's owner for that hero dead property. Much harder I think for the Phoenix promotion, there is the CanRetreatWhenCaptured that vampires use. But how can I hook into that temporarily? UnitCaptured is an Event, but that trigger on units being killed, somehow works for Vampires. 
- [ ] hero abandonment if leave religion     Event: PolicyChanged (since we are planning religion as a slotable policyType.). Then just iterate over relevant player units and kill them.
- [ ] Summoning Buildings : Modifier with 3 tile AOE? So can only affect one city. Dunno if there is a modifier to grant a modifier to a city, like there is for units.

### Alignment System:
- [ ] Certain actions like switching religion set as Good, Evil, Neutral   Probably pPlayer:SetProperty()
- [ ] limit units depending on alignment   Lua: pPlayer:GetUnits:SetBuildDisabled()? no args documented so maybe just stops all units being built.
- [ ] diplomacy penalties, advantages      Annoyingly diplo penalties seem to be done as modifiers, but no requirements would work.
- [ ] debuff effects : Lua Unit:GetAbility():ChangeAbilityCount, and then implement abilities. Seems undocumented though. ('SANGUINE_PACT_VAMPIRE_COMBAT_STRENGTH_ON_DEAD_UNIT', 'MODIFIER_ALL_COMBAT_RESULTS_APPLY_MODIFIER_TO_UNITS_ON_TILE'); MODIFIER_COMBAT_RESULTS_ATTACH_UNIT_MODIFIER
- [ ] buff effects : ditto as before. Attacking debuffs (withered, Diseased can use Event :: OnUnitRetreated ?)

### Armageddon Counter:
- [ ] Conversion of global warming system  We probably just steal the UI design of it.  
- [ ] Converting terrain to Hell terrain equivalent. Look into TerrainBuilder.SetTerrainType(), can also set Features and Resources. If not, can set plot Properties and visually change it, like JNR does? idk if that ever worked.
- [ ] actions that happen once counter reaches certain value     Lua: Event : PlayerTurnStarted check if some property has reached a point. Actually where would I store state, there is no Game:SetProperty()

### Item system:
in civ iv, act as promotions that give buffs, and allow the dropping of item, to be picked up by someone else. can also be dropped on death, and captured. Also spawnable via event
- [ ] ability that can be removed by lua on button press : Reasonably easy to implement for player as button, not for AI. Attempts with custom FormationClasses have failed as entering formation fails for combining novel formationClasses. Would limit a unit to one unit, one item.
- [ ] 0 movement ingame unit that is destroyed/summoned, support class? A button to apply an effect on the combat unit in the same tile seems feasible. As does removing it. We don't need to store unit state, beyond its UnitType. Lua Event: UnitRemovedFromMap to respawn all items when a unit with them dies?
- [ ] Need to distribute hidden ability to all combat units, to be able to pick up any of the items implemeneted. Seems reasonable in SQL. weapons cant stack.

### Lairs:
like barbarian encampments but with different classes that spawn different units, can be explored, that will trigger random event from deck, may spawn enemies, like existing raid encampment bonus feature, to add to natural wonders like Pyre of the Seraphic, have to build map generator to add these
- [ ] Implement multiple barbarian factions (animal, orc/goblin, skeletons, lizardmen)   Look into how spectator mod implemeneted Civilization Spectator.
- [ ] Have to implement spawning on mapgeneration, check that Cat relics mod, to see how they did it.
- [ ] Implement "deck" of different events that can happen when a lair is explored: probably do this with plot:SetProperty() then remove them on lair removal

### Event System:
dialogue boxes with a choice that appear randomly, if the conditions satisfy the event. ex. library burning if u have library : tricky, as ui elements involved, choice will lead to lua script execution. Low priority.
- [ ] Someone made a framework for Stellaris meteors on discord. Just copy that I guess..
- [ ] summoned units being "illusions", heal after combat, but cant kill enemy units, only damage up to 90%. seems impossible
- [ ] The Deepening project to add tundra and snow (terrain changes dont show up except on reload)
- [ ] The Draw project to force war to you from everyone, half city population, half unit health    Damage all units is simple, pPlayer:GetDiplomacy():DeclareWarOn(), city pop, unsure
- [ ] Blizzard weather, (implement like GS blizzard but gives snow)
- [ ] An ability that allows giving an ability to another unit, if it has enough promotions     Button implemented in Lua. Unit:GetExperience():GetLevel()
- [ ] active to reduce population in a city                       Button implemented in Lua. Unit:GetExperience():ChangeExperience(). Possible to remove pop, check Firetuner. Transient amenity loss will be harder.
- [ ] building that does Required Amenities * int = prod          Probably also a lua thing.  Lua : Event : PlayerTurnStarted
- [ ] Free starting hero Lucian         I think someone has implemented multiple starting units per civ. Could also just grant him on first settle.
- [ ] can upgrade outside borders       probably needs bespoke upgrade system
- [ ] Peace with barbarians trait, shared with embers        WildW was thinking of something like this, look at comments on discord
- [ ] some units can do duels with another unit for xp          lua button, need to take target adjacent tile logic used in QinBuilders on Machu Picchu
- [ ] Arenas Gladiator
- [ ] Button for all units if level 6 and Sidar to convert to Shade. Then just use Great Person Specialist system already set up
- [ ] lua event for mages with enchant 1 to repair   Just an extra spell with one more condition
- [ ] aoe explosion damage from death of pyre zombie    Lua : Event : UnitRemovedFromMap
- [ ] planar gates randomly summon units              Lua : Event : PlayerTurnStarted : Iterate through cities with planar gates. Check if they have the other buildings. Have random chance to spawn.
- [ ] Hall of Mirrors clone spawning
- [ ] Create building in city if matches unit type, not present already, and city has carnival  Lua button on per unit basis, or ability basis for Human, Orc, Elf etc.
- [ ] Puppets, inheriting from summoner
- [ ] needs to implement some concept of inherent city identity for being able to produce those units, check civ conquer mode? But then apply only to that city. hmmm
- [ ] New Civ spawned midgame      think we use barb clans method
- [ ] Forced city transfer to the civ      doable in Lua
- [ ] Switch player midgame              very hard
- [ ] UI prompt from events to do switch        doable
- [ ] Summoned through first to tech, takes over a barbarian city           easy to do first to tech. Barb city is harder tho. Need to implement Free City spawning
### Kuriotates:
  Sprawling, have bigger cities, 3 distance, but only allowed 3 cities. Other cities founded are Settlements, which have 0 yields and only allow access to resources. This seems very hard.
- [ ] 4 tile workable cities, seems fucking impossible, dll bound as fuck. Then again, Yaxchilan? It bugs out and gives like 180 yields for each sometimes
- [ ] 0 yield cities, seems doable, just have a modifier that any city past the first 3 gets a "settlement" modifier that multiplies all yields by 0. Unsure if requirement exists of count cities. 
- [ ] Dynamic allowed city count, based on map size. Map size part is hard and probably needs Lua. 
### World Spell:
  a one time cast spell with often global effects, in civ iv is available to most units to cast, we can just have it be like a 0 prod project? or buyable
- [ ] When doing iterations on hide ability in Lua, can just do multiple checks. Is owner of unit x civ? Does owner of unit have x tech? Has owner cast spell before? Storing that internal state might suck though, maybe it can attach a modifier on the civ?
- [ ] Do I even need to do it on a unit? arent all world spells just on units for convenience, I could make a UI button for it, in governor panel?
- [ ] can do check on pPlayer:GetProperty() to see if its been used, or regained with Regain Birthright.
- [ ] come up with eurekas
- [ ] Use eurekas as proxies for techs where soft requirements (i.e. Trade uses something from Sailing or Horseback riding to Eureka? problem is has to be only opposing )
- [ ] Implement Barbarian trait
- [ ] Implement Perpentach insanity and ui indicator
- [ ] Implement Cassiel adaptive and ui selector
- [ ] Implement Commando roads stuff
- [ ] Implement summoner inherit system on summon
- [ ] implement Charisma +relationship gain
- [ ] implement diplo effects for each trait?
- [ ] Trade Mission, Gold for distance, gold for city size
- [ ] Culture Bomb, big grant of culture, and border expansion
- [ ] Bulbing techs.
- [ ] Golden Age modifiers, the whole extra Hammer/ extra gold per tile thing.
- [ ] Luonnotar buildup using Great Person action rather than Lua, so the ai can win with it. Issue with doing same action to make next building iteration. And enabling/disabling based on that.
- [ ] Dark elf kidnapping superSpecialist ( apply a modifier  with the reverse values of a superspecialist) and spawn a great person
- [ ] first to tech Great People or other things
- [ ] Hero Hijacking, see if the relic system is in Lua and if we can override, so the ai can use abilities of units hopefully. or maybe Great People
- [ ] Plural upgrade paths for a unit                 We can maybe implement this by making our own upgrade system.
- [ ] Investigate Religion as Removing/Allowing Policies (WC is dll bound, can only grant policy not take away in Lua. PolicyXP1 allows dark age policies, no more granular than 1 or 0) MODIFIER_MAJOR_PLAYERS_ADJUST_BANNED_POLICY
- [ ] world congress but without inclusive participation : bonus feature really
- [ ] didnt exist in civ iv, so dont know how i would approach it? Could just have them be a generic race (orc, human, dwarf, elf), or inherit the governance of nearby civs, like Age of Wonders
- [ ] Altar of Luonnotar ez, A series of buildings, then a final project that requires last building. Only difficulty is making building not buildable, but still grantable by Great Person (like Hypatia)
- [ ] Tower of Mastery Attach modifier that allows each tower to be built, if req_set: has_mana_1, has_mana_2... Tower of Mastery attach modifier has req_set: has_tower_1, ... Then victory condition on Tower of Mastery.
## Art Todo
- [ ] Investigat Landmark / District changes to allow alt buildings. Like why do Wonders like ORzgarzh work in city centre? but buildings wont. also palgum exclamation cultures stuff.
- [ ] Make new Buildings
- [ ] Make new Units
## Design Todo
- [ ] Display SuperSpecialists in the City UI somehow (DESIGN DECISION)
- [ ] Reexamine if buildings path and districts makes sense.
## Polish Todo
- [ ] Trait Descriptions


# Done
##### Mercurians:
  Not directly playable, needs Wonder completed to summon, and then takes over that city. Needs to also be switchable to that player via ui prompt Units spawn on mercurian gate when Good units die, that whole headache as with Infernal
- [x] Ability modifier of "Good" unit applied to other civs units
- [x] lua event when "Good" unit dies to spawn angels for this civ Lua : Event : UnitRemovedFromMap
  ##### Infernals
- [x] Evil units globally reborn as manes, like Mercurians
- [x] cannot gain or lose pops with food, manes add population to a city.

  ## Races:
- [x] different movements for dif races, double on desert, hills, forests for Nomads, dwarves, elves
- [ ] due to engine differences, cant regain movement like in IV without restoring all movement, which isnt right.
- [x] buffs, debuffs to certain combat conditions


# Design choices and required changes:
## Tech System:
  - [x] Tech tree is now vastly different, being split into two, need to decide what techs go where and even pare techs apart.

## Leader Trait System:
  - civ iv had boilerplate leader traits, civ vi has bespoke traits per leader that are far more specific.
  - [x] Implement modifiers for each of the civ iv leader traits (organized etc.) Apply to relevant leaders
  
  - [x] Implement proper free promotions (Combat I) as just ability misses getting early better promos behind combat I
  - [x] Implement xp gain from potency
  
## City System:
  - [x] District system means we need to change a lot of buildings, categorise them by District,
## Religion System:
  - [x] due to custom religions being a thing, how do we incorporate the veil, Order, kilmorph?  : Plan is, custom policy screen grants access to religion policy once in one of your cities. Predefine religions on map startup by assigning them as being founded by dummy civs? Can give people Mvemba traits if we wanna use Founder beliefs. + Amenities may be an issue. Game.GetReligion():FoundReligion(); Game.GetReligion():AddBelief();  Pantheons may bite us in the ass. Also Holy City will have to be manually implemented through City:SetProperty()
  - [x] Extra Policies on Policy Screen
  - [x] Investigate Religion as Religion lol. Do check on each civ to see what religions it qualifies for based on religion spread to it, do a playerProperty for each relgion as Yes can or no Cant. Do a custom screen to select which religion, stealing copiously from PolicyScreen. For AI, just make them do first religion, and stay on if has unique units from it, and move off if lost majority. Also possibly custom preferences, like no Veil for Bannor say.

## Great People System:
  - [x] Duplicate Great people so they all are basically the same, as for civ iv.
  - [x] Buttons for making Academy, Religious Wonders, SuperSpecialist
  - [x] Golden ages. playerProperty to see number of golden ages triggered, to know how many great people to consume. playerProperty to get all current Great people owned, and also references to delete them on use.
  - [x] Great General Command post, Junil
  - [x] Great General aura all eras
  - [x] Lunnotar Buildings in Lua/with modifiers
  - [x] Use name list from xml/Text to generate names
  - [x] Grigori Great Adventurer issue, put under Great Writer, and then change its requirements

## City State System:
## Wonder System:
  - [x] Find why we cant find filter wonders in buildinginfos
  - [x] Extra: port existing wonders to outside the city and adjust as needed.
# Specialist System:
- [x] Permanent specialists could implement as a few modifiers on a city, with variable values based on requirements?
## Combat Rebalancing:
- [x] Find a way to go from % damage increases and low values to high integer values in a comprehensive way. Maybe if we had the calculation for both combat systems? have a desmos graph on slothmoth email acc


## Per Civ Features:
  ### Difficulty:
  #### Easy:
  ##### Amurite: Nothing, they are ez
  ##### Hippus:  unique abilty buffing heavy and light cavalry : adjusted Genghis Khan modifier
  ##### Khazad:
  - [x] lots of banned units
  - [x] cities have buffs/ nerfs depending on current gold / number of cities -> Lua: Could do lua side that sets plot property of city, and 5 modifiers for each stage, applied to each city, with requirement REQUIREMENT_PLOT_PROPERTY_MATCHES. Although unsure if modifier with City context would have plot as a subject for requirements...
  - [x] Dwarven units moving fast on hills
  ##### Ljolsfar:
  - [x] elven workers can build in forest without chopping    Can do this with dummy tech and RHAI-style tech hiding.
  - [x] racial units are not applied on civ level, instead as production level 
  - [x] all archer units are stronger, Genghis style
  #### Medium:
  ##### Elohim:
  tolerant, can build conquered cities civ unique stuff.     
  ##### Lanun:
  - [x] coast tiles get +1 food 
  - [x] unique resource others cant access or see, pearls. Basically a strategic resource reveal, piggyback off leylines/etherium
  - [x] pirate cove, water improvement that have to be 3 tiles from another, and get upgraded as they get worked, like cottage. Possible by Plot:SetProperty('worked', isWorked) on event ImprovementChanged(isWorked), then on PlayerTurnStarted use pPlayer:GetImprovements() to get a full list then filter to the Pirate Ports. Get their Plot, then Plot:SetProperty('turns_worked', ++). Then ImprovementBuilder:SetImprovementType()?
  ##### Malakim:
  most units have Nomad, double movement on desert, could apply on civ level, but then would include stuff like StoneWardens who are dwarves.
  - [x] +1 gold on desert tiles
  - [x] Nomad race
  ##### Balseraph:
  slave and slave cages, puppets summons that inherit magic promotions units, affecting neutral cities, arenas, chance of killing unit but otherwise free xp
  - [x] Slavery mechanic taken from Aztec civ

  ##### Sheaim
  #### Hard:
  ##### Luichuirp:
  Golems being promotion lacking, slow healers, but mendable by mages with enchant 1, Barnaxus, passing buffs onto other golems globally may be awkward
  - [x] modifier to reduce healing on golem units     copy vampire mechanic without pillage part.
  - [x] Barnaxus Golem Modifier attachment, do it by Great general aoe but like range 99
  - [x] stop golems upgrading by making them uniques, not replacers, and banning unit they would replace
  ##### Grigori:
  plural unit upgrade paths (archer, warrior, scout, cavalry) possible for Adventurer, blocked religous units, unique great person type
  - [x] Blocked units (as opposed to replaced)
  - [x] Great adventurer spawning system, just replace Great Writers with it? Implemented, now need a modifier to ban everyone else getting them. Like Maori
   ##### Sidar:
  Level 6 + units can retire as shades, who can act as free Great Person Specialist, so a repeatable building that provides yields and gp points
  ##### Clan of embers
  - [x] -10% science, lie Babylon 50% reduction
  - [x] warrens building makes all units in city be doubled, like Scythia for light cavalry, but repeat for all promoClasses

  ##### Doviello

  ##### Calabim
  Vampirism, a unit on a city can cast feed, reducing the pop of the city by one, and gaining xp. also causes unhappiness, building that gets prod from unhappiness.

  ##### Ilians
  - [x] extra yields on snow terrain, like Auckland, Canada

  ##### Svartalfar
  - [x] Recon units (scout, skirmisher etc.) get a damage buff on attack, but not on defense