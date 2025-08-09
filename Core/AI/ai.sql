-- elohim Backstab Averse, Tomyris. OR. Gandhi peaceful
-- Basium, Bolivar? Highly promoted units.
-- Philipp for Grigori? Or do they even care about other religions coming in. not really.
-- I suppose for Grigori, its get Great Prophets. Pedro?
-- Hippus. Genghis Khan
-- Ljosalfar: Kupe try plant woods and keep features.
-- Lanun: Harald Hadrada Last Viking King. OR Dido, settle coastal cities.

-- Qin Wonder: Generic Wonder builder (Industrious)

-- Qin Unifier: Generic Barb lover (Doviello, Clan, Infernal)
-- agendas to cut.
DELETE FROM RandomAgendas WHERE AgendaType IN ('AGENDA_AIRPOWER', 'AGENDA_CITY_STATE_ALLY', 'AGENDA_CITY_STATE_PROTECTOR',
'AGENDA_DEMAGOGUE', 'AGENDA_DESTINATION_CIV', 'AGENDA_FLAT_EARTHER', 'AGENDA_LIBERTARIAN',
'AGENDA_NUKE_LOVER', 'AGENDA_SYCOPHANT', 'AGENDA_SYMPATHIZER', 'AGENDA_ZEALOT');

DELETE FROM RandomAgendas WHERE AgendaType IN ('AGENDA_BARBARIAN_LOVER');

UPDATE AiFavoredItems SET Value = 15 WHERE ListType='DefaultYieldBias' and Item='YIELD_FAITH';
UPDATE AiFavoredItems SET Value = 15 WHERE ListType='ClassicalYields' and Item='YIELD_FAITH';
UPDATE AiFavoredItems SET Value = 15 WHERE ListType='MedievalYields' and Item='YIELD_FAITH';
UPDATE AiFavoredItems SET Value = 15 WHERE ListType='IndustrialYields' and Item='YIELD_FAITH';

DELETE FROM AiLists WHERE ListType='DefaultTechBoostSupportList';

-- adjust agendas:
-- war Darwinist, limit some civs getting it?
-- Barbarian Ally (at least remove from random pool)
-- Environmentalist: add Fellowship Of Leaves bias. Remove national parks bit
-- Ideologue. Can we adjust this to be on religon policy

-- Populous, but instead hate high pop civs.

-- bring back Curmudgeon and Flirtatious
--

-- Amurite Masters of Sorcery
--AGENDA_MASTERS_OF_SORCERY
INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_MASTERS_OF_SORCERY', 'LOC_SLTH_TRAIT_CIVILIZATION_AMURITES_COOL_NAME', 'LOC_AGENDA_MASTERS_OF_SORCERY_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_VALLEDIA',	'AGENDA_MASTERS_OF_SORCERY'),
('LEADER_DAIN',	'AGENDA_MASTERS_OF_SORCERY');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_MASTERS_OF_SORCERY');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_MASTERS_OF_SORCERY', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_MASTERS_OF_SORCERY', 'TRAIT_AGENDA_MASTERS_OF_SORCERY');

