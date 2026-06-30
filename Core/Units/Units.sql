
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('UNIT_SLTH_ABASHI', 'LOC_UNIT_SLTH_ABASHI_NAME', '2', '3', '101', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_UNIT_SLTH_ABASHI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ABASHI', '0', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('UNIT_SLTH_DISCIPLE_THE_ORDER',            'LOC_UNIT_SLTH_DISCIPLE_THE_ORDER_NAME',            'LOC_UNIT_SLTH_DISCIPLE_THE_ORDER_DESCRIPTION',            '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_ORDERS_FROM_HEAVEN',    'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('UNIT_SLTH_ADEPT', 'LOC_UNIT_SLTH_ADEPT_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '1', 'LOC_UNIT_SLTH_ADEPT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', 'TECH_KNOWLEDGE_OF_THE_ETHER', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_AIRSHIP', 'LOC_UNIT_SLTH_AIRSHIP_NAME', '2', '3', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_UNIT_SLTH_AIRSHIP_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_AIRSHIP', '0', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_ASTRONOMY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_ALAZKAN', 'LOC_UNIT_SLTH_ALAZKAN_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_ALAZKAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ALAZKAN', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_ANGEL', 'LOC_UNIT_SLTH_ANGEL_NAME', '2', '1', '19', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1', '0', 'LOC_UNIT_SLTH_ANGEL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_ANGEL_OF_DEATH', 'LOC_UNIT_SLTH_ANGEL_OF_DEATH_NAME', '2', '2', '39', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '3', '0', 'LOC_UNIT_SLTH_ANGEL_OF_DEATH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ANGEL_OF_DEATH', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_ARCANE_BARGE', 'LOC_UNIT_SLTH_ARCANE_BARGE_NAME', '2', '3', '38', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '250',  'LOC_UNIT_SLTH_ARCANE_BARGE_DESCRIPTION', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_ASTRONOMY', '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AirSlots, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_ARCHER', 'LOC_UNIT_SLTH_ARCHER_NAME', '2', '1', '14', '14', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60','LOC_UNIT_SLTH_ARCHER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_ARCHERY', NULL, '1', '1',  '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_ARTHENDAIN', 'LOC_UNIT_SLTH_ARTHENDAIN_NAME', '2', '1', '43', '9', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_ARTHENDAIN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RANGED', 'TECH_MEDICINE', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AirSlots, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_ARQUEBUS', 'LOC_UNIT_SLTH_ARQUEBUS_NAME', '2', '1', '48', '53', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', 'LOC_UNIT_SLTH_ARQUEBUS_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RANGED', 'TECH_BLASTING_POWDER', NULL, '1', '1',  '0',  NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('UNIT_SLTH_ASSASSIN', 'LOC_UNIT_SLTH_ASSASSIN_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', 'LOC_UNIT_SLTH_ASSASSIN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1','0',NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_BALOR', 'LOC_UNIT_SLTH_BALOR_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_UNIT_SLTH_BALOR_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_SLTH_BALOR', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1',  '0',  NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BAMBUR', 'LOC_UNIT_SLTH_BAMBUR_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_BAMBUR_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_ARETE', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('UNIT_SLTH_BARNAXUS', 'LOC_UNIT_SLTH_BARNAXUS_NAME', '2', '1', '24', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_BARNAXUS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BARNAXUS', 'PROMOTION_CLASS_MELEE', 'TECH_CONSTRUCTION', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', 'PSEUDOYIELD_UNIT_HERO', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('UNIT_SLTH_BASIUM', 'LOC_UNIT_SLTH_BASIUM_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_BASIUM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BASIUM', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', NULL, '1', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BATTLEMASTER', 'LOC_UNIT_SLTH_BATTLEMASTER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_UNIT_SLTH_BATTLEMASTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BATTLEMASTER', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BEAST_OF_AGARES', 'LOC_UNIT_SLTH_BEAST_OF_AGARES_NAME', '2', '2', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_BEAST_OF_AGARES_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_MALEVOLENT_DESIGNS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BEASTMAN', 'LOC_UNIT_SLTH_BEASTMAN_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '25', '0', 'LOC_UNIT_SLTH_BEASTMAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BEASTMAN', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AirSlots, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BEASTMASTER', 'LOC_UNIT_SLTH_BEASTMASTER_NAME', '2', '2', '67', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_UNIT_SLTH_BEASTMASTER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_MASTERY', NULL, '1', '1',  '1', NULL, '0', 'ADVISOR_GENERIC', '0', 1),
('UNIT_SLTH_BERSERKER', 'LOC_UNIT_SLTH_BERSERKER_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_UNIT_SLTH_BERSERKER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BISON_RIDER', 'LOC_UNIT_SLTH_BISON_RIDER_NAME', '2', '2', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_BISON_RIDER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BISON_RIDER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('UNIT_SLTH_BLACK_WIND', 'LOC_UNIT_SLTH_BLACK_WIND_NAME', '2', '4', '48', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '300', '0', 'LOC_UNIT_SLTH_BLACK_WIND_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BLACK_WIND', '0', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BOAR_RIDER', 'LOC_UNIT_SLTH_BOAR_RIDER_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_BOAR_RIDER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BOAR_RIDER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('UNIT_SLTH_BOARDING_PARTY', 'LOC_UNIT_SLTH_BOARDING_PARTY_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_BOARDING_PARTY_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BOARDING_PARTY', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('UNIT_SLTH_BONE_GOLEM', 'LOC_UNIT_SLTH_BONE_GOLEM_NAME', '2', '1', '63', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_UNIT_SLTH_BONE_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BONE_GOLEM', NULL, NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BRUJAH', 'LOC_UNIT_SLTH_BRUJAH_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_BRUJAH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_BRUJAH', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CAMEL_ARCHER', 'LOC_UNIT_SLTH_CAMEL_ARCHER_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_CAMEL_ARCHER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CAMEL_ARCHER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CANNON', 'LOC_UNIT_SLTH_CANNON_NAME', '2', '1', '38', '43', '53',  '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_CANNON_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_SIEGE', 'TECH_BLASTING_POWDER', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_CARAVEL', 'LOC_UNIT_SLTH_CARAVEL_NAME', '2', '4', '34', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '100', 'LOC_UNIT_SLTH_CARAVEL_DESCRIPTION', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS', '1', '1', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CATAPULT', 'LOC_UNIT_SLTH_CATAPULT_NAME', '2', '1', '19', '24', '34', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_CATAPULT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_SIEGE', 'TECH_CONSTRUCTION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CENTAUR_ARCHER', 'LOC_UNIT_SLTH_CENTAUR_ARCHER_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_CENTAUR_ARCHER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_ARCHER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_CENTAUR_CHARGER', 'LOC_UNIT_SLTH_CENTAUR_CHARGER_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_CENTAUR_CHARGER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_CHARGER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_CENTAUR', 'LOC_UNIT_SLTH_CENTAUR_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_CENTAUR_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_CENTAUR_LANCER', 'LOC_UNIT_SLTH_CENTAUR_LANCER_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_CENTAUR_LANCER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CENTAUR_LANCER', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('UNIT_SLTH_CLOCKWORK_GOLEM', 'LOC_UNIT_SLTH_CLOCKWORK_GOLEM_NAME', '2', '1', '72', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_UNIT_SLTH_CLOCKWORK_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CLOCKWORK_GOLEM', NULL, 'TECH_MACHINERY', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CHALID', 'LOC_UNIT_SLTH_CHALID_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_UNIT_SLTH_CHALID_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_RELIGIOUS_LAW', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CHAMPION', 'LOC_UNIT_SLTH_CHAMPION_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_CHAMPION_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CHANTER', 'LOC_UNIT_SLTH_CHANTER_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_CHANTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CHANTER', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CHARIOT', 'LOC_UNIT_SLTH_CHARIOT_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_CHARIOT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PRIEST_OF_THE_ORDER', 'LOC_UNIT_SLTH_PRIEST_OF_THE_ORDER_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_PRIEST_OF_THE_ORDER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CORLINDALE', 'LOC_UNIT_SLTH_CORLINDALE_NAME', '2', '2', '0', '0', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '300', '1', 'LOC_UNIT_SLTH_CORLINDALE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CORLINDALE', '0', 'PROMOTION_CLASS_ADEPT', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_COURTESAN', 'LOC_UNIT_SLTH_COURTESAN_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_COURTESAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_COURTESAN', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CRUSADER', 'LOC_UNIT_SLTH_CRUSADER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_CRUSADER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_CROSSBOWMAN', 'LOC_UNIT_SLTH_CROSSBOWMAN_NAME', '2', '1', '44', '48', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_CROSSBOWMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RANGED', 'TECH_MACHINERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PRIEST_OF_THE_OVERLORDS', 'LOC_UNIT_SLTH_PRIEST_OF_THE_OVERLORDS_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_PRIEST_OF_THE_OVERLORDS_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DEATH_KNIGHT', 'LOC_UNIT_SLTH_DEATH_KNIGHT_NAME', '2', '3', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_DEATH_KNIGHT_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEATH_KNIGHT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_DEMAGOG', 'LOC_UNIT_SLTH_DEMAGOG_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_DEMAGOG_DESCRIPTION', 'SLTH_TRAIT_RELIGION_UNIT_DEMAGOG', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_DEVOUT', 'LOC_UNIT_SLTH_DEVOUT_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_DEVOUT_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEVOUT', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('UNIT_SLTH_DISCIPLE_FELLOWSHIP_OF_LEAVES', 'LOC_UNIT_SLTH_DISCIPLE_FELLOWSHIP_OF_LEAVES_NAME', 'LOC_UNIT_SLTH_DISCIPLE_FELLOWSHIP_OF_LEAVES_DESCRIPTION', '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_WAY_OF_THE_FORESTS',    'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DISEASED_CORPSE', 'LOC_UNIT_SLTH_DISEASED_CORPSE_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_DISEASED_CORPSE_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_CORRUPTION_OF_SPIRIT', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DIVIDED_SOUL', 'LOC_UNIT_SLTH_DIVIDED_SOUL_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_DIVIDED_SOUL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DIVIDED_SOUL', '0', 'PROMOTION_CLASS_RECON', 'TECH_HUNTING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DONAL', 'LOC_UNIT_SLTH_DONAL_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_UNIT_SLTH_DONAL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DONAL', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DRAGON_SLAYER', 'LOC_UNIT_SLTH_DRAGON_SLAYER_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_DRAGON_SLAYER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DRAGON_SLAYER', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DROWN', 'LOC_UNIT_SLTH_DROWN_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_DROWN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MESSAGE_FROM_THE_DEEP', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqCivic, CanTrain, Maintenance, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DRUID',   'LOC_UNIT_SLTH_DRUID_NAME',   '2', '2', '39', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_UNIT_SLTH_DRUID_DESCRIPTION',   'SLTH_RELIGION_BAN_TRAIT',   '0', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_COMMUNE_WITH_NATURE', '1', '1', '1', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DUIN', 'LOC_UNIT_SLTH_DUIN_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '500', '0', 'LOC_UNIT_SLTH_DUIN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_FERAL_BOND', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DWARVEN_CANNON', 'LOC_UNIT_SLTH_DWARVEN_CANNON_NAME', '2', '1', '48', '53', '63', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_DWARVEN_CANNON_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_CANNON', '0', 'PROMOTION_CLASS_SIEGE', 'TECH_BLASTING_POWDER', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DWARVEN_DRUID', 'LOC_UNIT_SLTH_DWARVEN_DRUID_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_DWARVEN_DRUID_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_DRUID', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_COMMUNE_WITH_NATURE', '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1'),
('UNIT_SLTH_DWARVEN_SHADOW', 'LOC_UNIT_SLTH_DWARVEN_SHADOW_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_DWARVEN_SHADOW_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_SHADOW', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_DWARVEN_SLINGER', 'LOC_UNIT_SLTH_DWARVEN_SLINGER_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_DWARVEN_SLINGER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DWARVEN_SLINGER', '0', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_ARCHERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_DWARVEN_SOLDIER_RUNES', 'LOC_UNIT_SLTH_DWARVEN_SOLDIER_RUNES_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_SOLDIER_OF_KILMORPH_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_WAY_OF_THE_EARTHMOTHER', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('UNIT_SLTH_EATER_OF_DREAMS', 'LOC_UNIT_SLTH_EATER_OF_DREAMS_NAME', '2', '1', '24', '5', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '1', 'LOC_UNIT_SLTH_EATER_OF_DREAMS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_EATER_OF_DREAMS', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_STRENGTH_OF_WILL', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('UNIT_SLTH_DISCIPLE_EMPYREAN',             'LOC_UNIT_SLTH_DISCIPLE_EMPYREAN_NAME',             'LOC_UNIT_SLTH_DISCIPLE_EMPYREAN_DESCRIPTION',             '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_HONOR',                 'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqCivic, CanTrain, Maintenance, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_EIDOLON', 'LOC_UNIT_SLTH_EIDOLON_NAME', '2', '1', '53', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_UNIT_SLTH_EIDOLON_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_MALEVOLENT_DESIGNS',  '1', '1', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_EURABATRES', 'LOC_UNIT_SLTH_EURABATRES_NAME', '2', '3', '111', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_UNIT_SLTH_EURABATRES_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_EURABATRES', '0', 'PROMOTION_CLASS_BEAST', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_FAWN', 'LOC_UNIT_SLTH_FAWN_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_FAWN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_WAY_OF_THE_FORESTS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_FIREBOW', 'LOC_UNIT_SLTH_FIREBOW_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_FIREBOW_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FIREBOW', '0', 'PROMOTION_CLASS_RANGED', 'TECH_BOWYERS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_FLAGBEARER', 'LOC_UNIT_SLTH_FLAGBEARER_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_FLAGBEARER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FLAGBEARER', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_FLURRY', 'LOC_UNIT_SLTH_FLURRY_NAME', '2', '2', '58', '63', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_FLURRY_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FLURRY', '0', 'PROMOTION_CLASS_RANGED', 'TECH_MACHINERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_FRIGATE', 'LOC_UNIT_SLTH_FRIGATE_NAME', '2', '3', '48', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '150', 'LOC_UNIT_SLTH_FRIGATE_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS',  '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_FREAK', 'LOC_UNIT_SLTH_FREAK_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_FREAK_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FREAK', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_GAMES_RECREATION', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_FYRDWELL', 'LOC_UNIT_SLTH_FYRDWELL_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_FYRDWELL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_FYRDWELL', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_GARGOYLE', 'LOC_UNIT_SLTH_GARGOYLE_NAME', '2', '1', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_GARGOYLE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GARGOYLE', '0', NULL, 'TECH_ENGINEERING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_GALLEON', 'LOC_UNIT_SLTH_GALLEON_NAME', '2', '5', '34', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '150', 'LOC_UNIT_SLTH_GALLEON_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_ASTRONOMY',  '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1),
('UNIT_SLTH_GALLEY', 'LOC_UNIT_SLTH_GALLEY_NAME', '2', '3', '24', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '50', 'LOC_UNIT_SLTH_GALLEY_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'SLTH_TECH_SAILING', '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_GHOST', 'LOC_UNIT_SLTH_GHOST_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_GHOST_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GHOST', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_GIBBON', 'LOC_UNIT_SLTH_GIBBON_NAME', '2', '1', '24', '5', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '1', 'LOC_UNIT_SLTH_GIBBON_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_ADEPT', NULL, 'CIVIC_DECEPTION', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_TECHNOLOGY', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_GILDEN', 'LOC_UNIT_SLTH_GILDEN_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_GILDEN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GILDEN', '0', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_ARCHERY', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_GOBLIN', 'LOC_UNIT_SLTH_GOBLIN_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '15', '0', 'LOC_UNIT_SLTH_GOBLIN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GOBLIN', '1', 'PROMOTION_CLASS_RECON', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_GOVANNON', 'LOC_UNIT_SLTH_GOVANNON_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '480', '1', 'LOC_UNIT_SLTH_GOVANNON_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GOVANNON', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_ARCANE_LORE', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_GRIGORI_MEDIC', 'LOC_UNIT_SLTH_GRIGORI_MEDIC_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_GRIGORI_MEDIC_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GRIGORI_MEDIC', '0', 'PROMOTION_CLASS_MELEE', 'TECH_MEDICINE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('UNIT_SLTH_GUYBRUSH', 'LOC_UNIT_SLTH_GUYBRUSH_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_UNIT_SLTH_GUYBRUSH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_GUYBRUSH', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_HARLEQUIN', 'LOC_UNIT_SLTH_HARLEQUIN_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_UNIT_SLTH_HARLEQUIN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HARLEQUIN', '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_HANDLING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_HAWK', 'LOC_UNIT_SLTH_HAWK_NAME', '4', '8', '0', '0', '5', 'DOMAIN_AIR', 'FORMATION_CLASS_AIR', '20', '0', 'LOC_UNIT_SLTH_HAWK_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', 'TECH_HUNTING', NULL, '1', '1', '1', '0', '1', 'PSEUDOYIELD_UNIT_AIR_COMBAT', '1', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('UNIT_SLTH_HELLHOUND', 'LOC_UNIT_SLTH_HELLHOUND_NAME', '2', '3', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_HELLHOUND_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HELLHOUND', '0', 'PROMOTION_CLASS_RECON', 'TECH_HUNTING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', NULL, '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_HEMAH', 'LOC_UNIT_SLTH_HEMAH_NAME', '2', '1', '34', '7', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '1', 'LOC_UNIT_SLTH_HEMAH_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_ARCANE_LORE', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_HERALD', 'LOC_UNIT_SLTH_HERALD_NAME', '2', '2', '68', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '3', '0', 'LOC_UNIT_SLTH_HERALD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HERALD', '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_MASTERY', NULL, '1', '1', '0', '1', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_HERNE', 'LOC_UNIT_SLTH_HERNE_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_HERNE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HERNE', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_HORNGUARD', 'LOC_UNIT_SLTH_HORNGUARD_NAME', '2', '2', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_DWARVEN_HORNGUARD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HORNGUARD', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('UNIT_SLTH_HYBOREM', 'LOC_UNIT_SLTH_HYBOREM_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '100', '0', 'LOC_UNIT_SLTH_HYBOREM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_HYBOREM', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', NULL, '1', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_HORSE_ARCHER', 'LOC_UNIT_SLTH_HORSE_ARCHER_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_HORSE_ARCHER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_HORSEMAN', 'LOC_UNIT_SLTH_HORSEMAN_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_HORSEMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_HUNTER', 'LOC_UNIT_SLTH_HUNTER_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_HUNTER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', 'TECH_HUNTING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_ILLUSIONIST', 'LOC_UNIT_SLTH_ILLUSIONIST_NAME', '2', '1', '19', '24', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '1', 'LOC_UNIT_SLTH_ILLUSIONIST_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_ILLUSIONIST', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_SORCERY', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_TECHNOLOGY', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('UNIT_SLTH_IMP', 'LOC_UNIT_SLTH_IMP_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '1', 'LOC_UNIT_SLTH_IMP_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_IMP', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_KNOWLEDGE_OF_THE_ETHER', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', '0', NULL, '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('UNIT_SLTH_IRON_GOLEM', 'LOC_UNIT_SLTH_IRON_GOLEM_NAME', '2', '1', '48', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_IRON_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_IRON_GOLEM', NULL, 'TECH_IRON_WORKING', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_JAVELIN_THROWER', 'LOC_UNIT_SLTH_JAVELIN_THROWER_NAME', '2', '1', '19', '4', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_JAVELIN_THROWER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_JAVELIN_THROWER', '0', 'PROMOTION_CLASS_RANGED', 'SLTH_TECH_ARCHERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('UNIT_SLTH_KNIGHT', 'LOC_UNIT_SLTH_KNIGHT_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_KNIGHT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_LIGHTBRINGER', 'LOC_UNIT_SLTH_LIGHTBRINGER_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_LIGHTBRINGER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LIGHTBRINGER', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_LIZARDMAN', 'LOC_UNIT_SLTH_LIZARDMAN_NAME', '2', '2', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_LIZARDMAN_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_RECON', NULL, NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_LOKI', 'LOC_UNIT_SLTH_LOKI_NAME', '2', '2', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_LOKI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOKI', '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_LONGBOWMAN', 'LOC_UNIT_SLTH_LONGBOWMAN_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_LONGBOWMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RANGED', 'TECH_BOWYERS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_LOSHA', 'LOC_UNIT_SLTH_LOSHA_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '300', '0', 'LOC_UNIT_SLTH_LOSHA_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LOSHA', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_LUNATIC', 'LOC_UNIT_SLTH_LUNATIC_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_LUNATIC_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MIND_STAPLING', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_LUONNOTAR', 'LOC_UNIT_SLTH_LUONNOTAR_NAME', '2', '1', '48', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_LUONNOTAR_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_LUONNOTAR', '0', 'PROMOTION_CLASS_DISCIPLE', 'TECH_STRENGTH_OF_WILL', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_KITHRA', 'LOC_UNIT_SLTH_KITHRA_NAME', '2', '3', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_KITHRA_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_FERAL_BOND', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, PromotionClass, PrereqTech, CanTrain, PseudoYieldType, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_MAGNADINE', 'LOC_UNIT_SLTH_MAGNADINE_NAME', '2', '4', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', 'LOC_UNIT_SLTH_MAGNADINE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MAGNADINE', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', '1',  'PSEUDOYIELD_UNIT_HERO','ADVISOR_CONQUEST', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_MAN_O_WAR', 'LOC_UNIT_SLTH_MAN_O_WAR_NAME', '2', '5', '63', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '225',  'LOC_UNIT_SLTH_MAN_O_WAR_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_BLASTING_POWDER', '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('UNIT_SLTH_MANES', 'LOC_UNIT_SLTH_MANES_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1', '0', 'LOC_UNIT_SLTH_MANES_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MARDERO', 'LOC_UNIT_SLTH_MARDERO_NAME', '2', '2', '48', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_MARDERO_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_MALEVOLENT_DESIGNS', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MARKSMAN', 'LOC_UNIT_SLTH_MARKSMAN_NAME', '2', '1', '53', '58', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_MARKSMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RANGED', 'TECH_PRECISION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MAROS', 'LOC_UNIT_SLTH_MAROS_NAME', '2', '1', '29', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_MAROS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MAROS', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, TraitType, PromotionClass, PrereqTech, CanTrain, PseudoYieldType, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_MERCENARY_MOUNTED', 'LOC_UNIT_SLTH_MERCENARY_MOUNTED_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '100', 'LOC_UNIT_SLTH_MERCENARY_MOUNTED_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MERCENARY_MOUNTED', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, '0', NULL, 'ADVISOR_CONQUEST', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MESHABBER', 'LOC_UNIT_SLTH_MESHABBER_NAME', '2', '2', '92', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1200', '0', 'LOC_UNIT_SLTH_MESHABBER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_INFERNAL_PACT', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MIMIC', 'LOC_UNIT_SLTH_MIMIC_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_MIMIC_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MIMIC', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MITHRIL_GOLEM', 'LOC_UNIT_SLTH_MITHRIL_GOLEM_NAME', '2', '1', '121', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '1200', '0', 'LOC_UNIT_SLTH_MITHRIL_GOLEM_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', NULL, 'TECH_MITHRIL_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MONK', 'LOC_UNIT_SLTH_MONK_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_MONK_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MONK', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MOROI', 'LOC_UNIT_SLTH_MOROI_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_MOROI_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MOROI', '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('UNIT_SLTH_MUD_GOLEM', 'LOC_UNIT_SLTH_MUD_GOLEM_NAME', '2', '2', '14', '1', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '100', '5', 'LOC_UNIT_SLTH_MUD_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM', NULL, NULL, NULL, '1', '1', 'ADVISOR_GENERIC', '0', NULL, '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MYCONID', 'LOC_UNIT_SLTH_MYCONID_NAME', '2', '2', '68', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_MYCONID_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_MYCONID', '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_MASTERY', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_NIGHTWATCH', 'LOC_UNIT_SLTH_NIGHTWATCH_NAME', '2', '1', '14', '3', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_NIGHTWATCH_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RANGED', 'TECH_BOWYERS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('UNIT_SLTH_NULLSTONE_GOLEM', 'LOC_UNIT_SLTH_NULLSTONE_GOLEM_NAME', '2', '1', '63', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_NULLSTONE_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_NULLSTONE_GOLEM', NULL, 'TECH_MITHRIL_WEAPONS', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_NYXKIN', 'LOC_UNIT_SLTH_NYXKIN_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_NYXKIN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_NYXKIN', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_STIRRUPS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_OGRE', 'LOC_UNIT_SLTH_OGRE_NAME', '2', '1', '38', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_OGRE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_OGRE', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_OGRE_WARCHIEF', 'LOC_UNIT_SLTH_OGRE_WARCHIEF_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_OGRE_WARCHIEF_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_OGRE_WARCHIEF', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_OPHANIM', 'LOC_UNIT_SLTH_OPHANIM_NAME', '2', '2', '43', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '3', '0', 'LOC_UNIT_SLTH_OPHANIM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_OPHANIM', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, Description, TraitType, AllowBarbarians, PromotionClass, PrereqCivic, CanTrain, Maintenance, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PALADIN', 'LOC_UNIT_SLTH_PALADIN_NAME', '2', '1', '53', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', 'LOC_UNIT_SLTH_PALADIN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_RIGHTEOUSNESS',       '1', '1', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PARAMANDER', 'LOC_UNIT_SLTH_PARAMANDER_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_PARAMANDER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PHALANX', 'LOC_UNIT_SLTH_PHALANX_NAME', '2', '1', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_PHALANX_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', 'TECH_MITHRIL_WEAPONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('UNIT_SLTH_PIRATE', 'LOC_UNIT_SLTH_PIRATE_NAME', '2', '4', '39', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '100', '0', 'LOC_UNIT_SLTH_PIRATE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_PIRATE', '0', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PRIEST_OF_LEAVES', 'LOC_UNIT_SLTH_PRIEST_OF_LEAVES_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_PRIEST_OF_LEAVES_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_PRIVATEER', 'LOC_UNIT_SLTH_PRIVATEER_NAME', '2', '4', '39', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '100', 'LOC_UNIT_SLTH_PRIVATEER_DESCRIPTION', 'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_OPTICS', '1', '1', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PUPPET', 'LOC_UNIT_SLTH_PUPPET_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_PUPPET_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('UNIT_SLTH_PYRE_ZOMBIE', 'LOC_UNIT_SLTH_PYRE_ZOMBIE_NAME', '2', '1', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_PYRE_ZOMBIE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_PYRE_ZOMBIE', '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_RADIANT_GUARD', 'LOC_UNIT_SLTH_RADIANT_GUARD_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_RADIANT_GUARD_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_HONOR', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_RATHA', 'LOC_UNIT_SLTH_RATHA_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_RATHA_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_TRADE', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_REPENTANT_ANGEL', 'LOC_UNIT_SLTH_REPENTANT_ANGEL_NAME', '2', '3', '58',  'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_REPENTANT_ANGEL_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_REPENTANT_ANGEL', '0', 'PROMOTION_CLASS_MELEE', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PRIEST_OF_THE_VEIL', 'LOC_UNIT_SLTH_PRIEST_OF_THE_VEIL_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_PRIEST_OF_THE_VEIL_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_ROSIER', 'LOC_UNIT_SLTH_ROSIER_NAME', '2', '3', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_ROSIER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_CORRUPTION_OF_SPIRIT', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_ROYAL_GUARD', 'LOC_UNIT_SLTH_ROYAL_GUARD_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_ROYAL_GUARD_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_FEUDALISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_QUEEN_OF_THE_LINE', 'LOC_UNIT_SLTH_QUEEN_OF_THE_LINE_NAME', '2', '3', '43', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '225', 'LOC_UNIT_SLTH_QUEEN_OF_THE_LINE_DESCRIPTION',  'PROMOTION_CLASS_NAVAL_MELEE', 'TECH_ASTRONOMY',  '1', '1',  'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_RATHUS', 'LOC_UNIT_SLTH_RATHUS_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_RATHUS_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_RATHUS', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_RANTINE', 'LOC_UNIT_SLTH_RANTINE_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_RANTINE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_RANTINE', '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_RANGER', 'LOC_UNIT_SLTH_RANGER_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_UNIT_SLTH_RANGER_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_HANDLING', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', 1);

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('UNIT_SLTH_DISCIPLE_THE_ASHEN_VEIL',       'LOC_UNIT_SLTH_DISCIPLE_THE_ASHEN_VEIL_NAME',       'LOC_UNIT_SLTH_DISCIPLE_THE_ASHEN_VEIL_DESCRIPTION',       '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_CORRUPTION_OF_SPIRIT',  'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_SAVEROUS', 'LOC_UNIT_SLTH_SAVEROUS_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_SAVEROUS_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_MIND_STAPLING', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_SATYR', 'LOC_UNIT_SLTH_SATYR_NAME', '2', '2', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '150', '0', 'LOC_UNIT_SLTH_SATYR_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_HANDLING', NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_SCOUT', 'LOC_UNIT_SLTH_SCOUT_NAME', '2', '2', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '25', '0', 'LOC_UNIT_SLTH_SCOUT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_RECON', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_SERAPH', 'LOC_UNIT_SLTH_SERAPH_NAME', '2', '1', '39', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '3', '0', 'LOC_UNIT_SLTH_SERAPH_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_SERAPH', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_SHADOW', 'LOC_UNIT_SLTH_SHADOW_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_SHADOW_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_RECON', NULL, 'CIVIC_GUILDS', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1'),
('UNIT_SLTH_SHADOWRIDER', 'LOC_UNIT_SLTH_SHADOWRIDER_NAME', '2', '3', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_SHADOWRIDER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('UNIT_SLTH_SHAMAN', 'LOC_UNIT_SLTH_SHAMAN_NAME', '2', '1', '14', '19', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '1', 'LOC_UNIT_SLTH_SHAMAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_SHAMAN', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_KNOWLEDGE_OF_THE_ETHER', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', 0);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_SONS_OF_ASENA', 'LOC_UNIT_SLTH_SONS_OF_ASENA_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_SONS_OF_ASENA_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_SONS_OF_ASENA', '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_SPHENER', 'LOC_UNIT_SLTH_SPHENER_NAME', '2', '2', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_SPHENER_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_RIGHTEOUSNESS', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_STONESKIN_OGRE', 'LOC_UNIT_SLTH_STONESKIN_OGRE_NAME', '2', '1', '68', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_STONESKIN_OGRE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_STONESKIN_OGRE', '0', 'PROMOTION_CLASS_MELEE', 'TECH_MITHRIL_WEAPONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PRIEST_OF_KILMORPH', 'LOC_UNIT_SLTH_PRIEST_OF_KILMORPH_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_PRIEST_OF_KILMORPH_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_STYGIAN_GUARD', 'LOC_UNIT_SLTH_STYGIAN_GUARD_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_STYGIAN_GUARD_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FANATICISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_SUPPLIES', 'LOC_UNIT_SLTH_SUPPLIES_NAME', '2', '1', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '-1', '0', 'LOC_UNIT_SLTH_SUPPLIES_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('UNIT_SLTH_SWORDSMAN', 'LOC_UNIT_SLTH_SWORDSMAN_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_SWORDSMAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', 'TECH_BRONZE_WORKING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_TASKMASTER', 'LOC_UNIT_SLTH_TASKMASTER_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_TASKMASTER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_TASKMASTER', '0', 'PROMOTION_CLASS_RECON', 'TECH_POISONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_TEUTORIX', 'LOC_UNIT_SLTH_TEUTORIX_NAME', '2', '2', '58', '63', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_TEUTORIX_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_TEUTORIX', '0', 'PROMOTION_CLASS_RANGED', 'TECH_BLASTING_POWDER', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('UNIT_SLTH_DISCIPLE_RUNES_OF_KILMORPH',    'LOC_UNIT_SLTH_DISCIPLE_RUNES_OF_KILMORPH_NAME',    'LOC_UNIT_SLTH_DISCIPLE_RUNES_OF_KILMORPH_DESCRIPTION',    '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_WAY_OF_THE_EARTHMOTHER','PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Bombard, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_TREBUCHET', 'LOC_UNIT_SLTH_TREBUCHET_NAME', '2', '1', '29', '34', '44', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_TREBUCHET_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_TREBUCHET', '0', 'PROMOTION_CLASS_SIEGE', 'TECH_CONSTRUCTION', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, Description, PromotionClass, PrereqTech, CanTrain, Maintenance,  PseudoYieldType, IgnoreMoves, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_TRIREME', 'LOC_UNIT_SLTH_TRIREME_NAME', '2', '2', '34', '0', '0', 'DOMAIN_SEA', 'FORMATION_CLASS_NAVAL', '75', 'LOC_UNIT_SLTH_TRIREME_DESCRIPTION', 'PROMOTION_CLASS_NAVAL_MELEE', 'SLTH_TECH_SAILING',  '1', '1', 'PSEUDOYIELD_UNIT_NAVAL_COMBAT', '0', 'ADVISOR_CONQUEST', 1);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_VALIN', 'LOC_UNIT_SLTH_VALIN_NAME', '2', '3', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_VALIN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', NULL, 'CIVIC_ORDERS_FROM_HEAVEN', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_VALKYRIE', 'LOC_UNIT_SLTH_VALKYRIE_NAME', '2', '1', '29', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '7', '0', 'LOC_UNIT_SLTH_VALKYRIE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VALKYRIE', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_VAMPIRE', 'LOC_UNIT_SLTH_VAMPIRE_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '180', '0', 'LOC_UNIT_SLTH_VAMPIRE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE', '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_FEUDALISM', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, PseudoYieldType, AdvisorType, ZoneOfControl) VALUES
('UNIT_SLTH_VAMPIRE_LORD', 'LOC_UNIT_SLTH_VAMPIRE_LORD_NAME', '2', '1', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_VAMPIRE_LORD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_VAMPIRE_LORD', '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '0', '1', NULL, 'ADVISOR_CONQUEST', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_PRIEST_OF_THE_EMPYREAN', 'LOC_UNIT_SLTH_PRIEST_OF_THE_EMPYREAN_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '0', 'LOC_UNIT_SLTH_PRIEST_OF_THE_EMPYREAN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_PRIESTHOOD', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_RELIGIOUS', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_WAR_MACHINE', 'LOC_UNIT_SLTH_WAR_MACHINE_NAME', '2', '3', '92', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_WAR_MACHINE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WAR_MACHINE', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_MACHINERY', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion,ZoneOfControl) VALUES
('UNIT_SLTH_WAR_TORTOISE', 'LOC_UNIT_SLTH_WAR_TORTOISE_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_WAR_TORTOISE_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WAR_TORTOISE', '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('UNIT_SLTH_WILBOMAN', 'LOC_UNIT_SLTH_WILBOMAN_NAME', '2', '1', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '360', '0', 'LOC_UNIT_SLTH_WILBOMAN_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WILBOMAN', '0', 'PROMOTION_CLASS_MELEE', 'TECH_IRON_WORKING', NULL, '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', NULL, '0', '1');


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_WIZARD', 'LOC_UNIT_SLTH_WIZARD_NAME', '2', '1', '19', '24', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '1', 'LOC_UNIT_SLTH_WIZARD_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WIZARD', '0', 'PROMOTION_CLASS_ADEPT', 'TECH_SORCERY', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', '0', '0');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_WOLF_RIDER', 'LOC_UNIT_SLTH_WOLF_RIDER_NAME', '2', '3', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', '0', 'LOC_UNIT_SLTH_WOLF_RIDER_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, AdvisorType, EnabledByReligion, PseudoYieldType, ZoneOfControl) VALUES
('UNIT_SLTH_WOOD_GOLEM', 'LOC_UNIT_SLTH_WOOD_GOLEM_NAME', '2', '1', '29', '30', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_WOOD_GOLEM_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_WOOD_GOLEM', NULL, 'TECH_CONSTRUCTION', NULL, '1', '1', 'ADVISOR_CONQUEST', '0', NULL, '1');

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_YVAIN', 'LOC_UNIT_SLTH_YVAIN_NAME', '2', '2', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_YVAIN_DESCRIPTION', 'SLTH_RELIGION_BAN_TRAIT', '0', 'PROMOTION_CLASS_DISCIPLE', NULL, 'CIVIC_COMMUNE_WITH_NATURE', '1', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_HERO', '0', 'ADVISOR_CONQUEST', '0', '1');

INSERT INTO Units(UnitType,                 Name,                                               Description,                                               BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain,        FormationClass,                Cost, PromotionClass,             PrereqCivic,                   PseudoYieldType,              TrackReligion, EnabledByReligion, SpreadCharges, ReligionEvictPercent, ReligiousStrength, AdvisorType) VALUES
('UNIT_SLTH_DISCIPLE_OCTOPUS_OVERLORDS',    'LOC_UNIT_SLTH_DISCIPLE_OCTOPUS_OVERLORDS_NAME',    'LOC_UNIT_SLTH_DISCIPLE_OCTOPUS_OVERLORDS_DESCRIPTION',    '2',            '1',       '14',   '14',         '2',   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '60', 'PROMOTION_CLASS_DISCIPLE', 'CIVIC_MESSAGE_FROM_THE_DEEP', 'PSEUDOYIELD_UNIT_RELIGIOUS', '1',           '1',               '1',           '10',                '100',              'ADVISOR_RELIGIOUS');


-- summons so order doesnt matter
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_BATTERING_RAM', 'LOC_UNIT_SLTH_BATTERING_RAM_NAME', '2', '1', '0', '0', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_BATTERING_RAM_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_SIEGE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('UNIT_SLTH_AIR_ELEMENTAL', 'LOC_UNIT_SLTH_AIR_ELEMENTAL_NAME', '2', '2', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_AIR_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_CHAOS_MARAUDER', 'LOC_UNIT_SLTH_CHAOS_MARAUDER_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_CHAOS_MARAUDER_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_CHAOS_MARAUDER', '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),             -- sheaim have as trait
('UNIT_SLTH_DJINN', 'LOC_UNIT_SLTH_DJINN_NAME', '2', '2', '5', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_DJINN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_EARTH_ELEMENTAL', 'LOC_UNIT_SLTH_EARTH_ELEMENTAL_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_EARTH_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_EYE', 'LOC_UNIT_SLTH_EYE_NAME', '4', '8', '0', '0', '5', 'DOMAIN_AIR', 'FORMATION_CLASS_AIR', '-1', '0', 'LOC_UNIT_SLTH_EYE_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '1', '0', '1', 'PSEUDOYIELD_UNIT_AIR_COMBAT', '1', 'ADVISOR_CONQUEST', '0', 0),
('UNIT_SLTH_FIRE_ELEMENTAL', 'LOC_UNIT_SLTH_FIRE_ELEMENTAL_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_FIRE_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_FIREBALL', 'LOC_UNIT_SLTH_FIREBALL_NAME', '2', '1', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_FIREBALL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_FLESH_GOLEM', 'LOC_UNIT_SLTH_FLESH_GOLEM_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_FLESH_GOLEM_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_SKELETON', 'LOC_UNIT_SLTH_SKELETON_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_SKELETON_DESCRIPTION', 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA', '1', 'PROMOTION_CLASS_MELEE', NULL, NULL, '1', '1', '0', '0', '0', NULL, '0', NULL, '0', 1),
('UNIT_SLTH_ICE_ELEMENTAL', 'LOC_UNIT_SLTH_ICE_ELEMENTAL_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_ICE_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_IRA', 'LOC_UNIT_SLTH_IRA_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_IRA_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_LIGHTNING_ELEMENTAL', 'LOC_UNIT_SLTH_LIGHTNING_ELEMENTAL_NAME', '2', '2', '1', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '-1', '0', 'LOC_UNIT_SLTH_LIGHTNING_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0', 1),
('UNIT_SLTH_EINHERJAR', 'LOC_UNIT_SLTH_EINHERJAR_NAME', '2', '1', '6', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_EINHERJAR_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_DISCIPLE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_AUREALIS', 'LOC_UNIT_SLTH_AUREALIS_NAME', '2', '1', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_AUREALIS_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_GUARDIAN_VINES', 'LOC_UNIT_SLTH_GUARDIAN_VINES_NAME', '2', '0', '43', '0', '0', 'DOMAIN_IMMOBILE', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_GUARDIAN_VINES_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_PIT_BEAST', 'LOC_UNIT_SLTH_PIT_BEAST_NAME', '2', '1', '19', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_PIT_BEAST_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_METEOR', 'LOC_UNIT_SLTH_METEOR_NAME', '2', '1', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_METEOR_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_MISTFORM', 'LOC_UNIT_SLTH_MISTFORM_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_MISTFORM_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_SAND_LION', 'LOC_UNIT_SLTH_SAND_LION_NAME', '2', '3', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_SAND_LION_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', NULL, '0', 1),
('UNIT_SLTH_SPECTRE', 'LOC_UNIT_SLTH_SPECTRE_NAME', '2', '2', '14', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_SPECTRE_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_SEVERED_SOUL', 'LOC_UNIT_SLTH_SEVERED_SOUL_NAME', '2', '1', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '-1', '0', 'LOC_UNIT_SLTH_SEVERED_SOUL_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('UNIT_SLTH_TREANT', 'LOC_UNIT_SLTH_TREANT_NAME', '2', '1', '48', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_TREANT_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_WATER_ELEMENTAL', 'LOC_UNIT_SLTH_WATER_ELEMENTAL_NAME', '2', '1', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_WATER_ELEMENTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_WRAITH', 'LOC_UNIT_SLTH_WRAITH_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_WRAITH_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

UPDATE Units SET Name='LOC_UNIT_WARRIOR_NAME', BaseMoves='1', Combat='14', Cost='25', Description='LOC_UNIT_WARRIOR_DESCRIPTION', Maintenance='1' WHERE UnitType='UNIT_WARRIOR';

-- convert into/unbuildable
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, ZoneOfControl) VALUES
('UNIT_SLTH_MARY', 'LOC_UNIT_SLTH_MARY_NAME', '2', '2', '29', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_MARY_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_LICH', 'LOC_UNIT_SLTH_LICH_NAME', '2', '1', '24', '29', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '1', 'LOC_UNIT_SLTH_LICH_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_GAELAN', 'LOC_UNIT_SLTH_GAELAN_NAME', '2', '1', '29', '34', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '1', 'LOC_UNIT_SLTH_GAELAN_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('UNIT_SLTH_MERCENARY', 'LOC_UNIT_SLTH_MERCENARY_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_MERCENARY_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_WAR_ELEPHANT', 'LOC_UNIT_SLTH_WAR_ELEPHANT_NAME', '2', '2', '34', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '90', '0', 'LOC_UNIT_SLTH_WAR_ELEPHANT_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_HORSEBACK_RIDING', NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_SLAVE', 'LOC_UNIT_SLTH_SLAVE_NAME', '2', '2', '0', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', '60', '3', 'LOC_UNIT_SLTH_SLAVE_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_GENERIC', '0', 0),
('UNIT_SLTH_SHADE', 'LOC_UNIT_SLTH_SHADE_NAME', '2', '1', '10', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_SHADE_DESCRIPTION', NULL, '0', NULL, NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 0),
('UNIT_SLTH_RAVENOUS_WEREWOLF', 'LOC_UNIT_SLTH_RAVENOUS_WEREWOLF_NAME', '2', '1', '24', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_RAVENOUS_WEREWOLF_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_WEREWOLF', 'LOC_UNIT_SLTH_WEREWOLF_NAME', '2', '2', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_WEREWOLF_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1),
('UNIT_SLTH_GREATER_WEREWOLF', 'LOC_UNIT_SLTH_GREATER_WEREWOLF_NAME', '2', '3', '54', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '-1', '0', 'LOC_UNIT_SLTH_GREATER_WEREWOLF_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_BEAST', NULL, NULL, '0', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', 1);

INSERT INTO UnitCaptures(CapturedUnitType, BecomesUnitType) VALUES
('UNIT_SLTH_SLAVE', 'UNIT_SLTH_SLAVE');
-- mages
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion) VALUES
('UNIT_SLTH_MAGE', 'LOC_UNIT_SLTH_MAGE_NAME', '2', '1', '4', '4', '10', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '120', '1', 'LOC_UNIT_SLTH_MAGE_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', 'TECH_SORCERY', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', 0),
('UNIT_SLTH_ARCHMAGE', 'LOC_UNIT_SLTH_ARCHMAGE_NAME', '2', '1', '24', '36', '2', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '1', 'LOC_UNIT_SLTH_ARCHMAGE_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_ADEPT', 'TECH_STRENGTH_OF_WILL', NULL, '0', '1', '0', '0', '0', 'PSEUDOYIELD_UNIT_MAGIC', '0', 'ADVISOR_CONQUEST', 0);


INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, PurchaseYield, MustPurchase, ZoneOfControl) VALUES
('UNIT_SLTH_IMMORTAL', 'LOC_UNIT_SLTH_IMMORTAL_NAME', '2', '1', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_UNIT_SLTH_IMMORTAL_DESCRIPTION', NULL, '0', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, '1', 1);


INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('UNIT_SLTH_SHAMAN', 'UNIT_SLTH_ADEPT'),
('UNIT_SLTH_JAVELIN_THROWER', 'UNIT_SLTH_ARCHER'),
-- ('UNIT_SLTH_POLAR_BEAR', 'UNIT_SLTH_BEAR'),              --???
('UNIT_SLTH_BALOR', 'UNIT_SLTH_BERSERKER'),
('UNIT_SLTH_OGRE', 'UNIT_SLTH_CHAMPION'),
('UNIT_SLTH_WOLF_RIDER', 'UNIT_SLTH_HORSEMAN'),
('UNIT_SLTH_OGRE_WARCHIEF', 'UNIT_SLTH_IMMORTAL'),
('UNIT_SLTH_GARGOYLE', 'UNIT_SLTH_LONGBOWMAN'),
('UNIT_SLTH_STONESKIN_OGRE', 'UNIT_SLTH_PHALANX'),
('UNIT_SLTH_AIRSHIP', 'UNIT_SLTH_QUEEN_OF_THE_LINE'),
('UNIT_SLTH_GOBLIN', 'UNIT_SLTH_SCOUT');

INSERT INTO Unit_BuildingPrereqs(Unit, PrereqBuilding) VALUES                   -- fine as no non- bespoke upgrades into it
('UNIT_SLTH_ADEPT', 'BUILDING_MAGE_GUILD'),
('UNIT_SLTH_ARCHER', 'SLTH_BUILDING_ARCHERY_RANGE'),
('UNIT_SLTH_DRUID', 'BUILDING_GROVE'),
('UNIT_SLTH_QUEEN_OF_THE_LINE', 'BUILDING_SHIPYARD'),
('UNIT_SLTH_CATAPULT', 'SLTH_BUILDING_SIEGE_WORKSHOP'),
('UNIT_SLTH_HAWK', 'SLTH_BUILDING_HUNTING_LODGE');

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
('UNIT_SLTH_ADEPT', 'CLASS_ADEPT'),
('UNIT_SLTH_SHAMAN', 'CLASS_ADEPT'),
('UNIT_SLTH_ARCANE_BARGE', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_ARCHER', 'CLASS_RANGED'),
('UNIT_SLTH_JAVELIN_THROWER', 'CLASS_RANGED'),
('UNIT_SLTH_ARCHMAGE', 'CLASS_ADEPT'),
('UNIT_SLTH_ARQUEBUS', 'CLASS_RANGED'),
('UNIT_SLTH_ASSASSIN', 'CLASS_RECON'),
('UNIT_SLTH_SWORDSMAN', 'CLASS_MELEE'),

('UNIT_SLTH_BATTERING_RAM', 'CLASS_SIEGE'),
('UNIT_SLTH_CHAOS_MARAUDER', 'CLASS_MELEE'),
('UNIT_SLTH_EINHERJAR', 'CLASS_DISCIPLE'),
('UNIT_SLTH_EYE', 'CLASS_MELEE'),
('UNIT_SLTH_ICE_ELEMENTAL', 'CLASS_MELEE'),
('UNIT_SLTH_IRA', 'CLASS_MELEE'),
('UNIT_SLTH_PIT_BEAST', 'CLASS_BEAST'),

('UNIT_SLTH_BEASTMASTER', 'CLASS_RECON'),
('UNIT_SLTH_BALOR', 'CLASS_MELEE'),
('UNIT_SLTH_BERSERKER', 'CLASS_MELEE'),
('UNIT_SLTH_CANNON', 'CLASS_SIEGE'),
('UNIT_SLTH_CARAVEL', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_CATAPULT', 'CLASS_SIEGE'),
('UNIT_SLTH_CHAMPION', 'CLASS_MELEE'),
('UNIT_SLTH_OGRE', 'CLASS_MELEE'),
('UNIT_SLTH_CHARIOT', 'CLASS_LIGHT_CAVALRY'),
('UNIT_SLTH_CROSSBOWMAN', 'CLASS_RANGED'),
('UNIT_SLTH_DRIFA', 'CLASS_BEAST'),
('UNIT_SLTH_DRUID', 'CLASS_DISCIPLE'),
('UNIT_SLTH_DUIN', 'CLASS_BEAST'),
('UNIT_SLTH_DWARVEN_SOLDIER_RUNES', 'CLASS_MELEE'),
('UNIT_SLTH_EIDOLON', 'CLASS_DISCIPLE'),

('UNIT_SLTH_FRIGATE', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_GAELAN', 'CLASS_ADEPT'),
('UNIT_SLTH_GALLEON', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_GALLEY', 'CLASS_NAVAL_MELEE'),

('UNIT_SLTH_GREATER_WEREWOLF', 'CLASS_BEAST'),
('UNIT_SLTH_GRIGORI_MEDIC', 'CLASS_MELEE'),
('UNIT_SLTH_HAWK', 'CLASS_AIRCRAFT'),
('UNIT_SLTH_HAWK', 'CLASS_AIR_FIGHTER'),
('UNIT_SLTH_DISCIPLE_OF_ACHERON', 'CLASS_ADEPT'),
('UNIT_SLTH_DISCIPLE_OF_ACHERON', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_HILL_GIANT', 'CLASS_BEAST'),
('UNIT_SLTH_HORSE_ARCHER', 'CLASS_LIGHT_CAVALRY'),
('UNIT_SLTH_HORSEMAN', 'CLASS_LIGHT_CAVALRY'),
('UNIT_SLTH_WOLF_RIDER', 'CLASS_LIGHT_CAVALRY'),
('UNIT_SLTH_HUNTER', 'CLASS_RECON'),
('UNIT_SLTH_IMMORTAL', 'CLASS_MELEE'),
('UNIT_SLTH_OGRE_WARCHIEF', 'CLASS_MELEE'),
('UNIT_SLTH_LICH', 'CLASS_ADEPT'),
('UNIT_SLTH_LONGBOWMAN', 'CLASS_RANGED'),
('UNIT_SLTH_LUNATIC', 'CLASS_MELEE'),
('UNIT_SLTH_MAGE', 'CLASS_ADEPT'),
('UNIT_SLTH_MAN_O_WAR', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_MANTICORE', 'CLASS_BEAST'),
('UNIT_SLTH_MARKSMAN', 'CLASS_RANGED'),
('UNIT_SLTH_MARY', 'CLASS_MELEE'),
('UNIT_SLTH_MERCENARY', 'CLASS_MELEE'),
('UNIT_SLTH_MESHABBER', 'CLASS_MELEE'),
('UNIT_SLTH_MISTFORM', 'CLASS_MELEE'),
('UNIT_SLTH_MUIRIN', 'CLASS_MELEE'),
('UNIT_SLTH_PALADIN', 'CLASS_DISCIPLE'),
('UNIT_SLTH_PHALANX', 'CLASS_MELEE'),
('UNIT_SLTH_STONESKIN_OGRE', 'CLASS_MELEE'),
('UNIT_SLTH_PRIVATEER', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_AIRSHIP', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_QUEEN_OF_THE_LINE', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_RANGER', 'CLASS_RECON'),
('UNIT_SLTH_RANTINE', 'CLASS_MELEE'),
('UNIT_SLTH_RAVENOUS_WEREWOLF', 'CLASS_BEAST'),
('UNIT_SLTH_REVELERS', 'CLASS_RECON'),
('UNIT_SLTH_ROYAL_GUARD', 'CLASS_LIGHT_CAVALRY'),
('UNIT_SLTH_SAILORS_DIRGE', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_SAND_LION', 'CLASS_BEAST'),
('UNIT_SLTH_SCORPION', 'CLASS_ANIMAL'),
('UNIT_SLTH_GOBLIN', 'CLASS_RECON'),
('UNIT_SLTH_SCOUT', 'CLASS_RECON'),
('UNIT_SLTH_SKELETON', 'CLASS_MELEE'),
('UNIT_SLTH_SPECTRE', 'CLASS_MELEE'),
('UNIT_SLTH_TRIREME', 'CLASS_NAVAL_MELEE'),
('UNIT_SLTH_WAR_ELEPHANT', 'CLASS_LIGHT_CAVALRY'),
('UNIT_SLTH_WEREWOLF', 'CLASS_BEAST'),
('UNIT_SLTH_ADEPT', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_SHAMAN', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_ARCHER', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_JAVELIN_THROWER', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_ARCHMAGE', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_ARQUEBUS', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_ASSASSIN', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_SWORDSMAN', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_BEASTMASTER', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_KNIGHT', 'CLASS_LIGHT_CAVALRY'),
('UNIT_SLTH_KNIGHT', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_BALOR', 'RACE_DEMON'),
('UNIT_SLTH_BERSERKER', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_CHAMPION', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_OGRE', 'RACE_ORCISH'),
('UNIT_SLTH_CHAOS_MARAUDER', 'RACE_DEMON'),
('UNIT_SLTH_CROSSBOWMAN', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_DRUID', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_DUIN', 'RACE_WINTERBORN'),
('UNIT_SLTH_DWARVEN_SOLDIER_RUNES', 'RACE_DWARVEN'),
('UNIT_SLTH_EIDOLON', 'RACE_DEMON'),
('UNIT_SLTH_EINHERJAR', 'RACE_ANGEL'),
('UNIT_SLTH_GAELAN', 'RACE_HUMAN'),
('UNIT_SLTH_GRIGORI_MEDIC', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_HORSE_ARCHER', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_HORSEMAN', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_WOLF_RIDER', 'RACE_ORCISH'),
('UNIT_SLTH_HUNTER', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_IMMORTAL', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_OGRE_WARCHIEF', 'RACE_ORCISH'),
('UNIT_SLTH_LICH', 'IS_UNDEAD'),
('UNIT_SLTH_GARGOYLE', 'RACE_GOLEM'),
('UNIT_SLTH_LONGBOWMAN', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_LUNATIC', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_MAGE', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_MARKSMAN', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_MARY', 'RACE_HUMAN'),
('UNIT_SLTH_MERCENARY', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_MESHABBER', 'RACE_DEMON'),
('UNIT_SLTH_MOKKA', 'RACE_FROSTLING'),
('UNIT_SLTH_MUIRIN', 'RACE_DWARVEN'),
('UNIT_SLTH_PALADIN', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_PHALANX', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_STONESKIN_OGRE', 'RACE_ORCISH'),
('UNIT_SLTH_PIT_BEAST', 'RACE_DEMON'),
('UNIT_SLTH_PRIEST_OF_WINTER', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_RANGER', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_RANTINE', 'RACE_ORCISH'),
('UNIT_SLTH_ROYAL_GUARD', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_GOBLIN', 'RACE_ORCISH'),
('UNIT_SLTH_SCOUT', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_SKELETON', 'IS_UNDEAD'),
('UNIT_SLTH_SLAVE', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_SLAVE', 'CLASS_BUILDER'),
('UNIT_SLTH_SLAVE', 'CLASS_LANDCIVILIAN'),
('UNIT_WARRIOR', 'CAN_BE_RACIALIZED'),
('UNIT_SLTH_AIR_ELEMENTAL', 'RACE_ELEMENTAL'),
('UNIT_SLTH_DJINN',  'RACE_ELEMENTAL'),
('UNIT_SLTH_FIRE_ELEMENTAL', 'RACE_ELEMENTAL'),
('UNIT_SLTH_FIREBALL', 'RACE_ELEMENTAL'),
('UNIT_SLTH_ICE_ELEMENTAL', 'RACE_ELEMENTAL'),
('UNIT_SLTH_LIGHTNING_ELEMENTAL', 'RACE_ELEMENTAL'),
('UNIT_SLTH_AUREALIS', 'RACE_ELEMENTAL'),
('UNIT_SLTH_MISTFORM', 'RACE_ELEMENTAL'),
('UNIT_SLTH_SAND_LION', 'RACE_ELEMENTAL'),
('UNIT_SLTH_WATER_ELEMENTAL', 'RACE_ELEMENTAL'),
('UNIT_SLTH_TREANT', 'TAG_VULN_FIRE'),
('UNIT_SLTH_DROWN', 'TAG_VULN_FIRE'),
('UNIT_SLTH_WILBOMAN', 'TAG_VULN_FIRE'),
('UNIT_SLTH_DRIFA', 'TAG_VULN_FIRE'),
('UNIT_SLTH_ICE_ELEMENTAL', 'TAG_VULN_FIRE'),
('UNIT_SLTH_MUIRIN', 'TAG_VULN_FIRE');

INSERT INTO TypeProperties(Type, Name, Value, PropertyType) VALUES
('UNIT_SLTH_AIR_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_AUREALIS', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_DJINN', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_EARTH_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_EINHERJAR', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_EYE', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_FIRE_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_FIREBALL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_ICE_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_LIGHTNING_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_MISTFORM', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_PIT_BEAST', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_SPECTRE', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_WATER_ELEMENTAL', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY'),
('UNIT_SLTH_WRAITH', 'LIFESPAN', '1', 'PROPERTYTYPE_IDENTITY');
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
('UNIT_SLTH_ADEPT', 'KIND_UNIT'),
('UNIT_SLTH_SHAMAN', 'KIND_UNIT'),
('UNIT_SLTH_ARCANE_BARGE', 'KIND_UNIT'),
('UNIT_SLTH_ARCHER', 'KIND_UNIT'),
('UNIT_SLTH_JAVELIN_THROWER', 'KIND_UNIT'),
('UNIT_SLTH_ARCHMAGE', 'KIND_UNIT'),
('UNIT_SLTH_ARQUEBUS', 'KIND_UNIT'),
('UNIT_SLTH_ASSASSIN', 'KIND_UNIT'),
('UNIT_SLTH_AURIC_ASCENDED', 'KIND_UNIT'),
('UNIT_SLTH_SWORDSMAN', 'KIND_UNIT'),
('UNIT_SLTH_BEASTMASTER', 'KIND_UNIT'),
('UNIT_SLTH_BALOR', 'KIND_UNIT'),
('UNIT_SLTH_BERSERKER', 'KIND_UNIT'),
('UNIT_SLTH_CANNON', 'KIND_UNIT'),
('UNIT_SLTH_CARAVEL', 'KIND_UNIT'),
('UNIT_SLTH_CATAPULT', 'KIND_UNIT'),
('UNIT_SLTH_CHAMPION', 'KIND_UNIT'),
('UNIT_SLTH_OGRE', 'KIND_UNIT'),
('UNIT_SLTH_CHAOS_MARAUDER', 'KIND_UNIT'),
('UNIT_SLTH_CHARIOT', 'KIND_UNIT'),
('UNIT_SLTH_CROSSBOWMAN', 'KIND_UNIT'),
('UNIT_SLTH_DRUID', 'KIND_UNIT'),
('UNIT_SLTH_DUIN', 'KIND_UNIT'),
('UNIT_SLTH_DWARVEN_SOLDIER_RUNES', 'KIND_UNIT'),
('UNIT_SLTH_EIDOLON', 'KIND_UNIT'),
('UNIT_SLTH_FRIGATE', 'KIND_UNIT'),
('UNIT_SLTH_GAELAN', 'KIND_UNIT'),
('UNIT_SLTH_GALLEON', 'KIND_UNIT'),
('UNIT_SLTH_GALLEY', 'KIND_UNIT'),
('UNIT_SLTH_GREATER_WEREWOLF', 'KIND_UNIT'),
('UNIT_SLTH_GRIGORI_MEDIC', 'KIND_UNIT'),
('UNIT_SLTH_HAWK', 'KIND_UNIT'),
('UNIT_SLTH_HILL_GIANT', 'KIND_UNIT'),
('UNIT_SLTH_HORSE_ARCHER', 'KIND_UNIT'),
('UNIT_SLTH_HORSEMAN', 'KIND_UNIT'),
('UNIT_SLTH_WOLF_RIDER', 'KIND_UNIT'),
('UNIT_SLTH_HUNTER', 'KIND_UNIT'),
('UNIT_SLTH_IMMORTAL', 'KIND_UNIT'),
('UNIT_SLTH_OGRE_WARCHIEF', 'KIND_UNIT'),
('UNIT_SLTH_LICH', 'KIND_UNIT'),
('UNIT_SLTH_GARGOYLE', 'KIND_UNIT'),
('UNIT_SLTH_LONGBOWMAN', 'KIND_UNIT'),
('UNIT_SLTH_LUNATIC', 'KIND_UNIT'),
('UNIT_SLTH_MAGE', 'KIND_UNIT'),
('UNIT_SLTH_MAN_O_WAR', 'KIND_UNIT'),
('UNIT_SLTH_MANTICORE', 'KIND_UNIT'),
('UNIT_SLTH_MARKSMAN', 'KIND_UNIT'),
('UNIT_SLTH_MARY', 'KIND_UNIT'),
('UNIT_SLTH_MERCENARY', 'KIND_UNIT'),
('UNIT_SLTH_MESHABBER', 'KIND_UNIT'),
('UNIT_SLTH_MUIRIN', 'KIND_UNIT'),
('UNIT_SLTH_PALADIN', 'KIND_UNIT'),
('UNIT_SLTH_PHALANX', 'KIND_UNIT'),
('UNIT_SLTH_STONESKIN_OGRE', 'KIND_UNIT'),
('UNIT_SLTH_PRIEST_OF_WINTER', 'KIND_UNIT'),
('UNIT_SLTH_PRIVATEER', 'KIND_UNIT'),
('UNIT_SLTH_AIRSHIP', 'KIND_UNIT'),
('UNIT_SLTH_QUEEN_OF_THE_LINE', 'KIND_UNIT'),
('UNIT_SLTH_RANGER', 'KIND_UNIT'),
('UNIT_SLTH_RANTINE', 'KIND_UNIT'),
('UNIT_SLTH_RAVENOUS_WEREWOLF', 'KIND_UNIT'),
('UNIT_SLTH_ROYAL_GUARD', 'KIND_UNIT'),
('UNIT_SLTH_SAILORS_DIRGE', 'KIND_UNIT'),
('UNIT_SLTH_SAND_LION', 'KIND_UNIT'),
('UNIT_SLTH_SCORPION', 'KIND_UNIT'),
('UNIT_SLTH_GOBLIN', 'KIND_UNIT'),
('UNIT_SLTH_SCOUT', 'KIND_UNIT'),
('UNIT_SLTH_SHADE', 'KIND_UNIT'),
('UNIT_SLTH_SLAVE', 'KIND_UNIT'),
('UNIT_SLTH_SUPPLIES', 'KIND_UNIT'),
('UNIT_SLTH_TRIREME', 'KIND_UNIT'),
('UNIT_SLTH_WAR_ELEPHANT', 'KIND_UNIT'),
('UNIT_SLTH_WEREWOLF', 'KIND_UNIT'),
('UNIT_SLTH_DISCIPLE_OF_ACHERON', 'KIND_UNIT'),
('UNIT_SLTH_IRA', 'KIND_UNIT'),
('UNIT_SLTH_LIGHTNING_ELEMENTAL', 'KIND_UNIT'),
('UNIT_SLTH_ICE_ELEMENTAL', 'KIND_UNIT'),
('UNIT_SLTH_GUARDIAN_VINES', 'KIND_UNIT'),
('UNIT_SLTH_EINHERJAR', 'KIND_UNIT'),
('UNIT_SLTH_BATTERING_RAM', 'KIND_UNIT'),
('UNIT_SLTH_AIR_ELEMENTAL', 'KIND_UNIT'),
('UNIT_SLTH_AUREALIS', 'KIND_UNIT'),
('UNIT_SLTH_DJINN', 'KIND_UNIT'),
('UNIT_SLTH_EARTH_ELEMENTAL', 'KIND_UNIT'),
('UNIT_SLTH_EYE', 'KIND_UNIT'),
('UNIT_SLTH_FIRE_ELEMENTAL', 'KIND_UNIT'),
('UNIT_SLTH_FIREBALL', 'KIND_UNIT'),
('UNIT_SLTH_FLESH_GOLEM', 'KIND_UNIT'),
('UNIT_SLTH_WRAITH', 'KIND_UNIT'),
('UNIT_SLTH_TREANT', 'KIND_UNIT'),
('UNIT_SLTH_METEOR', 'KIND_UNIT'),
('UNIT_SLTH_MISTFORM', 'KIND_UNIT'),
('UNIT_SLTH_PIT_BEAST', 'KIND_UNIT'),
('UNIT_SLTH_SEVERED_SOUL', 'KIND_UNIT'),
('UNIT_SLTH_SKELETON', 'KIND_UNIT'),
('UNIT_SLTH_SPECTRE', 'KIND_UNIT'),
('UNIT_SLTH_WATER_ELEMENTAL', 'KIND_UNIT'),
('UNIT_SLTH_KNIGHT', 'KIND_UNIT');
