INSERT INTO Types(Type, Kind) VALUES
('BUILDING_ANGKOR_WAT', 'KIND_BUILDING'),
('FEATURE_HA_LONG_BAY', 'KIND_FEATURE');

-- feature ha long bay TODO

INSERT INTO Features (FeatureType, Name, Description, Quote, Coast, NoCoast, NoRiver, NoAdjacentFeatures, RequiresRiver, MovementChange, SightThroughModifier, Impassable, NaturalWonder, RemoveTech, Removable, AddCivic, DefenseModifier, AddsFreshWater, Appeal, MinDistanceLand, MaxDistanceLand, NotNearFeature, Lake, Tiles, Adjacent, NoResource, DoubleAdjacentTerrainYield, NotCliff, MinDistanceNW, CustomPlacement, Forest, AntiquityPriority, QuoteAudio, Settlement, FollowRulesInWB, DangerValue) VALUES
('FEATURE_HA_LONG_BAY', 'LOC_FEATURE_HA_LONG_BAY_NAME', 'LOC_FEATURE_HA_LONG_BAY_DESCRIPTION', 'LOC_FEATURE_HA_LONG_BAY_QUOTE', 0, 0, 0, 0, 0, 0, 0, 0, 1, null, 0, null, 15, 0, 2, 1, 1, 0, 0, 2, 1, 0, 0, 0, 8, null, 0, 0, 'PLAY_HA_LONG_BAY_QUOTE', 0, 0, 0);
