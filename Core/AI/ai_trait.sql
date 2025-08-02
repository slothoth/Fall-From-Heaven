-- do each Trait biases: Like Arcane bias for Mage Guild, Industrious for Wonders
-- 'SLTH_TRAIT_AGGRESSIVE'
-- 'SLTH_TRAIT_ARCANE'
-- 'SLTH_TRAIT_CHARISMATIC'
-- 'SLTH_TRAIT_CREATIVE'
-- 'SLTH_TRAIT_DEFENDER'
-- 'SLTH_TRAIT_EXPANSIVE'
-- 'SLTH_TRAIT_FINANCIAL'
-- 'SLTH_TRAIT_INDUSTRIOUS'
-- 'SLTH_TRAIT_INGENUITY'
-- 'SLTH_TRAIT_ORGANIZED'
-- 'SLTH_TRAIT_PHILOSOPHICAL'
-- 'SLTH_TRAIT_SPIRITUAL'
-- 'SLTH_TRAIT_SUMMONER'
-- 'SLTH_TRAIT_RAIDERS'
-- 'SLTH_TRAIT_BARBARIAN'

/*
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
-- INSERT INTO ExclusiveAgendas(AgendaOne, AgendaTwo) VALUES
-- ('AGENDA_DWARVEN_GOLD', 'AGENDA_MONEY_GRUBBER');

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

 */