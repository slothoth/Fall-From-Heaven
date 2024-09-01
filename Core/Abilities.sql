INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE', 'LOC_SLTH_PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE_NAME', 'LOC_PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE_DESCRIPTION', '1', '1'),
('WOODSMAN1_ABILITY_FEATUREATTACKS', 'LOC_SLTH_WOODSMAN1_ABILITY_FEATUREATTACKS_NAME', 'LOC_WOODSMAN1_ABILITY_FEATUREATTACKS_DESCRIPTION', '1', '1'),
('WOODSMAN1_ABILITY_FEATUREDEFENSES', 'LOC_SLTH_WOODSMAN1_ABILITY_FEATUREDEFENSES_NAME', 'LOC_WOODSMAN1_ABILITY_FEATUREDEFENSES_DESCRIPTION', '1', '1'),
('WOODSMAN2_ABILITY_FEATUREATTACKS', 'LOC_SLTH_WOODSMAN2_ABILITY_FEATUREATTACKS_NAME', 'LOC_WOODSMAN2_ABILITY_FEATUREATTACKS_DESCRIPTION', '1', '1'),
('WOODSMAN2_ABILITY_FEATUREDEFENSES', 'LOC_SLTH_WOODSMAN2_ABILITY_FEATUREDEFENSES_NAME', 'LOC_WOODSMAN2_ABILITY_FEATUREDEFENSES_DESCRIPTION', '1', '1'),
('PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES', 'LOC_SLTH_PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES_NAME', 'LOC_PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE', 'MODIFIER_PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE'),
('WOODSMAN1_ABILITY_FEATUREATTACKS', 'MODIFIER_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_JUNGLE'),
('WOODSMAN1_ABILITY_FEATUREATTACKS', 'MODIFIER_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_FOREST'),
('WOODSMAN1_ABILITY_FEATUREATTACKS', 'MODIFIER_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT'),
('WOODSMAN1_ABILITY_FEATUREDEFENSES', 'MODIFIER_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_JUNGLE'),
('WOODSMAN1_ABILITY_FEATUREDEFENSES', 'MODIFIER_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_FOREST'),
('WOODSMAN1_ABILITY_FEATUREDEFENSES', 'MODIFIER_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_FOREST_ANCIENT'),
('WOODSMAN2_ABILITY_FEATUREATTACKS', 'MODIFIER_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_JUNGLE'),
('WOODSMAN2_ABILITY_FEATUREATTACKS', 'MODIFIER_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_FOREST'),
('WOODSMAN2_ABILITY_FEATUREATTACKS', 'MODIFIER_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT'),
('WOODSMAN2_ABILITY_FEATUREDEFENSES', 'MODIFIER_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_JUNGLE'),
('WOODSMAN2_ABILITY_FEATUREDEFENSES', 'MODIFIER_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_FOREST'),
('WOODSMAN2_ABILITY_FEATUREDEFENSES', 'MODIFIER_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_FOREST_ANCIENT'),
('PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES', 'MODIFIER_PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES_JUNGLE'),
('PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES', 'MODIFIER_PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES_FOREST'),
('PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES', 'MODIFIER_PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES_ANCIENT_FOREST');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_PROMOTION_DISEASED', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_DRILL4', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'OPPONENT_PROMOTION_CLASS_MOUNTED_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_EMPOWER1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_EMPOWER2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_EMPOWER3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_EMPOWER4', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_EMPOWER5', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_EMPTY_BIER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_EMPTY_BIER_SET'),
('MODIFIER_PROMOTION_ENCHANTED_BLADE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_ENRAGED_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_ENRAGED', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_ENRAGED_SET'),
('MODIFIER_PROMOTION_FAIR_WINDS_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_FATIGUED', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_FLYING_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_FORMATION', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'OPPONENT_PROMOTION_CLASS_MOUNTED_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_FORMATION2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'OPPONENT_PROMOTION_CLASS_MOUNTED_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_GODSLAYER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_GODSLAYER_SET'),
('MODIFIER_PROMOTION_GOLDEN_HAMMER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS'),
('MODIFIER_PROMOTION_GREAT_COMMANDER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_GREAT_COMMANDER_SET'),
('MODIFIER_PROMOTION_GUERILLA1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'PROMOTION_GUERILLA1_REQS'),
('MODIFIER_PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', 'PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE_REQS'),
('TRAIT_GRANT_PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY_GRANCOLOMBIA_MAYA', '0', '0', NULL),
('MODIFIER_PROMOTION_GUERILLA2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'PROMOTION_GUERILLA2_REQS'),
('MODIFIER_PROMOTION_HASTED_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_HEAVY', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_HEROIC_DEFENSE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_HEROIC_DEFENSE_SET'),
('MODIFIER_PROMOTION_HEROIC_DEFENSE2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_HEROIC_DEFENSE2_SET'),
('MODIFIER_PROMOTION_HEROIC_STRENGTH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS'),
('MODIFIER_PROMOTION_HEROIC_STRENGTH2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS'),
('MODIFIER_PROMOTION_HORSELORD_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_ILLUSION', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_FROM_COMBAT', '0', '0', NULL),
('MODIFIER_PROMOTION_IRON_WEAPONS', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_IRON_WEAPONS_SET'),
('MODIFIER_PROMOTION_LIGHT_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_LIGHT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_LONGSHOREMEN_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_MARCH', 'MODIFIER_PLAYER_UNIT_GRANT_HEAL_AFTER_ACTION', '0', '0', NULL),
('MODIFIER_PROMOTION_MITHRIL_WEAPONS', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_MITHRIL_WEAPONS_SET'),
('MODIFIER_PROMOTION_MOBILITY1_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_MOBILITY2_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_MORALE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'URBAN_RAIDER_REQUIREMENTS'),
('MODIFIER_PROMOTION_NAVIGATION1_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_NAVIGATION2_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_PLAGUED', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_POISONED', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_PUPPET', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_REGENERATION', 'MODIFIER_PLAYER_UNIT_GRANT_HEAL_AFTER_ACTION', '0', '0', NULL),
('MODIFIER_PROMOTION_RUSTED', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_SCOURGE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'OPPONENT_PROMOTION_CLASS_DISCIPLE_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_SHIELD_OF_FAITH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_SHIELD_OF_FAITH_SET'),
('MODIFIER_PROMOTION_SHOCK', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'OPPONENT_PROMOTION_CLASS_MELEE_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_SHOCK2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'OPPONENT_PROMOTION_CLASS_MELEE_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_SINISTER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS'),
('MODIFIER_PROMOTION_SKELETON_CREW', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_SKELETON_CREW_SET'),
('MODIFIER_PROMOTION_SLOW_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_STARTING_SETTLER_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_STONESKIN', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_STONESKIN_SET'),
('MODIFIER_PROMOTION_STRONG', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_STRONG_SET'),
('MODIFIER_PROMOTION_SUBDUE_ANIMAL', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'OPPONENT_PROMOTION_CLASS_ANIMAL_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_SUBDUE_ANIMAL_SLAVE_TAKING_MODIFIER', 'MODIFIER_UNIT_ADJUST_PROPERTY', '0', '0', 'OPPONENT_PROMOTION_CLASS_ANIMAL_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_SUBDUE_BEASTS', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'OPPONENT_PROMOTION_CLASS_BEAST_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_SUBDUE_BEASTS_SLAVE_TAKING_MODIFIER', 'MODIFIER_UNIT_ADJUST_PROPERTY', '0', '0', 'OPPONENT_PROMOTION_CLASS_BEAST_REQUIREMENT_SET'),
('MODIFIER_PROMOTION_UNHOLY_TAINT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_UNHOLY_TAINT_SET'),
('MODIFIER_PROMOTION_VAMPIRE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL),
('MODIFIER_PROMOTION_WARCRY_MOVEMENT', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', NULL),
('MODIFIER_PROMOTION_WARCRY', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_WARCRY_SET'),
('MODIFIER_PROMOTION_WEAK', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'REQUIREMENT_PROMOTION_WEAK_SET'),
('MODIFIER_PROMOTION_WITHERED', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_PROMOTION_DISEASED', 'Type', 'ARGTYPE_IDENTITY', 'ALL'),
('MODIFIER_PROMOTION_DISEASED', 'Amount', 'ARGTYPE_IDENTITY', '-10'),
('MODIFIER_PROMOTION_DRILL4', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('MODIFIER_PROMOTION_EMPOWER1', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_EMPOWER2', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_EMPOWER3', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_EMPOWER4', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_EMPOWER5', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_EMPTY_BIER', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('MODIFIER_PROMOTION_ENCHANTED_BLADE', 'Amount', 'ARGTYPE_IDENTITY', '20'),
('MODIFIER_PROMOTION_ENRAGED_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_ENRAGED', 'Amount', 'ARGTYPE_IDENTITY', '20'),
('MODIFIER_PROMOTION_FAIR_WINDS_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_FATIGUED', 'Amount', 'ARGTYPE_IDENTITY', '-10'),
('MODIFIER_PROMOTION_FLYING_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_FORMATION', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_FORMATION2', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_GODSLAYER', 'Amount', 'ARGTYPE_IDENTITY', '3'),
('MODIFIER_PROMOTION_GOLDEN_HAMMER', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_GREAT_COMMANDER', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_GUERILLA1', 'Amount', 'ARGTYPE_IDENTITY', '40'),
('MODIFIER_PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE', 'Amount', 'ARGTYPE_IDENTITY', '5'),
('TRAIT_GRANT_PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE', 'AbilityType', 'ARGTYPE_IDENTITY', 'PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE'),
('MODIFIER_PROMOTION_GUERILLA2', 'Amount', 'ARGTYPE_IDENTITY', '60'),
('MODIFIER_PROMOTION_HASTED_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_HEAVY', 'Amount', 'ARGTYPE_IDENTITY', '30'),
('MODIFIER_PROMOTION_HEROIC_DEFENSE', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_HEROIC_DEFENSE2', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_HEROIC_STRENGTH', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_HEROIC_STRENGTH2', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_HORSELORD_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_ILLUSION', 'Amount', 'ARGTYPE_IDENTITY', '100'),
('MODIFIER_PROMOTION_IRON_WEAPONS', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('MODIFIER_PROMOTION_LIGHT_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_LIGHT', 'Amount', 'ARGTYPE_IDENTITY', '-20'),
('MODIFIER_PROMOTION_LONGSHOREMEN_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_MARCH', 'Type', 'ARGTYPE_IDENTITY', 'ALL'),
('MODIFIER_PROMOTION_MARCH', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_MITHRIL_WEAPONS', 'Amount', 'ARGTYPE_IDENTITY', '4'),
('MODIFIER_PROMOTION_MOBILITY1_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_MOBILITY2_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_MORALE', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_NAVIGATION1_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_NAVIGATION2_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_PLAGUED', 'Type', 'ARGTYPE_IDENTITY', 'ALL'),
('MODIFIER_PROMOTION_PLAGUED', 'Amount', 'ARGTYPE_IDENTITY', '-20'),
('MODIFIER_PROMOTION_POISONED', 'Type', 'ARGTYPE_IDENTITY', 'ALL'),
('MODIFIER_PROMOTION_POISONED', 'Amount', 'ARGTYPE_IDENTITY', '-3'),
('MODIFIER_PROMOTION_PUPPET', 'Amount', 'ARGTYPE_IDENTITY', '-20'),
('MODIFIER_PROMOTION_REGENERATION', 'Type', 'ARGTYPE_IDENTITY', 'ALL'),
('MODIFIER_PROMOTION_REGENERATION', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_RUSTED', 'Amount', 'ARGTYPE_IDENTITY', '-10'),
('MODIFIER_PROMOTION_SCOURGE', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_SHIELD_OF_FAITH', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_SHOCK', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_SHOCK2', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_PROMOTION_SINISTER', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_SKELETON_CREW', 'Amount', 'ARGTYPE_IDENTITY', '-1'),
('MODIFIER_PROMOTION_SLOW_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '-1'),
('MODIFIER_PROMOTION_STARTING_SETTLER_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('MODIFIER_PROMOTION_STONESKIN', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('MODIFIER_PROMOTION_STRONG', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_SUBDUE_ANIMAL', 'Amount', 'ARGTYPE_IDENTITY', '6'),
('MODIFIER_PROMOTION_SUBDUE_ANIMAL_SLAVE_TAKING_MODIFIER', 'Key', 'ARGTYPE_IDENTITY', 'HeroResurrectKill'),
('MODIFIER_PROMOTION_SUBDUE_ANIMAL_SLAVE_TAKING_MODIFIER', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_SUBDUE_BEASTS', 'Amount', 'ARGTYPE_IDENTITY', '6'),
('MODIFIER_PROMOTION_SUBDUE_BEASTS_SLAVE_TAKING_MODIFIER', 'Key', 'ARGTYPE_IDENTITY', 'HeroResurrectKill'),
('MODIFIER_PROMOTION_SUBDUE_BEASTS_SLAVE_TAKING_MODIFIER', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_UNHOLY_TAINT', 'Amount', 'ARGTYPE_IDENTITY', '-25'),
('MODIFIER_PROMOTION_VAMPIRE', 'Type', 'ARGTYPE_IDENTITY', 'ALL'),
('MODIFIER_PROMOTION_VAMPIRE', 'Amount', 'ARGTYPE_IDENTITY', '5'),
('MODIFIER_PROMOTION_WARCRY_MOVEMENT', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_WARCRY', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PROMOTION_WEAK', 'Amount', 'ARGTYPE_IDENTITY', '-1'),
('MODIFIER_PROMOTION_WITHERED', 'Type', 'ARGTYPE_IDENTITY', 'ALL'),
('MODIFIER_PROMOTION_WITHERED', 'Amount', 'ARGTYPE_IDENTITY', '-20');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('OPPONENT_PROMOTION_CLASS_MELEE_REQUIREMENT_SET', 'OPPONENT_PROMOTION_CLASS_MELEE_REQUIREMENT'),
('OPPONENT_PROMOTION_CLASS_NAVAL_REQUIREMENT_SET', 'OPPONENT_PROMOTION_CLASS_NAVAL_REQUIREMENT'),
('OPPONENT_PROMOTION_CLASS_MOUNTED_REQUIREMENT_SET', 'OPPONENT_PROMOTION_CLASS_MOUNTED_REQUIREMENT'),
('REQUIREMENT_PROMOTION_BRONZE_WEAPONS_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_BUCCANEERS_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('OPPONENT_PROMOTION_CLASS_ARCHER_REQUIREMENT_SET', 'OPPONENT_PROMOTION_CLASS_ARCHER_REQUIREMENT'),
('REQUIREMENT_PROMOTION_EMPTY_BIER_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_ENRAGED_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_GODSLAYER_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_GREAT_COMMANDER_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_IRON_WEAPONS_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_MITHRIL_WEAPONS_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('OPPONENT_PROMOTION_CLASS_DISCIPLE_REQUIREMENT_SET', 'OPPONENT_PROMOTION_CLASS_DISCIPLE_REQUIREMENT'),
('REQUIREMENT_PROMOTION_SHIELD_OF_FAITH_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_SKELETON_CREW_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_STONESKIN_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_STRONG_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('OPPONENT_PROMOTION_CLASS_ANIMAL_REQUIREMENT_SET', 'OPPONENT_PROMOTION_CLASS_ANIMAL_REQUIREMENT'),
('OPPONENT_PROMOTION_CLASS_BEAST_REQUIREMENT_SET', 'OPPONENT_PROMOTION_CLASS_BEAST_REQUIREMENT'),
('REQUIREMENT_PROMOTION_UNHOLY_TAINT_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_WARCRY_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS'),
('REQUIREMENT_PROMOTION_WEAK_SET', 'PLAYER_IS_DEFENDER_REQUIREMENTS');
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('OPPONENT_PROMOTION_CLASS_MELEE_REQUIREMENT_SET', 'REQUIREMENTSET_TEST_ALL'),
('OPPONENT_PROMOTION_CLASS_NAVAL_REQUIREMENT_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_BRONZE_WEAPONS_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_BUCCANEERS_SET', 'REQUIREMENTSET_TEST_ALL'),
('OPPONENT_PROMOTION_CLASS_ARCHER_REQUIREMENT_SET', 'REQUIREMENTSET_TEST_ALL'),
('OPPONENT_PROMOTION_CLASS_MOUNTED_REQUIREMENT_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_EMPTY_BIER_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_ENRAGED_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_GODSLAYER_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_GREAT_COMMANDER_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_MITHRIL_WEAPONS_SET', 'REQUIREMENTSET_TEST_ALL'),
('OPPONENT_PROMOTION_CLASS_DISCIPLE_REQUIREMENT_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_SHIELD_OF_FAITH_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_SKELETON_CREW_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_STONESKIN_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_STRONG_SET', 'REQUIREMENTSET_TEST_ALL'),
('OPPONENT_PROMOTION_CLASS_ANIMAL_REQUIREMENT_SET', 'REQUIREMENTSET_TEST_ALL'),
('OPPONENT_PROMOTION_CLASS_BEAST_REQUIREMENT_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_UNHOLY_TAINT_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_WARCRY_SET', 'REQUIREMENTSET_TEST_ALL'),
('REQUIREMENT_PROMOTION_WEAK_SET', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_PROMOTION_DISEASED', 'Preview', 'LOC_PROMOTION_DISEASED_DESCRIPTION'),
('MODIFIER_PROMOTION_DRILL4', 'Preview', 'LOC_PROMOTION_DRILL4_DESCRIPTION'),
('MODIFIER_PROMOTION_EMPOWER1', 'Preview', 'LOC_PROMOTION_EMPOWER1_DESCRIPTION'),
('MODIFIER_PROMOTION_EMPOWER2', 'Preview', 'LOC_PROMOTION_EMPOWER2_DESCRIPTION'),
('MODIFIER_PROMOTION_EMPOWER3', 'Preview', 'LOC_PROMOTION_EMPOWER3_DESCRIPTION'),
('MODIFIER_PROMOTION_EMPOWER4', 'Preview', 'LOC_PROMOTION_EMPOWER4_DESCRIPTION'),
('MODIFIER_PROMOTION_EMPOWER5', 'Preview', 'LOC_PROMOTION_EMPOWER5_DESCRIPTION'),
('MODIFIER_PROMOTION_EMPTY_BIER', 'Preview', 'LOC_PROMOTION_EMPTY_BIER_DESCRIPTION'),
('MODIFIER_PROMOTION_ENCHANTED_BLADE', 'Preview', 'LOC_PROMOTION_ENCHANTED_BLADE_DESCRIPTION'),
('MODIFIER_PROMOTION_ENRAGED', 'Preview', 'LOC_PROMOTION_ENRAGED_DESCRIPTION'),
('MODIFIER_PROMOTION_FATIGUED', 'Preview', 'LOC_PROMOTION_FATIGUED_DESCRIPTION'),
('MODIFIER_PROMOTION_FORMATION', 'Preview', 'LOC_PROMOTION_FORMATION_DESCRIPTION'),
('MODIFIER_PROMOTION_FORMATION2', 'Preview', 'LOC_PROMOTION_FORMATION2_DESCRIPTION'),
('MODIFIER_PROMOTION_GODSLAYER', 'Preview', 'LOC_PROMOTION_GODSLAYER_DESCRIPTION'),
('MODIFIER_PROMOTION_GOLDEN_HAMMER', 'Preview', 'LOC_PROMOTION_GOLDEN_HAMMER_DESCRIPTION'),
('MODIFIER_PROMOTION_GREAT_COMMANDER', 'Preview', 'LOC_PROMOTION_GREAT_COMMANDER_DESCRIPTION'),
('MODIFIER_PROMOTION_GUERILLA1', 'Preview', 'LOC_PROMOTION_GUERILLA1_DESCRIPTION'),
('MODIFIER_PROMOTION_GUERILLA2', 'Preview', 'LOC_PROMOTION_GUERILLA2_DESCRIPTION'),
('MODIFIER_PROMOTION_HEAVY', 'Preview', 'LOC_PROMOTION_HEAVY_DESCRIPTION'),
('MODIFIER_PROMOTION_HEROIC_DEFENSE', 'Preview', 'LOC_PROMOTION_HEROIC_DEFENSE_DESCRIPTION'),
('MODIFIER_PROMOTION_HEROIC_DEFENSE2', 'Preview', 'LOC_PROMOTION_HEROIC_DEFENSE2_DESCRIPTION'),
('MODIFIER_PROMOTION_HEROIC_STRENGTH', 'Preview', 'LOC_PROMOTION_HEROIC_STRENGTH_DESCRIPTION'),
('MODIFIER_PROMOTION_HEROIC_STRENGTH2', 'Preview', 'LOC_PROMOTION_HEROIC_STRENGTH2_DESCRIPTION'),
('MODIFIER_PROMOTION_IRON_WEAPONS', 'Preview', 'LOC_PROMOTION_IRON_WEAPONS_DESCRIPTION'),
('MODIFIER_PROMOTION_LIGHT', 'Preview', 'LOC_PROMOTION_LIGHT_DESCRIPTION'),
('MODIFIER_PROMOTION_MITHRIL_WEAPONS', 'Preview', 'LOC_PROMOTION_MITHRIL_WEAPONS_DESCRIPTION'),
('MODIFIER_PROMOTION_MORALE', 'Preview', 'LOC_PROMOTION_MORALE_DESCRIPTION'),
('MODIFIER_PROMOTION_PLAGUED', 'Preview', 'LOC_PROMOTION_PLAGUED_DESCRIPTION'),
('MODIFIER_PROMOTION_POISONED', 'Preview', 'LOC_PROMOTION_POISONED_DESCRIPTION'),
('MODIFIER_PROMOTION_PUPPET', 'Preview', 'LOC_PROMOTION_PUPPET_DESCRIPTION'),
('MODIFIER_PROMOTION_RUSTED', 'Preview', 'LOC_PROMOTION_RUSTED_DESCRIPTION'),
('MODIFIER_PROMOTION_SCOURGE', 'Preview', 'LOC_PROMOTION_SCOURGE_DESCRIPTION'),
('MODIFIER_PROMOTION_SHIELD_OF_FAITH', 'Preview', 'LOC_PROMOTION_SHIELD_OF_FAITH_DESCRIPTION'),
('MODIFIER_PROMOTION_SHOCK', 'Preview', 'LOC_PROMOTION_SHOCK_DESCRIPTION'),
('MODIFIER_PROMOTION_SHOCK2', 'Preview', 'LOC_PROMOTION_SHOCK2_DESCRIPTION'),
('MODIFIER_PROMOTION_SINISTER', 'Preview', 'LOC_PROMOTION_SINISTER_DESCRIPTION'),
('MODIFIER_PROMOTION_SKELETON_CREW', 'Preview', 'LOC_PROMOTION_SKELETON_CREW_DESCRIPTION'),
('MODIFIER_PROMOTION_STONESKIN', 'Preview', 'LOC_PROMOTION_STONESKIN_DESCRIPTION'),
('MODIFIER_PROMOTION_STRONG', 'Preview', 'LOC_PROMOTION_STRONG_DESCRIPTION'),
('MODIFIER_PROMOTION_SUBDUE_ANIMAL', 'Preview', 'LOC_PROMOTION_SUBDUE_ANIMAL_DESCRIPTION'),
('MODIFIER_PROMOTION_SUBDUE_ANIMAL_SLAVE_TAKING_MODIFIER', 'Preview', 'LOC_PROMOTION_SUBDUE_ANIMAL_DESCRIPTION'),
('MODIFIER_PROMOTION_SUBDUE_BEASTS', 'Preview', 'LOC_PROMOTION_SUBDUE_BEASTS_DESCRIPTION'),
('MODIFIER_PROMOTION_SUBDUE_BEASTS_SLAVE_TAKING_MODIFIER', 'Preview', 'LOC_PROMOTION_SUBDUE_BEASTS_DESCRIPTION'),
('MODIFIER_PROMOTION_UNHOLY_TAINT', 'Preview', 'LOC_PROMOTION_UNHOLY_TAINT_DESCRIPTION'),
('MODIFIER_PROMOTION_VAMPIRE', 'Preview', 'LOC_PROMOTION_VAMPIRE_DESCRIPTION'),
('MODIFIER_PROMOTION_WARCRY', 'Preview', 'LOC_PROMOTION_WARCRY_DESCRIPTION'),
('MODIFIER_PROMOTION_WEAK', 'Preview', 'LOC_PROMOTION_WEAK_DESCRIPTION'),
('MODIFIER_PROMOTION_WITHERED', 'Preview', 'LOC_PROMOTION_WITHERED_DESCRIPTION'),
('MODIFIER_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_JUNGLE', 'Preview', 'LOC_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_JUNGLE_PREVIEW'),
('MODIFIER_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_FOREST', 'Preview', 'LOC_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_FOREST_PREVIEW'),
('MODIFIER_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT', 'Preview', 'LOC_WOODSMAN1_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT_PREVIEW'),
('MODIFIER_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_JUNGLE', 'Preview', 'LOC_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_JUNGLE_PREVIEW'),
('MODIFIER_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_FOREST', 'Preview', 'LOC_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_FOREST_PREVIEW'),
('MODIFIER_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_FOREST_ANCIENT', 'Preview', 'LOC_WOODSMAN1_ABILITY_FEATUREDEFENSES_FEATURE_FOREST_ANCIENT_PREVIEW'),
('MODIFIER_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_JUNGLE', 'Preview', 'LOC_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_JUNGLE_PREVIEW'),
('MODIFIER_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_FOREST', 'Preview', 'LOC_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_FOREST_PREVIEW'),
('MODIFIER_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT', 'Preview', 'LOC_WOODSMAN2_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT_PREVIEW'),
('MODIFIER_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_JUNGLE', 'Preview', 'LOC_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_JUNGLE_PREVIEW'),
('MODIFIER_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_FOREST', 'Preview', 'LOC_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_FOREST_PREVIEW'),
('MODIFIER_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_FOREST_ANCIENT', 'Preview', 'LOC_WOODSMAN2_ABILITY_FEATUREDEFENSES_FEATURE_FOREST_ANCIENT_PREVIEW');

INSERT INTO TypeTags(Type, Tag) VALUES
('PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE', 'CLASS_ALL_UNITS'),
('PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES', 'CLASS_ALL_UNITS'),
('WOODSMAN1_ABILITY_FEATUREATTACKS', 'CLASS_ALL_UNITS'),
('WOODSMAN1_ABILITY_FEATUREDEFENSES', 'CLASS_ALL_UNITS'),
('WOODSMAN2_ABILITY_FEATUREATTACKS', 'CLASS_ALL_UNITS'),
('WOODSMAN2_ABILITY_FEATUREDEFENSES', 'CLASS_ALL_UNITS');

INSERT INTO Types(Type, Kind) VALUES
('PROMOTION_GUERILLA2_ABILITY_HILLS_DOUBLE_MOVE', 'KIND_ABILITY'),
('WOODSMAN1_ABILITY_FEATUREATTACKS', 'KIND_ABILITY'),
('WOODSMAN1_ABILITY_FEATUREDEFENSES', 'KIND_ABILITY'),
('WOODSMAN2_ABILITY_FEATUREATTACKS', 'KIND_ABILITY'),
('WOODSMAN2_ABILITY_FEATUREDEFENSES', 'KIND_ABILITY'),
('PROMOTION_WOODSMAN2_ABILITY_FEATUREDOUBLEMOVES', 'KIND_ABILITY');
