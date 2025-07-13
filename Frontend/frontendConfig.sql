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
