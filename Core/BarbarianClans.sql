DELETE FROM BarbarianTribes WHERE Name ='TRIBE_CLAN_CAVALRY_JUNGLE';
DELETE FROM BarbarianTribes WHERE Name ='TRIBE_CLAN_NAVAL';

DELETE FROM BarbarianTribe_MapConditions;
DELETE FROM BarbarianTribe_MapConditionSets;
DELETE FROM BarbarianTribeNames;

-- CAN_MOVE_AFTER_PURCHASE TypeProperties, CAN_EVER_TRAIN_CITY_STATE (seems unneeded), CAN_EVER_TRAIN_FREE_CITY (maybe useful to limit barb cities?)
DELETE FROM UnitCommands WHERE CommandType='UNITCOMMAND_TREAT_WITH_CLAN_RAID';
UPDATE TypeProperties SET Value=0 WHERE Type = 'UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE' and Name='XP_EARNED';
-- spawn into game. keeping same as goody huts for now
UPDATE Improvements SET Goody = 1, TilesPerGoody = 64, GoodyRange = 3 WHERE ImprovementType = 'IMPROVEMENT_BARBARIAN_CAMP';

UPDATE TypeProperties SET Value='100' WHERE Name='BRIBE_CONVERSION_POINTS_CHANGE';          -- just for testing
UPDATE TypeProperties SET Value='200' WHERE Name='BRIBE_INTERVAL_STANDARD';                 -- closest thing to peace with barbs
UPDATE TypeProperties SET Value='0' WHERE Name='BRIBE_BASE_COST';

UPDATE TypeProperties SET Value='10' WHERE Name='RAID_CONVERSION_POINTS_CHANGE';

UPDATE GlobalParameters SET Value='0' WHERE Name='BARBARIAN_CLANS_RANSOM_COST_SCALAR';
UPDATE GlobalParameters SET Value='0' WHERE Name='BARBARIAN_CLANS_BRIBE_COST_PER_CITY';
UPDATE GlobalParameters SET Value = '30' WHERE Name = 'EXPERIENCE_BARB_SOFT_CAP';               -- no cap on barb combat
UPDATE GlobalParameters SET Value = '30' WHERE Name = 'EXPERIENCE_MAX_BARB_LEVEL';

-- scorpion, grass, plain, tundra, no features
-- ruins, grass, plains, tundra, needs jungle though
-- barrow, grass, plains, desert, tundra, snow

