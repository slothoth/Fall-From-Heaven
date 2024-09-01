------- ELF
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('ELF_ABILITY_FEATUREATTACKS', 'LOC_SLTH_ELF_ABILITY_FEATUREATTACKS_NAME', 'LOC_ELF_ABILITY_FEATUREATTACKS_DESCRIPTION', '1', '1'),
('ELF_ABILITY_FEATUREDOUBLEMOVES', 'LOC_SLTH_ELF_ABILITY_FEATUREDOUBLEMOVES_NAME', 'LOC_ELF_ABILITY_FEATUREDOUBLEMOVES_DESCRIPTION', '1', '1'),
('INHERENT_ELF_ABILITY_FEATUREATTACKS', 'LOC_SLTH_ELF_ABILITY_FEATUREATTACKS_NAME', 'LOC_ELF_ABILITY_FEATUREATTACKS_DESCRIPTION', '1', '1'),
('INHERENT_ELF_ABILITY_FEATUREDOUBLEMOVES', 'LOC_SLTH_ELF_ABILITY_FEATUREDOUBLEMOVES_NAME', 'LOC_ELF_ABILITY_FEATUREDOUBLEMOVES_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('ELF_ABILITY_FEATUREATTACKS', 'MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST'),
('ELF_ABILITY_FEATUREATTACKS', 'MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT'),
('ELF_ABILITY_FEATUREDOUBLEMOVES', 'MODIFIER_ELF_ABILITY_FEATUREDOUBLEMOVES_FOREST'),
('INHERENT_ELF_ABILITY_FEATUREATTACKS', 'MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST'),
('INHERENT_ELF_ABILITY_FEATUREATTACKS', 'MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT'),
('INHERENT_ELF_ABILITY_FEATUREDOUBLEMOVES', 'MODIFIER_ELF_ABILITY_FEATUREDOUBLEMOVES_FOREST');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'ELF_ABILITY_FEATUREATTACKS_REQS_FEATURE_FOREST'),
('MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'ELF_ABILITY_FEATUREATTACKS_REQS_FEATURE_FOREST_ANCIENT'),
('MODIFIER_ELF_ABILITY_FEATUREDOUBLEMOVES_FOREST', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', 'ELF_ABILITY_FEATUREDOUBLEMOVES_FOREST_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST_ANCIENT', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_ELF_ABILITY_FEATUREDOUBLEMOVES_FOREST', 'Amount', 'ARGTYPE_IDENTITY', '1');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('ELF_ABILITY_FEATUREATTACKS_REQS_FEATURE_FOREST', 'PLAYER_IS_ATTACKER_REQUIREMENTS'),
('ELF_ABILITY_FEATUREATTACKS_REQS_FEATURE_FOREST', 'PLOT_IS_FOREST_REQUIREMENT'),
('ELF_ABILITY_FEATUREATTACKS_REQS_FEATURE_FOREST_ANCIENT', 'PLAYER_IS_ATTACKER_REQUIREMENTS'),
('ELF_ABILITY_FEATUREATTACKS_REQS_FEATURE_FOREST_ANCIENT', 'PLOT_IS_ANCIENT_FOREST_REQUIREMENT'),
('ELF_ABILITY_FEATUREDOUBLEMOVES_FOREST_REQS', 'PLOT_IS_FOREST_REQUIREMENT'),
('ELF_ABILITY_FEATUREDOUBLEMOVES_FOREST_REQS', 'PLOT_IS_ANCIENT_FOREST_REQUIREMENT');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('ELF_ABILITY_FEATUREATTACKS_REQS_FEATURE_FOREST', 'REQUIREMENTSET_TEST_ALL'),
('ELF_ABILITY_FEATUREATTACKS_REQS_FEATURE_FOREST_ANCIENT', 'REQUIREMENTSET_TEST_ALL'),
('ELF_ABILITY_FEATUREDOUBLEMOVES_FOREST_REQS', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO TypeTags(Type, Tag) VALUES
('ELF_ABILITY_FEATUREATTACKS', 'CAN_BE_RACIALIZED'),
('ELF_ABILITY_FEATUREDOUBLEMOVES', 'CAN_BE_RACIALIZED'),
('INHERENT_ELF_ABILITY_FEATUREATTACKS', 'RACE_ELVEN'),
('INHERENT_ELF_ABILITY_FEATUREDOUBLEMOVES', 'RACE_ELVEN');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST', 'Preview', 'LOC_ELF_ABILITY_FEATUREATTACKS_FEATURE_FOREST_PREVIEW');

INSERT INTO Types(Type, Kind) VALUES
('ELF_ABILITY_FEATUREATTACKS', 'KIND_ABILITY'),
('ELF_ABILITY_FEATUREDOUBLEMOVES', 'KIND_ABILITY'),
('INHERENT_ELF_ABILITY_FEATUREATTACKS', 'KIND_ABILITY'),
('INHERENT_ELF_ABILITY_FEATUREDOUBLEMOVES', 'KIND_ABILITY');

-------- DWARF
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('DWARF_ABILITY_HILLS_DOUBLE_MOVE', 'LOC_SLTH_DWARF_ABILITY_HILLS_DOUBLE_MOVE_NAME', 'LOC_DWARF_ABILITY_HILLS_DOUBLE_MOVE_DESCRIPTION', '1', '1'),
('INHERENT_DWARF_ABILITY_HILLS_DOUBLE_MOVE', 'LOC_SLTH_DWARF_ABILITY_HILLS_DOUBLE_MOVE_NAME', 'LOC_DWARF_ABILITY_HILLS_DOUBLE_MOVE_DESCRIPTION', '0', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('DWARF_ABILITY_HILLS_DOUBLE_MOVE', 'HILLS_DOUBLE_MOVE_MODIFIER'),
('INHERENT_DWARF_ABILITY_HILLS_DOUBLE_MOVE', 'HILLS_DOUBLE_MOVE_MODIFIER');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('HILLS_DOUBLE_MOVE_MODIFIER', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', 'ROUGH_RIDER_HILL_TERRAIN_REQUIREMENTS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('HILLS_DOUBLE_MOVE_MODIFIER', 'Amount', 'ARGTYPE_IDENTITY', '5');

INSERT INTO TypeTags(Type, Tag) VALUES
('DWARF_ABILITY_HILLS_DOUBLE_MOVE', 'CAN_BE_RACIALIZED'),
('INHERENT_DWARF_ABILITY_HILLS_DOUBLE_MOVE', 'RACE_DWARVEN');

INSERT INTO Types(Type, Kind) VALUES
('DWARF_ABILITY_HILLS_DOUBLE_MOVE', 'KIND_ABILITY'),
('INHERENT_DWARF_ABILITY_HILLS_DOUBLE_MOVE', 'KIND_ABILITY');

-------- DEMON
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'LOC_SLTH_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_NAME', 'LOC_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_DESCRIPTION', '1', '1'),
('INHERENT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'LOC_SLTH_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_NAME', 'LOC_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_DESCRIPTION', '0', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'MODIFIER_DEMON_ABILITY_HELL_TERRAIN_STRENGTH'),
('INHERENT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'MODIFIER_DEMON_ABILITY_HELL_TERRAIN_STRENGTH');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'DEMON_ABILITY_TERRAIN_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'Amount', 'ARGTYPE_IDENTITY', '10');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('DEMON_ABILITY_TERRAIN_REQS', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('DEMON_ABILITY_TERRAIN_REQS', 'PLOT_IS_BROKEN_LANDS'),
('DEMON_ABILITY_TERRAIN_REQS', 'PLOT_IS_FIELDS_OF_PERDITION'),
('DEMON_ABILITY_TERRAIN_REQS', 'PLOT_IS_BURNING_SANDS'),
('DEMON_ABILITY_TERRAIN_REQS', 'PLOT_IS_BROKEN_LANDS_HILLS'),
('DEMON_ABILITY_TERRAIN_REQS', 'PLOT_IS_FIELDS_OF_PERDITION_HILLS'),
('DEMON_ABILITY_TERRAIN_REQS', 'PLOT_IS_BURNING_SANDS_HILLS');

INSERT INTO Requirements(RequirementId, RequirementType, ProgressWeight) VALUES
('PLOT_IS_BROKEN_LANDS', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES', '0'),
('PLOT_IS_FIELDS_OF_PERDITION', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES', '0'),
('PLOT_IS_BURNING_SANDS', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES', '0'),
('PLOT_IS_BROKEN_LANDS_HILLS', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES', '0'),
('PLOT_IS_FIELDS_OF_PERDITION_HILLS', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES', '0'),
('PLOT_IS_BURNING_SANDS_HILLS', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES', '0');

INSERT INTO RequirementArguments(RequirementId, Name, Type, Value) VALUES
('PLOT_IS_BROKEN_LANDS', 'TerrainType', 'ARGTYPE_IDENTITY', 'TERRAIN_BROKEN_LANDS'),
('PLOT_IS_FIELDS_OF_PERDITION', 'TerrainType', 'ARGTYPE_IDENTITY', 'TERRAIN_FIELDS_OF_PERDITION'),
('PLOT_IS_BURNING_SANDS', 'TerrainType', 'ARGTYPE_IDENTITY', 'TERRAIN_BURNING_SANDS'),
('PLOT_IS_BROKEN_LANDS_HILLS', 'TerrainType', 'ARGTYPE_IDENTITY', 'TERRAIN_BROKEN_LANDS_HILLS'),
('PLOT_IS_FIELDS_OF_PERDITION_HILLS', 'TerrainType', 'ARGTYPE_IDENTITY', 'TERRAIN_FIELDS_OF_PERDITION_HILLS'),
('PLOT_IS_BURNING_SANDS_HILLS', 'TerrainType', 'ARGTYPE_IDENTITY', 'TERRAIN_BURNING_SANDS_HILLS');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'Preview', 'LOC_SLTH_DEMON_ABILITY_HELL_TERRAIN_STRENGTH_PREVIEW');

INSERT INTO TypeTags(Type, Tag) VALUES
('DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'CAN_BE_RACIALIZED'),
('INHERENT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'RACE_DEMON');

INSERT INTO Types(Type, Kind) VALUES
('DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'KIND_ABILITY'),
('INHERENT_DEMON_ABILITY_HELL_TERRAIN_STRENGTH', 'KIND_ABILITY');

-------- FROSTLING
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('INHERENT_FROSTLING_ABILITY_ICY_STRENGTH', 'LOC_SLTH_FROSTLING_ABILITY_TERRAIN_STRENGTH_NAME', 'LOC_FROSTLING_ABILITY_TERRAIN_STRENGTH_DESCRIPTION', '0', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('INHERENT_FROSTLING_ABILITY_ICY_STRENGTH', 'MODIFIER_FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW'),
('INHERENT_FROSTLING_ABILITY_ICY_STRENGTH', 'MODIFIER_FROSTLING_ABILITY_TERRAIN_STRENGTH_TUNDRA'),
('INHERENT_FROSTLING_ABILITY_ICY_STRENGTH', 'MODIFIER_FROSTLING_ABILITY_TERRAIN_WEAKNESS_DESERT');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW_REQS'),
('MODIFIER_FROSTLING_ABILITY_TERRAIN_STRENGTH_TUNDRA', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'PLOT_HAS_TUNDRA_REQUIREMENTS'),
('MODIFIER_FROSTLING_ABILITY_TERRAIN_WEAKNESS_DESERT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'FROSTLING_ABILITY_TERRAIN_WEAKNESS_DESERT_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW', 'Amount', 'ARGTYPE_IDENTITY', '25'),
('MODIFIER_FROSTLING_ABILITY_TERRAIN_STRENGTH_TUNDRA', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_FROSTLING_ABILITY_TERRAIN_WEAKNESS_DESERT', 'Amount', 'ARGTYPE_IDENTITY', '-25');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW_REQS', 'SLTH_PLOT_IS_SNOW'),
('FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW_REQS', 'SLTH_PLOT_IS_SNOW_HILLS'),
('FROSTLING_ABILITY_TERRAIN_WEAKNESS_DESERT_REQS', 'REQUIRES_PLOT_HAS_DESERT'),
('FROSTLING_ABILITY_TERRAIN_WEAKNESS_DESERT_REQS', 'REQUIRES_PLOT_HAS_DESERT_HILLS');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW_REQS', 'REQUIREMENTSET_TEST_ANY'),
('FROSTLING_ABILITY_TERRAIN_WEAKNESS_DESERT_REQS', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO Requirements(RequirementId, RequirementType, ProgressWeight) VALUES
('SLTH_PLOT_IS_SNOW', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES', '0'),
('SLTH_PLOT_IS_SNOW_HILLS', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES', '0');

INSERT INTO RequirementArguments(RequirementId, Name, Type, Value) VALUES
('SLTH_PLOT_IS_SNOW', 'TerrainType', 'ARGTYPE_IDENTITY', 'TERRAIN_SNOW'),
('SLTH_PLOT_IS_SNOW_HILLS', 'TerrainType', 'ARGTYPE_IDENTITY', 'TERRAIN_SNOW_HILLS');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW', 'Preview', 'LOC_FROSTLING_ABILITY_TERRAIN_STRENGTH_SNOW_PREVIEW'),
('MODIFIER_FROSTLING_ABILITY_TERRAIN_STRENGTH_TUNDRA', 'Preview', 'LOC_FROSTLING_ABILITY_TERRAIN_STRENGTH_TUNDRA_PREVIEW'),
('MODIFIER_FROSTLING_ABILITY_TERRAIN_WEAKNESS_DESERT', 'Preview', 'LOC_FROSTLING_ABILITY_TERRAIN_STRENGTH_DESERT_PREVIEW');

INSERT INTO TypeTags(Type, Tag) VALUES
('INHERENT_FROSTLING_ABILITY_ICY_STRENGTH', 'RACE_FROSTLING');

INSERT INTO Types(Type, Kind) VALUES
('INHERENT_FROSTLING_ABILITY_ICY_STRENGTH', 'KIND_ABILITY');

-------- LIZARDMEN
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('INHERENT_LIZARDMAN_ABILITY_MARSH_STRENGTH', 'LOC_SLTH_LIZARDMAN_ABILITY_MARSH_STRENGTH_NAME', 'LOC_LIZARDMAN_ABILITY_MARSH_STRENGTH_DESCRIPTION', '0', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('INHERENT_LIZARDMAN_ABILITY_MARSH_STRENGTH', 'MODIFIER_LIZARDMAN_ABILITY_MARSH_STRENGTH_MARSH'),
('INHERENT_LIZARDMAN_ABILITY_MARSH_STRENGTH', 'MODIFIER_LIZARDMAN_ABILITY_MARSH_DOUBLE_MOVES_MARSH');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_LIZARDMAN_ABILITY_MARSH_STRENGTH_MARSH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'SLTH_PLOT_IS_MARSH_REQS'),
('MODIFIER_LIZARDMAN_ABILITY_MARSH_DOUBLE_MOVES_MARSH', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', '0', '0', 'SLTH_PLOT_IS_MARSH_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_LIZARDMAN_ABILITY_MARSH_STRENGTH_MARSH', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_LIZARDMAN_ABILITY_MARSH_DOUBLE_MOVES_MARSH', 'Amount', 'ARGTYPE_IDENTITY', '1');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('SLTH_PLOT_IS_MARSH_REQS', 'PLOT_IS_MARSH_REQUIREMENT');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('SLTH_PLOT_IS_MARSH_REQS', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_LIZARDMAN_ABILITY_MARSH_STRENGTH_MARSH', 'Preview', 'LOC_LIZARDMAN_ABILITY_MARSH_STRENGTH_MARSH_PREVIEW');

INSERT INTO TypeTags(Type, Tag) VALUES
('INHERENT_LIZARDMAN_ABILITY_MARSH_STRENGTH', 'RACE_LIZARDMEN');

INSERT INTO Types(Type, Kind) VALUES
('INHERENT_LIZARDMAN_ABILITY_MARSH_STRENGTH', 'KIND_ABILITY');

-------- ORC
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('ORC_ABILITY_JUNGLE_ATTACKS', 'LOC_SLTH_ORC_ABILITY_JUNGLE_ATTACKS_NAME', 'LOC_ORC_ABILITY_JUNGLE_ATTACKS_DESCRIPTION', '1', '1'),
('INHERENT_ORC_ABILITY_JUNGLE_ATTACKS', 'LOC_SLTH_ORC_ABILITY_JUNGLE_ATTACKS_NAME', 'LOC_ORC_ABILITY_JUNGLE_ATTACKS_DESCRIPTION', '0', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('ORC_ABILITY_JUNGLE_ATTACKS', 'MODIFIER_ORC_ABILITY_JUNGLE_ATTACKS_FEATURE_JUNGLE'),
('INHERENT_ORC_ABILITY_JUNGLE_ATTACKS', 'MODIFIER_ORC_ABILITY_JUNGLE_ATTACKS_FEATURE_JUNGLE');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_ORC_ABILITY_JUNGLE_ATTACKS_FEATURE_JUNGLE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'ORC_ABILITY_JUNGLE_ATTACKS_REQS_FEATURE_JUNGLE');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_ORC_ABILITY_JUNGLE_ATTACKS_FEATURE_JUNGLE', 'Amount', 'ARGTYPE_IDENTITY', '10');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('ORC_ABILITY_JUNGLE_ATTACKS_REQS_FEATURE_JUNGLE', 'PLAYER_IS_ATTACKER_REQUIREMENTS'),
('ORC_ABILITY_JUNGLE_ATTACKS_REQS_FEATURE_JUNGLE', 'REQUIRES_PLOT_HAS_JUNGLE');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('ORC_ABILITY_JUNGLE_ATTACKS_REQS_FEATURE_JUNGLE', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_ORC_ABILITY_JUNGLE_ATTACKS_FEATURE_JUNGLE', 'Preview', 'LOC_ORC_ABILITY_JUNGLE_ATTACKS_FEATURE_JUNGLE_PREVIEW');

INSERT INTO TypeTags(Type, Tag) VALUES
('INHERENT_ORC_ABILITY_JUNGLE_ATTACKS', 'RACE_ORCISH'),
('ORC_ABILITY_JUNGLE_ATTACKS', 'CAN_BE_RACIALIZED');

INSERT INTO Types(Type, Kind) VALUES
('ORC_ABILITY_JUNGLE_ATTACKS', 'KIND_ABILITY'),
('INHERENT_ORC_ABILITY_JUNGLE_ATTACKS', 'KIND_ABILITY');

-------- WINTERBORN
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH', 'LOC_SLTH_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_NAME', 'LOC_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_DESCRIPTION', '1', '1'),
('INHERENT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH', 'LOC_SLTH_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_NAME', 'LOC_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_DESCRIPTION', '0', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH', 'MODIFIER_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_SNOW'),
('INHERENT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH', 'MODIFIER_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_SNOW');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_SNOW', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', 'SLTH_PLOT_IS_SNOW_OR_TUNDRA');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_SNOW', 'Amount', 'ARGTYPE_IDENTITY', '10');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('SLTH_PLOT_IS_SNOW_OR_TUNDRA', 'SLTH_PLOT_IS_SNOW'),
('SLTH_PLOT_IS_SNOW_OR_TUNDRA', 'SLTH_PLOT_IS_SNOW_HILLS'),
('SLTH_PLOT_IS_SNOW_OR_TUNDRA', 'REQUIRES_PLOT_HAS_TUNDRA'),
('SLTH_PLOT_IS_SNOW_OR_TUNDRA', 'REQUIRES_PLOT_HAS_TUNDRA_HILLS');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('SLTH_PLOT_IS_SNOW_OR_TUNDRA', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
('MODIFIER_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_SNOW', 'Preview', 'LOC_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_SNOW_PREVIEW');

INSERT INTO TypeTags(Type, Tag) VALUES
('WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH', 'CAN_BE_RACIALIZED'),
('INHERENT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH', 'RACE_WINTERBORN');

INSERT INTO Types(Type, Kind) VALUES
('WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH', 'KIND_ABILITY'),
('INHERENT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH', 'KIND_ABILITY');
