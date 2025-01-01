INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_CALABIM', 'LOC_CIV_CALABIM_NAME', 'LOC_CIV_CALABIM_DESCRIPTION', 'LOC_SLTH_CIV_CALABIM_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('LEADER_ALEXIS', 'LOC_LEADER_ALEXIS_NAME', 'LEADER_DEFAULT'),
('LEADER_FLAUROS', 'LOC_LEADER_FLAUROS_NAME', 'LEADER_DEFAULT'),
('LEADER_DECIUS_CALABIM', 'LOC_LEADER_DECIUS_NAME', 'LEADER_DEFAULT');

INSERT INTO	StartBiasTerrains
		(CivilizationType,			TerrainType,			Tier	)
VALUES	('SLTH_CIVILIZATION_CALABIM',	'TERRAIN_GRASS',		5	);

INSERT INTO	StartBiasRivers(CivilizationType,	        Tier)
VALUES	                   ('SLTH_CIVILIZATION_CALABIM',	5);


INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('LEADER_ALEXIS', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME'),
('LEADER_FLAUROS', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME'),
('LEADER_DECIUS_CALABIM', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME');

INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_CALABIM_COOL'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_MOROI'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_CALABIM_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_CALABIM_COOL_DESCRIPTION'),
('NULL_CIVILIZATION_CALABIM', 'LOC_SLTH_NULL_CIVILIZATION_CALABIM_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MOROI_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MOROI_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_GRANT_TECH_EXPLORATION'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_BAN_SLTH_UNIT_CANNON'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_BODY'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_SMALL_ADJUST_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_LAW'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_SHADOW');

INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('BUILDING_ORDU', 'LOC_BUILDING_ORDU_NAME', NULL, NULL, '120', 'DISTRICT_CITY_CENTER', 'LOC_BUILDING_ORDU_DESCRIPTION', '0', '-1', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT', NULL, 'ADVISOR_GENERIC'),
('SLTH_BUILDING_GOVERNORS_MANOR', 'LOC_SLTH_BUILDING_GOVERNORS_MANOR_NAME', NULL, 'CIVIC_CODE_OF_LAWS', '180', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_GOVERNORS_MANOR_DESCRIPTION', '0', '0', '-1', 'SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR', NULL, 'ADVISOR_GENERIC');


INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_GOVERNORS_MANOR', 'BUILDING_QUEENS_BIBLIOTHEQUE'),
('SLTH_BUILDING_NULL_CIVILIZATION_CALABIM_ALCHEMY_LAB', 'BUILDING_RESEARCH_LAB'),
('SLTH_BUILDING_NULL_CIVILIZATION_CALABIM_ELDER_COUNCIL', 'SLTH_BUILDING_ELDER_COUNCIL'),
('SLTH_BUILDING_NULL_CIVILIZATION_SHEAIM_TRAINING_YARD', 'BUILDING_BARRACKS');

INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
('SLTH_BUILDING_GOVERNORS_MANOR', 'MODIFIER_SLTH_BUILDING_GOVERNORS_MANOR_ADJUST_WAR_WEARINESS'),
('SLTH_BUILDING_GOVERNORS_MANOR', 'MODIFIER_GRANT_2_PROD_BIN_1'),
('SLTH_BUILDING_GOVERNORS_MANOR', 'MODIFIER_GRANT_4_PROD_BIN_2'),
('SLTH_BUILDING_GOVERNORS_MANOR', 'MODIFIER_GRANT_8_PROD_BIN_4'),
('SLTH_BUILDING_GOVERNORS_MANOR', 'MODIFIER_GRANT_16_PROD_BIN_8');

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('MODIFIER_SLTH_BUILDING_GOVERNORS_MANOR_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS', NULL),
('MODIFIER_GRANT_2_PROD_BIN_1', 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE', 'PLOT_PROP_AMENITY_NEEDED_BIN_1_REQS'),
('MODIFIER_GRANT_4_PROD_BIN_2', 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE', 'PLOT_PROP_AMENITY_NEEDED_BIN_2_REQS'),
('MODIFIER_GRANT_8_PROD_BIN_4', 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE', 'PLOT_PROP_AMENITY_NEEDED_BIN_4_REQS'),
('MODIFIER_GRANT_16_PROD_BIN_8', 'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE', 'PLOT_PROP_AMENITY_NEEDED_BIN_8_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('MODIFIER_SLTH_BUILDING_GOVERNORS_MANOR_ADJUST_WAR_WEARINESS', 'Amount', '-25'),
('MODIFIER_SLTH_BUILDING_GOVERNORS_MANOR_ADJUST_WAR_WEARINESS', 'Overall', '1'),
('MODIFIER_GRANT_2_PROD_BIN_1', 'Amount', '2'),
('MODIFIER_GRANT_2_PROD_BIN_1', 'YieldType', 'YIELD_PRODUCTION'),
('MODIFIER_GRANT_4_PROD_BIN_2', 'Amount', '4'),
('MODIFIER_GRANT_4_PROD_BIN_2', 'YieldType', 'YIELD_PRODUCTION'),
('MODIFIER_GRANT_8_PROD_BIN_4', 'Amount', '8'),
('MODIFIER_GRANT_8_PROD_BIN_4', 'YieldType', 'YIELD_PRODUCTION'),
('MODIFIER_GRANT_16_PROD_BIN_8', 'Amount', '16'),
('MODIFIER_GRANT_16_PROD_BIN_8', 'YieldType', 'YIELD_PRODUCTION');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('PLOT_PROP_AMENITY_NEEDED_BIN_1', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_AMENITY_NEEDED_BIN_2', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_AMENITY_NEEDED_BIN_4', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('PLOT_PROP_AMENITY_NEEDED_BIN_8', 'REQUIREMENT_PLOT_PROPERTY_MATCHES');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('PLOT_PROP_AMENITY_NEEDED_BIN_1', 'PropertyName','CITY_AMENITIES_REQUIRED_1'),
('PLOT_PROP_AMENITY_NEEDED_BIN_1', 'PropertyMinimum','1'),
('PLOT_PROP_AMENITY_NEEDED_BIN_2', 'PropertyName','CITY_AMENITIES_REQUIRED_2'),
('PLOT_PROP_AMENITY_NEEDED_BIN_2', 'PropertyMinimum','1'),
('PLOT_PROP_AMENITY_NEEDED_BIN_4', 'PropertyName','CITY_AMENITIES_REQUIRED_4'),
('PLOT_PROP_AMENITY_NEEDED_BIN_4', 'PropertyMinimum','1'),
('PLOT_PROP_AMENITY_NEEDED_BIN_8', 'PropertyName','CITY_AMENITIES_REQUIRED_8'),
('PLOT_PROP_AMENITY_NEEDED_BIN_8', 'PropertyMinimum','1');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('PLOT_PROP_AMENITY_NEEDED_BIN_1_REQS', 'PLOT_PROP_AMENITY_NEEDED_BIN_1'),
('PLOT_PROP_AMENITY_NEEDED_BIN_2_REQS', 'PLOT_PROP_AMENITY_NEEDED_BIN_2'),
('PLOT_PROP_AMENITY_NEEDED_BIN_4_REQS', 'PLOT_PROP_AMENITY_NEEDED_BIN_4'),
('PLOT_PROP_AMENITY_NEEDED_BIN_8_REQS', 'PLOT_PROP_AMENITY_NEEDED_BIN_8');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('PLOT_PROP_AMENITY_NEEDED_BIN_1_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_AMENITY_NEEDED_BIN_2_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_AMENITY_NEEDED_BIN_4_REQS', 'REQUIREMENTSET_TEST_ANY'),
('PLOT_PROP_AMENITY_NEEDED_BIN_8_REQS', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_LOSHA', 'LOC_SLTH_UNIT_LOSHA_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_SLTH_UNIT_LOSHA_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_MOROI', 'LOC_SLTH_UNIT_MOROI_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_MOROI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', '1', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_BRUJAH', 'LOC_SLTH_UNIT_BRUJAH_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_BRUJAH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_VAMPIRE', 'LOC_SLTH_UNIT_VAMPIRE_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_VAMPIRE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FEUDALISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, PseudoYieldType, AdvisorType) VALUES
('SLTH_UNIT_VAMPIRE_LORD', 'LOC_SLTH_UNIT_VAMPIRE_LORD_NAME', '2', '1', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_VAMPIRE_LORD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '0', '1', NULL, 'ADVISOR_CONQUEST');


INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_MOROI', 'SLTH_UNIT_SWORDSMAN'),
('SLTH_UNIT_BRUJAH', 'SLTH_UNIT_BERSERKER'),
('SLTH_UNIT_VAMPIRE_LORD', 'SLTH_UNIT_IMMORTAL'),
('SLTH_UNIT_VAMPIRE', 'SLTH_UNIT_CHAMPION');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES
('SLTH_UNIT_VAMPIRE', 'SLTH_BUILDING_GOVERNORS_MANOR'),
('SLTH_UNIT_MOROI', 'BUILDING_BARRACKS');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('VAMPIRISM_INHERENT',  'LOC_INHERENT_VAMPIRISM_NAME', 'LOC_INHERENT_VAMPIRISM_DESCRIPTION','0', '1'),
('ABILITY_VAMPIRISM',  'LOC_VAMPIRISM_NAME', 'LOC_VAMPIRISM_DESCRIPTION','1', '1'),
('BUFF_BURNING_BLOOD', 'LOC_BUFF_BURNING_BLOOD_NAME', 'LOC_BUFF_BURNING_BLOOD_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('VAMPIRISM_INHERENT', 'INHERENT_GRANT_VAMPIRISM');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('INHERENT_GRANT_VAMPIRISM', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('INHERENT_GRANT_VAMPIRISM', 'AbilityType', 'ABILITY_VAMPIRISM');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_VAMPIRE', 'ABILITY_CLASS'),
('CLASS_MOROI', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_LOSHA', 'CLASS_MELEE'),
('SLTH_UNIT_LOSHA', 'RACE_HUMAN'),
('SLTH_UNIT_MOROI', 'CLASS_MELEE'),
('SLTH_UNIT_MOROI', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_BRUJAH', 'CLASS_MELEE'),
('SLTH_UNIT_BRUJAH', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_VAMPIRE_LORD', 'CLASS_MELEE'),
('SLTH_UNIT_VAMPIRE_LORD', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_VAMPIRE', 'CLASS_MELEE'),
('SLTH_UNIT_VAMPIRE', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_LOSHA', 'CLASS_VAMPIRE'),
('SLTH_UNIT_VAMPIRE', 'CLASS_VAMPIRE'),
('SLTH_UNIT_VAMPIRE_LORD', 'CLASS_VAMPIRE'),
('VAMPIRISM_INHERENT', 'CLASS_VAMPIRE'),
('ABILITY_VAMPIRISM', 'CLASS_ALL_UNITS'),
('BUFF_BURNING_BLOOD', 'CLASS_MOROI'),
('SLTH_UNIT_MOROI', 'CLASS_MOROI');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_CALABIM', 'KIND_CIVILIZATION'),
('LEADER_ALEXIS', 'KIND_LEADER'),
('LEADER_FLAUROS', 'KIND_LEADER'),
('LEADER_DECIUS_CALABIM', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_CALABIM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', 'KIND_TRAIT'),
('SLTH_UNIT_LOSHA', 'KIND_UNIT'),
('SLTH_UNIT_MOROI', 'KIND_UNIT'),
('SLTH_UNIT_BRUJAH', 'KIND_UNIT'),
('SLTH_UNIT_VAMPIRE', 'KIND_UNIT'),
('SLTH_UNIT_VAMPIRE_LORD', 'KIND_UNIT'),
('SLTH_BUILDING_GOVERNORS_MANOR', 'KIND_BUILDING'),
('ABILITY_VAMPIRISM', 'KIND_ABILITY'),
('VAMPIRISM_INHERENT', 'KIND_ABILITY'),
('BUFF_BURNING_BLOOD', 'KIND_ABILITY');