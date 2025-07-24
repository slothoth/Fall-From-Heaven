INSERT INTO Buildings(BuildingType, Name, Description, Cost) VALUES
('BUILDING_TEMPLE_ARTEMIS', 'NULL', 'NULL', '1'),
-- ('BUILDING_MONT_ST_MICHEL', 'NULL', 'NULL', '1'),
-- ('BUILDING_LIBRARY', 'NULL', 'NULL', '1'),
('BUILDING_UNIVERSITY', 'NULL', 'NULL', '1');
-- ('BUILDING_RESEARCH_LAB', 'NULL', 'NULL', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Description, Cost, FormationClass, Domain) VALUES
('UNIT_MECHANIZED_INFANTRY', 'NULL', 2, 2, 'NULL', 1, 'FORMATION_CLASS_LAND_COMBAT', 'DOMAIN_LAND');

-- INSERT INTO Districts (DistrictType, Name, Cost, RequiresPlacement, NoAdjacentCity, Aqueduct, InternalOnly, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, PlunderAmount, MilitaryDomain) VALUES
-- ('DISTRICT_CAMPUS', 'LOC_DISTRICT_CAMPUS_NAME', 54, 1, 0, 0, 0, 0, 0, 'PLUNDER_SCIENCE', 25, 'NO_DOMAIN');
