INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_LUCHUIRP', 'LOC_CIV_LUCHUIRP_NAME', 'LOC_CIV_LUCHUIRP_DESCRIPTION', 'LOC_SLTH_CIV_LUCHUIRP_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_GARRIM', 'LOC_SLTH_LEADER_GARRIM_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_BEERI', 'LOC_SLTH_LEADER_BEERI_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_GARRIM', 'SLTH_CIVILIZATION_LUCHUIRP', 'LOC_CITY_LUCHUIRP_1_NAME'),
('SLTH_LEADER_BEERI', 'SLTH_CIVILIZATION_LUCHUIRP', 'LOC_CITY_LUCHUIRP_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_BUILDING_SCULPTORS_STUDIO'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_BUILDING_BLASTING_WORKSHOP'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_BUILDING_PALLENS_ENGINE'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_BUILDING_ADULARIA_CHAMBER'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_BARNAXUS'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_WOOD_GOLEM'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_CLOCKWORK_GOLEM'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_IRON_GOLEM'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_DRUID'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_BOAR_RIDER'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_BONE_GOLEM'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_HORNGUARD'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_GARGOYLE'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_NULLSTONE_GOLEM'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_SHADOW'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_SLINGER'),
('SLTH_CIVILIZATION_LUCHUIRP', 'SLTH_TRAIT_DWARVEN');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_SCULPTORS_STUDIO', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_SCULPTORS_STUDIO_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_SCULPTORS_STUDIO_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_BLASTING_WORKSHOP', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_BLASTING_WORKSHOP_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_BLASTING_WORKSHOP_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_PALLENS_ENGINE', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_PALLENS_ENGINE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_PALLENS_ENGINE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_ADULARIA_CHAMBER', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_ADULARIA_CHAMBER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_ADULARIA_CHAMBER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BARNAXUS', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BARNAXUS_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BARNAXUS_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WOOD_GOLEM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WOOD_GOLEM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WOOD_GOLEM_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CLOCKWORK_GOLEM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CLOCKWORK_GOLEM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CLOCKWORK_GOLEM_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_IRON_GOLEM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_IRON_GOLEM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_IRON_GOLEM_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BONE_GOLEM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BONE_GOLEM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BONE_GOLEM_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_NULLSTONE_GOLEM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_NULLSTONE_GOLEM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_NULLSTONE_GOLEM_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GARGOYLE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GARGOYLE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GARGOYLE_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_SLTH_GRANT_TECH_CRAFTING'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_SLTH_GRANT_MANA_ENCHANTMENT'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_SLTH_SMALL_MORE_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_SLTH_GRANT_MANA_LIFE'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_SLTH_GRANT_MANA_EARTH'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_BAN_SLTH_UNIT_BEASTMASTER'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_BAN_SLTH_UNIT_AXEMAN'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_BAN_SLTH_UNIT_CHAMPION'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_BAN_SLTH_UNIT_BERSERKER'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_BAN_SLTH_UNIT_IMMORTAL'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'MODIFIER_BAN_SLTH_UNIT_PHALANX');

