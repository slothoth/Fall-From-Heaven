INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_HIPPUS', 'LOC_CIV_HIPPUS_NAME', 'LOC_CIV_HIPPUS_DESCRIPTION', 'LOC_SLTH_CIV_HIPPUS_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_TASUNKE', 'LOC_SLTH_LEADER_TASUNKE_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_RHOANNA', 'LOC_SLTH_LEADER_RHOANNA_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_TASUNKE', 'SLTH_CIVILIZATION_HIPPUS', 'LOC_CITY_HIPPUS_1_NAME'),
('SLTH_LEADER_RHOANNA', 'SLTH_CIVILIZATION_HIPPUS', 'LOC_CITY_HIPPUS_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_HIPPUS', 'SLTH_TRAIT_CIVILIZATION_UNIT_MAGNADINE'),
('SLTH_CIVILIZATION_HIPPUS', 'SLTH_TRAIT_CIVILIZATION_UNIT_MERCENARY_MOUNTED'),
('SLTH_CIVILIZATION_HIPPUS', 'SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('NULL_CIVILIZATION_HIPPUS', 'LOC_SLTH_NULL_CIVILIZATION_HIPPUS_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MAGNADINE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MAGNADINE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MAGNADINE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MERCENARY_MOUNTED', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MERCENARY_MOUNTED_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MERCENARY_MOUNTED_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'TRAIT_CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD'),
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'MODIFIER_SLTH_GRANT_TECH_AGRICULTURE'),
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'MODIFIER_SLTH_GRANT_HORSE'),
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'MODIFIER_SLTH_GRANT_MANA_NATURE'),
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'MODIFIER_SLTH_GRANT_MANA_AIR'),
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS'),
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'MODIFIER_BAN_SLTH_UNIT_CANNON');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD_MOVE', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('TRAIT_CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', '0', '0', NULL);
INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD', 'Amount', 'ARGTYPE_IDENTITY', '5'),
('MODIFIER_CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD_MOVE', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('TRAIT_CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD', 'AbilityType', 'ARGTYPE_IDENTITY', 'CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD');
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_HIPPUS_ALCHEMY_LAB', 'SLTH_BUILDING_ALCHEMY_LAB');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_MERCENARY_MOUNTED', 'LOC_SLTH_UNIT_MERCENARY_MOUNTED_NAME', '2', '3', '5', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_MERCENARY_MOUNTED_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MERCENARY_MOUNTED', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_MAGNADINE', 'LOC_SLTH_UNIT_MAGNADINE_NAME', '2', '4', '11', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_MAGNADINE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MAGNADINE', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'SLTH_TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_MERCENARY_MOUNTED', 'SLTH_UNIT_MERCENARY');

INSERT INTO TypeTags(Type, Tag) VALUES
('CIVILIZATION_HIPPUS_ABILITY_SLTH_TRAIT_HORSELORD', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_MERCENARY_MOUNTED', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_MAGNADINE', 'CLASS_LIGHT_CAVALRY');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_TRAIT_CIVILIZATION_HIPPUS_COOL', 'KIND_TRAIT'),
('SLTH_CIVILIZATION_HIPPUS', 'KIND_CIVILIZATION'),
('SLTH_LEADER_TASUNKE', 'KIND_LEADER'),
('SLTH_LEADER_RHOANNA', 'KIND_LEADER'),
('NULL_CIVILIZATION_HIPPUS', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MAGNADINE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MERCENARY_MOUNTED', 'KIND_TRAIT'),
('SLTH_UNIT_MERCENARY_MOUNTED', 'KIND_UNIT'),
('SLTH_UNIT_MAGNADINE', 'KIND_UNIT');