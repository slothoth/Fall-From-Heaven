INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_SIDAR', 'LOC_CIV_SIDAR_NAME', 'LOC_CIV_SIDAR_DESCRIPTION', 'LOC_SLTH_CIV_SIDAR_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_SANDALPHON', 'LOC_SLTH_LEADER_SANDALPHON_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_SANDALPHON', 'SLTH_CIVILIZATION_SIDAR', 'LOC_CITY_SIDAR_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_SIDAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_RATHUS'),
('SLTH_CIVILIZATION_SIDAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_GHOST'),
('SLTH_CIVILIZATION_SIDAR', 'SLTH_TRAIT_CIVILIZATION_UNIT_DIVIDED_SOUL'),
('SLTH_CIVILIZATION_SIDAR', 'SLTH_TRAIT_CIVILIZATION_SIDAR_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_SIDAR_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_SIDAR_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_SIDAR_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_RATHUS', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_RATHUS_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_RATHUS_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GHOST', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GHOST_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GHOST_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DIVIDED_SOUL', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DIVIDED_SOUL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DIVIDED_SOUL_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_SIDAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_SPIRIT'),
('SLTH_TRAIT_CIVILIZATION_SIDAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_ENCHANTMENT'),
('SLTH_TRAIT_CIVILIZATION_SIDAR_COOL', 'MODIFIER_SLTH_GRANT_MANA_SHADOW'),
('SLTH_TRAIT_CIVILIZATION_SIDAR_COOL', 'MODIFIER_SLTH_GRANT_TECH_ANCIENT_CHANTS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_RATHUS', 'LOC_SLTH_UNIT_RATHUS_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_RATHUS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_RATHUS', '1', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_GHOST', 'LOC_SLTH_UNIT_GHOST_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_GHOST_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GHOST', '1', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_DIVIDED_SOUL', 'LOC_SLTH_UNIT_DIVIDED_SOUL_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_DIVIDED_SOUL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DIVIDED_SOUL', '1', 'PROMOTION_CLASS_RECON', 'TECH_HUNTING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_GHOST', 'SLTH_UNIT_ASSASSIN'),
('SLTH_UNIT_DIVIDED_SOUL', 'SLTH_UNIT_HUNTER');


INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_RATHUS', 'CLASS_RECON'),
('SLTH_UNIT_GHOST', 'CLASS_RECON'),
('SLTH_UNIT_DIVIDED_SOUL', 'CLASS_RECON'),
('SLTH_UNIT_RATHUS', 'RACE_HUMAN'),
('SLTH_UNIT_GHOST', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DIVIDED_SOUL', 'CAN_BE_RACIALIZED');


INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_SIDAR', 'KIND_CIVILIZATION'),
('SLTH_LEADER_SANDALPHON', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_SIDAR_COOL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_RATHUS', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GHOST', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DIVIDED_SOUL', 'KIND_TRAIT'),
('SLTH_UNIT_RATHUS', 'KIND_UNIT'),
('SLTH_UNIT_GHOST', 'KIND_UNIT'),
('SLTH_UNIT_DIVIDED_SOUL', 'KIND_UNIT');

