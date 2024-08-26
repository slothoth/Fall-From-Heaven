INSERT INTO Civilizations(CivilizationType, Name, Description, Adjective, RandomCityNameDepth, StartingCivilizationLevelType, Ethnicity) VALUES
('SLTH_CIVILIZATION_MERCURIANS', 'LOC_CIV_MERCURIANS_NAME', 'LOC_CIV_MERCURIANS_DESCRIPTION', 'LOC_SLTH_CIV_MERCURIANS_ADJECTIVE', '10', 'CIVILIZATION_LEVEL_FULL_CIV', 'ETHNICITY_EURO');
INSERT INTO Leaders(LeaderType, Name, InheritFrom) VALUES
('SLTH_LEADER_BASIUM', 'LOC_SLTH_LEADER_BASIUM_NAME', 'LEADER_DEFAULT');
INSERT INTO CivilizationLeaders(LeaderType, CivilizationType, CapitalName) VALUES
('SLTH_LEADER_BASIUM', 'SLTH_CIVILIZATION_MERCURIANS', 'LOC_CITY_MERCURIANS_1_NAME');
INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
('SLTH_CIVILIZATION_MERCURIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_ANGEL_OF_DEATH'),
('SLTH_CIVILIZATION_MERCURIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_BASIUM'),
('SLTH_CIVILIZATION_MERCURIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_HERALD'),
('SLTH_CIVILIZATION_MERCURIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_OPHANIM'),
('SLTH_CIVILIZATION_MERCURIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_REPENTANT_ANGEL'),
('SLTH_CIVILIZATION_MERCURIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_SERAPH'),
('SLTH_CIVILIZATION_MERCURIANS', 'SLTH_TRAIT_CIVILIZATION_UNIT_VALKYRIE'),
('SLTH_CIVILIZATION_MERCURIANS', 'SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL');

INSERT INTO Traits(TraitType, Name, Description) VALUES
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'LOC_SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_ANGEL_OF_DEATH', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ANGEL_OF_DEATH_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_ANGEL_OF_DEATH_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BASIUM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BASIUM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_BASIUM_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HERALD', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HERALD_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_HERALD_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_OPHANIM', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_OPHANIM_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_OPHANIM_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_REPENTANT_ANGEL', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_REPENTANT_ANGEL_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_REPENTANT_ANGEL_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_SERAPH', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_SERAPH_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_SERAPH_DESCRIPTION'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VALKYRIE', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VALKYRIE_NAME', 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_VALKYRIE_DESCRIPTION');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_SLTH_GRANT_TECH_CRAFTING'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_ARQUEBUS'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_BEASTMASTER'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_BERSERKER'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_CROSSBOWMAN'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_IMMORTAL'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_KNIGHT'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_MARKSMAN'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_PHALANX'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_SCOUT'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_BAN_SLTH_UNIT_WARRIOR'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_SLTH_GRANT_MANA_LIFE'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_SLTH_HUGE_ADJUST_WAR_WEARINESS'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_SLTH_BUILDING_PALACE_MERCURIANS_MILITARY_PRODUCTION'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_SLTH_GRANT_MANA_EARTH'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'MODIFIER_SLTH_GRANT_IRON');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_SLTH_BUILDING_PALACE_MERCURIANS_MILITARY_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION', '0', '0', NULL);
INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_SLTH_BUILDING_PALACE_MERCURIANS_MILITARY_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '40');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_ANGEL', 'LOC_SLTH_UNIT_ANGEL_NAME', '2', '1', '4', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_ANGEL_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_ANGEL_OF_DEATH', 'LOC_SLTH_UNIT_ANGEL_OF_DEATH_NAME', '2', '2', '8', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '0', '0', 'LOC_SLTH_UNIT_ANGEL_OF_DEATH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ANGEL_OF_DEATH', '1', 'PROMOTION_CLASS_RECON', NULL, 'SLTH_CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_REPENTANT_ANGEL', 'LOC_SLTH_UNIT_REPENTANT_ANGEL_NAME', '2', '3', '12', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_REPENTANT_ANGEL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_REPENTANT_ANGEL', '1', 'PROMOTION_CLASS_MELEE', 'SLTH_TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_VALKYRIE', 'LOC_SLTH_UNIT_VALKYRIE_NAME', '2', '1', '6', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '10', '0', 'LOC_SLTH_UNIT_VALKYRIE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VALKYRIE', '1', 'PROMOTION_CLASS_MELEE', NULL, 'SLTH_CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_BASIUM', 'LOC_SLTH_UNIT_BASIUM_NAME', '2', '2', '7', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_BASIUM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BASIUM', '1', 'PROMOTION_CLASS_MELEE', 'SLTH_TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_HERALD', 'LOC_SLTH_UNIT_HERALD_NAME', '2', '2', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '0', '0', 'LOC_SLTH_UNIT_HERALD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HERALD', '1', 'PROMOTION_CLASS_RECON', 'SLTH_TECH_ANIMAL_MASTERY', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0'),
('SLTH_UNIT_OPHANIM', 'LOC_SLTH_UNIT_OPHANIM_NAME', '2', '2', '9', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '0', '0', 'LOC_SLTH_UNIT_OPHANIM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_OPHANIM', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'SLTH_TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_SERAPH', 'LOC_SLTH_UNIT_SERAPH_NAME', '2', '1', '8', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '0', '0', 'LOC_SLTH_UNIT_SERAPH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_SERAPH', '1', 'PROMOTION_CLASS_MELEE', NULL, 'SLTH_CIVIC_RAGE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_REPENTANT_ANGEL', 'CLASS_MELEE'),
('SLTH_UNIT_ANGEL', 'CLASS_MELEE'),
('SLTH_UNIT_ANGEL_OF_DEATH', 'CLASS_RECON'),
('SLTH_UNIT_VALKYRIE', 'CLASS_MELEE'),
('SLTH_UNIT_BASIUM', 'CLASS_MELEE'),
('SLTH_UNIT_HERALD', 'CLASS_RECON'),
('SLTH_UNIT_OPHANIM', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_SERAPH', 'CLASS_MELEE');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_TRAIT_CIVILIZATION_UNIT_ANGEL_OF_DEATH', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_BASIUM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_HERALD', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_OPHANIM', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_REPENTANT_ANGEL', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_SERAPH', 'KIND_TRAIT'),
('SLTH_TRAIT_CIVILIZATION_UNIT_VALKYRIE', 'KIND_TRAIT'),
('SLTH_CIVILIZATION_MERCURIANS', 'KIND_CIVILIZATION'),
('SLTH_LEADER_BASIUM', 'KIND_LEADER'),
('SLTH_TRAIT_CIVILIZATION_MERCURIANS_COOL', 'KIND_TRAIT'),
('SLTH_UNIT_ANGEL', 'KIND_UNIT'),
('SLTH_UNIT_ANGEL_OF_DEATH', 'KIND_UNIT'),
('SLTH_UNIT_REPENTANT_ANGEL', 'KIND_UNIT'),
('SLTH_UNIT_VALKYRIE', 'KIND_UNIT'),
('SLTH_UNIT_BASIUM', 'KIND_UNIT'),
('SLTH_UNIT_HERALD', 'KIND_UNIT'),
('SLTH_UNIT_OPHANIM', 'KIND_UNIT'),
('SLTH_UNIT_SERAPH', 'KIND_UNIT');