import xmltodict

debug_string = ""
unique_units = """Eater_of_Dreams, Sheaim
Moroi, Calabim
Pyre_Zombie, Sheaimp
Devout, Elohim
Chanter, Amurite
Ghost, Sidar
Imp, Infernals
wood_golem, Luchuirp
Myconid, Khazad
Balor, Infernal
Brujah, Calabim
Circle_Of_Urd, Doviello
Clockwork_Golem, Luchiuirp
Dwarven_Cannon, Khazad
Trebuchet, Khazad
Dragon_Slayer, Grigori
Iron_Golem, Luchuirp
Mimic, Balseraphs
Vampire, Calabim
Centaur_Charger, Kuriotates
Flurry, Ljosalfar
Luonnotar, Grigori
Camel_archer, Malakim
Centaur_archer, Kuriotates
Fyrdwell, Ljosalfar
Nyxkin, Svartalfar
Centaur_Horserider, Kuriotates
Divided_Soul, Sidar
Hellhound, Infernal
Bone_Golem, Luchuirp
Ogre_WarChief, Embers
Skuld, Doviello
Vampire_Lord, Calabim
Bison_Rider, Doviello
Centaur_Lancer, Kuriotates
Death_Knight, Infernal
Hornguard, Khazad
War_Tortoise, Lanun
Lightbringer, Malakim
Firebow, Amurite
Gargoyle, Luchuirp
Illusionist, Svartalfar
Wizard, Amurite
Monk, Elohim
Ophanim, Mercurian
Nullstone_Golem, Luchuirp
Stoneskin_Ogre, Embers
Verdandi, Doviello
Pirate, Lanun
Airship, Kuriotates
Harlequin, Balseraph
Repentant_angel, Mercurian
Goblin, Embers
Seraph, Mercurian
Courtesan, Balseraph
Dwarven_Shadow, Khazad
Valkyrie, Mercurian
Beastman, Doviello
Bloodpet, Calabim
Mud_golem, Luchuirp
Angel_of_Death, Mercurian
Centaur, Kuriotates
Sons_of_Asena, Doviello
Boarding_Party, Lanun
Taskmaster, Balseraph"""
# [f'TRAIT_CIVILIZATION_UNIT_CALABIM{i["Name"][4:]}' for i in buildable_only if 'VAMPIRE' in i['Name']]
# Flagbearer, Bannor    Grigori_medic, Grigori
#
# only aesthetic differences:
double_civ_units_str = """Goblin, Embers, Barbarian
Lizardman, Embers, Barbarian
Lizardman_ranger, Embers, Barbarian
Lizardman_assassin, Embers, Barbarian
Lizardman_Beastmaster, Embers, Barbarian
Ogre, Embers, Barbarian
Shaman, Embers, Doviello
Wolf_rider, Embers, Barbarian
Boar_Rider, Khazad, Luchuirp
Dwarven_Slinger, Khazad, Luchuirp
Dwarven_Druid, Khazad, Luchuirp
Javelin_Thrower, Doviello, Illian"""
# swordsman
# now lets catch units made for multiple civs
# LIZARDMAN_ASSASSIN, Lizardman, Lizardman_Beastmaster, Lizardman_Ranger, Javelin Thrower, Dwarven Slinger, Shaman
# Ogre, Dwarven Druid, Boar_Rider, Wolf rider

# AND HEROES
unique_heroes = """ABASHI, sheaim
ACHERON, Barbarian
ALAZKAN, Svartalfar
Barnaxus, Luchuirp
Basium, Mercurian
Black_Wind, Lanun
Corlindale, Elohim
Donal, Bannor
Eurabatres, Kuriotates
Govannon, Amurite
Guybrush, Lanun
Herne, Kuriotates
Hyborem, Infernal
Loki, Balseraph
Losha, Calabim
Lucian, Doviello
Magnadine, Hippus
Maros, Khazad
Rantine, Embers
Rathus, Sidar
Teutorix, Malakim
War_Machine, Doviello
Wilboman, Illian
TumTum, Barbarian"""

# Religion Specific:
religious_units_str = """Kithra, FELLOWSHIP_OF_LEAVES
Satyr, FELLOWSHIP_OF_LEAVES
Fawn, FELLOWSHIP_OF_LEAVES
Yvain, FELLOWSHIP_OF_LEAVES
DISCIPLE_FELLOWSHIP_OF_LEAVES, FELLOWSHIP_OF_LEAVES
PRIEST_OF_LEAVES, FELLOWSHIP_OF_LEAVES
HIGH_PRIEST_OF_LEAVES, FELLOWSHIP_OF_LEAVES
DISCIPLE_THE_ASHEN_VEIL, ASHEN_VEIL
PRIEST_OF_THE_VEIL, ASHEN_VEIL
HIGH_PRIEST_OF_THE_VEIL, ASHEN_VEIL
DISEASED_CORPSE, ASHEN_VEIL
meshabber, ASHEN_VEIL
Rosier, ASHEN_VEIL
BEAST_OF_AGARES, ASHEN_VEIL
THANE_OF_KILMORPH, RUNES_OF_KILMORPH
PRIEST_OF_KILMORPH, RUNES_OF_KILMORPH
HIGH_PRIEST_OF_KILMORPH, RUNES_OF_KILMORPH
mithril_golem, RUNES_OF_KILMORPH
DWARVEN_SOLDIER_RUNES', RUNES_OF_KILMORPH
Paramander, RUNES_OF_KILMORPH
DISCIPLE_OCTOPUS_OVERLORDS, OCTOPUS_OVERLORDS
PRIEST_OF_THE_OVERLORDS, OCTOPUS_OVERLORDS
HIGH_PRIEST_OF_THE_OVERLORDS, OCTOPUS_OVERLORDS
DROWN, OCTOPUS_OVERLORDS
Lunatic, OCTOPUS_OVERLORDS
Saverous, OCTOPUS_OVERLORDS
Stygian Guard, OCTOPUS_OVERLORDS
DISCIPLE_THE_ORDER, THE_ORDER
PRIEST_OF_THE_ORDER, THE_ORDER
HIGH_PRIEST_OF_THE_ORDER, THE_ORDER
CRUSADER, THE_ORDER
Valin, THE_ORDER
DEMAGOG, THE_ORDER
DISCIPLE_EMPYREAN, EMPYREAN
PRIEST_OF_THE_EMPYREAN, EMPYREAN
HIGH_PRIEST_OF_THE_EMPYREAN, EMPYREAN
RATHA, EMPYREAN
RADIANT_GUARD, EMPYREAN
CHALID_ASTRAKEIN, EMPYREAN
Shadowrider, COUNCIL_OF_ESUS
NIGHTWATCH, COUNCIL_OF_ESUS
GIBBON, COUNCIL_OF_ESUS
SHADOW, COUNCIL_OF_ESUS"""

