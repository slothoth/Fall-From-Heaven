# Welcome
Mod to faithfully recreate the glorious Civ IV FallFromHeaven mod by Kael in Civ VI. 

To download the mod, git clone or go to the Releases page, and select the highest number, for most recent. Put the downloaded folder in your Sid Meier's Civilization VI/Sid Meier's Civilization VI/Mods/ folder.
One the mod is out of Alpha (probably when art assets for three civilizations are done), I will publish on Steam Workshop.
## TOP priority:
Magic system[ ]
Barbarians[x]
Fix religion[x]
Armageddon[x]
World Spells
Items[x]
Victory Conditions [x]
## Promotion System:
- [x] promotions based on resource availabilty, ie can only learn Death 1 with access to Death Mana resource.Achieved, but irreversibly as based on promotion. can i unset promo? i cannot
- [x] UI improvements hiding dummy promos in pips on UnitPanel, should be just a skip line
- [ ] clean up UI by doing includes instead of whole file
- [ ] Low prio: unitFlagManager counts hidden promos, hide em
- [x] Lines linking promos where dummy promo is used in promop popup screen
- [x] Mess with sphere promos to get them to look better. Get placeholder Amber icon in for test? Also line formatting, aligning title. Maybe just replace the promotion icon with unique one?
- [ ] How are we gonna handle other non-adepts getting channeling I or II. Disciple is common enough we should plan for it, others, no clue.

## Alignment System:
- [ ] Certain actions like switching religion set as Good, Evil, Neutral  Need to find the right trigger, policy change as thats how religion?
- [x] limit units depending on alignment         Used the settler ban from isolation. But does it cover upgrading?
- [ ] diplomacy penalties, advantages      Annoyingly diplo penalties seem to be done as modifiers, but no requirements would work.

## Improvement System:
- [x] resource transformation, ie can build Death Well improvement on raw mana node and it becomes Death mana

