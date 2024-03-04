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



- Longbowman, TECH_BOWYERS
- Nightwatch, TECH_BOWYERS
- Arquebus, TECH_BLASTING_POWDER
- Marksman, TECH_PRECISION
- Arthendain, TECH_MEDICINE
- Gilden_Silveric, TECH_ARCHERY
- Teutorix, TECH_BLASTING_POWDER
- Dwarven_Slinger, TECH_ARCHERY
- Javelin_Thrower, TECH_ARCHERY
- Flurry, TECH_MACHINERY
- Firebow, TECH_BOWYERS
- Champion, TECH_IRON_WORKING
- Berserker, CIVIC_RAGE
- Immortal, CIVIC_DIVINE_ESSENCE
- Phalanx, TECH_MITHRIL_WEAPONS
- Diseased_Corpses, CIVIC_CORRUPTION_OF_SPIRIT
- Drown, CIVIC_MESSAGE_FROM_THE_DEEP
- Lunatic, CIVIC_MIND_STAPLING
- Stygian_Guard, CIVIC_FANATICISM
- Soldier_of_Kilmorph, CIVIC_WAY_OF_THE_EARTHMOTHER
- Radiant_Guard, CIVIC_HONOR
- Beast_of_Agares, CIVIC_MALEVOLENT_DESIGNS
- Bambur, CIVIC_ARETE
- Barnaxus, TECH_CONSTRUCTION
- Basium, TECH_IRON_WORKING
- Donal_Lugh, CIVIC_FANATICISM
- Guybrush_Threepwood, TECH_IRON_WORKING
- Losha_Valas, CIVIC_FANATICISM
- Maros, TECH_IRON_WORKING
- Meshabber_Of_Dis, CIVIC_MALEVOLENT_DESIGNS
- Rantine, TECH_BRONZE_WORKING
- Saverous, CIVIC_MIND_STAPLING
- Wilboman, TECH_IRON_WORKING
- Abashi_the_Black_Dragon, CIVIC_DIVINE_ESSENCE
- Eurabatres_the_Gold_Dragon, CIVIC_DIVINE_ESSENCE
- Baron_Duin_Halfmorn, CIVIC_FERAL_BOND
- Moroi, TECH_BRONZE_WORKING
- Pyre_Zombie, TECH_BRONZE_WORKING
- Sons_Of_Asena, TECH_BRONZE_WORKING)
- Wood_Golem, TECH_CONSTRUCTION
- Balor, CIVIC_RAGE
- Brujah, CIVIC_RAGE
- Circle_Of_Urd, CIVIC_RAGE
- Clockwork_Golem, TECH_MACHINERY
- Battlemaster, TECH_IRON_WORKING
- Boarding_Party, TECH_IRON_WORKING
- Dragon_Slayer, TECH_IRON_WORKING
- Mimic, TECH_IRON_WORKING
- Ogre, TECH_IRON_WORKING
- Vampire, CIVIC_FEUDALISM
- Iron_Golem, TECH_IRON_WORKING
- Ogre_Warchief, CIVIC_DIVINE_ESSENCE
- Skuld, CIVIC_DIVINE_ESSENCE
- Vampire_Lord, CIVIC_DIVINE_ESSENCE
- Bone_Golem, CIVIC_DIVINE_ESSENCE
- Stoneskin_Ogre, TECH_MITHRIL_WEAPONS
- Verdandi, TECH_MITHRIL_WEAPONS
- Nullstone_Golem, TECH_MITHRIL_WEAPONS
- Beastman, NULL
- Bloodpet, NULL
- Demagag (bannor), TECH_IRON_WORKING
- Flagbearer, CIVIC_FANATICISM
- Freak, CIVIC_FESTIVALS
- Grigori_Medic, TECH_MEDICINE
- Repentant_Angel, TECH_WARHORSES
- Seraph, CIVIC_RAGE
- Valkyrie, CIVIC_DIVINE_ESSENCE
- Gargoyle, TECH_ENGINEERING
- Mud_Golem, NULL