kept_units = ['UNIT_SETTLER', 'UNIT_BUILDER', 'UNIT_TRADER', 'UNIT_GREAT_GENERAL', 'UNIT_GREAT_ENGINEER',
              'UNIT_GREAT_MERCHANT', 'UNIT_GREAT_PROPHET', 'UNIT_GREAT_SCIENTIST', 'UNIT_GREAT_ARTIST',
              'UNIT_SCOUT', 'UNIT_WARRIOR', 'UNIT_ARCHER', 'UNIT_GALLEY', 'UNIT_HORSEMAN',
              'UNIT_CROSSBOWMAN']

units_changed_tech = ['UNIT_CATAPULT', 'UNIT_SWORDSMAN', 'UNIT_KNIGHT', 'UNIT_RANGER',
                      'UNIT_FRIGATE', 'UNIT_CARAVEL', 'UNIT_PRIVATEER']

units_but_for_unique_civs = ['UNIT_TREBUCHET']

compat_units = ['UNIT_GREAT_ADMIRAL', 'UNIT_GREAT_WRITER', 'UNIT_GREAT_MUSICIAN']

kept_units.extend(units_changed_tech)
kept_units.extend(units_but_for_unique_civs)
kept_units.extend(compat_units)

to_keep_but_modify = {'UNIT_SLINGER': 'UNIT_DWARVEN_SLINGER', 'UNIT_HEAVY_CHARIOT': 'UNIT_CHARIOT',
                      'UNIT_BOMBARD': 'UNIT_CANNON', 'UNIT_MUSKETMAN': 'UNIT_ARQUEBUS',
                      'UNIT_MAN_AT_ARMS': 'UNIT_CHAMPION', 'UNIT_NORWEGIAN_BERSERKER': 'UNIT_BERSERKER',
                      'UNIT_SCYTHIAN_HORSE_ARCHER': 'UNIT_HORSE_ARCHER',
                      'UNIT_SKIRMISHER': 'UNIT_LONGBOWMAN'}

keep_art_for = {'UNIT_VAMPIRE': 'UNIT_VAMPIRE_LORD'}

excludes_from_four = ['UNIT_WORKBOAT', 'UNIT_WORKER']

upgrade_tree = {'UNIT_WARRIOR': ['UNIT_AXEMAN', 'UNIT_ARCHER'],
                'UNIT_AXEMAN': ['UNIT_CHAMPION', 'UNIT_CHARIOT'],
                'UNIT_CHAMPION': ['UNIT_IMMORTAL', 'UNIT_EIDOLON', 'UNIT_PALADIN', 'UNIT_BERSERKER', 'UNIT_PHALANX',
                                  'UNIT_KNIGHT'],
                'UNIT_ARCHER': ['UNIT_LONGBOWMAN', 'UNIT_CROSSBOWMAN', 'UNIT_HORSE_ARCHER'],
                'UNIT_LONGBOWMAN': ['UNIT_CROSSBOWMAN', 'UNIT_ARQUEBUS', 'UNIT_MARKSMAN'],
                'UNIT_ADEPT': ['UNIT_MAGE'],
                'UNIT_MAGE': ['UNIT_ARCHMAGE'],
                'UNIT_CHARIOT': ['UNIT_KNIGHT'],
                'UNIT_HORSEMAN': ['UNIT_CHARIOT', 'UNIT_HORSE_ARCHER'],
                'UNIT_HORSE_ARCHER': ['UNIT_KNIGHT'],
                'UNIT_SCOUT': ['UNIT_HUNTER', 'UNIT_HORSEMAN'],
                'UNIT_HUNTER': ['UNIT_RANGER', 'UNIT_ASSASSIN'],
                'UNIT_RANGER': ['UNIT_BEASTMASTER', 'UNIT_DRUID'],
                'UNIT_ASSASSIN': ['UNIT_MARKSMAN', 'UNIT_SHADOW'],
                'UNIT_CATAPULT': ['UNIT_CANNON'],
                'UNIT_GALLEY': ['UNIT_CARAVEL', 'UNIT_PRIVATEER', 'UNIT_FRIGATE'],
                'UNIT_TRIREME': ['UNIT_PRIVATEER', 'UNIT_FRIGATE'],
                'UNIT_CARAVEL': ['UNIT_GALLEON'],
                'UNIT_FRIGATE': ['UNIT_MAN_O_WAR', 'UNIT_QUEEN_OF_THE_LINE'],
                'UNIT_SAVANT': ['UNIT_RITUALIST', 'UNIT_MAGE'],
                'UNIT_RITUALIST': ['UNIT_PROFANE', 'UNIT_EIDOLON', 'UNIT_DRUID', 'UNIT_PALADIN'],
                'UNIT_DISEASED_CORPES': ['UNIT_EIDOLON'],
                'UNIT_ECCLESIASTIC': ['UNIT_VICAR'],
                'UNIT_VICAR': ['UNIT_LURIDUS', 'UNIT_PALADIN', 'UNIT_DRUID', 'UNIT_EIDOLON'],
                'UNIT_RADIANT_GUARD': ['UNIT_RATHA', 'UNIT_CHAMPION'],
                'UNIT_RATHA': ['UNIT_KNIGHT'],
                'UNIT_DISCIPLE_OCTOPUS_OVERLORD': ['UNIT_PRIEST_OF_THE_OVERLORDS', 'UNIT_STYGIAN_GUARD'],
                'UNIT_PRIEST_OF_THE_OVERLORDS': ['UNIT_HIGH_PRIEST_OF_THE_OVERLORDS', 'UNIT_EIDOLON', 'UNIT_DRUID',
                                                 'UNIT_PALADIN'],
                'UNIT_DROWN': ['UNIT_STYGIAN_GUARD'],
                'UNIT_STYGIAN_GUARD': ['UNIT_EIDOLON'],
                'UNIT_LUNATIC': ['UNIT_BERSERKER'],
                'UNIT_NIGHTWATCH': ['UNIT_ASSASSIN', 'UNIT_SHADOWRIDER'],
                'UNIT_DISCIPLE_OF_LEAVES': ['UNIT_PRIEST_OF_LEAVES', 'UNIT_RANGER'],
                'UNIT_PRIEST_OF_LEAVES': ['UNIT_HIGH_PRIEST_OF_LEAVES', 'UNIT_EIDOLON', 'UNIT_DRUID', 'UNIT_PALADIN'],
                'UNIT_FAWN': ['UNIT_SATYR'],
                'UNIT_DISCIPLE_THE_ORDER': ['UNIT_PRIEST_OF_THE_ORDER', 'UNIT_CRUSADER'],
                'UNIT_PRIEST_OF_THE_ORDER': ['UNIT_HIGH_PRIEST_OF_THE_ORDER', 'UNIT_EIDOLON', 'UNIT_DRUID',
                                             'UNIT_PALADIN'],
                'UNIT_CRUSADER': ['UNIT_PALADIN'],
                'UNIT_DISCIPLE_RUNES_OF_KILMORPH': ['UNIT_PRIEST_OF_KILMORPH', "UNIT_PARAMANDER"],
                'UNIT_PRIEST_OF_KILMORPH': ['UNIT_HIGH_PRIEST_OF_KILMORPH', 'UNIT_EIDOLON', 'UNIT_DRUID',
                                            'UNIT_PALADIN'],
                'UNIT_DWARVEN_SOLDIER_RUNES': ['UNIT_PARAMANDER'],
                'UNIT_PARAMANDER': ['UNIT_PALADIN'],
                'UNIT_ROYAL_GUARD': ['UNIT_KNIGHT'],
                'UNIT_ADVENTURER': ['UNIT_WARRIOR', 'UNIT_SCOUT', 'UNIT_ADEPT'],
                'UNIT_ANGEL': ['UNIT_ANGEL_OF_DEATH', 'UNIT_HERALD', 'UNIT_OPHANIM', 'UNIT_REPENTANT_ANGEL', 'UNIT_SERAPH', 'UNIT_VALKYRIE'],
                'UNIT_DISCIPLE_OF_ACHERON': ['UNIT_SONS_OF_THE_INFERNO'],
                'UNIT_FREAK': ['UNIT_ARCHER', 'UNIT_AXEMAN', 'UNIT_HUNTER'],
                'UNIT_GRIGORI_MEDIC': ['UNIT_DRUID'],
                'UNIT_LIGHTBRINGER': ['UNIT_DISCIPLE_EMPYREAN', 'UNIT_DISCIPLE_OF_LEAVES',
                                      'UNIT_DISCIPLE_OCTOPUS_OVERLORDS', 'UNIT_DISCIPLE_RUNES_OF_KILMORPH',
                                      'UNIT_DISCIPLE_THE_ASHEN_VEIL', 'UNIT_DISCIPLE_THE_ORDER'],
                'UNIT_MONK': ['UNIT_PALADIN', 'UNIT_IMMORTAL'],
                'UNIT_PRIEST_OF_WINTER': ['UNIT_HIGH_PRIEST_OF_WINTER'],
                }

