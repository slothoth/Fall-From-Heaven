-- elohim Backstab Averse, Tomyris. OR. Gandhi peaceful



-- Basium, Bolivar? Highly promoted units.

-- Amurite. Science focus like Korea? because mages need science.

-- Nzinga just a hater of people on her continent?

-- Philipp for Grigori? Or do they even care about other religions coming in. not really.
-- I suppose for Grigori, its get Great Prophets. Pedro?

-- Khazad. Get lots of money like Mansa Musa? And Ethiopia settle on hills stuff.
-- Kandros, Mansa musa or Kublai. Arturus, Wonders and I guess go wide?

-- Hippus. Genghis Khan

-- Ljosalfar: Kupe try plant woods and keep features.

-- Lanun: Harald Hadrada Last Viking King. OR Dido, settle coastal cities.

-- Chandra: Generic Warmonger?

-- Trajan: Generic Go Wide?



-- Qin Wonder: Generic Wonder builder (Industrious)

-- Qin Unifier: Generic Barb lover (Doviello, Clan, Infernal)

-- Fun Loving, for Balseraphs?

-- agendas to cut.
DELETE FROM RandomAgendas WHERE AgendaType IN ('AGENDA_AIRPOWER', 'AGENDA_CITY_STATE_ALLY', 'AGENDA_CITY_STATE_PROTECTOR',
'AGENDA_DEMAGOGUE', 'AGENDA_DESTINATION_CIV', 'AGENDA_FLAT_EARTHER', 'AGENDA_LIBERTARIAN',
'AGENDA_NUKE_LOVER', 'AGENDA_SYCOPHANT', 'AGENDA_SYMPATHIZER', 'AGENDA_ZEALOT');

DELETE FROM RandomAgendas WHERE AgendaType IN ('AGENDA_BARBARIAN_LOVER');

UPDATE AiFavoredItems SET Value = 10 WHERE ListType='DefaultYieldBias' and Item='YIELD_FAITH';
DELETE FROM AiFavoredItems WHERE ListType='ClassicalYields' and Item='YIELD_FAITH';
DELETE FROM AiFavoredItems WHERE ListType='MedievalYields' and Item='YIELD_FAITH';
DELETE FROM AiFavoredItems WHERE ListType='IndustrialYields' and Item='YIELD_FAITH';

DELETE FROM AiLists WHERE ListType='DefaultTechBoostSupportList';

-- adjust agendas:
-- war Darwinist, limit some civs getting it?
-- Barbarian Ally (at least remove from random pool)
-- Environmentalist: add Fellowship Of Leaves bias. Remove national parks bit
-- Ideologue. Can we adjust this to be on religon policy

-- Populous, but instead hate high pop civs.
-- oh god could we make state religion a government.

-- bring back Curmudgeon and Flirtatious
--

-- Amurite Masters of Sorcery
--AGENDA_MASTERS_OF_SORCERY
INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_MASTERS_OF_SORCERY', 'LOC_AGENDA_MASTERS_OF_SORCERY_NAME', 'LOC_AGENDA_MASTERS_OF_SORCERY_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_VALLEDIA',	'AGENDA_MASTERS_OF_SORCERY'),
('LEADER_DAIN',	'AGENDA_MASTERS_OF_SORCERY');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_MASTERS_OF_SORCERY');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_MASTERS_OF_SORCERY', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_MASTERS_OF_SORCERY', 'TRAIT_AGENDA_MASTERS_OF_SORCERY');

