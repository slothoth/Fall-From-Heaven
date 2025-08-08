-- comppat for not having DLC, but still works in frontend
INSERT OR IGNORE INTO IconTextureAtlases(Name, IconSize, IconsPerRow, IconsPerColumn, Filename) VALUES
('ICON_ATLAS_BABYLON_UNITS', '22', '4', '4' , 'Babylon_Units22.dds'),
('ICON_ATLAS_BABYLON_UNITS', '32', '4', '4' , 'Babylon_Units32.dds'),
('ICON_ATLAS_BABYLON_UNITS', '38', '4', '4' , 'Babylon_Units38.dds'),
('ICON_ATLAS_BABYLON_UNITS', '50', '4', '4' , 'Babylon_Units50.dds'),
('ICON_ATLAS_BABYLON_UNITS', '80', '4', '4' , 'Babylon_Units80.dds'),
('ICON_ATLAS_BABYLON_UNITS', '256', '4', '4' , 'Babylon_Units256.dds');

INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES                 -- units
('ICON_SLTH_UNIT_CHANTER', 'ICON_ATLAS_BABYLON_UNITS' , '0'),
('ICON_SLTH_UNIT_DEVOUT', 'ICON_ATLAS_BABYLON_UNITS' , '0'),
('ICON_SLTH_UNIT_BLACK_WIND', 'ICON_ATLAS_BABYLON_UNITS' , '11');

----------------- BYZANTINE ----------------------------------------
INSERT OR IGNORE INTO IconTextureAtlases(Name, IconSize, IconsPerRow, IconsPerColumn, Filename) VALUES
('ICON_ATLAS_BYZANTIUM_GAUL_UNITS', '22', '4', '1' , 'Gaul_Units22.dds'),
('ICON_ATLAS_BYZANTIUM_GAUL_UNITS', '32', '4', '1' , 'Gaul_Units32.dds'),
('ICON_ATLAS_BYZANTIUM_GAUL_UNITS', '38', '4', '1' , 'Gaul_Units38.dds'),
('ICON_ATLAS_BYZANTIUM_GAUL_UNITS', '50', '4', '1' , 'Gaul_Units50.dds'),
('ICON_ATLAS_BYZANTIUM_GAUL_UNITS', '80', '4', '1' , 'Gaul_Units80.dds'),
('ICON_ATLAS_BYZANTIUM_GAUL_UNITS', '256','4', '1' , 'Gaul_Units256.dds');

INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES                     -- units
('ICON_SLTH_UNIT_ROYAL_GUARD', 'ICON_ATLAS_BYZANTIUM_GAUL_UNITS' , '1'),
('ICON_SLTH_UNIT_BEASTMAN', 'ICON_ATLAS_BYZANTIUM_GAUL_UNITS' , '2');

----------------- ETHIOPIA ----------------------------------------
INSERT OR IGNORE INTO IconTextureAtlases(Name, IconSize, IconsPerRow, IconsPerColumn, Filename) VALUES
('ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', '38', '4', '1' , 'Ethiopia_UnitActions38.dds'),
('ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', '50', '4', '1' , 'Ethiopia_UnitActions50.dds'),
('ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', '80', '4', '1' , 'Ethiopia_UnitActions80.dds'),
('ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', '256','4', '1' , 'Ethiopia_UnitActions256.dds');
INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES
('ICON_PROJECT_ELEGY_OF_THE_SHEAIM', 'ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', 0),
('ICON_PROJECT_BIRTHRIGHT_REGAINED', 'ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', 4);

INSERT OR IGNORE INTO IconTextureAtlases(Name, IconSize, IconsPerRow, IconsPerColumn, Filename) VALUES
('ICON_ATLAS_ETHIOPIA_UNITS', '22', '4', '1' , 'Ethiopia_Units22.dds'),
('ICON_ATLAS_ETHIOPIA_UNITS', '32', '4', '1' , 'Ethiopia_Units32.dds'),
('ICON_ATLAS_ETHIOPIA_UNITS', '38', '4', '1' , 'Ethiopia_Units38.dds'),
('ICON_ATLAS_ETHIOPIA_UNITS', '50', '4', '1' , 'Ethiopia_Units50.dds'),
('ICON_ATLAS_ETHIOPIA_UNITS', '80', '4', '1' , 'Ethiopia_Units80.dds'),
('ICON_ATLAS_ETHIOPIA_UNITS', '256','4', '1' , 'Ethiopia_Units256.dds');
INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES                     -- units
('ICON_SLTH_UNIT_VAMPIRE', 'ICON_ATLAS_ETHIOPIA_UNITS' , '1'),
('ICON_SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL', 'ICON_ATLAS_ETHIOPIA_UNITS' , '0');

----------------- KHMER ----------------------------------------
INSERT OR IGNORE INTO IconTextureAtlases(Name, IconSize, IconsPerRow, IconsPerColumn, Filename) VALUES
('ICON_ATLAS_INDONESIA_KHMER_UNITACTIONS', '38', '8', '8' , 'Indonesia_UnitActions38.dds'),
('ICON_ATLAS_INDONESIA_KHMER_UNITACTIONS', '50', '8', '8' , 'Indonesia_UnitActions50.dds'),
('ICON_ATLAS_INDONESIA_KHMER_UNITACTIONS', '80', '8', '8' , 'Indonesia_UnitActions80.dds'),
('ICON_ATLAS_INDONESIA_KHMER_UNITACTIONS', '256','8', '8' , 'Indonesia_UnitActions256.dds');
INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES
('ICON_IMPROVEMENT_PIRATE_COVE', 'ICON_ATLAS_INDONESIA_KHMER_UNITACTIONS', 0);

----------------- MAYA ----------------------------------------
INSERT OR IGNORE INTO IconTextureAtlases(Name, IconSize, IconsPerRow, IconsPerColumn, Filename) VALUES
('ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS', '22', '4', '2' , 'MayaGran_Units22'),
('ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS', '32', '4', '2' , 'MayaGran_Units32'),
('ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS', '38', '4', '2' , 'MayaGran_Units38'),
('ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS', '50', '4', '2' , 'MayaGran_Units50'),
('ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS', '80', '4', '2' , 'MayaGran_Units80'),
('ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS', '256','4', '2' , 'MayaGran_Units256');
INSERT INTO IconDefinitions(Name, Atlas, 'Index') VALUES                                     -- units
('ICON_SLTH_UNIT_JAVELIN_THROWER', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS' , '0'),
('ICON_SLTH_UNIT_TASKMASTER', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS' , '3'),
('ICON_SLTH_UNIT_SHAMAN', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS' , '4'),
('ICON_SLTH_UNIT_YERSINIA', 'ICON_ATLAS_GRAN_COLOMBIA_MAYA_UNITS' , '1');