kept_civics = ['CIVIC_CODE_OF_LAWS', 'CIVIC_EXPLORATION', 'CIVIC_FEUDALISM', 'CIVIC_GUILDS', 'CIVIC_MERCANTILISM',
               'CIVIC_MYSTICISM', 'CIVIC_THEOLOGY']

kept_techs = ['TECH_ANIMAL_HUSBANDRY', 'TECH_ARCHERY', 'TECH_ASTRONOMY', 'TECH_BRONZE_WORKING', 'TECH_CARTOGRAPHY',
              'TECH_CONSTRUCTION', 'TECH_ENGINEERING', 'TECH_FUTURE_TECH', 'TECH_HORSEBACK_RIDING', 'TECH_IRON_WORKING',
              'TECH_MACHINERY', 'TECH_MASONRY', 'TECH_MATHEMATICS', 'TECH_MINING', 'TECH_SAILING', 'TECH_SANITATION',
              'TECH_STIRRUPS', 'TECH_WRITING']

native_prereqtechs = """DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_WRITING' AND PrereqTech LIKE 'TECH_POTTERY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_THE_WHEEL' AND PrereqTech LIKE 'TECH_MINING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_TELECOMMUNICATIONS' AND PrereqTech LIKE 'TECH_COMPUTERS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_SYNTHETIC_MATERIALS' AND PrereqTech LIKE 'TECH_PLASTICS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_STIRRUPS' AND PrereqTech LIKE 'TECH_APPRENTICESHIP';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_STEEL' AND PrereqTech LIKE 'TECH_RIFLING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_STEAM_POWER' AND PrereqTech LIKE 'TECH_INDUSTRIALIZATION';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_STEALTH_TECHNOLOGY' AND PrereqTech LIKE 'TECH_SYNTHETIC_MATERIALS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_SQUARE_RIGGING' AND PrereqTech LIKE 'TECH_CARTOGRAPHY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_SIEGE_TACTICS' AND PrereqTech LIKE 'TECH_CASTLES';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_SHIPBUILDING' AND PrereqTech LIKE 'TECH_SAILING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_SCIENTIFIC_THEORY' AND PrereqTech LIKE 'TECH_BANKING';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_SCIENTIFIC_THEORY' AND PrereqTech LIKE 'TECH_ASTRONOMY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_SATELLITES' AND PrereqTech LIKE 'TECH_ROCKETRY';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_SATELLITES' AND PrereqTech LIKE 'TECH_ADVANCED_FLIGHT';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_SANITATION' AND PrereqTech LIKE 'TECH_SCIENTIFIC_THEORY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_ROCKETRY' AND PrereqTech LIKE 'TECH_RADIO';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ROCKETRY' AND PrereqTech LIKE 'TECH_CHEMISTRY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_ROBOTICS' AND PrereqTech LIKE 'TECH_SATELLITES';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ROBOTICS' AND PrereqTech LIKE 'TECH_LASERS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ROBOTICS' AND PrereqTech LIKE 'TECH_GUIDANCE_SYSTEMS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ROBOTICS' AND PrereqTech LIKE 'TECH_COMPUTERS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_RIFLING' AND PrereqTech LIKE 'TECH_MILITARY_SCIENCE';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_RIFLING' AND PrereqTech LIKE 'TECH_BALLISTICS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_REPLACEABLE_PARTS' AND PrereqTech LIKE 'TECH_ECONOMICS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_REFINING' AND PrereqTech LIKE 'TECH_RIFLING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_RADIO' AND PrereqTech LIKE 'TECH_STEAM_POWER';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_RADIO' AND PrereqTech LIKE 'TECH_FLIGHT';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_PRINTING' AND PrereqTech LIKE 'TECH_MACHINERY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_PLASTICS' AND PrereqTech LIKE 'TECH_COMBUSTION';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_NUCLEAR_FUSION' AND PrereqTech LIKE 'TECH_LASERS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_NUCLEAR_FISSION' AND PrereqTech LIKE 'TECH_COMBINED_ARMS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_NUCLEAR_FISSION' AND PrereqTech LIKE 'TECH_ADVANCED_BALLISTICS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_NANOTECHNOLOGY' AND PrereqTech LIKE 'TECH_COMPOSITES';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_MILITARY_TACTICS' AND PrereqTech LIKE 'TECH_MATHEMATICS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_MILITARY_SCIENCE' AND PrereqTech LIKE 'TECH_SIEGE_TACTICS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_MILITARY_SCIENCE' AND PrereqTech LIKE 'TECH_PRINTING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_MILITARY_ENGINEERING' AND PrereqTech LIKE 'TECH_CONSTRUCTION';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_METAL_CASTING' AND PrereqTech LIKE 'TECH_GUNPOWDER';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_MATHEMATICS' AND PrereqTech LIKE 'TECH_CURRENCY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_MASS_PRODUCTION' AND PrereqTech LIKE 'TECH_MILITARY_TACTICS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_MASS_PRODUCTION' AND PrereqTech LIKE 'TECH_EDUCATION';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_MASS_PRODUCTION' AND PrereqTech LIKE 'TECH_BUTTRESS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_MACHINERY' AND PrereqTech LIKE 'TECH_IRON_WORKING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_LASERS' AND PrereqTech LIKE 'TECH_NUCLEAR_FISSION';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_IRRIGATION' AND PrereqTech LIKE 'TECH_POTTERY';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_IRON_WORKING' AND PrereqTech LIKE 'TECH_BRONZE_WORKING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_INDUSTRIALIZATION' AND PrereqTech LIKE 'TECH_SQUARE_RIGGING';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_INDUSTRIALIZATION' AND PrereqTech LIKE 'TECH_MASS_PRODUCTION';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_HORSEBACK_RIDING' AND PrereqTech LIKE 'TECH_ARCHERY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_GUNPOWDER' AND PrereqTech LIKE 'TECH_STIRRUPS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_GUNPOWDER' AND PrereqTech LIKE 'TECH_MILITARY_ENGINEERING';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_GUNPOWDER' AND PrereqTech LIKE 'TECH_APPRENTICESHIP';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_GUIDANCE_SYSTEMS' AND PrereqTech LIKE 'TECH_ROCKETRY';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_GUIDANCE_SYSTEMS' AND PrereqTech LIKE 'TECH_ADVANCED_BALLISTICS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_FLIGHT' AND PrereqTech LIKE 'TECH_SCIENTIFIC_THEORY';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_FLIGHT' AND PrereqTech LIKE 'TECH_INDUSTRIALIZATION';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ENGINEERING' AND PrereqTech LIKE 'TECH_THE_WHEEL';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_ELECTRICITY' AND PrereqTech LIKE 'TECH_STEAM_POWER';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_EDUCATION' AND PrereqTech LIKE 'TECH_MATHEMATICS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_EDUCATION' AND PrereqTech LIKE 'TECH_APPRENTICESHIP';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_ECONOMICS' AND PrereqTech LIKE 'TECH_SCIENTIFIC_THEORY';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ECONOMICS' AND PrereqTech LIKE 'TECH_METAL_CASTING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_CURRENCY' AND PrereqTech LIKE 'TECH_WRITING';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_CONSTRUCTION' AND PrereqTech LIKE 'TECH_HORSEBACK_RIDING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_COMPUTERS' AND PrereqTech LIKE 'TECH_RADIO';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_COMPUTERS' AND PrereqTech LIKE 'TECH_ELECTRICITY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_COMPOSITES' AND PrereqTech LIKE 'TECH_SYNTHETIC_MATERIALS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_COMBUSTION' AND PrereqTech LIKE 'TECH_STEEL';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_COMBUSTION' AND PrereqTech LIKE 'TECH_REFINING';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_COMBINED_ARMS' AND PrereqTech LIKE 'TECH_STEEL';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_COMBINED_ARMS' AND PrereqTech LIKE 'TECH_COMBUSTION';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_CHEMISTRY' AND PrereqTech LIKE 'TECH_SANITATION';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_CHEMISTRY' AND PrereqTech LIKE 'TECH_REPLACEABLE_PARTS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_CELESTIAL_NAVIGATION' AND PrereqTech LIKE 'TECH_SAILING';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_CELESTIAL_NAVIGATION' AND PrereqTech LIKE 'TECH_ASTROLOGY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_CASTLES' AND PrereqTech LIKE 'TECH_CONSTRUCTION';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_CARTOGRAPHY' AND PrereqTech LIKE 'TECH_BUTTRESS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_BUTTRESS' AND PrereqTech LIKE 'TECH_SHIPBUILDING';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_BUTTRESS' AND PrereqTech LIKE 'TECH_MATHEMATICS';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_BANKING' AND PrereqTech LIKE 'TECH_STIRRUPS';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_BANKING' AND PrereqTech LIKE 'TECH_EDUCATION';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_BALLISTICS' AND PrereqTech LIKE 'TECH_METAL_CASTING';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ASTRONOMY' AND PrereqTech LIKE 'TECH_EDUCATION';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ARCHERY' AND PrereqTech LIKE 'TECH_ANIMAL_HUSBANDRY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_APPRENTICESHIP' AND PrereqTech LIKE 'TECH_HORSEBACK_RIDING';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_APPRENTICESHIP' AND PrereqTech LIKE 'TECH_CURRENCY';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_ADVANCED_FLIGHT' AND PrereqTech LIKE 'TECH_RADIO';
DELETE FROM TechnologyPrereqs WHERE Technology LIKE 'TECH_ADVANCED_BALLISTICS' AND PrereqTech LIKE 'TECH_STEEL';
UPDATE TechnologyPrereqs SET PrereqTech = 'TECH_FUTURE_TECH' WHERE Technology LIKE 'TECH_ADVANCED_BALLISTICS' AND PrereqTech LIKE 'TECH_REPLACEABLE_PARTS';
"""

