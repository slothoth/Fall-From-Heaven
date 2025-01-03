INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_BALSERAPHS', 'LOC_CIV_BALSERAPHS_NAME', 'LOC_CIV_BALSERAPHS_DESCRIPTION', 'LOC_SLTH_CIV_BALSERAPHS_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_SOUTHAM');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('LEADER_PERPENTACH', 'LOC_LEADER_PERPENTACH_NAME', 'LEADER_DEFAULT'),
('LEADER_KEELYN', 'LOC_LEADER_KEELYN_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('LEADER_PERPENTACH', 'SLTH_CIVILIZATION_BALSERAPHS', 'LOC_CITY_BALSERAPHS_1_NAME'),
('LEADER_KEELYN', 'SLTH_CIVILIZATION_BALSERAPHS', 'LOC_CITY_BALSERAPHS_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_BUILDING_ARENA'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_BUILDING_FREAK_SHOW'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_BUILDING_HALL_OF_MIRRORS'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_UNIT_FREAK'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOKI'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_UNIT_TASKMASTER'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_UNIT_MIMIC'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_UNIT_COURTESAN'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_UNIT_HARLEQUIN'),
('SLTH_CIVILIZATION_BALSERAPHS', 'SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_ARENA', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_ARENA_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_ARENA_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_HALL_OF_MIRRORS', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_HALL_OF_MIRRORS_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_HALL_OF_MIRRORS_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_FREAK_SHOW', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_FREAK_SHOW_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_FREAK_SHOW_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FREAK', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FREAK_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_FREAK_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LOKI', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LOKI_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LOKI_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_COURTESAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_COURTESAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_COURTESAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_TASKMASTER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_TASKMASTER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_TASKMASTER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MIMIC', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MIMIC_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MIMIC_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HARLEQUIN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HARLEQUIN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HARLEQUIN_DESCRIPTION');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL', 'MODIFIER_SLTH_GRANT_TECH_AGRICULTURE'),
('SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL', 'MODIFIER_SLTH_GRANT_MANA_MIND'),
('SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL', 'MODIFIER_SLTH_GRANT_MANA_CHAOS'),
('SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL', 'MODIFIER_SLTH_GRANT_MANA_AIR'),
('SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL', 'BALSERAPH_MAGIC_GRANT_PUPPET_ABILITY');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('BALSERAPH_MAGIC_GRANT_PUPPET_ABILITY', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY_GRANCOLOMBIA_MAYA');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('BALSERAPH_MAGIC_GRANT_PUPPET_ABILITY', 'AbilityType', 'ABILITY_CAN_PUPPET');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('ABILITY_CAN_PUPPET', 'LOC_ABILITY_CAN_PUPPET_NAME', 'LOC_ABILITY_CAN_PUPPET_DESCRIPTION', '1', '1');         -- limited to magic units, need balseraph apply ability

INSERT INTO TypeTags(Type, Tag) VALUES
('ABILITY_CAN_PUPPET', 'CLASS_ADEPT');


INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_FREAK_SHOW', 'LOC_SLTH_BUILDING_FREAK_SHOW_NAME', NULL, NULL, '1', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_FREAK_SHOW_DESCRIPTION', '0', '0', '1', 'SLTH_TRAIT_CIVILIZATION_BUILDING_FREAK_SHOW', NULL, 'ADVISOR_CULTURE'),
('BUILDING_ARENA', 'LOC_BUILDING_ARENA_NAME', 'TECH_BRONZE_WORKING', NULL, '100', 'DISTRICT_CITY_CENTER', 'LOC_BUILDING_ARENA_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_ARENA', NULL, 'ADVISOR_CONQUEST'),
('SLTH_BUILDING_HALL_OF_MIRRORS', 'LOC_SLTH_BUILDING_HALL_OF_MIRRORS_NAME', 'TECH_ALTERATION', NULL, '180', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_HALL_OF_MIRRORS_DESCRIPTION', '0', '0', '1', 'SLTH_TRAIT_CIVILIZATION_BUILDING_HALL_OF_MIRRORS', NULL, 'ADVISOR_CONQUEST');

INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType, PurchaseYield, MustPurchase) VALUES
('SLTH_BUILDING_DWARF_CAGE', 'LOC_SLTH_BUILDING_DWARF_CAGE_NAME', NULL, NULL, '1', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_DWARF_CAGE_DESCRIPTION', '0', '0', '1', NULL, NULL, 'ADVISOR_CULTURE', NULL, '1'),
('SLTH_BUILDING_ELF_CAGE', 'LOC_SLTH_BUILDING_ELF_CAGE_NAME', NULL, NULL, '1', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_ELF_CAGE_DESCRIPTION', '0', '0', '1', NULL, NULL, 'ADVISOR_CULTURE', NULL, '1'),
('SLTH_BUILDING_HUMAN_CAGE', 'LOC_SLTH_BUILDING_HUMAN_CAGE_NAME', NULL, NULL, '1', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_HUMAN_CAGE_DESCRIPTION', '0', '0', '1', NULL, NULL, 'ADVISOR_CULTURE', NULL, '1'),
('SLTH_BUILDING_ORC_CAGE', 'LOC_SLTH_BUILDING_ORC_CAGE_NAME', NULL, NULL, '1', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_ORC_CAGE_DESCRIPTION', '0', '0', '1', NULL, NULL, 'ADVISOR_CULTURE', NULL, '1');

INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange) VALUES
('SLTH_BUILDING_FREAK_SHOW', 'YIELD_CULTURE', '2');

INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn) VALUES
('SLTH_BUILDING_FREAK_SHOW', 'GREAT_PERSON_CLASS_ARTIST', '1'),
('SLTH_BUILDING_DWARF_CAGE', 'GREAT_PERSON_CLASS_ARTIST', '1'),
('SLTH_BUILDING_ELF_CAGE', 'GREAT_PERSON_CLASS_ARTIST', '1'),
('SLTH_BUILDING_HUMAN_CAGE', 'GREAT_PERSON_CLASS_ARTIST', '1'),
('SLTH_BUILDING_ORC_CAGE', 'GREAT_PERSON_CLASS_ARTIST', '1');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('BUILDING_ARENA', 'BUILDING_BARRACKS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_LOKI', 'LOC_SLTH_UNIT_LOKI_NAME', '2', '2', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_LOKI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOKI', '1', NULL, NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_PUPPET', 'LOC_SLTH_UNIT_PUPPET_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_PUPPET_DESCRIPTION', NULL, '1', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_PUPPET_LOKI', 'LOC_SLTH_UNIT_PUPPET_LOKI_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_PUPPET_DESCRIPTION', NULL, '1', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_MIMIC', 'LOC_SLTH_UNIT_MIMIC_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_MIMIC_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MIMIC', '1', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_COURTESAN', 'LOC_SLTH_UNIT_COURTESAN_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_COURTESAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_COURTESAN', '1', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_TASKMASTER', 'LOC_SLTH_UNIT_TASKMASTER_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_TASKMASTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_TASKMASTER', '1', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_HARLEQUIN', 'LOC_SLTH_UNIT_HARLEQUIN_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_SLTH_UNIT_HARLEQUIN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HARLEQUIN', '1', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_HANDLING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0'),
('SLTH_UNIT_FREAK', 'LOC_SLTH_UNIT_FREAK_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_FREAK_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FREAK', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_GAMES_RECREATION', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_MIMIC', 'SLTH_UNIT_CHAMPION'),
('SLTH_UNIT_COURTESAN', 'SLTH_UNIT_SHADOW'),
('SLTH_UNIT_TASKMASTER', 'SLTH_UNIT_ASSASSIN'),
('SLTH_UNIT_HARLEQUIN', 'SLTH_UNIT_RANGER');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES
('SLTH_UNIT_HARLEQUIN', 'SLTH_BUILDING_CARNIVAL'),
('SLTH_UNIT_FREAK', 'SLTH_BUILDING_FREAK_SHOW');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_MIMIC', 'CLASS_MELEE'),
('SLTH_UNIT_MIMIC', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_COURTESAN', 'CLASS_RECON'),
('SLTH_UNIT_COURTESAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_TASKMASTER', 'CLASS_RECON'),
('SLTH_UNIT_TASKMASTER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HARLEQUIN', 'CLASS_RECON'),
('SLTH_UNIT_HARLEQUIN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_FREAK', 'CLASS_MELEE'),
('SLTH_UNIT_FREAK', 'CAN_BE_RACIALIZED');

INSERT INTO TypeProperties(Type, Name, Value, PropertyType) VALUES
('SLTH_UNIT_PUPPET', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_PUPPET_LOKI', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_BALSERAPHS', 'KIND_CIVILIZATION'),
('LEADER_PERPENTACH', 'KIND_LEADER'),
('LEADER_KEELYN', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_BALSERAPHS_COOL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_FREAK_SHOW', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_FREAK', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LOKI', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_COURTESAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_TASKMASTER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MIMIC', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HARLEQUIN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_ARENA', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_HALL_OF_MIRRORS', 'KIND_TRAIT'),
('SLTH_UNIT_MIMIC', 'KIND_UNIT'),
('SLTH_UNIT_LOKI', 'KIND_UNIT'),
('SLTH_UNIT_PUPPET', 'KIND_UNIT'),
('SLTH_UNIT_PUPPET_LOKI', 'KIND_UNIT'),
('SLTH_UNIT_COURTESAN', 'KIND_UNIT'),
('SLTH_UNIT_TASKMASTER', 'KIND_UNIT'),
('SLTH_UNIT_HARLEQUIN', 'KIND_UNIT'),
('SLTH_UNIT_FREAK', 'KIND_UNIT'),
('SLTH_BUILDING_FREAK_SHOW', 'KIND_BUILDING'),
('SLTH_BUILDING_DWARF_CAGE', 'KIND_BUILDING'),
('SLTH_BUILDING_ELF_CAGE', 'KIND_BUILDING'),
('SLTH_BUILDING_HUMAN_CAGE', 'KIND_BUILDING'),
('SLTH_BUILDING_ORC_CAGE', 'KIND_BUILDING'),
('SLTH_BUILDING_HALL_OF_MIRRORS', 'KIND_BUILDING'),
('ABILITY_CAN_PUPPET', 'KIND_ABILITY');