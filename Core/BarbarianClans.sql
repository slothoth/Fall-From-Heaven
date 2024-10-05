DELETE FROM BarbarianTribes;
DELETE FROM BarbarianTribe_MapConditions;
DELETE FROM BarbarianTribe_MapConditionSets;

-- spawn into game. keeping same as goody huts for now
UPDATE Improvements SET Goody = 1, TilesPerGoody = 64, GoodyRange = 3 WHERE ImprovementType = 'IMPROVEMENT_BARBARIAN_CAMP';

-- scorpion, grass, plain, tundra, no features
-- ruins, grass, plains, tundra, needs jungle though
-- barrow, grass, plains, desert, tundra, snow
INSERT INTO BarbarianTribes(TribeType, Name, ScoutTag, MeleeTag, RangedTag, SiegeTag, DefenderTag, SupportTag, PercentRangedUnits, TurnsToWarriorSpawn, RaidingBoldness, CityAttackBoldness, ScoutingBehaviorTree, RaidingBehaviorTree, CityAttackOperation) VALUES 
('TRIBE_CLAN_SCORPION', 'LOC_BARBARIAN_CLAN_TYPE_SCORPION', 'CLASS_GOBLIN', 'CLASS_WARRIOR', 'CLASS_WARRIOR', 'CLASS_WARRIOR', 'CLASS_GOBLIN_RANGED', 'CLASS_GOBLIN_RANGED', '15', '15', '20', '30', 'Barbarian Found City', 'Barbarian Attack', 'Barbarian City Assault');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_GOBLIN', 'ABILITY_CLASS'),
('CLASS_GOBLIN_RANGED', 'ABILITY_CLASS'),
('CLASS_WARRIOR', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_GOBLIN', 'CLASS_GOBLIN'),
('UNIT_WARRIOR' , 'CLASS_WARRIOR'),
('SLTH_UNIT_ARCHER_SCORPION_CLAN', 'CLASS_GOBLIN_RANGED');

INSERT INTO TypeProperties(Type, Name, Value) VALUES
('TRIBE_CLAN_SCORPION', 'RAID_CONVERSION_POINTS_CHANGE', '10'),
('TRIBE_CLAN_SCORPION', 'RAID_INTERVAL_STANDARD', '10'),
('TRIBE_CLAN_SCORPION', 'HIRE_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_SCORPION', 'HIRE_INTERVAL_STANDARD', '15'),
('TRIBE_CLAN_SCORPION', 'BRIBE_BASE_COST', '50'),
('TRIBE_CLAN_SCORPION', 'BRIBE_CONVERSION_POINTS_CHANGE', '8'),
('TRIBE_CLAN_SCORPION', 'BRIBE_INTERVAL_STANDARD', '20'),
('TRIBE_CLAN_SCORPION', 'RANSOM_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_SCORPION', 'INCITE_BASE_COST', '160'),
('TRIBE_CLAN_SCORPION', 'INCITE_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_SCORPION', 'INCITE_INTERVAL_STANDARD', '15');

INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_GRASS', 'TRIBE_CLAN_SCORPION', 'ALL', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_PLAINS', 'TRIBE_CLAN_SCORPION', 'ALL', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_TUNDRA', 'TRIBE_CLAN_SCORPION', 'ALL', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_GRASS_HILLS', 'TRIBE_CLAN_SCORPION', 'ANY', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_PLAINS_HILLS', 'TRIBE_CLAN_SCORPION', 'ANY', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_TUNDRA_HILLS', 'TRIBE_CLAN_SCORPION', 'ANY', '1');


--INSERT INTO BarbarianTribe_ExtraUnits(TribeType, UnitType) VALUES this seems to be an extra unit spawned with camp, not what we want
-- ('TRIBE_CLAN_SCORPION', );

