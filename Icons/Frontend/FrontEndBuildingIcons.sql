INSERT INTO IconTextureAtlases( Name,                           IconSize, IconsPerRow, IconsPerColumn, Filename) VALUES
                                ('ICON_SLTH_BUILDINGS_ATLAS_0', '256',    '8',         '1',            'Slth_Buildings_Atlas_0_256.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_0', '128',    '8',         '1',            'Slth_Buildings_Atlas_0_128.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_0', '80',     '8',         '1',            'Slth_Buildings_Atlas_0_80.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_0', '50',     '8',         '1',            'Slth_Buildings_Atlas_0_50.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_0', '38',     '8',         '1',            'Slth_Buildings_Atlas_0_38.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_0', '32',     '8',         '1',            'Slth_Buildings_Atlas_0_32.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_1', '256',    '3',         '1',            'Slth_Buildings_Atlas_1_256.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_1', '128',    '3',         '1',            'Slth_Buildings_Atlas_1_128.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_1', '80',     '3',         '1',            'Slth_Buildings_Atlas_1_80.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_1', '50',     '3',         '1',            'Slth_Buildings_Atlas_1_50.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_1', '38',     '3',         '1',            'Slth_Buildings_Atlas_1_38.dds'),
                                ('ICON_SLTH_BUILDINGS_ATLAS_1', '32',     '3',         '1',            'Slth_Buildings_Atlas_1_32.dds');

INSERT INTO IconDefinitions(Name,       Atlas,                         'Index') VALUES
('ICON_SLTH_BUILDING_ADULARIA_CHAMBER', 'ICON_SLTH_BUILDINGS_ATLAS_0', 3),
('ICON_SLTH_BUILDING_BLASTING_WORKSHOP','ICON_SLTH_BUILDINGS_ATLAS_0', 9),
('ICON_SLTH_BUILDING_CAVE_OF_ANCESTORS','ICON_SLTH_BUILDINGS_ATLAS_0', 10),
('ICON_SLTH_BUILDING_CITADEL_OF_LIGHT', 'ICON_SLTH_BUILDINGS_ATLAS_0', 12),
('ICON_SLTH_BUILDING_DESERT_SHRINE',    'ICON_SLTH_BUILDINGS_ATLAS_0', 17),
('ICON_SLTH_BUILDING_DWARF_CAGE',       'ICON_SLTH_BUILDINGS_ATLAS_0', 19),
('ICON_SLTH_BUILDING_DWARVEN_SMITHY',   'ICON_SLTH_BUILDINGS_ATLAS_0', 20),
('ICON_SLTH_BUILDING_ELF_CAGE',         'ICON_SLTH_BUILDINGS_ATLAS_0', 22),
('ICON_SLTH_BUILDING_FREAK_SHOW',       'ICON_SLTH_BUILDINGS_ATLAS_0', 24),
('ICON_SLTH_BUILDING_GOVERNORS_MANOR',  'ICON_SLTH_BUILDINGS_ATLAS_0', 27),
('ICON_SLTH_BUILDING_HALL_OF_MIRRORS',  'ICON_SLTH_BUILDINGS_ATLAS_0', 29),
('ICON_SLTH_BUILDING_HARBOR_LANUN',     'ICON_SLTH_BUILDINGS_ATLAS_0', 30),
('ICON_SLTH_BUILDING_HUMAN_CAGE',       'ICON_SLTH_BUILDINGS_ATLAS_0', 32),
('ICON_SLTH_BUILDING_JEWELER',          'ICON_SLTH_BUILDINGS_ATLAS_0', 36),
('ICON_SLTH_BUILDING_ORC_CAGE',         'ICON_SLTH_BUILDINGS_ATLAS_0', 43),
('ICON_SLTH_BUILDING_PALLENS_ENGINE',   'ICON_SLTH_BUILDINGS_ATLAS_0', 44),
('ICON_SLTH_BUILDING_PLANAR_GATE',      'ICON_SLTH_BUILDINGS_ATLAS_0', 46),
('ICON_SLTH_BUILDING_RELIQUARY',        'ICON_SLTH_BUILDINGS_ATLAS_0', 48),
('ICON_SLTH_BUILDING_SCULPTORS_STUDIO', 'ICON_SLTH_BUILDINGS_ATLAS_0', 50),
('ICON_SLTH_BUILDING_SMUGGLERS_PORT',   'ICON_SLTH_BUILDINGS_ATLAS_0', 53),
('ICON_SLTH_BUILDING_TAILOR',           'ICON_SLTH_BUILDINGS_ATLAS_0', 58),
('ICON_SLTH_BUILDING_TEMPLE_OF_THE_HAND','ICON_SLTH_BUILDINGS_ATLAS_0',59),
('ICON_SLTH_BUILDING_WARRENS',          'ICON_SLTH_BUILDINGS_ATLAS_1', 1);


-- CHancel of guardians missed, uses gameplay building icon that isnt possible to load.