INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_SVARTALFAR', 'LOC_CIV_SVARTALFAR_NAME', 'LOC_CIV_SVARTALFAR_DESCRIPTION', 'LOC_SLTH_CIV_SVARTALFAR_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('LEADER_FAERYL', 'LOC_LEADER_FAERYL_NAME', 'LEADER_DEFAULT');

INSERT INTO	StartBiasTerrains (CivilizationType,			TerrainType,			        Tier	)
VALUES	                      ('SLTH_CIVILIZATION_SVARTALFAR',	'TERRAIN_GRASS',		    3	),
                              ('SLTH_CIVILIZATION_SVARTALFAR',	'TERRAIN_GRASS_HILLS',		3	),
                              ('SLTH_CIVILIZATION_SVARTALFAR',	'TERRAIN_PLAINS',		    3	),
                              ('SLTH_CIVILIZATION_SVARTALFAR',	'TERRAIN_PLAINS_HILLS',		3	);

INSERT INTO	StartBiasFeatures (CivilizationType,			    FeatureType,			Tier	)
VALUES	                      ('SLTH_CIVILIZATION_SVARTALFAR',	'FEATURE_FOREST',	        5	),
                              ('SLTH_CIVILIZATION_SVARTALFAR',	'FEATURE_FOREST_ANCIENT',	5	);

INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('LEADER_FAERYL', 'SLTH_CIVILIZATION_SVARTALFAR', 'LOC_CITY_SVARTALFAR_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_SVARTALFAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_ALAZKAN'),
('SLTH_CIVILIZATION_SVARTALFAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_NYXKIN'),
('SLTH_CIVILIZATION_SVARTALFAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_ILLUSIONIST'),
('SLTH_CIVILIZATION_SVARTALFAR', 'SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('NULL_CIVILIZATION_SVARTALFAR', 'LOC_SLTH_NULL_CIVILIZATION_SVARTALFAR_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ALAZKAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ALAZKAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ALAZKAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ILLUSIONIST', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ILLUSIONIST_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ILLUSIONIST_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_NYXKIN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_NYXKIN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_NYXKIN_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'TRAIT_SLTH_ABILITY_SINISTER'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_SLTH_GRANT_TECH_AGRICULTURE'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_SHADOW'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_SLTH_SMALL_ADJUST_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_NATURE'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_MIND'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_GRANT_TECH_SKIP_'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'TRAIT_GRANT_ELF_ABILITY_FEATUREATTACKS_CITY_ATTACH'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'TRAIT_GRANT_ELF_ABILITY_FEATUREDOUBLEMOVES_CITY_ATTACH'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_BAN_SLTH_UNIT_BERSERKER'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_BAN_SLTH_UNIT_CANNON'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_BAN_SLTH_UNIT_CATAPULT'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'MODIFIER_BAN_SLTH_UNIT_CHARIOT');
-- NOT IMPLEMENTED: Great people theft.
INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_SLTH_ABILITY_SINISTER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('TRAIT_SLTH_ABILITY_SINISTER', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', '0', '0', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_SLTH_ABILITY_SINISTER', 'Amount', 'ARGTYPE_IDENTITY', '5'),
('TRAIT_SLTH_ABILITY_SINISTER', 'AbilityType', 'ARGTYPE_IDENTITY', 'SLTH_ABILITY_SINISTER');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('SLTH_ABILITY_SINISTER', 'LOC_SLTH_SLTH_ABILITY_SINISTER_NAME', 'LOC_SLTH_ABILITY_SINISTER_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('SLTH_ABILITY_SINISTER', 'MODIFIER_SLTH_ABILITY_SINISTER');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_SVARTALFAR_ALCHEMY_LAB', 'BUILDING_RESEARCH_LAB'),
('SLTH_BUILDING_NULL_CIVILIZATION_SVARTALFAR_SIEGE_WORKSHOP', 'SLTH_BUILDING_SIEGE_WORKSHOP');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_SVARTALFAR_ALCHEMY_LAB', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_SVARTALFAR', NULL, 'ADVISOR_RELIGIOUS'),
('SLTH_BUILDING_NULL_CIVILIZATION_SVARTALFAR_SIEGE_WORKSHOP', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_SVARTALFAR', NULL, 'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_ALAZKAN', 'LOC_SLTH_UNIT_ALAZKAN_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_ALAZKAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ALAZKAN', '1', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_NYXKIN', 'LOC_SLTH_UNIT_NYXKIN_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_NYXKIN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_NYXKIN', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_ILLUSIONIST', 'LOC_SLTH_UNIT_ILLUSIONIST_NAME', '2', '1', '19', '24', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '1', 'LOC_SLTH_UNIT_ILLUSIONIST_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ILLUSIONIST', '1', 'PROMOTION_CLASS_ADEPT', 'TECH_SORCERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_TECHNOLOGY', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_NYXKIN', 'SLTH_UNIT_HORSE_ARCHER'),
('SLTH_UNIT_ILLUSIONIST', 'SLTH_UNIT_MAGE');

INSERT INTO Improvement_ValidBuildUnits(UnitType, ImprovementType, ConsumesCharge) VALUES
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_AIR', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_BODY', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_CHAOS', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_DEATH', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_EARTH', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_ENCHANTMENT', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_ENTROPY', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_FIRE', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_LAW', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_LIFE', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_METAMAGIC', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_MIND', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_NATURE', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_SPIRIT', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_WATER', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_SHADOW', '0'),
('SLTH_UNIT_ILLUSIONIST', 'IMPROVEMENT_MANA_SUN', '0');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_ABILITY_SINISTER', 'CLASS_RECON'),
('SLTH_UNIT_ALAZKAN', 'CLASS_RECON'),
('SLTH_UNIT_NYXKIN', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_ILLUSIONIST', 'CLASS_ADEPT'),
('SLTH_UNIT_ALAZKAN', 'RACE_ELVEN'),
('SLTH_UNIT_NYXKIN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_ILLUSIONIST', 'CAN_BE_RACIALIZED');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_SVARTALFAR', 'KIND_CIVILIZATION'),
('LEADER_FAERYL', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_SVARTALFAR_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_SVARTALFAR', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ALAZKAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ILLUSIONIST', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_NYXKIN', 'KIND_TRAIT'),
('SLTH_UNIT_ALAZKAN', 'KIND_UNIT'),
('SLTH_UNIT_NYXKIN', 'KIND_UNIT'),
('SLTH_UNIT_ILLUSIONIST', 'KIND_UNIT'),
('SLTH_BUILDING_NULL_CIVILIZATION_SVARTALFAR_ALCHEMY_LAB', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_SVARTALFAR_SIEGE_WORKSHOP', 'KIND_BUILDING'),
('SLTH_ABILITY_SINISTER', 'KIND_ABILITY');