INSERT INTO BarbarianTribe_MapConditions(MapConditionSetType, TerrainType, FeatureType, ResourceType, Range, Invert) VALUES
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_GRASS', 'TERRAIN_GRASS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_PLAINS', 'TERRAIN_PLAINS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_TUNDRA', 'TERRAIN_TUNDRA', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_GRASS_HILLS', 'TERRAIN_GRASS_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_PLAINS_HILLS', 'TERRAIN_PLAINS_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_TUNDRA_HILLS', 'TERRAIN_TUNDRA_HILLS', NULL, NULL, '1', '0');

INSERT INTO BarbarianTribeNames(TribeNameType, TribeType, TribeDisplayName)VALUES
('BARBARIAN_CLAN_SCORPION', 'TRIBE_CLAN_SCORPION', 'LOC_BARBARIAN_CLAN_SCORPION_1');

INSERT INTO BarbarianTribeForces(AttackForceType, TribeType) VALUES
('LowDifficultyStandardRaid', 'TRIBE_CLAN_SCORPION'),
('StandardRaid',				'TRIBE_CLAN_SCORPION'),
('HighDifficultyStandardRaid', 'TRIBE_CLAN_SCORPION'),
('LowDifficultyStandardAttack', 'TRIBE_CLAN_SCORPION'),
('StandardAttack',			'TRIBE_CLAN_SCORPION'),
('HighDifficultyStandardAttack', 'TRIBE_CLAN_SCORPION');

INSERT INTO Types(Type, Kind) VALUES
('TRIBE_CLAN_SCORPION', 'KIND_BARBARIAN_TRIBE_TYPE'),
('BARBARIAN_CLAN_SCORPION', 'KIND_BARBARIAN_TRIBE');

--------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO BarbarianTribes(TribeType, Name, ScoutTag, MeleeTag, RangedTag, SiegeTag, DefenderTag, SupportTag, PercentRangedUnits, TurnsToWarriorSpawn, RaidingBoldness, CityAttackBoldness, ScoutingBehaviorTree, RaidingBehaviorTree, CityAttackOperation) VALUES
('TRIBE_CLAN_SKELETON', 'LOC_BARBARIAN_CLAN_TYPE_SKELETON', 'CLASS_NULL', 'CLASS_SKELETON', 'CLASS_SKELETON', 'CLASS_SKELETON', 'CLASS_SKELETON', 'CLASS_SKELETON', '0', '15', '20', '30', 'Barbarian Found City', 'Barbarian Attack', 'Barbarian City Assault');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_SKELETON', 'ABILITY_CLASS'),
('CLASS_NULL', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_SKELETON', 'CLASS_SKELETON');

INSERT INTO TypeProperties(Type, Name, Value) VALUES
('TRIBE_CLAN_SKELETON', 'RAID_CONVERSION_POINTS_CHANGE', '10'),
('TRIBE_CLAN_SKELETON', 'RAID_INTERVAL_STANDARD', '10'),
('TRIBE_CLAN_SKELETON', 'HIRE_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_SKELETON', 'HIRE_INTERVAL_STANDARD', '15'),
('TRIBE_CLAN_SKELETON', 'BRIBE_BASE_COST', '50'),
('TRIBE_CLAN_SKELETON', 'BRIBE_CONVERSION_POINTS_CHANGE', '8'),
('TRIBE_CLAN_SKELETON', 'BRIBE_INTERVAL_STANDARD', '20'),
('TRIBE_CLAN_SKELETON', 'RANSOM_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_SKELETON', 'INCITE_BASE_COST', '160'),
('TRIBE_CLAN_SKELETON', 'INCITE_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_SKELETON', 'INCITE_INTERVAL_STANDARD', '15');


INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_SKELETON_OPEN_DESERT', 'TRIBE_CLAN_SKELETON', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_GRASS', 'TRIBE_CLAN_SKELETON', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_PLAINS', 'TRIBE_CLAN_SKELETON', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_TUNDRA', 'TRIBE_CLAN_SKELETON', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_SNOW', 'TRIBE_CLAN_SKELETON', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_DESERT_HILLS', 'TRIBE_CLAN_SKELETON', 'ANY', '1'),
('TRIBE_CONDITION_SET_SKELETON_SNOW_HILLS', 'TRIBE_CLAN_SKELETON', 'ANY', '1'),
('TRIBE_CONDITION_SET_SKELETON_GRASS_HILLS', 'TRIBE_CLAN_SKELETON', 'ANY', '1'),
('TRIBE_CONDITION_SET_SKELETON_PLAINS_HILLS', 'TRIBE_CLAN_SKELETON', 'ANY', '1'),
('TRIBE_CONDITION_SET_SKELETON_TUNDRA_HILLS', 'TRIBE_CLAN_SKELETON', 'ANY', '1');


