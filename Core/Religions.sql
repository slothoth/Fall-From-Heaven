DELETE FROM Religions WHERE IconString NOT IN ('Pa', 'Pr', 'Ju', 'Co', 'Ca', 'Hi', 'Is', 'Bu');

UPDATE Religions SET Name='LOC_RELIGION_THE_ORDER', Color='COLOR_RELIGION_PROTESTANTISM' WHERE IconString='Pr';
UPDATE Religions SET Name='LOC_RELIGION_EMPYREAN', Color='COLOR_RELIGION_CUSTOM_4' WHERE IconString='Ju';       -- Mahayana Buddhism sun if KhmerScenario
UPDATE Religions SET Name='LOC_RELIGION_KILMORPH', Color='COLOR_RELIGION_JUDAISM' WHERE IconString='Co';
UPDATE Religions SET Name='LOC_RELIGION_LEAVES', Color='COLOR_RELIGION_HINDUISM', IconString='8' WHERE IconString='Ca';
UPDATE Religions SET Name='LOC_RELIGION_OVERLORDS', Color='COLOR_RELIGION_SIKHISM', IconString='9' WHERE IconString='Hi';            -- could use Shaivism tentacle icon if KhmerScenario
UPDATE Religions SET Name='LOC_RELIGION_ESUS', Color='COLOR_RELIGION_ZOROASTRIANISM' WHERE IconString='Is';
UPDATE Religions SET Name='LOC_RELIGION_VEIL', Color='COLOR_RELIGION_CATHOLICISM' WHERE IconString='Bu';

--DELETE FROM GameCapabilities WHERE GameCapability = 'CAPABILITY_FOUND_PANTHEONS';

