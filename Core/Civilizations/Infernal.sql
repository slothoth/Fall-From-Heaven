INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_INFERNAL', 'LOC_CIV_INFERNAL_NAME', 'LOC_CIV_INFERNAL_DESCRIPTION', 'LOC_SLTH_CIV_INFERNAL_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_HYBOREM', 'LOC_SLTH_LEADER_HYBOREM_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_HYBOREM', 'SLTH_CIVILIZATION_INFERNAL', 'LOC_CITY_INFERNAL_1_NAME');

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
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'TRAIT_TOWORLDSEND_NO_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'MODIFIER_SLTH_BUILDING_PALACE_INFERNAL_ADD_PRODUCTIONYIELD'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'TRAIT_GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY_ATTACH'),
('SLTH_TRAIT_CIVILIZATION_INFERNAL_COOL', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_SLTH_BUILDING_PALACE_INFERNAL_ADD_PRODUCTIONYIELD', 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER', '0', '0', NULL),
('TRAIT_GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY_ATTACH', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 0, 0, NULL),
('GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_SLTH_BUILDING_PALACE_INFERNAL_ADD_PRODUCTIONYIELD', 'Amount', 'ARGTYPE_IDENTITY', '50'),
('MODIFIER_SLTH_BUILDING_PALACE_INFERNAL_ADD_PRODUCTIONYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_PRODUCTION'),
('TRAIT_GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY'),
('GRANT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_CITY', 'AbilityType', 'ARGTYPE_IDENTITY', 'DEMON_ABILITY_HELL_TERRAIN_STRENGTH');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_AQUEDUCT', 'SLTH_BUILDING_AQUEDUCT'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_GRANARY', 'SLTH_BUILDING_GRANARY'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_HERBALIST', 'SLTH_BUILDING_HERBALIST'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_INFIRMARY', 'SLTH_BUILDING_INFIRMARY'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_PUBLIC_BATHS', 'SLTH_BUILDING_PUBLIC_BATHS'),
('SLTH_BUILDING_NULL_CIVILIZATION_INFERNAL_SMOKEHOUSE', 'SLTH_BUILDING_SMOKEHOUSE');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_HYBOREM', 'LOC_SLTH_UNIT_HYBOREM_NAME', '2', '2', '7', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '100', '0', 'LOC_SLTH_UNIT_HYBOREM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_HYBOREM', 'CLASS_MELEE'),
('SLTH_UNIT_HYBOREM', 'RACE_DEMON');


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
('SLTH_UNIT_HYBOREM', 'KIND_UNIT');