-- section for agenda relationship
-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
-- ('TRAIT_AGENDA_SLAVER_CARNIVALS', NULL);         -- dont like other hilly civs
/*
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

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
('AGENDA_SLAVER_CARNIVALS', 'LOC_AGENDA_SLAVER_CARNIVALS_NAME', 'LOC_AGENDA_SLAVER_CARNIVALS_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_PERPENTACH',	'AGENDA_SLAVER_CARNIVALS'),
('LEADER_KEELYN',	'AGENDA_SLAVER_CARNIVALS');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_SLAVER_CARNIVALS');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_SLAVER_CARNIVALS', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_SLAVER_CARNIVALS', 'TRAIT_AGENDA_SLAVER_CARNIVALS');

-- section for agenda relationship
-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
-- ('TRAIT_AGENDA_SLAVER_CARNIVALS', NULL);         -- dont like other hilly civs
/*
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

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
('AGENDA_HOLY_CRUSADERS', 'LOC_AGENDA_HOLY_CRUSADERS_NAME', 'LOC_AGENDA_HOLY_CRUSADERS_DESCRIPTION');

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

-- section for agenda relationship. Bannor: hates other civs with veil or any evil civ?
/*
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_AGENDA_SLAVER_CARNIVALS', NULL);
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

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
('AGENDA_VAMPIRIC_ARISTOCRACY', 'LOC_AGENDA_VAMPIRIC_ARISTOCRACY_NAME', 'LOC_AGENDA_VAMPIRIC_ARISTOCRACY_DESCRIPTION');

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

-- section for agenda relationship
-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
-- ('TRAIT_AGENDA_SLAVER_CARNIVALS', NULL);         -- dont like other hilly civs
/*
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

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
('AGENDA_BESTIAL_TRIBES', 'LOC_AGENDA_BESTIAL_TRIBES_NAME', 'LOC_AGENDA_BESTIAL_TRIBES_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_JONAS',	'AGENDA_BESTIAL_TRIBES'),
('LEADER_SHEELBA',	'AGENDA_BESTIAL_TRIBES');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_BESTIAL_TRIBES');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_BESTIAL_TRIBES', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_BESTIAL_TRIBES', 'TRAIT_AGENDA_BESTIAL_TRIBES'),
('AGENDA_BESTIAL_TRIBES', 'AGENDA_BARBARIAN_LOVER');

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
('AGENDA_WOLVES_OF_WINTER', 'LOC_AGENDA_WOLVES_OF_WINTER_NAME', 'LOC_AGENDA_WOLVES_OF_WINTER_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('LEADER_CHARADON',	'AGENDA_WOLVES_OF_WINTER'),
('LEADER_MAHALA',	'AGENDA_WOLVES_OF_WINTER');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_AGENDA_WOLVES_OF_WINTER');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_AGENDA_WOLVES_OF_WINTER', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('AGENDA_WOLVES_OF_WINTER', 'TRAIT_AGENDA_WOLVES_OF_WINTER'),
('AGENDA_WOLVES_OF_WINTER', 'AGENDA_BARBARIAN_LOVER');                  -- barb lovers

-- section for agenda relationship
-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
-- ('TRAIT_AGENDA_SLAVER_CARNIVALS', NULL);         -- dont like other hilly civs
/*
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

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

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('$1', 'LOC_$1_NAME', 'LOC_$1_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('',	'$1'),
('',	'$1');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_$1');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_$1', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('$1', 'TRAIT_$1');

-- section for agenda relationship
-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
-- ('TRAIT_$1', NULL);         -- dont like other hilly civs
/*
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

INSERT INTO AiListTypes(ListType) VALUES
('$2Yields'),
('$2Units'),
('$2Buildings'),
('$2Civics'),
('$2Techs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('$2Yields', 'TRAIT_$1', 'Yields'),
('$2Units', 'TRAIT_$1', 'UnitPromotionClasses'),
('$2Buildings', 'TRAIT_$1', 'Buildings'),
('$2Civics', 'TRAIT_$1', 'Civics'),
('$2Techs', 'TRAIT_$1', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('$2Yields', 'YIELD_CULTURE', '25'),                   -- not sure if want to bias culture
('$2Units', 'PROMOTION_CLASS_RECON', '1');
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('$2Buildings', '', '1'),
('$2Buildings', '', '1');


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('$2Civics', 'CIVIC_CORRUPTION_OF_SPIRIT', '1'),           -- religions
('$2Civics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '1'),
('$2Civics', 'CIVIC_DRAMA_POETRY', '1'),
('$2Civics', 'CIVIC_DRAMA_POETRY', '1'),
('$2Civics', 'CIVIC_WAY_OF_THE_WICKED', '1'),              -- for slavery
('$2Civics', 'TECH_CALENDAR', '1'),                        -- for carnivals
('$2Civics', 'TECH_HUNTING', '1'),                         -- recon line
('$2Civics', 'TECH_POISONS', '1');

-- Grigori      Agnostic Heroes

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('$1', 'LOC_$1_NAME', 'LOC_$1_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('',	'$1'),
('',	'$1');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_$1');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_$1', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('$1', 'TRAIT_$1');

-- section for agenda relationship
-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
-- ('TRAIT_$1', NULL);         -- dont like other hilly civs
/*
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

INSERT INTO AiListTypes(ListType) VALUES
('$2Yields'),
('$2Units'),
('$2Buildings'),
('$2Civics'),
('$2Techs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('$2Yields', 'TRAIT_$1', 'Yields'),
('$2Units', 'TRAIT_$1', 'UnitPromotionClasses'),
('$2Buildings', 'TRAIT_$1', 'Buildings'),
('$2Civics', 'TRAIT_$1', 'Civics'),
('$2Techs', 'TRAIT_$1', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('$2Yields', 'YIELD_CULTURE', '25'),                   -- not sure if want to bias culture
('$2Units', 'PROMOTION_CLASS_RECON', '1');
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('$2Buildings', '', '1'),
('$2Buildings', '', '1');
--


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('$2Civics', 'CIVIC_CORRUPTION_OF_SPIRIT', '1'),           -- religions
('$2Civics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '1'),
('$2Civics', 'CIVIC_DRAMA_POETRY', '1'),
('$2Civics', 'CIVIC_DRAMA_POETRY', '1'),
('$2Civics', 'CIVIC_WAY_OF_THE_WICKED', '1'),              -- for slavery
('$2Civics', 'TECH_CALENDAR', '1'),                        -- for carnivals
('$2Civics', 'TECH_HUNTING', '1'),                         -- recon line
('$2Civics', 'TECH_POISONS', '1');

-- Hippus       Horselords

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('$1', 'LOC_$1_NAME', 'LOC_$1_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('',	'$1'),
('',	'$1');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_$1');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_$1', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('$1', 'TRAIT_$1');

-- section for agenda relationship
-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
-- ('TRAIT_$1', NULL);         -- dont like other hilly civs
/*
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

INSERT INTO AiListTypes(ListType) VALUES
('$2Yields'),
('$2Units'),
('$2Buildings'),
('$2Civics'),
('$2Techs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('$2Yields', 'TRAIT_$1', 'Yields'),
('$2Units', 'TRAIT_$1', 'UnitPromotionClasses'),
('$2Buildings', 'TRAIT_$1', 'Buildings'),
('$2Civics', 'TRAIT_$1', 'Civics'),
('$2Techs', 'TRAIT_$1', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('$2Yields', 'YIELD_CULTURE', '25'),                   -- not sure if want to bias culture
('$2Units', 'PROMOTION_CLASS_RECON', '1');
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('$2Buildings', '', '1'),
('$2Buildings', '', '1');


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('$2Civics', 'CIVIC_CORRUPTION_OF_SPIRIT', '1'),           -- religions
('$2Civics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '1'),
('$2Civics', 'CIVIC_DRAMA_POETRY', '1'),
('$2Civics', 'CIVIC_DRAMA_POETRY', '1'),
('$2Civics', 'CIVIC_WAY_OF_THE_WICKED', '1'),              -- for slavery
('$2Civics', 'TECH_CALENDAR', '1'),                        -- for carnivals
('$2Civics', 'TECH_HUNTING', '1'),                         -- recon line
('$2Civics', 'TECH_POISONS', '1');

-- Illians      Resurrectors of Fallen Winter

INSERT INTO LeaderTraits(LeaderType, TraitType) VALUES
('', 'TRAIT_LEADER_AGGRESSIVE_MILITARY'),
('', 'TRAIT_LEADER_AGGRESSIVE_MILITARY');

INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('$1', 'LOC_$1_NAME', 'LOC_$1_DESCRIPTION');

INSERT INTO HistoricalAgendas(LeaderType,	AgendaType) VALUES
('',	'$1'),
('',	'$1');

INSERT INTO Traits(TraitType)  VALUES
('TRAIT_$1');

INSERT INTO Types(Type, Kind) VALUES
('TRAIT_$1', 'KIND_TRAIT');

INSERT INTO AgendaTraits(AgendaType, TraitType) VALUES
('$1', 'TRAIT_$1');

-- section for agenda relationship
-- INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
-- ('TRAIT_$1', NULL);         -- dont like other hilly civs
/*
INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');
 */

