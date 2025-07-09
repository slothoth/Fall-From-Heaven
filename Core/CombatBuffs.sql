-- sheaim pyre zombie aoe damage on death

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
