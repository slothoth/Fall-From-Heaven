INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_SHEAIM', 'LOC_CIV_SHEAIM_NAME', 'LOC_CIV_SHEAIM_DESCRIPTION', 'LOC_SLTH_CIV_SHEAIM_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_SOUTHAM');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_TEBRYN', 'LOC_SLTH_LEADER_TEBRYN_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_OS-GABELLA', 'LOC_SLTH_LEADER_OS_GABELLA_NAME', 'LEADER_DEFAULT');

INSERT INTO	StartBiasTerrains
		(CivilizationType,			TerrainType,			Tier	)
VALUES	('SLTH_CIVILIZATION_SHEAIM',	'TERRAIN_PLAINS',		5		);

INSERT INTO	StartBiasFeatures
		(CivilizationType,			FeatureType,			Tier	)
VALUES	('SLTH_CIVILIZATION_SHEAIM',	'FEATURE_JUNGLE',	5		);          -- feels bad but is accurate

INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_TEBRYN', 'SLTH_CIVILIZATION_SHEAIM', 'LOC_CITY_SHEAIM_1_NAME'),
('SLTH_LEADER_OS-GABELLA', 'SLTH_CIVILIZATION_SHEAIM', 'LOC_CITY_SHEAIM_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_SHEAIM', 'SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL'),
('SLTH_CIVILIZATION_SHEAIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_PLANAR_GATE'),
('SLTH_CIVILIZATION_SHEAIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_ABASHI'),
('SLTH_CIVILIZATION_SHEAIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_PYRE_ZOMBIE'),
('SLTH_CIVILIZATION_SHEAIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_EATER_OF_DREAMS');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL_DESCRIPTION'),
('NULL_CIVILIZATION_SHEAIM', 'LOC_SLTH_NULL_CIVILIZATION_SHEAIM_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_PLANAR_GATE', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_PLANAR_GATE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_PLANAR_GATE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ABASHI', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ABASHI_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ABASHI_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_PYRE_ZOMBIE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_PYRE_ZOMBIE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_PYRE_ZOMBIE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_EATER_OF_DREAMS', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_EATER_OF_DREAMS_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_EATER_OF_DREAMS_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_SLTH_GRANT_TECH_ANCIENT_CHANTS'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_BAN_SLTH_UNIT_BERSERKER'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_BAN_SLTH_UNIT_IMMORTAL'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_BAN_SLTH_UNIT_PHALANX'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_BAN_SLTH_UNIT_CHAMPION'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_DEATH'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_SLTH_SMALL_ADJUST_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_CHAOS'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_FIRE'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'ALLOW_ELEGY');

INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_SHEAIM_TRAINING_YARD', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_SHEAIM', NULL, 'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_ABASHI', 'LOC_SLTH_UNIT_ABASHI_NAME', '2', '3', '101', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_ABASHI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ABASHI', '1', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_PYRE_ZOMBIE', 'LOC_SLTH_UNIT_PYRE_ZOMBIE_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_PYRE_ZOMBIE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_PYRE_ZOMBIE', '1', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'LOC_SLTH_UNIT_EATER_OF_DREAMS_NAME', '2', '1', '24', '5', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '1', 'LOC_SLTH_UNIT_EATER_OF_DREAMS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_EATER_OF_DREAMS', '1', 'PROMOTION_CLASS_ADEPT', 'TECH_STRENGTH_OF_WILL', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_PYRE_ZOMBIE', 'SLTH_UNIT_SWORDSMAN'),
('SLTH_UNIT_EATER_OF_DREAMS', 'SLTH_UNIT_ARCHMAGE');

