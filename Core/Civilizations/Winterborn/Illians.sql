INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_ILLIANS', 'LOC_CIV_ILLIANS_NAME', 'LOC_CIV_ILLIANS_DESCRIPTION', 'LOC_SLTH_CIV_ILLIANS_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_AURIC', 'LOC_SLTH_LEADER_AURIC_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_AURIC', 'SLTH_CIVILIZATION_ILLIANS', 'LOC_CITY_ILLIANS_1_NAME');

INSERT INTO	StartBiasTerrains (CivilizationType,			TerrainType,			        Tier	)
VALUES	                      ('SLTH_CIVILIZATION_ILLIANS',	'TERRAIN_TUNDRA',		    2	),
                              ('SLTH_CIVILIZATION_ILLIANS',	'TERRAIN_TUNDRA_HILLS',		2	),
                              ('SLTH_CIVILIZATION_ILLIANS',	'TERRAIN_SNOW',		        2	),
                              ('SLTH_CIVILIZATION_ILLIANS',	'TERRAIN_SNOW_HILLS',		2	);

INSERT INTO	StartBiasFeatures (CivilizationType,			    FeatureType,			Tier	)
VALUES	                      ('SLTH_CIVILIZATION_ILLIANS',	'FEATURE_FOREST',	        3		);


INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_ILLIANS', 'SLTH_TRAIT_CIVILIZATION_BUILDING_TEMPLE_OF_THE_HAND'),
('SLTH_CIVILIZATION_ILLIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_HIGH_PRIEST_OF_WINTER'),
('SLTH_CIVILIZATION_ILLIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_WILBOMAN'),
('SLTH_CIVILIZATION_ILLIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_JAVELIN_THROWER'),
('SLTH_CIVILIZATION_ILLIANS', 'SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL'),
('SLTH_CIVILIZATION_ILLIANS', 'SLTH_TRAIT_WINTERBORN');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_TEMPLE_OF_THE_HAND', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_TEMPLE_OF_THE_HAND_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_TEMPLE_OF_THE_HAND_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WILBOMAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WILBOMAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WILBOMAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_JAVELIN_THROWER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_JAVELIN_THROWER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_JAVELIN_THROWER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HIGH_PRIEST_OF_WINTER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HIGH_PRIEST_OF_WINTER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HIGH_PRIEST_OF_WINTER_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'MODIFIER_SLTH_GRANT_TECH_EXPLORATION'),
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'MODIFIER_SLTH_GRANT_MANA_ICE'),
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'MODIFIER_SLTH_GRANT_MANA_ENCHANTMENT'),
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'MODIFIER_SLTH_GRANT_MANA_LAW'),
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'MODIFIER_SLTH_ILIAN_BONUS_FOOD_SNOW'),
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'ALLOW_SAMHAIN'),
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'ALLOW_STIR_FROM_SLUMBER');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_SLTH_ILIAN_BONUS_FOOD_SNOW', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', '0', '0', 'FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW_REQS'),     -- borrowed from Racials
('MODIFIER_THE_DRAW_HALF_HEALTH', 'MODIFIER_PLAYER_UNITS_ADJUST_DAMAGE', '1', '1', NULL),
('ALLOW_SAMHAIN', 'MODIFIER_PLAYER_ALLOW_PROJECT_CHINA', '0', '0', NULL),
('ALLOW_STIR_FROM_SLUMBER', 'MODIFIER_PLAYER_ALLOW_PROJECT_CHINA', '0', '0', NULL);

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, OwnerRequirementSetId) VALUES
('GRANT_AURIC_ASCENDED', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', '1', '1', 'SLTH_PLAYER_HAS_CAPITAL'),
('GRANT_THREE_PRIESTS_OF_WINTER', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', '1', '1', 'SLTH_PLAYER_HAS_CAPITAL'),
('GRANT_DRIFA', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', '1', '1', 'SLTH_PLAYER_HAS_CAPITAL');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('MODIFIER_SLTH_ILIAN_BONUS_FOOD_SNOW', 'YieldType', 'YIELD_FARM'),
('MODIFIER_SLTH_ILIAN_BONUS_FOOD_SNOW', 'Amount', '2'),
('MODIFIER_THE_DRAW_HALF_HEALTH', 'Amount', '50'),
('GRANT_AURIC_ASCENDED', 'UnitType', 'SLTH_UNIT_AURIC_ASCENDED'),
('GRANT_AURIC_ASCENDED', 'Amount', '1'),
('GRANT_AURIC_ASCENDED', 'AllowUniqueOverride', '0'),
('GRANT_THREE_PRIESTS_OF_WINTER', 'UnitType', 'SLTH_UNIT_PRIEST_OF_WINTER'),
('GRANT_THREE_PRIESTS_OF_WINTER', 'Amount', '3'),
('GRANT_THREE_PRIESTS_OF_WINTER', 'AllowUniqueOverride', '0'),
('GRANT_DRIFA', 'UnitType', 'SLTH_UNIT_DRIFA'),
('GRANT_DRIFA', 'Amount', '1'),
('GRANT_DRIFA', 'AllowUniqueOverride', '0'),
('ALLOW_SAMHAIN', 'ProjectType', 'PROJECT_SAMHAIN'),
('ALLOW_STIR_FROM_SLUMBER', 'ProjectType', 'PROJECT_STIR_FROM_SLUMBER');


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase) VALUES
('SLTH_UNIT_WILBOMAN', 'LOC_SLTH_UNIT_WILBOMAN_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_WILBOMAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WILBOMAN', '1', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '0'),
('SLTH_UNIT_HIGH_PRIEST_OF_WINTER', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_WINTER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_WINTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HIGH_PRIEST_OF_WINTER', '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_THEOLOGY', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1'),
('SLTH_UNIT_AURIC_ASCENDED', 'LOC_SLTH_UNIT_AURIC_ASCENDED_NAME', '2', '3', '144', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_AURIC_ASCENDED_DESCRIPTION', NULL, '1', NULL, 'TECH_OMNISCIENCE', NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '1', NULL, '1'),
('SLTH_UNIT_DRIFA', 'LOC_SLTH_UNIT_DRIFA_NAME', '2', '3', '68', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_DRIFA_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_DIVINE_ESSENCE', '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_HIGH_PRIEST_OF_WINTER', 'CLASS_DISCIPLE'),
('SLTH_UNIT_HIGH_PRIEST_OF_WINTER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_WILBOMAN', 'CLASS_MELEE');

INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_TEMPLE_OF_THE_HAND', 'LOC_SLTH_BUILDING_TEMPLE_OF_THE_HAND_NAME', NULL, 'CIVIC_MYSTICISM', '100', 'DISTRICT_HOLY_SITE', 'LOC_SLTH_BUILDING_TEMPLE_OF_THE_HAND_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_TEMPLE_OF_THE_HAND', '1', 'ADVISOR_CULTURE');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_TEMPLE_OF_THE_HAND', 'BUILDING_SHRINE');

INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
('SLTH_BUILDING_TEMPLE_OF_THE_HAND', 'MODIFIER_BUILDING_SHRINE_ADD_CULTUREYIELD');

INSERT INTO Projects(ProjectType, Name, ShortName, Cost, PrereqTech, PrereqCivic, MaxPlayerInstances, UnlocksFromEffect) VALUES
('PROJECT_STIR_FROM_SLUMBER', 'LOC_PROJECT_STIR_FROM_SLUMBER_NAME', 'LOC_PROJECT_STIR_FROM_SLUMBER_SHORT', '900', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1'),
('PROJECT_SAMHAIN', 'LOC_PROJECT_SAMHAIN_NAME', 'LOC_PROJECT_SAMHAIN_SHORT', '250', NULL, NULL, '1', '1'),
('PROJECT_WHITE_HAND', 'LOC_PROJECT_WHITE_HAND_NAME', 'LOC_PROJECT_WHITE_HAND_SHORT', '400', NULL, 'CIVIC_POLITICAL_PHILOSOPHY','1', '0'),
('PROJECT_DEEPENING', 'LOC_PROJECT_DEEPENING_NAME', 'LOC_PROJECT_DEEPENING_SHORT', '600', NULL, 'CIVIC_PRIESTHOOD', '1', '0'),
('PROJECT_THE_DRAW', 'LOC_PROJECT_THE_DRAW_NAME', 'LOC_PROJECT_THE_DRAW_SHORT', '900', 'TECH_STRENGTH_OF_WILL', NULL, '1', '0'),
('PROJECT_ASCENSION', 'LOC_PROJECT_ASCENSION_NAME', 'LOC_PROJECT_ASCENSION_SHORT', '1200', 'TECH_OMNISCIENCE', NULL, '1', '0');

INSERT INTO ProjectCompletionModifiers (ProjectType, ModifierId) VALUES
('PROJECT_STIR_FROM_SLUMBER', 'GRANT_DRIFA'),
('PROJECT_WHITE_HAND', 'GRANT_THREE_PRIESTS_OF_WINTER'),
('PROJECT_THE_DRAW', 'MODIFIER_THE_DRAW_HALF_HEALTH'),                  --  random damage on all player units in lua: declare wars, no diplo, lose half pop in all cities,
('PROJECT_ASCENSION', 'GRANT_AURIC_ASCENDED');                 -- spawn auric ascended, give godslayer to strongest enemy player in lua

-- TODO attach Drifa grant modifier on killing a civ.
-- MODIFIER_PLAYER_UNITS_ADJUST_OWNER
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES ('SLTH_PLAYER_HAS_CAPITAL', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES ('SLTH_PLAYER_HAS_CAPITAL', 'REQUIRES_CAPITAL_CITY');

INSERT INTO ProjectPrereqs (ProjectType, PrereqProjectType, MinimumPlayerInstances) VALUES
('PROJECT_WHITE_HAND', 'PROJECT_SAMHAIN', 1),
('PROJECT_DEEPENING', 'PROJECT_WHITE_HAND', 1),                     -- cooling world, impossible basically
('PROJECT_THE_DRAW', 'PROJECT_DEEPENING', 1),
('PROJECT_ASCENSION', 'PROJECT_THE_DRAW', 1);

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_ILLIANS', 'KIND_CIVILIZATION'),
('SLTH_TRAIT_CIVILIZATION_ILLIANS_COOL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_TEMPLE_OF_THE_HAND', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WILBOMAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HIGH_PRIEST_OF_WINTER', 'KIND_TRAIT'),
('SLTH_LEADER_AURIC', 'KIND_LEADER'),
('SLTH_UNIT_WILBOMAN', 'KIND_UNIT'),
('SLTH_UNIT_HIGH_PRIEST_OF_WINTER', 'KIND_UNIT'),
('SLTH_BUILDING_TEMPLE_OF_THE_HAND', 'KIND_BUILDING'),
('SLTH_TRAIT_CIVILIZATION_UNIT_JAVELIN_THROWER', 'KIND_TRAIT'),
('PROJECT_STIR_FROM_SLUMBER', 'KIND_PROJECT'),
('PROJECT_SAMHAIN', 'KIND_PROJECT'),
('PROJECT_WHITE_HAND', 'KIND_PROJECT'),
('PROJECT_DEEPENING', 'KIND_PROJECT'),
('PROJECT_THE_DRAW', 'KIND_PROJECT'),
('PROJECT_ASCENSION', 'KIND_PROJECT');