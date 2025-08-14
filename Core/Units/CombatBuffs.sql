-- sheaim pyre zombie aoe damage on death
/*
INSERT INTO GameModifiers(ModifierId) VALUES
('PYRE_ZOMBIE_EXPLOSION_ON_DEATH');

INSERT INTO DynamicModifiers(ModifierType, CollectionType, EffectType) VALUES
('SLTH_ALL_COMBAT_RESULTS_APPLY_MODIFIER_TO_ADJACENT_UNITS', 'COLLECTION_COMBAT_RESULTS', 'EFFECT_ATTACH_PERMANENT_MODIFIER_TO_ADJACENT_PLOT_UNITS');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_ALL_COMBAT_RESULTS_APPLY_MODIFIER_TO_ADJACENT_UNITS', 'KIND_MODIFIER');

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('PYRE_ZOMBIE_EXPLOSION_ON_DEATH', 'SLTH_ALL_COMBAT_RESULTS_APPLY_MODIFIER_TO_ADJACENT_UNIT', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('PYRE_ZOMBIE_EXPLOSION_ON_DEATH', 'ModifierId', 'MODIFIER_PYRE_ZOMBIE_DAMAGE');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('MODIFIER_PYRE_ZOMBIE_DAMAGE', 'MODIFIER_PLAYER_UNIT_ADJUST_DAMAGE');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('MODIFIER_PYRE_ZOMBIE_DAMAGE', 'Amount', '50');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('SLTH_COMBAT_RESULT_CAUSED_DEATH', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('SLTH_COMBAT_RESULT_CAUSED_DEATH', 'SLTH_REQUIRES_COMBAT_UNIT_DEATH');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('SLTH_REQUIRES_COMBAT_UNIT_DEATH', 'REQUIREMENT_COMBAT_RESULTS_UNIT_DIED');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('SLTH_REQUIRES_COMBAT_UNIT_DEATH', 'ExcludeBarbs', '0');

-- later do check that unit is not immune to fire?

-- is COMBAT_RESULTS different than COLLECTION_PLAYER_COMBAT, if so, can set it just to sheaim.
-- just doesnt work lol

UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE SubjectRequirementSetId ='THIS_COMBAT_RESULTS_IN_UNIT_DEATH';
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE SubjectRequirementSetId ='THIS_UNIT_IS_A_VAMPIRE';


 */
    -- WOULD WORK PERFECTLY, EXCEPT THHERE IS NO WAY TO CHECK A UNITS HEALTH, MY GOD. SO IT CRASHES THE GAME GOING BELOW 0 HEALTH
/*
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId, Permanent, RunOnce) VALUES
('MODIFIER_PYRE_ZOMBIE_DAMAGE', 'MODIFIER_PLAYER_UNIT_ADJUST_DAMAGE', 'UNIT_HAS_MORE_THAN_30_HEALTH_REQS', 0, 0);

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('MODIFIER_PYRE_ZOMBIE_DAMAGE', 'Amount', '30');

INSERT INTO Requirements(RequirementId, RequirementType, Inverse) VALUES
('REQUIREMENT_UNIT_HAS_MORE_THAN_30_HEALTH', 'REQUIREMENT_UNIT_DAMAGE_MINIMUM', '0');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('REQUIREMENT_UNIT_HAS_MORE_THAN_30_HEALTH', 'MinimumAmount', '10');

INSERT OR IGNORE  INTO RequirementSets(RequirementSetId,	RequirementSetType)
VALUES	('UNIT_HAS_MORE_THAN_30_HEALTH_REQS',	'REQUIREMENTSET_TEST_ANY');

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
VALUES	('UNIT_HAS_MORE_THAN_30_HEALTH_REQS',			'REQUIREMENT_UNIT_HAS_MORE_THAN_30_HEALTH');

 */
-- WORKS! BUt only on attack, if you attack her, it doesnt spread as its only her plot? that makse no sense now I think about it. Good news is, doesnt spread on ranged attacks
-- just need to assign typetags to plagued so it only works on living targets.
-- This should also work for Withered Touch
-- This would not be possible to do for Disease, as tag level means no dynamic checks. Could try putting it on
-- a local COMBAT_RESULTS, BUt theres no such collection?
-- COULD THIS do the accursed Doviello prod from combat? Did i make that whole thing up and it was a modmod?
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId, Permanent, RunOnce) VALUES
('MODIFIER_PLAGUE_CARRIER_GRANT', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY', NULL, 1, 1);

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('MODIFIER_PLAGUE_CARRIER_GRANT', 'AbilityType', 'PLAGUED');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('REQUIREMENT_MARY_ATTACKING', 'REQUIREMENT_COMBAT_RESULTS_ATTACKING_UNIT_HAS_TAG'),
('REQUIREMENT_MARY_DEFENDING', 'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('REQUIREMENT_MARY_ATTACKING', 'Tag', 'PLAGUE_CARRIER_CLASS'),
('REQUIREMENT_MARY_DEFENDING', 'Tag', 'PLAGUE_CARRIER_CLASS');

INSERT OR IGNORE  INTO RequirementSets(RequirementSetId,	RequirementSetType)
VALUES	('MARY_INVOLVED_IN_COMBAT_REQS',	'REQUIREMENTSET_TEST_ANY');

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
VALUES	('MARY_INVOLVED_IN_COMBAT_REQS',			'REQUIREMENT_MARY_ATTACKING'),
        ('MARY_INVOLVED_IN_COMBAT_REQS',			'REQUIREMENT_MARY_DEFENDING');

INSERT OR IGNORE  INTO Types
		(Type,																		Kind)
VALUES	('MODIFIER_ALL_COMBAT_RESULTS_APPLY_MODIFIER_TO_UNITS_ON_TILE',				'KIND_MODIFIER');


INSERT OR IGNORE  INTO DynamicModifiers
		(ModifierType,																CollectionType,						EffectType)
VALUES	('MODIFIER_ALL_COMBAT_RESULTS_APPLY_MODIFIER_TO_UNITS_ON_TILE',				'COLLECTION_COMBAT_RESULTS',		'EFFECT_ATTACH_PERMANENT_MODIFIER_TO_PLOT_UNITS');

INSERT INTO GameModifiers(ModifierId) VALUES ('DEBUFF_ON_MARY_COMBAT');

INSERT INTO Modifiers(ModifierId,					ModifierType,													SubjectRequirementSetId,	    RunOnce,	Permanent)
VALUES	('DEBUFF_ON_MARY_COMBAT',					'MODIFIER_ALL_COMBAT_RESULTS_APPLY_MODIFIER_TO_UNITS_ON_TILE',	'MARY_INVOLVED_IN_COMBAT_REQS',	0,			0);

INSERT INTO ModifierArguments(ModifierId,						Name,				Value)
VALUES	                     ('DEBUFF_ON_MARY_COMBAT',			'ModifierId',		'MODIFIER_PLAGUE_CARRIER_GRANT');