INSERT INTO AiListTypes(ListType) VALUES
('MasterOfSorceryYields'),
('MasterOfSorceryUnits'),
('MasterOfSorceryBuildings'),
('MasterOfSorceryTechs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('MasterOfSorceryYields', 'TRAIT_AGENDA_MASTERS_OF_SORCERY', 'Yields'),
('MasterOfSorceryUnits', 'TRAIT_AGENDA_MASTERS_OF_SORCERY', 'UnitPromotionClasses'),
('MasterOfSorceryBuildings', 'TRAIT_AGENDA_MASTERS_OF_SORCERY', 'Buildings'),
('MasterOfSorceryTechs', 'TRAIT_AGENDA_MASTERS_OF_SORCERY', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('MasterOfSorceryYields', 'YIELD_SCIENCE', '10'),
('MasterOfSorceryUnits', 'PROMOTION_CLASS_ADEPT', '1');
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('MasterOfSorceryBuildings', 'SLTH_BUILDING_CAVE_OF_ANCESTORS', '1'),
('MasterOfSorceryBuildings', 'BUILDING_MAGE_GUILD', '1');


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('MasterOfSorceryTechs', 'TECH_ARCANE_LORE', '1'),                      -- magic line always
('MasterOfSorceryTechs', 'TECH_SORCERY', '1'),
('MasterOfSorceryTechs', 'TECH_KNOWLEDGE_OF_THE_ETHER', '1'),
('MasterOfSorceryTechs', 'TECH_BOWYERS', '1');                      -- Firebows

-- Balseraph. Bias towards Drama and Theatre. Freak Shows.
-- Balseraph: War Favored. Recon line Favored. Culture favored. Evil Religion favored.
INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_PERPENTACH', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('LEADER_KEELYN', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_SLAVER_CARNIVALS', 'LOC_SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL_NAME', 'LOC_AGENDA_SLAVER_CARNIVALS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_PERPENTACH',	'AGENDA_SLAVER_CARNIVALS'),
('LEADER_KEELYN',	'AGENDA_SLAVER_CARNIVALS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_SLAVER_CARNIVALS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_SLAVER_CARNIVALS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_SLAVER_CARNIVALS', 'TRAIT_AGENDA_SLAVER_CARNIVALS');

INSERT INTO AiListTypes(ListType) VALUES
('SlaverCarnivalsYields'),
('SlaverCarnivalsUnits'),
('SlaverCarnivalsBuildings'),
('SlaverCarnivalsCivics'),
('SlaverCarnivalsTechs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('SlaverCarnivalsYields', 'TRAIT_AGENDA_SLAVER_CARNIVALS', 'Yields'),
('SlaverCarnivalsUnits', 'TRAIT_AGENDA_SLAVER_CARNIVALS', 'UnitPromotionClasses'),
('SlaverCarnivalsBuildings', 'TRAIT_AGENDA_SLAVER_CARNIVALS', 'Buildings'),
('SlaverCarnivalsCivics', 'TRAIT_AGENDA_SLAVER_CARNIVALS', 'Civics'),
('SlaverCarnivalsTechs', 'TRAIT_AGENDA_SLAVER_CARNIVALS', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('SlaverCarnivalsYields', 'YIELD_CULTURE', '25'),                   -- not sure if want to bias culture
('SlaverCarnivalsUnits', 'PROMOTION_CLASS_RECON', '1');
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('SlaverCarnivalsBuildings', 'SLTH_BUILDING_CARNIVAL', '1'),
('SlaverCarnivalsBuildings', 'SLTH_BUILDING_FREAK_SHOW', '1');
-- ('SlaverCarnivalsBuildings', 'SLTH_BUILDING_HALL_OF_MIRRORS', '1');


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('SlaverCarnivalsCivics', 'CIVIC_CORRUPTION_OF_SPIRIT', '1'),           -- religions
('SlaverCarnivalsCivics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '1'),
('SlaverCarnivalsCivics', 'CIVIC_DRAMA_POETRY', '1'),
('SlaverCarnivalsCivics', 'CIVIC_WAY_OF_THE_WICKED', '1'),              -- for slavery
('SlaverCarnivalsTechs', 'TECH_CALENDAR', '1'),                        -- for carnivals
('SlaverCarnivalsTechs', 'TECH_HUNTING', '1'),                         -- recon line
('SlaverCarnivalsTechs', 'TECH_POISONS', '1');

-- if we can get it, the state religion policies (well as two different strategies)
-- but it turns out that its not possible except via stupid fake yield stuff. not even pseudoyields.

-- Bannor: War favored, Order favoured. Cottage Economy Favored. Holy Crusaders
-- Crusade policy favoured.

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_CAPRIA', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('LEADER_SABATHIEL', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('LEADER_DECIUS_BANNOR', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_HOLY_CRUSADERS', 'LOC_SLTH_TRAIT_CIVILIZATION_BANNOR_COOL_NAME', 'LOC_AGENDA_HOLY_CRUSADERS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_CAPRIA',	'AGENDA_HOLY_CRUSADERS'),
('LEADER_SABATHIEL',	'AGENDA_HOLY_CRUSADERS'),
('LEADER_DECIUS_BANNOR',	'AGENDA_HOLY_CRUSADERS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_HOLY_CRUSADERS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_HOLY_CRUSADERS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_HOLY_CRUSADERS', 'TRAIT_AGENDA_HOLY_CRUSADERS');

-- HERES WHERE COTTAGE ECONOMY WOULD GO, IF I HAD ONE WAY TO DO AN IMPROVEMENTS SYSTEM
INSERT INTO AiListTypes(ListType) VALUES
('HolyCrusadersCivics');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('HolyCrusadersCivics', 'TRAIT_AGENDA_HOLY_CRUSADERS', 'Civics');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('HolyCrusadersCivics', 'CIVIC_EDUCATION', '1'),           -- Cottage Economy
('HolyCrusadersCivics', 'CIVIC_ORDERS_FROM_HEAVEN', '1'),           -- religions
('HolyCrusadersCivics', 'CIVIC_FANATICISM', '1');

-- Calabim      Vampiric Aristocracy        Calabim: War favored. Food favored. Farm favored. Feudalism favored. hates civs with high pop (to capture em).
-- VAMPIRIC_ARISTOCRACY
INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_ALEXIS', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('LEADER_DECIUS_CALABIM', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

-- flauros isnt aggro early

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_VAMPIRIC_ARISTOCRACY', 'LOC_SLTH_TRAIT_CIVILIZATION_CALABIM_COOL_NAME', 'LOC_AGENDA_VAMPIRIC_ARISTOCRACY_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_ALEXIS',	'AGENDA_VAMPIRIC_ARISTOCRACY'),
('LEADER_FLAUROS',	'AGENDA_VAMPIRIC_ARISTOCRACY'),
('LEADER_DECIUS_CALABIM',	'AGENDA_VAMPIRIC_ARISTOCRACY');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_VAMPIRIC_ARISTOCRACY');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_VAMPIRIC_ARISTOCRACY', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_VAMPIRIC_ARISTOCRACY', 'TRAIT_AGENDA_VAMPIRIC_ARISTOCRACY');

INSERT INTO AiListTypes(ListType) VALUES
('VampiricAristocracyYields'),
('VampiricAristocracyBuildings'),
('VampiricAristocracyCivics'),
('VampiricAristocracyTechs'),
('VampiricAristocracyUnitBuilds');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('VampiricAristocracyYields', 'TRAIT_AGENDA_VAMPIRIC_ARISTOCRACY', 'Yields'),
('VampiricAristocracyBuildings', 'TRAIT_AGENDA_VAMPIRIC_ARISTOCRACY', 'Buildings'),
('VampiricAristocracyCivics', 'TRAIT_AGENDA_VAMPIRIC_ARISTOCRACY', 'Civics'),
('VampiricAristocracyTechs', 'TRAIT_AGENDA_VAMPIRIC_ARISTOCRACY', 'Technologies'),
('VampiricAristocracyUnitBuilds', 'TRAIT_AGENDA_VAMPIRIC_ARISTOCRACY', 'Units');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('VampiricAristocracyYields', 'YIELD_FOOD', '25');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('VampiricAristocracyBuildings', 'BUILDING_ORDU', '1'),
('VampiricAristocracyBuildings', 'SLTH_BUILDING_GOVERNORS_MANOR', '1'),
('VampiricAristocracyBuildings', 'SLTH_BUILDING_SMOKEHOUSE', '1'),
('VampiricAristocracyBuildings', 'BUILDING_GRANARY', '1');
-- look into more housing buildings...

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('VampiricAristocracyCivics', 'CIVIC_INFERNAL_PACT', '1'),           -- Infernal pact for half cost food upkeep on StWeak
('VampiricAristocracyCivics', 'CIVIC_FEUDALISM', '1'),              -- Gov Manor, Vampires
('VampiricAristocracyCivics', 'CIVIC_CODE_OF_LAWS', '1'),              --   Aristocracy
('VampiricAristocracyTechs', 'TECH_CALENDAR', '1');                        -- Agrarianism

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('VampiricAristocracyUnitBuilds', 'SLTH_UNIT_VAMPIRE', '1');                        -- vampires!

-- Clan Bestial Tribes
-- Friendly with Barbarians. Upset at people who clear them (agenda). Doesnt clear barbs.
-- Builds warrens in most every city that produces units.
--
INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_SHEELBA', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');
-- Jonas isnt as aggro

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_BESTIAL_TRIBES', 'LOC_SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL_NAME', 'LOC_AGENDA_BESTIAL_TRIBES_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_JONAS',	'AGENDA_BESTIAL_TRIBES'),
('LEADER_SHEELBA',	'AGENDA_BESTIAL_TRIBES');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_BESTIAL_TRIBES');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_BESTIAL_TRIBES', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_BESTIAL_TRIBES', 'TRAIT_AGENDA_BESTIAL_TRIBES'),
('AGENDA_BESTIAL_TRIBES', 'TRAIT_AGENDA_BARBARIAN_LOVER');

INSERT INTO AiListTypes(ListType) VALUES
('BestialTribesBuildings'),
('BestialTribesCivics'),
('BestialTribesTechs');

INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('BestialTribesBuildings', 'TRAIT_AGENDA_BESTIAL_TRIBES', 'Buildings'),
('BestialTribesTechs', 'TRAIT_AGENDA_BESTIAL_TRIBES', 'Technologies');


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('BestialTribesBuildings', 'SLTH_BUILDING_WARRENS', '1');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('BestialTribesTechs', 'TECH_MASONRY', '1');

-- Doviello     Wolves of Winter
-- Ambiorix: Generic rush? Bronze Working.
-- Qin Alt barb lover

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_CHARADON', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('LEADER_MAHALA', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_WOLVES_OF_WINTER', 'LOC_SLTH_TRAIT_CIVILIZATION_DOVIELLO_COOL_NAME', 'LOC_AGENDA_WOLVES_OF_WINTER_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_CHARADON',	'AGENDA_WOLVES_OF_WINTER'),
('LEADER_MAHALA',	'AGENDA_WOLVES_OF_WINTER');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_WOLVES_OF_WINTER');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_WOLVES_OF_WINTER', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_WOLVES_OF_WINTER', 'TRAIT_AGENDA_WOLVES_OF_WINTER'),
('AGENDA_WOLVES_OF_WINTER', 'TRAIT_AGENDA_BARBARIAN_LOVER');                  -- barb lovers

INSERT INTO AiListTypes(ListType) VALUES
('WolvesOfWinterUnits'),
('WolvesOfWinterTechs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('WolvesOfWinterUnits', 'TRAIT_AGENDA_WOLVES_OF_WINTER', 'UnitPromotionClasses'),
('WolvesOfWinterTechs', 'TRAIT_AGENDA_WOLVES_OF_WINTER', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('WolvesOfWinterUnits', 'PROMOTION_CLASS_MELEE', '1');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('WolvesOfWinterTechs', 'TECH_BRONZE_WORKING', '1');

-- Elohim       Tolerant
-- Chancel, Monk. -- Dont think its in FFH. Spirit Mana for Monk strength?
-- Priesthood, Way of Wise,
-- FoL, RoK, Order, and Empyrean.


INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_ETHNE',	'AGENDA_PEACEKEEPER'),                          -- nicked from Gandhi
('LEADER_EINION',	'AGENDA_PEACEKEEPER');

INSERT INTO AiListTypes(ListType) VALUES
('TolerantUnits'),
('TolerantBuildings'),
('TolerantCivics');

INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('TolerantUnits', 'TRAIT_AGENDA_PEACEKEEPER', 'UnitPromotionClasses'),
('TolerantBuildings', 'TRAIT_AGENDA_PEACEKEEPER', 'Buildings'),
('TolerantCivics', 'TRAIT_AGENDA_PEACEKEEPER', 'Civics');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('TolerantUnits', 'PROMOTION_CLASS_DISCIPLE', '1'),
('TolerantBuildings', 'SLTH_BUILDING_CHANCEL', '1');


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('TolerantCivics', 'CIVIC_PRIESTHOOD', '1'),                -- for monks
('TolerantCivics', 'CIVIC_FANATICISM', '1');              -- for corlinedale

-- Grigori      Agnostic Heroes
-- anti bias towards religion civics.
-- bias towards all great people (because we cant do per city great people)

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_GODLESS_HEROES', 'LOC_SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL_NAME', 'LOC_AGENDA_GODLESS_HEROES_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_CASSIEL',	'AGENDA_GODLESS_HEROES');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_GODLESS_HEROES');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_GODLESS_HEROES', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_GODLESS_HEROES', 'TRAIT_AGENDA_GODLESS_HEROES');

-- doesnt like competitiors for great people
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_AGENDA_GODLESS_HEROES', 'AGENDA_MODIFIER_LAGS_GREAT_PEOPLE'),
('TRAIT_AGENDA_GODLESS_HEROES', 'AGENDA_MODIFIER_LEADS_GREAT_PEOPLE');
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_GODLESS_HEROES', 'AGENDA_GREAT_PERSON_ADVOCATE');

INSERT INTO AiListTypes(ListType) VALUES
('GodlessHeroesBuildings'),
('GodlessHeroesCivics');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('GreatPersonObsessedGreatPeople', 'TRAIT_AGENDA_GODLESS_HEROES', 'PseudoYields'),
('GodlessHeroesBuildings', 'TRAIT_AGENDA_GODLESS_HEROES', 'Buildings'),
('GodlessHeroesCivics', 'TRAIT_AGENDA_GODLESS_HEROES', 'Civics');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('GodlessHeroesBuildings', 'SLTH_BUILDING_NATIONAL_EPIC', '1'),                            -- national epic
('GodlessHeroesBuildings', 'BUILDING_GUILDHALL', '1');                            -- adventurers guild
-- ('GodlessHeroesBuildings', '', '1');                            -- mage guild           (arcane line maybe strong?)


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('GodlessHeroesCivics', 'CIVIC_CORRUPTION_OF_SPIRIT', '0'),           -- religions unfavoured
('GodlessHeroesCivics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '0'),
('GodlessHeroesCivics', 'CIVIC_WAY_OF_THE_EARTHMOTHER', '0'),
('GodlessHeroesCivics', 'CIVIC_WAY_OF_THE_FORESTS', '0'),
('GodlessHeroesCivics', 'CIVIC_DECEPTION', '0'),
('GodlessHeroesCivics', 'CIVIC_HONOR', '0'),
('GodlessHeroesCivics', 'CIVIC_ORDERS_FROM_HEAVEN', '0'),
('GodlessHeroesCivics', 'CIVIC_MIND_STAPLING', '0'),
('GodlessHeroesCivics', 'CIVIC_INFERNAL_PACT', '0'),
('GodlessHeroesCivics', 'CIVIC_ARETE', '0'),
('GodlessHeroesCivics', 'CIVIC_HIDDEN_PATHS', '0'),
('GodlessHeroesCivics', 'CIVIC_MALEVOLENT_DESIGNS', '0');

-- Hippus       Horselords

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_TASUNKE', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('LEADER_RHOANNA', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');          -- unsure if she should.. she doesnt rush

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_HORSELORDS', 'LOC_SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL_NAME', 'LOC_AGENDA_HORSELORDS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_TASUNKE',	'AGENDA_HORSELORDS'),
('LEADER_RHOANNA',	'AGENDA_HORSELORDS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_HORSELORDS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_HORSELORDS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_HORSELORDS', 'TRAIT_AGENDA_HORSELORDS');


INSERT INTO AiListTypes(ListType) VALUES
('HorseLordsYields'),
('HorseLordsUnits'),
('HorseLordsBuildings'),
('HorseLordsCivics'),
('HorseLordsTechs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('HorseLordsUnits', 'TRAIT_AGENDA_HORSELORDS', 'UnitPromotionClasses'),
('HorseLordsBuildings', 'TRAIT_AGENDA_HORSELORDS', 'Buildings'),
('HorseLordsCivics', 'TRAIT_AGENDA_HORSELORDS', 'Civics'),
('HorseLordsTechs', 'TRAIT_AGENDA_HORSELORDS', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('HorseLordsUnits', 'PROMOTION_CLASS_LIGHT_CAVALRY', '1');
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('HorseLordsBuildings', 'BUILDING_STABLE', '1'),
('HorseLordsBuildings', 'SLTH_BUILDING_RIDE_OF_THE_NINE_KINGS', '1'),
('HorseLordsBuildings', 'BUILDING_UNIVERSITY_SANKORE', '1');            -- guild of the nine for mounted mercs

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('HorseLordsTechs', 'TECH_WARHORSES', '1'),
('HorseLordsTechs', 'TECH_STIRRUPS', '1'),
('HorseLordsTechs', 'TECH_HORSEBACK_RIDING', '1');

-- Illians      Resurrectors of Fallen Winter
-- bias for tundra and snow (no ice in mapgen issuess....) It seems you caannot bias for terrains
-- ok so bias for the civic unlocks for the different projects...

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_WINTER_REZ', 'LOC_SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL_NAME', 'LOC_AGENDA_WINTER_REZ_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_AURIC',	'AGENDA_WINTER_REZ');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_WINTER_REZ');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_WINTER_REZ', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_WINTER_REZ', 'TRAIT_AGENDA_WINTER_REZ');

-- kinda screwed if we cant do project pseudo yields
INSERT INTO AiListTypes(ListType) VALUES
('WinterRezBuildings'),
('WinterRezCivics'),
('WinterRezTechs'),
('WinterRezProjects');

INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('WinterRezBuildings', 'TRAIT_AGENDA_WINTER_REZ', 'Buildings'),
('WinterRezCivics', 'TRAIT_AGENDA_WINTER_REZ', 'Civics'),
('WinterRezTechs', 'TRAIT_AGENDA_WINTER_REZ', 'Technologies'),
('WinterRezProjects', 'TRAIT_AGENDA_WINTER_REZ', 'Projects');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('WinterRezBuildings', 'SLTH_BUILDING_TEMPLE_OF_THE_HAND', '1'),
('WinterRezBuildings', 'SLTH_BUILDING_CELESTIAL_COMPASS', '1');             -- for faster rituals... idk


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('WinterRezCivics', 'CIVIC_CORRUPTION_OF_SPIRIT', '0'),           -- religions unfavoured
('WinterRezCivics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '0'),
('WinterRezCivics', 'CIVIC_DECEPTION', '0'),
('WinterRezCivics', 'CIVIC_MIND_STAPLING', '0'),
('WinterRezCivics', 'CIVIC_INFERNAL_PACT', '0'),
('WinterRezCivics', 'CIVIC_WAY_OF_THE_EARTHMOTHER', '0'),
('WinterRezCivics', 'CIVIC_WAY_OF_THE_FORESTS', '0'),
('WinterRezCivics', 'CIVIC_HONOR', '0'),
('WinterRezCivics', 'CIVIC_ORDERS_FROM_HEAVEN', '0'),
('WinterRezCivics', 'CIVIC_ARETE', '0'),
('WinterRezCivics', 'CIVIC_HIDDEN_PATHS', '0'),
('WinterRezCivics', 'CIVIC_POLITICAL_PHILOSOPHY', '1'),
('WinterRezCivics', 'CIVIC_PRIESTHOOD', '1'),
('WinterRezTechs', 'TECH_STRENGTH_OF_WILL', '1'),               -- ideally we want a Strategy to switch to these tech stuff later
('WinterRezTechs', 'TECH_OMNISCIENCE', '1'),
('WinterRezProjects', 'PROJECT_STIR_FROM_SLUMBER', '1'),
('WinterRezProjects', 'PROJECT_SAMHAIN', '1'),
('WinterRezProjects', 'PROJECT_WHITE_HAND', '1'),
('WinterRezProjects', 'PROJECT_DEEPENING', '1'),
('WinterRezProjects', 'PROJECT_THE_DRAW', '1'),
('WinterRezProjects', 'PROJECT_ASCENSION', '1');

-- Infernal     Fallow
-- zero out value for food. Super aggro.
-- to zero out food needs work because of different era yield strategis
-- if it goed negative does that go the other way, todo ASK ROMAN
-- something to make him even more aggro than AGGRESSIVE_MILITARY?
INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_HYBOREM', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_FALLOW', 'LOC_SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL_NAME', 'LOC_AGENDA_FALLOW_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_HYBOREM',	'AGENDA_FALLOW');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_FALLOW');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_FALLOW', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_FALLOW', 'TRAIT_AGENDA_FALLOW'),
('AGENDA_FALLOW', 'TRAIT_AGENDA_BARBARIAN_LOVER');


INSERT INTO AiListTypes(ListType) VALUES
('FallowPseudoYields'),
('FallowYields'),
('FallowUnits'),
('FallowBuildings'),
('FallowCivics'),
('FallowTechs'),
('FallowPlotEval');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('FallowPseudoYields', 'TRAIT_AGENDA_FALLOW', 'PseudoYields'),
('FallowYields', 'TRAIT_AGENDA_FALLOW', 'Yields'),
('FallowBuildings', 'TRAIT_AGENDA_FALLOW', 'Buildings'),
('FallowCivics', 'TRAIT_AGENDA_FALLOW', 'Civics'),
('FallowTechs', 'TRAIT_AGENDA_FALLOW', 'Technologies'),
('FallowPlotEval', 'TRAIT_AGENDA_FALLOW', 'PlotEvaluations');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('FallowPseudoYields', 'PSEUDOYIELD_DIPLOMATIC_BONUS', '-20'),              -- WARRRR
('FallowPseudoYields', 'PSEUDOYIELD_DIPLOMATIC_GRIEVANCE', '-20');              -- WARRRR

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('FallowYields', 'YIELD_FOOD', '-100');                   -- does this overflow into avoiding food in certain ages. +25 strongest point

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('FallowBuildings', 'BUILDING_BARRACKS', '1'),
('FallowBuildings', 'BUILDING_STABLE', '1');

INSERT INTO AiFavoredItems(ListType, Item, Value, StringVal) VALUES
('FallowPlotEval', 'Total Yield', '-1', 'YIELD_FOOD'),
('FallowPlotEval', 'Inner Ring Yield', '-2', 'YIELD_FOOD');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('FallowCivics', 'CIVIC_CORRUPTION_OF_SPIRIT', '1'),           -- should be impossible not to have these two but...
('FallowCivics', 'CIVIC_INFERNAL_PACT', '1'),
('FallowCivics', 'CIVIC_WAY_OF_THE_WICKED', '1'),
('FallowCivics', 'CIVIC_MALEVOLENT_DESIGNS', '1'),              -- mardero i guess?
('FallowTechs', 'TECH_IRON_WORKING', '1');                  -- free iron makes this value


-- khazad attempt. Likes gold. Doesnt like people with lots of hills.
INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_DWARVEN_GOLD', 'LOC_SLTH_TRAIT_CIVILIZATION_KHAZAD_COOL_NAME', 'LOC_AGENDA_ETHIOPIAN_HIGHLANDS_DESCRIPTION');
INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_KANDROS',	'AGENDA_DWARVEN_GOLD'),
('LEADER_ARTURUS',	'AGENDA_DWARVEN_GOLD');
INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_DWARVEN_GOLD', 'KIND_TRAIT');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_DWARVEN_GOLD');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_DWARVEN_GOLD', 'TRAIT_AGENDA_DWARVEN_GOLD');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_AGENDA_DWARVEN_GOLD', 'AGENDA_MODIFIER_CITIES_NEAR_HILLS');         -- dont like other hilly civs

INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');

INSERT INTO AiListTypes(ListType) VALUES
('DwarvenGoldPseudoYields'),
('DwarvenGoldYields'),
('DwarvenGoldSavings'),
('DwarvenGoldCivics');

INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('DwarvenGoldPseudoYields', 'TRAIT_AGENDA_DWARVEN_GOLD', 'PseudoYields'),
('DwarvenGoldYields', 'TRAIT_AGENDA_DWARVEN_GOLD', 'Yields'),
('DwarvenGoldSavings', 'TRAIT_AGENDA_DWARVEN_GOLD', 'SavingTypes'),
('DwarvenGoldCivics', 'TRAIT_AGENDA_DWARVEN_GOLD', 'Civics');

UPDATE AiLists SET AgendaType = 'TRAIT_AGENDA_DWARVEN_GOLD' WHERE ListType='PreferHills' AND System='PlotEvaluations';          -- give ethiopia highlands stuff. But unsure if its just city centre.

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('DwarvenGoldPseudoYields', 'PSEUDOYIELD_UNIT_TRADE', '50'),            -- do we want em to trade? ehhhhh
('DwarvenGoldYields', 'YIELD_GOLD', '25'),
('DwarvenGoldSavings', 'SAVING_SLUSH_FUND', '7');                               -- vault gold

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('DwarvenGoldCivics', 'CIVIC_WAY_OF_THE_EARTHMOTHER', '1');

-- Strategies AiLists ('FavorCulturalVictory', FavorReligiousVictory, ForbidReligiousVictory, FavorScienceVictory);
-- AlexanderPreferWar?

-- Kuriotates       Sprawling
-- remove plot eval for Horses (centaur means no need)
-- technically need totally new plot eval when 4 ring, but we dont have that
-- enclave means cottage economy, so education bias
--
INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_SPRAWLING', 'LOC_SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL_NAME', 'LOC_AGENDA_SPRAWLING_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_CARDITH',	'AGENDA_SPRAWLING');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_SPRAWLING');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_SPRAWLING', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_SPRAWLING', 'TRAIT_AGENDA_SPRAWLING');

INSERT INTO AiListTypes(ListType) VALUES
('SprawlingYields'),
('SprawlingBuildings'),
('SprawlingCivics'),
('SprawlingTechs'),
('SprawlingSettlementPreferences');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('SprawlingYields', 'TRAIT_AGENDA_SPRAWLING', 'Yields'),
('SprawlingBuildings', 'TRAIT_AGENDA_SPRAWLING', 'Buildings'),
('SprawlingCivics', 'TRAIT_AGENDA_SPRAWLING', 'Civics'),
('SprawlingTechs', 'TRAIT_AGENDA_SPRAWLING', 'Technologies'),
('SprawlingSettlementPreferences', 'TRAIT_AGENDA_SPRAWLING', 'PlotEvaluations');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('SprawlingYields', 'YIELD_CULTURE', '10');                   -- should they bias culture? Legends did promote culture win

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('SprawlingBuildings', 'BUILDING_GRAND_BAZAAR', '1');                   -- bazaar of mammon

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('SprawlingCivics', 'CIVIC_EDUCATION', '1'),           -- cottage into enclaves
('SprawlingCivics', 'CIVIC_MYSTICISM', '1'),            -- god king very important
('SprawlingTechs', 'TECH_HORSEBACK_RIDING', '1');           -- centaurs