INSERT INTO BarbarianTribe_MapConditions(MapConditionSetType, TerrainType, FeatureType, ResourceType, Range, Invert) VALUES
('TRIBE_CONDITION_SET_SKELETON_OPEN_DESERT', 'TERRAIN_DESERT', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_DESERT_HILLS', 'TERRAIN_DESERT_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_SNOW', 'TERRAIN_SNOW', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_SNOW_HILLS', 'TERRAIN_SNOW_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_GRASS', 'TERRAIN_GRASS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_PLAINS', 'TERRAIN_PLAINS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_TUNDRA', 'TERRAIN_TUNDRA', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_GRASS_HILLS', 'TERRAIN_GRASS_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_PLAINS_HILLS', 'TERRAIN_PLAINS_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_SKELETON_TUNDRA_HILLS', 'TERRAIN_TUNDRA_HILLS', NULL, NULL, '1', '0');

INSERT INTO BarbarianTribeNames(TribeNameType, TribeType, TribeDisplayName)VALUES
('BARBARIAN_CLAN_SKELETON_1', 'TRIBE_CLAN_SKELETON', 'LOC_BARBARIAN_CLAN_SKELETON_1');

INSERT INTO BarbarianTribeForces(AttackForceType, TribeType) VALUES
('LowDifficultyStandardRaid', 'TRIBE_CLAN_SKELETON'),
('StandardRaid',				'TRIBE_CLAN_SKELETON'),
('HighDifficultyStandardRaid', 'TRIBE_CLAN_SKELETON'),
('LowDifficultyStandardAttack', 'TRIBE_CLAN_SKELETON'),
('StandardAttack',			'TRIBE_CLAN_SKELETON'),
('HighDifficultyStandardAttack', 'TRIBE_CLAN_SKELETON');

INSERT INTO Types(Type, Kind) VALUES
('TRIBE_CLAN_SKELETON', 'KIND_BARBARIAN_TRIBE_TYPE'),
('BARBARIAN_CLAN_SKELETON_1', 'KIND_BARBARIAN_TRIBE');

----------------------------------------------------------------------
INSERT INTO BarbarianTribes(TribeType, Name, ScoutTag, MeleeTag, RangedTag, SiegeTag, DefenderTag, SupportTag, PercentRangedUnits, TurnsToWarriorSpawn, RaidingBoldness, CityAttackBoldness, ScoutingBehaviorTree, RaidingBehaviorTree, CityAttackOperation) VALUES
('TRIBE_CLAN_LIZARDMEN', 'LOC_BARBARIAN_CLAN_TYPE_LIZARDMEN', 'CLASS_NULL', 'CLASS_LIZARDMEN', 'CLASS_LIZARDMEN', 'CLASS_LIZARDMEN', 'CLASS_LIZARDMEN', 'CLASS_LIZARDMEN', '0', '15', '20', '30', 'Barbarian Found City', 'Barbarian Attack', 'Barbarian City Assault');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_LIZARDMEN', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_LIZARDMAN', 'CLASS_LIZARDMEN');

