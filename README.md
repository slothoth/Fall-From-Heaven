# Welcome
Mod to faithfully recreate the glorious Civ IV FallFromHeaven mod by Kael in Civ VI. 

To download the mod, git clone the repo. Put the downloaded folder in your Sid Meier's Civilization VI/Sid Meier's Civilization VI/Mods/ folder. If you want to see the latest art assets, download the Platforms folder in Releases and place it in the repo.
One the mod is out of Alpha (probably when art assets for three civilizations are done), I will publish on Steam Workshop.

Check out my [website](https://slothoth.github.io/Fall-From-Heaven/) where I will be detailing some of the progress I have made, cool screenshots of assets, and mechanics I have BEATEN civ vi into submission to get to work.

# Introduction
Hi! Development on this port of Fall From Heaven to Civ VI has been a long time coming. And is still on-going. This Alpha is designed to get some feedback on the features I''ve implemented, and how much sense they make in the VI engine. For example, units have 1 movement in keeping with FFH, but the switch to hexes and 3 tile radius cities means this is slowing down units quite a lot. So I am unsure whether all units should gain a movement, or keep it as is. So i would love to hear feedback on it. I currently have a github page where you could list technical issues, and may set up a Discord or other means of gathering feedback or community.
In keeping with its incomplete nature, I am aware that a lot of art is perhaps lower quality. In particular, the leader art is going from 256x256 images to roughly 1024x1024. Thats a 16 times increase, and it reveals a lot of flaws in the evocative oil painted art. In addition, separating out the backgrounds has been a lot of manual work. I am not an artist, digital or otherwise, and this has been a crash course for me, so they are rough around the edges.
Some art looked so bad when upscaled, I turned to using AI tools to both upscale and fine-tune portions of the image that made no sense at scale. With the current release, it is about half and half unopinionated normal upscaling, and half AI-assisted work. The leader buttons still show the older, upscaled versions however. I am aware some people are morally against AI image generation, for a multitude of reasons. From my perspective, using it in a not-for-profit way is acceptable. As I have said before, I am not an artist, so this project would not have been possible without it. It helped me throughout the process, such as new Resource Icons and even textures for 3d models, like the Wood Golem, Iron Golem, and Lizardman. Depending on the reception, I could make a version that strips all that out. But it would be a vastly inferior product.
## Completed Features
Here is a list of the features that are implemented:
- All civs and Leaders. Most every leader and civ trait, bar Kuriotates Sprawling, Svartalfar Great person kidnapping, and  the Commando ability to use enemy roads due to engine limitations.
- All units and their icons. Modelling units is still ongoing, so some units are in a incomplete state, or are placeholders. If an Angel looks like a Warrior, thats why.
- Unit ethnicities, ensuring the demons are well, demonic, and the orcs are orcish. Angels are still to do.
- Most unique spells and abilities.
- Religions and State Religions, and their unlocks.
- Mana Affinities and Resource Strength from Weapons. Equipment affinity (Rod of Winds) not yet implemented.
- Barbarian lairs and the events from clearing them.
- Equipment
- Victory Types: Tower of Mastery and Altar of Lunnotar are fully functional.
- Tech Tree: Has been split in two, into Techs and Civics. This is probably the biggest change made, and mostly came because it was not possible to fit the tech tree within the UI due to strange limitations. I may revisit this to fix it. I have tried to split it roughly so religious and policies (civics) are in the culture tree, and magic and technology in the Tech tree.
- Contributing Technology Prereqs: Like how Sorcery requires only one of Alteration, Divination, Elementalism or Necromancy.
- Transient Buffs: Like Haste or Blur, abilities that wear off over time.
- Infernal/Mercurian summoning.
- Branching Unit Upgrades. In VI, Units may only upgrade into one other unit. This mod allows for upgrading into other units as in FFH.
- Combat spread debuffs like Diseased, Wither.
- Buildings unlocked by resource access or number of libraries, like the Tower of Necromancy or the Great Library.
- Golden Age/Financial Commerce on tiles with that yield.
- Unique Heroes for each civ/religion, that act like a unit Wonder. Experience gain per turn on eligible heroes and magic units.
- Improvement upgrades from working, i.e. Cottage->Hamlet etc.
- Resource conversion by improvement, i.e. Mana Node conversion.
- Spell Buildings like Inspiration, Hope. Implemented as passives, and work when within the cities borders, to accomodate 1 unit per turn. Does not stack.
- Natural Wonders. Still have some art to do, so some appear to occupy more than one tile, or look like a geothermal vent, for now.
- Racial abilities. Khazad built units will be Dwarven, with bonuses on hills. Ljosalfar Elven etc. With exceptions on units where ethnicity is specified or not relevant (like say, Hill Giants).
## Partly Implemented
- Magic Combat Strength. Units have magic combat strength bonuses as they should. However resistance or vulnerability to that combat strength is limited to a unit level. I.e. a Wood Golem is Vulnerable to Fire, so takes more damage from Fire Combat Strength. But there is no way currently to make the Fire Resistance promotion reduce Fire Combat Strength.
- Commerce and Sliders: Commerce is implemented as the Faith yield. Which is converted in cities to Science, Culture and Gold. Currently its split into thirds, but once I''ve built the UI for it, you can adjust the conversion with sliders.
- Specialists. VI had far less emphasis on Specialists, and placed them in Districts. To allow the AI to interact with Specialists, I have elected to do the same. As a result, buildings that allow slotting a specialist will be housed in that district. Campus=Sage, Industrial Zone=Engineer, Theatre Square=Bard, Commercial Hub=Merchant, Holy Site=Priest. So to slot a Priest, you would slot a population into that district. Wonders and policies that allow extra specialists are implemented using a script so dont need this.
- National Units. Units that are only buildable when you have less than 4. Unfortunately, this is not respected for upgrading.
- Erebus map script. Ported from Python to Lua, with many headaches along the way. It works, but is a bit slow to generate maps, and has a tendency to make the same maps.
- Tech Tree Disconnects: Some technologies/civics are easier to access, because the prerequisite now lives in the Civic/Tech tree, and cannot be a prerequisite. This is most aggregious with Feral Bond being accessible turn 1. There is a plan to fix this with dummy prerequisites however.
- Magic promotions on non-magic units, like Vampirism granting up to Death II, Shadow II and Body II. As is, Vampirism just grants Shadow I and Body I and Death I. Similarly, units like the Brujah or Chalid cannot gain promotions with spells. As each would need a custom promotion class.
- Alignment. Civs change alignment on changing State Religions, and start with a default alignment. Druids, Eidolons and Paladins are limited by alignment. Howver, there is no diplomatic relation loss from differing alignments.
- Armageddon Counter. Contributions and reductions to the Armageddon Counter all works. However, there is no UI to display it currently. Events from the Armageddon counter should work, however Hell terrain is not yet implemented.
- Acheron city spawning. Acheron will spawn, but is not held and will go roam about!
- 
## Not currently Implemented:
- First strikes. As a Stop-gap, units get Combat Strength instead.
- Great People recruitment per city. Currently it is done as a global amount, as in VI.
- Adaptive and Insane traits. Planned soon.
- World spells. Interface built, but each spell not yet built.
- Overcouncil/Undercouncil. Currently do not have a way to exclude civs from world congress, or call it earlier. Also was causing CTDs.
- Music system. Music in VI is implemented on a per civ level, and also requires quite a lot of work to even implement like that. Whereas FFH has different music based on civ alignment, religion, or war status.
- Illusion units that cannot kill units, only damage them. Seems relatively impossible in VI without DLL work
- Animal units spawning in the Wilderness, making Dens
- Events system (like the governor assassinated event)
- Tolerant Trait of Elohim. While there are some examples of this done like the Civ Conquer mod, that is on a player level, not per city.
- Doviello scavenging prod for nearby city on killing unit. I thought I needed to do this, but I think this is from a Modmod.
## Makes no Sense in VI
- Marksman attacking the weakest unit in the stack. Stacks don''t exist anymore, so makes no sense. With that goes Guardsman.
- Withdrawal chance. As units automatically withdraw in VI, this cannot be implemented. I do hope to build a solution for Loki though.'

## Little Quirks
- [ ] We use hidden promotions to allow different spell sphere promotions, or promotions unlocked by techs like Scourge. As a result, the number of promotions your unit has will look a lot higher than it is.

## Some things on the Todo List:
### Armageddon Counter:
- [ ] Hijack Global Warming panel. We probably just steal the UI design of it.  
- [ ] Events to implement still: Warning popup, Blight, 100Armageddon

### Lua Actives:
- [ ] An ability that allows giving an ability to another unit, if it has enough promotions     Button implemented in Lua. Unit:GetExperience():GetLevel()
- [ ] some units can do duels with another unit for xp          lua button, need to take target adjacent tile logic used in QinBuilders on Machu Picchu
- [ ] Arenas Gladiator
- [ ] Trade Mission, Gold for distance, gold for city size
- [ ] Culture Bomb, big grant of culture, and border expansion
- [ ] Bulbing techs.
- [ ] Dark elf kidnapping superSpecialist ( apply a modifier  with the reverse values of a superspecialist) and spawn a great person. 
- [ ] Puppets, inheriting from summoner
- [ ] Resurrection System  For Hero level, Use pPlayer:SetProperty() on UnitRemovedFromMap (assuming thats the death event). Then on casting Resurrection, check unit's owner for that hero dead property. Much harder I think for the Phoenix promotion, there is the CanRetreatWhenCaptured that vampires use. But how can I hook into that temporarily? UnitCaptured is an Event, but that trigger on units being killed, somehow works for Vampires. 
- [ ] Switch player midgame              very hard
- [ ] Birthright regained (world spell back)
- [ ] Blood of the Phoenix (let all current units be able to respawn in cap once) probably cant do as modifier sadly as no ability to respawn
- [ ] Genesis (upgrade terrain in civ)
- [ ] Rites of Oghma (new mana resources spawn)
- [ ] Purge the Unfaithful (there is a modifier to remove for inquisition, but we have a different definition of state religion)
- [ ] The Deepening (convert some desert to plains, plains/grassland to tundra, tundra to snow. cba with blizards tho.)

### Hard but minor:
- [ ] Blizzard weather, (implement like GS blizzard but gives snow)
- [ ] Hall of Mirrors clone spawning
- [ ] Hidden nationality units

### Trait System:
- [ ] Implement Barbarian trait
- [ ] Implement Perpentach insanity and ui indicator
- [ ] Implement Cassiel adaptive and ui selector
- [ ] Implement Commando roads stuff
- [ ] implement diplo effects for each trait?
- [ ] Infernal no amenity cost? as they get no unhappiness. (+2 amenities per 2 pop to balance out cost?)
- [ ] Diplo modifiers to hate on those close to victory

### Cultures Todo
- [x] Cultures.artdef. Map buildings and units.
- Would be lovely if our asset budget lets us use Leugi's City Styles, for doviello, clan , hippus
- [x] Unique unit Cultures: Clan, Infernal, Kuriotates(Centaurs)
- [ ] Minimal cultures: Mercurian (just do angel units, humans can be mercurian recruits), Dwarves, Elves, Dark Elves, Calabim(pale)
- [x] Doviello Barbarian units.
- [ ] Palaces?
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
- [ ] Convert all but Illian/Doviello euro civs to mediterreanean

#### Rejig
- [ ] Boarding Party
- [ ] Paramander
- [ ] Divided Soul
- [ ] Flagbearer
- [ ] Harlequin
- [ ] Revelers
- [ ] Courtesan
- [ ] Govannon
- [ ] Guybrush
- [ ] Hemah
- [ ] Loki
- [ ] Rathus
- [ ] Donal
- [ ] Gibbon
- [ ] Chalid
#### Rejig with Custom Culture
- [ ] Repentant Angel
- [ ] Sphener
- [ ] Angel
- [ ] Angel of Death
- [ ] Herald
- [ ] Ophanim
- [ ] Seraph
- [ ] Valkyrie
- [ ] Einherjar (alpha channel variant. impossible)
- [ ] Imp
- [L] Balor
- [ ] Chaos Marauder
- [ ] Mardero
- [L] Meshabber
- [L] Ogre
- [L] Ogre Warchief
- [ ] Yvain
#### Custom Parts 
- [ ] Boar Rider
- [ ] Bison Rider
- [ ] Fyrdwell
- [L] Nyxkin
- [L] Hornguard
- [ ] TumTum
- [ ] Stephanos
- [ ] Buboes
- [ ] Yersinia
- [ ] Ars Moriendi
- [ ] Hyborem
- [ ] Dwarven Druid
#### Custom Model
- [ ] Hawk
- [ ] Floating eye
- [ ] Werewolf (w/ Ravenous/Greater variants)
- [L] Golems
- [ ] Guardian Vines
- [ ] Treant
- [X] Generic Equipment Chest (keep all same for now)
- [ ] Puppet
- [X] Wilboman
- [ ] Auric Ascended
- [ ] Avatar of Wrath
- [ ] Hellhound (Beast of Agares variant scaled)
- [ ] Meteor
- [ ] Sailors Dirge
- [ ] Giant Tortoise (Variant War Tortoise)
- [ ] Scorpion
#### Custom Model and Animations
- [ ] Spider attackers (Giant Spider,  Baby Spider)
- [x] Arm attack (Golems, Stygian Guard, treant Wait just copy Zombies)
- [ ] Claw attack (Werewolves, Pit Beast)
- [ ] Mouth Attackers (Griffon, Manticore)
- [ ] Big Club attackers (Hill Giant, Ogres)
#### Cultures
- [ ] Elf
- [ ] Dwarf
- [L] Orc
- [ ] Goblin
- [ ] Frostling
- [ ] Angel
- [ ] Liquid (Tar demon, Water Elemental)
#### VFX
- [L] Mistform
#### Partial VFX
- [ ] Ira
- [ ] SandLion
- [ ] Shade
- [L] Pyre Zombie
#### Unsure
- [ ] Myconid
### Design Todo
- [ ] Display SuperSpecialists in the City UI somehow 
- [ ] Do we swap Amenities and Housing as Amenities and Housing?
- [ ] We are making districts easy to get but not worth anything. How to fix trade routes sucking? Also how do we make sure district sonly unlock whena building needs them, but with multiple techs/civics

### Bugs
- [L] use MODIFIER_PLAYER_UNITS_GRANT_PROMOTION instead of promotion lua grant system? THIS WILL NEVER WORK, PROMOS HAVE TO BE IN RIGHT CLASS AND IMMEDIATELY AVAILABLE
- [ ] Both PLAYER_BAN_UNIT_PRODUCTION and reverse PLAYER_ALLOW_UNIT (nihang) dont seem to stop upgrading into next unit tier. More fuel for custom upgrade system
- [ ] Upgrade system also takes precedence in removing obsolete units even if the replacement is not buildable due to a no BuildingPrereq for example
- [ ] Use CanTrain = 0 for only upgradable-to-units (todo Immortal?, Eater of Dreams, probably more)


# Attributions:
Many icons used from Game-Icons.net
Lava and Ice material from https://ambientcg.com
Deliverator animal and T rex models from Wildlife mod.
Skeleton model from SailorCat, IronicGame