native_prereq_civics = """UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_CRAFTSMANSHIP' AND PrereqCivic = 'CIVIC_CODE_OF_LAWS';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_FOREIGN_TRADE' AND PrereqCivic = 'CIVIC_CODE_OF_LAWS';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_MILITARY_TRADITION' AND PrereqCivic = 'CIVIC_CRAFTSMANSHIP';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_STATE_WORKFORCE' AND PrereqCivic = 'CIVIC_CRAFTSMANSHIP';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_EARLY_EMPIRE' AND PrereqCivic = 'CIVIC_FOREIGN_TRADE';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_MYSTICISM' AND PrereqCivic = 'CIVIC_FOREIGN_TRADE';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_GAMES_RECREATION' AND PrereqCivic = 'CIVIC_STATE_WORKFORCE';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_POLITICAL_PHILOSOPHY' AND PrereqCivic = 'CIVIC_STATE_WORKFORCE';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_POLITICAL_PHILOSOPHY' AND PrereqCivic = 'CIVIC_EARLY_EMPIRE';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_DRAMA_POETRY' AND PrereqCivic = 'CIVIC_EARLY_EMPIRE';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_MILITARY_TRAINING' AND PrereqCivic = 'CIVIC_MILITARY_TRADITION';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_MILITARY_TRAINING' AND PrereqCivic = 'CIVIC_GAMES_RECREATION';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_DEFENSIVE_TACTICS' AND PrereqCivic = 'CIVIC_GAMES_RECREATION';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_DEFENSIVE_TACTICS' AND PrereqCivic = 'CIVIC_POLITICAL_PHILOSOPHY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_RECORDED_HISTORY' AND PrereqCivic = 'CIVIC_POLITICAL_PHILOSOPHY';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_RECORDED_HISTORY' AND PrereqCivic = 'CIVIC_DRAMA_POETRY';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_THEOLOGY' AND PrereqCivic = 'CIVIC_DRAMA_POETRY';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_THEOLOGY' AND PrereqCivic = 'CIVIC_MYSTICISM';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_NAVAL_TRADITION' AND PrereqCivic = 'CIVIC_DEFENSIVE_TACTICS';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_FEUDALISM' AND PrereqCivic = 'CIVIC_DEFENSIVE_TACTICS';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_CIVIL_SERVICE' AND PrereqCivic = 'CIVIC_DEFENSIVE_TACTICS';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_CIVIL_SERVICE' AND PrereqCivic = 'CIVIC_RECORDED_HISTORY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_MERCENARIES' AND PrereqCivic = 'CIVIC_MILITARY_TRAINING';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_MERCENARIES' AND PrereqCivic = 'CIVIC_FEUDALISM';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_MEDIEVAL_FAIRES' AND PrereqCivic = 'CIVIC_FEUDALISM';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_GUILDS' AND PrereqCivic = 'CIVIC_FEUDALISM';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_GUILDS' AND PrereqCivic = 'CIVIC_CIVIL_SERVICE';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_DIVINE_RIGHT' AND PrereqCivic = 'CIVIC_CIVIL_SERVICE';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_DIVINE_RIGHT' AND PrereqCivic = 'CIVIC_THEOLOGY';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_EXPLORATION' AND PrereqCivic = 'CIVIC_MERCENARIES';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_EXPLORATION' AND PrereqCivic = 'CIVIC_MEDIEVAL_FAIRES';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_HUMANISM' AND PrereqCivic = 'CIVIC_MEDIEVAL_FAIRES';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_HUMANISM' AND PrereqCivic = 'CIVIC_GUILDS';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_DIPLOMATIC_SERVICE' AND PrereqCivic = 'CIVIC_GUILDS';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_REFORMED_CHURCH' AND PrereqCivic = 'CIVIC_GUILDS';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_REFORMED_CHURCH' AND PrereqCivic = 'CIVIC_DIVINE_RIGHT';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_MERCANTILISM' AND PrereqCivic = 'CIVIC_HUMANISM';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_THE_ENLIGHTENMENT' AND PrereqCivic = 'CIVIC_HUMANISM';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_THE_ENLIGHTENMENT' AND PrereqCivic = 'CIVIC_DIPLOMATIC_SERVICE';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_COLONIALISM' AND PrereqCivic = 'CIVIC_MERCANTILISM';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_CIVIL_ENGINEERING' AND PrereqCivic = 'CIVIC_MERCANTILISM';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_NATIONALISM' AND PrereqCivic = 'CIVIC_THE_ENLIGHTENMENT';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_OPERA_BALLET' AND PrereqCivic = 'CIVIC_THE_ENLIGHTENMENT';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_NATURAL_HISTORY' AND PrereqCivic = 'CIVIC_COLONIALISM';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_SCORCHED_EARTH' AND PrereqCivic = 'CIVIC_NATIONALISM';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_URBANIZATION' AND PrereqCivic = 'CIVIC_CIVIL_ENGINEERING';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_URBANIZATION' AND PrereqCivic = 'CIVIC_NATIONALISM';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_CONSERVATION' AND PrereqCivic = 'CIVIC_NATURAL_HISTORY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_MASS_MEDIA' AND PrereqCivic = 'CIVIC_NATURAL_HISTORY';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_MASS_MEDIA' AND PrereqCivic = 'CIVIC_URBANIZATION';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_CAPITALISM' AND PrereqCivic = 'CIVIC_MASS_MEDIA';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_MOBILIZATION' AND PrereqCivic = 'CIVIC_URBANIZATION';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_IDEOLOGY' AND PrereqCivic = 'CIVIC_MASS_MEDIA';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_IDEOLOGY' AND PrereqCivic = 'CIVIC_MOBILIZATION';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_NUCLEAR_PROGRAM' AND PrereqCivic = 'CIVIC_IDEOLOGY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_SUFFRAGE' AND PrereqCivic = 'CIVIC_IDEOLOGY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_TOTALITARIANISM' AND PrereqCivic = 'CIVIC_IDEOLOGY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_CLASS_STRUGGLE' AND PrereqCivic = 'CIVIC_IDEOLOGY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_COLD_WAR' AND PrereqCivic = 'CIVIC_IDEOLOGY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_PROFESSIONAL_SPORTS' AND PrereqCivic = 'CIVIC_IDEOLOGY';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_CULTURAL_HERITAGE' AND PrereqCivic = 'CIVIC_CONSERVATION';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_RAPID_DEPLOYMENT' AND PrereqCivic = 'CIVIC_COLD_WAR';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_SPACE_RACE' AND PrereqCivic = 'CIVIC_COLD_WAR';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_GLOBALIZATION' AND PrereqCivic = 'CIVIC_RAPID_DEPLOYMENT';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_GLOBALIZATION' AND PrereqCivic = 'CIVIC_SPACE_RACE';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_SOCIAL_MEDIA' AND PrereqCivic = 'CIVIC_SPACE_RACE';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_SOCIAL_MEDIA' AND PrereqCivic = 'CIVIC_PROFESSIONAL_SPORTS';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_FUTURE_CIVIC' AND PrereqCivic = 'CIVIC_GLOBALIZATION';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_FUTURE_CIVIC' AND PrereqCivic = 'CIVIC_SOCIAL_MEDIA';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_MOBILIZATION' AND PrereqCivic = 'CIVIC_SCORCHED_EARTH';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_ENVIRONMENTALISM' AND PrereqCivic = 'CIVIC_CULTURAL_HERITAGE';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_ENVIRONMENTALISM' AND PrereqCivic = 'CIVIC_RAPID_DEPLOYMENT';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_CORPORATE_LIBERTARIANISM' AND PrereqCivic = 'CIVIC_GLOBALIZATION';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_CORPORATE_LIBERTARIANISM' AND PrereqCivic = 'CIVIC_SOCIAL_MEDIA';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_DIGITAL_DEMOCRACY' AND PrereqCivic = 'CIVIC_GLOBALIZATION';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_DIGITAL_DEMOCRACY' AND PrereqCivic = 'CIVIC_SOCIAL_MEDIA';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_SYNTHETIC_TECHNOCRACY' AND PrereqCivic = 'CIVIC_GLOBALIZATION';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_SYNTHETIC_TECHNOCRACY' AND PrereqCivic = 'CIVIC_SOCIAL_MEDIA';
UPDATE CivicPrereqs SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE Civic = 'CIVIC_NEAR_FUTURE_GOVERNANCE' AND PrereqCivic = 'CIVIC_ENVIRONMENTALISM';
DELETE FROM CivicPrereqs WHERE Civic = 'CIVIC_NEAR_FUTURE_GOVERNANCE' AND PrereqCivic = 'CIVIC_GLOBALIZATION';
"""


