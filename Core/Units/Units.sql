
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('SLTH_UNIT_ABASHI', 'LOC_SLTH_UNIT_ABASHI_NAME', '2', '3', '101', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_ABASHI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ABASHI', '0', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('SLTH_UNIT_DISCIPLE_THE_ORDER',            'LOC_SLTH_UNIT_DISCIPLE_THE_ORDER_NAME',            'LOC_SLTH_UNIT_DISCIPLE_THE_ORDER_DESCRIPTION',            '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_ORDERS_FROM_HEAVEN',    'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_ADEPT', 'LOC_SLTH_UNIT_ADEPT_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '1', 'LOC_SLTH_UNIT_ADEPT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', 'TECH_KNOWLEDGE_OF_THE_ETHER', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_AIRSHIP', 'LOC_SLTH_UNIT_AIRSHIP_NAME', '2', '3', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_SLTH_UNIT_AIRSHIP_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_AIRSHIP', '0', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_ASTRONOMY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_ALAZKAN', 'LOC_SLTH_UNIT_ALAZKAN_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_ALAZKAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ALAZKAN', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_ANGEL', 'LOC_SLTH_UNIT_ANGEL_NAME', '2', '1', '19', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1', '0', 'LOC_SLTH_UNIT_ANGEL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_ANGEL_OF_DEATH', 'LOC_SLTH_UNIT_ANGEL_OF_DEATH_NAME', '2', '2', '39', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '3', '0', 'LOC_SLTH_UNIT_ANGEL_OF_DEATH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ANGEL_OF_DEATH', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_ARCANE_BARGE', 'LOC_SLTH_UNIT_ARCANE_BARGE_NAME', '2', '3', '38', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '250',  'LOC_SLTH_UNIT_ARCANE_BARGE_DESCRIPTION', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_ASTRONOMY', '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AirSlots, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_ARCHER', 'LOC_SLTH_UNIT_ARCHER_NAME', '2', '1', '14', '14', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60','LOC_SLTH_UNIT_ARCHER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_ARCHERY', NULL, '1', '1',  '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_ARTHENDAIN', 'LOC_SLTH_UNIT_ARTHENDAIN_NAME', '2', '1', '43', '9', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_ARTHENDAIN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RANGED', 'TECH_MEDICINE', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AirSlots, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_ARQUEBUS', 'LOC_SLTH_UNIT_ARQUEBUS_NAME', '2', '1', '48', '53', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', 'LOC_SLTH_UNIT_ARQUEBUS_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RANGED', 'TECH_BLASTING_POWDER', NULL, '1', '1',  '0',  NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('SLTH_UNIT_ASSASSIN', 'LOC_SLTH_UNIT_ASSASSIN_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', 'LOC_SLTH_UNIT_ASSASSIN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1','0',NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_BALOR', 'LOC_SLTH_UNIT_BALOR_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_SLTH_UNIT_BALOR_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BALOR', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1',  '0',  NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BAMBUR', 'LOC_SLTH_UNIT_BAMBUR_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_BAMBUR_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_ARETE', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('SLTH_UNIT_BARNAXUS', 'LOC_SLTH_UNIT_BARNAXUS_NAME', '2', '1', '24', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_BARNAXUS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BARNAXUS', 'PROMOTION_CLASS_MELEE', 'TECH_CONSTRUCTION', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', 'PSEUDOYIELD_UNIT_HERO', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('SLTH_UNIT_BASIUM', 'LOC_SLTH_UNIT_BASIUM_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_BASIUM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BASIUM', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', NULL, '1', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BATTLEMASTER', 'LOC_SLTH_UNIT_BATTLEMASTER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_SLTH_UNIT_BATTLEMASTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BATTLEMASTER', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BEAST_OF_AGARES', 'LOC_SLTH_UNIT_BEAST_OF_AGARES_NAME', '2', '2', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_BEAST_OF_AGARES_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_MALEVOLENT_DESIGNS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BEASTMAN', 'LOC_SLTH_UNIT_BEASTMAN_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '25', '0', 'LOC_SLTH_UNIT_BEASTMAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BEASTMAN', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AirSlots, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BEASTMASTER', 'LOC_SLTH_UNIT_BEASTMASTER_NAME', '2', '2', '67', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_SLTH_UNIT_BEASTMASTER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_MASTERY', NULL, '1', '1',  '1', NULL, '0', 'ADVISOR_GENERIC', '0', 1),
('SLTH_UNIT_BERSERKER', 'LOC_SLTH_UNIT_BERSERKER_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_SLTH_UNIT_BERSERKER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BISON_RIDER', 'LOC_SLTH_UNIT_BISON_RIDER_NAME', '2', '2', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_BISON_RIDER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BISON_RIDER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('SLTH_UNIT_BLACK_WIND', 'LOC_SLTH_UNIT_BLACK_WIND_NAME', '2', '4', '48', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '300', '0', 'LOC_SLTH_UNIT_BLACK_WIND_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BLACK_WIND', '0', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BOAR_RIDER', 'LOC_SLTH_UNIT_BOAR_RIDER_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_BOAR_RIDER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BOAR_RIDER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('SLTH_UNIT_BOARDING_PARTY', 'LOC_SLTH_UNIT_BOARDING_PARTY_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_BOARDING_PARTY_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BOARDING_PARTY', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('SLTH_UNIT_BONE_GOLEM', 'LOC_SLTH_UNIT_BONE_GOLEM_NAME', '2', '1', '63', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_BONE_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BONE_GOLEM', NULL, NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BRUJAH', 'LOC_SLTH_UNIT_BRUJAH_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_BRUJAH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CAMEL_ARCHER', 'LOC_SLTH_UNIT_CAMEL_ARCHER_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CAMEL_ARCHER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CAMEL_ARCHER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CANNON', 'LOC_SLTH_UNIT_CANNON_NAME', '2', '1', '38', '43', '53',  '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_CANNON_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_SIEGE', 'TECH_BLASTING_POWDER', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_CARAVEL', 'LOC_SLTH_UNIT_CARAVEL_NAME', '2', '4', '34', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '100', 'LOC_SLTH_UNIT_CARAVEL_DESCRIPTION', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS', '1', '1', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CATAPULT', 'LOC_SLTH_UNIT_CATAPULT_NAME', '2', '1', '19', '24', '34', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_CATAPULT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_SIEGE', 'TECH_CONSTRUCTION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CENTAUR_ARCHER', 'LOC_SLTH_UNIT_CENTAUR_ARCHER_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CENTAUR_ARCHER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_ARCHER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_CENTAUR_CHARGER', 'LOC_SLTH_UNIT_CENTAUR_CHARGER_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CENTAUR_CHARGER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_CHARGER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_CENTAUR', 'LOC_SLTH_UNIT_CENTAUR_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_CENTAUR_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_CENTAUR_LANCER', 'LOC_SLTH_UNIT_CENTAUR_LANCER_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_CENTAUR_LANCER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_LANCER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('SLTH_UNIT_CLOCKWORK_GOLEM', 'LOC_SLTH_UNIT_CLOCKWORK_GOLEM_NAME', '2', '1', '72', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_CLOCKWORK_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CLOCKWORK_GOLEM', NULL, 'TECH_MACHINERY', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CHALID', 'LOC_SLTH_UNIT_CHALID_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_SLTH_UNIT_CHALID_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_RELIGIOUS_LAW', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CHAMPION', 'LOC_SLTH_UNIT_CHAMPION_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CHAMPION_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CHANTER', 'LOC_SLTH_UNIT_CHANTER_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CHANTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CHANTER', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CHARIOT', 'LOC_SLTH_UNIT_CHARIOT_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CHARIOT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PRIEST_OF_THE_ORDER', 'LOC_SLTH_UNIT_PRIEST_OF_THE_ORDER_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_THE_ORDER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CORLINDALE', 'LOC_SLTH_UNIT_CORLINDALE_NAME', '2', '2', '0', '0', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '300', '1', 'LOC_SLTH_UNIT_CORLINDALE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CORLINDALE', '0', 'PROMOTION_CLASS_ADEPT', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_COURTESAN', 'LOC_SLTH_UNIT_COURTESAN_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_COURTESAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_COURTESAN', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CRUSADER', 'LOC_SLTH_UNIT_CRUSADER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_CRUSADER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_CROSSBOWMAN', 'LOC_SLTH_UNIT_CROSSBOWMAN_NAME', '2', '1', '44', '48', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_CROSSBOWMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RANGED', 'TECH_MACHINERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PRIEST_OF_THE_OVERLORDS', 'LOC_SLTH_UNIT_PRIEST_OF_THE_OVERLORDS_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_THE_OVERLORDS_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DEATH_KNIGHT', 'LOC_SLTH_UNIT_DEATH_KNIGHT_NAME', '2', '3', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_DEATH_KNIGHT_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEATH_KNIGHT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_DEMAGOG', 'LOC_SLTH_UNIT_DEMAGOG_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_DEMAGOG_DESCRIPTION', 'SLTH_TRAIT_RELIGION_UNIT_DEMAGOG', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_DEVOUT', 'LOC_SLTH_UNIT_DEVOUT_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_DEVOUT_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEVOUT', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'LOC_SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES_NAME', 'LOC_SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES_DESCRIPTION', '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_WAY_OF_THE_FORESTS',    'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DISEASED_CORPSE', 'LOC_SLTH_UNIT_DISEASED_CORPSE_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_DISEASED_CORPSE_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_CORRUPTION_OF_SPIRIT', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DIVIDED_SOUL', 'LOC_SLTH_UNIT_DIVIDED_SOUL_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_DIVIDED_SOUL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DIVIDED_SOUL', '0', 'PROMOTION_CLASS_RECON', 'TECH_HUNTING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DONAL', 'LOC_SLTH_UNIT_DONAL_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_SLTH_UNIT_DONAL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DONAL', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DRAGON_SLAYER', 'LOC_SLTH_UNIT_DRAGON_SLAYER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_DRAGON_SLAYER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DRAGON_SLAYER', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DROWN', 'LOC_SLTH_UNIT_DROWN_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_DROWN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MESSAGE_FROM_THE_DEEP', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqCivic, CanTrain, Maintenance, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DRUID',   'LOC_SLTH_UNIT_DRUID_NAME',   '2', '2', '39', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_SLTH_UNIT_DRUID_DESCRIPTION',   'SLTH_RELIGION_BAN_TRAIT',   '0', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_COMMUNE_WITH_NATURE', '1', '1', '1', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DUIN', 'LOC_SLTH_UNIT_DUIN_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '500', '0', 'LOC_SLTH_UNIT_DUIN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_FERAL_BOND', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DWARVEN_CANNON', 'LOC_SLTH_UNIT_DWARVEN_CANNON_NAME', '2', '1', '48', '53', '63', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_DWARVEN_CANNON_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_CANNON', '0', 'PROMOTION_CLASS_SIEGE', 'TECH_BLASTING_POWDER', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DWARVEN_DRUID', 'LOC_SLTH_UNIT_DWARVEN_DRUID_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_DWARVEN_DRUID_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_DRUID', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_COMMUNE_WITH_NATURE', '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1'),
('SLTH_UNIT_DWARVEN_SHADOW', 'LOC_SLTH_UNIT_DWARVEN_SHADOW_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_DWARVEN_SHADOW_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_SHADOW', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_DWARVEN_SLINGER', 'LOC_SLTH_UNIT_DWARVEN_SLINGER_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_DWARVEN_SLINGER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_SLINGER', '0', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_ARCHERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_DWARVEN_SOLDIER_RUNES', 'LOC_SLTH_UNIT_DWARVEN_SOLDIER_RUNES_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_SOLDIER_OF_KILMORPH_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_WAY_OF_THE_EARTHMOTHER', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('SLTH_UNIT_EATER_OF_DREAMS', 'LOC_SLTH_UNIT_EATER_OF_DREAMS_NAME', '2', '1', '24', '5', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '1', 'LOC_SLTH_UNIT_EATER_OF_DREAMS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_EATER_OF_DREAMS', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_STRENGTH_OF_WILL', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('SLTH_UNIT_DISCIPLE_EMPYREAN',             'LOC_SLTH_UNIT_DISCIPLE_EMPYREAN_NAME',             'LOC_SLTH_UNIT_DISCIPLE_EMPYREAN_DESCRIPTION',             '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_HONOR',                 'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqCivic, CanTrain, Maintenance, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_EIDOLON', 'LOC_SLTH_UNIT_EIDOLON_NAME', '2', '1', '53', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_SLTH_UNIT_EIDOLON_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_MALEVOLENT_DESIGNS',  '1', '1', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_EURABATRES', 'LOC_SLTH_UNIT_EURABATRES_NAME', '2', '3', '111', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_EURABATRES_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_EURABATRES', '0', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_FAWN', 'LOC_SLTH_UNIT_FAWN_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_FAWN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_WAY_OF_THE_FORESTS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_FIREBOW', 'LOC_SLTH_UNIT_FIREBOW_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_FIREBOW_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FIREBOW', '0', 'PROMOTION_CLASS_RANGED', 'TECH_BOWYERS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_FLAGBEARER', 'LOC_SLTH_UNIT_FLAGBEARER_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_FLAGBEARER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FLAGBEARER', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_FLURRY', 'LOC_SLTH_UNIT_FLURRY_NAME', '2', '2', '58', '63', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_FLURRY_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FLURRY', '0', 'PROMOTION_CLASS_RANGED', 'TECH_MACHINERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_FRIGATE', 'LOC_SLTH_UNIT_FRIGATE_NAME', '2', '3', '48', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '150', 'LOC_SLTH_UNIT_FRIGATE_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS',  '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_FREAK', 'LOC_SLTH_UNIT_FREAK_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_FREAK_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FREAK', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_GAMES_RECREATION', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_FYRDWELL', 'LOC_SLTH_UNIT_FYRDWELL_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_FYRDWELL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FYRDWELL', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_GARGOYLE', 'LOC_SLTH_UNIT_GARGOYLE_NAME', '2', '1', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_GARGOYLE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GARGOYLE', '0', NULL, 'TECH_ENGINEERING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_GALLEON', 'LOC_SLTH_UNIT_GALLEON_NAME', '2', '5', '34', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '150', 'LOC_SLTH_UNIT_GALLEON_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_ASTRONOMY',  '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1),
('SLTH_UNIT_GALLEY', 'LOC_SLTH_UNIT_GALLEY_NAME', '2', '3', '24', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '50', 'LOC_SLTH_UNIT_GALLEY_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'SLTH_TECH_SAILING', '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_GHOST', 'LOC_SLTH_UNIT_GHOST_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_GHOST_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GHOST', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_GIBBON', 'LOC_SLTH_UNIT_GIBBON_NAME', '2', '1', '24', '5', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '1', 'LOC_SLTH_UNIT_GIBBON_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_ADEPT', NULL, 'CIVIC_DECEPTION', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_TECHNOLOGY', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_GILDEN', 'LOC_SLTH_UNIT_GILDEN_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_GILDEN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GILDEN', '0', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_ARCHERY', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_GOBLIN', 'LOC_SLTH_UNIT_GOBLIN_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '15', '0', 'LOC_SLTH_UNIT_GOBLIN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN', '1', 'PROMOTION_CLASS_RECON', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_GOVANNON', 'LOC_SLTH_UNIT_GOVANNON_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '480', '1', 'LOC_SLTH_UNIT_GOVANNON_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GOVANNON', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_ARCANE_LORE', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_GRIGORI_MEDIC', 'LOC_SLTH_UNIT_GRIGORI_MEDIC_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_GRIGORI_MEDIC_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GRIGORI_MEDIC', '0', 'PROMOTION_CLASS_MELEE', 'TECH_MEDICINE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('SLTH_UNIT_GUYBRUSH', 'LOC_SLTH_UNIT_GUYBRUSH_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_GUYBRUSH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GUYBRUSH', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_HARLEQUIN', 'LOC_SLTH_UNIT_HARLEQUIN_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_SLTH_UNIT_HARLEQUIN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HARLEQUIN', '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_HANDLING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_HAWK', 'LOC_SLTH_UNIT_HAWK_NAME', '4', '8', '0', '0', '5', 'DOMAIN_AIR', 'FORMATION_CLASS_AIR', '20', '0', 'LOC_SLTH_UNIT_HAWK_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', 'TECH_HUNTING', NULL, '1', '1', '1', '0', '1', 'PSEUDOYIELD_UNIT_AIR_COMBAT', '1', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('SLTH_UNIT_HELLHOUND', 'LOC_SLTH_UNIT_HELLHOUND_NAME', '2', '3', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_HELLHOUND_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HELLHOUND', '0', 'PROMOTION_CLASS_RECON', 'TECH_HUNTING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', NULL, '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_HEMAH', 'LOC_SLTH_UNIT_HEMAH_NAME', '2', '1', '34', '7', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '1', 'LOC_SLTH_UNIT_HEMAH_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_ARCANE_LORE', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_HERALD', 'LOC_SLTH_UNIT_HERALD_NAME', '2', '2', '68', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '3', '0', 'LOC_SLTH_UNIT_HERALD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HERALD', '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_MASTERY', NULL, '1', '1', '0', '1', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_HERNE', 'LOC_SLTH_UNIT_HERNE_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_HERNE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HERNE', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_HORNGUARD', 'LOC_SLTH_UNIT_HORNGUARD_NAME', '2', '2', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_DWARVEN_HORNGUARD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HORNGUARD', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('SLTH_UNIT_HYBOREM', 'LOC_SLTH_UNIT_HYBOREM_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '100', '0', 'LOC_SLTH_UNIT_HYBOREM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', NULL, '1', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_HORSE_ARCHER', 'LOC_SLTH_UNIT_HORSE_ARCHER_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_HORSE_ARCHER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_HORSEMAN', 'LOC_SLTH_UNIT_HORSEMAN_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_HORSEMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_HUNTER', 'LOC_SLTH_UNIT_HUNTER_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_HUNTER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', 'TECH_HUNTING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_ILLUSIONIST', 'LOC_SLTH_UNIT_ILLUSIONIST_NAME', '2', '1', '19', '24', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '1', 'LOC_SLTH_UNIT_ILLUSIONIST_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ILLUSIONIST', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_SORCERY', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_TECHNOLOGY', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('SLTH_UNIT_IMP', 'LOC_SLTH_UNIT_IMP_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '1', 'LOC_SLTH_UNIT_IMP_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_IMP', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_KNOWLEDGE_OF_THE_ETHER', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', '0', NULL, '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('SLTH_UNIT_IRON_GOLEM', 'LOC_SLTH_UNIT_IRON_GOLEM_NAME', '2', '1', '48', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_IRON_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_IRON_GOLEM', NULL, 'TECH_IRON_WORKING', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_JAVELIN_THROWER', 'LOC_SLTH_UNIT_JAVELIN_THROWER_NAME', '2', '1', '19', '4', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_JAVELIN_THROWER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_JAVELIN_THROWER', '0', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_ARCHERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('SLTH_UNIT_KNIGHT', 'LOC_SLTH_UNIT_KNIGHT_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_KNIGHT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_LIGHTBRINGER', 'LOC_SLTH_UNIT_LIGHTBRINGER_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_LIGHTBRINGER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LIGHTBRINGER', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_LIZARDMAN', 'LOC_SLTH_UNIT_LIZARDMAN_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_LIZARDMAN_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_RECON', NULL, NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_LOKI', 'LOC_SLTH_UNIT_LOKI_NAME', '2', '2', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_LOKI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOKI', '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_LONGBOWMAN', 'LOC_SLTH_UNIT_LONGBOWMAN_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_LONGBOWMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RANGED', 'TECH_BOWYERS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_LOSHA', 'LOC_SLTH_UNIT_LOSHA_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_SLTH_UNIT_LOSHA_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_LUNATIC', 'LOC_SLTH_UNIT_LUNATIC_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_LUNATIC_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MIND_STAPLING', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_LUONNOTAR', 'LOC_SLTH_UNIT_LUONNOTAR_NAME', '2', '1', '48', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_LUONNOTAR_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LUONNOTAR', '0', 'PROMOTION_CLASS_DISCIPLE', 'TECH_STRENGTH_OF_WILL', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_KITHRA', 'LOC_SLTH_UNIT_KITHRA_NAME', '2', '3', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_KITHRA_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_FERAL_BOND', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, PromotionClass, PrereqTech, CanTrain, PseudoYieldType, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_MAGNADINE', 'LOC_SLTH_UNIT_MAGNADINE_NAME', '2', '4', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', 'LOC_SLTH_UNIT_MAGNADINE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MAGNADINE', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', '1',  'PSEUDOYIELD_UNIT_HERO','ADVISOR_CONQUEST', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_MAN_O_WAR', 'LOC_SLTH_UNIT_MAN_O_WAR_NAME', '2', '5', '63', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '225',  'LOC_SLTH_UNIT_MAN_O_WAR_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_BLASTING_POWDER', '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('SLTH_UNIT_MANES', 'LOC_SLTH_UNIT_MANES_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1', '0', 'LOC_SLTH_UNIT_MANES_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MARDERO', 'LOC_SLTH_UNIT_MARDERO_NAME', '2', '2', '48', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_MARDERO_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_MALEVOLENT_DESIGNS', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MARKSMAN', 'LOC_SLTH_UNIT_MARKSMAN_NAME', '2', '1', '53', '58', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_MARKSMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RANGED', 'TECH_PRECISION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MAROS', 'LOC_SLTH_UNIT_MAROS_NAME', '2', '1', '29', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_MAROS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MAROS', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, PromotionClass, PrereqTech, CanTrain, PseudoYieldType, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_MERCENARY_MOUNTED', 'LOC_SLTH_UNIT_MERCENARY_MOUNTED_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '100', 'LOC_SLTH_UNIT_MERCENARY_MOUNTED_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MERCENARY_MOUNTED', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, '0', NULL, 'ADVISOR_CONQUEST', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MESHABBER', 'LOC_SLTH_UNIT_MESHABBER_NAME', '2', '2', '92', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1200', '0', 'LOC_SLTH_UNIT_MESHABBER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_INFERNAL_PACT', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MIMIC', 'LOC_SLTH_UNIT_MIMIC_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_MIMIC_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MIMIC', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MITHRIL_GOLEM', 'LOC_SLTH_UNIT_MITHRIL_GOLEM_NAME', '2', '1', '121', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1200', '0', 'LOC_SLTH_UNIT_MITHRIL_GOLEM_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', NULL, 'TECH_MITHRIL_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MONK', 'LOC_SLTH_UNIT_MONK_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_MONK_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MONK', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MOROI', 'LOC_SLTH_UNIT_MOROI_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_MOROI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('SLTH_UNIT_MUD_GOLEM', 'LOC_SLTH_UNIT_MUD_GOLEM_NAME', '2', '2', '14', '1', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '100', '5', 'LOC_SLTH_UNIT_MUD_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM', NULL, NULL, NULL, '1', '1', 'ADVISOR_GENERIC', '0', NULL, '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MYCONID', 'LOC_SLTH_UNIT_MYCONID_NAME', '2', '2', '68', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_MYCONID_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MYCONID', '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_MASTERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_NIGHTWATCH', 'LOC_SLTH_UNIT_NIGHTWATCH_NAME', '2', '1', '14', '3', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_NIGHTWATCH_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RANGED', 'TECH_BOWYERS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('SLTH_UNIT_NULLSTONE_GOLEM', 'LOC_SLTH_UNIT_NULLSTONE_GOLEM_NAME', '2', '1', '63', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_NULLSTONE_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_NULLSTONE_GOLEM', NULL, 'TECH_MITHRIL_WEAPONS', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_NYXKIN', 'LOC_SLTH_UNIT_NYXKIN_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_NYXKIN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_NYXKIN', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_OGRE', 'LOC_SLTH_UNIT_OGRE_NAME', '2', '1', '38', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_OGRE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_OGRE', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_OGRE_WARCHIEF', 'LOC_SLTH_UNIT_OGRE_WARCHIEF_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_OGRE_WARCHIEF_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_WARCHIEF', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_OPHANIM', 'LOC_SLTH_UNIT_OPHANIM_NAME', '2', '2', '43', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '3', '0', 'LOC_SLTH_UNIT_OPHANIM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_OPHANIM', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqCivic, CanTrain, Maintenance, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PALADIN', 'LOC_SLTH_UNIT_PALADIN_NAME', '2', '1', '53', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_SLTH_UNIT_PALADIN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_RIGHTEOUSNESS',       '1', '1', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PARAMANDER', 'LOC_SLTH_UNIT_PARAMANDER_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PARAMANDER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PHALANX', 'LOC_SLTH_UNIT_PHALANX_NAME', '2', '1', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_PHALANX_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', 'TECH_MITHRIL_WEAPONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('SLTH_UNIT_PIRATE', 'LOC_SLTH_UNIT_PIRATE_NAME', '2', '4', '39', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '100', '0', 'LOC_SLTH_UNIT_PIRATE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_PIRATE', '0', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PRIEST_OF_LEAVES', 'LOC_SLTH_UNIT_PRIEST_OF_LEAVES_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_LEAVES_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_PRIVATEER', 'LOC_SLTH_UNIT_PRIVATEER_NAME', '2', '4', '39', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '100', 'LOC_SLTH_UNIT_PRIVATEER_DESCRIPTION', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS', '1', '1', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PUPPET', 'LOC_SLTH_UNIT_PUPPET_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_PUPPET_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('SLTH_UNIT_PYRE_ZOMBIE', 'LOC_SLTH_UNIT_PYRE_ZOMBIE_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_PYRE_ZOMBIE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_PYRE_ZOMBIE', '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_RADIANT_GUARD', 'LOC_SLTH_UNIT_RADIANT_GUARD_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_RADIANT_GUARD_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_HONOR', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_RATHA', 'LOC_SLTH_UNIT_RATHA_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_RATHA_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_REPENTANT_ANGEL', 'LOC_SLTH_UNIT_REPENTANT_ANGEL_NAME', '2', '3', '58',  'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_REPENTANT_ANGEL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_REPENTANT_ANGEL', '0', 'PROMOTION_CLASS_MELEE', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PRIEST_OF_THE_VEIL', 'LOC_SLTH_UNIT_PRIEST_OF_THE_VEIL_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_THE_VEIL_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_ROSIER', 'LOC_SLTH_UNIT_ROSIER_NAME', '2', '3', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_ROSIER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_CORRUPTION_OF_SPIRIT', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_ROYAL_GUARD', 'LOC_SLTH_UNIT_ROYAL_GUARD_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_ROYAL_GUARD_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_FEUDALISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_QUEEN_OF_THE_LINE', 'LOC_SLTH_UNIT_QUEEN_OF_THE_LINE_NAME', '2', '3', '43', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '225', 'LOC_SLTH_UNIT_QUEEN_OF_THE_LINE_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_ASTRONOMY',  '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_RATHUS', 'LOC_SLTH_UNIT_RATHUS_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_RATHUS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_RATHUS', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_RANTINE', 'LOC_SLTH_UNIT_RANTINE_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_RANTINE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_RANTINE', '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_RANGER', 'LOC_SLTH_UNIT_RANGER_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_SLTH_UNIT_RANGER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_HANDLING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', 1);

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL',       'LOC_SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL_NAME',       'LOC_SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL_DESCRIPTION',       '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_CORRUPTION_OF_SPIRIT',  'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_SAVEROUS', 'LOC_SLTH_UNIT_SAVEROUS_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_SAVEROUS_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MIND_STAPLING', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_SATYR', 'LOC_SLTH_UNIT_SATYR_NAME', '2', '2', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_SLTH_UNIT_SATYR_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_HANDLING', NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_SCOUT', 'LOC_SLTH_UNIT_SCOUT_NAME', '2', '2', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '25', '0', 'LOC_SLTH_UNIT_SCOUT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_SERAPH', 'LOC_SLTH_UNIT_SERAPH_NAME', '2', '1', '39', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '3', '0', 'LOC_SLTH_UNIT_SERAPH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_SERAPH', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_SHADOW', 'LOC_SLTH_UNIT_SHADOW_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_SHADOW_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('SLTH_UNIT_SHADOWRIDER', 'LOC_SLTH_UNIT_SHADOWRIDER_NAME', '2', '3', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_SHADOWRIDER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_SHAMAN', 'LOC_SLTH_UNIT_SHAMAN_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '1', 'LOC_SLTH_UNIT_SHAMAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_SHAMAN', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_KNOWLEDGE_OF_THE_ETHER', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_SONS_OF_ASENA', 'LOC_SLTH_UNIT_SONS_OF_ASENA_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_SONS_OF_ASENA_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_SONS_OF_ASENA', '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_SPHENER', 'LOC_SLTH_UNIT_SPHENER_NAME', '2', '2', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_SPHENER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_RIGHTEOUSNESS', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_STONESKIN_OGRE', 'LOC_SLTH_UNIT_STONESKIN_OGRE_NAME', '2', '1', '68', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_STONESKIN_OGRE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_STONESKIN_OGRE', '0', 'PROMOTION_CLASS_MELEE', 'TECH_MITHRIL_WEAPONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PRIEST_OF_KILMORPH', 'LOC_SLTH_UNIT_PRIEST_OF_KILMORPH_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_KILMORPH_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_STYGIAN_GUARD', 'LOC_SLTH_UNIT_STYGIAN_GUARD_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_STYGIAN_GUARD_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_SUPPLIES', 'LOC_SLTH_UNIT_SUPPLIES_NAME', '2', '1', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '-1', '0', 'LOC_SLTH_UNIT_SUPPLIES_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('SLTH_UNIT_SWORDSMAN', 'LOC_SLTH_UNIT_SWORDSMAN_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_SWORDSMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_TASKMASTER', 'LOC_SLTH_UNIT_TASKMASTER_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_TASKMASTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_TASKMASTER', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_TEUTORIX', 'LOC_SLTH_UNIT_TEUTORIX_NAME', '2', '2', '58', '63', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_TEUTORIX_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_TEUTORIX', '0', 'PROMOTION_CLASS_RANGED', 'TECH_BLASTING_POWDER', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH',    'LOC_SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH_NAME',    'LOC_SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH_DESCRIPTION',    '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_WAY_OF_THE_EARTHMOTHER','PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_TREBUCHET', 'LOC_SLTH_UNIT_TREBUCHET_NAME', '2', '1', '29', '34', '44', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_TREBUCHET_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_TREBUCHET', '0', 'PROMOTION_CLASS_SIEGE', 'TECH_CONSTRUCTION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_TRIREME', 'LOC_SLTH_UNIT_TRIREME_NAME', '2', '2', '34', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '75', 'LOC_SLTH_UNIT_TRIREME_DESCRIPTION', 'PROMOTION_CLASS_NAVAL_MELEE', 'SLTH_TECH_SAILING',  '1', '1', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_VALIN', 'LOC_SLTH_UNIT_VALIN_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_VALIN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_ORDERS_FROM_HEAVEN', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_VALKYRIE', 'LOC_SLTH_UNIT_VALKYRIE_NAME', '2', '1', '29', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '7', '0', 'LOC_SLTH_UNIT_VALKYRIE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VALKYRIE', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_VAMPIRE', 'LOC_SLTH_UNIT_VAMPIRE_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_SLTH_UNIT_VAMPIRE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FEUDALISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, PseudoYieldType, AdvisorType, ZoneOfControl) VALUES
('SLTH_UNIT_VAMPIRE_LORD', 'LOC_SLTH_UNIT_VAMPIRE_LORD_NAME', '2', '1', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_VAMPIRE_LORD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '0', '1', NULL, 'ADVISOR_CONQUEST', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_PRIEST_OF_THE_EMPYREAN', 'LOC_SLTH_UNIT_PRIEST_OF_THE_EMPYREAN_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_SLTH_UNIT_PRIEST_OF_THE_EMPYREAN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_WAR_MACHINE', 'LOC_SLTH_UNIT_WAR_MACHINE_NAME', '2', '3', '92', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_WAR_MACHINE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WAR_MACHINE', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_MACHINERY', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('SLTH_UNIT_WAR_TORTOISE', 'LOC_SLTH_UNIT_WAR_TORTOISE_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_WAR_TORTOISE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WAR_TORTOISE', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('SLTH_UNIT_WILBOMAN', 'LOC_SLTH_UNIT_WILBOMAN_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_SLTH_UNIT_WILBOMAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WILBOMAN', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', NULL, '0', '1');


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_WIZARD', 'LOC_SLTH_UNIT_WIZARD_NAME', '2', '1', '19', '24', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '1', 'LOC_SLTH_UNIT_WIZARD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WIZARD', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_SORCERY', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_WOLF_RIDER', 'LOC_SLTH_UNIT_WOLF_RIDER_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_SLTH_UNIT_WOLF_RIDER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('SLTH_UNIT_WOOD_GOLEM', 'LOC_SLTH_UNIT_WOOD_GOLEM_NAME', '2', '1', '29', '30', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_WOOD_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WOOD_GOLEM', NULL, 'TECH_CONSTRUCTION', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_YVAIN', 'LOC_SLTH_UNIT_YVAIN_NAME', '2', '2', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_YVAIN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_COMMUNE_WITH_NATURE', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS',    'LOC_SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS_NAME',    'LOC_SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS_DESCRIPTION',    '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_MESSAGE_FROM_THE_DEEP', 'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');


-- summons so order doesnt matter
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_BATTERING_RAM', 'LOC_SLTH_UNIT_BATTERING_RAM_NAME', '2', '1', '0', '0', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_BATTERING_RAM_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_SIEGE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('SLTH_UNIT_AIR_ELEMENTAL', 'LOC_SLTH_UNIT_AIR_ELEMENTAL_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_AIR_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_CHAOS_MARAUDER', 'LOC_SLTH_UNIT_CHAOS_MARAUDER_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_CHAOS_MARAUDER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CHAOS_MARAUDER', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),             -- sheaim have as trait
('SLTH_UNIT_DJINN', 'LOC_SLTH_UNIT_DJINN_NAME', '2', '2', '5', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_DJINN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_EARTH_ELEMENTAL', 'LOC_SLTH_UNIT_EARTH_ELEMENTAL_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_EARTH_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_EYE', 'LOC_SLTH_UNIT_EYE_NAME', '4', '8', '0', '0', '5', 'DOMAIN_AIR', 'FORMATION_CLASS_AIR', '-1', '0', 'LOC_SLTH_UNIT_EYE_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '1', '0', '1', 'PSEUDOYIELD_UNIT_AIR_COMBAT', '1', 'ADVISOR_CONQUEST', '0', 0),
('SLTH_UNIT_FIRE_ELEMENTAL', 'LOC_SLTH_UNIT_FIRE_ELEMENTAL_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_FIRE_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_FIREBALL', 'LOC_SLTH_UNIT_FIREBALL_NAME', '2', '1', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_FIREBALL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_FLESH_GOLEM', 'LOC_SLTH_UNIT_FLESH_GOLEM_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_FLESH_GOLEM_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_SKELETON', 'LOC_SLTH_UNIT_SKELETON_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_SKELETON_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0', 1),
('SLTH_UNIT_ICE_ELEMENTAL', 'LOC_SLTH_UNIT_ICE_ELEMENTAL_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_ICE_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_IRA', 'LOC_SLTH_UNIT_IRA_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_IRA_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_LIGHTNING_ELEMENTAL', 'LOC_SLTH_UNIT_LIGHTNING_ELEMENTAL_NAME', '2', '2', '1', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '-1', '0', 'LOC_SLTH_UNIT_LIGHTNING_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0', 1),
('SLTH_UNIT_EINHERJAR', 'LOC_SLTH_UNIT_EINHERJAR_NAME', '2', '1', '6', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_EINHERJAR_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_DISCIPLE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_AUREALIS', 'LOC_SLTH_UNIT_AUREALIS_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_AUREALIS_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_GUARDIAN_VINES', 'LOC_SLTH_UNIT_GUARDIAN_VINES_NAME', '2', '0', '43', '0', '0', 'DOMAIN_IMMOBILE', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_GUARDIAN_VINES_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_PIT_BEAST', 'LOC_SLTH_UNIT_PIT_BEAST_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_PIT_BEAST_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_METEOR', 'LOC_SLTH_UNIT_METEOR_NAME', '2', '1', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_METEOR_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_MISTFORM', 'LOC_SLTH_UNIT_MISTFORM_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_MISTFORM_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_SAND_LION', 'LOC_SLTH_UNIT_SAND_LION_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_SAND_LION_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0', 1),
('SLTH_UNIT_SPECTRE', 'LOC_SLTH_UNIT_SPECTRE_NAME', '2', '2', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_SPECTRE_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_SEVERED_SOUL', 'LOC_SLTH_UNIT_SEVERED_SOUL_NAME', '2', '1', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '-1', '0', 'LOC_SLTH_UNIT_SEVERED_SOUL_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('SLTH_UNIT_TREANT', 'LOC_SLTH_UNIT_TREANT_NAME', '2', '1', '48', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_TREANT_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_WATER_ELEMENTAL', 'LOC_SLTH_UNIT_WATER_ELEMENTAL_NAME', '2', '1', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_WATER_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_WRAITH', 'LOC_SLTH_UNIT_WRAITH_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_WRAITH_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

UPDATE Units SET Name='LOC_UNIT_WARRIOR_NAME', BaseMoves='1', Combat='14', Cost='25', Description='LOC_UNIT_WARRIOR_DESCRIPTION', Maintenance='1' WHERE UnitType='UNIT_WARRIOR';

-- convert into/unbuildable
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('SLTH_UNIT_MARY', 'LOC_SLTH_UNIT_MARY_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_MARY_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_LICH', 'LOC_SLTH_UNIT_LICH_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '1', 'LOC_SLTH_UNIT_LICH_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_GAELAN', 'LOC_SLTH_UNIT_GAELAN_NAME', '2', '1', '29', '34', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '1', 'LOC_SLTH_UNIT_GAELAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('SLTH_UNIT_MERCENARY', 'LOC_SLTH_UNIT_MERCENARY_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_MERCENARY_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_WAR_ELEPHANT', 'LOC_SLTH_UNIT_WAR_ELEPHANT_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_SLTH_UNIT_WAR_ELEPHANT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_SLAVE', 'LOC_SLTH_UNIT_SLAVE_NAME', '2', '2', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '60', '3', 'LOC_SLTH_UNIT_SLAVE_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', 0),
('SLTH_UNIT_SHADE', 'LOC_SLTH_UNIT_SHADE_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_SHADE_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('SLTH_UNIT_RAVENOUS_WEREWOLF', 'LOC_SLTH_UNIT_RAVENOUS_WEREWOLF_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_RAVENOUS_WEREWOLF_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_WEREWOLF', 'LOC_SLTH_UNIT_WEREWOLF_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_WEREWOLF_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('SLTH_UNIT_GREATER_WEREWOLF', 'LOC_SLTH_UNIT_GREATER_WEREWOLF_NAME', '2', '3', '54', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_SLTH_UNIT_GREATER_WEREWOLF_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO UnitCaptures(CapturedUnitType, BecomesUnitType) VALUES
('SLTH_UNIT_SLAVE', 'SLTH_UNIT_SLAVE');
-- mages
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('SLTH_UNIT_MAGE', 'LOC_SLTH_UNIT_MAGE_NAME', '2', '1', '4', '4', '10', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '1', 'LOC_SLTH_UNIT_MAGE_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', 'TECH_SORCERY', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', 0),
('SLTH_UNIT_ARCHMAGE', 'LOC_SLTH_UNIT_ARCHMAGE_NAME', '2', '1', '24', '36', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '1', 'LOC_SLTH_UNIT_ARCHMAGE_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', 'TECH_STRENGTH_OF_WILL', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', 0);


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('SLTH_UNIT_IMMORTAL', 'LOC_SLTH_UNIT_IMMORTAL_NAME', '2', '1', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_IMMORTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1', 1);


INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_SHAMAN', 'SLTH_UNIT_ADEPT'),
('SLTH_UNIT_JAVELIN_THROWER', 'SLTH_UNIT_ARCHER'),
-- ('SLTH_UNIT_POLAR_BEAR', 'SLTH_UNIT_BEAR'),              --???
('SLTH_UNIT_BALOR', 'SLTH_UNIT_BERSERKER'),
('SLTH_UNIT_OGRE', 'SLTH_UNIT_CHAMPION'),
('SLTH_UNIT_WOLF_RIDER', 'SLTH_UNIT_HORSEMAN'),
('SLTH_UNIT_OGRE_WARCHIEF', 'SLTH_UNIT_IMMORTAL'),
('SLTH_UNIT_GARGOYLE', 'SLTH_UNIT_LONGBOWMAN'),
('SLTH_UNIT_STONESKIN_OGRE', 'SLTH_UNIT_PHALANX'),
('SLTH_UNIT_AIRSHIP', 'SLTH_UNIT_QUEEN_OF_THE_LINE'),
('SLTH_UNIT_GOBLIN', 'SLTH_UNIT_SCOUT');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES                   -- fine as no non- bespoke upgrades into it
('SLTH_UNIT_ADEPT', 'BUILDING_MAGE_GUILD'),
('SLTH_UNIT_ARCHER', 'SLTH_BUILDING_ARCHERY_RANGE'),
('SLTH_UNIT_DRUID', 'BUILDING_GROVE'),
('SLTH_UNIT_QUEEN_OF_THE_LINE', 'BUILDING_SHIPYARD'),
('SLTH_UNIT_CATAPULT', 'SLTH_BUILDING_SIEGE_WORKSHOP'),
('SLTH_UNIT_HAWK', 'SLTH_BUILDING_HUNTING_LODGE');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_ANIMAL', 'ABILITY_CLASS'),
('CLASS_BEAST', 'ABILITY_CLASS'),
('CLASS_ADEPT', 'ABILITY_CLASS'),
('CLASS_DISCIPLE', 'ABILITY_CLASS'),
('CAN_BE_RACIALIZED', 'ABILITY_CLASS'),
('RACE_HUMAN', 'ABILITY_CLASS'),
('RACE_ELVEN', 'ABILITY_CLASS'),
('RACE_ORCISH', 'ABILITY_CLASS'),
('RACE_DWARVEN', 'ABILITY_CLASS'),
('RACE_LIZARDMEN', 'ABILITY_CLASS'),
('RACE_WINTERBORN', 'ABILITY_CLASS'),
('RACE_FROSTLING', 'ABILITY_CLASS'),
('RACE_DEMON', 'ABILITY_CLASS'),
('IS_UNDEAD', 'ABILITY_CLASS'),
('RACE_ANGEL', 'ABILITY_CLASS'),
('RACE_GOLEM', 'ABILITY_CLASS'),
('RACE_ELEMENTAL', 'ABILITY_CLASS'),
('TAG_VULN_FIRE', 'ABILITY_CLASS');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_ADEPT', 'CLASS_ADEPT'),
('SLTH_UNIT_SHAMAN', 'CLASS_ADEPT'),
('SLTH_UNIT_ARCANE_BARGE', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_ARCHER', 'CLASS_RANGED'),
('SLTH_UNIT_JAVELIN_THROWER', 'CLASS_RANGED'),
('SLTH_UNIT_ARCHMAGE', 'CLASS_ADEPT'),
('SLTH_UNIT_ARQUEBUS', 'CLASS_RANGED'),
('SLTH_UNIT_ASSASSIN', 'CLASS_RECON'),
('SLTH_UNIT_SWORDSMAN', 'CLASS_MELEE'),

('SLTH_UNIT_BATTERING_RAM', 'CLASS_SIEGE'),
('SLTH_UNIT_CHAOS_MARAUDER', 'CLASS_MELEE'),
('SLTH_UNIT_EINHERJAR', 'CLASS_DISCIPLE'),
('SLTH_UNIT_EYE', 'CLASS_MELEE'),
('SLTH_UNIT_ICE_ELEMENTAL', 'CLASS_MELEE'),
('SLTH_UNIT_IRA', 'CLASS_MELEE'),
('SLTH_UNIT_PIT_BEAST', 'CLASS_BEAST'),

('SLTH_UNIT_BEASTMASTER', 'CLASS_RECON'),
('SLTH_UNIT_BALOR', 'CLASS_MELEE'),
('SLTH_UNIT_BERSERKER', 'CLASS_MELEE'),
('SLTH_UNIT_CANNON', 'CLASS_SIEGE'),
('SLTH_UNIT_CARAVEL', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_CATAPULT', 'CLASS_SIEGE'),
('SLTH_UNIT_CHAMPION', 'CLASS_MELEE'),
('SLTH_UNIT_OGRE', 'CLASS_MELEE'),
('SLTH_UNIT_CHARIOT', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_CROSSBOWMAN', 'CLASS_RANGED'),
('SLTH_UNIT_DRIFA', 'CLASS_BEAST'),
('SLTH_UNIT_DRUID', 'CLASS_DISCIPLE'),
('SLTH_UNIT_DUIN', 'CLASS_BEAST'),
('SLTH_UNIT_DWARVEN_SOLDIER_RUNES', 'CLASS_MELEE'),
('SLTH_UNIT_EIDOLON', 'CLASS_DISCIPLE'),

('SLTH_UNIT_FRIGATE', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_GAELAN', 'CLASS_ADEPT'),
('SLTH_UNIT_GALLEON', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_GALLEY', 'CLASS_NAVAL_MELEE'),

('SLTH_UNIT_GREATER_WEREWOLF', 'CLASS_BEAST'),
('SLTH_UNIT_GRIGORI_MEDIC', 'CLASS_MELEE'),
('SLTH_UNIT_HAWK', 'CLASS_AIRCRAFT'),
('SLTH_UNIT_HAWK', 'CLASS_AIR_FIGHTER'),
('SLTH_UNIT_DISCIPLE_OF_ACHERON', 'CLASS_ADEPT'),
('SLTH_UNIT_DISCIPLE_OF_ACHERON', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HILL_GIANT', 'CLASS_BEAST'),
('SLTH_UNIT_HORSE_ARCHER', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_HORSEMAN', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_WOLF_RIDER', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_HUNTER', 'CLASS_RECON'),
('SLTH_UNIT_IMMORTAL', 'CLASS_MELEE'),
('SLTH_UNIT_OGRE_WARCHIEF', 'CLASS_MELEE'),
('SLTH_UNIT_LICH', 'CLASS_ADEPT'),
('SLTH_UNIT_LONGBOWMAN', 'CLASS_RANGED'),
('SLTH_UNIT_LUNATIC', 'CLASS_MELEE'),
('SLTH_UNIT_MAGE', 'CLASS_ADEPT'),
('SLTH_UNIT_MAN_O_WAR', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_MANTICORE', 'CLASS_BEAST'),
('SLTH_UNIT_MARKSMAN', 'CLASS_RANGED'),
('SLTH_UNIT_MARY', 'CLASS_MELEE'),
('SLTH_UNIT_MERCENARY', 'CLASS_MELEE'),
('SLTH_UNIT_MESHABBER', 'CLASS_MELEE'),
('SLTH_UNIT_MISTFORM', 'CLASS_MELEE'),
('SLTH_UNIT_MUIRIN', 'CLASS_MELEE'),
('SLTH_UNIT_PALADIN', 'CLASS_DISCIPLE'),
('SLTH_UNIT_PHALANX', 'CLASS_MELEE'),
('SLTH_UNIT_STONESKIN_OGRE', 'CLASS_MELEE'),
('SLTH_UNIT_PRIVATEER', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_AIRSHIP', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_QUEEN_OF_THE_LINE', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_RANGER', 'CLASS_RECON'),
('SLTH_UNIT_RANTINE', 'CLASS_MELEE'),
('SLTH_UNIT_RAVENOUS_WEREWOLF', 'CLASS_BEAST'),
('SLTH_UNIT_REVELERS', 'CLASS_RECON'),
('SLTH_UNIT_ROYAL_GUARD', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_SAILORS_DIRGE', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_SAND_LION', 'CLASS_BEAST'),
('SLTH_UNIT_SCORPION', 'CLASS_ANIMAL'),
('SLTH_UNIT_GOBLIN', 'CLASS_RECON'),
('SLTH_UNIT_SCOUT', 'CLASS_RECON'),
('SLTH_UNIT_SKELETON', 'CLASS_MELEE'),
('SLTH_UNIT_SPECTRE', 'CLASS_MELEE'),
('SLTH_UNIT_TRIREME', 'CLASS_NAVAL_MELEE'),
('SLTH_UNIT_WAR_ELEPHANT', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_WEREWOLF', 'CLASS_BEAST'),
('SLTH_UNIT_ADEPT', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_SHAMAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_ARCHER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_JAVELIN_THROWER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_ARCHMAGE', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_ARQUEBUS', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_ASSASSIN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_SWORDSMAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_BEASTMASTER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_KNIGHT', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_KNIGHT', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_BALOR', 'RACE_DEMON'),
('SLTH_UNIT_BERSERKER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_CHAMPION', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_OGRE', 'RACE_ORCISH'),
('SLTH_UNIT_CHAOS_MARAUDER', 'RACE_DEMON'),
('SLTH_UNIT_CROSSBOWMAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DRUID', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_DUIN', 'RACE_WINTERBORN'),
('SLTH_UNIT_DWARVEN_SOLDIER_RUNES', 'RACE_DWARVEN'),
('SLTH_UNIT_EIDOLON', 'RACE_DEMON'),
('SLTH_UNIT_EINHERJAR', 'RACE_ANGEL'),
('SLTH_UNIT_GAELAN', 'RACE_HUMAN'),
('SLTH_UNIT_GRIGORI_MEDIC', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HORSE_ARCHER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_HORSEMAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_WOLF_RIDER', 'RACE_ORCISH'),
('SLTH_UNIT_HUNTER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_IMMORTAL', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_OGRE_WARCHIEF', 'RACE_ORCISH'),
('SLTH_UNIT_LICH', 'IS_UNDEAD'),
('SLTH_UNIT_GARGOYLE', 'RACE_GOLEM'),
('SLTH_UNIT_LONGBOWMAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_LUNATIC', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_MAGE', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_MARKSMAN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_MARY', 'RACE_HUMAN'),
('SLTH_UNIT_MERCENARY', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_MESHABBER', 'RACE_DEMON'),
('SLTH_UNIT_MOKKA', 'RACE_FROSTLING'),
('SLTH_UNIT_MUIRIN', 'RACE_DWARVEN'),
('SLTH_UNIT_PALADIN', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_PHALANX', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_STONESKIN_OGRE', 'RACE_ORCISH'),
('SLTH_UNIT_PIT_BEAST', 'RACE_DEMON'),
('SLTH_UNIT_PRIEST_OF_WINTER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_RANGER', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_RANTINE', 'RACE_ORCISH'),
('SLTH_UNIT_ROYAL_GUARD', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_GOBLIN', 'RACE_ORCISH'),
('SLTH_UNIT_SCOUT', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_SKELETON', 'IS_UNDEAD'),
('SLTH_UNIT_SLAVE', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_SLAVE', 'CLASS_BUILDER'),
('SLTH_UNIT_SLAVE', 'CLASS_LANDCIVILIAN'),
('UNIT_WARRIOR', 'CAN_BE_RACIALIZED'),
('SLTH_UNIT_AIR_ELEMENTAL', 'RACE_ELEMENTAL'),
('SLTH_UNIT_DJINN',  'RACE_ELEMENTAL'),
('SLTH_UNIT_FIRE_ELEMENTAL', 'RACE_ELEMENTAL'),
('SLTH_UNIT_FIREBALL', 'RACE_ELEMENTAL'),
('SLTH_UNIT_ICE_ELEMENTAL', 'RACE_ELEMENTAL'),
('SLTH_UNIT_LIGHTNING_ELEMENTAL', 'RACE_ELEMENTAL'),
('SLTH_UNIT_AUREALIS', 'RACE_ELEMENTAL'),
('SLTH_UNIT_MISTFORM', 'RACE_ELEMENTAL'),
('SLTH_UNIT_SAND_LION', 'RACE_ELEMENTAL'),
('SLTH_UNIT_WATER_ELEMENTAL', 'RACE_ELEMENTAL'),
('SLTH_UNIT_TREANT', 'TAG_VULN_FIRE'),
('SLTH_UNIT_DROWN', 'TAG_VULN_FIRE'),
('SLTH_UNIT_WILBOMAN', 'TAG_VULN_FIRE'),
('SLTH_UNIT_DRIFA', 'TAG_VULN_FIRE'),
('SLTH_UNIT_ICE_ELEMENTAL', 'TAG_VULN_FIRE'),
('SLTH_UNIT_MUIRIN', 'TAG_VULN_FIRE');

INSERT INTO TypeProperties(Type, Name, Value, PropertyType) VALUES
('SLTH_UNIT_AIR_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_AUREALIS', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_DJINN', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_EARTH_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_EINHERJAR', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_EYE', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_FIRE_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_FIREBALL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_ICE_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_LIGHTNING_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_MISTFORM', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_PIT_BEAST', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_SPECTRE', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_WATER_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('SLTH_UNIT_WRAITH', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY');
INSERT INTO UnitPromotionClasses(PromotionClassType, Name) VALUES
('PROMOTION_CLASS_ANIMAL', 'LOC_PROMOTION_CLASS_ANIMAL_NAME'),
('PROMOTION_CLASS_BEAST', 'LOC_PROMOTION_CLASS_BEAST_NAME'),
('PROMOTION_CLASS_ADEPT', 'LOC_PROMOTION_CLASS_ADEPT_NAME'),
('PROMOTION_CLASS_DISCIPLE', 'LOC_PROMOTION_CLASS_DISCIPLE_NAME');
INSERT INTO Types(Type, Kind) VALUES
('PROMOTION_CLASS_ANIMAL', 'KIND_PROMOTION_CLASS'),
('PROMOTION_CLASS_BEAST', 'KIND_PROMOTION_CLASS'),
('PROMOTION_CLASS_ADEPT', 'KIND_PROMOTION_CLASS'),
('PROMOTION_CLASS_DISCIPLE', 'KIND_PROMOTION_CLASS'),
('SLTH_UNIT_ADEPT', 'KIND_UNIT'),
('SLTH_UNIT_SHAMAN', 'KIND_UNIT'),
('SLTH_UNIT_ARCANE_BARGE', 'KIND_UNIT'),
('SLTH_UNIT_ARCHER', 'KIND_UNIT'),
('SLTH_UNIT_JAVELIN_THROWER', 'KIND_UNIT'),
('SLTH_UNIT_ARCHMAGE', 'KIND_UNIT'),
('SLTH_UNIT_ARQUEBUS', 'KIND_UNIT'),
('SLTH_UNIT_ASSASSIN', 'KIND_UNIT'),
('SLTH_UNIT_AURIC_ASCENDED', 'KIND_UNIT'),
('SLTH_UNIT_SWORDSMAN', 'KIND_UNIT'),
('SLTH_UNIT_BEASTMASTER', 'KIND_UNIT'),
('SLTH_UNIT_BALOR', 'KIND_UNIT'),
('SLTH_UNIT_BERSERKER', 'KIND_UNIT'),
('SLTH_UNIT_CANNON', 'KIND_UNIT'),
('SLTH_UNIT_CARAVEL', 'KIND_UNIT'),
('SLTH_UNIT_CATAPULT', 'KIND_UNIT'),
('SLTH_UNIT_CHAMPION', 'KIND_UNIT'),
('SLTH_UNIT_OGRE', 'KIND_UNIT'),
('SLTH_UNIT_CHAOS_MARAUDER', 'KIND_UNIT'),
('SLTH_UNIT_CHARIOT', 'KIND_UNIT'),
('SLTH_UNIT_CROSSBOWMAN', 'KIND_UNIT'),
('SLTH_UNIT_DRUID', 'KIND_UNIT'),
('SLTH_UNIT_DUIN', 'KIND_UNIT'),
('SLTH_UNIT_DWARVEN_SOLDIER_RUNES', 'KIND_UNIT'),
('SLTH_UNIT_EIDOLON', 'KIND_UNIT'),
('SLTH_UNIT_FRIGATE', 'KIND_UNIT'),
('SLTH_UNIT_GAELAN', 'KIND_UNIT'),
('SLTH_UNIT_GALLEON', 'KIND_UNIT'),
('SLTH_UNIT_GALLEY', 'KIND_UNIT'),
('SLTH_UNIT_GREATER_WEREWOLF', 'KIND_UNIT'),
('SLTH_UNIT_GRIGORI_MEDIC', 'KIND_UNIT'),
('SLTH_UNIT_HAWK', 'KIND_UNIT'),
('SLTH_UNIT_HILL_GIANT', 'KIND_UNIT'),
('SLTH_UNIT_HORSE_ARCHER', 'KIND_UNIT'),
('SLTH_UNIT_HORSEMAN', 'KIND_UNIT'),
('SLTH_UNIT_WOLF_RIDER', 'KIND_UNIT'),
('SLTH_UNIT_HUNTER', 'KIND_UNIT'),
('SLTH_UNIT_IMMORTAL', 'KIND_UNIT'),
('SLTH_UNIT_OGRE_WARCHIEF', 'KIND_UNIT'),
('SLTH_UNIT_LICH', 'KIND_UNIT'),
('SLTH_UNIT_GARGOYLE', 'KIND_UNIT'),
('SLTH_UNIT_LONGBOWMAN', 'KIND_UNIT'),
('SLTH_UNIT_LUNATIC', 'KIND_UNIT'),
('SLTH_UNIT_MAGE', 'KIND_UNIT'),
('SLTH_UNIT_MAN_O_WAR', 'KIND_UNIT'),
('SLTH_UNIT_MANTICORE', 'KIND_UNIT'),
('SLTH_UNIT_MARKSMAN', 'KIND_UNIT'),
('SLTH_UNIT_MARY', 'KIND_UNIT'),
('SLTH_UNIT_MERCENARY', 'KIND_UNIT'),
('SLTH_UNIT_MESHABBER', 'KIND_UNIT'),
('SLTH_UNIT_MUIRIN', 'KIND_UNIT'),
('SLTH_UNIT_PALADIN', 'KIND_UNIT'),
('SLTH_UNIT_PHALANX', 'KIND_UNIT'),
('SLTH_UNIT_STONESKIN_OGRE', 'KIND_UNIT'),
('SLTH_UNIT_PRIEST_OF_WINTER', 'KIND_UNIT'),
('SLTH_UNIT_PRIVATEER', 'KIND_UNIT'),
('SLTH_UNIT_AIRSHIP', 'KIND_UNIT'),
('SLTH_UNIT_QUEEN_OF_THE_LINE', 'KIND_UNIT'),
('SLTH_UNIT_RANGER', 'KIND_UNIT'),
('SLTH_UNIT_RANTINE', 'KIND_UNIT'),
('SLTH_UNIT_RAVENOUS_WEREWOLF', 'KIND_UNIT'),
('SLTH_UNIT_ROYAL_GUARD', 'KIND_UNIT'),
('SLTH_UNIT_SAILORS_DIRGE', 'KIND_UNIT'),
('SLTH_UNIT_SAND_LION', 'KIND_UNIT'),
('SLTH_UNIT_SCORPION', 'KIND_UNIT'),
('SLTH_UNIT_GOBLIN', 'KIND_UNIT'),
('SLTH_UNIT_SCOUT', 'KIND_UNIT'),
('SLTH_UNIT_SHADE', 'KIND_UNIT'),
('SLTH_UNIT_SLAVE', 'KIND_UNIT'),
('SLTH_UNIT_SUPPLIES', 'KIND_UNIT'),
('SLTH_UNIT_TRIREME', 'KIND_UNIT'),
('SLTH_UNIT_WAR_ELEPHANT', 'KIND_UNIT'),
('SLTH_UNIT_WEREWOLF', 'KIND_UNIT'),
('SLTH_UNIT_DISCIPLE_OF_ACHERON', 'KIND_UNIT'),
('SLTH_UNIT_IRA', 'KIND_UNIT'),
('SLTH_UNIT_LIGHTNING_ELEMENTAL', 'KIND_UNIT'),
('SLTH_UNIT_ICE_ELEMENTAL', 'KIND_UNIT'),
('SLTH_UNIT_GUARDIAN_VINES', 'KIND_UNIT'),
('SLTH_UNIT_EINHERJAR', 'KIND_UNIT'),
('SLTH_UNIT_BATTERING_RAM', 'KIND_UNIT'),
('SLTH_UNIT_AIR_ELEMENTAL', 'KIND_UNIT'),
('SLTH_UNIT_AUREALIS', 'KIND_UNIT'),
('SLTH_UNIT_DJINN', 'KIND_UNIT'),
('SLTH_UNIT_EARTH_ELEMENTAL', 'KIND_UNIT'),
('SLTH_UNIT_EYE', 'KIND_UNIT'),
('SLTH_UNIT_FIRE_ELEMENTAL', 'KIND_UNIT'),
('SLTH_UNIT_FIREBALL', 'KIND_UNIT'),
('SLTH_UNIT_FLESH_GOLEM', 'KIND_UNIT'),
('SLTH_UNIT_WRAITH', 'KIND_UNIT'),
('SLTH_UNIT_TREANT', 'KIND_UNIT'),
('SLTH_UNIT_METEOR', 'KIND_UNIT'),
('SLTH_UNIT_MISTFORM', 'KIND_UNIT'),
('SLTH_UNIT_PIT_BEAST', 'KIND_UNIT'),
('SLTH_UNIT_SEVERED_SOUL', 'KIND_UNIT'),
('SLTH_UNIT_SKELETON', 'KIND_UNIT'),
('SLTH_UNIT_SPECTRE', 'KIND_UNIT'),
('SLTH_UNIT_WATER_ELEMENTAL', 'KIND_UNIT'),
('SLTH_UNIT_KNIGHT', 'KIND_UNIT');