- Savant, CIVIC_CORRUPTION_OF_SPIRIT
- Ritualist, CIVIC_PRIESTHOOD
- Profane, CIVIC_THEOLOGY
- Zealot, CIVIC_MESSAGE_FROM_THE_DEEP
- Cultist, CIVIC_PRIESTHOOD
- Speaker, CIVIC_THEOLOGY
- Disciple_of_Leaves, CIVIC_WAY_OF_THE_FORESTS
- Priest_of_Leaves, CIVIC_PRIESTHOOD
- High_Priest_of_Leaves, CIVIC_THEOLOGY
- Thane_of_Kilmorph, CIVIC_WAY_OF_THE_EARTHMOTHER
- Stonewarden, CIVIC_PRIESTHOOD
- Runekeeper, CIVIC_THEOLOGY
- Paramander, CIVIC_FANATICISM
- Ecclesiast, CIVIC_HONOR
- Vicar, CIVIC_PRIESTHOOD
- Luridus, CIVIC_THEOLOGY
- Acolyte, CIVIC_ORDERS_FROM_HEAVEN
- Confessor, CIVIC_PRIESTHOOD
- Prior, CIVIC_THEOLOGY
- Crusader, CIVIC_FANATICISM
- Paladin, CIVIC_RIGHTEOUSNESS
- Druid, CIVIC_COMMUNE_WITH_NATURE
- Eidolon, CIVIC_MALEVOLENT_DESIGNS
- Chalid Astrakein, CIVIC_RELIGIOUS_LAW
- Sphener, CIVIC_RIGHTEOUSNESS
- Yvain, CIVIC_COMMUNE_WITH_NATURE
- Mardero, CIVIC_MALEVOLENT_DESIGNS
- Dwarven_Druid, CIVIC_COMMUNE_WITH_NATURE
- Lizardman_Druid, CIVIC_COMMUNE_WITH_NATURE
- Luonnotar, TECH_STRENGTH_OF_WILL
- Monk, CIVIC_PRIESTHOOD
- Ratha, CIVIC_TRADE
- Royal_Guard, CIVIC_FEUDALISM
- Shadowrider, TECH_WARHORSES
- Herne, TECH_WARHORSES
- Kitha_Kyriel, CIVIC_FERAL_BOND
- Magnadine, TECH_WARHORSES
- Rosier_the_Fallen, CIVIC_CORRUPTION_OF_SPIRIT
- Valin_Phanuel, CIVIC_ORDERS_FROM_HEAVEN
- The_War_Machine, TECH_MACHINERY
- Centaur_Charger, TECH_TRADE
- Camel_archer, TECH_STIRRUPS
- Centaur_Archer, TECH_STIRRUPS
- Fyrdwell, TECH_STIRRUPS
- Nyxkin, TECH_STIRRUPS
- Boar_Rider, TECH_HORSEBACK_RIDING
- Centaur, TECH_HORSEBACK_RIDING
- Wolf_Rider, TECH_HORSEBACK_RIDING
- Bison_rider, TECH_WARHORSES
- War_Tortoise, TECH_WARHORSES
- Dwarven_Hornguard, TECH_WARHORSES
- Centaur_Lancer, TECH_WARHORSES
- Death_Knight, TECH_WARHORSES
- Ophanim, TECH_WARHORSES
#### Barbarian
- Tumtum, TECH_TRADE, BARB
- Scout, NULL
- Hunter, TECH_HUNTING
- Ranger, TECH_ANIMAL_HANDLING
- Beastmaster, TECH_ANIMAL_MASTERY
- Fawn, CIVIC_WAY_OF_THE_FORESTS
- Satyr, TECH_ANIMAL_HANDLING
- Assassin, TECH_POISONS
- Shadow, CIVIC_GUILDS
- Alazkan_the_assassin, TECH_POISONS
- Rathus_Denmora, TECH_POISONS
- Angel_of_Death, CIVIC_GUILDS
- Chanter, TECH_POISONS
- Devout, TECH_POISONS 
- Ghost, TECH_POISONS
- Taskmaster, TECH_POISONS
- Lizard_Beastmaster, TECH_ANIMAL_MASTERY
- Myconid, TECH_ANIMAL_MASTERY
- Herald, TECH_ANIMAL_MASTERY
- Divided_Soul, TECH_HUNTING
- Hellhound, TECH_HUNTING
- Lizardman, TECH_HUNTING
- Harlequin, TECH_ANIMAL_HANDLING
- Lizard_Ranger, TECH_ANIMAL_HANDLING
- Goblin, NULL
- Courtesan, CIVIC_GUILDS
- Dwarven_Shadow, CIVIC_GUILDS
- Adept, TECH_KNOWLEDGE_OF_THE_ETHER
- Mage, TECH_SORCERY
- Archmage, TECH_STRENGTH_OF_WILL
- Govannon, TECH_ARCANE_LORE
- Corlindale, CIVIC_FANATICISM
- Gibbon_Goetia, TECH_DECEPTION
- Hemah, TECH_ARCANE_LORE
- Imp, TECH_KNOWLEDGE_OF_THE_ETHER
- Shaman, TECH_KNOWLEDGE_OF_THE_ETHER
- Eater_of_Dreams, TECH_STRENGTH_OF_WILL
- Illusionist, TECH_SORCERY
- Wizard, TECH_SORCERY
- Cannon, TECH_BLASTING_POWDER
- Dwarven_Cannon, TECH_BLASTING_POWDER
- Galleon, TECH_ASTRONOMY
- Man_o_War, TECH_BLASTING_POWDER
- Arcane_Barge, TECH_SORCERY
- queen_of_the_line, TECH_ENGINEERING
- The_Black_Wind, TECH_OPTICS
- Pirate, TECH_OPTICS
- Airship, TECH_ENGINEERING
- Hawk, TECH_HUNTING
- Supplies, TECH_MATHEMATICS