INSERT INTO TypeProperties(Type, Name, Value) VALUES
('TRIBE_CLAN_LIZARDMEN', 'RAID_CONVERSION_POINTS_CHANGE', '10'),
('TRIBE_CLAN_LIZARDMEN', 'RAID_INTERVAL_STANDARD', '10'),
('TRIBE_CLAN_LIZARDMEN', 'HIRE_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_LIZARDMEN', 'HIRE_INTERVAL_STANDARD', '15'),
('TRIBE_CLAN_LIZARDMEN', 'BRIBE_BASE_COST', '50'),
('TRIBE_CLAN_LIZARDMEN', 'BRIBE_CONVERSION_POINTS_CHANGE', '8'),
('TRIBE_CLAN_LIZARDMEN', 'BRIBE_INTERVAL_STANDARD', '20'),
('TRIBE_CLAN_LIZARDMEN', 'RANSOM_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_LIZARDMEN', 'INCITE_BASE_COST', '160'),
('TRIBE_CLAN_LIZARDMEN', 'INCITE_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_LIZARDMEN', 'INCITE_INTERVAL_STANDARD', '15');


INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_LIZARDMEN', 'TRIBE_CLAN_LIZARDMEN', 'ANY', '1'),
('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_GRASS', 'TRIBE_CLAN_LIZARDMEN', 'ALL', '1'),
('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_PLAINS', 'TRIBE_CLAN_LIZARDMEN', 'ALL', '1'),
--('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_TUNDRA', 'TRIBE_CLAN_LIZARDMEN', 'ALL', '1'),
--('TRIBE_CONDITION_SET_LIZARDMAN_TUNDRA_HILLS', 'TRIBE_CLAN_LIZARDMEN', 'ANY', '1')
('TRIBE_CONDITION_SET_LIZARDMAN_GRASS_HILLS', 'TRIBE_CLAN_LIZARDMEN', 'ANY', '1'),
('TRIBE_CONDITION_SET_LIZARDMAN_PLAINS_HILLS', 'TRIBE_CLAN_LIZARDMEN', 'ANY', '1');


INSERT INTO BarbarianTribe_MapConditions(MapConditionSetType, TerrainType, FeatureType, ResourceType, Range, Invert) VALUES
('TRIBE_CONDITION_SET_LIZARDMEN', NULL, 'FEATURE_JUNGLE', NULL,  '1', '0'),
('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_GRASS', 'TERRAIN_GRASS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_PLAINS', 'TERRAIN_PLAINS', NULL, NULL, '1', '0'),
-- ('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_TUNDRA', 'TERRAIN_TUNDRA_HILLS', NULL, NULL, '1', '0'),
-- ('TRIBE_CONDITION_SET_LIZARDMAN_TUNDRA_HILLS', 'TERRAIN_TUNDRA_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_LIZARDMAN_GRASS_HILLS', 'TERRAIN_GRASS_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_LIZARDMAN_PLAINS_HILLS', 'TERRAIN_PLAINS_HILLS', NULL, NULL, '1', '0');


