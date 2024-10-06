INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_LJOSALFAR', 'LOC_CIV_LJOSALFAR_NAME', 'LOC_CIV_LJOSALFAR_DESCRIPTION', 'LOC_SLTH_CIV_LJOSALFAR_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_AMELANCHIER', 'LOC_SLTH_LEADER_AMELANCHIER_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_ARENDEL', 'LOC_SLTH_LEADER_ARENDEL_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_THESSA', 'LOC_SLTH_LEADER_THESSA_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_AMELANCHIER', 'SLTH_CIVILIZATION_LJOSALFAR', 'LOC_CITY_LJOSALFAR_1_NAME'),
('SLTH_LEADER_ARENDEL', 'SLTH_CIVILIZATION_LJOSALFAR', 'LOC_CITY_LJOSALFAR_1_NAME'),
('SLTH_LEADER_THESSA', 'SLTH_CIVILIZATION_LJOSALFAR', 'LOC_CITY_LJOSALFAR_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_LJOSALFAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_GILDEN'),
('SLTH_CIVILIZATION_LJOSALFAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_FYRDWELL'),
('SLTH_CIVILIZATION_LJOSALFAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_FLURRY'),
('SLTH_CIVILIZATION_LJOSALFAR', 'SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL'),
('SLTH_CIVILIZATION_LJOSALFAR', 'SLTH_TRAIT_ELVEN');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('NULL_CIVILIZATION_LJOSALFAR', 'LOC_SLTH_NULL_CIVILIZATION_SVARTALFAR_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GILDEN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GILDEN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GILDEN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FYRDWELL', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FYRDWELL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FYRDWELL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FLURRY', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FLURRY_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FLURRY_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL', 'TRAIT_CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS'),
('SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL', 'MODIFIER_SLTH_GRANT_TECH_EXPLORATION'),
('SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_NATURE'),
('SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL', 'MODIFIER_SLTH_SMALL_MORE_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_AIR'),
('SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_LIFE');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('TRAIT_CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', '0', '0', NULL),
('MODIFIER_PROMOTION_DEXTEROUS', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS', 'Amount', 'ARGTYPE_IDENTITY', '5'),
('TRAIT_CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS', 'AbilityType', 'ARGTYPE_IDENTITY', 'CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS'),
('MODIFIER_PROMOTION_DEXTEROUS', 'Amount', 'ARGTYPE_IDENTITY', '1');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_PROMOTION_DEXTEROUS', 'Preview', 'LOC_PROMOTION_DEXTEROUS_DESCRIPTION');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS', 'LOC_SLTH_CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS_NAME', 'LOC_CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS', 'MODIFIER_CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_LJOSALFAR_ALCHEMY_LAB', 'BUILDING_RESEARCH_LAB'),
('SLTH_BUILDING_NULL_CIVILIZATION_LJOSALFAR_SIEGE_WORKSHOP', 'SLTH_BUILDING_SIEGE_WORKSHOP');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_LJOSALFAR_ALCHEMY_LAB', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_LJOSALFAR', NULL, 'ADVISOR_RELIGIOUS'),
('SLTH_BUILDING_NULL_CIVILIZATION_LJOSALFAR_SIEGE_WORKSHOP', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_LJOSALFAR', NULL, 'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_GILDEN', 'LOC_SLTH_UNIT_GILDEN_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_GILDEN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GILDEN', '1', 'PROMOTION_CLASS_RANGED', 'TECH_ARCHERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_FYRDWELL', 'LOC_SLTH_UNIT_FYRDWELL_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_FYRDWELL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FYRDWELL', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_FLURRY', 'LOC_SLTH_UNIT_FLURRY_NAME', '2', '2', '58', '63', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_FLURRY_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FLURRY', '1', 'PROMOTION_CLASS_RANGED', 'TECH_MACHINERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_FYRDWELL', 'SLTH_UNIT_HORSE_ARCHER'),
('SLTH_UNIT_FLURRY', 'SLTH_UNIT_CROSSBOWMAN');

INSERT INTO TypeTags(Type, Tag) VALUES
('CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS', 'CLASS_RANGED'),
('SLTH_UNIT_GILDEN', 'CLASS_RANGED'),
('SLTH_UNIT_FYRDWELL', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_FLURRY', 'CLASS_RANGED'),
('SLTH_UNIT_GILDEN', 'RACE_ELVEN'),
('SLTH_UNIT_FYRDWELL', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_FLURRY', 'CAN_BE_RACIALIZED');

INSERT INTO Types(Type, Kind) VALUES
('CIVILIZATION_LJOSALFAR_ABILITY_SLTH_TRAIT_DEXTEROUS', 'KIND_ABILITY'),
('SLTH_CIVILIZATION_LJOSALFAR', 'KIND_CIVILIZATION'),
('SLTH_LEADER_AMELANCHIER', 'KIND_LEADER'),
('SLTH_LEADER_ARENDEL', 'KIND_LEADER'),
('SLTH_LEADER_THESSA', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_LJOSALFAR_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_LJOSALFAR', 'KIND_TRAIT'),
('SLTH_BUILDING_NULL_CIVILIZATION_LJOSALFAR_ALCHEMY_LAB', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_LJOSALFAR_SIEGE_WORKSHOP', 'KIND_BUILDING'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FYRDWELL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FLURRY', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GILDEN', 'KIND_TRAIT'),
('SLTH_UNIT_GILDEN', 'KIND_UNIT'),
('SLTH_UNIT_FYRDWELL', 'KIND_UNIT'),
('SLTH_UNIT_FLURRY', 'KIND_UNIT');