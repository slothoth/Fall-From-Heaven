/*
INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender, ActionRequiresIncompleteWonder) VALUES
('SLTH_GREAT_ENGINEER_1', 'LOC_SLTH_GREAT_ENGINEER_1', 'GREAT_PERSON_CLASS_ENGINEER', 'ERA_CLASSICAL', '1', 'Male', '1');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType) VALUES
('SLTH_GREAT_ENGINEER_1', 'SLTH_MODIFIER_HURRY_WONDER', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_WONDER_IN_TILE');

 */
CREATE TEMPORARY TABLE IF NOT EXISTS GreatPersonRepeater ( GreatPersonIndividualType TEXT PRIMARY KEY);
-- GEngineer
WITH RECURSIVE iterator AS (
    SELECT 21 AS i
    UNION ALL
    SELECT i + 1
    FROM iterator
    WHERE i < 512
)
INSERT INTO GreatPersonRepeater (GreatPersonIndividualType)
SELECT 'SLTH_GREAT_ENGINEER_' || i
FROM iterator;

INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender, ActionRequiresIncompleteWonder)
SELECT GreatPersonIndividualType, 'LOC_SLTH_GREAT_ENGINEER_21', 'GREAT_PERSON_CLASS_ENGINEER', 'ERA_CLASSICAL', '1', 'Male', '1'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'SLTH_MODIFIER_HURRY_WONDER', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_WONDER_IN_TILE'
FROM GreatPersonRepeater;

INSERT INTO Types(Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM GreatPersonRepeater;

DELETE FROM GreatPersonRepeater;
---------------------------------------- GGeneral
WITH RECURSIVE iterator AS (
    SELECT 21 AS i
    UNION ALL
    SELECT i + 1
    FROM iterator
    WHERE i < 512
)
INSERT INTO GreatPersonRepeater (GreatPersonIndividualType)
SELECT 'SLTH_GREAT_GENERAL_' || i
FROM iterator;

INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender)
SELECT GreatPersonIndividualType, 'LOC_SLTH_GREAT_GENERAL_21', 'GREAT_PERSON_CLASS_GENERAL', 'ERA_CLASSICAL', '1', 'Male'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'SLTH_MODIFIER_GRANT_COMMAND_POST', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualBirthModifiers (GreatPersonIndividualType, ModifierId)
SELECT GreatPersonIndividualType, 'SLTH_GREAT_GENERAL_STRENGTH_AOE'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualBirthModifiers (GreatPersonIndividualType, ModifierId)
SELECT GreatPersonIndividualType, 'SLTH_GREAT_GENERAL_MOVEMENT_AOE'
FROM GreatPersonRepeater;

INSERT INTO Types(Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM GreatPersonRepeater;

DELETE FROM GreatPersonRepeater;
/*
INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender) VALUES
('SLTH_GREAT_GENERAL_1', 'LOC_SLTH_GREAT_GENERAL_1', 'GREAT_PERSON_CLASS_GENERAL', 'ERA_CLASSICAL', '1', 'Male');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType) VALUES
('SLTH_GREAT_GENERAL_1', 'SLTH_MODIFIER_GRANT_COMMAND_POST', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY');

INSERT INTO GreatPersonIndividualBirthModifiers(GreatPersonIndividualType, ModifierId) VALUES
('SLTH_GREAT_GENERAL_1', 'SLTH_GREAT_GENERAL_STRENGTH_AOE'),
('SLTH_GREAT_GENERAL_1', 'SLTH_GREAT_GENERAL_MOVEMENT_AOE');

 */

-------------------------- Great Prophet
WITH RECURSIVE iterator AS (
    SELECT 21 AS i
    UNION ALL
    SELECT i + 1
    FROM iterator
    WHERE i < 512
)
INSERT INTO GreatPersonRepeater (GreatPersonIndividualType)
SELECT 'SLTH_GREAT_PROPHET_' || i
FROM iterator;

INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender, ActionRequiresMissingBuildingType, ActionRequiresCompletedDistrictType, ActionRequiresOwnedTile, ActionEffectTextOverride)
SELECT GreatPersonIndividualType, 'LOC_SLTH_GREAT_PROPHET_21', 'GREAT_PERSON_CLASS_PROPHET', 'ERA_CLASSICAL', '1', 'Female', 'BUILDING_BLOCK_ALTAR', 'DISTRICT_CITY_CENTER',  '1', 'LOC_GRANT_ALTAR'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'SLTH_MODIFIER_GRANT_LUONNOTAR_BASE', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'SLTH_MODIFIER_GRANT_LUONNOTAR_ANOINTED', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'SLTH_MODIFIER_GRANT_LUONNOTAR_BLESSED', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'SLTH_MODIFIER_GRANT_LUONNOTAR_CONSECRATED', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'SLTH_MODIFIER_GRANT_LUONNOTAR_DIVINE', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'SLTH_MODIFIER_GRANT_LUONNOTAR_EXALTED', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
FROM GreatPersonRepeater;

