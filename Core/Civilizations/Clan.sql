INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'LOC_CIV_CLAN_OF_EMBERS_NAME', 'LOC_CIV_CLAN_OF_EMBERS_DESCRIPTION', 'LOC_SLTH_CIV_CLAN_OF_EMBERS_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_JONAS', 'LOC_SLTH_LEADER_JONAS_NAME', 'LEADER_DEFAULT'),
('SLTH_LEADER_SHEELBA', 'LOC_SLTH_LEADER_SHEELBA_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_JONAS', 'SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'LOC_CITY_CLAN_OF_EMBERS_1_NAME'),
('SLTH_LEADER_SHEELBA', 'SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'LOC_CITY_CLAN_OF_EMBERS_1_NAME');

INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_BUILDING_WARRENS'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_RANTINE'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_ASSASSIN'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_OGRE'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_DRUID'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_WARCHIEF'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_STONESKIN_OGRE'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_BEASTMASTER'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_SHAMAN'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_RANGER'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN'),
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('NULL_CIVILIZATION_CLAN_OF_EMBERS', 'LOC_SLTH_NULL_CIVILIZATION_CLAN_OF_EMBERS_NAME', 'LOC_NULL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ARCHER_SCORPION_CLAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ARCHER_SCORPION_CLAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ARCHER_SCORPION_CLAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CHARIOT_SCORPION_CLAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CHARIOT_SCORPION_CLAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_CHARIOT_SCORPION_CLAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER_SCORPION_CLAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER_SCORPION_CLAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER_SCORPION_CLAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN_SCORPION_CLAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN_SCORPION_CLAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN_SCORPION_CLAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_WARRENS', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_WARRENS_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_BUILDING_WARRENS_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_RANTINE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_RANTINE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_RANTINE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_ASSASSIN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_ASSASSIN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_ASSASSIN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_RANGER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_RANGER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_RANGER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_BEASTMASTER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_BEASTMASTER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_BEASTMASTER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_DRUID', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_DRUID_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_DRUID_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_OGRE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_WARCHIEF', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_WARCHIEF_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_WARCHIEF_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_STONESKIN_OGRE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_STONESKIN_OGRE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_STONESKIN_OGRE_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_SHAMAN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_SHAMAN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_SHAMAN_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'MODIFIER_SLTH_GRANT_MANA_FIRE'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'MODIFIER_SLTH_LARGE_ADJUST_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'MODIFIER_SLTH_GRANT_MANA_NATURE'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'MODIFIER_SLTH_GRANT_MANA_BODY'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'TRAIT_GRANT_ORC_ABILITY_FEATUREATTACKS'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'MODIFIER_BAN_SLTH_UNIT_KNIGHT'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'MODIFIER_BAN_SLTH_UNIT_HORSE_ARCHER'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'MODIFIER_BAN_SLTH_UNIT_CANNON');

INSERT INTO BuildingReplaces(CivUniqueBuildingType, ReplacesBuildingType) VALUES
('SLTH_BUILDING_NULL_CIVILIZATION_CLAN_OF_EMBERS_ALCHEMY_LAB', 'SLTH_BUILDING_ALCHEMY_LAB'),
('SLTH_BUILDING_NULL_CIVILIZATION_CLAN_OF_EMBERS_LIBRARY', 'SLTH_BUILDING_LIBRARY'),
('SLTH_BUILDING_NULL_CIVILIZATION_CLAN_OF_EMBERS_MAGE_GUILD', 'SLTH_BUILDING_MAGE_GUILD'),
('SLTH_BUILDING_NULL_CIVILIZATION_CLAN_OF_EMBERS_STABLE', 'SLTH_BUILDING_STABLE');
INSERT INTO Types(Type, Kind) VALUES
('SLTH_CIVILIZATION_CLAN_OF_EMBERS', 'KIND_CIVILIZATION'),
('SLTH_TRAIT_CIVILIZATION_CLAN_OF_EMBERS_COOL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_BUILDING_WARRENS', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_OGRE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_WARCHIEF', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_STONESKIN_OGRE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_DRUID', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_ASSASSIN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_BEASTMASTER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_LIZARDMAN_RANGER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ARCHER_SCORPION_CLAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_CHARIOT_SCORPION_CLAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER_SCORPION_CLAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN_SCORPION_CLAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_SHAMAN', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_RANTINE', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_WOLF_RIDER', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN', 'KIND_TRAIT'),
('NULL_CIVILIZATION_CLAN_OF_EMBERS', 'KIND_TRAIT'),
('SLTH_LEADER_JONAS', 'KIND_LEADER'),
('SLTH_LEADER_SHEELBA', 'KIND_LEADER');
