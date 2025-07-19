INSERT INTO RulesetDomainOverrides (Ruleset, PlayerId, ParameterId, Domain) VALUES
('RULESET_EXPANSION_2', 1, 'PlayerLocked', 'PlayerLockedAlwaysLocked'),
('RULESET_EXPANSION_2', 2, 'PlayerLocked', 'PlayerLockedAlwaysLocked');

INSERT INTO RulesetSupportedValues (Ruleset, PlayerId, Domain, Value) VALUES
('RULESET_EXPANSION_2', 1, 'Players:Expansion2_Players', 'LEADER_BASIUM'),
('RULESET_EXPANSION_2', 2, 'Players:Expansion2_Players', 'LEADER_HYBOREM');

INSERT INTO RulesetUnsupportedValues(Ruleset, PlayerId, Domain, Value) VALUES
('RULESET_EXPANSION_2', '0', 'Players:Expansion2_Players', 'LEADER_BASIUM'),
('RULESET_EXPANSION_2', '0', 'Players:Expansion2_Players', 'LEADER_HYBOREM');

UPDATE MapSizes SET MinPlayers=4 WHERE MinPlayers=2 or MinPlayers=3;
UPDATE MapSizes SET DefaultPlayers=4 WHERE DefaultPlayers=2 or DefaultPlayers=3;
UPDATE MapSizes SET MaxPlayers=4 WHERE MaxPlayers=2 or MaxPlayers=3;


INSERT INTO Maps(Domain, File, Name, Description, Image, SortIndex) VALUES
('StandardMaps', 'Erebus.lua', 'LOC_MAP_SLTH_EREBUS_NAME', 'LOC_MAP_SLTH_EREBUS_DESCRIPTION', 'Map_Highlands', 130);

INSERT INTO Parameters(Key1, Key2, ParameterId, Name, Description, Domain, DefaultValue, ConfigurationGroup, ConfigurationId, GroupId, Hash, SortIndex) VALUES
('Map', 'Erebus.lua', 'Temperature', 'LOC_MAP_TEMPERATURE_NAME', 'LOC_MAP_TEMPERATURE_DESCRIPTION', 'Temperature', '2', 'Map', 'temperature', 'MapOptions', '0', '240'),
('Map', 'Erebus.lua', 'Rainfall', 'LOC_MAP_RAINFALL_NAME', 'LOC_MAP_RAINFALL_DESCRIPTION', 'Rainfall', '2', 'Map', 'rainfall', 'MapOptions', '0', '250'),
('Map', 'Erebus.lua', 'WorldAge', 'LOC_MAP_WORLD_AGE_NAME', 'LOC_MAP_WORLD_AGE_DESCRIPTION', 'WorldAge', '2', 'Map', 'world_age', 'MapOptions', '0', '250'),
('Map', 'Erebus.lua', 'SeaLevel', 'LOC_MAP_SEA_LEVEL_NAME', 'LOC_MAP_SEA_LEVEL_LOW_DESCRIPTION', 'SeaLevel', '2', 'Map', 'sea_level', 'MapOptions', '0', '250');

-- for some reason we need to delete continents to have it show
DELETE FROM Maps where File='Continents.lua';
DELETE FROM Parameters where Key2 ='Continents.lua';

UPDATE Parameters SET DefaultValue='Erebus.lua' WHERE DefaultValue='Continents.lua';
UPDATE Parameters SET DefaultValue='Erebus.lua' WHERE DefaultValue='Pangaea.lua';
UPDATE Parameters SET DefaultValue='Erebus.lua' WHERE ParameterId='Map';

UPDATE Parameters SET DefaultValue=1 WHERE ParameterId='CityStateCount';

UPDATE MapSizes SET DefaultCityStates='1',  MinCityStates= '1', MaxCityStates = '1';

DELETE FROM NaturalWonders WHERE FeatureType NOT IN ('FEATURE_BERMUDA_TRIANGLE', 'FEATURE_FOUNTAIN_OF_YOUTH', 'FEATURE_IKKIL',
                                                        'FEATURE_MATTERHORN', 'FEATURE_TSINGY', 'FEATURE_HA_LONG_BAY',
                                                       'FEATURE_PANTANAL', 'FEATURE_PAITITI', 'FEATURE_EYE_OF_THE_SAHARA',
                                                       'FEATURE_UBSUNUR_HOLLOW', 'FEATURE_GOBUSTAN', 'FEATURE_DELICATE_ARCH',
                                                       'FEATURE_YOSEMITE', 'FEATURE_DEVILSTOWER', 'FEATURE_CHOCOLATEHILLS',
                                                       'FEATURE_TORRES_DEL_PAINE');

