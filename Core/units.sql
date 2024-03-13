INSERT INTO Types
		(Type,													Kind			)
VALUES	('UNIT_MODERN_INFANTRY',								'KIND_UNIT'		);

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
		),
        ('UNIT_AAA',	-- UnitType
		'LOC_UNIT_AAA_NAME',	-- Name
		'LOC_UNIT_AAA_DESCRIPTION', -- Description
		1, -- BaseMoves
		5, -- Cost
		'YIELD_GOLD', -- PurchaseYield
		'ADVISOR_CONQUEST', -- AdvisorType
		40, -- Combat
		2, -- BaseSightRange
		1, -- ZoneOfControl
		'DOMAIN_LAND', -- Domain
		'FORMATION_CLASS_LAND_COMBAT', -- FormationClass
		'PROMOTION_CLASS_MELEE', -- PromotionClass
		1, -- Maintenance
		'TECH_POTTERY' -- PrereqTech
		);
