INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_KURIOTATES', 'LOC_CIV_KURIOTATES_NAME', 'LOC_CIV_KURIOTATES_DESCRIPTION', 'LOC_SLTH_CIV_KURIOTATES_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_MEDIT');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('LEADER_CARDITH', 'LOC_LEADER_CARDITH_NAME', 'LEADER_DEFAULT');


INSERT INTO	StartBiasTerrains                                       -- minimise desert/tundra/snow as cap matters more
		(CivilizationType,			TerrainType,			        Tier	)
VALUES	('SLTH_CIVILIZATION_KURIOTATES',	'TERRAIN_GRASS',		5	),
        ('SLTH_CIVILIZATION_KURIOTATES',	'TERRAIN_PLAINS',		5	);

INSERT INTO	StartBiasRivers(CivilizationType,	        Tier)
VALUES	                   ('SLTH_CIVILIZATION_KURIOTATES',	5);

INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('LEADER_CARDITH', 'SLTH_CIVILIZATION_KURIOTATES', 'LOC_CITY_KURIOTATES_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_BUILDING_TAILOR'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_BUILDING_JEWELER'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_UNIT_EURABATRES'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_UNIT_HERNE'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_ARCHER'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_LANCER'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_CHARGER'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_UNIT_AIRSHIP'),
('SLTH_CIVILIZATION_KURIOTATES', 'SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('NULL_CIVILIZATION_KURIOTATES', 'LOC_SLTH_NULL_CIVILIZATION_KURIOTATES_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_TAILOR', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_TAILOR_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_TAILOR_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_JEWELER', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_JEWELER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_JEWELER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HERNE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HERNE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HERNE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_EURABATRES', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_EURABATRES_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_EURABATRES_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_ARCHER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_ARCHER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_ARCHER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_LANCER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_LANCER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_LANCER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_CHARGER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_CHARGER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_CHARGER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_AIRSHIP', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_AIRSHIP_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_AIRSHIP_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL', 'MODIFIER_SLTH_GRANT_TECH_AGRICULTURE'),
('SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL', 'MODIFIER_SLTH_GRANT_MANA_SUN'),
('SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL', 'MODIFIER_SLTH_LARGE_MORE_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL', 'MODIFIER_SLTH_BUILDING_PALACE_KURIOTATES_ADJUST_HOUSING'),
('SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL', 'MODIFIER_SLTH_GRANT_MANA_SPIRIT'),
('SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL', 'MODIFIER_SLTH_GRANT_MANA_WATER');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_SLTH_BUILDING_PALACE_KURIOTATES_ADJUST_HOUSING', 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING', '0', '0', NULL),
('MODIFIER_SLTH_GRANT_JEWELS', 'MODIFIER_FREE_RESOURCE_IN_CAPITAL', '0', '0', NULL),
('MODIFIER_SLTH_GRANT_FINE_CLOTHES', 'MODIFIER_FREE_RESOURCE_IN_CAPITAL', '0', '0', NULL);
INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_SLTH_BUILDING_PALACE_KURIOTATES_ADJUST_HOUSING', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_GRANT_JEWELS', 'ResourceType', 'ARGTYPE_IDENTITY', 'RESOURCE_JEWELS'),
('MODIFIER_SLTH_GRANT_JEWELS', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_GRANT_FINE_CLOTHES', 'ResourceType', 'ARGTYPE_IDENTITY', 'RESOURCE_FINE_CLOTHES'),
('MODIFIER_SLTH_GRANT_FINE_CLOTHES', 'Amount', 'ARGTYPE_IDENTITY', '1');
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_KURIOTATES_STABLE', 'BUILDING_STABLE');

INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_JEWELER', 'LOC_SLTH_BUILDING_JEWELER_NAME', 'TECH_SMELTING', NULL, '120', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_JEWELER_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_JEWELER', NULL, 'ADVISOR_GENERIC'),
('SLTH_BUILDING_TAILOR', 'LOC_SLTH_BUILDING_TAILOR_NAME', 'TECH_CRAFTING', NULL, '140', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_TAILOR_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_TAILOR', NULL, 'ADVISOR_GENERIC');

INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
('SLTH_BUILDING_JEWELER', 'MODIFIER_SLTH_GRANT_JEWELS'),
('SLTH_BUILDING_TAILOR', 'MODIFIER_SLTH_BUILDING_TAILOR_GRANT_FINE_CLOTHES');


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_CENTAUR_ARCHER', 'LOC_SLTH_UNIT_CENTAUR_ARCHER_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CENTAUR_ARCHER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_ARCHER', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_CENTAUR_CHARGER', 'LOC_SLTH_UNIT_CENTAUR_CHARGER_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CENTAUR_CHARGER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_CHARGER', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_CENTAUR', 'LOC_SLTH_UNIT_CENTAUR_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_CENTAUR_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_CENTAUR_LANCER', 'LOC_SLTH_UNIT_CENTAUR_LANCER_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_CENTAUR_LANCER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_LANCER', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_HERNE', 'LOC_SLTH_UNIT_HERNE_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_HERNE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HERNE', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_EURABATRES', 'LOC_SLTH_UNIT_EURABATRES_NAME', '2', '3', '111', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_EURABATRES_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_EURABATRES', '1', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO Units_Presentation(UnitType, UIFlagOffset) VALUES ('SLTH_UNIT_EURABATRES', '20');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_CENTAUR_CHARGER', 'SLTH_UNIT_CHARIOT'),
('SLTH_UNIT_CENTAUR_ARCHER', 'SLTH_UNIT_HORSE_ARCHER'),
('SLTH_UNIT_CENTAUR', 'SLTH_UNIT_HORSEMAN'),
('SLTH_UNIT_CENTAUR_LANCER', 'SLTH_UNIT_KNIGHT');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('RACE_CENTAUR', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_CENTAUR_CHARGER', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_CENTAUR_LANCER', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_CENTAUR_ARCHER', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_CENTAUR', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_HERNE', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_EURABATRES', 'CLASS_BEAST'),
('SLTH_UNIT_CENTAUR_CHARGER', 'RACE_CENTAUR'),
('SLTH_UNIT_CENTAUR_LANCER', 'RACE_CENTAUR'),
('SLTH_UNIT_CENTAUR_ARCHER', 'RACE_CENTAUR'),
('SLTH_UNIT_CENTAUR', 'RACE_CENTAUR'),
('SLTH_UNIT_HERNE', 'RACE_CENTAUR');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_KURIOTATES', 'KIND_CIVILIZATION'),
('SLTH_TRAIT_CIVILIZATION_KURIOTATES_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_KURIOTATES', 'KIND_TRAIT'),
('LEADER_CARDITH', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_TAILOR', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_JEWELER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HERNE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_EURABATRES', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_ARCHER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_LANCER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_CHARGER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_AIRSHIP', 'KIND_TRAIT'),
('SLTH_UNIT_CENTAUR_ARCHER', 'KIND_UNIT'),
('SLTH_UNIT_CENTAUR', 'KIND_UNIT'),
('SLTH_UNIT_CENTAUR_LANCER', 'KIND_UNIT'),
('SLTH_UNIT_CENTAUR_CHARGER', 'KIND_UNIT'),
('SLTH_UNIT_HERNE', 'KIND_UNIT'),
('SLTH_BUILDING_JEWELER', 'KIND_BUILDING'),
('SLTH_BUILDING_TAILOR', 'KIND_BUILDING'),
('SLTH_UNIT_EURABATRES', 'KIND_UNIT');