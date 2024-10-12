-- format nicked from Honey's Victory Menagerie

INSERT INTO Types
			(Type, Kind)
VALUES    ('VICTORY_TOWER_OF_MASTERY', 'KIND_VICTORY'),
		  ('VICTORY_ALTAR_OF_LUONNOTAR', 'KIND_VICTORY');

--UI will be handled via override, basic requirementsets will not show up.
INSERT INTO RequirementSets
	      (RequirementSetId,                    RequirementSetType  )
VALUES    ('TOWER_OF_MASTERY_VICTORY_VICTORY_REQS', 'REQUIREMENTSET_TEST_ALL'),
		  ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements
	      (RequirementSetId,                    RequirementId)
VALUES    ('TOWER_OF_MASTERY_VICTORY_VICTORY_REQS',		 'PLAYER_HAS_TOWER_NECROMANCY_REQUIREMENT'),
          ('TOWER_OF_MASTERY_VICTORY_VICTORY_REQS',		 'PLAYER_HAS_TOWER_ELEMENTS_REQUIREMENT'),
          ('TOWER_OF_MASTERY_VICTORY_VICTORY_REQS',		 'PLAYER_HAS_TOWER_DIVINATION_REQUIREMENT'),
          ('TOWER_OF_MASTERY_VICTORY_VICTORY_REQS',		 'PLAYER_HAS_TOWER_ALTERATION_REQUIREMENT'),
          ('TOWER_OF_MASTERY_VICTORY_VICTORY_REQS',		 'TOWER_OF_MASTERY_VICTORY_REQ'),
          ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',		 'SLTH_REQUIREMENT_HAS_LUONNOTAR_BASE'),
          ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',		 'SLTH_REQUIREMENT_HAS_LUONNOTAR_ANOINTED'),
          ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',		 'SLTH_REQUIREMENT_HAS_LUONNOTAR_BLESSED'),
          ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',		 'SLTH_REQUIREMENT_HAS_LUONNOTAR_CONSECRATED'),
          ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',		 'SLTH_REQUIREMENT_HAS_LUONNOTAR_DIVINE'),
          ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',		 'SLTH_REQUIREMENT_HAS_LUONNOTAR_EXALTED'),
		  ('ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',		 'SLTH_REQUIREMENT_HAS_LUONNOTAR_FINAL');

INSERT INTO Requirements
		 (RequirementId,                           RequirementType)
VALUES   ('TOWER_OF_MASTERY_VICTORY_REQ',    'REQUIREMENT_PLAYER_HAS_AT_LEAST_NUM_BUILDINGS');

INSERT INTO RequirementArguments
		(RequirementId,			Name,               Value)
VALUES  ('TOWER_OF_MASTERY_VICTORY_REQ',  'BuildingType',     'BUILDING_EIFFEL_TOWER'),
		('TOWER_OF_MASTERY_VICTORY_REQ',  'Amount',			'1');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('SLTH_REQUIREMENT_HAS_LUONNOTAR_BASE', 'REQUIREMENT_PLAYER_HAS_BUILDING'),
('SLTH_REQUIREMENT_HAS_LUONNOTAR_ANOINTED', 'REQUIREMENT_PLAYER_HAS_BUILDING'),
('SLTH_REQUIREMENT_HAS_LUONNOTAR_CONSECRATED', 'REQUIREMENT_PLAYER_HAS_BUILDING'),
('SLTH_REQUIREMENT_HAS_LUONNOTAR_EXALTED', 'REQUIREMENT_PLAYER_HAS_BUILDING'),
('SLTH_REQUIREMENT_HAS_LUONNOTAR_FINAL', 'REQUIREMENT_PLAYER_HAS_BUILDING');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('SLTH_REQUIREMENT_HAS_LUONNOTAR_BASE', 'BuildingType','SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR'),
('SLTH_REQUIREMENT_HAS_LUONNOTAR_ANOINTED', 'BuildingType','SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_ANOINTED'),
('SLTH_REQUIREMENT_HAS_LUONNOTAR_CONSECRATED', 'BuildingType','SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_CONSECRATED'),
('SLTH_REQUIREMENT_HAS_LUONNOTAR_EXALTED', 'BuildingType','SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_EXALTED'),
('SLTH_REQUIREMENT_HAS_LUONNOTAR_FINAL', 'BuildingType','SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_FINAL');

INSERT INTO Victories
		 (VictoryType,                Name,                                Blurb,                              Description,                                     RequirementSetId,                           Icon,                 CriticalPercentage)
VALUES   ('VICTORY_TOWER_OF_MASTERY', 'LOC_VICTORY_TOWER_OF_MASTERY_NAME', 'LOC_VICTORY_TOWER_OF_MASTERY_TEXT','LOC_VICTORY_TOWER_OF_MASTERY_DESCRIPTION',      'TOWER_OF_MASTERY_VICTORY_VICTORY_REQS',    'ICON_VICTORY_TOWER_OF_MASTERY',       50),
		 ('VICTORY_ALTAR_OF_LUONNOTAR', 'LOC_VICTORY_ALTAR_OF_LUONNOTAR_NAME', 'LOC_VICTORY_ALTAR_OF_LUONNOTAR_TEXT','LOC_VICTORY_ALTAR_OF_LUONNOTAR_DESCRIPTION',      'ALTAR_OF_LUONNOTAR_VICTORY_VICTORY_REQS',    'ICON_VICTORY_DIPLOMATIC',       50);