# Unbuildable
- Angel (mercurian good death mechanic)
- Ice_Elemental
- Mistform
- Skeleton
- Spectre
- Air_Elemental
- Lightning_Elemental
- Aurealis
- Earth_Elemental
- Fire_Elemental
- Treant
- Water_Elemental
- Wraith
- Flesh_Golem
- Fireball
- Chaos_Marauder (sheaim, planar gate)
- Minotaur (sheaim, planar gate)
- Succubus (sheaim, planar gate)
- Manticore (sheaim, planar gate)
- Hill_Giant
- Azer
- Brigit
- Ira
- Muirin
- Orthus
- Avatar_of_Wrath
- Baby_Spider
- Bear
- Polar_Bear
- Elephant
- Giant_Spider
- Giant_Tortoise
- Gorilla
- Griffon
- Lion
- Lion_Pride
- Scorpion
- Sea_Serpent
- Tiger
- Wolf
- Wolf_Pack
- Acheron_the_Red_Dragon
- Gurid
- Margalard
- Leviathan
- Kraken
- Ravenous_Werewolf
- Blooded_Werewolf
- Greater_Werewolf
- Pit_Beast
- Sand_Lion
- Lucian
- Hyborem
- Mary_Morbus
- Drifa_the_White_Dragon
- Host_of_the_Einherjar
- Tar_Demon (planar gate)
- Ars_Moriendi
- Buboes
- Stephanos
- Yersinia
- Frostling_rider
- Frostling
- Mounted_Mercenary( mercenary, hippus)
- Lich
- Gaelan (unbuildable)
- Mobius Witch ( sheaim, planar gate)
- Sons_of_the_inferno
- Mokka
- Djinn
- Sailors Dirge
- Battering_Ram (summon)
- Floating Eye
- Guardian Vines
- Puppet
- Mercenary
- Adventurer
- Revelers (sheaim, planar gate)
