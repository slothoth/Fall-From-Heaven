INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES                             -- improvements
('ICON_IMPROVEMENT_TOWN', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNIT_ACTIONS', 0);


INSERT INTO IconDefinitions(Name, Atlas, 'Index') VALUES                                     -- resources
('ICON_RESOURCE_CORN', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_RESOURCES', '1'),
('ICON_RESOURCE_CORN_FOW', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_RESOURCES_FOW', '1');

INSERT INTO IconDefinitions(Name, Atlas, 'Index') VALUES                                     -- units
('ICON_UNIT_SLTH_JAVELIN_THROWER', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS' , '0'),
('ICON_UNIT_SLTH_TASKMASTER', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS' , '3'),
('ICON_UNIT_SLTH_SHAMAN', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS' , '4'),
('ICON_UNIT_SLTH_YERSINIA', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS' , '1');

-- Unit portraits borrowed from the base/DLC unit that shares the unit's member type.
-- Rows marked 'placeholder art' reuse stand-in art and need a portrait of their own later.
INSERT OR REPLACE INTO IconDefinitions(Name, Atlas, 'Index') VALUES
('ICON_UNIT_SLTH_FLAGBEARER_PORTRAIT', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNIT_PORTRAITS', '4'),	-- UNIT_SOOTHSAYER (GranColombia_Maya)  -- placeholder art: needs its own portrait
('ICON_UNIT_SLTH_JAVELIN_THROWER_PORTRAIT', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNIT_PORTRAITS', '0'),	-- UNIT_MAYAN_HULCHE (GranColombia_Maya)
('ICON_UNIT_SLTH_TASKMASTER_PORTRAIT', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNIT_PORTRAITS', '3');	-- UNIT_LAHORE_NIHANG (GranColombia_Maya)
