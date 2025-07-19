UPDATE GlobalParameters SET Value = '1' WHERE Name = 'FORTIFY_BONUS_PER_TURN';
UPDATE GlobalParameters SET Value = '5' WHERE Name = 'FORTIFY_TURN_MAX';
UPDATE GlobalParameters SET Value = '30' WHERE Name = 'EXPERIENCE_MAX_LEVEL';
UPDATE GlobalParameters SET Value = '99' WHERE Name = 'INFLUENCE_TOKENS_MINIMUM_FOR_SUZERAIN';
UPDATE GlobalParameters SET Value = '1000' WHERE Name = 'RELIGION_PANTHEON_MIN_FAITH';

UPDATE GlobalParameters SET Value = '99' WHERE Name = 'EXPERIENCE_MAXIMUM_ONE_COMBAT';

INSERT INTO DynamicModifiers(ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_ALL_UNITS_PROMOTE_NO_FINISH_MOVES', 'COLLECTION_ALL_UNITS', 'EFFECT_ADJUST_UNIT_PROMOTE_NO_FINISH_MOVES');

INSERT INTO Types(Type, Kind) VALUES
('MODIFIER_ALL_UNITS_PROMOTE_NO_FINISH_MOVES', 'KIND_MODIFIER');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('GLOBAL_PROMOTION_DOESNT_END_TURN', 'MODIFIER_ALL_UNITS_PROMOTE_NO_FINISH_MOVES');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES ('GLOBAL_PROMOTION_DOESNT_END_TURN', 'NoFinishMoves', '1');

INSERT INTO GameModifiers(ModifierId) VALUES
('GLOBAL_PROMOTION_DOESNT_END_TURN');


-- UPDATE GlobalParameters SET Value = '0' WHERE Name = 'UPGRADE_BASE_COST';
-- UPDATE GlobalParameters SET Value = '0' WHERE Name = 'UPGRADE_MINIMUM_COST';

DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_WORLD_CONGRESS';
DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_TOP_PANEL_ENVOYS';
DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_CITY_STATES_VIEW';
DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_DISPLAY_SCORE';
DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_ERAS';
DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_GOLDEN_AND_DARK_AGES';
DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_HISTORIC_MOMENTS';
DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_EMERGENCIES';

-- UPDATE GlobalParameters SET Value = '1' WHERE Name = 'GOVERNMENT_ALLOW_EMPTY_POLICY_SLOTS'; -- could be good

-- UPDATE GlobalParameters SET Value = '5' WHERE Name = 'PLOT_UNIT_LIMIT';      - i dont want this but? does it worK?

INSERT INTO GameModifiers(ModifierId) VALUES
('SLTH_RIVER_GOLD');

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('SLTH_RIVER_GOLD', 'MODIFIER_GAME_ADJUST_PLOT_YIELD', 'RIVER_ADJACENT_AND_NOT_FORESTED_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('SLTH_RIVER_GOLD', 'YieldType', 'YIELD_GOLD'),
('SLTH_RIVER_GOLD', 'Amount', '1');

INSERT INTO Requirements(RequirementId, RequirementType, Inverse) VALUES
('SUBREQSET_HAS_NOT_FOREST_OR_JUNGLE_REQS', 'REQUIREMENT_REQUIREMENTSET_IS_MET', '1');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('SUBREQSET_HAS_NOT_FOREST_OR_JUNGLE_REQS', 'RequirementSetId', 'SUBREQSET_HAS_NOT_FOREST_OR_JUNGLE_REQS');

INSERT OR IGNORE  INTO RequirementSets(RequirementSetId,	RequirementSetType)
VALUES	('RIVER_ADJACENT_AND_NOT_FORESTED_REQS',	'REQUIREMENTSET_TEST_ALL'),
        ('SUBREQSET_HAS_NOT_FOREST_OR_JUNGLE_REQS',	'REQUIREMENTSET_TEST_ANY');

INSERT INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
VALUES	('RIVER_ADJACENT_AND_NOT_FORESTED_REQS',		'SUBREQSET_HAS_NOT_FOREST_OR_JUNGLE_REQS'),
        ('RIVER_ADJACENT_AND_NOT_FORESTED_REQS',		'REQUIRES_PLOT_ADJACENT_TO_RIVER'),
        ('SUBREQSET_HAS_NOT_FOREST_OR_JUNGLE_REQS',     'PLOT_IS_FOREST_REQUIREMENT'),
        ('SUBREQSET_HAS_NOT_FOREST_OR_JUNGLE_REQS',     'REQUIRES_PLOT_HAS_JUNGLE');

-- slider setup basic



/*
-- Civ only has a Faith yield into other yields. So to do sliders we would need to convert all yield gold stuff to faith.
-- furthermore, while this would let us control the science and culture gotten from gold(faith), there is no way
-- to reduce the faith values at a player level. Which sucks. We tried using the Yields per great person. It fails to go
-- below 0
-- this works for cities, but theres no player level way to multiply to reduce faith(gold)
DELETE FROM GlobalParameters WHERE Name ='YIELD_MODIFIER_PER_EARNED_GREAT_PERSON_MAXIMUM';

INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
('BUILDING_PALACE', 'GOLD_INTO_CULTURE'),
('BUILDING_PALACE', 'GOLD_INTO_SCIENCE');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'GOLD_INTO_NOT_GOLD'),
('TRAIT_LEADER_MAJOR_CIV', 'GOLD_INTO_NOT_GOLD_TWO');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('GOLD_INTO_CULTURE', 'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_MODIFIER_FROM_FAITH'),
('GOLD_INTO_SCIENCE', 'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_MODIFIER_FROM_FAITH'),
('GOLD_INTO_NOT_GOLD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER'),
('GOLD_INTO_NOT_GOLD_TWO', 'MODIFIER_PLAYER_ADJUST_YIELD_MODIFIER_PER_EARNED_GREAT_PERSON');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('GOLD_INTO_CULTURE', 'YieldType', 'YIELD_CULTURE'),
('GOLD_INTO_CULTURE', 'Amount', '30'),
('GOLD_INTO_SCIENCE', 'YieldType', 'YIELD_SCIENCE'),
('GOLD_INTO_SCIENCE', 'Amount', '30'),
('GOLD_INTO_NOT_GOLD', 'YieldType', 'YIELD_FAITH'),
('GOLD_INTO_NOT_GOLD', 'Amount', '-60'),
('GOLD_INTO_NOT_GOLD_TWO', 'YieldType', 'YIELD_FAITH'),
('GOLD_INTO_NOT_GOLD_TWO', 'Amount', '-30');


-- sadly this sejong/moon project modifier just fails outside of a runonce context. Rtried Repeatable, no such luck
INSERT INTO Modifiers(ModifierId, ModifierType, Repeatable, SubjectRequirementSetId) VALUES
('GOLD_INTO_CULTURE', 'MODIFIER_PLAYER_GRANT_YIELD_BASED_ON_CURRENT_YIELD_RATE', '1',  NULL),
('GOLD_INTO_SCIENCE', 'MODIFIER_PLAYER_GRANT_YIELD_BASED_ON_CURRENT_YIELD_RATE', '1', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('GOLD_INTO_CULTURE', 'YieldToBaseOn', 'YIELD_GOLD'),
('GOLD_INTO_CULTURE', 'YieldToGrant', 'YIELD_CULTURE'),
('GOLD_INTO_CULTURE', 'Multiplier', '30'),
('GOLD_INTO_SCIENCE', 'YieldToBaseOn', 'YIELD_GOLD'),
('GOLD_INTO_SCIENCE', 'YieldType', 'YIELD_SCIENCE'),
('GOLD_INTO_SCIENCE', 'Multiplier', '30');


INSERT INTO DynamicModifiers(ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_GRANT_YIELD_BASED_ON_CURRENT_YIELD_RATE_CITIES', 'COLLECTION_PLAYER_CITIES', 'EFFECT_GRANT_YIELD_BASED_ON_CURRENT_YIELD_RATE');

INSERT INTO Types(Type, Kind) VALUES
('MODIFIER_GRANT_YIELD_BASED_ON_CURRENT_YIELD_RATE_CITIES', 'KIND_MODIFIER');

 */