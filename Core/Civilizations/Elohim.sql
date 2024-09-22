INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_ELOHIM', 'LOC_CIV_ELOHIM_NAME', 'LOC_CIV_ELOHIM_DESCRIPTION', 'LOC_SLTH_CIV_ELOHIM_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_ETHNE', 'LOC_SLTH_LEADER_ETHNE_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_EINION', 'LOC_SLTH_LEADER_EINION_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_ETHNE', 'SLTH_CIVILIZATION_ELOHIM', 'LOC_CITY_ELOHIM_1_NAME'),
('SLTH_LEADER_EINION', 'SLTH_CIVILIZATION_ELOHIM', 'LOC_CITY_ELOHIM_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_ELOHIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_CHANCEL_OF_GUARDIANS'),
('SLTH_CIVILIZATION_ELOHIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_RELIQUARY'),
('SLTH_CIVILIZATION_ELOHIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_CORLINDALE'),
('SLTH_CIVILIZATION_ELOHIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_MONK'),
('SLTH_CIVILIZATION_ELOHIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEVOUT'),
('SLTH_CIVILIZATION_ELOHIM', 'SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_CHANCEL_OF_GUARDIANS', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_CHANCEL_OF_GUARDIANS_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_CHANCEL_OF_GUARDIANS_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_RELIQUARY', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_RELIQUARY_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_RELIQUARY_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CORLINDALE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CORLINDALE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CORLINDALE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MONK', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MONK_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MONK_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DEVOUT', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DEVOUT_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DEVOUT_DESCRIPTION');
-- missing Tolerant implementation
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL', 'MODIFIER_SLTH_GRANT_TECH_ANCIENT_CHANTS'),
('SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_SPIRIT'),
('SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL', 'MODIFIER_SLTH_LARGE_MORE_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_NATURE'),
('SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_WATER');

-- implement, Reliquary spirit guide promo, 20% chance of defensive on chancel, -1 housing on reliquary
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_RELIQUARY', 'LOC_SLTH_BUILDING_RELIQUARY_NAME', NULL, 'CIVIC_WAY_OF_THE_WISE', '100', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_RELIQUARY_DESCRIPTION', '0', '-1', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_RELIQUARY', NULL, 'ADVISOR_GENERIC'),
('BUILDING_GOV_FAITH', 'LOC_BUILDING_GOV_FAITH_NAME', NULL, 'CIVIC_PRIESTHOOD', '120', 'DISTRICT_CITY_CENTER', 'LOC_BUILDING_GOV_FAITH_DESCRIPTION', '200', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_CHANCEL_OF_GUARDIANS', NULL, 'ADVISOR_GENERIC');

INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn) VALUES
('SLTH_BUILDING_RELIQUARY', 'GREAT_PERSON_CLASS_PROPHET', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_DEVOUT', 'LOC_SLTH_UNIT_DEVOUT_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_DEVOUT_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEVOUT', '1', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_MONK', 'LOC_SLTH_UNIT_MONK_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_MONK_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MONK', '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0'),
('SLTH_UNIT_CORLINDALE', 'LOC_SLTH_UNIT_CORLINDALE_NAME', '2', '2', '0', '0', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '300', '1', 'LOC_SLTH_UNIT_CORLINDALE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CORLINDALE', '1', 'PROMOTION_CLASS_ADEPT', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_DEVOUT', 'SLTH_UNIT_ASSASSIN');
INSERT INTO UnitUpgrades(Unit, UpgradeUnit) VALUES
('SLTH_UNIT_MONK', 'SLTH_UNIT_PALADIN');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_DEVOUT', 'CLASS_RECON'),
('SLTH_UNIT_DEVOUT', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_MONK', 'CLASS_DISCIPLE'),
('SLTH_UNIT_MONK', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_CORLINDALE', 'CLASS_ADEPT'),
('SLTH_UNIT_CORLINDALE', 'RACE_HUMAN');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_ELOHIM', 'KIND_CIVILIZATION'),
('SLTH_LEADER_ETHNE', 'KIND_LEADER'),
('SLTH_LEADER_EINION', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_ELOHIM_COOL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_CHANCEL_OF_GUARDIANS', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_RELIQUARY', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CORLINDALE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MONK', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DEVOUT', 'KIND_TRAIT'),
('SLTH_UNIT_DEVOUT', 'KIND_UNIT'),
('SLTH_UNIT_MONK', 'KIND_UNIT'),
('SLTH_UNIT_CORLINDALE', 'KIND_UNIT'),
('SLTH_BUILDING_RELIQUARY', 'KIND_BUILDING');