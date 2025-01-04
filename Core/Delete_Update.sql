UPDATE Route_ValidBuildUnits SET UnitType = 'UNIT_BUILDER' WHERE UnitType = 'UNIT_MILITARY_ENGINEER';
UPDATE Building_BuildChargeProductions SET UnitType = 'UNIT_BUILDER' WHERE UnitType = 'UNIT_MILITARY_ENGINEER';
UPDATE District_BuildChargeProductions SET UnitType = 'UNIT_BUILDER' WHERE UnitType = 'UNIT_MILITARY_ENGINEER';
DELETE FROM Routes WHERE RouteType == 'ROUTE_RAILROAD' OR RouteType == 'ROUTE_MODERN_ROAD' OR RouteType == 'ROUTE_INDUSTRIAL_ROAD';
UPDATE Routes SET MovementCost = 0.5 WHERE RouteType == 'ROUTE_ANCIENT_ROAD';
UPDATE Routes SET MovementCost = 0.5 WHERE RouteType == 'ROUTE_MEDIEVAL_ROAD';          -- how to absorb engineering buffing roads?


UPDATE Eras SET TechTreeLayoutMethod='Prereq';
DELETE FROM Technologies;
DELETE FROM TechnologyPrereqs;
DELETE FROM Technologies_XP2;
DELETE FROM Civics;
DELETE FROM Boosts;
DELETE FROM Policies;
DELETE FROM CivicPrereqs;
DELETE FROM Civics_XP2;
DELETE FROM Building_GreatPersonPoints;
DELETE FROM Unit_BuildingPrereqs;
DELETE FROM UnitUpgrades;
DELETE FROM UnitPromotionPrereqs;
DELETE FROM UnitPromotionModifiers;
DELETE FROM UnitPromotions;
DELETE FROM Improvements WHERE ImprovementType NOT IN('IMPROVEMENT_FARM', 'IMPROVEMENT_MINE', 'IMPROVEMENT_QUARRY', 'IMPROVEMENT_FISHING_BOATS', 'IMPROVEMENT_PASTURE', 'IMPROVEMENT_PLANTATION', 'IMPROVEMENT_CAMP', 'IMPROVEMENT_LUMBER_MILL', 'IMPROVEMENT_FORT', 'IMPROVEMENT_GOODY_HUT', 'IMPROVEMENT_BARBARIAN_CAMP');
DELETE FROM Improvement_ValidBuildUnits WHERE ImprovementType NOT IN('IMPROVEMENT_FARM', 'IMPROVEMENT_MINE', 'IMPROVEMENT_QUARRY', 'IMPROVEMENT_FISHING_BOATS', 'IMPROVEMENT_PASTURE', 'IMPROVEMENT_PLANTATION', 'IMPROVEMENT_CAMP', 'IMPROVEMENT_LUMBER_MILL', 'IMPROVEMENT_FORT', 'IMPROVEMENT_GOODY_HUT', 'IMPROVEMENT_BARBARIAN_CAMP');
DELETE FROM Improvement_ValidTerrains WHERE ImprovementType NOT IN('IMPROVEMENT_FARM', 'IMPROVEMENT_MINE', 'IMPROVEMENT_QUARRY', 'IMPROVEMENT_FISHING_BOATS', 'IMPROVEMENT_PASTURE', 'IMPROVEMENT_PLANTATION', 'IMPROVEMENT_CAMP', 'IMPROVEMENT_LUMBER_MILL', 'IMPROVEMENT_FORT', 'IMPROVEMENT_GOODY_HUT', 'IMPROVEMENT_BARBARIAN_CAMP');
DELETE FROM Improvement_ValidResources WHERE ImprovementType NOT IN('IMPROVEMENT_FARM', 'IMPROVEMENT_MINE', 'IMPROVEMENT_QUARRY', 'IMPROVEMENT_FISHING_BOATS', 'IMPROVEMENT_PASTURE', 'IMPROVEMENT_PLANTATION', 'IMPROVEMENT_CAMP', 'IMPROVEMENT_LUMBER_MILL', 'IMPROVEMENT_FORT', 'IMPROVEMENT_GOODY_HUT', 'IMPROVEMENT_BARBARIAN_CAMP');
DELETE FROM Units WHERE UnitType NOT IN ('UNIT_GREAT_GENERAL', 'UNIT_GREAT_ADMIRAL', 'UNIT_GREAT_ENGINEER', 'UNIT_GREAT_MERCHANT', 'UNIT_GREAT_PROPHET', 'UNIT_GREAT_SCIENTIST', 'UNIT_GREAT_WRITER', 'UNIT_GREAT_ARTIST', 'UNIT_GREAT_MUSICIAN', 'UNIT_BUILDER', 'UNIT_TRADER', 'UNIT_SETTLER', 'UNIT_WARRIOR');
DELETE FROM Buildings WHERE BuildingType NOT IN ('BUILDING_PALACE');
DELETE FROM Building_YieldChanges WHERE BuildingType != 'BUILDING_PALACE';
DELETE FROM UnitPromotionClasses WHERE PromotionClassType NOT IN ('PROMOTION_CLASS_MELEE', 'PROMOTION_CLASS_RANGED', 'PROMOTION_CLASS_RECON', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'PROMOTION_CLASS_NAVAL_MELEE', 'PROMOTION_CLASS_SIEGE');
DELETE FROM Projects WHERE ProjectType NOT IN ('PROJECT_ENHANCE_DISTRICT_ENCAMPMENT', 'PROJECT_ENHANCE_DISTRICT_HARBOR', 'PROJECT_ENHANCE_DISTRICT_INDUSTRIAL_ZONE', 'PROJECT_ENHANCE_DISTRICT_COMMERCIAL_HUB', 'PROJECT_ENHANCE_DISTRICT_HOLY_SITE', 'PROJECT_ENHANCE_DISTRICT_CAMPUS', 'PROJECT_ENHANCE_DISTRICT_THEATER', 'PROJECT_BREAD_AND_CIRCUSES', 'PROJECT_LAUNCH_EARTH_SATELLITE', 'PROJECT_LAUNCH_MOON_LANDING');
DELETE FROM Resources WHERE ResourceType NOT IN ('RESOURCE_COPPER', 'RESOURCE_IRON', 'RESOURCE_MARBLE', 'RESOURCE_DEER', 'RESOURCE_FISH', 'RESOURCE_RICE', 'RESOURCE_SHEEP', 'RESOURCE_WHEAT', 'RESOURCE_INCENSE', 'RESOURCE_IVORY', 'RESOURCE_SILK', 'RESOURCE_SUGAR', 'RESOURCE_WINE', 'RESOURCE_COTTON');
DELETE FROM Governments WHERE GovernmentType NOT IN ('GOVERNMENT_CHIEFDOM');
DELETE FROM Districts WHERE DistrictType NOT IN ('DISTRICT_CITY_CENTER', 'DISTRICT_HOLY_SITE', 'DISTRICT_CAMPUS', 'DISTRICT_HARBOR', 'DISTRICT_ENCAMPMENT', 'DISTRICT_COMMERCIAL_HUB', 'DISTRICT_THEATER', 'DISTRICT_ENTERTAINMENT_COMPLEX', 'DISTRICT_INDUSTRIAL_ZONE', 'DISTRICT_AQUEDUCT', 'DISTRICT_WONDER');
DELETE FROM District_Adjacencies;
DELETE FROM District_GreatPersonPoints;
UPDATE Districts SET Cost=1, PlunderAmount=0, PlunderType='NO_PLUNDER', CostProgressionModel='NO_COST_PROGRESSION', CostProgressionParam1=0, CitystrengthModifier=0 WHERE RequiresPopulation=1;
UPDATE Districts SET RequiresPopulation=0 WHERE RequiresPopulation=1;
UPDATE District_TradeRouteYields SET YieldChangeAsDomesticDestination = 0.0 WHERE YieldChangeAsDomesticDestination != 0.0;          -- trade imbalance issues, todo
-- uodate District_CitizenYieldChanges to give specialists right amount, for ex scientists are two, not three. check ffh for vals
DELETE FROM GreatPersonIndividuals;

