INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_INFERNAL', 'LOC_CIV_INFERNAL_NAME', 'LOC_CIV_INFERNAL_DESCRIPTION', 'LOC_SLTH_CIV_INFERNAL_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_HYBOREM', 'LOC_SLTH_LEADER_HYBOREM_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_HYBOREM', 'SLTH_CIVILIZATION_INFERNAL', 'LOC_CITY_INFERNAL_1_NAME');

INSERT INTO Leaders_XP2 (LeaderType, OceanStart) VALUES ('SLTH_LEADER_HYBOREM', 1);

INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_INFERNAL', 'SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL'),
('SLTH_CIVILIZATION_INFERNAL', 'SLTH_TRAIT_CIVILIZATION_UNIT_IMP'),
('SLTH_CIVILIZATION_INFERNAL', 'SLTH_TRAIT_CIVILIZATION_UNIT_HELLHOUND'),
('SLTH_CIVILIZATION_INFERNAL', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEATH_KNIGHT'),
('SLTH_CIVILIZATION_INFERNAL', 'SLTH_TRAIT_CIVILIZATION_UNIT_BALOR'),
('SLTH_CIVILIZATION_INFERNAL', 'SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL_DESCRIPTION'),
('NULL_CIVILIZATION_INFERNAL', 'LOC_SLTH_NULL_CIVILIZATION_INFERNAL_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_IMP', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_IMP_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_IMP_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HELLHOUND', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HELLHOUND_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HELLHOUND_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DEATH_KNIGHT', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DEATH_KNIGHT_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DEATH_KNIGHT_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BALOR', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BALOR_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BALOR_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'MODIFIER_SLTH_GRANT_TECH_CRAFTING'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'MODIFIER_SLTH_GRANT_MANA_ENTROPY'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'MODIFIER_SLTH_GRANT_MANA_FIRE'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'MODIFIER_SLTH_GRANT_IRON'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'TRAIT_TOWORLDSEND_NO_WAR_WEARINESS'),                -- borrowed from Alexander
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'MODIFIER_SLTH_BUILDING_PALACE_INFERNAL_ADD_PRODUCTIONYIELD'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'NO_FOOD_COST_INFERNAL'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'NO_GROWTH_AT_ALL'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'TRAIT_NO_FRESH_WATER_HOUSING'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'TRAIT_GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY_ATTACH'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'HYBOREM_ADD_HERO_HYBOREM'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('MODIFIER_SLTH_BUILDING_PALACE_INFERNAL_ADD_PRODUCTIONYIELD', 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER'),
('NO_FOOD_COST_INFERNAL', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_POPULATION'),
('NO_GROWTH_AT_ALL', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_GROWTH'),
('TRAIT_GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY_ATTACH', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
('GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_SLTH_BUILDING_PALACE_INFERNAL_ADD_PRODUCTIONYIELD', 'Amount', 'ARGTYPE_IDENTITY', '50'),
('MODIFIER_SLTH_BUILDING_PALACE_INFERNAL_ADD_PRODUCTIONYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_PRODUCTION'),
('NO_FOOD_COST_INFERNAL', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('NO_FOOD_COST_INFERNAL', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_FOOD'),
('NO_GROWTH_AT_ALL', 'Amount', 'ARGTYPE_IDENTITY', '-100'),
('TRAIT_GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY'),
('GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY', 'AbilityType', 'ARGTYPE_IDENTITY', 'DEMON_ABILITY_HELL_TERRAIN_STRENGTH'),
('HYBOREM_ADD_HERO_HYBOREM', 'UnitType','ARGTYPE_IDENTITY', 'SLTH_UNIT_HYBOREM'),
('HYBOREM_ADD_HERO_HYBOREM', 'Amount','ARGTYPE_IDENTITY', '1'),
('HYBOREM_ADD_HERO_HYBOREM', 'AllowUniqueOverride','ARGTYPE_IDENTITY', '0');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, OwnerRequirementSetId) VALUES
('HYBOREM_ADD_HERO_HYBOREM', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', '1', '1', 'HAS_CAPITAL_CITY');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_AQUEDUCT', 'SLTH_BUILDING_AQUEDUCT'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_GRANARY', 'BUILDING_GRANARY'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_HERBALIST', 'BUILDING_MEETING_HOUSE'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_INFIRMARY', 'BUILDING_CHANCERY'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_PUBLIC_BATHS', 'SLTH_BUILDING_PUBLIC_BATHS'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_SMOKEHOUSE', 'SLTH_BUILDING_SMOKEHOUSE');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase) VALUES
('SLTH_UNIT_HYBOREM', 'LOC_SLTH_UNIT_HYBOREM_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '100', '0', 'LOC_SLTH_UNIT_HYBOREM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1'),
('SLTH_UNIT_MANES', 'LOC_SLTH_UNIT_MANES_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_MANES_DESCRIPTION', NULL, '1', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1'),
('SLTH_UNIT_IMP', 'LOC_SLTH_UNIT_IMP_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '1', 'LOC_SLTH_UNIT_IMP_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_IMP', '1', 'PROMOTION_CLASS_ADEPT', 'TECH_KNOWLEDGE_OF_THE_ETHER', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '0'),
('SLTH_UNIT_HELLHOUND', 'LOC_SLTH_UNIT_HELLHOUND_NAME', '2', '3', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_HELLHOUND_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HELLHOUND', '1', 'PROMOTION_CLASS_RECON', 'TECH_HUNTING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', NULL, '0');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES
('SLTH_UNIT_DEATH_KNIGHT', 'BUILDING_STABLE');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_IMP', 'SLTH_UNIT_ADEPT'),
('SLTH_UNIT_HELLHOUND', 'SLTH_UNIT_HUNTER');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES
('SLTH_UNIT_IMP', 'BUILDING_MAGE_GUILD');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_HYBOREM', 'CLASS_MELEE'),
('SLTH_UNIT_HYBOREM', 'RACE_DEMON'),
('SLTH_UNIT_IMP', 'CLASS_ADEPT'),
('SLTH_UNIT_IMP', 'RACE_DEMON'),
('SLTH_UNIT_HELLHOUND', 'CLASS_RECON'),
('SLTH_UNIT_HELLHOUND', 'RACE_DEMON'),
('SLTH_UNIT_MANES', 'RACE_DEMON');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_INFERNAL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_IMP', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HELLHOUND', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BALOR', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DEATH_KNIGHT', 'KIND_TRAIT'),
('SLTH_CIVILIZATION_INFERNAL', 'KIND_CIVILIZATION'),
('SLTH_LEADER_HYBOREM', 'KIND_LEADER'),
('SLTH_UNIT_HYBOREM', 'KIND_UNIT'),
('SLTH_UNIT_IMP', 'KIND_UNIT'),
('SLTH_UNIT_MANES', 'KIND_UNIT'),
('SLTH_UNIT_HELLHOUND', 'KIND_UNIT');