def small_dict(big_dict, four_to_six_map):
    # smaller_dict = {four_to_six_map[j]: big_dict[j] for j in big_dict if j in four_to_six_map}
    smaller_dict = {}
    for j in big_dict:
        if j in four_to_six_map:
            smaller_dict[four_to_six_map[j]] = big_dict[j]

    for to_insert, default_value in four_to_six_map.items():
        if default_value not in smaller_dict:
            smaller_dict[to_insert] = default_value

    return smaller_dict


# pd.read_csv('unit_tech_or_civic_reqs.csv')
# Open the XML file
with open('CIV4UnitInfos.xml', 'r') as file:
    xml_dict = xmltodict.parse(file.read())

with open('CIV4TechInfos.xml', 'r') as file:
    xml_tech_dict = xmltodict.parse(file.read())

tech_infos = xml_tech_dict['Civ4TechInfos']['TechInfos']['TechInfo']
infos = xml_dict['Civ4UnitInfos']['UnitInfos'][('UnitInfo')]
unit_dict = {'Class': 'UnitType', 'Type': 'Name', 'Description': 'Description', 'iMoves': 'BaseMoves',
             'iCost': 'Cost', 'Advisor': 'AdvisorType', 'iCombat': 'Combat', 'Combat': 'RangedCombat',
             'Domain': 'Domain', 'PromotionClass': 'Combat', 'Maintenance': 'bMilitarySupport',
             'PrereqTech': 'PrereqTech'}