INSERT INTO BarbarianTribeNames(TribeNameType, TribeType, TribeDisplayName)VALUES
('BARBARIAN_CLAN_LIZARDMEN_1', 'TRIBE_CLAN_LIZARDMEN', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1');

INSERT INTO BarbarianTribeForces(AttackForceType, TribeType) VALUES
('LowDifficultyStandardRaid', 'TRIBE_CLAN_LIZARDMEN'),
('StandardRaid',				'TRIBE_CLAN_LIZARDMEN'),
('HighDifficultyStandardRaid', 'TRIBE_CLAN_LIZARDMEN'),
('LowDifficultyStandardAttack', 'TRIBE_CLAN_LIZARDMEN'),
('StandardAttack',			'TRIBE_CLAN_LIZARDMEN'),
('HighDifficultyStandardAttack', 'TRIBE_CLAN_LIZARDMEN');

INSERT INTO Types(Type, Kind) VALUES
('TRIBE_CLAN_LIZARDMEN', 'KIND_BARBARIAN_TRIBE_TYPE'),
('BARBARIAN_CLAN_LIZARDMEN_1', 'KIND_BARBARIAN_TRIBE'),
('TRIBE_CONDITION_SET_LIZARDMEN', 'KIND_TRIBE_MAP_CONDITION_SET');

---------------------------------------------------------------------- maybe change city attacking
INSERT INTO BarbarianTribes(TribeType, Name, ScoutTag, MeleeTag, RangedTag, SiegeTag, DefenderTag, SupportTag, PercentRangedUnits, TurnsToWarriorSpawn, RaidingBoldness, CityAttackBoldness, ScoutingBehaviorTree, RaidingBehaviorTree, CityAttackOperation) VALUES
('TRIBE_CLAN_BEARS', 'LOC_BARBARIAN_CLAN_TYPE_BEARS', 'CLASS_NULL', 'CLASS_BEAR', 'CLASS_BEAR', 'CLASS_BEAR', 'CLASS_BEAR', 'CLASS_BEAR', '0', '15', '20', '0', 'Barbarian Found City', 'Barbarian Attack', 'Barbarian City Assault');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_BEAR', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_BEAR', 'CLASS_BEAR');
-- Bears cant spawn for some reason
INSERT INTO TypeProperties(Type, Name, Value) VALUES
('TRIBE_CLAN_BEARS', 'RAID_CONVERSION_POINTS_CHANGE', '10'),
('TRIBE_CLAN_BEARS', 'RAID_INTERVAL_STANDARD', '10'),
('TRIBE_CLAN_BEARS', 'HIRE_CONVERSION_POINTS_CHANGE', '0'),
('TRIBE_CLAN_BEARS', 'HIRE_INTERVAL_STANDARD', '15'),
('TRIBE_CLAN_BEARS', 'BRIBE_BASE_COST', '10'),
('TRIBE_CLAN_BEARS', 'BRIBE_CONVERSION_POINTS_CHANGE', '0'),
('TRIBE_CLAN_BEARS', 'BRIBE_INTERVAL_STANDARD', '20'),
('TRIBE_CLAN_BEARS', 'RANSOM_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_BEARS', 'INCITE_BASE_COST', '10'),
('TRIBE_CLAN_BEARS', 'INCITE_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_BEARS', 'INCITE_INTERVAL_STANDARD', '15');

