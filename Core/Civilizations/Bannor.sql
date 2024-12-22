INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_BANNOR', 'LOC_CIV_BANNOR_NAME', 'LOC_CIV_BANNOR_DESCRIPTION', 'LOC_SLTH_CIV_BANNOR_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_AFRICAN');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('LEADER_SABATHIEL', 'LOC_LEADER_SABATHIEL_NAME', 'LEADER_DEFAULT'),
('LEADER_CAPRIA', 'LOC_LEADER_CAPRIA_NAME', 'LEADER_DEFAULT'),
('LEADER_DECIUS_BANNOR', 'LOC_LEADER_DECIUS_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('LEADER_SABATHIEL', 'SLTH_CIVILIZATION_BANNOR', 'LOC_CITY_BANNOR_1_NAME'),
('LEADER_CAPRIA', 'SLTH_CIVILIZATION_BANNOR', 'LOC_CITY_BANNOR_1_NAME'),
('LEADER_DECIUS_BANNOR', 'SLTH_CIVILIZATION_BANNOR', 'LOC_CITY_BANNOR_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_BANNOR', 'SLTH_TRAIT_CIVILIZATION_BANNOR_COOL'),
('SLTH_CIVILIZATION_BANNOR', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEMAGOG'),
('SLTH_CIVILIZATION_BANNOR', 'SLTH_TRAIT_CIVILIZATION_UNIT_DONAL'),
('SLTH_CIVILIZATION_BANNOR', 'SLTH_TRAIT_CIVILIZATION_UNIT_FLAGBEARER');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_BANNOR_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_BANNOR_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BANNOR_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DEMAGOG', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DEMAGOG_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DEMAGOG_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FLAGBEARER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FLAGBEARER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FLAGBEARER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DONAL', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DONAL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DONAL_DESCRIPTION'),
('SLTH_TRAIT_RELIGION_UNIT_DEMAGOG', 'LOC_SLTH_TRAIT_RELIGION_UNIT_DEMAGOG_NAME', 'LOC_SLTH_TRAIT_RELIGION_UNIT_DEMAGOG_DESCRIPTION');          -- TODO religion not sorted
-- TODO policy card Crusade
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_BANNOR_COOL', 'MODIFIER_SLTH_GRANT_TECH_EXPLORATION'),
('SLTH_TRAIT_CIVILIZATION_BANNOR_COOL', 'MODIFIER_SLTH_GRANT_MANA_LAW'),
('SLTH_TRAIT_CIVILIZATION_BANNOR_COOL', 'MODIFIER_SLTH_SMALL_ADJUST_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_BANNOR_COOL', 'MODIFIER_SLTH_GRANT_MANA_SPIRIT'),
('SLTH_TRAIT_CIVILIZATION_BANNOR_COOL', 'MODIFIER_SLTH_GRANT_MANA_EARTH');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_DEMAGOG', 'LOC_SLTH_UNIT_DEMAGOG_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_DEMAGOG_DESCRIPTION', 'SLTH_TRAIT_RELIGION_UNIT_DEMAGOG', '1', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_FLAGBEARER', 'LOC_SLTH_UNIT_FLAGBEARER_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_FLAGBEARER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FLAGBEARER', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_DONAL', 'LOC_SLTH_UNIT_DONAL_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_SLTH_UNIT_DONAL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DONAL', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_DEMAGOG', 'CLASS_MELEE'),
('SLTH_UNIT_DEMAGOG', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_FLAGBEARER', 'CLASS_MELEE'),
('SLTH_UNIT_FLAGBEARER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DONAL', 'CLASS_MELEE'),
('SLTH_UNIT_DONAL', 'RACE_HUMAN');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_BANNOR', 'KIND_CIVILIZATION'),
('LEADER_SABATHIEL', 'KIND_LEADER'),
('LEADER_CAPRIA', 'KIND_LEADER'),
('LEADER_DECIUS_BANNOR', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_BANNOR_COOL', 'KIND_TRAIT'),
('SLTH_TRAIT_RELIGION_UNIT_DEMAGOG', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DEMAGOG', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FLAGBEARER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DONAL', 'KIND_TRAIT'),
('SLTH_UNIT_DEMAGOG', 'KIND_UNIT'),
('SLTH_UNIT_FLAGBEARER', 'KIND_UNIT'),
('SLTH_UNIT_DONAL', 'KIND_UNIT');