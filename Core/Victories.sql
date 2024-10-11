-- format nicked from Honey's Victory Menagerie

INSERT INTO Types
			(Type, Kind)
VALUES    ('VICTORY_TOWER_OF_MASTERY', 'KIND_VICTORY'),
		  ('VICTORY_ALTAR_OF_LUONNOTAR', 'KIND_VICTORY');

--UI will be handled via override, basic requirementsets will not show up.
INSERT INTO RequirementSets
	      (RequirementSetId,                    RequirementSetType  )
VALUES    ('TOWER_OF_MASTERY_VICTORY_VICTORY_REQS', 'REQUIREMENTSET_TEST_ALL' ),
		  ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS', 'REQUIREMENTSET_TEST_ALL' );


INSERT INTO RequirementSetRequirements
	      (RequirementSetId,                    RequirementId)
VALUES    ('TOWER_OF_MASTERY_VICTORY_VICTORY_REQS',		 'TOWER_OF_MASTERY_VICTORY_REQ'),
		  ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',		 'ALTAR_OF_LUONNOTAR_VICTORY_REQ');

INSERT INTO Requirements
		 (RequirementId,                           RequirementType)
VALUES   ('TOWER_OF_MASTERY_VICTORY_REQ',    'REQUIREMENT_PLAYER_HAS_AT_LEAST_NUM_BUILDINGS'),
		 ('ALTAR_OF_LUONNOTAR_VICTORY_REQ',    'REQUIREMENT_PLAYER_HAS_AT_LEAST_NUM_BUILDINGS');


INSERT INTO RequirementArguments
		(RequirementId,			Name,               Value)
VALUES  ('TOWER_OF_MASTERY_VICTORY_REQ',  'BuildingType',     'BUILDING_EIFFEL_TOWER'),
		('TOWER_OF_MASTERY_VICTORY_REQ',  'Amount',			'1'),
		('ALTAR_OF_LUONNOTAR_VICTORY_REQ',  'BuildingType',   'SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_FINAL'),
		('ALTAR_OF_LUONNOTAR_VICTORY_REQ',  'Amount',			'1');


INSERT INTO Victories
		 ("VictoryType",     "Name",                    "Blurb",                  "Description",                  "RequirementSetId",              "Icon",                 "CriticalPercentage")
VALUES   ('VICTORY_TOWER_OF_MASTERY', 'LOC_VICTORY_TOWER_OF_MASTERY_NAME', 'LOC_VICTORY_TOWER_OF_MASTERY_TEXT','LOC_VICTORY_TOWER_OF_MASTERY_DESCRIPTION',      'TOWER_OF_MASTERY_VICTORY_VICTORY_REQS',    'ICON_VICTORY_TOWER_OF_MASTERY',       50),
		 ('VICTORY_ALTAR_OF_LUONNOTAR', 'LOC_VICTORY_ALTAR_OF_LUONNOTAR_NAME', 'LOC_VICTORY_ALTAR_OF_LUONNOTAR_TEXT','LOC_VICTORY_ALTAR_OF_LUONNOTAR_DESCRIPTION',      'ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',    'ICON_VICTORY_ALTAR_OF_LUONNOTAR',       50);
