INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES                     -- units
('ICON_UNIT_SLTH_ROYAL_GUARD', 'ICON_ATLAS_BYZANTIUM_GAUL_UNITS' , '1'),
('ICON_UNIT_SLTH_BEASTMAN', 'ICON_ATLAS_BYZANTIUM_GAUL_UNITS' , '2');

-- Unit portraits borrowed from the base/DLC unit that shares the unit's member type.
-- Rows marked 'placeholder art' reuse stand-in art and need a portrait of their own later.
INSERT OR REPLACE INTO IconDefinitions(Name, Atlas, 'Index') VALUES
('ICON_UNIT_SLTH_ROYAL_GUARD_PORTRAIT', 'ICON_ATLAS_BYZANTIUM_GAUL_UNIT_PORTRAITS', '1');	-- UNIT_BYZANTINE_TAGMA (Byzantium_Gaul)