-- scorpion clan kept separate for template of any new tribe
UPDATE BarbarianTribes SET Name='LOC_BARBARIAN_CLAN_TYPE_SCORPION', ScoutTag='CLASS_GOBLIN_RANGED', MeleeTag='CLASS_GOBLIN_RANGED',
                           RangedTag='CLASS_GOBLIN_RANGED', SiegeTag='CLASS_GOBLIN_RANGED', DefenderTag='CLASS_GOBLIN_RANGED',
                           SupportTag='CLASS_GOBLIN_RANGED', PercentRangedUnits='15', TurnsToWarriorSpawn='15'
                       WHERE TribeType='TRIBE_CLAN_MELEE_OPEN';

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_GOBLIN', 'ABILITY_CLASS'),
('CLASS_GOBLIN_RANGED', 'ABILITY_CLASS'),
('CLASS_WARRIOR', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_GOBLIN', 'CLASS_GOBLIN'),
('UNIT_WARRIOR' , 'CLASS_WARRIOR'),
('SLTH_UNIT_ARCHER_SCORPION_CLAN', 'CLASS_GOBLIN_RANGED');


INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_GRASS', 'TRIBE_CLAN_MELEE_OPEN', 'ALL', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_PLAINS', 'TRIBE_CLAN_MELEE_OPEN', 'ALL', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_OPEN_TUNDRA', 'TRIBE_CLAN_MELEE_OPEN', 'ALL', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_GRASS_HILLS', 'TRIBE_CLAN_MELEE_OPEN', 'ANY', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_PLAINS_HILLS', 'TRIBE_CLAN_MELEE_OPEN', 'ANY', '1'),
('TRIBE_CONDITION_SET_SCORPION_CLAN_TUNDRA_HILLS', 'TRIBE_CLAN_MELEE_OPEN', 'ANY', '1');


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
('BARBARIAN_CLAN_SCORPION_1', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_2', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_3', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_4', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_5', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_6', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_7', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_8', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_9', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_10', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_11', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_12', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_13', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_14', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_15', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_16', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_17', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_18', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_19', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1'),
('BARBARIAN_CLAN_SCORPION_20', 'TRIBE_CLAN_MELEE_OPEN', 'LOC_BARBARIAN_CLAN_SCORPION_1');


INSERT INTO Types(Type, Kind) VALUES
('BARBARIAN_CLAN_SCORPION_1',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_2',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_3',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_4',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_5',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_6',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_7',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_8',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_9',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_10',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_11',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_12',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_13',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_14',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_15',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_16',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_17',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_18',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_19',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SCORPION_20',  'KIND_BARBARIAN_TRIBE');

--------------------------------------------------------------------------------------------------------------------------------------------
UPDATE BarbarianTribes SET Name='LOC_BARBARIAN_CLAN_TYPE_SKELETON', ScoutTag='CLASS_NULL', MeleeTag='CLASS_SKELETON',
                           RangedTag='CLASS_SKELETON', SiegeTag='CLASS_SKELETON', DefenderTag='CLASS_SKELETON',
                           SupportTag='CLASS_SKELETON', PercentRangedUnits='0', TurnsToWarriorSpawn='15'
                       WHERE TribeType='TRIBE_CLAN_MELEE_HILLS';

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_SKELETON', 'ABILITY_CLASS'),
('CLASS_NULL', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_SKELETON', 'CLASS_SKELETON');


INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_SKELETON_OPEN_DESERT', 'TRIBE_CLAN_MELEE_HILLS', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_GRASS', 'TRIBE_CLAN_MELEE_HILLS', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_PLAINS', 'TRIBE_CLAN_MELEE_HILLS', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_TUNDRA', 'TRIBE_CLAN_MELEE_HILLS', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_OPEN_SNOW', 'TRIBE_CLAN_MELEE_HILLS', 'ALL', '1'),
('TRIBE_CONDITION_SET_SKELETON_DESERT_HILLS', 'TRIBE_CLAN_MELEE_HILLS', 'ANY', '1'),
('TRIBE_CONDITION_SET_SKELETON_SNOW_HILLS', 'TRIBE_CLAN_MELEE_HILLS', 'ANY', '1'),
('TRIBE_CONDITION_SET_SKELETON_GRASS_HILLS', 'TRIBE_CLAN_MELEE_HILLS', 'ANY', '1'),
('TRIBE_CONDITION_SET_SKELETON_PLAINS_HILLS', 'TRIBE_CLAN_MELEE_HILLS', 'ANY', '1'),
('TRIBE_CONDITION_SET_SKELETON_TUNDRA_HILLS', 'TRIBE_CLAN_MELEE_HILLS', 'ANY', '1');


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
('BARBARIAN_CLAN_SKELETON_1', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_2', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_3', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_4', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_5', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_6', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_7', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_8', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_9', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_10', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_11', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_12', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_13', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_14', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_15', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_16', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_17', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_18', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_19', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1'),
('BARBARIAN_CLAN_SKELETON_20', 'TRIBE_CLAN_MELEE_HILLS', 'LOC_BARBARIAN_CLAN_SKELETON_1');


----------------------------------------------------------------------
UPDATE BarbarianTribes SET Name='LOC_BARBARIAN_CLAN_TYPE_LIZARDMEN', ScoutTag='CLASS_NULL', MeleeTag='CLASS_LIZARDMEN',
                           RangedTag='CLASS_LIZARDMEN', SiegeTag='CLASS_LIZARDMEN', DefenderTag='CLASS_LIZARDMEN',
                           SupportTag='CLASS_LIZARDMEN', PercentRangedUnits='0', TurnsToWarriorSpawn='15'
                       WHERE TribeType='TRIBE_CLAN_MELEE_FOREST';

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_LIZARDMEN', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_LIZARDMAN', 'CLASS_LIZARDMEN');


INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_LIZARDMEN', 'TRIBE_CLAN_MELEE_FOREST', 'ANY', '1'),
('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_GRASS', 'TRIBE_CLAN_MELEE_FOREST', 'ALL', '1'),
('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_PLAINS', 'TRIBE_CLAN_MELEE_FOREST', 'ALL', '1'),
--('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_TUNDRA', 'TRIBE_CLAN_MELEE_FOREST', 'ALL', '1'),
--('TRIBE_CONDITION_SET_LIZARDMAN_TUNDRA_HILLS', 'TRIBE_CLAN_MELEE_FOREST', 'ANY', '1')
('TRIBE_CONDITION_SET_LIZARDMAN_GRASS_HILLS', 'TRIBE_CLAN_MELEE_FOREST', 'ANY', '1'),
('TRIBE_CONDITION_SET_LIZARDMAN_PLAINS_HILLS', 'TRIBE_CLAN_MELEE_FOREST', 'ANY', '1');


INSERT INTO BarbarianTribe_MapConditions(MapConditionSetType, TerrainType, FeatureType, ResourceType, Range, Invert) VALUES
('TRIBE_CONDITION_SET_LIZARDMEN', NULL, 'FEATURE_JUNGLE', NULL,  '1', '0'),
('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_GRASS', 'TERRAIN_GRASS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_PLAINS', 'TERRAIN_PLAINS', NULL, NULL, '1', '0'),
-- ('TRIBE_CONDITION_SET_LIZARDMAN_OPEN_TUNDRA', 'TERRAIN_TUNDRA_HILLS', NULL, NULL, '1', '0'),
-- ('TRIBE_CONDITION_SET_LIZARDMAN_TUNDRA_HILLS', 'TERRAIN_TUNDRA_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_LIZARDMAN_GRASS_HILLS', 'TERRAIN_GRASS_HILLS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_LIZARDMAN_PLAINS_HILLS', 'TERRAIN_PLAINS_HILLS', NULL, NULL, '1', '0');


INSERT INTO BarbarianTribeNames(TribeNameType, TribeType, TribeDisplayName)VALUES
('BARBARIAN_CLAN_LIZARDMEN_1', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_2', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_3', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_4', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_5', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_6', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_7', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_8', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_9', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_10', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_11', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_12', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_13', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_14', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_15', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_16', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_17', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_18', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_19', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1'),
('BARBARIAN_CLAN_LIZARDMEN_20', 'TRIBE_CLAN_MELEE_FOREST', 'LOC_BARBARIAN_CLAN_LIZARDMEN_1');

---------------------------------------------------------------------- maybe change city attacking
UPDATE BarbarianTribes SET Name='LOC_BARBARIAN_CLAN_TYPE_BEARS', ScoutTag='CLASS_BEAR', MeleeTag='CLASS_BEAR',
                           RangedTag='CLASS_BEAR', SiegeTag='CLASS_BEAR', DefenderTag='CLASS_BEAR',
                           SupportTag='CLASS_BEAR', PercentRangedUnits='0', TurnsToWarriorSpawn='10'
                       WHERE TribeType='TRIBE_CLAN_CAVALRY_OPEN';

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_BEAR', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_BEAR', 'CLASS_BEAR');
-- Bears cant spawn for some reason


INSERT INTO BarbarianTribe_MapConditions(MapConditionSetType, TerrainType, FeatureType, ResourceType, Range, Invert) VALUES
('TRIBE_CONDITION_SET_BEARS_OPEN_TUNDRA', 'TERRAIN_TUNDRA', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_BEARS_OPEN_SNOW', 'TERRAIN_SNOW', NULL, NULL, '1', '0');

INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_BEARS_OPEN_TUNDRA', 'TRIBE_CLAN_CAVALRY_OPEN', 'ALL', '1'),
('TRIBE_CONDITION_SET_BEARS_OPEN_SNOW', 'TRIBE_CLAN_CAVALRY_OPEN', 'ALL', '1');

INSERT INTO BarbarianTribeNames(TribeNameType, TribeType, TribeDisplayName)VALUES
('BARBARIAN_CLAN_BEARS_1', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_2', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_3', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_4', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_5', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_6', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_7', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_8', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_9', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_10', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_11', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_12', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_13', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_14', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_15', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_16', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_17', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_18', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_19', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1'),
('BARBARIAN_CLAN_BEARS_20', 'TRIBE_CLAN_CAVALRY_OPEN', 'LOC_BARBARIAN_CLAN_BEAR_1');

DELETE FROM BarbarianTribeForces WHERE TribeType='TRIBE_CLAN_CAVALRY_OPEN';

---------------------------------------------------------------------- maybe change city attacking
UPDATE BarbarianTribes SET Name='LOC_BARBARIAN_CLAN_TYPE_LIONS', ScoutTag='CLASS_NULL', MeleeTag='CLASS_LION',
                           RangedTag='CLASS_LION', SiegeTag='CLASS_LION', DefenderTag='CLASS_LION',
                           SupportTag='CLASS_LION', PercentRangedUnits='0', TurnsToWarriorSpawn='10'
                       WHERE TribeType='TRIBE_CLAN_CAVALRY_CHARIOT';

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_LION', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_LION', 'CLASS_LION'),
('SLTH_UNIT_LION_PRIDE', 'CLASS_LION');


INSERT INTO BarbarianTribe_MapConditions(MapConditionSetType, TerrainType, FeatureType, ResourceType, Range, Invert) VALUES
('TRIBE_CONDITION_SET_LION_OPEN_PLAINS', 'TERRAIN_PLAINS', NULL, NULL, '1', '0'),
('TRIBE_CONDITION_SET_LION_OPEN_DESERT', 'TERRAIN_DESERT', NULL, NULL, '1', '0');

INSERT INTO BarbarianTribe_MapConditionSets(MapConditionSetType, TribeType, Test, Priority) VALUES
('TRIBE_CONDITION_SET_LION_OPEN_PLAINS', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'ALL', '1'),
('TRIBE_CONDITION_SET_LION_OPEN_DESERT', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'ALL', '1');

INSERT INTO BarbarianTribeNames(TribeNameType, TribeType, TribeDisplayName)VALUES
('BARBARIAN_CLAN_LIONS_1', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_2', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_3', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_4', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_5', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_6', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_7', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_8', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_9', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_10', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_11', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_12', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_13', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_14', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_15', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_16', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_17', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_18', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_19', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1'),
('BARBARIAN_CLAN_LIONS_20', 'TRIBE_CLAN_CAVALRY_CHARIOT', 'LOC_BARBARIAN_CLAN_LION_1');

DELETE FROM BarbarianTribeForces WHERE TribeType='TRIBE_CLAN_CAVALRY_OPEN';

-- Convert city states to all militaristic
UPDATE TypeProperties SET Value= 'MILITARISTIC' WHERE Name= 'CityStateCategory';

DELETE FROM TraitModifiers  WHERE ModifierId = 'MINOR_CIV_MILITARISTIC_SMALL_INFLUENCE_CAPITAL';
DELETE FROM TraitModifiers  WHERE ModifierId = 'MINOR_CIV_MILITARISTIC_SMALL_INFLUENCE_ETHIOPIA';
DELETE FROM TraitModifiers  WHERE ModifierId = 'MINOR_CIV_MILITARISTIC_MEDIUM_INFLUENCE_ETHIOPIA';
DELETE FROM TraitModifiers  WHERE ModifierId = 'MINOR_CIV_MILITARISTIC_MEDIUM_INFLUENCE_ARMORY';
DELETE FROM TraitModifiers  WHERE ModifierId = 'MINOR_CIV_MILITARISTIC_LARGE_INFLUENCE_ETHIOPIA';
DELETE FROM TraitModifiers  WHERE ModifierId = 'MINOR_CIV_MILITARISTIC_LARGE_INFLUENCE_MILITARY_ACADEMY';

UPDATE Leaders SET InheritFrom = 'LEADER_MINOR_CIV_MILITARISTIC'
               WHERE InheritFrom IN ('LEADER_MINOR_CIV_INDUSTRIAL', 'LEADER_MINOR_CIV_SCIENTIFIC',
                                     'LEADER_MINOR_CIV_TRADE', 'LEADER_MINOR_CIV_RELIGIOUS',
                                     'LEADER_MINOR_CIV_CULTURAL');

INSERT INTO Types(Type, Kind) VALUES
('TRIBE_CONDITION_SET_LIZARDMEN', 'KIND_TRIBE_MAP_CONDITION_SET'),
('BARBARIAN_CLAN_SKELETON_1', 'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_2',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_3',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_4',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_5',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_6',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_7',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_8',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_9',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_10',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_11',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_12',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_13',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_14',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_15',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_16',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_17',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_18',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_19',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_SKELETON_20',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_1', 'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_2',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_3',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_4',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_5',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_6',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_7',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_8',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_9',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_10',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_11',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_12',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_13',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_14',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_15',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_16',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_17',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_18',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_19',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIZARDMEN_20', 'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_1', 'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_2',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_3',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_4',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_5',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_6',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_7',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_8',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_9',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_10',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_11',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_12',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_13',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_14',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_15',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_16',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_17',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_18',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_19',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_BEARS_20',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_1', 'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_2',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_3',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_4',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_5',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_6',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_7',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_8',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_9',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_10',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_11',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_12',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_13',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_14',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_15',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_16',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_17',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_18',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_19',  'KIND_BARBARIAN_TRIBE'),
('BARBARIAN_CLAN_LIONS_20',  'KIND_BARBARIAN_TRIBE');