## Combat System:
- [x] debuff effects : Lua Unit:GetAbility():ChangeAbilityCount, and then implement abilities. Seems undocumented though. Modifier attempts failed ('SANGUINE_PACT_VAMPIRE_COMBAT_STRENGTH_ON_DEAD_UNIT', 'MODIFIER_ALL_COMBAT_RESULTS_APPLY_MODIFIER_TO_UNITS_ON_TILE'); MODIFIER_COMBAT_RESULTS_ATTACH_UNIT_MODIFIER
- [ ] buff effects : % chance to remove each turn. big concern on desyncs here. Maybe just do counter
- [ ] some summoned units being "illusions", heal after combat, but cant kill enemy units, only damage up to 90%. VERY HARD
- [ ] aoe explosion damage from death of pyre zombie    Lua : Event : UnitRemovedFromMap
- [x] Element damage system. Need to test the range of resistance. Each damage is really 5. Some immunities exist. 20% MR plus 50% MR specific.
- [ ] Fire resistance. 100% Fire immune, 100% Godslayer. 50% Magic immune, 50% Stoneskin. 20 %Magic Resistance.
- [x] Fire resistance. 20% Angel.  Negatives: Frostling -50%, -50% vulnerable to fire.
- [L] Fire resistance. 20% Demon, Orc. -10 Winterborn
- [ ] Cold resistance: 100%, Godslayer, Frostling, Frost Immune. 50% Magic Immune, Stoneskin 20% Magic Resistance, Winterborn   negative: elf -25%
- [x] Cold resistance: 100% Frostling.
- [L] Cold resistance: 20% Winterborn   negative: elf -25%
- [ ] Lightning resistance: 100%, GodSlayer, Lightning Immune. 50% Magic Immune, Stoneskin. 20% Magic Resistance   negative: Bronze, Iron weapons -25%
- [L] Lightning resistance: 20%  Winterborn
- [ ] Poison resistance: 100%, Godslayer, Illusion, Jade Torc. 50% Magic Immune, Stoneskin. 20% Magic Resistance
- [x] Poison resistance: 100%, Angel, Elemental, Golem, Undead.
- [L] Poison resistance: 100%, Demon.  20% Dwarf
- [ ] Unholy resistance: 100%, GodSlayer. 50 Stoneskin. 25 Sundered, Unholy Taint
- [x] Unholy resistance:  50 Undead.
- [L] Unholy resistance: 100%, Demon.
- [ ] Holy resistance: 100%, GodSlayer, Angel. Stoneskin  negative: Demon -25%, -10 Sheut, -50 Undead
- [x] Holy resistance: 100%, Angel. negative: -50 Undead
- [L] Holy resistance: negative: Demon -25%,
- [ ] Death resistance: 100%, GodSlayer,  Illusion. 50% Magic Immune, Stoneskin. 20% Magic Resistance, Sheut Stone 
- [x] Death resistance: 100%,Demon, Elemental, Golem, Undead. 50% Angel
- [x] can then just do as modifier with requirements in a binaryish way, if only 5 possible ways. i.e. if unit doesnt have 20% tag, do 1 damage. if unit doesnt have 50% tag, do 3 damage. if unit doesnt have immune tag, do 2 damage for full 6.
- [ ] Affinity system
- [ ] On three equipments
- [ ] With different damage types.
## Armageddon Counter:
- [x] Contributons to Armageddon count (Razing non-Veil cities (makes City Ruins improvement), Prophecy Mark units being created, Wonders being created. Ashen Veil founding, Ashen Veil spread, Compact broken (hyborem or Basium), Sheaim project, Illian projects? War equipment kills)
- [x] Lowering Armageddon count (Razing Veil Cities, Sanctifying city ruins, Hallowing of Elohim project, Prophecy Mark units dying, Wonders destroyed? )
- [ ] Hijack Global Warming panel. We probably just steal the UI design of it.  
- [x] Converting terrain to Hell terrain equivalent. Look into TerrainBuilder.SetTerrainType(), can also set Features and Resources. If not, can set plot Properties and visually change it, like JNR does? idk if that ever worked.
- [ ] test basic functionality
- [x] amend to proper version with plotProp counter
- [x] actions that happen once counter reaches certain value. Did this without any specific Event, instead its checked whenever armageddon counter is changed.
- [ ] Events to implement still: Warning popup, Blight, 100Armageddon

## Item system:
in civ iv, act as promotions that give buffs, and allow the dropping of item, to be picked up by someone else. can also be dropped on death, and captured. Also spawnable via event
- [x] ability that can be removed by lua on button press : Reasonably easy to implement for player as button, not for AI. Attempts with custom FormationClasses have failed as entering formation fails for combining novel formationClasses. Would limit a unit to one unit, one item.
- [x] 0 movement ingame unit that is destroyed/summoned, support class? A button to apply an effect on the combat unit in the same tile seems feasible. As does removing it. We don't need to store unit state, beyond its UnitType. Lua Event: UnitRemovedFromMap to respawn all items when a unit with them dies?
- [x] Need to distribute hidden ability to all combat units, to be able to pick up any of the items implemeneted. Seems reasonable in SQL. weapons cant stack.
- [ ] Implement ability modifiers
## Lairs and barbarians:
like barbarian encampments but with different classes that spawn different units, can be explored, that will trigger random event from deck, may spawn enemies, like existing raid encampment bonus feature, to add to natural wonders like Pyre of the Seraphic, have to build map generator to add these
- [x] Implement multiple barbarian factions (animal, orc/goblin, skeletons, lizardmen)   Look into Barb Clans different clans. There is some UniqueBarbarianUnits table.
- [x] Have to implement spawning on mapgeneration, MapUtilities override was possible, but instead just gave GoodyHut columns to barb camp
- [x] Implement "deck" of different events that can happen when a lair is explored: probably do this with plot:SetProperty() then hook into barbarian clans removal and trigger event, if it shouldnt clear the lair, replace the lair lol
- [x] Deck selection skeleton
- [ ] All deck options
- [ ] Peace with barbarians trait, shared with embers        WildW was thinking of something like this, look at comments on discord
- [x] Free City spawning
- [x] Goblin Clan Fort: Orc warriors, Goblin scouts, Archers, Goblin Chariot
- [x] Ruins: Lizardmen
- [x] Barrows: Skeleton
- [x] Lion Den
- [ ] Bear Den: Bears not spawning despite CanTrain
- [ ] Generic: Frostlings, Beasts, Event barbarians, spawning ad-hoc
- [ ] Acheron Free City
- [x] Embers diplomacy with Clans only
- [x] No diplomacy with some clans
- [ ] Animal Clans cant become cities
- [x] natural wonder clans