six_style_dict = [small_dict(i, unit_dict) for i in infos]
no_equipment_units = [i for i in six_style_dict if not ('EQUIPMENT' in i['Name'])]
buildable_only = [i for i in six_style_dict if not (i['Cost'] == '-1')]
# how to filter out barbarian only
unbuildable_only = [i for i in six_style_dict if i['Cost'] == '-1']
# [i.get('Name', 'not_found') for i in buildable_only]


# Conversions for civ vi
for i in buildable_only:
    i['TraitType'] = "NULL"
    i['BaseSightRange'] = 2
    if i['RangedCombat'] == 'UNIT_COMBAT_NAVAL':
        i['Domain'] = 'DOMAIN_SEA'
        i['FormationClass'] = 'FORMATION_CLASS_NAVAL'

    if any([element == i['RangedCombat'] for element in ['UNITCOMBAT_ARCHER', 'UNITCOMBAT_ADEPT', 'UNITCOMBAT_SIEGE']]):
        i['RangedCombat'] = i['Combat']
    else:
        i['RangedCombat'] = 0

    if i['Combat'] == '0':
        i['FormationClass'] = 'FORMATION_CLASS_CIVILIAN'
    else:
        i['FormationClass'] = 'FORMATION_CLASS_LAND_COMBAT'

# now we are gonna filter out those civs we arent doing stuff with
civs = ['AMURITE', 'CALABIM', 'LUCHUIRP']
religions = ['RUNES_OF_KILMORPH', 'OCTOPUS_OVERLORDS', 'THE_ORDER']
# Filter out civ units, processing strings
uu = [s.split(',') for s in unique_units.split('\n')]
uu = [[f'UNIT_{i[0].strip().upper()}', i[1].strip().upper()] for i in uu]
heroes = [s.split(',') for s in unique_heroes.split('\n')]
heroes = [[f'UNIT_{i[0].strip().upper()}', i[1].strip().upper()] for i in heroes]
two_civs_units = [s.split(',') for s in double_civ_units_str.split('\n')]
two_civs_units = [[f'UNIT_{i[0].strip().upper()}', i[1].strip().upper(), i[2].strip().upper()] for i in two_civs_units]
religious = [s.split(',') for s in religious_units_str.split('\n')]
religious = [[f'UNIT_{i[0].strip().upper()}', i[1].strip().upper()] for i in religious]
equipment = [i for i in unbuildable_only if 'EQUIP' in i['Name']]
summons = [i for i in unbuildable_only if not ('EQUIP' in i['Name'])]

# From infos remove unique units not based on another generic
unique_civ_units = [i for i in infos if i.get('PrereqCiv', '')]
has_unique_units = {uunit['PrereqCiv'] for uunit in unique_civ_units}
unique_civ_units_by_type = [[j['Type'] for j in unique_civ_units if i == j['PrereqCiv']] for i in has_unique_units]

# Make dictionaries of units to remove
not_civ_units, civ_units = {i[0]: i[1] for i in uu if not (i[1] in civs)}, {i[0]: i[1] for i in uu if i[1] in civs}
not_civ_heroes, civ_heroes = {i[0]: i[1] for i in heroes if not (i[1] in civs)}, {i[0]: i[1] for i in heroes if
                                                                                  i[1] in civs}
not_double_civ_units = [i[0] for i in two_civs_units if not any([j in civs for j in i])]
double_civ_units = {i[0]: [j for j in i if j in civs][0] for i in two_civs_units if any([j in civs for j in i])}
not_religious_units, religious_units = {i[0]: i[1] for i in religious if not (i[1] in religions)}, {i[0]: i[1] for i in
                                                                                                    religious if
                                                                                                    i[1] in religions}
# Filter the units based on dictionaries
final_units = [i for i in buildable_only if not (i['Name'] in not_civ_units)]
final_units = [i for i in final_units if not (i['Name'] in not_civ_heroes)]  # heroes removal
final_units = [i for i in final_units if not (i['Name'] in [j['Type'] for j in unique_civ_units])]  # units removal
final_units = [i for i in final_units if not i['Name'] in not_double_civ_units]
final_units = [i for i in final_units if not (i['Name'] in not_religious_units)]
final_units = [i for i in final_units if not i['Name'] in excludes_from_four]
final_units, never = [i for i in final_units if i['PrereqTech'] != 'TECH_NEVER'], [i for i in final_units if i['PrereqTech'] == 'TECH_NEVER']

# filter for our upgrades table too
to_pop = []
names = [i['Name'] for i in final_units]
for unit, upgrade in upgrade_tree.items():
    if unit in names:
        viable_upgrades = [i for i in upgrade if i in names]
        upgrade_tree[unit] = viable_upgrades
    else:
        to_pop.append(unit)