-- TODO Fireball promo on Blasting, Sculptors Studio Golem Prereqs, Adularia Promo, yield, Pallens Promo, yield,
INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_SCULPTORS_STUDIO', 'BUILDING_BARRACKS');
INSERT INTO Buildings(BuildingType, Name, PrereqTech, PrereqCivic, Cost, PrereqDistrict, Description, OuterDefenseHitPoints, Housing, Entertainment, TraitType, CitizenSlots, AdvisorType) VALUES
('SLTH_BUILDING_SCULPTORS_STUDIO', 'LOC_SLTH_BUILDING_SCULPTORS_STUDIO_NAME', 'TECH_CONSTRUCTION', NULL, '90', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_SCULPTORS_STUDIO_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_SCULPTORS_STUDIO', NULL, 'ADVISOR_CONQUEST'),
('SLTH_BUILDING_BLASTING_WORKSHOP', 'LOC_SLTH_BUILDING_BLASTING_WORKSHOP_NAME', 'TECH_SORCERY', NULL, '120', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_BLASTING_WORKSHOP_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_BLASTING_WORKSHOP', NULL, 'ADVISOR_CONQUEST'),
('SLTH_BUILDING_PALLENS_ENGINE', 'LOC_SLTH_BUILDING_PALLENS_ENGINE_NAME', 'TECH_DIVINATION', NULL, '180', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_PALLENS_ENGINE_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_PALLENS_ENGINE', NULL, 'ADVISOR_CONQUEST'),
('SLTH_BUILDING_ADULARIA_CHAMBER', 'LOC_SLTH_BUILDING_ADULARIA_CHAMBER_NAME', 'TECH_NECROMANCY', NULL, '180', 'DISTRICT_CITY_CENTER', 'LOC_SLTH_BUILDING_ADULARIA_CHAMBER_DESCRIPTION', '0', '0', '0', 'SLTH_TRAIT_CIVILIZATION_BUILDING_ADULARIA_CHAMBER', NULL, 'ADVISOR_CONQUEST');

INSERT INTO Building_YieldChanges(BuildingType, YieldType, YieldChange) VALUES
('SLTH_BUILDING_SCULPTORS_STUDIO', 'YIELD_CULTURE', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_WOOD_GOLEM', 'LOC_SLTH_UNIT_WOOD_GOLEM_NAME', '2', '1', '6', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_WOOD_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WOOD_GOLEM', '1', NULL, 'TECH_CONSTRUCTION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_CLOCKWORK_GOLEM', 'LOC_SLTH_UNIT_CLOCKWORK_GOLEM_NAME', '2', '1', '15', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_CLOCKWORK_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CLOCKWORK_GOLEM', '1', NULL, 'TECH_MACHINERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_IRON_GOLEM', 'LOC_SLTH_UNIT_IRON_GOLEM_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_IRON_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_IRON_GOLEM', '1', NULL, 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_BONE_GOLEM', 'LOC_SLTH_UNIT_BONE_GOLEM_NAME', '2', '1', '13', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_BONE_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BONE_GOLEM', '1', NULL, NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_NULLSTONE_GOLEM', 'LOC_SLTH_UNIT_NULLSTONE_GOLEM_NAME', '2', '1', '13', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_NULLSTONE_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_NULLSTONE_GOLEM', '1', NULL, 'TECH_MITHRIL_WEAPONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_BARNAXUS', 'LOC_SLTH_UNIT_BARNAXUS_NAME', '2', '1', '5', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_BARNAXUS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BARNAXUS', '1', 'PROMOTION_CLASS_MELEE', 'TECH_CONSTRUCTION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES
('SLTH_UNIT_WOOD_GOLEM', 'SLTH_BUILDING_SCULPTORS_STUDIO'),
('SLTH_UNIT_CLOCKWORK_GOLEM', 'SLTH_BUILDING_SCULPTORS_STUDIO'),
('SLTH_UNIT_IRON_GOLEM', 'SLTH_BUILDING_SCULPTORS_STUDIO'),
('SLTH_UNIT_BONE_GOLEM', 'SLTH_BUILDING_SCULPTORS_STUDIO'),
('SLTH_UNIT_NULLSTONE_GOLEM', 'SLTH_BUILDING_SCULPTORS_STUDIO'),
('SLTH_UNIT_GARGOYLE', 'SLTH_BUILDING_SCULPTORS_STUDIO');

-- Barnaxus
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_1', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'SLTH_UNIT_IS_BARNAXUS', 'SLTH_BARNAXUS_GOLEM_GLOBAL_AOE_REQS'),
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_2', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'SLTH_UNIT_IS_BARNAXUS', 'SLTH_BARNAXUS_GOLEM_GLOBAL_AOE_REQS'),
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_3', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'SLTH_UNIT_IS_BARNAXUS', 'SLTH_BARNAXUS_GOLEM_GLOBAL_AOE_REQS'),
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_4', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'SLTH_UNIT_IS_BARNAXUS', 'SLTH_BARNAXUS_GOLEM_GLOBAL_AOE_REQS'),
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_5', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'SLTH_UNIT_IS_BARNAXUS', 'SLTH_BARNAXUS_GOLEM_GLOBAL_AOE_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_1', 'AbilityType', 'ARGTYPE_IDENTITY', 'ABILITY_BARNAXUS_GOLEM_STRENGTH'),
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_2', 'AbilityType', 'ARGTYPE_IDENTITY', 'ABILITY_BARNAXUS_GOLEM_STRENGTH'),
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_3', 'AbilityType', 'ARGTYPE_IDENTITY', 'ABILITY_BARNAXUS_GOLEM_STRENGTH'),
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_4', 'AbilityType', 'ARGTYPE_IDENTITY', 'ABILITY_BARNAXUS_GOLEM_STRENGTH'),
('SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_5', 'AbilityType', 'ARGTYPE_IDENTITY', 'ABILITY_BARNAXUS_GOLEM_STRENGTH');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('SLTH_BARNAXUS_GOLEM_GLOBAL_AOE_REQS', 'AOE_BARNAXUS_GLOBAL_OWNER'),
('SLTH_BARNAXUS_GOLEM_GLOBAL_AOE_REQS', 'REQUIREMENT_UNIT_IS_GOLEM'),
('SLTH_UNIT_IS_BARNAXUS', 'REQUIREMENT_UNIT_IS_BARNAXUS');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('SLTH_BARNAXUS_GOLEM_GLOBAL_AOE_REQS', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_UNIT_IS_BARNAXUS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('AOE_BARNAXUS_GLOBAL_OWNER', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER'),
('REQUIREMENT_UNIT_IS_GOLEM', 'REQUIREMENT_UNIT_TAG_MATCHES'),
('REQUIREMENT_UNIT_IS_BARNAXUS', 'REQUIREMENT_UNIT_TAG_MATCHES');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('AOE_BARNAXUS_GLOBAL_OWNER', 'MinDistance', '1'),
('AOE_BARNAXUS_GLOBAL_OWNER', 'MaxDistance', '99'),                      -- can we even go higher?
('REQUIREMENT_UNIT_IS_GOLEM', 'Tag', 'RACE_GOLEM'),
('REQUIREMENT_UNIT_IS_BARNAXUS', 'Tag', 'CLASS_BARNAXUS');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('GOLEM_REDUCED_HEALING_ABILITY', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN'),
('MODIFIER_BAN_SLTH_UNIT_AXEMAN', 'MODIFIER_PLAYER_UNIT_BUILD_DISABLED');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('GOLEM_REDUCED_HEALING_ABILITY', 'Type', 'ARGTYPE_IDENTITY', 'ALL'),
('GOLEM_REDUCED_HEALING_ABILITY', 'Amount', 'ARGTYPE_IDENTITY', '-5'),
('MODIFIER_BAN_SLTH_UNIT_AXEMAN', 'UnitType', 'ARGTYPE_IDENTITY', 'SLTH_UNIT_AXEMAN');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('GOLEM_RACE_LOW_HEALING_ABILITY', 'LOC_SLTH_GOLEM_RACE_LOW_HEALING_ABILITY_NAME', 'LOC_GOLEM_RACE_LOW_HEALING_ABILITY_DESCRIPTION', '0', '1'),
('ABILITY_BARNAXUS_GOLEM_STRENGTH', 'LOC_BARNAXUS_GOLEM_STRENGTH_ABILITY_NAME', 'LOC_BARNAXUS_GOLEM_STRENGTH_ABILITY_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('GOLEM_RACE_LOW_HEALING_ABILITY', 'GOLEM_REDUCED_HEALING_ABILITY');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_BARNAXUS', 'ABILITY_CLASS');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES
('PROMOTION_COMBAT1_MELEE', 'SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_1'),
('PROMOTION_COMBAT2_MELEE', 'SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_2'),
('PROMOTION_COMBAT3_MELEE', 'SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_3'),
('PROMOTION_COMBAT4_MELEE', 'SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_4'),
('PROMOTION_COMBAT5_MELEE', 'SLTH_BARNAXUS_GOLEM_STRENGTH_GLOBAL_5');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_WOOD_GOLEM', 'CLASS_MELEE'),
('SLTH_UNIT_CLOCKWORK_GOLEM', 'CLASS_MELEE'),
('SLTH_UNIT_IRON_GOLEM', 'CLASS_MELEE'),
('SLTH_UNIT_BONE_GOLEM', 'CLASS_MELEE'),
('SLTH_UNIT_NULLSTONE_GOLEM', 'CLASS_MELEE'),
('SLTH_UNIT_BARNAXUS', 'CLASS_MELEE'),
('SLTH_UNIT_WOOD_GOLEM', 'RACE_GOLEM'),
('SLTH_UNIT_CLOCKWORK_GOLEM', 'RACE_GOLEM'),
('SLTH_UNIT_IRON_GOLEM', 'RACE_GOLEM'),
('SLTH_UNIT_BONE_GOLEM', 'RACE_GOLEM'),
('SLTH_UNIT_NULLSTONE_GOLEM', 'RACE_GOLEM'),
('SLTH_UNIT_BARNAXUS', 'RACE_GOLEM'),
('GOLEM_RACE_LOW_HEALING_ABILITY', 'RACE_GOLEM'),
('SLTH_UNIT_BARNAXUS', 'CLASS_BARNAXUS');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_LUCHUIRP', 'KIND_CIVILIZATION'),
('SLTH_TRAIT_CIVILIZATION_LUCHUIRP_COOL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_SCULPTORS_STUDIO', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_BLASTING_WORKSHOP', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_PALLENS_ENGINE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_ADULARIA_CHAMBER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BARNAXUS', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WOOD_GOLEM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CLOCKWORK_GOLEM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_IRON_GOLEM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BONE_GOLEM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_NULLSTONE_GOLEM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HORNGUARD', 'KIND_TRAIT'),           -- trait not found
('SLTH_TRAIT_CIVILIZATION_UNIT_GARGOYLE', 'KIND_TRAIT'),            -- unit defined elsewhere as Pristin Pass
('SLTH_UNIT_WOOD_GOLEM', 'KIND_UNIT'),
('SLTH_UNIT_CLOCKWORK_GOLEM', 'KIND_UNIT'),
('SLTH_UNIT_IRON_GOLEM', 'KIND_UNIT'),
('SLTH_UNIT_BONE_GOLEM', 'KIND_UNIT'),
('SLTH_UNIT_NULLSTONE_GOLEM', 'KIND_UNIT'),
('SLTH_UNIT_BARNAXUS', 'KIND_UNIT'),
('SLTH_BUILDING_SCULPTORS_STUDIO', 'KIND_BUILDING'),
('SLTH_BUILDING_BLASTING_WORKSHOP', 'KIND_BUILDING'),
('SLTH_BUILDING_PALLENS_ENGINE', 'KIND_BUILDING'),
('SLTH_BUILDING_ADULARIA_CHAMBER', 'KIND_BUILDING'),
('SLTH_LEADER_GARRIM', 'KIND_LEADER'),
('SLTH_LEADER_BEERI', 'KIND_LEADER'),
('GOLEM_RACE_LOW_HEALING_ABILITY', 'KIND_ABILITY');