## Terrain Alteration:
- [ ] The Deepening project to add tundra and snow (terrain changes dont show up except on reload)

## Lua Actives:
- [ ] An ability that allows giving an ability to another unit, if it has enough promotions     Button implemented in Lua. Unit:GetExperience():GetLevel()
- [ ] active to reduce population in a city                       Button implemented in Lua. Unit:GetExperience():ChangeExperience(). Possible to remove pop, check Firetuner. Transient amenity loss will be harder.
- [ ] some units can do duels with another unit for xp          lua button, need to take target adjacent tile logic used in QinBuilders on Machu Picchu
- [ ] Button for all units if level 6 and Sidar to convert to Shade. Then just use Great Person Specialist system already set up
- [ ] Arenas Gladiator
- [ ] lua event for mages with enchant 1 to repair   Just an extra spell with one more condition
- [ ] Create building in city if matches unit type, not present already, and city has carnival  Lua button on per unit basis, or ability basis for Human, Orc, Elf etc.
- [ ] Trade Mission, Gold for distance, gold for city size
- [ ] Culture Bomb, big grant of culture, and border expansion
- [ ] Bulbing techs.
- [ ] Dark elf kidnapping superSpecialist ( apply a modifier  with the reverse values of a superspecialist) and spawn a great person
- [x] For single ability units, Manes for example, Hero Hijacking, see if the relic system is in Lua and if we can override, so the ai can use abilities of units hopefully. or maybe Great People
- [ ] Single active, grants to city/player/unit
- [ ] Bear, Wolf, Lion, Tiger, Gorilla, spider pen, scorpion cages (issue with barbs. Also all_units_attach_modifier fails.)
- [ ] 

## Upgrade System:
- [ ] can upgrade outside borders       probably needs bespoke upgrade system. what about using strategic forts to briefly grant the tile to the player?
- [ ] Plural upgrade paths for a unit                 We can maybe implement this by making our own upgrade system. That would solve a lot of issues. WildW unit transfer system?

## Magic System:
- [ ] UI to press buttons (try make something like for building improvements but above) maybe hijack unitCommands system for populating?
- [ ] Puppets, inheriting from summoner
- [ ] Resurrection System  For Hero level, Use pPlayer:SetProperty() on UnitRemovedFromMap (assuming thats the death event). Then on casting Resurrection, check unit's owner for that hero dead property. Much harder I think for the Phoenix promotion, there is the CanRetreatWhenCaptured that vampires use. But how can I hook into that temporarily? UnitCaptured is an Event, but that trigger on units being killed, somehow works for Vampires. 
- [ ] Summoning Buildings : Modifier with 3 tile AOE? So can only affect one city. Needs to be Lua as requirements cant check if unit has promotion, and needs to be rooted in city not unit. Or with modifier as do a modifier on city with REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TYPE_MATCHES