for unit in to_pop:
    upgrade_tree.pop(unit)

# now do formatting for 6 style tables
replaces = {}
for unit in final_units:
    unit['UnitType'] = unit['UnitType'].replace('UNITCLASS', 'UNIT')
    if unit['UnitType'] != unit['Name']:
        replaces[unit['Name']] = unit['UnitType']
        unit['UnitType'] = unit['Name']
    unit['Name'] = 'LOC_' + unit['Name'] + '_NAME'
    unit['Description'] = unit['Description'].replace('TXT_KEY', 'LOC') + '_DESCRIPTION'
    if unit['AdvisorType'] in ['ADVISOR_MILITARY', 'ADVISOR_RELIGION']:
        unit['AdvisorType'] = 'ADVISOR_CONQUEST'
    if unit['AdvisorType'] in ['ADVISOR_ECONOMY', 'ADVISOR_GROWTH']:
        unit['AdvisorType'] = 'ADVISOR_GENERIC'
    if unit['PrereqTech'] == 'NONE':
        unit['PrereqTech'] = 'NULL'
# patch
replaces.pop('UNIT_SWORDSMAN')
replaces['UNIT_MUD_GOLEM'] = 'UNIT_BUILDER'

# do tech - civic prereqs Conversions
with open('techs.sql', 'r') as file:
    techsql = file.read()

techsql = techsql.splitlines()
defined_civic_and_traits = techsql[2:85]
civics = {}
techs = []
for line in defined_civic_and_traits:
    formatted = line[2:-3].split("', '")
    if 'TECH' in formatted[1]:
        techs.append(formatted[0])
    elif 'CIVIC' in formatted[1]:
        civics['TECH' + formatted[0][5:]] = formatted[0]

for unit in final_units:
    if unit['PrereqTech'] in civics:
        unit['PrereqCivic'] = civics[unit['PrereqTech']]
        unit['PrereqTech'] = 'NULL'
    else:
        unit['PrereqCivic'] = 'NULL'


trait_types_to_define: list[str] = []
# Insert TraitType for civ-unique units
trait_types_heroes = [[unit for unit, civ in civ_heroes.items() if civ == civ_name] for civ_name in civs]
trait_types_units = [[unit for unit, civ in civ_units.items() if civ == civ_name] for civ_name in civs]
trait_types_double_civ_units = [[unit for unit, civ in double_civ_units.items() if civ == civ_name] for civ_name in
                                civs]
trait_types = [x + y + z for x, y, z in zip(trait_types_heroes, trait_types_units, trait_types_double_civ_units)]
trait_types = {i: j for i, j in zip(civs, trait_types)}

count = 0
for idx, civ in enumerate(civs):
    for i in final_units:
        if i['UnitType'] in trait_types[civs[idx]]:
            trait_str = f'TRAIT_CIVILIZATION_UNIT{i["UnitType"][4:]}'
            i['TraitType'] = trait_str
            trait_types_to_define.append(trait_str)
# Insert TraitType for religion units
trait_types_religion = {religion_name: [unit for unit, civ in religious_units.items() if civ == religion_name] for
                        religion_name in religions}
for idx, religion in enumerate(religions):
    for i in final_units:
        if i['UnitType'] in trait_types_religion[religions[idx]]:
            trait_str = f'TRAIT_RELIGION_UNIT{i["UnitType"][4:]}'
            i['TraitType'] = trait_str
            trait_types_to_define.append(trait_str)

unit_military_engineer_issues = ['Improvement_ValidBuildUnits', "Route_ValidBuildUnits",
                                 "Building_BuildChargeProductions", "District_BuildChargeProductions"]
update_string = ""
for table in unit_military_engineer_issues:
    update_string += f"UPDATE {table} SET UnitType = 'UNIT_BUILDER' WHERE UnitType = 'UNIT_MILITARY_ENGINEER';\n"
unit_list = "'" + "', '".join(kept_units) + "'"
delete_string = ""
update_string += f"UPDATE Boosts SET Unit1Type = NULL WHERE Unit1Type NOT IN ({unit_list});\n"
# delete_string += f"DELETE FROM UnitReplaces WHERE CivUniqueUnitType is not null;\n"
# delete_string += f"DELETE FROM Units_XP2 WHERE UnitType is not null;\n"
# delete_string += f"DELETE FROM Units WHERE UnitType NOT IN ({unit_list});\n"

delete_string += ("UPDATE RandomAgendaCivicTags SET CivicType = 'CIVIC_FEUDALISM' "
                  "WHERE CivicType = 'CIVIC_NATIONALISM';\n")

schema_string = '('
for schema_key in [i for i in final_units[0]]:
    schema_string += f'{schema_key}, '
schema_string = schema_string[:-2] + ') VALUES\n'
unit_table_string = "INSERT INTO Units" + schema_string
for unit in final_units:
    if unit['UnitType'] not in kept_units:
        unit_table_string += "("
        for attribute in unit:
            unit_table_string += f"'{unit[attribute]}', "
        unit_table_string = unit_table_string[:-2] + "),\n"
unit_table_string = unit_table_string[:-2] + ";\n"
replacements_string = 'INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES\n'
for unique_unit, original_unit in replaces.items():
    replacements_string += f"('{unique_unit}', '{original_unit}'),\n"
    debug_string += f"('{unique_unit}',"
debug_string += "\n"
replacements_string = replacements_string[:-2] + ";\n"
upgrades_string = "INSERT INTO UnitUpgrades(Unit, Upgradeunit) VALUES\n"
# upgrade tree, commented out for multiple upgrades, whicn is not supported in 6
for unit, upgrades in upgrade_tree.items():
    # for upgrade in upgrades:
        # upgrades_string += f"('{unit}', '{upgrade}'),\n"
    if unit in kept_units:
        update_string += f"UPDATE UnitUpgrades SET UpgradeUnit = '{upgrades[0]}' WHERE Unit LIKE '{unit}';\n"
    else:
        upgrades_string += f"('{unit}', '{upgrades[0]}'),\n"
upgrades_string = upgrades_string[:-2] + ";\n"

with open('../Core/initial_units.sql', 'w') as file:
    file.write(delete_string + unit_table_string + replacements_string + upgrades_string)

loc_string = 'INSERT OR REPLACE INTO LocalizedText (Language, Tag, Text)\n VALUES\n'
for unit in final_units:
    en_name = ' '.join([word.capitalize() for word in unit['Name'][4:-4].split('_')])[:-1]
    loc_string += f"('en_us', '{unit['Name']}', '{en_name}'),\n"
    loc_string += f"('en_us', '{unit['Description']}',  'Description'),\n"
    loc_string += f"('en_us', 'LOC_PEDIA_UNITS_PAGE_{unit['Name'][4:-4]}CHAPTER_HISTORY_PARA_1', 'DESCRIPTION'),\n"
