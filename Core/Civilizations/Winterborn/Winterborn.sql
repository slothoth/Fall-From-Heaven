INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('TRAIT_GRANT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_CITY_ATTACH', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 0, 0, NULL),
('GRANT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_CITY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('TRAIT_GRANT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_CITY_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'GRANT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_CITY'),
('GRANT_WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH_CITY', 'AbilityType', 'ARGTYPE_IDENTITY', 'WINTERBORN_ABILITY_TUNDRA_SNOW_STRENGTH');