DELETE FROM Features WHERE NaturalWonder = 1 AND FeatureType NOT IN ('FEATURE_BERMUDA_TRIANGLE', 'FEATURE_FOUNTAIN_OF_YOUTH', 'FEATURE_IKKIL', 'FEATURE_MATTERHORN', 'FEATURE_TSINGY', 'FEATURE_HA_LONG_BAY', 'FEATURE_PANTANAL', 'FEATURE_PAITITI', 'FEATURE_UBSUNUR_HOLLOW', 'FEATURE_EYE_OF_THE_SAHARA', 'FEATURE_GOBUSTAN', 'FEATURE_DELICATE_ARCH', 'FEATURE_YOSEMITE', 'FEATURE_BARRIER_REEF', 'FEATURE_DEVILSTOWER', 'FEATURE_CHOCOLATEHILLS', 'FEATURE_TORRES_DEL_PAINE');
DELETE FROM Eras WHERE EraType IN ('ERA_MODERN', 'ERA_ATOMIC', 'ERA_INFORMATION', 'ERA_FUTURE');

UPDATE Districts SET PrereqCivic = 'CIVIC_MYSTICISM' WHERE DistrictType = 'DISTRICT_HOLY_SITE';
UPDATE Districts SET PrereqCivic = 'CIVIC_MYSTICISM' WHERE DistrictType = 'DISTRICT_CAMPUS';
UPDATE Districts SET PrereqTech = 'TECH_BRONZE_WORKING' WHERE DistrictType = 'DISTRICT_ENCAMPMENT';
UPDATE Districts SET PrereqTech = 'TECH_FISHING' WHERE DistrictType = 'DISTRICT_HARBOR';
UPDATE Districts SET PrereqCivic = 'CIVIC_GAMES_RECREATION' WHERE DistrictType = 'DISTRICT_COMMERCIAL_HUB';
UPDATE Districts SET PrereqCivic = 'CIVIC_GAMES_RECREATION' WHERE DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX';
UPDATE Districts SET PrereqCivic = 'CIVIC_GAMES_RECREATION' WHERE DistrictType = 'DISTRICT_THEATER';
UPDATE Districts SET PrereqTech = 'TECH_SMELTING' WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';
UPDATE Districts SET PrereqTech = 'TECH_SANITATION' WHERE DistrictType = 'DISTRICT_AQUEDUCT';

-- UPDATE Building_YieldChanges SET YieldChange = 100 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_CULTURE';
-- UPDATE Building_YieldChanges SET YieldChange = 999 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_GOLD';
-- UPDATE Building_YieldChanges SET YieldChange = 50 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_PRODUCTION';
-- UPDATE Building_YieldChanges SET YieldChange = 50 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_SCIENCE';

-- INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES('BUILDING_PALACE', 'CONTRATACION_GOVERNOR_POINTS')

-- for debug
INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_AIR'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_BODY'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_CHAOS'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_DEATH'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_EARTH'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_ENCHANTMENT'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_ENTROPY'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_FIRE'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_ICE'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_LAW'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_LIFE'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_METAMAGIC'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_MIND'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_NATURE'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_SHADOW'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_SPIRIT'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_SUN'),
('BUILDING_PALACE', 'MODIFIER_SLTH_GRANT_MANA_WATER');