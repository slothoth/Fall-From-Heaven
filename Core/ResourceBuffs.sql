-- Mithril, Iron, Copper bonuses to units when we do it. Also Nightmare, and Sheut stone

-- Sheut stone: If city has access (to implement) 1 death damage, +25% Death resistance and a -10% weakness to holy damage

-- Nightmare: If city has access to Nightmare when building a unit, +1 Unholy combat

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH', 'LOC_SLTH_NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH_NAME', 'LOC_NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH', 'MODIFIER_DEMON_ABILITY_HELL_TERRAIN_STRENGTH'),            -- borrowed from Demon Race
('NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH', 'MODIFIER_NIGHTMARE_STRENGTH');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, OwnerRequirementSetId) VALUES
('TRAIT_GRANT_NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', 'PLAYER_HAS_NIGHTMARES'),
('MODIFIER_NIGHTMARE_STRENGTH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('TRAIT_GRANT_NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH', 'AbilityType', 'ARGTYPE_IDENTITY', 'NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH'),
('MODIFIER_NIGHTMARE_STRENGTH', 'Amount', 'ARGTYPE_IDENTITY', '1');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_NIGHTMARE_STRENGTH', 'Preview', 'LOC_PROMOTION_NIGHTMARE_DESCRIPTION');

INSERT INTO TypeTags(Type, Tag) VALUES
('NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH', 'CLASS_LIGHT_CAVALRY');

INSERT INTO Types(Type, Kind) VALUES
('NIGHTMARE_ABILITY_HELL_TERRAIN_STRENGTH', 'KIND_ABILITY');

-- this is the weak version that doesnt take into account imports. Maybe we'll fix with lua later.
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('PLAYER_HAS_NIGHTMARES', 'REQUIRES_PLAYER_HAS_NIGHTMARES');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('PLAYER_HAS_NIGHTMARES', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO Requirements(RequirementId, RequirementType, ProgressWeight) VALUES
('REQUIRES_PLAYER_HAS_NIGHTMARES', 'REQUIREMENT_PLAYER_HAS_RESOURCE_OWNED', '1');

INSERT INTO RequirementArguments(RequirementId, Name, Type, Value) VALUES
('REQUIRES_PLAYER_HAS_NIGHTMARES', 'ResourceType', 'ARGTYPE_IDENTITY', 'RESOURCE_HORSES');