INSERT INTO BarbarianTribe_MapConditions(MapConditionSetType, TerrainType, FeatureType, ResourceType, Range, Invert) VALUES
('TRIBE_CONDITION_SET_BEARS_OPEN_TUNDRA', 'TERRAIN_TUNDRA', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_BEARS_OPEN_SNOW', 'TERRAIN_SNOW', NULL, NULL, '1', '0');

INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_BEARS_OPEN_TUNDRA', 'TRIBE_CLAN_BEARS', 'ALL', '1'),
('TRIBE_CONDITION_SET_BEARS_OPEN_SNOW', 'TRIBE_CLAN_BEARS', 'ALL', '1');

INSERT INTO BarbarianTribeNames(TribeNameType, TribeType, TribeDisplayName)VALUES
('BARBARIAN_CLAN_BEARS_1', 'TRIBE_CLAN_BEARS', 'LOC_BARBARIAN_CLAN_BEAR_1');

INSERT INTO BarbarianTribeForces(AttackForceType, TribeType) VALUES
('LowDifficultyStandardRaid', 'TRIBE_CLAN_BEARS'),
('StandardRaid',				'TRIBE_CLAN_BEARS'),
('HighDifficultyStandardRaid', 'TRIBE_CLAN_BEARS'),
('LowDifficultyStandardAttack', 'TRIBE_CLAN_BEARS'),
('StandardAttack',			'TRIBE_CLAN_BEARS'),
('HighDifficultyStandardAttack', 'TRIBE_CLAN_BEARS');

INSERT INTO Types(Type, Kind) VALUES
('TRIBE_CLAN_BEARS', 'KIND_BARBARIAN_TRIBE_TYPE'),
('BARBARIAN_CLAN_BEARS_1', 'KIND_BARBARIAN_TRIBE');

---------------------------------------------------------------------- maybe change city attacking
INSERT INTO BarbarianTribes(TribeType, Name, ScoutTag, MeleeTag, RangedTag, SiegeTag, DefenderTag, SupportTag, PercentRangedUnits, TurnsToWarriorSpawn, RaidingBoldness, CityAttackBoldness, ScoutingBehaviorTree, RaidingBehaviorTree, CityAttackOperation) VALUES
('TRIBE_CLAN_LIONS', 'LOC_BARBARIAN_CLAN_TYPE_LIONS', 'CLASS_NULL', 'CLASS_LION', 'CLASS_LION', 'CLASS_LION', 'CLASS_LION', 'CLASS_LION', '0', '15', '20', '0', 'Barbarian Found City', 'Barbarian Attack', 'Barbarian City Assault');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_LION', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_LION', 'CLASS_LION'),
('SLTH_UNIT_LION_PRIDE', 'CLASS_LION');
-- you can still hire LIONs from the clan lmao
INSERT INTO TypeProperties(Type, Name, Value) VALUES
('TRIBE_CLAN_LIONS', 'RAID_CONVERSION_POINTS_CHANGE', '10'),
('TRIBE_CLAN_LIONS', 'RAID_INTERVAL_STANDARD', '10'),
('TRIBE_CLAN_LIONS', 'HIRE_CONVERSION_POINTS_CHANGE', '0'),
('TRIBE_CLAN_LIONS', 'HIRE_INTERVAL_STANDARD', '15'),
('TRIBE_CLAN_LIONS', 'BRIBE_BASE_COST', '99999'),
('TRIBE_CLAN_LIONS', 'BRIBE_CONVERSION_POINTS_CHANGE', '0'),
('TRIBE_CLAN_LIONS', 'BRIBE_INTERVAL_STANDARD', '20'),
('TRIBE_CLAN_LIONS', 'RANSOM_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_LIONS', 'INCITE_BASE_COST', '99999'),
('TRIBE_CLAN_LIONS', 'INCITE_CONVERSION_POINTS_CHANGE', '5'),
('TRIBE_CLAN_LIONS', 'INCITE_INTERVAL_STANDARD', '15');

INSERT INTO BarbarianTribe_MapConditions(MapConditionSetType, TerrainType, FeatureType, ResourceType, Range, Invert) VALUES
('TRIBE_CONDITION_SET_LION_OPEN_PLAINS', 'TERRAIN_PLAINS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_LION_OPEN_DESERT', 'TERRAIN_DESERT', NULL, NULL, '1', '0');

INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_LION_OPEN_PLAINS', 'TRIBE_CLAN_LIONS', 'ALL', '1'),
('TRIBE_CONDITION_SET_LION_OPEN_DESERT', 'TRIBE_CLAN_LIONS', 'ALL', '1');

INSERT INTO BarbarianTribeNames(TribeNameType, TribeType, TribeDisplayName)VALUES
('BARBARIAN_CLAN_LIONS_1', 'TRIBE_CLAN_LIONS', 'LOC_BARBARIAN_CLAN_LION_1');

INSERT INTO BarbarianTribeForces(AttackForceType, TribeType) VALUES
('LowDifficultyStandardRaid', 'TRIBE_CLAN_LIONS'),
('StandardRaid',				'TRIBE_CLAN_LIONS'),
('HighDifficultyStandardRaid', 'TRIBE_CLAN_LIONS'),
('LowDifficultyStandardAttack', 'TRIBE_CLAN_LIONS'),
('StandardAttack',			'TRIBE_CLAN_LIONS'),
('HighDifficultyStandardAttack', 'TRIBE_CLAN_LIONS');

INSERT INTO Types(Type, Kind) VALUES
('TRIBE_CLAN_LIONS', 'KIND_BARBARIAN_TRIBE_TYPE'),
('BARBARIAN_CLAN_LIONS_1', 'KIND_BARBARIAN_TRIBE');

