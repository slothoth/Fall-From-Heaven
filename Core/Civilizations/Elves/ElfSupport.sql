INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_ELVEN', 'LOC_SLTH_TRAIT_ELVEN_NAME', 'LOC_SLTH_TRAIT_ELVEN_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_ELVEN', 'MODIFIER_GRANT_TECH_SKIP_'),
('SLTH_TRAIT_ELVEN', 'TRAIT_GRANT_ELF_ABILITY_FEATUREATTACKS_CITY_ATTACH'),
('SLTH_TRAIT_ELVEN', 'TRAIT_GRANT_ELF_ABILITY_FEATUREDOUBLEMOVES_CITY_ATTACH'),
('SLTH_TRAIT_ELVEN', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS'),
('SLTH_TRAIT_ELVEN', 'MODIFIER_BAN_SLTH_UNIT_BERSERKER'),
('SLTH_TRAIT_ELVEN', 'MODIFIER_BAN_SLTH_UNIT_CANNON'),
('SLTH_TRAIT_ELVEN', 'MODIFIER_BAN_SLTH_UNIT_CATAPULT'),
('SLTH_TRAIT_ELVEN', 'MODIFIER_BAN_SLTH_UNIT_CHARIOT');

INSERT INTO Technologies(TechnologyType, Name, Cost, EmbarkUnitType, EmbarkAll, Description, EraType, UITreeRow, AdvisorType) VALUES
('TECH_SKIP_', 'LOC_TECH_SKIP_NAME', '9000', NULL, '0', 'LOC_TECH_SKIP_DESCRIPTION', 'ERA_ANCIENT', '0', 'ADVISOR_GENERIC');

INSERT INTO TechnologyPrereqs(Technology, PrereqTech) VALUES
('TECH_SKIP_', 'TECH_FUTURE_TECH');

INSERT INTO Improvement_ValidFeatures(PrereqTech, ImprovementType, FeatureType) VALUES
('TECH_SKIP_', 'IMPROVEMENT_COTTAGE', 'FEATURE_FOREST'),
('TECH_SKIP_', 'IMPROVEMENT_COTTAGE', 'FEATURE_FOREST_ANCIENT'),
('TECH_SKIP_', 'IMPROVEMENT_FARM', 'FEATURE_FOREST'),
('TECH_SKIP_', 'IMPROVEMENT_FARM', 'FEATURE_FOREST_ANCIENT'),
('TECH_SKIP_', 'IMPROVEMENT_MINE', 'FEATURE_FOREST'),
('TECH_SKIP_', 'IMPROVEMENT_MINE', 'FEATURE_FOREST_ANCIENT'),
('TECH_SKIP_', 'IMPROVEMENT_WINDMILL', 'FEATURE_FOREST'),
('TECH_SKIP_', 'IMPROVEMENT_WINDMILL', 'FEATURE_FOREST_ANCIENT'),
('TECH_SKIP_', 'IMPROVEMENT_WORKSHOP', 'FEATURE_FOREST'),
('TECH_SKIP_', 'IMPROVEMENT_WORKSHOP', 'FEATURE_FOREST_ANCIENT');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_GRANT_TECH_SKIP_', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', '1', '1', NULL),
('TRAIT_GRANT_ELF_ABILITY_FEATUREDOUBLEMOVES_CITY_ATTACH', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 0, 0, NULL),
('GRANT_ELF_ABILITY_FEATUREDOUBLEMOVES_CITY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', NULL),
('TRAIT_GRANT_ELF_ABILITY_FEATUREATTACKS_CITY_ATTACH', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 0, 0, NULL),
('GRANT_ELF_ABILITY_FEATUREATTACKS_CITY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_GRANT_TECH_SKIP_', 'TechType', 'ARGTYPE_IDENTITY', 'TECH_SKIP_'),
('TRAIT_GRANT_ELF_ABILITY_FEATUREDOUBLEMOVES_CITY_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'GRANT_ELF_ABILITY_FEATUREDOUBLEMOVES_CITY'),
('GRANT_ELF_ABILITY_FEATUREDOUBLEMOVES_CITY', 'AbilityType', 'ARGTYPE_IDENTITY', 'ELF_ABILITY_FEATUREDOUBLEMOVES'),
('TRAIT_GRANT_ELF_ABILITY_FEATUREATTACKS_CITY_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'GRANT_ELF_ABILITY_FEATUREATTACKS_CITY'),
('GRANT_ELF_ABILITY_FEATUREATTACKS_CITY', 'AbilityType', 'ARGTYPE_IDENTITY', 'ELF_ABILITY_FEATUREATTACKS');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_TRAIT_ELVEN', 'KIND_TRAIT'),
('TECH_SKIP_', 'KIND_TECH');
