-- Buildings
INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES
('ICON_SLTH_BUILDING_INFIRMARY', 'ICON_ATLAS_ETHIOPIA_BUILDINGS', 2),                 -- Chancery
('ICON_SLTH_BUILDING_DEMONS_ALTAR', 'ICON_ATLAS_ETHIOPIA_BUILDINGS', 5);                 -- old god obelisk

-- Improvements
INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES
('ICON_IMPROVEMENT_MANA_LIFE', 'ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', 3);

-- Projects
INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES
('ICON_PROJECT_ELEGY_OF_THE_SHEAIM', 'ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', 0),
('ICON_PROJECT_BIRTHRIGHT_REGAINED', 'ICON_ATLAS_ETHIOPIA_UNIT_ACTIONS', 4);


INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES                     -- units
('ICON_UNIT_SLTH_VAMPIRE', 'ICON_ATLAS_ETHIOPIA_UNITS' , '1'),
('ICON_UNIT_SLTH_HIGH_PRIEST_OF_THE_VEIL', 'ICON_ATLAS_ETHIOPIA_UNITS' , '0');

-- Unit portraits borrowed from the base/DLC unit that shares the unit's member type.
-- Rows marked 'placeholder art' reuse stand-in art and need a portrait of their own later.
INSERT OR REPLACE INTO IconDefinitions(Name, Atlas, 'Index') VALUES
('ICON_UNIT_SLTH_HIGH_PRIEST_OF_THE_VEIL_PORTRAIT', 'ICON_ATLAS_ETHIOPIA_UNIT_PORTRAITS', '0'),	-- UNIT_CULTIST (Ethiopia)
('ICON_UNIT_SLTH_SHADE_PORTRAIT', 'ICON_ATLAS_ETHIOPIA_UNIT_PORTRAITS', '0');	-- UNIT_CULTIST (Ethiopia)