loc_string = loc_string[:-2] + ';'

with open('../Core/localization.sql', 'w') as file:
    file.write(loc_string)

tech_list = "'" + "', '".join(kept_techs) + "'"
civic_list = "'" + "', '".join(kept_civics) + "'"
tech_string = ""
tech_string += native_prereqtechs + '\n'
tech_string += native_prereq_civics + '\n'
tech_string += "UPDATE Civics SET EraType = 'ERA_FUTURE' WHERE EraType is not null;\n"
tech_string += "UPDATE Technologies SET EraType = 'ERA_FUTURE' WHERE EraType is not null;\n"
# misc patches
tech_string += f"UPDATE Units SET ObsoleteTech = 'NULL' WHERE ObsoleteTech NOT IN ({tech_list});\n"
tech_string += f"UPDATE Units SET ObsoleteCivic = 'NULL' WHERE ObsoleteCivic NOT IN ({civic_list});\n"
tech_string += f"UPDATE Units SET PrereqTech = 'TECH_FUTURE_TECH' WHERE UnitType NOT IN ({unit_list});\n"
tech_string += f"UPDATE Units SET PrereqCivic = 'CIVIC_FUTURE_CIVIC' WHERE UnitType NOT IN ({unit_list});\n"
tech_string += f"DELETE from Routes_XP2 WHERE PrereqTech is 'TECH_STEAM_POWER';\n"

with open('prereqstechs.sql', 'r') as file:
    prereqs_string = file.read()

prereqs_string = prereqs_string[:-2] + ",\n    ('TECH_ASTROLOGY', 'TECH_FUTURE_TECH'),"
prereqs_string += "\n    ('TECH_POTTERY', 'TECH_FUTURE_TECH');\n"

with open('prereqscivics.sql', 'r') as file:
    prereqs_string += file.read() + "\n"

techs_4_to_6 = {'Type': 'TechnologyType', 'Name': 'TechnologyType', 'iCost': 'Cost', 'Repeatable': 0,
                'EmbarkUnitType': 'NULL', 'EmbarkAll': 0, 'Description': 'Description', 'EraType': 'ERA_ANCIENT',
                'Critical': 0, 'BarbarianFree': 0, 'UITreeRow': 0, 'AdvisorType': 'ADVISOR_GENERIC'}
six_techs = [small_dict(i, techs_4_to_6) for i in tech_infos]
six_style_techs = [i for i in six_techs if i['TechnologyType'] in techs]
for tech in six_style_techs:
    tech['Name'] = 'LOC_' + tech['TechnologyType'] + '_NAME'
    tech['Description'] = 'LOC_' + tech['TechnologyType'] + '_DESCRIPTION'
six_style_techs = [i for i in six_style_techs if not i['TechnologyType'] in kept_techs]

six_style_civics = [i for i in six_techs if i['TechnologyType'] in civics]
for civic in six_style_civics:
    civic['CivicType'] = civics[civic['TechnologyType']]
    civic.pop('TechnologyType')
    civic.pop('Critical')
    civic['Description'] = 'LOC_' + civic['CivicType'] + '_DESCRIPTION'
    civic['Name'] = 'LOC_' + civic['CivicType'] + '_NAME'

six_style_civics = [i for i in six_style_civics if not i['CivicType'] in kept_civics]
civics_4_to_6 = {'Type': 'CivicType', 'Name': 'CivicType', 'iCost': 'Cost', 'Repeatable': 0,
                 'Description': 'Description', 'EraType': 'ERA_ANCIENT', 'BarbarianFree': 0, 'UITreeRow': 0,
                 'Advisor': 'AdvisorType', 'EmbarkAll': 0, 'EmbarkUnitType': 'NULL'}

schema_string_tech = '('
for schema_key in [i for i in six_style_techs[0]]:
    schema_string_tech += f'{schema_key}, '
schema_string_tech = schema_string_tech[:-2] + ') VALUES\n'
tech_table_string = "INSERT INTO Technologies" + schema_string_tech

for tech in six_style_techs:
    tech_table_string += "("
    for tech_attribute in tech.values():
        tech_table_string += f"'{tech_attribute}', "
    tech_table_string = tech_table_string[:-2]
    tech_table_string += "),\n"
tech_table_string = tech_table_string[:-2]
tech_table_string += ";\n"

schema_string_civic = '('
for schema_key in [i for i in six_style_civics[0]]:
    schema_string_civic += f'{schema_key}, '
schema_string_civic = schema_string_civic[:-2] + ') VALUES\n'
civic_table_string = "INSERT INTO Civics" + schema_string_civic

for civic in six_style_civics:
    civic_table_string += "("
    for civic_attribute in civic.values():
        civic_table_string += f"'{civic_attribute}', "
    civic_table_string = civic_table_string[:-2]
    civic_table_string += "),\n"
civic_table_string = civic_table_string[:-2]
civic_table_string += ";\n"
civic_table_string += f"UPDATE Resource_Harvests SET PrereqTech = 'TECH_AGRICULTURE' WHERE PrereqTech = 'TECH_POTTERY';\n"

kind_string = ""
for tech_type_to_add in techsql:
    first_val = tech_type_to_add[2:].split("',")[0]
    if not ('TECH' in first_val or 'CIVIC' in first_val):
        kind_string += tech_type_to_add + '\n'
    elif not (first_val in kept_techs or first_val in kept_civics):
        kind_string += tech_type_to_add + '\n'
        debug_string += f"'{first_val}',"

kind_string = kind_string[:-2] + ","
for unit in final_units:
    name = unit['UnitType']
    if name not in kept_units:
        kind_string += f"\n('{name}', 'KIND_UNIT'),"
        debug_string += f"'{name}',"

traits_string = "INSERT INTO Traits(TraitType, Name, Description, InternalOnly) VALUES"
for trait in trait_types_to_define:
    kind_string += f"\n('{trait}', 'KIND_TRAIT'),"
    traits_string += f"\n('{trait}', '{'LOC_'+ trait + '_NAME'}', NULL, 0),"
    debug_string += f"'{trait}',"

traits_string = traits_string[:-1] + ";\n"
kind_string = kind_string[:-1] + ';\n'

with open('test.txt', 'w') as file:
    file.write(debug_string)

total = (kind_string + tech_string + '\n' + tech_table_string + civic_table_string + prereqs_string + update_string
         + delete_string + traits_string + unit_table_string + replacements_string + upgrades_string)
total_with_null = total.replace("'NULL'", "NULL")
with open('../Core/techs_civics.sql', 'w') as file:
    file.write(total_with_null)
