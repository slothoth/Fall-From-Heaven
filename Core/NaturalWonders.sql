UPDATE Features SET Impassable=0, Tiles=1, CustomPlacement= NULL WHERE NaturalWonder = 1;

UPDATE Features SET Name='LOC_FEATURE_MAELSTROM_NAME', Description='LOC_FEATURE_MAELSTROM_DESCRIPTION' WHERE FeatureType='FEATURE_BERMUDA_TRIANGLE';
UPDATE Features SET Name='LOC_FEATURE_POOL_OF_TEARS_NAME', Description='LOC_FEATURE_POOL_OF_TEARS_DESCRIPTION' WHERE FeatureType='FEATURE_FOUNTAIN_OF_YOUTH';
UPDATE Features SET Name='LOC_FEATURE_MIRROR_OF_HEAVEN_NAME', Description='LOC_FEATURE_MIRROR_OF_HEAVEN_DESCRIPTION' WHERE FeatureType='FEATURE_IKKIL';
UPDATE Features SET Name='LOC_FEATURE_PRISTIN_NAME', Description='LOC_FEATURE_PRISTIN_DESCRIPTION' WHERE FeatureType='FEATURE_MATTERHORN';
UPDATE Features SET Name='LOC_FEATURE_STANDING_STONES_NAME', Description='LOC_FEATURE_STANDING_STONES_DESCRIPTION' WHERE FeatureType='FEATURE_TSINGY';
UPDATE Features SET Name='LOC_FEATURE_TOMB_NAME', Description='LOC_FEATURE_TOMB_DESCRIPTION' WHERE FeatureType='FEATURE_HA_LONG_BAY';
UPDATE Features SET Name='LOC_FEATURE_YGGDRASIL_NAME', Description='LOC_FEATURE_YGGDRASIL_DESCRIPTION' WHERE FeatureType='FEATURE_PANTANAL';
UPDATE Features SET Name='LOC_FEATURE_PATRIA_NAME', Description='LOC_FEATURE_PATRIA_DESCRIPTION' WHERE FeatureType='FEATURE_PAITITI';
UPDATE Features SET Name='LOC_FEATURE_FRIGUS_NAME', Description='LOC_FEATURE_FRIGUS_DESCRIPTION' WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW';
UPDATE Features SET Name='LOC_FEATURE_BONES_NAME', Description='LOC_FEATURE_BONES_DESCRIPTION' WHERE FeatureType='FEATURE_EYE_OF_THE_SAHARA';
UPDATE Features SET Name='LOC_FEATURE_WELL_NAME', Description='LOC_FEATURE_WELL_DESCRIPTION' WHERE FeatureType='FEATURE_GOBUSTAN';
UPDATE Features SET Name='LOC_FEATURE_SEPULCHER_NAME', Description='LOC_FEATURE_SEPULCHER_DESCRIPTION' WHERE FeatureType='FEATURE_DELICATE_ARCH';
UPDATE Features SET Name='LOC_FEATURE_PYRE_NAME', Description='LOC_FEATURE_PYRE_DESCRIPTION' WHERE FeatureType='FEATURE_YOSEMITE';
UPDATE Features SET Name='LOC_FEATURE_MAENALUS_NAME', Description='LOC_FEATURE_MAENALUS_DESCRIPTION' WHERE FeatureType='FEATURE_BARRIER_REEF';
UPDATE Features SET Name='LOC_FEATURE_ODIO_NAME', Description='LOC_FEATURE_ODIO_DESCRIPTION' WHERE FeatureType='FEATURE_DEVILSTOWER';
UPDATE Features SET Name='LOC_FEATURE_PINES_NAME', Description='LOC_FEATURE_PINES_DESCRIPTION' WHERE FeatureType='FEATURE_CHOCOLATEHILLS';
UPDATE Features SET Name='LOC_FEATURE_CARCER_NAME', Description='LOC_FEATURE_CARCER_DESCRIPTION' WHERE FeatureType='FEATURE_TORRES_DEL_PAINE';


INSERT INTO Improvement_ValidFeatures (ImprovementType, FeatureType) VALUES
('IMPROVEMENT_BARBARIAN_CAMP', 'FEATURE_UBSUNUR_HOLLOW'),
('IMPROVEMENT_BARBARIAN_CAMP', 'FEATURE_GOBUSTAN'),
('IMPROVEMENT_BARBARIAN_CAMP', 'FEATURE_DELICATE_ARCH'),
('IMPROVEMENT_BARBARIAN_CAMP', 'FEATURE_YOSEMITE');

-- bermuda FEATURE_BERMUDA_TRIANGLE
-- pool of tears FEATURE_FOUNTAIN_OF_YOUTH
-- mirror of heaven FEATURE_IKKIL
--  guardianspristin  FEATURE_MATTERHORN
-- stones   FEATURE_TSINGY
-- sucell8s tomb            FEATURE_HA_LONG_BAY
-- yggdrasil    FEATURE_PANTANAL
-- remnants     FEATURE_PAITITI
-- dragon bones         FEATURE_EYE_OF_THE_SAHARA

-- letum frigus         FEATURE_UBSUNUR_HOLLOW
-- bradelines well  FEATURE_GOBUSTAN
-- broken sepulcher     FEATURE_DELICATE_ARCH
-- pyre         FEATURE_YOSEMITE


-- maenalus    FEATURE_BARRIER_REEF
-- odios prison         FEATURE_DEVILSTOWER
-- seven pines                  FEATURE_CHOCOLATEHILLS
-- ring of carcer               FEATURE_TORRES_DEL_PAINE