INSERT INTO AiFavoredItems(ListType, Item, Favored, Value, StringVal) VALUES
('SprawlingSettlementPreferences', 'Specific Resource', '1', '1', 'RESOURCE_DYES'),            -- Resource bias for Tailor
('SprawlingSettlementPreferences', 'Specific Resource', '1', '1', 'RESOURCE_SILK'),
('SprawlingSettlementPreferences', 'Specific Resource', '1', '1', 'RESOURCE_COTTON'),
('SprawlingSettlementPreferences', 'Specific Resource', '1', '1', 'RESOURCE_DIAMONDS'),            -- Resource bias for Jeweler
('SprawlingSettlementPreferences', 'Specific Resource', '1', '1', 'RESOURCE_GOLD'),
--('SprawlingSettlementPreferences', 'Specific Resource', '1', '1', 'RESOURCE_PEARLS'),   -- no bias for Pearls, as cannot see them
('SprawlingSettlementPreferences', 'Specific Resource', '1', '-3', 'RESOURCE_HORSES');            -- no desire for horses

-- Lanun            Seafaring
-- coastal settles like Dido, similar on the agenda
-- weirdly cant find bias for coastal...
INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_FALAMAR', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('LEADER_HANNAH', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_SEAFARING', 'LOC_SLTH_TRAIT_CIVILIZATION_LANUN_COOL_NAME', 'LOC_AGENDA_SICILIAN_WARS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_FALAMAR',	'AGENDA_SEAFARING'),
('LEADER_HANNAH',	'AGENDA_SEAFARING');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_SEAFARING');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_SEAFARING', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_SEAFARING', 'TRAIT_AGENDA_SEAFARING');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_AGENDA_SEAFARING', 'AGENDA_SICILIAN_WARS_LOW_COASTAL_CITES'),
('TRAIT_AGENDA_SEAFARING', 'AGENDA_SICILIAN_WARS_HIGH_COASTAL_CITIES');

