INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES                     -- units
('ICON_UNIT_SLTH_PHALANX', 'ICON_ATLAS_MACEDON_PERSIA_UNITS' , '1'),
('ICON_UNIT_SLTH_STEPHANOS', 'ICON_ATLAS_MACEDON_PERSIA_UNITS' , '0'),
('ICON_UNIT_SLTH_RADIANT_GUARD', 'ICON_ATLAS_MACEDON_PERSIA_UNITS' , '2');

-- Unit portraits borrowed from the base/DLC unit that shares the unit's member type.
-- Rows marked 'placeholder art' reuse stand-in art and need a portrait of their own later.
INSERT OR REPLACE INTO IconDefinitions(Name, Atlas, 'Index') VALUES
('ICON_UNIT_SLTH_PHALANX_PORTRAIT', 'ICON_ATLAS_MACEDON_PERSIA_UNIT_PORTRAITS', '1'),	-- UNIT_MACEDONIAN_HYPASPIST (Macedonia_Persia)
('ICON_UNIT_SLTH_RADIANT_GUARD_PORTRAIT', 'ICON_ATLAS_MACEDON_PERSIA_UNIT_PORTRAITS', '2');	-- UNIT_PERSIAN_IMMORTAL (Macedonia_Persia)