INSERT INTO AiListTypes(ListType) VALUES
('$2Yields'),
('$2Units'),
('$2Buildings'),
('$2Civics'),
('$2Techs');
INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('$2Yields', 'TRAIT_$1', 'Yields'),
('$2Units', 'TRAIT_$1', 'UnitPromotionClasses'),
('$2Buildings', 'TRAIT_$1', 'Buildings'),
('$2Civics', 'TRAIT_$1', 'Civics'),
('$2Techs', 'TRAIT_$1', 'Technologies');

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('$2Yields', 'YIELD_CULTURE', '25'),                   -- not sure if want to bias culture
('$2Units', 'PROMOTION_CLASS_RECON', '1');
INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('$2Buildings', '', '1'),
('$2Buildings', '', '1');


INSERT INTO AiFavoredItems(ListType, Item, Favored) VALUES
('$2Civics', 'CIVIC_CORRUPTION_OF_SPIRIT', '1'),           -- religions
('$2Civics', 'CIVIC_MESSAGE_FROM_THE_DEEP', '1'),
('$2Civics', 'CIVIC_DRAMA_POETRY', '1'),
('$2Civics', 'CIVIC_DRAMA_POETRY', '1'),
('$2Civics', 'CIVIC_WAY_OF_THE_WICKED', '1'),              -- for slavery
('$2Civics', 'TECH_CALENDAR', '1'),                        -- for carnivals
('$2Civics', 'TECH_HUNTING', '1'),                         -- recon line
('$2Civics', 'TECH_POISONS', '1');