UPDATE BeliefClasses SET MaxInReligion = '2' WHERE BeliefClassType = 'BELIEF_CLASS_FOUNDER';

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'TRAIT_GAINS_ALL_FOLLOWER_BELIEFS'),
('MINOR_CIV_DEFAULT_TRAIT', 'TRAIT_GAINS_ALL_FOLLOWER_BELIEFS');
-- fake pantheons
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_GRANTED_WITHOUT_STATE_SLTH_NAME', Description='LOC_THE_ORDER_BELIEFS' WHERE BeliefType='BELIEF_RELIGIOUS_IDOLS';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_GRANTED_WITHOUT_STATE_SLTH_NAME', Description='LOC_EMPYREAN_BELIEFS' WHERE BeliefType='BELIEF_GOD_OF_THE_OPEN_SKY';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_GRANTED_WITHOUT_STATE_SLTH_NAME', Description='LOC_KILMORPH_BELIEFS' WHERE BeliefType='BELIEF_STONE_CIRCLES';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_GRANTED_WITHOUT_STATE_SLTH_NAME', Description='LOC_LEAVES_BELIEFS' WHERE BeliefType='BELIEF_DESERT_FOLKLORE';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_GRANTED_WITHOUT_STATE_SLTH_NAME', Description='LOC_OVERLORDS_BELIEFS' WHERE BeliefType='BELIEF_DANCE_OF_THE_AURORA';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_GRANTED_WITHOUT_STATE_SLTH_NAME', Description='LOC_ESUS_BELIEFS' WHERE BeliefType='BELIEF_GOD_OF_THE_SEA';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_GRANTED_WITHOUT_STATE_SLTH_NAME', Description='LOC_VEIL_BELIEFS' WHERE BeliefType='BELIEF_INITIATION_RITES';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_WITH_STATE_SLTH_NAME', Description='LOC_THE_ORDER_STATE_UNITS' WHERE BeliefType='BELIEF_LAY_MINISTRY';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_WITH_STATE_SLTH_NAME', Description='LOC_EMPYREAN_STATE_UNITS' WHERE BeliefType='BELIEF_PAPAL_PRIMACY';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_WITH_STATE_SLTH_NAME', Description='LOC_KILMORPH_STATE_UNITS' WHERE BeliefType='BELIEF_PILGRIMAGE';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_WITH_STATE_SLTH_NAME', Description='LOC_LEAVES_STATE_UNITS' WHERE BeliefType='BELIEF_STEWARDSHIP';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_WITH_STATE_SLTH_NAME', Description='LOC_OVERLORDS_STATE_UNITS' WHERE BeliefType='BELIEF_TITHE';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_WITH_STATE_SLTH_NAME', Description='LOC_ESUS_STATE_UNITS' WHERE BeliefType='BELIEF_WORLD_CHURCH';
UPDATE Beliefs SET Name='LOC_BELIEF_UNITS_WITH_STATE_SLTH_NAME', Description='LOC_VEIL_STATE_UNITS' WHERE BeliefType='BELIEF_CROSS_CULTURAL_DIALOGUE';
UPDATE Beliefs SET Name='LOC_BELIEF_BUILDINGS_WITH_STATE_SLTH_NAME', Description='LOC_THE_ORDER_STATE_BUILDINGS' WHERE BeliefType='BELIEF_DIVINE_INSPIRATION';
UPDATE Beliefs SET Name='LOC_BELIEF_BUILDINGS_WITH_STATE_SLTH_NAME', Description='LOC_EMPYREAN_STATE_BUILDINGS' WHERE BeliefType='BELIEF_FEED_THE_WORLD';
UPDATE Beliefs SET Name='LOC_BELIEF_BUILDINGS_WITH_STATE_SLTH_NAME', Description='LOC_KILMORPH_STATE_BUILDINGS' WHERE BeliefType='BELIEF_JESUIT_EDUCATION';
UPDATE Beliefs SET Name='LOC_BELIEF_BUILDINGS_WITH_STATE_SLTH_NAME', Description='LOC_LEAVES_STATE_BUILDINGS' WHERE BeliefType='BELIEF_RELIQUARIES';
UPDATE Beliefs SET Name='LOC_BELIEF_BUILDINGS_WITH_STATE_SLTH_NAME', Description='LOC_OVERLORDS_STATE_BUILDINGS' WHERE BeliefType='BELIEF_RELIGIOUS_COMMUNITY';
UPDATE Beliefs SET Name='LOC_BELIEF_BUILDINGS_WITH_STATE_SLTH_NAME', Description='LOC_ESUS_STATE_BUILDINGS' WHERE BeliefType='BELIEF_WORK_ETHIC';
UPDATE Beliefs SET Name='LOC_BELIEF_BUILDINGS_WITH_STATE_SLTH_NAME', Description='LOC_VEIL_STATE_BUILDINGS' WHERE BeliefType='BELIEF_ZEN_MEDITATION';
UPDATE Beliefs SET Name='LOC_BELIEF_SPECIAL_WITH_STATE_SLTH_NAME', Description='LOC_THE_ORDER_STATE_SPECIAL' WHERE BeliefType='BELIEF_CHORAL_MUSIC';
UPDATE Beliefs SET Name='LOC_BELIEF_SPECIAL_WITH_STATE_SLTH_NAME', Description='LOC_EMPYREAN_STATE_SPECIAL' WHERE BeliefType='BELIEF_WARRIOR_MONKS';
UPDATE Beliefs SET Name='LOC_BELIEF_SPECIAL_WITH_STATE_SLTH_NAME', Description='LOC_KILMORPH_STATE_SPECIAL' WHERE BeliefType='';
UPDATE Beliefs SET Name='LOC_BELIEF_SPECIAL_WITH_STATE_SLTH_NAME', Description='LOC_LEAVES_STATE_SPECIAL' WHERE BeliefType='';
UPDATE Beliefs SET Name='LOC_BELIEF_SPECIAL_WITH_STATE_SLTH_NAME', Description='LOC_OVERLORDS_STATE_SPECIAL' WHERE BeliefType='';
UPDATE Beliefs SET Name='LOC_BELIEF_SPECIAL_WITH_STATE_SLTH_NAME', Description='LOC_ESUS_STATE_SPECIAL' WHERE BeliefType='';
UPDATE Beliefs SET Name='LOC_BELIEF_SPECIAL_WITH_STATE_SLTH_NAME', Description='LOC_VEIL_STATE_SPECIAL' WHERE BeliefType='';
DELETE FROM Beliefs WHERE Name NOT LIKE '%SLTH_NAME';