INSERT INTO AiListTypes(ListType) VALUES
('SeafaringYields'),
('SeafaringUnits'),
('SeafaringBuildings'),
('SeafaringCivics'),
('SeafaringTechs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('SeafaringUnits', 'TRAIT_AGENDA_SEAFARING', 'UnitPromotionClasses'),
('SeafaringBuildings', 'TRAIT_AGENDA_SEAFARING', 'Buildings'),
('SeafaringCivics', 'TRAIT_AGENDA_SEAFARING', 'Civics'),
('SeafaringTechs', 'TRAIT_AGENDA_SEAFARING', 'Technologies'),
('LastVikingKingCoastSettlement', 'TRAIT_AGENDA_SEAFARING', 'PlotEvaluations');         -- coastal bias

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('SeafaringUnits', 'PROMOTION_CLASS_NAVAL_MELEE', '1');                 -- this might be too much
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('SeafaringBuildings', 'BUILDING_LIGHTHOUSE', '1'),
('SeafaringBuildings', 'SLTH_BUILDING_HARBOR_LANUN', '1'),              -- bias towards big trade
('SeafaringBuildings', 'BUILDING_GREAT_LIGHTHOUSE', '1');              -- bias towards big trade


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('SeafaringCivics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '1'),            -- OO bias
('SeafaringCivics', 'CIVIC_MIND_STAPLING', '1'),            -- OO bias
('SeafaringCivics', 'CIVIC_WAY_OF_THE_WICKED', '1'),              -- for slavery
('SeafaringTechs', 'SLTH_TECH_SAILING', '1'),                   -- naval techs
('SeafaringTechs', 'TECH_FISHING', '1'),
('SeafaringTechs', 'TECH_TRADE', '1');              -- bias towards big trade

-- Ljosalfar        Elven Forest Defenders

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_AMELANCHIER', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_FOREST_DEFENDERS', 'LOC_SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL_NAME', 'LOC_AGENDA_FOREST_DEFENDERS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_AMELANCHIER',	'AGENDA_FOREST_DEFENDERS'),
('LEADER_ARENDEL',	'AGENDA_FOREST_DEFENDERS'),
('LEADER_THESSA',	'AGENDA_FOREST_DEFENDERS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_FOREST_DEFENDERS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_FOREST_DEFENDERS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_FOREST_DEFENDERS', 'TRAIT_AGENDA_FOREST_DEFENDERS');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_AGENDA_FOREST_DEFENDERS', 'AGENDA_ENVIRONMENT');         -- dont like those who tear down forests/resources
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_FOREST_DEFENDERS', 'AGENDA_ENVIRONMENTALIST'),
('AGENDA_FOREST_DEFENDERS', 'AGENDA_EXPLOITATIVE'),
('AGENDA_FOREST_DEFENDERS', 'AGENDA_INDUSTRIALIST');

INSERT INTO AiListTypes(ListType) VALUES
('ForestDefendersUnits'),
('ForestDefendersCivics'),
('ForestDefendersTechs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('ForestDefendersUnits', 'TRAIT_AGENDA_FOREST_DEFENDERS', 'UnitPromotionClasses'),
('ForestDefendersCivics', 'TRAIT_AGENDA_FOREST_DEFENDERS', 'Civics'),
('ForestDefendersTechs', 'TRAIT_AGENDA_FOREST_DEFENDERS', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('ForestDefendersUnits', 'PROMOTION_CLASS_RANGED', '1');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('ForestDefendersCivics', 'CIVIC_WAY_OF_THE_FORESTS', '1'),           -- Fellowship of Leaves strong pref
('ForestDefendersCivics', 'CIVIC_HIDDEN_PATHS', '1'),
('ForestDefendersCivics', 'CIVIC_DRAMA_POETRY', '1'),                   -- good for bard to build Fellowship
('ForestDefendersCivics', 'CIVIC_EDUCATION', '1'),              -- apprenticeship and cottage
('ForestDefendersCivics', 'CIVIC_FERAL_BOND', '1'),              -- kitha. But need to check it wont try make it instantly.
('ForestDefendersTechs', 'TECH_CALENDAR', '1'),                        -- agri?
('ForestDefendersTechs', 'TECH_ARCHERY', '1'),                         -- Ranged line
('ForestDefendersTechs', 'TECH_CONSTRUCTION', '0');                         -- cant make siege

-- Luichuirp        Golem Crafters
-- sculptor studios! Tech_Construction. Science bias as golems behind em?
-- negative bias towards swordsmen (bronze working), recon line, cavalry line
-- the ai would also need help to makke blasting workshops, pallens and adularia. But the AI wont use the promos.

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_GARRIM', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),          -- they do kinda aggro well
('LEADER_BEERI', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_GOLEM_CRAFTERS', 'LOC_SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL_NAME', 'LOC_AGENDA_GOLEM_CRAFTERS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_GARRIM',	'AGENDA_GOLEM_CRAFTERS'),
('LEADER_BEERI',	'AGENDA_GOLEM_CRAFTERS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_GOLEM_CRAFTERS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_GOLEM_CRAFTERS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_GOLEM_CRAFTERS', 'TRAIT_AGENDA_GOLEM_CRAFTERS');

INSERT INTO AiListTypes(ListType) VALUES
('GolemCraftersYields'),
('GolemCraftersBuildings'),
('GolemCraftersCivics'),
('GolemCraftersTechs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('GolemCraftersYields', 'TRAIT_AGENDA_GOLEM_CRAFTERS', 'Yields'),
('GolemCraftersBuildings', 'TRAIT_AGENDA_GOLEM_CRAFTERS', 'Buildings'),
('GolemCraftersCivics', 'TRAIT_AGENDA_GOLEM_CRAFTERS', 'Civics'),
('GolemCraftersTechs', 'TRAIT_AGENDA_GOLEM_CRAFTERS', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('GolemCraftersYields', 'YIELD_SCIENCE', '10');                   -- not sure if want to bias science
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('GolemCraftersBuildings', 'SLTH_BUILDING_SCULPTORS_STUDIO', '1'),
('GolemCraftersBuildings', 'SLTH_BUILDING_GUILD_OF_HAMMERS', '1'),
('GolemCraftersBuildings', 'SLTH_BUILDING_RIDE_OF_THE_NINE_KINGS', '0'),            -- experience wonders unfavored
('GolemCraftersBuildings', 'BUILDING_COLOSSUS', '0');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('GolemCraftersCivics', 'CIVIC_WAY_OF_THE_EARTHMOTHER', '1'),           -- religion runes
('GolemCraftersCivics', 'CIVIC_ARETE', '1'),           -- r
('GolemCraftersTechs', 'TECH_CONSTRUCTION', '1'),                    -- for wood golems
('GolemCraftersTechs', 'TECH_IRON_WORKING', '1'),                     -- iron golems?
('GolemCraftersTechs', 'TECH_BRONZE_WORKING', '0');                    -- dont care about swordsman

-- Malakim          Desert Nomads

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_DECIUS_MALAKIM', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');          -- varn is not aggro

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_DESERT_NOMADS', 'LOC_SLTH_TRAIT_CIVILIZATION_MALAKIM_COOL_NAME', 'LOC_AGENDA_DESERT_NOMADS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_VARN',	'AGENDA_DESERT_NOMADS'),
('LEADER_DECIUS_MALAKIM',	'AGENDA_DESERT_NOMADS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_DESERT_NOMADS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_DESERT_NOMADS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_DESERT_NOMADS', 'TRAIT_AGENDA_DESERT_NOMADS');

INSERT INTO AiListTypes(ListType) VALUES
('DesertNomadsUnits'),
('DesertNomadsBuildings'),
('DesertNomadsCivics'),
('DesertNomadsTechs'),
('DesertNomadsUnitBuilds'),
('DesertNomadsPlotEval');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('DesertNomadsUnits', 'TRAIT_AGENDA_DESERT_NOMADS', 'UnitPromotionClasses'),
('DesertNomadsBuildings', 'TRAIT_AGENDA_DESERT_NOMADS', 'Buildings'),
('DesertNomadsCivics', 'TRAIT_AGENDA_DESERT_NOMADS', 'Civics'),
('DesertNomadsTechs', 'TRAIT_AGENDA_DESERT_NOMADS', 'Technologies'),
('DesertNomadsUnitBuilds', 'TRAIT_AGENDA_DESERT_NOMADS', 'Units'),
('DesertNomadsPlotEval', 'TRAIT_AGENDA_DESERT_NOMADS', 'PlotEvaluations');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('DesertNomadsUnits', 'PROMOTION_CLASS_DISCIPLE', '1'),
('DesertNomadsUnitBuilds', 'SLTH_UNIT_LIGHTBRINGER', '1');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('DesertNomadsBuildings', 'SLTH_BUILDING_DESERT_SHRINE', '1');
-- ('DesertNomadsBuildings', 'SLTH_BUILDING_CITADEL_OF_LIGHT', '1');            -- would need bias to build it, but it sucks


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('DesertNomadsCivics', 'CIVIC_PRIESTHOOD', '1'),
('DesertNomadsCivics', 'CIVIC_HONOR', '1'),                 -- religions
('DesertNomadsCivics', 'CIVIC_CORRUPTION_OF_SPIRIT', '0'),           -- religions unfavoured
('DesertNomadsCivics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '0'),
('DesertNomadsCivics', 'CIVIC_DECEPTION', '0'),
('DesertNomadsCivics', 'CIVIC_MIND_STAPLING', '0'),
('DesertNomadsCivics', 'CIVIC_INFERNAL_PACT', '0'),
('DesertNomadsCivics', 'CIVIC_MYSTICISM', '1'),             -- desert shrine
('DesertNomadsTechs',  'TECH_TRADE', '1');                        -- for Honor, when we stitch trees.

INSERT INTO AiFavoredItems(ListType, Item, Value, StringVal) VALUES
('DesertNomadsPlotEval', 'Total Yield', '1', 'YIELD_FAITH'),
('DesertNomadsPlotEval', 'Inner Ring Yield', '2', 'YIELD_FAITH');

-- Mercurian        Angelic Warriors
-- At the start of each turn, all your cities will be purged of the  Ashen Veil and the Mercurians automatically
-- declare war on any Civilization following the Ashen Veil if they have been at peace for more than 20 turns.
INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_BASIUM', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_ANGELIC_WARRIORS', 'LOC_SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL_NAME', 'LOC_AGENDA_ANGELIC_WARRIORS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_BASIUM',	'AGENDA_ANGELIC_WARRIORS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_ANGELIC_WARRIORS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_ANGELIC_WARRIORS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_ANGELIC_WARRIORS', 'TRAIT_AGENDA_ANGELIC_WARRIORS');

INSERT INTO AiListTypes(ListType) VALUES
('AngelicWarriorsCivics');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('AngelicWarriorsCivics', 'TRAIT_AGENDA_ANGELIC_WARRIORS', 'Civics');


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('AngelicWarriorsCivics', 'CIVIC_CORRUPTION_OF_SPIRIT', '0'),           -- religions
('AngelicWarriorsCivics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '0'),
('AngelicWarriorsCivics', 'CIVIC_DECEPTION', '0'),
('AngelicWarriorsCivics', 'CIVIC_MIND_STAPLING', '0'),
('AngelicWarriorsCivics', 'CIVIC_INFERNAL_PACT', '0'),
('AngelicWarriorsCivics', 'CIVIC_WAY_OF_THE_WICKED', '0');

-- Sheaim           Seekers of Armageddon

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_TEBRYN', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('LEADER_OS_GABELLA', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');
-- certainly aggro, because of ye olde Pyre Zombie
INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_ARMAGEDDON_SEEKERS', 'LOC_SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL_NAME', 'LOC_AGENDA_ARMAGEDDON_SEEKERS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_TEBRYN',	'AGENDA_ARMAGEDDON_SEEKERS'),
('LEADER_OS_GABELLA',	'AGENDA_ARMAGEDDON_SEEKERS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_ARMAGEDDON_SEEKERS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_ARMAGEDDON_SEEKERS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_ARMAGEDDON_SEEKERS', 'TRAIT_AGENDA_ARMAGEDDON_SEEKERS');


INSERT INTO AiListTypes(ListType) VALUES
('ArmageddonSeekersBuildings'),
('ArmageddonSeekersCivics'),
('ArmageddonSeekersTechs'),
('ArmageddonSeekersUnitBuilds');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('ArmageddonSeekersBuildings', 'TRAIT_AGENDA_ARMAGEDDON_SEEKERS', 'Buildings'),
('ArmageddonSeekersCivics', 'TRAIT_AGENDA_ARMAGEDDON_SEEKERS', 'Civics'),
('ArmageddonSeekersTechs', 'TRAIT_AGENDA_ARMAGEDDON_SEEKERS', 'Technologies'),
('ArmageddonSeekersUnitBuilds', 'TRAIT_AGENDA_ARMAGEDDON_SEEKERS', 'Units');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('ArmageddonSeekersUnitBuilds', 'SLTH_UNIT_PYRE_ZOMBIE', '1');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('ArmageddonSeekersBuildings', 'SLTH_BUILDING_PLANAR_GATE', '1'),               -- as doesnt give yields, they wont build
('ArmageddonSeekersBuildings', 'BUILDING_MAGE_GUILD', '1');



INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('ArmageddonSeekersCivics', 'CIVIC_CORRUPTION_OF_SPIRIT', '1'),           -- religions
('ArmageddonSeekersCivics', 'CIVIC_INFERNAL_PACT', '1'),           -- religions
-- ('ArmageddonSeekersCivics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '1'),         -- do they want this as stopgap
('ArmageddonSeekersTechs', 'TECH_BRONZE_WORKING', '1'),                        -- for pyre zombies
('ArmageddonSeekersTechs', 'TECH_KNOWLEDGE_OF_THE_ETHER', '1');             -- mage guilds for planar

-- Sidar            Ghostly Spirits
-- Want to go Great People. Also want to get as much experience as possible
INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_GHOSTLY_SPIRITS', 'LOC_SLTH_TRAIT_CIVILIZATION_SIDAR_COOL_NAME', 'LOC_AGENDA_GHOSTLY_SPIRITS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_SANDALPHON',	'AGENDA_GHOSTLY_SPIRITS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_GHOSTLY_SPIRITS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_GHOSTLY_SPIRITS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_GHOSTLY_SPIRITS', 'TRAIT_AGENDA_GHOSTLY_SPIRITS');


INSERT INTO AiListTypes(ListType) VALUES
('GhostlySpiritsUnits'),
('GhostlySpiritsBuildings'),
('GhostlySpiritsCivics'),
('GhostlySpiritsPseudoYields');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('GhostlySpiritsBuildings', 'TRAIT_AGENDA_GHOSTLY_SPIRITS', 'Buildings'),
('GhostlySpiritsCivics', 'TRAIT_AGENDA_GHOSTLY_SPIRITS', 'Civics'),
('GhostlySpiritsPseudoYields', 'TRAIT_AGENDA_GHOSTLY_SPIRITS', 'PseudoYields');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('GhostlySpiritsPseudoYields', 'PSEUDOYIELD_GPP_PROPHET', '75');

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('GhostlySpiritsBuildings', 'SLTH_BUILDING_RIDE_OF_THE_NINE_KINGS', '1'),           -- experience buildings for shades
('GhostlySpiritsBuildings', 'BUILDING_COLOSSUS', '1'),
('GhostlySpiritsBuildings', 'SLTH_BUILDING_HEROIC_EPIC', '1'),
('GhostlySpiritsBuildings', 'BUILDING_KOTOKU_IN', '1'),
('GhostlySpiritsBuildings', 'SLTH_BUILDING_NATIONAL_EPIC', '1'),
('GhostlySpiritsBuildings', 'BUILDING_PAGODA', '1'),
('GhostlySpiritsBuildings', 'SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR', '1'),
('GhostlySpiritsBuildings', 'SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_ANOINTED', '1'),
('GhostlySpiritsBuildings', 'SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_BLESSED', '1'),
('GhostlySpiritsBuildings', 'SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_CONSECRATED', '1'),
('GhostlySpiritsBuildings', 'SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_DIVINE', '1'),
('GhostlySpiritsBuildings', 'SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_EXALTED', '1');          -- dont favour the final one?

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('GhostlySpiritsCivics', 'CIVIC_MILITARY_STRATEGY', '1');

-- Svartalfar       Elven Assassins

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('LEADER_FAERYL', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_ELVEN_ASSASSINS', 'LOC_SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL_NAME', 'LOC_AGENDA_ELVEN_ASSASSINS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_FAERYL',	'AGENDA_ELVEN_ASSASSINS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_ELVEN_ASSASSINS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_ELVEN_ASSASSINS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_ELVEN_ASSASSINS', 'TRAIT_AGENDA_ELVEN_ASSASSINS');

INSERT INTO AiListTypes(ListType) VALUES
('ElvenAssassinsUnits'),
('ElvenAssassinsCivics'),
('ElvenAssassinsTechs'),
('ElvenAssassinsDiplomacy');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('ElvenAssassinsUnits', 'TRAIT_AGENDA_ELVEN_ASSASSINS', 'UnitPromotionClasses'),
('ElvenAssassinsCivics', 'TRAIT_AGENDA_ELVEN_ASSASSINS', 'Civics'),
('ElvenAssassinsTechs', 'TRAIT_AGENDA_ELVEN_ASSASSINS', 'Technologies'),
('ElvenAssassinsDiplomacy', 'TRAIT_AGENDA_ELVEN_ASSASSINS', 'DiplomaticActions');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('ElvenAssassinsUnits', 'PROMOTION_CLASS_RECON', '1');                  -- recon line bias

INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('ElvenAssassinsCivics', 'CIVIC_DECEPTION', '1'),           -- religions
('ElvenAssassinsTechs', 'TECH_POISONS', '1'),               -- recon line
('ElvenAssassinsTechs', 'TECH_HUNTING', '1'),
('ElvenAssassinsTechs', 'TECH_CONSTRUCTION', '0'),         -- no siege
('ElvenAssassinsDiplomacy', 'DIPLOACTION_DECLARE_SURPRISE_WAR', '1'),         -- declare suprise war
('ElvenAssassinsDiplomacy', 'DIPLOACTION_DECLARE_FORMAL_WAR', '1');         -- declare war

--
INSERT INTO AiListTypes(ListType) VALUES
('SlthDefaultTechs');
                                                                            -- ai hates calender... dunno why
INSERT INTO AiLists(ListType, LeaderType, System) VALUES
('SlthDefaultTechs', 'TRAIT_LEADER_MAJOR_CIV', 'Technologies');
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('SlthDefaultTechs', 'TECH_CALENDAR', '1');          -- recon line

DELETE FROM AiFavoredItems WHERE Item == 'PSEUDOYIELD_GPP_ADMIRAL';
DELETE FROM AiFavoredItems WHERE Item == 'PSEUDOYIELD_GPP_MUSICIAN';
UPDATE AiFavoredItems SET Value = 20 WHERE Item == 'PSEUDOYIELD_GPP_PROPHET' AND Value < 0;
UPDATE AiFavoredItems SET Value = -100 WHERE Item == 'PSEUDOYIELD_UNIT_AIR_COMBAT' AND Value > 0;


-- Victory Strategies
DELETE FROM Strategy_Priorities WHERE StrategyType = 'VICTORY_STRATEGY_SCIENCE_VICTORY' AND ListType='ScienceVictoryDistricts';
DELETE FROM Strategy_Priorities WHERE StrategyType = 'VICTORY_STRATEGY_SCIENCE_VICTORY' AND ListType='ScienceVictoryProjects';
DELETE FROM Strategy_Priorities WHERE StrategyType = 'VICTORY_STRATEGY_SCIENCE_VICTORY' AND ListType='ScienceVictoryDistricts';

DELETE FROM AiFavoredItems WHERE ListType = 'ScienceVictoryPseudoYields' AND Item = 'PSEUDOYIELD_SPACE_RACE';
DELETE FROM AiFavoredItems WHERE ListType = 'ScienceVictoryPseudoYields' AND Item = 'PSEUDOYIELD_GPP_SCIENTIST';

-- DELETE FROM StrategyConditions WHERE StrategyType ='VICTORY_STRATEGY_SCIENCE_VICTORY' AND ConditionFunction = 'Is Renaissance';

-- science techs
UPDATE AiFavoredItems SET Item = 'TECH_ALTERATION' WHERE Item = 'TECH_ROCKETRY' ;
UPDATE AiFavoredItems SET Item = 'TECH_DIVINATION' WHERE Item = 'TECH_SATELLITES' ;
UPDATE AiFavoredItems SET Item = 'TECH_ELEMENTALISM' WHERE Item = 'TECH_ROBOTICS' ;
UPDATE AiFavoredItems SET Item = 'TECH_NECROMANCY' WHERE Item = 'TECH_NUCLEAR_FUSION' ;
UPDATE AiFavoredItems SET Item = 'TECH_STRENGTH_OF_WILL' WHERE Item = 'TECH_NANOTECHNOLOGY' ;

-- RESOURCE_ALUMINIUM
DELETE FROM Strategy_Priorities WHERE ListType = 'ReligiousVictoryBehaviors';
DELETE FROM Strategy_Priorities WHERE ListType = 'ReligiousVictoryDiplomacy';
DELETE FROM Strategy_Priorities WHERE ListType = 'ReligiousVictoryYields';

DELETE FROM AiFavoredItems WHERE ListType = 'ReligiousVictoryPseudoYields' AND Item = 'PSEUDOYIELD_UNIT_RELIGIOUS';
DELETE FROM AiFavoredItems WHERE ListType = 'ReligiousVictoryPseudoYields' AND Item = 'PSEUDOYIELD_RELIGIOUS_CONVERT_EMPIRE';
UPDATE AiFavoredItems SET Value = 75 WHERE ListType = 'ReligiousVictoryPseudoYields' AND Item = 'PSEUDOYIELD_GPP_PROPHET';

DELETE FROM StrategyConditions WHERE StrategyType ='VICTORY_STRATEGY_RELIGIOUS_VICTORY' AND ConditionFunction = 'Founded Religion';
DELETE FROM StrategyConditions WHERE StrategyType ='VICTORY_STRATEGY_RELIGIOUS_VICTORY' AND ConditionFunction = 'Cannot Found Religion';
DELETE FROM StrategyConditions WHERE StrategyType ='VICTORY_STRATEGY_RELIGIOUS_VICTORY' AND ConditionFunction = 'Religion Destroyed';

-- no diplo victory
DELETE FROM Strategy_Priorities WHERE StrategyType = 'VICTORY_STRATEGY_DIPLOMATIC_VICTORY';
DELETE FROM Strategies WHERE StrategyType = 'VICTORY_STRATEGY_DIPLOMATIC_VICTORY';
DELETE FROM AiFavoredItems WHERE Item == 'PSEUDOYIELD_DIPLOMATIC_FAVOR';
DELETE FROM AiFavoredItems WHERE Item == 'PSEUDOYIELD_DIPLOMATIC_VICTORY_POINT';

-- no city states
DELETE FROM AiFavoredItems WHERE Item == 'PSEUDOYIELD_INFLUENCE';
-- PSEUDOYIELD_ENVIRONMENT          -- could be good for ljosalfar. if you could turn on with modifiers, fellowship.
--PSEUDOYIELD_RESOURCE_LUXURY           -- sadly seems to be only control over resources. We would need fake yields to do improvement encouragement on resources

-- ignore warmongering? from Darwinist
UPDATE PseudoYields SET DefaultValue= '0.01' WHERE PseudoYieldType='PSEUDOYIELD_DIPLOMATIC_BONUS';          -- from 0.25
UPDATE PseudoYields SET DefaultValue= '0.01' WHERE PseudoYieldType='PSEUDOYIELD_DIPLOMATIC_GRIEVANCE';          -- from 0.25

DELETE FROM AiFavoredItems WHERE Item == 'PSEUDOYIELD_GOLDENAGE_POINT';
--
-- PSEUDOYIELD_UNIT_AIR_COMBAT
UPDATE PseudoYields SET DefaultValue= '-4.00' WHERE PseudoYieldType='PSEUDOYIELD_UNIT_AIR_COMBAT';          -- ai cant use hawks right.
UPDATE PseudoYields SET DefaultValue= '10.0' WHERE PseudoYieldType='PSEUDOYIELD_WONDER';          -- AI dont like building any wonders

-- try stopping them building naval units only...
-- DELETE FROM AiFavoredItems WHERE Item == 'PSEUDOYIELD_UNIT_NAVAL_COMBAT';


-- Alignment hatred
--
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_EVIL_PLAYER_HATES_GOOD_INTERACTION'),
-- ('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_EVIL_PLAYER_DISLIKES_NEUTRAL_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_EVIL_PLAYER_LOVES_EVIL_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_GOOD_PLAYER_HATES_EVIL_INTERACTION'),
-- ('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_GOOD_PLAYER_DISLIKES_NEUTRAL_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_GOOD_PLAYER_LOVES_GOOD_INTERACTION');

INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('STANDARD_DIPLOMATIC_EVIL_PLAYER_HATES_GOOD_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_IS_EVIL_REQS', 'OPPOSING_PLAYER_IS_GOOD_REQS'),
-- ('STANDARD_DIPLOMATIC_EVIL_PLAYER_DISLIKES_NEUTRAL_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_IS_EVIL_REQS', 'OPPOSING_PLAYER_IS_NEUTRAL_REQS'),
('STANDARD_DIPLOMATIC_EVIL_PLAYER_LOVES_EVIL_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_IS_EVIL_REQS', 'OPPOSING_PLAYER_IS_EVIL_REQS'),
('STANDARD_DIPLOMATIC_GOOD_PLAYER_HATES_EVIL_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_IS_GOOD_REQS', 'OPPOSING_PLAYER_IS_EVIL_REQS'),
-- ('STANDARD_DIPLOMATIC_GOOD_PLAYER_DISLIKES_NEUTRAL_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_IS_EVIL_REQS', 'OPPOSING_PLAYER_IS_NEUTRAL_REQS'),
('STANDARD_DIPLOMATIC_GOOD_PLAYER_LOVES_GOOD_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_IS_GOOD_REQS', 'OPPOSING_PLAYER_IS_GOOD_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('STANDARD_DIPLOMATIC_EVIL_PLAYER_HATES_GOOD_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_EVIL_HATES_GOOD'),
('STANDARD_DIPLOMATIC_EVIL_PLAYER_HATES_GOOD_INTERACTION', 'InitialValue', '-20'),
-- ('STANDARD_DIPLOMATIC_EVIL_PLAYER_DISLIKES_NEUTRAL_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_EVIL_NEUTRAL'),
-- ('STANDARD_DIPLOMATIC_EVIL_PLAYER_DISLIKES_NEUTRAL_INTERACTION', 'InitialValue', '-10'),
('STANDARD_DIPLOMATIC_EVIL_PLAYER_LOVES_EVIL_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_EVIL_LOVES_EVIL'),
('STANDARD_DIPLOMATIC_EVIL_PLAYER_LOVES_EVIL_INTERACTION', 'InitialValue', '20'),
('STANDARD_DIPLOMATIC_GOOD_PLAYER_HATES_EVIL_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_GOOD_HATES_EVIL'),
('STANDARD_DIPLOMATIC_GOOD_PLAYER_HATES_EVIL_INTERACTION', 'InitialValue', '-20'),
-- ('STANDARD_DIPLOMATIC_GOOD_PLAYER_DISLIKES_NEUTRAL_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_GOOD_NEUTRAL'),
-- ('STANDARD_DIPLOMATIC_GOOD_PLAYER_DISLIKES_NEUTRAL_INTERACTION', 'InitialValue', '-10'),
('STANDARD_DIPLOMATIC_GOOD_PLAYER_LOVES_GOOD_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_GOOD_LOVES_GOOD'),
('STANDARD_DIPLOMATIC_GOOD_PLAYER_LOVES_GOOD_INTERACTION', 'InitialValue', '20');
-- LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL, just uses {diplomaticReason}, we probably cant use that
INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('STANDARD_DIPLOMATIC_EVIL_PLAYER_HATES_GOOD_INTERACTION', 'Sample', 'LOC_DIPLO_EVIL_HATES_GOOD'),
-- ('STANDARD_DIPLOMATIC_EVIL_PLAYER_DISLIKES_NEUTRAL_INTERACTION', 'Sample', 'LOC_DIPLO_EVIL_DISLIKES_NEUTRAL'),
('STANDARD_DIPLOMATIC_EVIL_PLAYER_LOVES_EVIL_INTERACTION', 'Sample', 'LOC_DIPLO_EVIL_LOVES_EVIL'),
('STANDARD_DIPLOMATIC_GOOD_PLAYER_HATES_EVIL_INTERACTION', 'Sample', 'LOC_DIPLO_GOOD_HATES_EVIL'),
-- ('STANDARD_DIPLOMATIC_GOOD_PLAYER_DISLIKES_NEUTRAL_INTERACTION', 'Sample', 'LOC_DIPLO_GOOD_DISLIKES_NEUTRAL'),
('STANDARD_DIPLOMATIC_GOOD_PLAYER_LOVES_GOOD_INTERACTION', 'Sample', 'LOC_DIPLO_GOOD_LOVES_GOOD');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('OPPOSING_PLAYER_IS_GOOD_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_IS_NEUTRAL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_IS_EVIL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_IS_GOOD_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_IS_NEUTRAL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_IS_EVIL_REQS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('OPPOSING_PLAYER_IS_GOOD_REQS', 'REQUIRE_PLAYER_HAS_GOOD_CAPITAL'),
('OPPOSING_PLAYER_IS_GOOD_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_IS_NEUTRAL_REQS', 'REQUIRE_PLAYER_HAS_NEUTRAL_CAPITAL'),
('OPPOSING_PLAYER_IS_NEUTRAL_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_IS_EVIL_REQS', 'REQUIRE_PLAYER_HAS_EVIL_CAPITAL'),
('OPPOSING_PLAYER_IS_EVIL_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('PLAYER_IS_GOOD_REQS', 'REQUIRE_PLAYER_HAS_GOOD_CAPITAL'),
('PLAYER_IS_NEUTRAL_REQS', 'REQUIRE_PLAYER_HAS_NEUTRAL_CAPITAL'),
('PLAYER_IS_EVIL_REQS', 'REQUIRE_PLAYER_HAS_EVIL_CAPITAL');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('REQUIRE_PLAYER_HAS_GOOD_CAPITAL', 'REQUIREMENT_COLLECTION_ANY_MET'),
('REQUIRE_PLAYER_HAS_NEUTRAL_CAPITAL', 'REQUIREMENT_COLLECTION_ANY_MET'),
('REQUIRE_PLAYER_HAS_EVIL_CAPITAL', 'REQUIREMENT_COLLECTION_ANY_MET');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('REQUIRE_PLAYER_HAS_GOOD_CAPITAL', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_GOOD_CAPITAL', 'RequirementSetId',  'ALIGNMENT_GOOD_REQS'),                 -- used for paladin
('REQUIRE_PLAYER_HAS_NEUTRAL_CAPITAL', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_NEUTRAL_CAPITAL', 'RequirementSetId',  'ALIGNMENT_NEUTRAL_REQS'),
('REQUIRE_PLAYER_HAS_EVIL_CAPITAL', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_EVIL_CAPITAL', 'RequirementSetId',  'ALIGNMENT_EVIL_REQS');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_SAME_RELIGION_RUNES_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_RUNES_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_SAME_RELIGION_OCTOPUS_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_OCTOPUS_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_SAME_RELIGION_ORDER_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ORDER_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_SAME_RELIGION_VEIL_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_VEIL_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_SAME_RELIGION_LEAVES_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_LEAVES_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_SAME_RELIGION_EMPYREAN_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_EMPYREAN_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_SAME_RELIGION_ESUS_INTERACTION'),
('TRAIT_LEADER_MAJOR_CIV', 'STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ESUS_INTERACTION');


INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('STANDARD_DIPLOMATIC_SAME_RELIGION_RUNES_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_RUNES_STATE_REQS', 'OPPOSING_PLAYER_HAS_RUNES_STATE_REQS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_RUNES_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_RUNES_STATE_REQS', 'OPPOSING_PLAYER_HAS_STATEREL_NOT_RUNES_REQS'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_OCTOPUS_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_OCTOPUS_STATE_REQS', 'OPPOSING_PLAYER_HAS_OCTOPUS_STATE_REQS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_OCTOPUS_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_OCTOPUS_STATE_REQS', 'OPPOSING_PLAYER_HAS_STATEREL_NOT_OCTOPUS_REQS'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_ORDER_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_ORDER_STATE_REQS', 'OPPOSING_PLAYER_HAS_ORDER_STATE_REQS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ORDER_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_ORDER_STATE_REQS', 'OPPOSING_PLAYER_HAS_STATEREL_NOT_ORDER_REQS'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_VEIL_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_VEIL_STATE_REQS', 'OPPOSING_PLAYER_HAS_VEIL_STATE_REQS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_VEIL_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_VEIL_STATE_REQS', 'OPPOSING_PLAYER_HAS_STATEREL_NOT_VEIL_REQS'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_LEAVES_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_LEAVES_STATE_REQS', 'OPPOSING_PLAYER_HAS_LEAVES_STATE_REQS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_LEAVES_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_LEAVES_STATE_REQS', 'OPPOSING_PLAYER_HAS_STATEREL_NOT_LEAVES_REQS'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_EMPYREAN_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_EMPYREAN_STATE_REQS', 'OPPOSING_PLAYER_HAS_EMPYREAN_STATE_REQS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_EMPYREAN_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_EMPYREAN_STATE_REQS', 'OPPOSING_PLAYER_HAS_STATEREL_NOT_EMPYREAN_REQS'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_ESUS_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_ESUS_STATE_REQS', 'OPPOSING_PLAYER_HAS_ESUS_STATE_REQS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ESUS_INTERACTION', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'PLAYER_HAS_ESUS_STATE_REQS', 'OPPOSING_PLAYER_HAS_STATEREL_NOT_ESUS_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('STANDARD_DIPLOMATIC_SAME_RELIGION_RUNES_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_RUNES_SAME_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_RUNES_INTERACTION', 'InitialValue', '20'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_RUNES_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_RUNES_DIFFERENT_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_RUNES_INTERACTION', 'InitialValue', '-10'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_OCTOPUS_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_OCTOPUS_SAME_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_OCTOPUS_INTERACTION', 'InitialValue', '20'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_OCTOPUS_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_OCTOPUS_DIFFERENT_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_OCTOPUS_INTERACTION', 'InitialValue', '-10'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_ORDER_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ORDER_SAME_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_ORDER_INTERACTION', 'InitialValue', '20'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ORDER_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ORDER_DIFFERENT_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ORDER_INTERACTION', 'InitialValue', '-10'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_VEIL_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_VEIL_SAME_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_VEIL_INTERACTION', 'InitialValue', '20'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_VEIL_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_VEIL_DIFFERENT_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_VEIL_INTERACTION', 'InitialValue', '-10'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_LEAVES_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_LEAVES_SAME_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_LEAVES_INTERACTION', 'InitialValue', '20'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_LEAVES_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_LEAVES_DIFFERENT_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_LEAVES_INTERACTION', 'InitialValue', '-10'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_EMPYREAN_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_EMPYREAN_SAME_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_EMPYREAN_INTERACTION', 'InitialValue', '20'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_EMPYREAN_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_EMPYREAN_DIFFERENT_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_EMPYREAN_INTERACTION', 'InitialValue', '-10'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_ESUS_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ESUS_SAME_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_ESUS_INTERACTION', 'InitialValue', '20'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ESUS_INTERACTION', 'SimpleModifierDescription', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ESUS_DIFFERENT_STATE_RELIGION'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ESUS_INTERACTION', 'InitialValue', '-10');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('STANDARD_DIPLOMATIC_SAME_RELIGION_RUNES_INTERACTION', 'Sample', 'LOC_DIPLO_SAME_RELIGION_RUNES'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_RUNES_INTERACTION', 'Sample', 'LOC_DIPLO_DIFFERENT_RELIGION_RUNES'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_OCTOPUS_INTERACTION', 'Sample', 'LOC_DIPLO_SAME_RELIGION_OCTOPUS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_OCTOPUS_INTERACTION', 'Sample', 'LOC_DIPLO_DIFFERENT_RELIGION_OCTOPUS'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_ORDER_INTERACTION', 'Sample', 'LOC_DIPLO_SAME_RELIGION_ORDER'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ORDER_INTERACTION', 'Sample', 'LOC_DIPLO_DIFFERENT_RELIGION_ORDER'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_VEIL_INTERACTION', 'Sample', 'LOC_DIPLO_SAME_RELIGION_VEIL'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_VEIL_INTERACTION', 'Sample', 'LOC_DIPLO_DIFFERENT_RELIGION_VEIL'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_LEAVES_INTERACTION', 'Sample', 'LOC_DIPLO_SAME_RELIGION_LEAVES'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_LEAVES_INTERACTION', 'Sample', 'LOC_DIPLO_DIFFERENT_RELIGION_LEAVES'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_EMPYREAN_INTERACTION', 'Sample', 'LOC_DIPLO_SAME_RELIGION_EMPYREAN'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_EMPYREAN_INTERACTION', 'Sample', 'LOC_DIPLO_DIFFERENT_RELIGION_EMPYREAN'),
('STANDARD_DIPLOMATIC_SAME_RELIGION_ESUS_INTERACTION', 'Sample', 'LOC_DIPLO_SAME_RELIGION_ESUS'),
('STANDARD_DIPLOMATIC_DIFFERENT_RELIGION_ESUS_INTERACTION', 'Sample', 'LOC_DIPLO_DIFFERENT_RELIGION_ESUS');


INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('PLAYER_HAS_RUNES_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_HAS_OCTOPUS_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_HAS_ORDER_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_HAS_VEIL_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_HAS_LEAVES_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_HAS_EMPYREAN_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLAYER_HAS_ESUS_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_RUNES_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_OCTOPUS_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_ORDER_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_VEIL_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_LEAVES_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_EMPYREAN_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_ESUS_STATE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_RUNES_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_OCTOPUS_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_ORDER_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_VEIL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_LEAVES_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_EMPYREAN_REQS', 'REQUIREMENTSET_TEST_ALL'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_ESUS_REQS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('OPPOSING_PLAYER_HAS_RUNES_STATE_REQS', 'REQUIRE_PLAYER_HAS_RUNES_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_RUNES_STATE_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_OCTOPUS_STATE_REQS', 'REQUIRE_PLAYER_HAS_OCTOPUS_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_OCTOPUS_STATE_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_ORDER_STATE_REQS', 'REQUIRE_PLAYER_HAS_ORDER_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_ORDER_STATE_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_VEIL_STATE_REQS', 'REQUIRE_PLAYER_HAS_VEIL_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_VEIL_STATE_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_LEAVES_STATE_REQS', 'REQUIRE_PLAYER_HAS_LEAVES_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_LEAVES_STATE_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_EMPYREAN_STATE_REQS', 'REQUIRE_PLAYER_HAS_EMPYREAN_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_EMPYREAN_STATE_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_ESUS_STATE_REQS', 'REQUIRE_PLAYER_HAS_ESUS_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_ESUS_STATE_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('PLAYER_HAS_RUNES_STATE_REQS', 'REQUIRE_PLAYER_HAS_RUNES_STATE_RELIGION'),
('PLAYER_HAS_OCTOPUS_STATE_REQS', 'REQUIRE_PLAYER_HAS_OCTOPUS_STATE_RELIGION'),
('PLAYER_HAS_ORDER_STATE_REQS', 'REQUIRE_PLAYER_HAS_ORDER_STATE_RELIGION'),
('PLAYER_HAS_VEIL_STATE_REQS', 'REQUIRE_PLAYER_HAS_VEIL_STATE_RELIGION'),
('PLAYER_HAS_LEAVES_STATE_REQS', 'REQUIRE_PLAYER_HAS_LEAVES_STATE_RELIGION'),
('PLAYER_HAS_EMPYREAN_STATE_REQS', 'REQUIRE_PLAYER_HAS_EMPYREAN_STATE_RELIGION'),
('PLAYER_HAS_ESUS_STATE_REQS', 'REQUIRE_PLAYER_HAS_ESUS_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_RUNES_REQS', 'REQUIRE_PLAYER_HASNT_RUNES_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_RUNES_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_OCTOPUS_REQS', 'REQUIRE_PLAYER_HASNT_OCTOPUS_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_OCTOPUS_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_ORDER_REQS', 'REQUIRE_PLAYER_HASNT_ORDER_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_ORDER_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_VEIL_REQS', 'REQUIRE_PLAYER_HASNT_VEIL_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_VEIL_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_LEAVES_REQS', 'REQUIRE_PLAYER_HASNT_LEAVES_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_LEAVES_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_EMPYREAN_REQS', 'REQUIRE_PLAYER_HASNT_EMPYREAN_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_EMPYREAN_REQS', 'REQUIRES_PLAYERS_HAVE_MET'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_ESUS_REQS', 'REQUIRE_PLAYER_HASNT_ESUS_STATE_RELIGION'),
('OPPOSING_PLAYER_HAS_STATEREL_NOT_ESUS_REQS', 'REQUIRES_PLAYERS_HAVE_MET');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('REQUIRE_PLAYER_HAS_RUNES_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET'),
('REQUIRE_PLAYER_HAS_OCTOPUS_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET'),
('REQUIRE_PLAYER_HAS_ORDER_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET'),
('REQUIRE_PLAYER_HAS_VEIL_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET'),
('REQUIRE_PLAYER_HAS_LEAVES_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET'),
('REQUIRE_PLAYER_HAS_EMPYREAN_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET'),
('REQUIRE_PLAYER_HAS_ESUS_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET');

INSERT INTO Requirements(RequirementId, RequirementType, Inverse) VALUES
('REQUIRE_PLAYER_HASNT_RUNES_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET', '1'),
('REQUIRE_PLAYER_HASNT_OCTOPUS_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET', '1'),
('REQUIRE_PLAYER_HASNT_ORDER_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET', '1'),
('REQUIRE_PLAYER_HASNT_VEIL_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET', '1'),
('REQUIRE_PLAYER_HASNT_LEAVES_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET', '1'),
('REQUIRE_PLAYER_HASNT_EMPYREAN_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET', '1'),
('REQUIRE_PLAYER_HASNT_ESUS_STATE_RELIGION', 'REQUIREMENT_COLLECTION_ANY_MET', '1');


INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('REQUIRE_PLAYER_HAS_RUNES_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_RUNES_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_RUNES_STATE_REL_REQS'),
('REQUIRE_PLAYER_HAS_OCTOPUS_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_OCTOPUS_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_OCTOPUS_STATE_REL_REQS'),

('REQUIRE_PLAYER_HAS_ORDER_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_ORDER_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_ORDER_STATE_REL_REQS'),
('REQUIRE_PLAYER_HAS_VEIL_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_VEIL_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_VEIL_STATE_REL_REQS'),
('REQUIRE_PLAYER_HAS_LEAVES_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_LEAVES_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_LEAVES_STATE_REL_REQS'),
('REQUIRE_PLAYER_HAS_EMPYREAN_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_EMPYREAN_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_EMPYREAN_STATE_REL_REQS'),
('REQUIRE_PLAYER_HAS_ESUS_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HAS_ESUS_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_ESUS_STATE_REL_REQS'),

('REQUIRE_PLAYER_HASNT_RUNES_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HASNT_RUNES_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_RUNES_OR_NONE_STATE_REL_REQS'),
('REQUIRE_PLAYER_HASNT_OCTOPUS_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HASNT_OCTOPUS_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_OCTOPUS_OR_NONE_STATE_REL_REQS'),
('REQUIRE_PLAYER_HASNT_ORDER_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HASNT_ORDER_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_ORDER_OR_NONE_STATE_REL_REQS'),
('REQUIRE_PLAYER_HASNT_VEIL_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HASNT_VEIL_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_VEIL_OR_NONE_STATE_REL_REQS'),
('REQUIRE_PLAYER_HASNT_LEAVES_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HASNT_LEAVES_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_LEAVES_OR_NONE_STATE_REL_REQS'),
('REQUIRE_PLAYER_HASNT_EMPYREAN_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HASNT_EMPYREAN_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_EMPYREAN_OR_NONE_STATE_REL_REQS'),
('REQUIRE_PLAYER_HASNT_ESUS_STATE_RELIGION', 'CollectionType',  'COLLECTION_PLAYER_CAPITAL_CITY'),
('REQUIRE_PLAYER_HASNT_ESUS_STATE_RELIGION', 'RequirementSetId',  'PLOT_PROP_ESUS_OR_NONE_STATE_REL_REQS');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('PLOT_PROP_RUNES_STATE_REL_REQS', 'PLOT_PROP_RUNES_STATE_REL_POSITIVE'),
('PLOT_PROP_OCTOPUS_STATE_REL_REQS', 'PLOT_PROP_OCTOPUS_STATE_REL_POSITIVE'),
('PLOT_PROP_ORDER_STATE_REL_REQS', 'PLOT_PROP_ORDER_STATE_REL_POSITIVE'),
('PLOT_PROP_VEIL_STATE_REL_REQS', 'PLOT_PROP_VEIL_STATE_REL_POSITIVE'),
('PLOT_PROP_LEAVES_STATE_REL_REQS', 'PLOT_PROP_LEAVES_STATE_REL_POSITIVE'),
('PLOT_PROP_EMPYREAN_STATE_REL_REQS', 'PLOT_PROP_EMPYREAN_STATE_REL_POSITIVE'),
('PLOT_PROP_ESUS_STATE_REL_REQS', 'PLOT_PROP_ESUS_STATE_REL_POSITIVE');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('PLOT_PROP_RUNES_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLOT_PROP_OCTOPUS_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLOT_PROP_ORDER_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLOT_PROP_VEIL_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLOT_PROP_LEAVES_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLOT_PROP_EMPYREAN_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('PLOT_PROP_ESUS_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('PLOT_PROP_RUNES_STATE_REL_POSITIVE', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_OCTOPUS_STATE_REL_POSITIVE', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_ORDER_STATE_REL_POSITIVE', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_VEIL_STATE_REL_POSITIVE', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_LEAVES_STATE_REL_POSITIVE', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_EMPYREAN_STATE_REL_POSITIVE', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_ESUS_STATE_REL_POSITIVE', 'REQUIREMENT_PLOT_PROPERTY_MATCHES');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('PLOT_PROP_RUNES_STATE_REL_POSITIVE', 'PropertyName','RUNES_STATE_REL'),
('PLOT_PROP_RUNES_STATE_REL_POSITIVE', 'PropertyMinimum','1'),
('PLOT_PROP_OCTOPUS_STATE_REL_POSITIVE', 'PropertyName','OCTOPUS_STATE_REL'),
('PLOT_PROP_OCTOPUS_STATE_REL_POSITIVE', 'PropertyMinimum','1'),
('PLOT_PROP_ORDER_STATE_REL_POSITIVE', 'PropertyName','ORDER_STATE_REL'),
('PLOT_PROP_ORDER_STATE_REL_POSITIVE', 'PropertyMinimum','1'),
('PLOT_PROP_VEIL_STATE_REL_POSITIVE', 'PropertyName','VEIL_STATE_REL'),
('PLOT_PROP_VEIL_STATE_REL_POSITIVE', 'PropertyMinimum','1'),
('PLOT_PROP_LEAVES_STATE_REL_POSITIVE', 'PropertyName','LEAVES_STATE_REL'),
('PLOT_PROP_LEAVES_STATE_REL_POSITIVE', 'PropertyMinimum','1'),
('PLOT_PROP_EMPYREAN_STATE_REL_POSITIVE', 'PropertyName','EMPYREAN_STATE_REL'),
('PLOT_PROP_EMPYREAN_STATE_REL_POSITIVE', 'PropertyMinimum','1'),
('PLOT_PROP_ESUS_STATE_REL_POSITIVE', 'PropertyName','ESUS_STATE_REL'),
('PLOT_PROP_ESUS_STATE_REL_POSITIVE', 'PropertyMinimum','1');

-- extra for anti

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('PLOT_PROP_RUNES_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_RUNES_STATE_REL_POSITIVE'),
('PLOT_PROP_RUNES_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_NO_STATE_REL_POSITIVE'),
('PLOT_PROP_OCTOPUS_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_OCTOPUS_STATE_REL_POSITIVE'),
('PLOT_PROP_OCTOPUS_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_NO_STATE_REL_POSITIVE'),
('PLOT_PROP_ORDER_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_ORDER_STATE_REL_POSITIVE'),
('PLOT_PROP_ORDER_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_NO_STATE_REL_POSITIVE'),
('PLOT_PROP_VEIL_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_VEIL_STATE_REL_POSITIVE'),
('PLOT_PROP_VEIL_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_NO_STATE_REL_POSITIVE'),
('PLOT_PROP_LEAVES_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_LEAVES_STATE_REL_POSITIVE'),
('PLOT_PROP_LEAVES_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_NO_STATE_REL_POSITIVE'),
('PLOT_PROP_EMPYREAN_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_EMPYREAN_STATE_REL_POSITIVE'),
('PLOT_PROP_EMPYREAN_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_NO_STATE_REL_POSITIVE'),
('PLOT_PROP_ESUS_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_ESUS_STATE_REL_POSITIVE'),
('PLOT_PROP_ESUS_OR_NONE_STATE_REL_REQS', 'PLOT_PROP_NO_STATE_REL_POSITIVE');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('PLOT_PROP_RUNES_OR_NONE_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_OCTOPUS_OR_NONE_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_ORDER_OR_NONE_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_VEIL_OR_NONE_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_LEAVES_OR_NONE_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_EMPYREAN_OR_NONE_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_ESUS_OR_NONE_STATE_REL_REQS', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('PLOT_PROP_NO_STATE_REL_POSITIVE', 'REQUIREMENT_PLOT_PROPERTY_MATCHES');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('PLOT_PROP_NO_STATE_REL_POSITIVE', 'PropertyName','NO_STATE_REL'),
('PLOT_PROP_NO_STATE_REL_POSITIVE', 'PropertyMinimum','1');
