INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_GRIGORI', 'LOC_CIV_GRIGORI_NAME', 'LOC_CIV_GRIGORI_DESCRIPTION', 'LOC_SLTH_CIV_GRIGORI_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_MEDIT');

INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_CASSIEL', 'LOC_SLTH_LEADER_CASSIEL_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_CASSIEL', 'SLTH_CIVILIZATION_GRIGORI', 'LOC_CITY_GRIGORI_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_GRIGORI', 'SLTH_TRAIT_CIVILIZATION_BUILDING_TAVERN_GRIGORI'),
('SLTH_CIVILIZATION_GRIGORI', 'SLTH_TRAIT_CIVILIZATION_BUILDING_ADVENTURERS_GUILD'),
('SLTH_CIVILIZATION_GRIGORI', 'SLTH_TRAIT_CIVILIZATION_UNIT_ADVENTURER'),
('SLTH_CIVILIZATION_GRIGORI', 'SLTH_TRAIT_CIVILIZATION_UNIT_GRIGORI_MEDIC'),
('SLTH_CIVILIZATION_GRIGORI', 'SLTH_TRAIT_CIVILIZATION_UNIT_DRAGON_SLAYER'),
('SLTH_CIVILIZATION_GRIGORI', 'SLTH_TRAIT_CIVILIZATION_UNIT_LUONNOTAR'),
('SLTH_CIVILIZATION_GRIGORI', 'SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('NULL_CIVILIZATION_GRIGORI', 'LOC_SLTH_NULL_CIVILIZATION_GRIGORI_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_TAVERN_GRIGORI', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_TAVERN_GRIGORI_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_TAVERN_GRIGORI_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_ADVENTURERS_GUILD', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_ADVENTURERS_GUILD_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_ADVENTURERS_GUILD_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GRIGORI_MEDIC', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GRIGORI_MEDIC_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GRIGORI_MEDIC_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ADVENTURER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ADVENTURER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ADVENTURER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DRAGON_SLAYER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DRAGON_SLAYER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_DRAGON_SLAYER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LUONNOTAR', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LUONNOTAR_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LUONNOTAR_DESCRIPTION');

-- Need to implement Adventurers
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL', 'MODIFIER_SLTH_GRANT_TECH_CRAFTING'),
('SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL', 'MODIFIER_SLTH_GRANT_MANA_SPIRIT'),
('SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL', 'MODIFIER_SLTH_GRANT_MANA_ENCHANTMENT'),
('SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL', 'MODIFIER_SLTH_GRANT_MANA_WATER'),
('SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL', 'MODIFIER_PALACE_GRIGORI_INCREASE_GPP_MULT'),
('SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL', 'MODIFIER_UNITCLASS_ADVENTURER_INCREASE_GPP_POINT_BONUS');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_PALACE_GRIGORI_INCREASE_GPP_MULT', 'MODIFIER_PLAYER_CAPITAL_CITY_GPP_MULT', '0', '0', NULL),
('MODIFIER_UNITCLASS_ADVENTURER_INCREASE_GPP_POINT_BONUS', 'MODIFIER_CITY_INCREASE_GREAT_PERSON_POINT_BONUS', '0', '0', NULL),
('GRANT_EXPERIENCE_ABILITY_SMALL_ADVENT_GUILD', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', NULL),
('MODIFIER_ADVENTURERS_GUILD_INCREASE_GPP_MULT', 'MODIFIER_CITY_INCREASE_GREAT_PERSON_POINT_BONUS', '0', '0', NULL);
INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_PALACE_GRIGORI_INCREASE_GPP_MULT', 'Amount', 'ARGTYPE_IDENTITY', '15'),
('MODIFIER_UNITCLASS_ADVENTURER_INCREASE_GPP_POINT_BONUS', 'GreatPersonClassType', 'ARGTYPE_IDENTITY', 'GREAT_PERSON_CLASS_WRITER'),
('MODIFIER_UNITCLASS_ADVENTURER_INCREASE_GPP_POINT_BONUS', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('GRANT_EXPERIENCE_ABILITY_SMALL_ADVENT_GUILD', 'AbilityType', 'ARGTYPE_IDENTITY', 'GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD'),
('MODIFIER_ADVENTURERS_GUILD_INCREASE_GPP_MULT', 'Amount', 'ARGTYPE_IDENTITY', '25');

INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('BUILDING_GUILDHALL', 'LOC_SLTH_BUILDING_ADVENTURERS_GUILD_NAME', NULL, 'CIVIC_CURRENCY', '120', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_ADVENTURERS_GUILD_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_ADVENTURERS_GUILD', NULL, 'ADVISOR_CONQUEST'),
('SLTH_BUILDING_TAVERN_GRIGORI', 'LOC_SLTH_BUILDING_TAVERN_GRIGORI_NAME', NULL, 'CIVIC_MERCANTILISM', '250', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_TAVERN_GRIGORI_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_TAVERN_GRIGORI', NULL, 'ADVISOR_GENERIC'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_PAGAN_TEMPLE', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_GRIGORI', NULL, 'ADVISOR_RELIGIOUS'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_KILMORPH', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_GRIGORI', NULL, 'ADVISOR_RELIGIOUS'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_LEAVES', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_GRIGORI', NULL, 'ADVISOR_RELIGIOUS'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_EMPYREAN', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_GRIGORI', NULL, 'ADVISOR_RELIGIOUS'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_ORDER', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_GRIGORI', NULL, 'ADVISOR_RELIGIOUS'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_OVERLORDS', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_GRIGORI', NULL, 'ADVISOR_RELIGIOUS'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_VEIL', 'LOC_SLTH_BUILDING_NULL_NAME', NULL, NULL, '500', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_NULLDESCRIPTION', '0', '0', '0', 'NULL_CIVILIZATION_GRIGORI', NULL, 'ADVISOR_RELIGIOUS');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_TAVERN_GRIGORI', 'SLTH_BUILDING_TAVERN'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_PAGAN_TEMPLE', 'BUILDING_SHRINE'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_KILMORPH', 'BUILDING_WAT'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_LEAVES', 'BUILDING_SANCTUARY'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_EMPYREAN', 'BUILDING_GURDWARA'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_ORDER', 'BUILDING_CATHEDRAL'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_OVERLORDS', 'BUILDING_MOSQUE'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_VEIL', 'BUILDING_STUPA');

INSERT INTO Building_GreatPersonPoints(BuildingType, GreatPersonClassType, PointsPerTurn) VALUES
('BUILDING_GUILDHALL', 'GREAT_PERSON_CLASS_WRITER', '2'),
('SLTH_BUILDING_TAVERN_GRIGORI', 'GREAT_PERSON_CLASS_WRITER', '1');             -- could just get rid of custom tavern and give GPP on taverns. But need to remove Great Bard points, is that even possible?

INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
('BUILDING_GUILDHALL', 'MODIFIER_ADVENTURERS_GUILD_INCREASE_GPP_MULT'),
('BUILDING_GUILDHALL', 'GRANT_EXPERIENCE_ABILITY_SMALL_ADVENT_GUILD'),
('SLTH_BUILDING_TAVERN_GRIGORI', 'MODIFIER_SLTH_BUILDING_TAVERN_ADJUST_TRADE_ROUTE_CAPACITY'),
('SLTH_BUILDING_TAVERN_GRIGORI', 'MODIFIER_SLTH_BUILDING_TAVERN_TRADE_ROUTE_YIELD_MULT');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'LOC_GRANT_EXPERIENCE_ABILITY_NAME', 'LOC_GRANT_EXPERIENCE_ABILITY_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'GRANT_EXPERIENCE_SMALL');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_ADVENTURER', 'LOC_SLTH_UNIT_ADVENTURER_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_ADVENTURER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ADVENTURER', '1', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_DRAGON_SLAYER', 'LOC_SLTH_UNIT_DRAGON_SLAYER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_DRAGON_SLAYER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DRAGON_SLAYER', '1', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_LUONNOTAR', 'LOC_SLTH_UNIT_LUONNOTAR_NAME', '2', '1', '48', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_LUONNOTAR_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LUONNOTAR', '1', 'PROMOTION_CLASS_DISCIPLE', 'TECH_STRENGTH_OF_WILL', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0'),
('SLTH_UNIT_GRIGORI_MEDIC', 'LOC_SLTH_UNIT_GRIGORI_MEDIC_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_GRIGORI_MEDIC_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GRIGORI_MEDIC', '1', 'PROMOTION_CLASS_MELEE', 'TECH_MEDICINE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_DRAGON_SLAYER', 'SLTH_UNIT_CHAMPION'),
('SLTH_UNIT_LUONNOTAR', 'SLTH_UNIT_DRUID');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES
('SLTH_UNIT_GRIGORI_MEDIC', 'SLTH_BUILDING_INFIRMARY'),
('SLTH_UNIT_DRAGON_SLAYER', 'BUILDING_BARRACKS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_DRAGON_SLAYER', 'CLASS_MELEE'),
('SLTH_UNIT_DRAGON_SLAYER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_LUONNOTAR', 'CLASS_DISCIPLE'),
('SLTH_UNIT_LUONNOTAR', 'CAN_BE_RACIALIZED'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_MELEE'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_RANGED'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_RECON'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_LIGHT_CAVALRY'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_SIEGE'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_ADEPT'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_DISCIPLE'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_ANIMAL'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'CLASS_BEAST');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_GRIGORI', 'KIND_CIVILIZATION'),
('SLTH_LEADER_CASSIEL', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_GRIGORI_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_GRIGORI', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_TAVERN_GRIGORI', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GRIGORI_MEDIC', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_ADVENTURERS_GUILD', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ADVENTURER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_DRAGON_SLAYER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LUONNOTAR', 'KIND_TRAIT'),
('SLTH_UNIT_ADVENTURER', 'KIND_UNIT'),
('SLTH_UNIT_DRAGON_SLAYER', 'KIND_UNIT'),
('SLTH_UNIT_LUONNOTAR', 'KIND_UNIT'),
('BUILDING_GUILDHALL', 'KIND_BUILDING'),
('SLTH_BUILDING_TAVERN_GRIGORI', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_PAGAN_TEMPLE', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_KILMORPH', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_LEAVES', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_EMPYREAN', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_ORDER', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_OVERLORDS', 'KIND_BUILDING'),
('SLTH_BUILDING_NULL_CIVILIZATION_GRIGORI_TEMPLE_OF_THE_VEIL', 'KIND_BUILDING'),
('GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD', 'KIND_ABILITY');