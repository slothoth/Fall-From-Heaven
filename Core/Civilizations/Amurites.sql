INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_AMURITES', 'LOC_CIV_AMURITES_NAME', 'LOC_CIV_AMURITES_DESCRIPTION', 'LOC_SLTH_CIV_AMURITES_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_VALLEDIA', 'LOC_SLTH_LEADER_VALLEDIA_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_DAIN', 'LOC_SLTH_LEADER_DAIN_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_VALLEDIA', 'SLTH_CIVILIZATION_AMURITES', 'LOC_CITY_AMURITES_1_NAME'),
('SLTH_LEADER_DAIN', 'SLTH_CIVILIZATION_AMURITES', 'LOC_CITY_AMURITES_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_AMURITES', 'SLTH_TRAIT_CIVILIZATION_BUILDING_CAVE_OF_ANCESTORS'),
('SLTH_CIVILIZATION_AMURITES', 'SLTH_TRAIT_CIVILIZATION_UNIT_GOVANNON'),
('SLTH_CIVILIZATION_AMURITES', 'SLTH_TRAIT_CIVILIZATION_UNIT_SWORDSMAN'),
('SLTH_CIVILIZATION_AMURITES', 'SLTH_TRAIT_CIVILIZATION_UNIT_CHANTER'),
('SLTH_CIVILIZATION_AMURITES', 'SLTH_TRAIT_CIVILIZATION_UNIT_FIREBOW'),
('SLTH_CIVILIZATION_AMURITES', 'SLTH_TRAIT_CIVILIZATION_UNIT_WIZARD'),
('SLTH_CIVILIZATION_AMURITES', 'SLTH_TRAIT_CIVILIZATION_AMURITES_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_AMURITES_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_AMURITES_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_AMURITES_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_CAVE_OF_ANCESTORS', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_CAVE_OF_ANCESTORS_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_CAVE_OF_ANCESTORS_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GOVANNON', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GOVANNON_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GOVANNON_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_SWORDSMAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_SWORDSMAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_SWORDSMAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CHANTER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CHANTER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CHANTER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FIREBOW', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FIREBOW_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FIREBOW_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WIZARD', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WIZARD_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WIZARD_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_AMURITES_COOL', 'MODIFIER_SLTH_GRANT_TECH_ANCIENT_CHANTS'),
('SLTH_TRAIT_CIVILIZATION_AMURITES_COOL', 'MODIFIER_SLTH_GRANT_MANA_METAMAGIC'),
('SLTH_TRAIT_CIVILIZATION_AMURITES_COOL', 'MODIFIER_SLTH_GRANT_MANA_FIRE'),
('SLTH_TRAIT_CIVILIZATION_AMURITES_COOL', 'MODIFIER_SLTH_GRANT_MANA_BODY');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_WIZARD', 'LOC_SLTH_UNIT_WIZARD_NAME', '2', '1', '4', '4', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_WIZARD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WIZARD', '1', 'PROMOTION_CLASS_ADEPT', 'SLTH_TECH_SORCERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_FIREBOW', 'LOC_SLTH_UNIT_FIREBOW_NAME', '2', '1', '5', '5', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_FIREBOW_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FIREBOW', '1', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_BOWYERS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_CHANTER', 'LOC_SLTH_UNIT_CHANTER_NAME', '2', '2', '5', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CHANTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CHANTER', '1', 'PROMOTION_CLASS_RECON', 'SLTH_TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_GOVANNON', 'LOC_SLTH_UNIT_GOVANNON_NAME', '2', '1', '5', '5', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '480', '0', 'LOC_SLTH_UNIT_GOVANNON_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GOVANNON', '1', 'PROMOTION_CLASS_ADEPT', 'SLTH_TECH_ARCANE_LORE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_WIZARD', 'SLTH_UNIT_MAGE'),
('SLTH_UNIT_FIREBOW', 'SLTH_UNIT_LONGBOWMAN'),
('SLTH_UNIT_CHANTER', 'SLTH_UNIT_ASSASSIN'),
('SLTH_UNIT_GOVANNON', 'CLASS_ADEPT');


INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_WIZARD', 'CLASS_ADEPT'),
('SLTH_UNIT_FIREBOW', 'CLASS_RANGED'),
('SLTH_UNIT_CHANTER', 'CLASS_RECON');

-- work needed to for custom functions of CoA
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_CAVE_OF_ANCESTORS', 'LOC_SLTH_BUILDING_CAVE_OF_ANCESTORS_NAME', 'SLTH_TECH_SORCERY', NULL, '120', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_CAVE_OF_ANCESTORS_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_CAVE_OF_ANCESTORS', NULL, 'ADVISOR_TECHNOLOGY');


INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_AMURITES', 'KIND_CIVILIZATION'),
('SLTH_LEADER_VALLEDIA', 'KIND_LEADER'),
('SLTH_LEADER_DAIN', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_AMURITES_COOL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_CAVE_OF_ANCESTORS', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GOVANNON', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_SWORDSMAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CHANTER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FIREBOW', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WIZARD', 'KIND_TRAIT'),
('SLTH_UNIT_WIZARD', 'KIND_UNIT'),
('SLTH_UNIT_FIREBOW', 'KIND_UNIT'),
('SLTH_UNIT_CHANTER', 'KIND_UNIT'),
('SLTH_UNIT_GOVANNON', 'KIND_UNIT'),
('SLTH_BUILDING_CAVE_OF_ANCESTORS', 'KIND_BUILDING');