UPDATE NaturalWonders SET Name='LOC_FEATURE_MAELSTROM_NAME', Description='LOC_FEATURE_MAELSTROM_DESCRIPTION' WHERE FeatureType='FEATURE_BERMUDA_TRIANGLE';
UPDATE NaturalWonders SET Name='LOC_FEATURE_POOL_OF_TEARS_NAME', Description='LOC_FEATURE_POOL_OF_TEARS_DESCRIPTION' WHERE FeatureType='FEATURE_FOUNTAIN_OF_YOUTH';
UPDATE NaturalWonders SET Name='LOC_FEATURE_MIRROR_OF_HEAVEN_NAME', Description='LOC_FEATURE_MIRROR_OF_HEAVEN_DESCRIPTION' WHERE FeatureType='FEATURE_IKKIL';
UPDATE NaturalWonders SET Name='LOC_FEATURE_PRISTIN_NAME', Description='LOC_FEATURE_PRISTIN_DESCRIPTION' WHERE FeatureType='FEATURE_MATTERHORN';
UPDATE NaturalWonders SET Name='LOC_FEATURE_STANDING_STONES_NAME', Description='LOC_FEATURE_STANDING_STONES_DESCRIPTION' WHERE FeatureType='FEATURE_TSINGY';
UPDATE NaturalWonders SET FeatureType= 'FEATURE_NWON_TOMB_OF_SUCELLUS', Name='LOC_FEATURE_TOMB_NAME', Description='LOC_FEATURE_TOMB_DESCRIPTION' WHERE FeatureType='FEATURE_HA_LONG_BAY';
UPDATE NaturalWonders SET FeatureType= 'FEATURE_NWON_YGGDRASIL',Name='LOC_FEATURE_YGGDRASIL_NAME', Description='LOC_FEATURE_YGGDRASIL_DESCRIPTION' WHERE FeatureType='FEATURE_PANTANAL';
UPDATE NaturalWonders SET FeatureType= 'FEATURE_NWON_REMNANTS_OF_PATRIA',Name='LOC_FEATURE_PATRIA_NAME', Description='LOC_FEATURE_PATRIA_DESCRIPTION' WHERE FeatureType='FEATURE_PAITITI';
UPDATE NaturalWonders SET Name='LOC_FEATURE_FRIGUS_NAME', Description='LOC_FEATURE_FRIGUS_DESCRIPTION' WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW';
UPDATE NaturalWonders SET Name='LOC_FEATURE_BONES_NAME', Description='LOC_FEATURE_BONES_DESCRIPTION' WHERE FeatureType='FEATURE_EYE_OF_THE_SAHARA';
UPDATE NaturalWonders SET FeatureType= 'FEATURE_NWON_BRADELINES_WELL',Name='LOC_FEATURE_WELL_NAME', Description='LOC_FEATURE_WELL_DESCRIPTION' WHERE FeatureType='FEATURE_GOBUSTAN';
UPDATE NaturalWonders SET Name='LOC_FEATURE_SEPULCHER_NAME', Description='LOC_FEATURE_SEPULCHER_DESCRIPTION' WHERE FeatureType='FEATURE_DELICATE_ARCH';
UPDATE NaturalWonders SET Name='LOC_FEATURE_PYRE_NAME', Description='LOC_FEATURE_PYRE_DESCRIPTION' WHERE FeatureType='FEATURE_YOSEMITE';
UPDATE NaturalWonders SET Name='LOC_FEATURE_MAENALUS_NAME', Description='LOC_FEATURE_MAENALUS_DESCRIPTION' WHERE FeatureType='FEATURE_BARRIER_REEF';
UPDATE NaturalWonders SET Name='LOC_FEATURE_ODIO_NAME', Description='LOC_FEATURE_ODIO_DESCRIPTION' WHERE FeatureType='FEATURE_DEVILSTOWER';
UPDATE NaturalWonders SET FeatureType= 'FEATURE_NWON_SEVEN_PINES', Name='LOC_FEATURE_PINES_NAME', Description='LOC_FEATURE_PINES_DESCRIPTION' WHERE FeatureType='FEATURE_CHOCOLATEHILLS';
UPDATE NaturalWonders SET Name='LOC_FEATURE_CARCER_NAME', Description='LOC_FEATURE_CARCER_DESCRIPTION' WHERE FeatureType='FEATURE_TORRES_DEL_PAINE';