-- Infernal     Fallow

-- khazad attempt. Likes gold. Doesnt like people with lots of hills.
INSERT INTO Agendas(AgendaType, Name, Description) VALUES
('AGENDA_DWARVEN_GOLD', 'LOC_AGENDA_DWARVEN_GOLD_NAME', 'LOC_AGENDA_DWARVEN_GOLD_DESCRIPTION');
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
('DwarvenGoldSavings');

INSERT INTO AiLists(ListType, AgendaType, System) VALUES
('DwarvenGoldPseudoYields', 'TRAIT_AGENDA_DWARVEN_GOLD', 'PseudoYields'),
('DwarvenGoldYields', 'TRAIT_AGENDA_DWARVEN_GOLD', 'Yields'),
('DwarvenGoldSavings', 'TRAIT_AGENDA_DWARVEN_GOLD', 'SavingTypes');

UPDATE AiLists SET AgendaType = 'TRAIT_AGENDA_DWARVEN_GOLD' WHERE ListType='PreferHills' AND System='PlotEvaluations';          -- give ethiopia highlands stuff. But unsure if its just city centre.

INSERT INTO AiFavoredItems(ListType, Item, Value) VALUES
('DwarvenGoldPseudoYields', 'PSEUDOYIELD_UNIT_TRADE', '50'),            -- do we want em to trade? ehhhhh
('DwarvenGoldYields', 'YIELD_GOLD', '25'),
('SAVING_SLUSH_FUND', 'YIELD_GOLD', '7');                               -- vault gold

-- Strategies AiLists ('FavorCulturalVictory', FavorReligiousVictory, ForbidReligiousVictory, FavorScienceVictory);
-- AlexanderPreferWar?

--

-- Kuriotates       Sprawling

-- Lanun            Seafaring

-- Ljosalfar        Elven Forest Defenders

-- Luichuirp        Golem Crafters

-- Malakim          Desert Nomads

-- Mercurian        Angelic Warriors

-- Sheaim           Seekers of Armageddon

-- Sidar            Ghostly Spirits

-- Svartalfar       Elven Assassins


-- TRAIT_LEADER_AGGRESSIVE_MILITARY
-- <Row LeaderType="LEADER_MONTEZUMA" TraitType="TRAIT_LEADER_AGGRESSIVE_MILITARY"/>