-- spawned from sheaim planar gates
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase) VALUES
('SLTH_UNIT_MINOTAUR', 'LOC_SLTH_UNIT_MINOTAUR_NAME', '2', '1', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_MINOTAUR_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', 'TECH_MITHRIL_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1'),
('SLTH_UNIT_MOBIUS_WITCH', 'LOC_SLTH_UNIT_MOBIUS_WITCH_NAME', '2', '1', '19', '24', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '1', 'LOC_SLTH_UNIT_MOBIUS_WITCH_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_TECHNOLOGY', '0', NULL, '1'),
('SLTH_UNIT_REVELERS', 'LOC_SLTH_UNIT_REVELERS_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_REVELERS_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RECON', 'TECH_MATHEMATICS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1'),
('SLTH_UNIT_TAR_DEMON', 'LOC_SLTH_UNIT_TAR_DEMON_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_TAR_DEMON_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_CORRUPTION_OF_SPIRIT', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1'),
('SLTH_UNIT_SUCCUBUS', 'LOC_SLTH_UNIT_SUCCUBUS_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_SUCCUBUS_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', 'TECH_SANITATION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Improvement_ValidBuildUnits(UnitType, ImprovementType, ConsumesCharge) VALUES
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_AIR', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_BODY', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_CHAOS', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_DEATH', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_EARTH', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_ENCHANTMENT', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_ENTROPY', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_FIRE', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_LAW', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_LIFE', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_METAMAGIC', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_MIND', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_NATURE', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_SPIRIT', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_WATER', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_SHADOW', '0'),
('SLTH_UNIT_EATER_OF_DREAMS', 'IMPROVEMENT_MANA_SUN', '0');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_ABASHI', 'CLASS_BEAST'),
('SLTH_UNIT_PYRE_ZOMBIE', 'CLASS_MELEE'),
('SLTH_UNIT_EATER_OF_DREAMS', 'CLASS_ADEPT'),
('SLTH_UNIT_PYRE_ZOMBIE', 'IS_UNDEAD'),
('SLTH_UNIT_EATER_OF_DREAMS', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_MINOTAUR', 'CLASS_MELEE'),
('SLTH_UNIT_MOBIUS_WITCH', 'CLASS_ADEPT'),
('SLTH_UNIT_SUCCUBUS', 'CLASS_MELEE'),
('SLTH_UNIT_TAR_DEMON', 'CLASS_DISCIPLE'),
('SLTH_UNIT_SUCCUBUS', 'RACE_DEMON'),
('SLTH_UNIT_TAR_DEMON', 'RACE_DEMON');


INSERT INTO Projects(ProjectType, Name, ShortName, Cost, PrereqTech, PrereqCivic, UnlocksFromEffect) VALUES
('PROJECT_ELEGY_OF_THE_SHEAIM', 'LOC_PROJECT_ELEGY_OF_THE_SHEAIM_NAME', 'LOC_PROJECT_ELEGY_OF_THE_SHEAIM_SHORT', '600', NULL, 'CIVIC_WAY_OF_THE_WICKED', '1');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES ('ALLOW_ELEGY', 'MODIFIER_PLAYER_ALLOW_PROJECT_CHINA');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES ('ALLOW_ELEGY', 'ProjectType', 'PROJECT_ELEGY_OF_THE_SHEAIM');

INSERT INTO Units_Presentation(UnitType, UIFlagOffset) VALUES ('SLTH_UNIT_ABASHI', '20');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_TRAIT_CIVILIZATION_BUILDING_PLANAR_GATE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ABASHI', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_PYRE_ZOMBIE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_EATER_OF_DREAMS', 'KIND_TRAIT'),
('SLTH_CIVILIZATION_SHEAIM', 'KIND_CIVILIZATION'),
('SLTH_LEADER_TEBRYN', 'KIND_LEADER'),
('SLTH_LEADER_OS-GABELLA', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_SHEAIM_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_SHEAIM', 'KIND_TRAIT'),
('SLTH_UNIT_PYRE_ZOMBIE', 'KIND_UNIT'),
('SLTH_UNIT_ABASHI', 'KIND_UNIT'),
('SLTH_UNIT_EATER_OF_DREAMS', 'KIND_UNIT'),
('SLTH_BUILDING_NULL_CIVILIZATION_SHEAIM_TRAINING_YARD', 'KIND_BUILDING'),
('SLTH_UNIT_MINOTAUR', 'KIND_UNIT'),
('SLTH_UNIT_MOBIUS_WITCH', 'KIND_UNIT'),
('SLTH_UNIT_REVELERS', 'KIND_UNIT'),
('SLTH_UNIT_SUCCUBUS', 'KIND_UNIT'),
('SLTH_UNIT_TAR_DEMON', 'KIND_UNIT'),
('PROJECT_ELEGY_OF_THE_SHEAIM', 'KIND_PROJECT');