INSERT INTO BeliefModifiers(BeliefType, ModifierID) VALUES
('BELIEF_LAY_MINISTRY', 'ALLOW_DISCIPLE_THE_ORDER'),
('BELIEF_PAPAL_PRIMACY', 'ALLOW_DISCIPLE_EMPYREAN'),
('BELIEF_PILGRIMAGE', 'ALLOW_DISCIPLE_RUNES'),
('BELIEF_STEWARDSHIP', 'ALLOW_DISCIPLE_FELLOWSHIP'),
('BELIEF_TITHE', 'ALLOW_DISCIPLE_OCTOPUS'),
('BELIEF_CROSS_CULTURAL_DIALOGUE', 'ALLOW_DISCIPLE_THE_ASHEN');
;
INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('ALLOW_DISCIPLE_EMPYREAN', 'MODIFIER_PLAYER_RELIGION_ADD_RELIGIOUS_UNIT'),
('ALLOW_DISCIPLE_FELLOWSHIP', 'MODIFIER_PLAYER_RELIGION_ADD_RELIGIOUS_UNIT'),
('ALLOW_DISCIPLE_OCTOPUS', 'MODIFIER_PLAYER_RELIGION_ADD_RELIGIOUS_UNIT'),
('ALLOW_DISCIPLE_RUNES', 'MODIFIER_PLAYER_RELIGION_ADD_RELIGIOUS_UNIT'),
('ALLOW_DISCIPLE_THE_ASHEN', 'MODIFIER_PLAYER_RELIGION_ADD_RELIGIOUS_UNIT'),
('ALLOW_DISCIPLE_THE_ORDER', 'MODIFIER_PLAYER_RELIGION_ADD_RELIGIOUS_UNIT');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('ALLOW_DISCIPLE_EMPYREAN', 'UnitType', 'SLTH_UNIT_DISCIPLE_EMPYREAN'),
('ALLOW_DISCIPLE_FELLOWSHIP', 'UnitType', 'SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES'),
('ALLOW_DISCIPLE_OCTOPUS', 'UnitType', 'SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS'),
('ALLOW_DISCIPLE_RUNES', 'UnitType', 'SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH'),
('ALLOW_DISCIPLE_THE_ASHEN', 'UnitType', 'SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL'),
('ALLOW_DISCIPLE_THE_ORDER', 'UnitType', 'SLTH_UNIT_DISCIPLE_THE_ORDER');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_DISCIPLE_EMPYREAN', 'CLASS_RELIGIOUS'),
('SLTH_UNIT_DISCIPLE_EMPYREAN', 'CLASS_RELIGIOUS_SPREAD'),
('SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'CLASS_RELIGIOUS'),
('SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'CLASS_RELIGIOUS_SPREAD'),
('SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS', 'CLASS_RELIGIOUS'),
('SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS', 'CLASS_RELIGIOUS_SPREAD'),
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH', 'CLASS_RELIGIOUS'),
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH', 'CLASS_RELIGIOUS_SPREAD'),
('SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL', 'CLASS_RELIGIOUS'),
('SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL', 'CLASS_RELIGIOUS_SPREAD'),
('SLTH_UNIT_DISCIPLE_THE_ORDER', 'CLASS_RELIGIOUS'),
('SLTH_UNIT_DISCIPLE_THE_ORDER', 'CLASS_RELIGIOUS_SPREAD');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, PrereqCivic, Maintenance, PseudoYieldType, TrackReligion, AdvisorType, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength) VALUES
('SLTH_UNIT_DISCIPLE_EMPYREAN', 'LOC_SLTH_UNIT_DISCIPLE_EMPYREAN_NAME', '2', '1', '14', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60',  'LOC_SLTH_UNIT_DISCIPLE_EMPYREAN_DESCRIPTION', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_HONOR', '1', 'PSEUDOYIELD_UNIT_RELIGIOUS', '1', 'ADVISOR_RELIGIOUS', '1', '1', '10', '100'),
('SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'LOC_SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES_NAME', '2', '1', '14', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60',  'LOC_SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES_DESCRIPTION', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_WAY_OF_THE_FORESTS', '1',  'PSEUDOYIELD_UNIT_RELIGIOUS', '1', 'ADVISOR_RELIGIOUS', '1', '1', '10', '100'),
('SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS', 'LOC_SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS_NAME', '2', '1', '14', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60',  'LOC_SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS_DESCRIPTION', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_MESSAGE_FROM_THE_DEEP', '1',  'PSEUDOYIELD_UNIT_RELIGIOUS', '1', 'ADVISOR_RELIGIOUS', '1', '1', '10', '100'),
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH', 'LOC_SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH_NAME', '2', '1', '14', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60',  'LOC_SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH_DESCRIPTION', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_WAY_OF_THE_EARTHMOTHER', '1',   'PSEUDOYIELD_UNIT_RELIGIOUS', '1', 'ADVISOR_RELIGIOUS', '1', '1', '10', '100'),
('SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL', 'LOC_SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL_NAME', '2', '1', '14', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60',  'LOC_SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL_DESCRIPTION', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_CORRUPTION_OF_SPIRIT', '1',  'PSEUDOYIELD_UNIT_RELIGIOUS', '1', 'ADVISOR_RELIGIOUS', '1', '1', '10', '100'),
('SLTH_UNIT_DISCIPLE_THE_ORDER', 'LOC_SLTH_UNIT_DISCIPLE_THE_ORDER_NAME', '2', '1', '14', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60',  'LOC_SLTH_UNIT_DISCIPLE_THE_ORDER_DESCRIPTION', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_ORDERS_FROM_HEAVEN', '1', 'PSEUDOYIELD_UNIT_RELIGIOUS', '1', 'ADVISOR_RELIGIOUS', '1', '1', '10', '100');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase) VALUES
('SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_RUNEKEEPER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_THEOLOGY', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '1', NULL, 1),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_SPEAKER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_THEOLOGY', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '1', NULL, 1),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_PRIOR_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_THEOLOGY', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '1', NULL, 1),
('SLTH_UNIT_HIGH_PRIEST_OF_LEAVES', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_LEAVES_NAME', '2', '1', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_LEAVES_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_THEOLOGY', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '1', NULL, 1),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_THEOLOGY', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '1', NULL, 1),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL', 'LOC_SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_PROFANE_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_THEOLOGY', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '1', NULL, 1),
('SLTH_UNIT_LUNATIC', 'LOC_SLTH_UNIT_LUNATIC_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_LUNATIC_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MIND_STAPLING', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 1),
('SLTH_UNIT_PRIEST_OF_WINTER', 'LOC_SLTH_UNIT_PRIEST_OF_WINTER_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_PRIEST_OF_WINTER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 1),
('SLTH_UNIT_ARTHENDAIN', 'LOC_SLTH_UNIT_ARTHENDAIN_NAME', '2', '1', '43', '9', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_ARTHENDAIN_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RANGED', 'TECH_MEDICINE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_BAMBUR', 'LOC_SLTH_UNIT_BAMBUR_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_BAMBUR_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_ARETE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_MITHRIL_GOLEM', 'LOC_SLTH_UNIT_MITHRIL_GOLEM_NAME', '2', '1', '121', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1200', '0', 'LOC_SLTH_UNIT_MITHRIL_GOLEM_DESCRIPTION', NULL, '0', NULL, 'TECH_MITHRIL_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_PARAMANDER', 'LOC_SLTH_UNIT_PARAMANDER_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PARAMANDER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_DWARVEN_SOLDIER_RUNES', 'LOC_SLTH_UNIT_DWARVEN_SOLDIER_RUNES_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_SOLDIER_OF_KILMORPH_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_WAY_OF_THE_EARTHMOTHER', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_PRIEST_OF_KILMORPH', 'LOC_SLTH_UNIT_PRIEST_OF_KILMORPH_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_KILMORPH_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', NULL, 0),
('SLTH_UNIT_DROWN', 'LOC_SLTH_UNIT_DROWN_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_DROWN_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MESSAGE_FROM_THE_DEEP', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_PRIEST_OF_THE_OVERLORDS', 'LOC_SLTH_UNIT_PRIEST_OF_THE_OVERLORDS_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_THE_OVERLORDS_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', NULL, 0),
('SLTH_UNIT_HEMAH', 'LOC_SLTH_UNIT_HEMAH_NAME', '2', '1', '34', '7', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '1', 'LOC_SLTH_UNIT_HEMAH_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_ADEPT', 'TECH_ARCANE_LORE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_SAVEROUS', 'LOC_SLTH_UNIT_SAVEROUS_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_SAVEROUS_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MIND_STAPLING', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_STYGIAN_GUARD', 'LOC_SLTH_UNIT_STYGIAN_GUARD_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_STYGIAN_GUARD_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_CRUSADER', 'LOC_SLTH_UNIT_CRUSADER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CRUSADER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_PRIEST_OF_THE_ORDER', 'LOC_SLTH_UNIT_PRIEST_OF_THE_ORDER_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_THE_ORDER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', NULL, 0),
('SLTH_UNIT_VALIN', 'LOC_SLTH_UNIT_VALIN_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_VALIN_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_ORDERS_FROM_HEAVEN', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_SPHENER', 'LOC_SLTH_UNIT_SPHENER_NAME', '2', '2', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_SPHENER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_RIGHTEOUSNESS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_BEAST_OF_AGARES', 'LOC_SLTH_UNIT_BEAST_OF_AGARES_NAME', '2', '2', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_BEAST_OF_AGARES_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_MALEVOLENT_DESIGNS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_PRIEST_OF_THE_VEIL', 'LOC_SLTH_UNIT_PRIEST_OF_THE_VEIL_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_THE_VEIL_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', NULL, 0),
('SLTH_UNIT_DISEASED_CORPSE', 'LOC_SLTH_UNIT_DISEASED_CORPSE_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_DISEASED_CORPSE_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_CORRUPTION_OF_SPIRIT', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_ROSIER', 'LOC_SLTH_UNIT_ROSIER_NAME', '2', '3', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_ROSIER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_CORRUPTION_OF_SPIRIT', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_MARDERO', 'LOC_SLTH_UNIT_MARDERO_NAME', '2', '2', '48', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_MARDERO_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_MALEVOLENT_DESIGNS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_PRIEST_OF_LEAVES', 'LOC_SLTH_UNIT_PRIEST_OF_LEAVES_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_LEAVES_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', NULL, 0),
('SLTH_UNIT_FAWN', 'LOC_SLTH_UNIT_FAWN_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_FAWN_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_WAY_OF_THE_FORESTS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_SATYR', 'LOC_SLTH_UNIT_SATYR_NAME', '2', '2', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_SLTH_UNIT_SATYR_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_HANDLING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 1),
('SLTH_UNIT_KITHRA', 'LOC_SLTH_UNIT_KITHRA_NAME', '2', '3', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_KITHRA_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_FERAL_BOND', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_YVAIN', 'LOC_SLTH_UNIT_YVAIN_NAME', '2', '2', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_YVAIN_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_COMMUNE_WITH_NATURE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_PRIEST_OF_THE_EMPYREAN', 'LOC_SLTH_UNIT_PRIEST_OF_THE_EMPYREAN_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_THE_EMPYREAN_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', NULL, 0),
('SLTH_UNIT_RATHA', 'LOC_SLTH_UNIT_RATHA_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_RATHA_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_RADIANT_GUARD', 'LOC_SLTH_UNIT_RADIANT_GUARD_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_RADIANT_GUARD_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_HONOR', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_CHALID', 'LOC_SLTH_UNIT_CHALID_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_SLTH_UNIT_CHALID_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_RELIGIOUS_LAW', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_SHADOW', 'LOC_SLTH_UNIT_SHADOW_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_SHADOW_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_SHADOWRIDER', 'LOC_SLTH_UNIT_SHADOWRIDER_NAME', '2', '3', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_SHADOWRIDER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_NIGHTWATCH', 'LOC_SLTH_UNIT_NIGHTWATCH_NAME', '2', '1', '14', '3', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_NIGHTWATCH_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RANGED', 'TECH_BOWYERS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, 0),
('SLTH_UNIT_GIBBON', 'LOC_SLTH_UNIT_GIBBON_NAME', '2', '1', '24', '5', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '1', 'LOC_SLTH_UNIT_GIBBON_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_ADEPT', NULL, 'CIVIC_DECEPTION', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_TECHNOLOGY', '0', NULL, 0);

INSERT INTO UnitUpgrades(Unit, UpgradeUnit) VALUES
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH', 'SLTH_UNIT_PRIEST_OF_KILMORPH'),
('SLTH_UNIT_PRIEST_OF_KILMORPH', 'SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH'),
('SLTH_UNIT_DWARVEN_SOLDIER_RUNES', 'SLTH_UNIT_PARAMANDER'),
('SLTH_UNIT_PARAMANDER', 'SLTH_UNIT_PALADIN'),
('SLTH_UNIT_DROWN', 'SLTH_UNIT_STYGIAN_GUARD'),
('SLTH_UNIT_PRIEST_OF_THE_OVERLORDS', 'SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS'),
('SLTH_UNIT_STYGIAN_GUARD', 'SLTH_UNIT_EIDOLON'),
('SLTH_UNIT_CRUSADER', 'SLTH_UNIT_PALADIN'),
('SLTH_UNIT_DISCIPLE_THE_ORDER', 'SLTH_UNIT_PRIEST_OF_THE_ORDER'),
('SLTH_UNIT_PRIEST_OF_THE_ORDER', 'SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER'),
('SLTH_UNIT_FAWN', 'SLTH_UNIT_SATYR'),
('SLTH_UNIT_RADIANT_GUARD', 'SLTH_UNIT_RATHA'),
('SLTH_UNIT_RATHA', 'SLTH_UNIT_KNIGHT'),
('SLTH_UNIT_NIGHTWATCH', 'SLTH_UNIT_ASSASSIN'),
('SLTH_UNIT_PRIEST_OF_LEAVES', 'SLTH_UNIT_HIGH_PRIEST_OF_LEAVES');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH', 'BUILDING_WAT'),
('SLTH_UNIT_PRIEST_OF_KILMORPH', 'BUILDING_WAT'),
('SLTH_UNIT_PARAMANDER', 'BUILDING_WAT'),
('SLTH_UNIT_DISCIPLE_THE_ORDER', 'BUILDING_CATHEDRAL'),
('SLTH_UNIT_PRIEST_OF_THE_ORDER', 'BUILDING_CATHEDRAL'),
('SLTH_UNIT_CRUSADER', 'BUILDING_CATHEDRAL'),
('SLTH_UNIT_DISCIPLE_EMPYREAN', 'BUILDING_GURDWARA'),
('SLTH_UNIT_PRIEST_OF_THE_EMPYREAN', 'BUILDING_GURDWARA'),
('SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'BUILDING_SANCTUARY'),
('SLTH_UNIT_PRIEST_OF_LEAVES', 'BUILDING_SANCTUARY'),
('SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS', 'BUILDING_MOSQUE'),
('SLTH_UNIT_PRIEST_OF_THE_OVERLORDS', 'BUILDING_MOSQUE'),
('SLTH_UNIT_STYGIAN_GUARD', 'BUILDING_MOSQUE'),
('SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL', 'BUILDING_STUPA'),
('SLTH_UNIT_PRIEST_OF_THE_VEIL', 'BUILDING_STUPA'),
('SLTH_UNIT_BEAST_OF_AGARES', 'BUILDING_STUPA');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_ARTHENDAIN', 'CLASS_RANGED'),
('SLTH_UNIT_BAMBUR', 'CLASS_MELEE'),
('SLTH_UNIT_PARAMANDER', 'CLASS_DISCIPLE'),
('SLTH_UNIT_MITHRIL_GOLEM', 'CLASS_MELEE'),
('SLTH_UNIT_PRIEST_OF_KILMORPH', 'CLASS_DISCIPLE'),
('SLTH_UNIT_ARTHENDAIN', 'RACE_DWARVEN'),
('SLTH_UNIT_BAMBUR', 'RACE_DWARVEN'),
('SLTH_UNIT_MITHRIL_GOLEM', 'RACE_GOLEM'),
('SLTH_UNIT_PARAMANDER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_PRIEST_OF_KILMORPH', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DROWN', 'CLASS_MELEE'),
('SLTH_UNIT_HEMAH', 'CLASS_ADEPT'),
('SLTH_UNIT_SAVEROUS', 'CLASS_MELEE'),
('SLTH_UNIT_STYGIAN_GUARD', 'CLASS_MELEE'),
('SLTH_UNIT_PRIEST_OF_THE_OVERLORDS', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DROWN', 'IS_UNDEAD'),
('SLTH_UNIT_DROWN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_PRIEST_OF_THE_OVERLORDS', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HEMAH', 'RACE_HUMAN'),
('SLTH_UNIT_SAVEROUS', 'IS_UNDEAD'),
('SLTH_UNIT_SAVEROUS', 'RACE_WINTERBORN'),
('SLTH_UNIT_STYGIAN_GUARD', 'IS_UNDEAD'),             -- are they?
('SLTH_UNIT_CRUSADER', 'CLASS_DISCIPLE'),
('SLTH_UNIT_PRIEST_OF_THE_ORDER', 'CLASS_DISCIPLE'),
('SLTH_UNIT_VALIN', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_SPHENER', 'CLASS_DISCIPLE'),
('SLTH_UNIT_CRUSADER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_PRIEST_OF_THE_ORDER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_VALIN', 'RACE_HUMAN'),
('SLTH_UNIT_SPHENER', 'RACE_ANGEL'),
('SLTH_UNIT_BEAST_OF_AGARES', 'CLASS_BEAST'),
('SLTH_UNIT_PRIEST_OF_THE_VEIL', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DISEASED_CORPSE', 'CLASS_MELEE'),
('SLTH_UNIT_ROSIER', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_MARDERO', 'CLASS_DISCIPLE'),
('SLTH_UNIT_PRIEST_OF_THE_VEIL', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DISEASED_CORPSE', 'IS_UNDEAD'),
('SLTH_UNIT_DISEASED_CORPSE', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_ROSIER', 'RACE_HUMAN'),
('SLTH_UNIT_MARDERO', 'RACE_DEMON'),
('SLTH_UNIT_PRIEST_OF_LEAVES', 'CLASS_DISCIPLE'),
('SLTH_UNIT_FAWN', 'CLASS_RECON'),
('SLTH_UNIT_SATYR', 'CLASS_RECON'),
('SLTH_UNIT_KITHRA', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_YVAIN', 'CLASS_DISCIPLE'),
('SLTH_UNIT_PRIEST_OF_LEAVES', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_KITHRA', 'RACE_ELVEN'),
('SLTH_UNIT_YVAIN', 'RACE_ELVEN'),
('SLTH_UNIT_PRIEST_OF_THE_EMPYREAN', 'CLASS_DISCIPLE'),
('SLTH_UNIT_RATHA', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_RADIANT_GUARD', 'CLASS_MELEE'),
('SLTH_UNIT_CHALID', 'CLASS_DISCIPLE'),
('SLTH_UNIT_PRIEST_OF_THE_EMPYREAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_RADIANT_GUARD', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_CHALID', 'RACE_HUMAN'),
('SLTH_UNIT_SHADOW', 'CLASS_RECON'),
('SLTH_UNIT_SHADOWRIDER', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_NIGHTWATCH', 'CLASS_RANGED'),
('SLTH_UNIT_GIBBON', 'CLASS_ADEPT'),
('SLTH_UNIT_SHADOW', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_SHADOWRIDER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_NIGHTWATCH', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DISCIPLE_EMPYREAN', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DISCIPLE_THE_ORDER', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DISCIPLE_EMPYREAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DISCIPLE_THE_ORDER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH', 'CLASS_DISCIPLE'),
('SLTH_UNIT_HIGH_PRIEST_OF_LEAVES', 'CLASS_DISCIPLE'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN', 'CLASS_DISCIPLE'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER', 'CLASS_DISCIPLE'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS', 'CLASS_DISCIPLE'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL', 'CLASS_DISCIPLE'),
('SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HIGH_PRIEST_OF_LEAVES', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL', 'CAN_BE_RACIALIZED');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_UNIT_ARTHENDAIN', 'KIND_UNIT'),
('SLTH_UNIT_BAMBUR', 'KIND_UNIT'),
('SLTH_UNIT_MITHRIL_GOLEM', 'KIND_UNIT'),
('SLTH_UNIT_PARAMANDER', 'KIND_UNIT'),
('SLTH_UNIT_PRIEST_OF_KILMORPH', 'KIND_UNIT'),
('SLTH_UNIT_DROWN', 'KIND_UNIT'),
('SLTH_UNIT_PRIEST_OF_THE_OVERLORDS', 'KIND_UNIT'),
('SLTH_UNIT_HEMAH', 'KIND_UNIT'),
('SLTH_UNIT_SAVEROUS', 'KIND_UNIT'),
('SLTH_UNIT_STYGIAN_GUARD', 'KIND_UNIT'),
('SLTH_UNIT_CRUSADER', 'KIND_UNIT'),
('SLTH_UNIT_PRIEST_OF_THE_ORDER', 'KIND_UNIT'),
('SLTH_UNIT_VALIN', 'KIND_UNIT'),
('SLTH_UNIT_SPHENER', 'KIND_UNIT'),
('SLTH_UNIT_BEAST_OF_AGARES', 'KIND_UNIT'),
('SLTH_UNIT_PRIEST_OF_THE_VEIL', 'KIND_UNIT'),
('SLTH_UNIT_DISEASED_CORPSE', 'KIND_UNIT'),
('SLTH_UNIT_ROSIER', 'KIND_UNIT'),
('SLTH_UNIT_MARDERO', 'KIND_UNIT'),
('SLTH_UNIT_PRIEST_OF_LEAVES', 'KIND_UNIT'),
('SLTH_UNIT_FAWN', 'KIND_UNIT'),
('SLTH_UNIT_SATYR', 'KIND_UNIT'),
('SLTH_UNIT_KITHRA', 'KIND_UNIT'),
('SLTH_UNIT_YVAIN', 'KIND_UNIT'),
('SLTH_UNIT_PRIEST_OF_THE_EMPYREAN', 'KIND_UNIT'),
('SLTH_UNIT_RATHA', 'KIND_UNIT'),
('SLTH_UNIT_RADIANT_GUARD', 'KIND_UNIT'),
('SLTH_UNIT_CHALID', 'KIND_UNIT'),
('SLTH_UNIT_SHADOW', 'KIND_UNIT'),
('SLTH_UNIT_SHADOWRIDER', 'KIND_UNIT'),
('SLTH_UNIT_NIGHTWATCH', 'KIND_UNIT'),
('SLTH_UNIT_GIBBON', 'KIND_UNIT'),
('SLTH_UNIT_DISCIPLE_EMPYREAN', 'KIND_UNIT'),
('SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'KIND_UNIT'),
('SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS', 'KIND_UNIT'),
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH', 'KIND_UNIT'),
('SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL', 'KIND_UNIT'),
('SLTH_UNIT_DISCIPLE_THE_ORDER', 'KIND_UNIT'),
('SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH', 'KIND_UNIT'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS', 'KIND_UNIT'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN', 'KIND_UNIT'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER', 'KIND_UNIT'),
('SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL', 'KIND_UNIT'),
('SLTH_UNIT_HIGH_PRIEST_OF_LEAVES', 'KIND_UNIT'),
('ALIGNMENT_EVIL', 'KIND_ABILITY'),
('ALIGNMENT_GOOD', 'KIND_ABILITY');

-- does this ban prevent upgrade though
INSERT INTO GameModifiers(ModifierId) VALUES
('MODIFIER_BAN_SLTH_UNIT_PALADIN_ATTACH'),
('MODIFIER_BAN_SLTH_UNIT_DRUID_ATTACH'),
('MODIFIER_BAN_SLTH_UNIT_EIDOLON_ATTACH');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_BAN_SLTH_UNIT_PALADIN_ATTACH', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', '1', '1', NULL),
('MODIFIER_ATTACH_PALADIN_BAN_CAPITAL', 'MODIFIER_ATTACH_MODIFIER_PLAYER_CAPITAL', '0', '0', NULL),
('CANT_BUILD_SLTH_UNIT_PALADIN_IF_NOT_GOOD', 'MODIFIER_PLAYER_UNIT_BUILD_DISABLED', '0', '0', 'ALIGNMENT_NOT_GOOD_REQS'),
('MODIFIER_BAN_SLTH_UNIT_DRUID_ATTACH', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', '1', '1', NULL),
('MODIFIER_ATTACH_DRUID_BAN_CAPITAL', 'MODIFIER_ATTACH_MODIFIER_PLAYER_CAPITAL', '0', '0', NULL),
('CANT_BUILD_SLTH_UNIT_DRUID_IF_NOT_GOOD', 'MODIFIER_PLAYER_UNIT_BUILD_DISABLED', '0', '0', 'ALIGNMENT_NOT_NEUTRAL_REQS'),
('MODIFIER_BAN_SLTH_UNIT_EIDOLON_ATTACH', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', '1', '1', NULL),
('MODIFIER_ATTACH_EIDOLON_BAN_CAPITAL', 'MODIFIER_ATTACH_MODIFIER_PLAYER_CAPITAL', '0', '0', NULL),
('CANT_BUILD_SLTH_UNIT_EIDOLON_IF_NOT_GOOD', 'MODIFIER_PLAYER_UNIT_BUILD_DISABLED', '0', '0', 'ALIGNMENT_NOT_EVIL_REQS');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_BAN_SLTH_UNIT_PALADIN_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'MODIFIER_ATTACH_PALADIN_BAN_CAPITAL'),
('MODIFIER_ATTACH_PALADIN_BAN_CAPITAL', 'ModifierId', 'ARGTYPE_IDENTITY', 'MODIFIER_BAN_SLTH_UNIT_PALADIN'),
('CANT_BUILD_SLTH_UNIT_PALADIN_IF_NOT_GOOD', 'UnitType', 'ARGTYPE_IDENTITY', 'SLTH_UNIT_PALADIN'),
('MODIFIER_BAN_SLTH_UNIT_DRUID_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'MODIFIER_ATTACH_DRUID_BAN_CAPITAL'),
('MODIFIER_ATTACH_DRUID_BAN_CAPITAL', 'ModifierId', 'ARGTYPE_IDENTITY', 'MODIFIER_BAN_SLTH_UNIT_DRUID'),
('CANT_BUILD_SLTH_UNIT_DRUID_IF_NOT_GOOD', 'UnitType', 'ARGTYPE_IDENTITY', 'SLTH_UNIT_DRUID'),
('MODIFIER_BAN_SLTH_UNIT_EIDOLON_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'MODIFIER_ATTACH_EIDOLON_BAN_CAPITAL'),
('MODIFIER_ATTACH_EIDOLON_BAN_CAPITAL', 'ModifierId', 'ARGTYPE_IDENTITY', 'MODIFIER_BAN_SLTH_UNIT_EIDOLON'),
('CANT_BUILD_SLTH_UNIT_EIDOLON_IF_NOT_GOOD', 'UnitType', 'ARGTYPE_IDENTITY', 'SLTH_UNIT_EIDOLON');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('ALIGNMENT_NOT_GOOD_REQS', 'REQUIREMENTSET_TEST_ALL'),
('ALIGNMENT_NOT_NEUTRAL_REQS', 'REQUIREMENTSET_TEST_ALL'),
('ALIGNMENT_NOT_EVIL_REQS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('ALIGNMENT_NOT_GOOD_REQS', 'SLTH_REQUIREMENT_ALIGNMENT_NOT_GOOD'),
('ALIGNMENT_NOT_NEUTRAL_REQS', 'SLTH_REQUIREMENT_ALIGNMENT_NOT_NEUTRAL'),
('ALIGNMENT_NOT_EVIL_REQS', 'SLTH_REQUIREMENT_ALIGNMENT_NOT_EVIL');

INSERT INTO Requirements(RequirementId, RequirementType, Inverse) VALUES
('SLTH_REQUIREMENT_ALIGNMENT_NOT_GOOD', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', '1'),
('SLTH_REQUIREMENT_ALIGNMENT_NOT_NEUTRAL', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', '1'),
('SLTH_REQUIREMENT_ALIGNMENT_NOT_EVIL', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', '1');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('SLTH_REQUIREMENT_ALIGNMENT_NOT_GOOD', 'PropertyName','alignment_good'),
('SLTH_REQUIREMENT_ALIGNMENT_NOT_GOOD', 'PropertyMinimum','1'),
('SLTH_REQUIREMENT_ALIGNMENT_NOT_NEUTRAL', 'PropertyName','alignment_neutral'),
('SLTH_REQUIREMENT_ALIGNMENT_NOT_NEUTRAL', 'PropertyMinimum','1'),
('SLTH_REQUIREMENT_ALIGNMENT_NOT_EVIL', 'PropertyName','alignment_evil'),
('SLTH_REQUIREMENT_ALIGNMENT_NOT_EVIL', 'PropertyMinimum','1');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('ALIGNMENT_EVIL', 'LOC_SLTH_ABILITY_ALIGNMENT_EVIL_NAME', 'LOC_ABILITY_ALIGNMENT_EVIL_DESCRIPTION', '0', '1'),
('ALIGNMENT_GOOD', 'LOC_SLTH_ABILITY_ALIGNMENT_GOOD_NAME', 'LOC_ABILITY_ALIGNMENT_GOOD_DESCRIPTION', '0', '1');

INSERT INTO TypeTags(Type, Tag) VALUES
('ALIGNMENT_EVIL', 'CLASS_RECON'),
('ALIGNMENT_EVIL', 'CLASS_ADEPT'),
('ALIGNMENT_EVIL', 'CLASS_RANGED'),
('ALIGNMENT_EVIL', 'CLASS_LIGHT_CAVALRY'),
('ALIGNMENT_EVIL', 'CLASS_MELEE'),
('ALIGNMENT_EVIL', 'CLASS_NAVAL_MELEE'),
('ALIGNMENT_EVIL', 'CLASS_DISCIPLE'),
('ALIGNMENT_GOOD', 'CLASS_RECON'),
('ALIGNMENT_GOOD', 'CLASS_ADEPT'),
('ALIGNMENT_GOOD', 'CLASS_RANGED'),
('ALIGNMENT_GOOD', 'CLASS_LIGHT_CAVALRY'),
('ALIGNMENT_GOOD', 'CLASS_MELEE'),
('ALIGNMENT_GOOD', 'CLASS_NAVAL_MELEE'),
('ALIGNMENT_GOOD', 'CLASS_DISCIPLE');
