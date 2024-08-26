INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_CALABIM', 'LOC_CIV_CALABIM_NAME', 'LOC_CIV_CALABIM_DESCRIPTION', 'LOC_SLTH_CIV_CALABIM_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_ALEXIS', 'LOC_SLTH_LEADER_ALEXIS_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_FLAUROS', 'LOC_SLTH_LEADER_FLAUROS_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_ALEXIS', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME'),
('SLTH_LEADER_FLAUROS', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME'),
('SLTH_LEADER_DECIUS', 'SLTH_CIVILIZATION_CALABIM', 'LOC_CITY_CALABIM_1_NAME');

INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_CALABIM_COOL'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_MOROI'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE'),
('SLTH_CIVILIZATION_CALABIM', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_CALABIM_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_CALABIM_COOL_DESCRIPTION'),
('NULL_CIVILIZATION_CALABIM', 'LOC_SLTH_NULL_CIVILIZATION_CALABIM_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MOROI_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MOROI_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_GRANT_TECH_EXPLORATION'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_BAN_SLTH_UNIT_CANNON'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_BODY'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_SMALL_ADJUST_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_LAW'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'MODIFIER_SLTH_GRANT_MANA_SHADOW');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_GOVERNORS_MANOR', 'SLTH_BUILDING_COURTHOUSE'),
('SLTH_BUILDING_NULL_CIVILIZATION_CALABIM_ALCHEMY_LAB', 'SLTH_BUILDING_ALCHEMY_LAB'),
('SLTH_BUILDING_NULL_CIVILIZATION_CALABIM_ELDER_COUNCIL', 'SLTH_BUILDING_ELDER_COUNCIL'),
('SLTH_BUILDING_NULL_CIVILIZATION_SHEAIM_TRAINING_YARD', 'SLTH_BUILDING_TRAINING_YARD');
INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_CALABIM', 'KIND_CIVILIZATION'),
('SLTH_LEADER_ALEXIS', 'KIND_LEADER'),
('SLTH_LEADER_FLAUROS', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_CALABIM_COOL', 'KIND_TRAIT'),
('NULL_CIVILIZATION_CALABIM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_GOVERNORS_MANOR', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_BREEDING_PIT', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BLOODPET', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', 'KIND_TRAIT');