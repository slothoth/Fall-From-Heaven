INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_CALABIM', 'LOC_CIV_CALABIM_NAME', 'LOC_CIV_CALABIM_DESCRIPTION', 'LOC_SLTH_CIV_CALABIM_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_ALEXIS', 'LOC_SLTH_LEADER_ALEXIS_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_FLAUROS', 'LOC_SLTH_LEADER_FLAUROS_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_ALEXIS', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME'),
('SLTH_LEADER_FLAUROS', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME'),
('SLTH_LEADER_DECIUS', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME');

INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_CALABIM_COOL'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET'),
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
('SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET_DESCRIPTION'),
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
('SLTH_BUILDING_BREEDING_PIT', 'LOC_SLTH_BUILDING_BREEDING_PIT_NAME', NULL, NULL, '120', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_BREEDING_PIT_DESCRIPTION', '0', '-1', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT', NULL, 'ADVISOR_GENERIC'),
('SLTH_BUILDING_GOVERNORS_MANOR', 'LOC_SLTH_BUILDING_GOVERNORS_MANOR_NAME', NULL, 'CIVIC_CODE_OF_LAWS', '180', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_GOVERNORS_MANOR_DESCRIPTION', '0', '0', '-1', 'SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR', NULL, 'ADVISOR_GENERIC');


INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_GOVERNORS_MANOR', 'SLTH_BUILDING_COURTHOUSE'),
('SLTH_BUILDING_NULL_CIVILIZATION_CALABIM_ALCHEMY_LAB', 'SLTH_BUILDING_ALCHEMY_LAB'),
('SLTH_BUILDING_NULL_CIVILIZATION_CALABIM_ELDER_COUNCIL', 'SLTH_BUILDING_ELDER_COUNCIL'),
('SLTH_BUILDING_NULL_CIVILIZATION_SHEAIM_TRAINING_YARD', 'SLTH_BUILDING_TRAINING_YARD');

INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
('SLTH_BUILDING_GOVERNORS_MANOR', 'MODIFIER_SLTH_BUILDING_GOVERNORS_MANOR_ADJUST_WAR_WEARINESS');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('MODIFIER_SLTH_BUILDING_GOVERNORS_MANOR_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_SLTH_BUILDING_GOVERNORS_MANOR_ADJUST_WAR_WEARINESS', 'Amount', 'ARGTYPE_IDENTITY', '-25'),
('MODIFIER_SLTH_BUILDING_GOVERNORS_MANOR_ADJUST_WAR_WEARINESS', 'Overall', 'ARGTYPE_IDENTITY', '1');


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_LOSHA', 'LOC_SLTH_UNIT_LOSHA_NAME', '2', '1', '7', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_SLTH_UNIT_LOSHA_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_BLOODPET', 'LOC_SLTH_UNIT_BLOODPET_NAME', '2', '1', '3', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '25', '0', 'LOC_SLTH_UNIT_BLOODPET_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET', '1', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_MOROI', 'LOC_SLTH_UNIT_MOROI_NAME', '2', '1', '4', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_MOROI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', '1', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_BRUJAH', 'LOC_SLTH_UNIT_BRUJAH_NAME', '2', '1', '11', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_BRUJAH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_VAMPIRE_LORD', 'LOC_SLTH_UNIT_VAMPIRE_LORD_NAME', '2', '1', '9', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_VAMPIRE_LORD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_VAMPIRE', 'LOC_SLTH_UNIT_VAMPIRE_NAME', '2', '1', '5', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_VAMPIRE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FEUDALISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');


INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_BLOODPET', 'SLTH_UNIT_WARRIOR'),
('SLTH_UNIT_MOROI', 'SLTH_UNIT_AXEMAN'),
('SLTH_UNIT_BRUJAH', 'SLTH_UNIT_BERSERKER'),
('SLTH_UNIT_VAMPIRE_LORD', 'SLTH_UNIT_IMMORTAL'),
('SLTH_UNIT_VAMPIRE', 'SLTH_UNIT_CHAMPION');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_LOSHA', 'CLASS_MELEE'),
('SLTH_UNIT_LOSHA', 'RACE_HUMAN'),
('SLTH_UNIT_BLOODPET', 'CLASS_MELEE'),
('SLTH_UNIT_BLOODPET', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_MOROI', 'CLASS_MELEE'),
('SLTH_UNIT_MOROI', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_BRUJAH', 'CLASS_MELEE'),
('SLTH_UNIT_BRUJAH', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_VAMPIRE_LORD', 'CLASS_MELEE'),
('SLTH_UNIT_VAMPIRE_LORD', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_VAMPIRE', 'CLASS_MELEE'),
('SLTH_UNIT_VAMPIRE', 'CAN_BE_RACIALIZED');


INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_CALABIM', 'KIND_CIVILIZATION'),
('SLTH_LEADER_ALEXIS', 'KIND_LEADER'),
('SLTH_LEADER_FLAUROS', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_CALABIM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', 'KIND_TRAIT'),
('SLTH_UNIT_LOSHA', 'KIND_UNIT'),
('SLTH_UNIT_BLOODPET', 'KIND_UNIT'),
('SLTH_UNIT_MOROI', 'KIND_UNIT'),
('SLTH_UNIT_BRUJAH', 'KIND_UNIT'),
('SLTH_UNIT_VAMPIRE', 'KIND_UNIT'),
('SLTH_UNIT_VAMPIRE_LORD', 'KIND_UNIT'),
('SLTH_BUILDING_GOVERNORS_MANOR', 'KIND_BUILDING'),
('SLTH_BUILDING_BREEDING_PIT', 'KIND_BUILDING');