INSERT INTO Types(Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM GreatPersonRepeater;

DELETE FROM GreatPersonRepeater;
/*
INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender, ActionRequiresMissingBuildingType, ActionRequiresCompletedDistrictType, ActionRequiresOwnedTile, ActionEffectTextOverride) VALUES
('SLTH_GREAT_PROPHET_1', 'LOC_SLTH_GREAT_PROPHET_1', 'GREAT_PERSON_CLASS_PROPHET', 'ERA_CLASSICAL', '1', 'Female', 'BUILDING_BLOCK_ALTAR', 'DISTRICT_CITY_CENTER',  '1', 'LOC_GRANT_ALTAR');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType) VALUES
('SLTH_GREAT_PROPHET_1', 'SLTH_MODIFIER_GRANT_LUONNOTAR_BASE', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
('SLTH_GREAT_PROPHET_1', 'SLTH_MODIFIER_GRANT_LUONNOTAR_ANOINTED', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
('SLTH_GREAT_PROPHET_1', 'SLTH_MODIFIER_GRANT_LUONNOTAR_BLESSED', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
('SLTH_GREAT_PROPHET_1', 'SLTH_MODIFIER_GRANT_LUONNOTAR_CONSECRATED', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
('SLTH_GREAT_PROPHET_1', 'SLTH_MODIFIER_GRANT_LUONNOTAR_DIVINE', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
('SLTH_GREAT_PROPHET_1', 'SLTH_MODIFIER_GRANT_LUONNOTAR_EXALTED', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_GREAT_PROPHET_1', 'KIND_GREAT_PERSON_INDIVIDUAL');
 */

 ------------------------- Great Merchant

WITH RECURSIVE iterator AS (
    SELECT 21 AS i
    UNION ALL
    SELECT i + 1
    FROM iterator
    WHERE i < 512
)
INSERT INTO GreatPersonRepeater (GreatPersonIndividualType)
SELECT 'SLTH_GREAT_MERCHANT_' || i
FROM iterator;

INSERT INTO GreatPersonIndividuals  (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender)
SELECT GreatPersonIndividualType, 'LOC_SLTH_GREAT_MERCHANT_21', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_CLASSICAL', '1', 'Male'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_FOOD', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_GOLD', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_GOLD_SIDAR', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_GPP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_SCHOLARSHIP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO Types(Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM GreatPersonRepeater;

DELETE FROM GreatPersonRepeater;

/*
INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender) VALUES
('SLTH_GREAT_MERCHANT_1', 'LOC_SLTH_GREAT_MERCHANT_1', 'GREAT_PERSON_CLASS_MERCHANT', 'ERA_CLASSICAL', '1', 'Male');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType) VALUES
('SLTH_GREAT_MERCHANT_1', 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_FOOD', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_MERCHANT_1', 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_GOLD', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_MERCHANT_1', 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_GOLD_SIDAR', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_MERCHANT_1', 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_GPP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_MERCHANT_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_SCHOLARSHIP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_GREAT_MERCHANT_1', 'KIND_GREAT_PERSON_INDIVIDUAL');
 */

------- Great Artist

WITH RECURSIVE iterator AS (
    SELECT 21 AS i
    UNION ALL
    SELECT i + 1
    FROM iterator
    WHERE i < 512
)
INSERT INTO GreatPersonRepeater (GreatPersonIndividualType)
SELECT 'SLTH_GREAT_ARTIST_' || i
FROM iterator;

INSERT INTO GreatPersonIndividuals  (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender)
SELECT GreatPersonIndividualType, 'LOC_SLTH_GREAT_ARTIST_21', 'GREAT_PERSON_CLASS_ARTIST', 'ERA_CLASSICAL', '1', 'Male'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_ARTIST_ADD_GOLD', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_ARTIST_ADD_GPP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE_SIDAR', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;


INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE_THEATRE_OF_DREAMS', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_HALL_OF_KINGS', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_CASTE_SYSTEM', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_CASTE_SYSTEM', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_SCHOLARSHIP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO Types(Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM GreatPersonRepeater;

DELETE FROM GreatPersonRepeater;

/*
INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender) VALUES
('SLTH_GREAT_ARTIST_1', 'LOC_SLTH_GREAT_ARTIST_1', 'GREAT_PERSON_CLASS_ARTIST', 'ERA_CLASSICAL', '1', 'Male');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType) VALUES
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_ARTIST_ADD_GOLD', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE_SIDAR', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE_THEATRE_OF_DREAMS', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_ARTIST_ADD_GPP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_HALL_OF_KINGS', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_CASTE_SYSTEM', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_CASTE_SYSTEM', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_ARTIST_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_SCHOLARSHIP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY');
 */

----------------- Great Scientists
WITH RECURSIVE iterator AS (
    SELECT 21 AS i
    UNION ALL
    SELECT i + 1
    FROM iterator
    WHERE i < 512
)
INSERT INTO GreatPersonRepeater (GreatPersonIndividualType)
SELECT 'SLTH_GREAT_SCIENTIST_' || i
FROM iterator;

INSERT INTO GreatPersonIndividuals  (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender)
SELECT GreatPersonIndividualType, 'LOC_SLTH_GREAT_SCIENTIST_1', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_CLASSICAL', '1', 'Male'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_PROD', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_GPP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE_SIDAR', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE_GREAT_LIB', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_HALL_OF_KINGS', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_CASTE_SYSTEM', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_CASTE_SYSTEM', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
SELECT GreatPersonIndividualType, 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_SCHOLARSHIP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
FROM GreatPersonRepeater;

INSERT INTO Types(Type, Kind)
SELECT GreatPersonIndividualType, 'KIND_GREAT_PERSON_INDIVIDUAL'
FROM GreatPersonRepeater;

DROP TABLE GreatPersonRepeater;

/*
INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, Gender) VALUES
('SLTH_GREAT_SCIENTIST_1', 'LOC_SLTH_GREAT_SCIENTIST_1', 'GREAT_PERSON_CLASS_SCIENTIST', 'ERA_CLASSICAL', '1', 'Male');

INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType) VALUES
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_PROD', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE_SIDAR', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE_GREAT_LIB', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_GPP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_HALL_OF_KINGS', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_CASTE_SYSTEM', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_CASTE_SYSTEM', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'),
('SLTH_GREAT_SCIENTIST_1', 'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_SCHOLARSHIP', 'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY');
 */
