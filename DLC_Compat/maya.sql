INSERT INTO Types(Type, Kind) VALUES
('RESOURCE_MAIZE', 'KIND_RESOURCE'),
('FEATURE_FOUNTAIN_OF_YOUTH', 'KIND_FEATURE'),
('FEATURE_PAITITI', 'KIND_FEATURE');


INSERT INTO Features (FeatureType, Name, Description, Quote, Coast, NoCoast, NoRiver, NoAdjacentFeatures, RequiresRiver, MovementChange, SightThroughModifier, Impassable, NaturalWonder, RemoveTech, Removable, AddCivic, DefenseModifier, AddsFreshWater, Appeal, MinDistanceLand, MaxDistanceLand, NotNearFeature, Lake, Tiles, Adjacent, NoResource, DoubleAdjacentTerrainYield, NotCliff, MinDistanceNW, CustomPlacement, Forest, AntiquityPriority, QuoteAudio, Settlement, FollowRulesInWB, DangerValue) VALUES
('FEATURE_FOUNTAIN_OF_YOUTH', 'LOC_FEATURE_FOUNTAIN_OF_YOUTH_NAME', 'LOC_FEATURE_FOUNTAIN_OF_YOUTH_DESCRIPTION', 'LOC_FEATURE_FOUNTAIN_OF_YOUTH_QUOTE', 0, 1, 1, 0, 0, 0, 0, 0, 1, null, 0, null, 0, 1, 2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 8, null, 0, 0, 'PLAY_FOUNTAIN_OF_YOUTH_QUOTE_1', 0, 0, 0),
('FEATURE_PAITITI', 'LOC_FEATURE_PAITITI_NAME', 'LOC_FEATURE_PAITITI_DESCRIPTION', 'LOC_FEATURE_PAITITI_QUOTE', 0, 1, 1, 0, 0, 0, 0, 1, 1, null, 0, null, 0, 0, 2, 0, 0, 0, 0, 3, 1, 0, 0, 0, 8, 'PLACEMENT_PAITITI', 0, 0, 'PLAY_PAITITI_QUOTE_1', 0, 0, 0);

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('TRAIT_NO_FRESH_WATER_HOUSING', 'MODIFIER_PLAYER_CITIES_ADJUST_NO_FRESH_WATER_HOUSING');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('TRAIT_NO_FRESH_WATER_HOUSING', 'NoHousing', 'true');
