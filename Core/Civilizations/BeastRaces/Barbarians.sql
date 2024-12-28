--hero barbs
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_ACHERON', 'LOC_SLTH_UNIT_ACHERON_NAME', '2', '3', '91', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '25', '0', 'LOC_SLTH_UNIT_ACHERON_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_ARS', 'LOC_SLTH_UNIT_ARS_NAME', '2', '3', '62.4', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_ARS_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_BUBOES', 'LOC_SLTH_UNIT_BUBOES_NAME', '2', '3', '120', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_BUBOES_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_STEPHANOS', 'LOC_SLTH_UNIT_STEPHANOS_NAME', '2', '3', '92', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_STEPHANOS_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_WRATH', 'LOC_SLTH_UNIT_WRATH_NAME', '2', '2', '159', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_WRATH_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_YERSINIA', 'LOC_SLTH_UNIT_YERSINIA_NAME', '2', '3', '72', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_YERSINIA_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_GURID', 'LOC_SLTH_UNIT_GURID_NAME', '2', '1', '106', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_GURID_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_MARGALARD', 'LOC_SLTH_UNIT_MARGALARD_NAME', '2', '1', '106', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_MARGALARD_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_LEVIATHAN', 'LOC_SLTH_UNIT_LEVIATHAN_NAME', '2', '4', '106', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_LEVIATHAN_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_MOKKA', 'LOC_SLTH_UNIT_MOKKA_NAME', '2', '1', '29', '34', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '1', 'LOC_SLTH_UNIT_MOKKA_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_SAILORS_DIRGE', 'LOC_SLTH_UNIT_SAILORS_DIRGE_NAME', '2', '3', '39', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_SAILORS_DIRGE_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_NAVAL_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_TUMTUM', 'LOC_SLTH_UNIT_TUMTUM_NAME', '2', '3', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_SLTH_UNIT_TUMTUM_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_ORTHUS', 'LOC_SLTH_UNIT_ORTHUS_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_ORTHUS_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');
-- weird barbs
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_AZER', 'LOC_SLTH_UNIT_AZER_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_AZER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_FROSTLING', 'LOC_SLTH_UNIT_FROSTLING_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_FROSTLING_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_RECON', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0'),
('SLTH_UNIT_FROSTLING_ARCHER', 'LOC_SLTH_UNIT_FROSTLING_ARCHER_NAME', '2', '1', '10', '14', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_FROSTLING_ARCHER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_RANGED', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_FROSTLING_WOLF_RIDER', 'LOC_SLTH_UNIT_FROSTLING_WOLF_RIDER_NAME', '2', '2', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_FROSTLING_WOLF_RIDER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

-- animal barbs
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_BABY_SPIDER', 'LOC_SLTH_UNIT_BABY_SPIDER_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_BABY_SPIDER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_GIANT_SPIDER', 'LOC_SLTH_UNIT_GIANT_SPIDER_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_GIANT_SPIDER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_BEAR', 'LOC_SLTH_UNIT_BEAR_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '50', '0', 'LOC_SLTH_UNIT_BEAR_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_POLAR_BEAR', 'LOC_SLTH_UNIT_POLAR_BEAR_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '50', '0', 'LOC_SLTH_UNIT_POLAR_BEAR_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_ELEPHANT', 'LOC_SLTH_UNIT_ELEPHANT_NAME', '2', '1', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '50', '0', 'LOC_SLTH_UNIT_ELEPHANT_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_GIANT_TORTOISE', 'LOC_SLTH_UNIT_GIANT_TORTOISE_NAME', '2', '1', '29', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_GIANT_TORTOISE_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_GORILLA', 'LOC_SLTH_UNIT_GORILLA_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_GORILLA_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_GRIFFON', 'LOC_SLTH_UNIT_GRIFFON_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_GRIFFON_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_KRAKEN', 'LOC_SLTH_UNIT_KRAKEN_NAME', '2', '4', '82', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_KRAKEN_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_LION', 'LOC_SLTH_UNIT_LION_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_LION_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_LION_PRIDE', 'LOC_SLTH_UNIT_LION_PRIDE_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_LION_PRIDE_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_SCORPION', 'LOC_SLTH_UNIT_SCORPION_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_SCORPION_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_SEA_SERPENT', 'LOC_SLTH_UNIT_SEA_SERPENT_NAME', '2', '1', '39', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_SEA_SERPENT_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_MANTICORE', 'LOC_SLTH_UNIT_MANTICORE_NAME', '2', '3', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_MANTICORE_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_TIGER', 'LOC_SLTH_UNIT_TIGER_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_TIGER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_WOLF', 'LOC_SLTH_UNIT_WOLF_NAME', '2', '2', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '50', '0', 'LOC_SLTH_UNIT_WOLF_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0'),
('SLTH_UNIT_WOLF_PACK', 'LOC_SLTH_UNIT_WOLF_PACK_NAME', '2', '2', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '50', '0', 'LOC_SLTH_UNIT_WOLF_PACK_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_ANIMAL', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0');

-- mmust purchase because of pact of nilhorn
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase) VALUES
('SLTH_UNIT_HILL_GIANT', 'LOC_SLTH_UNIT_HILL_GIANT_NAME', '4', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '100', '0', 'LOC_SLTH_UNIT_HILL_GIANT_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_BEAST', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0', NULL, '1');

-- free city buildable
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, AllowBarbarians, PromotionClass, CanTrain, Maintenance, AdvisorType) VALUES
('SLTH_UNIT_SON_OF_THE_INFERNO', 'LOC_SLTH_UNIT_SON_OF_THE_INFERNO_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '1', 'LOC_SLTH_UNIT_SON_OF_THE_INFERNO_DESCRIPTION', '1', 'PROMOTION_CLASS_ADEPT', '0', '1', 'ADVISOR_CONQUEST'),
('SLTH_UNIT_DISCIPLE_OF_ACHERON', 'LOC_SLTH_UNIT_DISCIPLE_OF_ACHERON_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '1', 'LOC_SLTH_UNIT_DISCIPLE_OF_ACHERON_DESCRIPTION', '1', 'PROMOTION_CLASS_ADEPT', '1', '1', 'ADVISOR_CONQUEST');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES
('SLTH_UNIT_DISCIPLE_OF_ACHERON', 'BUILDING_ACHERONS_LAIR');

INSERT INTO Buildings(BuildingType, Name, Cost, PrereqDistrict, Description, AdvisorType, PurchaseYield, MustPurchase) VALUES
('BUILDING_ACHERONS_LAIR', 'LOC_BUILDING_ACHERONS_LAIR_NAME', '1', 'DISTRICT_CITY_CENTER', 'LOC_BUILDING_ACHERONS_LAIR_DESCRIPTION', 'ADVISOR_CULTURE', NULL, '1');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent) VALUES
('MODIFIER_GRANT_ACHERONS_LAIR', 'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE', '1', '1');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_GRANT_ACHERONS_LAIR', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_ACHERONS_LAIR');
-- goblin fort
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_ARCHER_SCORPION_CLAN', 'LOC_SLTH_UNIT_ARCHER_SCORPION_CLAN_NAME', '2', '1', '14', '3', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_ARCHER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_RANGED', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_CHARIOT_SCORPION_CLAN', 'LOC_SLTH_UNIT_CHARIOT_SCORPION_CLAN_NAME', '10', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CHARIOT_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0'),
('SLTH_UNIT_GOBLIN_SCORPION_CLAN', 'LOC_SLTH_UNIT_GOBLIN_SCORPION_CLAN_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '15', '0', 'LOC_SLTH_UNIT_GOBLIN_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_RECON', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0'),
('SLTH_UNIT_WOLF_RIDER_SCORPION_CLAN', 'LOC_SLTH_UNIT_WOLF_RIDER_SCORPION_CLAN_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '45', '0', 'LOC_SLTH_UNIT_WOLF_RIDER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_ACHERON', 'CLASS_BEAST'),
('SLTH_UNIT_BUBOES', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_ARS', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_AZER', 'CLASS_MELEE'),
('SLTH_UNIT_BABY_SPIDER', 'CLASS_ANIMAL'),
('SLTH_UNIT_BEAR', 'CLASS_ANIMAL'),
('SLTH_UNIT_POLAR_BEAR', 'CLASS_ANIMAL'),
('SLTH_UNIT_ELEPHANT', 'CLASS_ANIMAL'),
('SLTH_UNIT_FROSTLING', 'CLASS_RECON'),
('SLTH_UNIT_FROSTLING_ARCHER', 'CLASS_RANGED'),
('SLTH_UNIT_FROSTLING_WOLF_RIDER', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_GIANT_SPIDER', 'CLASS_ANIMAL'),
('SLTH_UNIT_GIANT_TORTOISE', 'CLASS_ANIMAL'),
('SLTH_UNIT_GORILLA', 'CLASS_ANIMAL'),
('SLTH_UNIT_GRIFFON', 'CLASS_ANIMAL'),
('SLTH_UNIT_GURID', 'CLASS_BEAST'),
('SLTH_UNIT_KRAKEN', 'CLASS_BEAST'),
('SLTH_UNIT_LEVIATHAN', 'CLASS_BEAST'),
('SLTH_UNIT_LION', 'CLASS_ANIMAL'),
('SLTH_UNIT_LION_PRIDE', 'CLASS_ANIMAL'),
('SLTH_UNIT_MARGALARD', 'CLASS_BEAST'),
('SLTH_UNIT_MOKKA', 'CLASS_ADEPT'),
('SLTH_UNIT_ORTHUS', 'CLASS_MELEE'),
('SLTH_UNIT_SEA_SERPENT', 'CLASS_ANIMAL'),
('SLTH_UNIT_STEPHANOS', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_TIGER', 'CLASS_ANIMAL'),
('SLTH_UNIT_TUMTUM', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_WOLF', 'CLASS_ANIMAL'),
('SLTH_UNIT_WOLF_PACK', 'CLASS_ANIMAL'),
('SLTH_UNIT_WRATH', 'CLASS_MELEE'),
('SLTH_UNIT_YERSINIA', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_FROSTLING', 'RACE_FROSTLING'),
('SLTH_UNIT_FROSTLING_ARCHER', 'RACE_FROSTLING'),
('SLTH_UNIT_FROSTLING_WOLF_RIDER', 'RACE_FROSTLING'),
('SLTH_UNIT_ORTHUS', 'RACE_ORCISH'),
('SLTH_UNIT_TUMTUM', 'RACE_ORCISH'),
('SLTH_UNIT_SON_OF_THE_INFERNO', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_SON_OF_THE_INFERNO', 'CLASS_ADEPT');

INSERT INTO Units_Presentation(UnitType, UIFlagOffset) VALUES ('SLTH_UNIT_ACHERON', '20'),
                                                              ('SLTH_UNIT_WRATH', '20');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_UNIT_ACHERON', 'KIND_UNIT'),
('SLTH_UNIT_ARS', 'KIND_UNIT'),
('SLTH_UNIT_BUBOES', 'KIND_UNIT'),
('SLTH_UNIT_DRIFA', 'KIND_UNIT'),
('SLTH_UNIT_STEPHANOS', 'KIND_UNIT'),
('SLTH_UNIT_GURID', 'KIND_UNIT'),
('SLTH_UNIT_KRAKEN', 'KIND_UNIT'),
('SLTH_UNIT_LEVIATHAN', 'KIND_UNIT'),
('SLTH_UNIT_MARGALARD', 'KIND_UNIT'),
('SLTH_UNIT_MOKKA', 'KIND_UNIT'),
('SLTH_UNIT_ORTHUS', 'KIND_UNIT'),
('SLTH_UNIT_TUMTUM', 'KIND_UNIT'),
('SLTH_UNIT_WRATH', 'KIND_UNIT'),
('SLTH_UNIT_YERSINIA', 'KIND_UNIT'),
('SLTH_UNIT_AZER', 'KIND_UNIT'),
('SLTH_UNIT_FROSTLING', 'KIND_UNIT'),
('SLTH_UNIT_FROSTLING_ARCHER', 'KIND_UNIT'),
('SLTH_UNIT_FROSTLING_WOLF_RIDER', 'KIND_UNIT'),
('SLTH_UNIT_BABY_SPIDER', 'KIND_UNIT'),
('SLTH_UNIT_BEAR', 'KIND_UNIT'),
('SLTH_UNIT_POLAR_BEAR', 'KIND_UNIT'),
('SLTH_UNIT_ELEPHANT', 'KIND_UNIT'),
('SLTH_UNIT_GIANT_SPIDER', 'KIND_UNIT'),
('SLTH_UNIT_GIANT_TORTOISE', 'KIND_UNIT'),
('SLTH_UNIT_GORILLA', 'KIND_UNIT'),
('SLTH_UNIT_GRIFFON', 'KIND_UNIT'),
('SLTH_UNIT_LION', 'KIND_UNIT'),
('SLTH_UNIT_LION_PRIDE', 'KIND_UNIT'),
('SLTH_UNIT_SEA_SERPENT', 'KIND_UNIT'),
('SLTH_UNIT_WOLF', 'KIND_UNIT'),
('SLTH_UNIT_WOLF_PACK', 'KIND_UNIT'),
('SLTH_UNIT_TIGER', 'KIND_UNIT'),
('SLTH_UNIT_SON_OF_THE_INFERNO', 'KIND_UNIT'),
('BUILDING_ACHERONS_LAIR', 'KIND_BUILDING');