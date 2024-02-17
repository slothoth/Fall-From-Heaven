
-----------------------------------------------
-- Types
-----------------------------------------------	
	
INSERT INTO Types
		(Type,													Kind			)
VALUES	('UNIT_MODERN_INFANTRY',								'KIND_UNIT'		);

-----------------------------------------------
-- Tags
-----------------------------------------------	

-----------------------------------------------
-- TypeTags
-----------------------------------------------		

-----------------------------------------------
-- Units
-----------------------------------------------	

UPDATE Units SET BaseMoves = 4 WHERE UnitType = 'UNIT_MECHANIZED_INFANTRY'; -- Mech Inf movement buff
	
INSERT INTO Units	(
		UnitType,
		Name,
		Description,
		BaseMoves,
		Cost,
		PurchaseYield,
		AdvisorType,
		Combat,
		BaseSightRange,
		ZoneOfControl,
		Domain,
		FormationClass,
		PromotionClass,
		Maintenance,
		PrereqTech
		)
VALUES	('UNIT_MODERN_INFANTRY',	-- UnitType
		'LOC_UNIT_MODERN_INFANTRY_NAME',	-- Name
		'LOC_UNIT_MODERN_INFANTRY_DESCRIPTION', -- Description
		3, -- BaseMoves
		40, -- Cost
		'YIELD_GOLD', -- PurchaseYield
		'ADVISOR_CONQUEST', -- AdvisorType
		80, -- Combat
		2, -- BaseSightRange
		1, -- ZoneOfControl
		'DOMAIN_LAND', -- Domain
		'FORMATION_CLASS_LAND_COMBAT', -- FormationClass
		'PROMOTION_CLASS_MELEE', -- PromotionClass
		7, -- Maintenance
		NULL -- PrereqTech
		);

/*
-----------------------------------------------
-- Units_XP2
-----------------------------------------------

INSERT INTO Units_XP2
		(UnitType,					ResourceCost	)
VALUES 	('UNIT_MODERN_INFANTRY',	10				);
*/

-----------------------------------------------
-- UnitAiInfos
-----------------------------------------------
		
INSERT INTO UnitAiInfos (UnitType,	AiType)
SELECT 	'UNIT_MODERN_INFANTRY',		AiType
FROM 	UnitAiInfos
WHERE 	UnitType = 'UNIT_MECHANIZED_INFANTRY';
		
-----------------------------------------------
-- UnitAbilities
-----------------------------------------------

-----------------------------------------------
-- DynamicModifiers

-- This is where we start to define the Modifiers.
-----------------------------------------------

-----------------------------------------------
-- Modifiers

-- This is where we attach the ModType made in "DynamicModifiers" to our "ModifierID" mentioned in the first section.
-----------------------------------------------
		-- This one has a ReqSetID which means that it identifies for this modifier to run - it needs a requirement.

-----------------------------------------------
-- UnitAbilityModifiers

-- These setup the modifers for your ability by hooking your specified modifiers into the ability.
-- "UnitAbilityType" is the Unit's Ability to which you are inserting the "ModifierID", or the modifier, into.
-----------------------------------------------

-----------------------------------------------
-- ModifierArguments

-- This is where we further define the Modifiers.
-----------------------------------------------
-----------------------------------------------
-- ModifierStrings

-- This is where we are going to link the Localisation to the Unit's Ability
-----------------------------------------------

-----------------------------------------------
-- Requirements

-- This is where you define your Requirements
-----------------------------------------------
	
-------------------------------------
-- RequirementArguments
-------------------------------------

-----------------------------------------------
-- RequirementSets

-- This is where you define your Requirement Set
-----------------------------------------------

-----------------------------------------------
-- RequirementSetRequirements

-- This is where you link your RequirementSet to your actual RequirementIDs
-----------------------------------------------