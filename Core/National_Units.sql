-- have a resource for each national unit type. Only grant when unit is granted for clutter.
-- for debug just do from game start
-- each unit costs one strategic resource.
-- on unit death, a unit returns a strategic resource. (Lua bound maybe)

--CAVEATS. means we can never do reduction in strategic resource, although could it round to 0?
-- And Magnus does that or Castillan

-- possible options
-- REQUIREMENT_COMBAT_RESULTS_UNIT_DIED used for vampire modifier, but maybe only applies to vamp owner,not unit died owner

-- cant do strategic granting in effects systen somehow

-- PROBLEM: THE AI will just trade their resources :(
/*
INSERT INTO Resources(ResourceType, Name, ResourceClassType, Happiness, Frequency, PrereqTech) VALUES
('RESOURCE_WARHORSES', 'LOC_RESOURCE_WARHORSES', 'RESOURCECLASS_STRATEGIC', '0', '0', NULL);

INSERT INTO Resource_Consumption(ResourceType, Accumulate, StockpileCap) VALUES
('RESOURCE_WARHORSES', '1', '4');

INSERT INTO Types(Type, Kind) VALUES
('RESOURCE_WARHORSES', 'KIND_RESOURCE');

INSERT INTO Units_XP2 (UnitType, ResourceCost) VALUES
('SLTH_UNIT_DEATH_KNIGHT', 1),
('SLTH_UNIT_KNIGHT', 1);

*/
INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, StrategicResource) VALUES
('SLTH_UNIT_DEATH_KNIGHT', 'LOC_SLTH_UNIT_DEATH_KNIGHT_NAME', '2', '3', '39', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_DEATH_KNIGHT_DESCRIPTION', 'SLTH_TRAIT_CIVILIZATION_UNIT_DEATH_KNIGHT', '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL),
('SLTH_UNIT_KNIGHT', 'LOC_SLTH_UNIT_KNIGHT_NAME', '2', '3', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_KNIGHT_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_LIGHT_CAVALRY', 'TECH_WARHORSES', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL),      -- was RESOURCE_WARHORSES
('SLTH_UNIT_BEASTMASTER', 'LOC_SLTH_UNIT_BEASTMASTER_NAME', '2', '2', '67', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_BEASTMASTER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_RECON', 'TECH_ANIMAL_MASTERY', NULL, '1', '1', '0', '1', '0', NULL, '0', 'ADVISOR_GENERIC', '0', NULL),
('SLTH_UNIT_BERSERKER', 'LOC_SLTH_UNIT_BERSERKER_NAME', '2', '1', '53', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_BERSERKER_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_RAGE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL),
('SLTH_UNIT_PHALANX', 'LOC_SLTH_UNIT_PHALANX_NAME', '2', '1', '58', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_PHALANX_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', 'TECH_MITHRIL_WEAPONS', NULL, '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL);

INSERT INTO Units(UnitType, Name, BaseSightRange, BaseMoves, Combat, RangedCombat, Range, Domain, FormationClass, Cost, BuildCharges, Description, TraitType, AllowBarbarians, PromotionClass, PrereqTech, PrereqCivic, CanTrain, Maintenance, Stackable, AirSlots, CanTargetAir, PseudoYieldType, IgnoreMoves, AdvisorType, EnabledByReligion, StrategicResource, PurchaseYield, MustPurchase) VALUES
('SLTH_UNIT_IMMORTAL', 'LOC_SLTH_UNIT_IMMORTAL_NAME', '2', '1', '43', '0', '0', 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', '240', '0', 'LOC_SLTH_UNIT_IMMORTAL_DESCRIPTION', NULL, '1', 'PROMOTION_CLASS_MELEE', NULL, 'CIVIC_DIVINE_ESSENCE', '1', '1', '0', '0', '0', NULL, '0', 'ADVISOR_CONQUEST', '0', NULL, NULL, '1');

INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES
('SLTH_UNIT_DEATH_KNIGHT', 'SLTH_UNIT_KNIGHT');

INSERT INTO UnitUpgrades(Unit, UpgradeUnit) VALUES
('SLTH_UNIT_CHARIOT', 'SLTH_UNIT_KNIGHT'),
('SLTH_UNIT_HORSE_ARCHER', 'SLTH_UNIT_KNIGHT'),
('SLTH_UNIT_ROYAL_GUARD', 'SLTH_UNIT_KNIGHT');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_DEATH_KNIGHT', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_KNIGHT', 'CLASS_LIGHT_CAVALRY'),
('SLTH_UNIT_DEATH_KNIGHT', 'RACE_DEMON'),
('SLTH_UNIT_KNIGHT', 'CAN_BE_RACIALIZED');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_UNIT_DEATH_KNIGHT', 'KIND_UNIT'),
('SLTH_UNIT_KNIGHT', 'KIND_UNIT');