-- <Row ListType="TrajanTechs" LeaderType="TRAJANS_COLUMN_TRAIT" System="Technologies"/>
--		<Row ListType="TomyrisiUnitBuilds" LeaderType="TRAIT_LEADER_KILLER_OF_CYRUS" System="UnitPromotionClasses"/>
-- 		<Row ListType="SaladinWonders" LeaderType="TRAIT_LEADER_RIGHTEOUSNESS_OF_FAITH" System="Buildings"/>
-- update DefaultYieldBias list pseudo yields to favor faith
-- update DefaultCitySettlement to deal with new settlement positions
/*
<Row ListType="GreatPersonObsessedGreatPeople" Item="PSEUDOYIELD_GPP_WRITER" Value="50"/>  -- grigori/cassiel
<Row ListType="LowReligiousPreferencePseudoYields" Item="PSEUDOYIELD_GPP_PROPHET" Value="-75"/>
		<Row ListType="LowReligiousPreferenceYields" Item="YIELD_FAITH" Value="-50"/>           -- inverse this, everyoneeee wants faith

<Row ListType="MoneyGrubberGoldPreference" Item="YIELD_GOLD" Value="20"/>

<Row ListType="PeacekeeperWarLimits" Item="DIPLOACTION_DECLARE_SURPRISE_WAR" Favored="false"/>
		<Row ListType="PeacekeeperWarLimits" Item="DIPLOACTION_DECLARE_FORMAL_WAR" Favored="false"/>
		<Row ListType="PeacekeeperWarLimits" Item="DIPLOACTION_DECLARE_WAR_MINOR_CIV" Favored="false"/>


<Row ListType="ScienceLoverSciencePreference" Item="YIELD_SCIENCE" Value="20"/>

<Row ListType="ExploitationLoverExploitationPreference" Item="PSEUDOYIELD_IMPROVEMENT" Value="5"/> eveyone

<Row ListType="WithShieldDiplomacy" Item="DIPLOACTION_MAKE_PEACE" Favored="false"/>

		<Row AgendaType="AGENDA_BARBARIAN_LOVER" Name="LOC_AGENDA_BARBARIAN_LOVER_NAME" Description="LOC_AGENDA_BARBARIAN_LOVER_DESCRIPTION"/>

<RandomAgendas>
		<Row AgendaType="AGENDA_AIRPOWER"/>
		<Row AgendaType="AGENDA_CITY_STATE_ALLY"/>
		<Row AgendaType="AGENDA_CITY_STATE_PROTECTOR"/>
<Row AgendaType="AGENDA_NUKE_LOVER" GameLimit="2"/>

<ExclusiveAgendas>
		<Row AgendaOne="AGENDA_DELIAN_LEAGUE" AgendaTwo="AGENDA_CITY_STATE_ALLY"/>
		<Row AgendaOne="AGENDA_QUEEN_OF_NILE" AgendaTwo="AGENDA_STANDING_ARMY"/>

<AiFavoredItems>
		<Row ListType="GreeceCivics" Item="CIVIC_DRAMA_POETRY" Favored="true"/>
		<Row ListType="GreeceYields" Item="YIELD_CULTURE" Value="20"/>
	</AiFavoredItems>

<AiFavoredItems>
		<Row ListType="TomyrisDiplomacy" Item="DIPLOACTION_DECLARE_SURPRISE_WAR" Favored="false"/>
		<Row ListType="GilgameshDiplomacy" Item="DIPLOACTION_DECLARE_FRIENDSHIP" Favored="true"/>

<Row ListType="GilgameshSciencePreference" Item="YIELD_SCIENCE" Value="10"/>
		<Row ListType="FavorCulturalVictory" Item="VICTORY_STRATEGY_CULTURAL_VICTORY" Value="-1"/>
		<Row ListType="FavorReligiousVictory" Item="VICTORY_STRATEGY_RELIGIOUS_VICTORY" Value="-1"/>
		<Row ListType="ForbidReligiousVictory" Item="VICTORY_STRATEGY_RELIGIOUS_VICTORY" Value="5"/>
		<Row ListType="FavorScienceVictory" Item="VICTORY_STRATEGY_SCIENCE_VICTORY" Value="-1"/>

<Row ListType="MinorCivScienceDistrict" Item="DISTRICT_CAMPUS" Favored="true"/>
		<Row ListType="CavalryLoverCitySettlement" Item="Specific Resource" Favored="true" Value="12" StringVal="RESOURCE_HORSES"/>

<AiFavoredItems>
		<Row ListType="BaseListTest" Item="CIVIC_IMPERIALISM"/>
		<Row ListType="BarbarossaWonders" Item="BUILDING_RUHR_VALLEY" Favored="true"/>
		<Row ListType="PericlesEnvoys" Item="PSEUDOYIELD_INFLUENCE" Value="30"/>
<Row ListType="BarbarossaCivics" Item="CIVIC_CRAFTSMANSHIP" Favored="true"/>
		<Row ListType="BarbarossaCivics" Item="CIVIC_FOREIGN_TRADE" Favored="true"/>

<Row ListType="GandhiUnitBuilds" Item="PROMOTION_CLASS_INQUISITOR" Value="-1"/>
		<Row ListType="TomyrisiUnitBuilds" Item="PROMOTION_CLASS_LIGHT_CAVALRY" Value="1"/>

<Row ListType="CavalryLoverCitySettlement" Item="Specific Resource" Favored="true" Value="12" StringVal="RESOURCE_HORSES"/>

<Row ListType="DefaultSavings" Item="SAVING_SLUSH_FUND" Value="3"/>  For khazad

<Row ListType="AggressivePseudoYields" Item="PSEUDOYIELD_UNIT_COMBAT" Value="25"/>
		<Row ListType="AggressivePseudoYields" Item="PSEUDOYIELD_UNIT_NAVAL_COMBAT" Value="25"/>
		<Row ListType="AggressivePseudoYields" Item="PSEUDOYIELD_UNIT_AIR_COMBAT" Value="25"/>

kill eureka boosts logic?

    <Row ListType="BaseOperationsLimits" Item="NAVAL_SUPERIORITY" Value="1" /> <!-- OG COMMENT Don't use this early game, it must be increased by a strategy to be used -->
-- is this why they love ships

<Row ListType="NavalPreferredTechs" Item="TECH_SAILING" Favored="true"/>
		<Row ListType="NavalPreferredTechs" Item="TECH_CELESTIAL_NAVIGATION" Favored="true"/>
		<Row ListType="NavalPreferredTechs" Item="TECH_SHIPBUILDING" Favored="true"/>
		<Row ListType="NavalPreferredTechs" Item="TECH_CARTOGRAPHY" Favored="true"/>

-- victories
<Row ListType="ScienceVictoryDistricts" Item="DISTRICT_SPACEPORT" Favored="true"/>
		<Row ListType="ScienceVictoryProjects" Item="PROJECT_LAUNCH_EARTH_SATELLITE" Favored="true"/>
		<Row ListType="ScienceVictoryProjects" Item="PROJECT_LAUNCH_MOON_LANDING" Favored="true"/>
		<Row ListType="ScienceVictoryProjects" Item="PROJECT_LAUNCH_MARS_REACTOR" Favored="true"/>
		<Row ListType="ScienceVictoryProjects" Item="PROJECT_LAUNCH_MARS_HABITATION" Favored="true"/>
		<Row ListType="ScienceVictoryProjects" Item="PROJECT_LAUNCH_MARS_HYDROPONICS" Favored="true"/>
		<Row ListType="ScienceVictoryPseudoYields" Item="PSEUDOYIELD_SPACE_RACE" Value="100"/>
		<Row ListType="ScienceVictoryPseudoYields" Item="PSEUDOYIELD_TECHNOLOGY" Value="25"/>
		<Row ListType="ScienceVictoryPseudoYields" Item="PSEUDOYIELD_GPP_SCIENTIST" Value="25"/>
		<Row ListType="ScienceVictoryTechs" Item="TECH_ROCKETRY" Favored="true"/>
		<Row ListType="ScienceVictoryTechs" Item="TECH_SATELLITES" Favored="true"/>
		<Row ListType="ScienceVictoryTechs" Item="TECH_ROBOTICS" Favored="true"/>
		<Row ListType="ScienceVictoryTechs" Item="TECH_NUCLEAR_FUSION" Favored="true"/>
		<Row ListType="ScienceVictoryTechs" Item="TECH_NANOTECHNOLOGY" Favored="true"/>
		<Row ListType="ScienceVictoryYields" Item="YIELD_SCIENCE" Value="50"/>

-- Civ specific
-- Amurite: War favored. Mana favored. Mage Guild/Adept favored(likely wont work tho), maybe put mages as support in AI


-- Elohim: Peace favored. Religion favored? No clue honestly
-- Grigori: Peace favored. No Religion favored. Econ favored/National Unit favored.

 */