## Civ Spawn System:
- [x] New Civ spawned midgame      Do Kupe LeadersXP2 ocean spawn, then do citytransfer/found city.
- [x] Forced city transfer to the civ      doable in Lua
- [ ] Switch player midgame              very hard
- [x] Summoned through first to tech, takes over a barbarian city           easy to do first to tech. Barb city is harder tho. Need to implement Free City spawning
- [x] need to do inheriting techs/civics and extra units(Basium/Hyborem, stack of angels/manes)
- [ ] Diplomatic modifiers for bringing into world. Not permanent alliance with basium tho
- [x] Ban Mercurian gate from palace. Mutually exclusives?. Also needs to grant palace after building, and maybe set capital
## Event System:
dialogue boxes with a choice that appear randomly, if the conditions satisfy the event. ex. library burning if u have library : tricky, as ui elements involved, choice will lead to lua script execution. Low priority.
- [ ] Someone made a framework for Stellaris meteors on discord. Just copy that I guess..
- [ ] UI prompt from events to do city switch        doable

## Projects:
- [x] Armageddon count projects
- [ ] Bane Divine (remove promos of Disciple units, 70 arma) Removing promotions is technically impossible :(. Replace units with one of same type and owner and health? Also ability tracking ugh.
- [ ] Birthright regained (world spell back)
- [ ] Blood of the Phoenix (let all current units be able to respawn in cap once) probably cant do as modifier sadly as no ability to respawn
- [ ] Genesis (upgrade terrain in civ)
- [ ] Glory everlasting (kill all demon units once, 70 Arma) 
- [ ] Pact of Nilhorn (3 giants spawn, only plausible one non-lua)
- [ ] Rites of Oghma (new mana resources spawn)
- [ ] Purge the Unfaithful (there is a modifier to remove for inquisition, but we have a different definition of state religion)
- [ ] Samhain (spawn barb frostlings and Mokka)   lua i think
- [ ] The White Hand (spawn 3 priest of Winters for player)
- [ ] The Deepening (convert some desert to plains, plains/grassland to tundra, tundra to snow. cba with blizards tho.)
- [ ] The Draw (+10 to Arma, halve all your cities pops, damage all units, declare war with all other civs, suspend any diplomacy.) Damage all units is simple, pPlayer:GetDiplomacy():DeclareWarOn(), city pop, unsure
- [ ] Ascension (Summons Auric Unleashed for player)
## Misc:
- [x] Double prod with Copper Form of Titan example. Also for some projects (Blood of Phoenix)
- [x] Need 3 libraries for Great Library, same with Theatre

## LowHangingCiv:
- [ ] Manor + Pillar of Chains building that does Required Amenities * int = prod          Probably also a lua thing.  Lua : Event : PlayerTurnStarted. Needs rebalacing as sucks under civ vi
- [ ] Free starting hero Lucian         I think someone has implemented multiple starting units per civ. Could also just grant him on first settle.
- [ ] planar gates randomly summon units              Lua : Event : PlayerTurnStarted : Iterate through cities with planar gates. Check if they have the other buildings. Have random chance to spawn.
- [ ] Infernal no amenity cost? as they get no unhappiness. (+2 amenities per 2 pop to balance out cost?)
## Hard but minor:
- [ ] Blizzard weather, (implement like GS blizzard but gives snow)
- [ ] Hall of Mirrors clone spawning
- [ ] Hidden nationality units

## CivHard
- [ ] 4 tile workable cities. CypRyan and Phantagonist versions, Phantagonist less buggy. But how to make single civ?
- [ ] 0 yield cities, seems doable, just have a modifier that any city past the first 3 gets a "settlement" modifier that multiplies all yields by 0. Unsure if requirement exists of count cities. 
- [ ] Dynamic allowed city count, based on map size. Map size part is hard and probably needs Lua. 
- [ ] needs to implement some concept of inherent city identity for being able to produce those units, check civ conquer mode? But then apply only to that city. hmmm
- [ ] Doviello scavenging prod for nearby city on killing unit.
## World Spell:
  a one time cast spell with often global effects, in civ iv is available to most units to cast, we can just have it be like a 0 prod project? or buyable
- [ ] Do I even need to do it on a unit? arent all world spells just on units for convenience, I could make a UI button for it, in governor panel?
- [ ] can do check on pPlayer:GetProperty() to see if its been used, or regained with Regain Birthright. And a Technology check after. The ai will have to be coerced into it, probably a onPlayerTurnStart thing.

## Trait System:
- [ ] Implement Barbarian trait
- [ ] Implement Perpentach insanity and ui indicator
- [ ] Implement Cassiel adaptive and ui selector
- [ ] Implement Commando roads stuff
- [ ] Implement summoner inherit system on summon
- [ ] implement Charisma +relationship gain
- [ ] implement diplo effects for each trait?

## Religion:
- [x] Investigate Religion as Removing/Allowing Policies Unearthed working Effect, now just need to find a way to have it turn on or off with requirements as its on Player not City. But Bannor specific worked
- [ ] hero abandonment if leave religion     Event: PolicyChanged (since we are planning religion as a slotable policyType.). Then just iterate over relevant player units and kill them.
- [x] Religion specific policies
- [L] Non-lua format where EFFECT_ADJUST_IMPROVEMENT_PROPERTY might be on plot as no Lua access? could then check the plot property the vampire castle t4 enables PROPERTY_AIRLIFT on vampire castle tiles. How could i then port it to city plot though, hmmm, the colletion is set as improvement, could set as capital city? This failed
- [x] POLICY ban framework for all state religions
- [ ] religion spread within civ tracker in lua for plot_prop req
## Great People:
- [ ] Golden Age modifiers, the whole extra Hammer/ extra gold per tile thing.
- [ ] Luonnotar buildup using Great Person action rather than Lua, so the ai can win with it. Issue with doing same action to make next building iteration. And enabling/disabling based on that.
- [ ] first to tech Great People or other things

## Nice to Have:
- [ ] world congress but without inclusive participation : bonus feature really
## Victory Conditions:
- [x] Altar of Luonnotar ez, A series of buildings, then a final project that requires last building. Only difficulty is making building not buildable, but still grantable by Great Person (like Hypatia)
- [x] Tower of Mastery Attach modifier that allows each tower to be built, if req_set: has_mana_1, has_mana_2... Tower of Mastery attach modifier has req_set: has_tower_1, ... Then victory condition on Tower of Mastery.
- [x] UI overrides to show correctly progress to victory
- [ ] Diplo modifiers to hate on close to winners
## Cultures Todo
- [ ] Cultures.artdef. Map buildings and units.
- Would be lovely if our asset budget lets us use Leugi's City Styles, for doviello, clan , hippus
- [ ] Unique unit Cultures: Clan, Infernal, Kuriotates(Centaurs)
- [ ] Minimal cultures: Mercurian (just do angel units, humans can be mercurian recruits), Dwarves, Elves, Dark Elves, Calabim(pale)
- [ ] Doviello Barbarian units.
- [x] Amurite buildings, (AncientEarth -> Mughal -> Colonial), MUGHAL
- [x] Balseraphs (AncientEarth -> Indonesian -> Colonial), SOUTHAM
- [x] Bannor (AncientEarth -> Scottish -> Colonial), AFRICAN
- [x] Calabim (AncientEarth -> DEFAULT -> Colonial), EURO
- [x] Elohim (AncientEarth -> EastAsian -> Colonial), ASIAN
- [x] Grigori (AncientEarth -> Baltic -> Colonial), MEDIT
- [ ] Hippus ((AncientEarth -> Mapuche -> Colonial) ASIAN    cant find mapuche building culture
- [ ] Infernal (new building style?) for now (AncientEarth -> ), CUSTOM
- [x] Kuriotates (AncientEarth -> America -> Colonial), CUSTOM MEDIT
- [x] Lanun (AncientWood -> Brazil -> Colonial), MEDIT
- [x] Malakim (AncientBrick - > SouthAfrican -> Colonial), AFRICAN
- [x] Mercurian (AncientBrick -> Mediterranean -> Colonial), EURO
- [x] Sheaim (AncientEarth -> SouthAmerican -> Colonial), INDIAN
- [x] Sidar (AncientEarth -> Baltic -> Colonial), EURO
- [ ] Khazad (AncientBrick -> NorthAfrican -> Colonial), CUSTOM EURO
- [ ] Luichuirp (AncientBrick -> NorthAfrican -> Colonial), CUSTOM EURO
- [ ] Ljosalfar (AncientWood -> Mediterranean -> Colonial), CUSTOM EURO
- [ ] Svartalfar (AncientWood -> Mediterranean -> Colonial), CUSTOM EURO
- [ ] Doviello (AncientEarth -> Cree -> Colonial), BARB  Cree is not working btw
- [x] Illian (AncientWood -> Scottish -> Colonial), EURO
- [ ] Clan of Embers (AncientEarth -> Cree -> Colonial), CUSTOM
- [ ] Change barbarians to Clan orc ethnicity
### Buildings
#### Redo District Placement
- [ ] Blasting Workshop(Workshop)
- [x!] Breeding Pit (Ordu)
- [?] Adventurers Guild (GuildHall)
- [x] Chancel of Guardians (GrandMasters Chapel)
- [x] Command Post (Pagoda)
- [x] Courthouse (Quens BiblioTheque)
- [x] Grove (Grove)
- [x] Herbalist (MEETING_HOUSE)
- [x] Hunting Lodge (Marae)
- [x] Infirmary (Chancery)
- [x] Inn (Consulate)
- [x] Mages Guild (Madrasa)
- [?] Shipyard (Shipyard)
- [ ] Shrine of the Champion (Kotoku-In)
- [?] Tavern (Meeting House)
- [ ] Grigori Tavern (Foreign Ministry lol)
- [x] Arena (Arena)
#### District Clutter
- [ ] Aqueduct from Aqueduct District Clutter 
- [ ] Carnival from Entertainment Complex Clutter
- [ ] Bath from Roman Bath District Clutter
#### Redo Landmarks Improvements
- [ ] Cave of Ancestors (Giant Head)
- [ ] Warrens (Cahokia Mound)
- [ ] Elder Council (Mekewap)
- [ ] Temple of the Hand (Monastery)
#### Redo Landmarks Wonder
- [ ] Bazaar of Mammon (Grand Bazaar)

#### Redo Landmarks Natural Wonders
- [ ] Mercurian Gate (Delicate Arch)
#### From elsewhere
- [ ] Archery Range (JNR_TARGET_RANGE)
- [ ] Governors Manor (JNR_MANSION)
- [ ] Dungeon (JNR_PRISON)
- [ ] Dwarven Smithy (JNR_MANUFACTORY?)
- [ ] Harbor (JNR_HARBOR_CITY_CENTRE)
- [ ] Lanun Harbor (JNR_HARBOR_VARIANT_CITY_CENTRE)
- [ ] Siege Workshop (JNR_CASEMATES)
- [ ] Smugglers Port (JNR_HAVEN)
- [ ] Tower of Necromancy (LEANING_TOWER_OF_PISA)
- [ ] Tower of Elements (Porcelain Tower)
- [ ] Thousand Slums (Kowloon Walled City?)

#### Could find someone elses
- [ ] Alchemy Lab
- [ ] Tailor
- [ ] Gambling House
- [ ] Desert Shrine
- [ ] Smokehouse
- [ ] Sculptors studio
#### Check if exist
- [ ] Citadel of Light
#### Custom
- [ ] Aquae Sucellus
- [ ] Asylum
- [ ] Celestial Compass
- [ ] Freak Show
- [ ] Planar Gate
- [ ] Pallens Engine
- [ ] Adularia Chamber
- [ ] Hall of Mirrors
- [ ] Jeweler
- [ ] Reliquary
- [ ] Code of Junil
- [ ] Dancing Bear, Gorilla/Lion/Tiger/Wolf Cage, Spider pen
- [ ] Human/Dwarf/Elf/Orc Cage
- [ ] Grand Menagerie
- [ ] Guild of Hammers (or some cool wonder)
- [ ] Heroic Epic (Monument variant but bigger, cooler?)
- [ ] National Epic (Monument variant but bigger, cooler?)
- [ ] Nox Noctis (no idea what it looks like)
- [ ] Song of Autumn (no idea)
- [ ] Stigmata on the Unborn
- [ ] Tablets of Bambur
- [ ] The Necronomicon
- [ ] Obsidian Gate
- [ ] The Nexus
- [ ] Pillar of Chains
- [ ] Ride of the Nine Kings (no idea)
- [ ] Soul Forge
- [ ] Tower of Eyes
#### Exclamation
- [ ] Palgum
#### Equipment Buildings
- [ ] Crown of Akharien (Little square, its on a plinth in centre)
- [ ] Infernal Grimoire
- [ ] Mokka's Cauldron
- [ ] Sylivens Lyre
- [ ] Dragons Horde
### Improvements
- [ ] Hamlet
- [ ] Cottage
- [ ] Village
- [ ] Town
- [ ] Enclave
- [ ] Pirate Cove
- [ ] Pirate Harbor
- [ ] Mana Well
- [ ] Castle
- [ ] Citadel
- [ ] Workshop
- [ ] Winery
### Resources
- [ ] Nightmare
- [ ] Toad
- [ ] Mana Tints ( and change to Gypsum)

### Units
#### Rebin
- [x] Losha
- [x] Vampire
- [x] Vampire Lord
- [x] Diseased Corpses
- [x] Drown
- [x] Saverous
#### Retint
- [x] Shadowrider
- [ ] Eidolon
#### Rejig
- [ ] Firebow
- [ ] Longbowman
- [ ] Nightwatch
- [ ] Marksman
- [ ] Freak
- [ ] Supplies (cultist wagon + builder)
- [ ] Assassin
- [ ] Ghost
- [ ] Boarding Party
- [ ] Paramander
- [ ] Divided Soul
- [ ] Flagbearer
- [ ] Harlequin
- [ ] Mimic
- [ ] Revelers
- [ ] Son of the Inferno
- [ ] Courtesan
- [ ] Shadow
- [ ] Slave
- [ ] Govannon
- [ ] Guybrush
- [ ] Hemah
- [ ] Loki
- [ ] Mary Morbus
- [ ] Rathus
- [ ] Donal
- [ ] Gibbon
- [ ] Chalid
#### Rejig with Custom Culture
- [ ] Rantine
- [ ] Lizardman Ranger
- [ ] Repentant Angel
- [ ] Sphener
- [ ] Angel
- [ ] Angel of Death
- [ ] Herald
- [ ] Ophanim
- [ ] Seraph
- [ ] Valkyrie
- [ ] Einherjar (alpha channel variant)
- [ ] Imp
- [ ] Balor
- [ ] Chaos Marauder
- [ ] Mardero
- [ ] Meshabber
- [ ] Alazkhan
- [ ] Arthendain
- [ ] Gilden
- [ ] Maros
- [ ] Orthus
- [ ] Goblin Archer
- [ ] Lizardman
- [ ] Lizardman Assassin
- [ ] Lizardman Druid
- [ ] Ogre
- [ ] Ogre Warchief
- [ ] Dwarven Shadow
- [ ] Yvain
#### Custom Parts 
- [ ] Boar Rider
- [ ] Bison Rider
- [ ] Fyrdwell
- [ ] Nyxkin
- [ ] Hornguard
- [ ] WolfRider
- [ ] Camel Archer
- [ ] TumTum
- [ ] Stephanos
- [ ] Buboes
- [ ] Yersinia
- [ ] Ars Moriendi
- [ ] Hyborem
- [ ] Fawn
- [ ] Satyr
- [ ] Soldier of Kilmorph
- [ ] Dwarven Druid
#### Custom Model
- [ ] Hawk
- [ ] Floating eye
- [ ] Werewolf (w/ Ravenous/Greater variants)
- [ ] Golems
- [ ] Centaur (Variants: Charger, Lancer, Archer)
- [ ] Guardian Vines
- [ ] Treant
- [ ] Generic Equipment Chest (keep all same for now)
- [ ] Puppet
- [ ] Succubus
- [ ] Wilboman
- [ ] Auric Ascended
- [ ] Avatar of Wrath
- [ ] Dragon (Abashi, Acheron, Drifa, Eurabatres)
- [ ] Hellhound (Beast of Agares variant scaled)
- [ ] Basium
- [ ] Herne
- [ ] Meteor
- [ ] Minotaur
- [ ] Sailors Dirge
- [ ] Giant Tortoise (Variant War Tortoise)
- [ ] Scorpion
- [ ] Earth Elemental
- [ ] Barnaxus
#### Custom Model and Animations
- [ ] Spider attackers (Giant Spider,  Baby Spider)
- [x] Arm attack (Golems, Stygian Guard, treant Wait just copy Zombies)
- [ ] Claw attack (Werewolves, Pit Beast)
- [ ] Mouth Attackers (Griffon, Manticore)
- [ ] Big Club attackers (Hill Giant, Ogres)
#### Cultures
- [ ] Elf
- [ ] Dwarf
- [ ] Infernal
- [ ] Orc
- [ ] Goblin
- [ ] Lizardman
- [ ] Frostling
- [ ] Ogre
- [ ] Angel
- [ ] Skeleton (Skeleton, Wraith, Ars, Bone Golem, Lich)
- [ ] Liquid (Tar demon, Water Elemental)
#### VFX
- [ ] Air Elemental  (We now know Ambient VFX is possible. Just need to hide unit (we have done this before accidentally by calling non-existant assets, but will the VFX stay?))
- [ ] Fire Elemental
- [ ] Fireball
- [ ] Mistform
- [ ] Severed Soul
- [ ] Lightning Elemental
- [ ] Pyre Zombie
#### Partial VFX
- [ ] Azer   Possible, look at Arthur sword, but its not an FX. unsure what it is as in blp. find another instance?
- [ ] Ira
- [ ] SandLion
- [ ] Shade
- [ ] Spectre
- [ ] Pyre Zombie
#### Unsure
- [ ] Myconid
#### Reuse
- [ ] Druid as Eagle Warrior
- [ ] Paramander as spearman
- [ ] Shadowrider as Keshig?
## Design Todo
- [ ] Display SuperSpecialists in the City UI somehow 
- [ ] Reexamine if buildings path and districts makes sense.
- [ ] come up with eurekas
- [ ] Use eurekas as proxies for techs where soft requirements (i.e. Trade uses something from Sailing or Horseback riding to Eureka? problem is has to be only opposing )
- [ ] City States didnt exist in civ iv, so dont know how i would approach it? Could just have them be a generic race (orc, human, dwarf, elf), or inherit the governance of nearby civs, like Age of Wonders
- [ ] Do we swap Amenities and Housing as Amenities and Housing?
## Polish Todo
- [x] Trait Descriptions
- [ ] Limit Tech Tree to Renaissance Era techs, and make tree look better 

## Bugs
- [ ] Why are civ colours always green blue?
- [ ] Why does UnitPanel buttons always show on reload of game?
- [ ] Accuracy promo granted on aggressive?
- [ ] Basium spawning crashing game, but Infernal not? we are using a property to gate, but maybe its set after city transfer so stuck in loop
- [ ] use MODIFIER_PLAYER_UNITS_GRANT_PROMOTION instead of promotion lua grant system?
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
  - [ ] Give recon line units Amphibious and Marsh strength as Lizardmen. Also druid. And lacks Entangle.
  ##### Doviello

  ##### Calabim
  Vampirism, a unit on a city can cast feed, reducing the pop of the city by one, and gaining xp. also causes unhappiness, building that gets prod from unhappiness.

  ##### Ilians
  - [x] extra yields on snow terrain, like Auckland, Canada

  ##### Svartalfar
  - [x] Recon units (scout, skirmisher etc.) get a damage buff on attack, but not on defense