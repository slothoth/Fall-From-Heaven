INSERT INTO Types (Type, Kind)
VALUES 
('TECH_AGRICULTURE', 'KIND_TECH'),
('TECH_ALTERATION', 'KIND_TECH'),
('TECH_ANIMAL_HANDLING', 'KIND_TECH'),
('TECH_ANIMAL_HUSBANDRY', 'KIND_TECH'),
('TECH_ANIMAL_MASTERY', 'KIND_TECH'),
('TECH_ARCANE_LORE', 'KIND_TECH'),
('TECH_ARCHERY', 'KIND_TECH'),
('TECH_ASTRONOMY', 'KIND_TECH'),
('TECH_BLASTING_POWDER', 'KIND_TECH'),
('TECH_BOWYERS', 'KIND_TECH'),
('TECH_BRONZE_WORKING', 'KIND_TECH'),
('TECH_CALENDAR', 'KIND_TECH'),
('TECH_CARTOGRAPHY', 'KIND_TECH'),
('TECH_CONSTRUCTION', 'KIND_TECH'),
('TECH_CRAFTING', 'KIND_TECH'),
('TECH_DIVINATION', 'KIND_TECH'),
('TECH_ELEMENTALISM', 'KIND_TECH'),
('TECH_ENGINEERING', 'KIND_TECH'),
('TECH_FISHING', 'KIND_TECH'),
('TECH_FUTURE_TECH', 'KIND_TECH'),
('TECH_HORSEBACK_RIDING', 'KIND_TECH'),
('TECH_HUNTING', 'KIND_TECH'),
('TECH_IRON_WORKING', 'KIND_TECH'),
('TECH_KNOWLEDGE_OF_THE_ETHER', 'KIND_TECH'),
('TECH_MACHINERY', 'KIND_TECH'),
('TECH_MASONRY', 'KIND_TECH'),
('TECH_MATHEMATICS', 'KIND_TECH'),
('TECH_MEDICINE', 'KIND_TECH'),
('TECH_MINING', 'KIND_TECH'),
('TECH_MITHRIL_WEAPONS', 'KIND_TECH'),
('TECH_MITHRIL_WORKING', 'KIND_TECH'),
('TECH_NECROMANCY', 'KIND_TECH'),
('TECH_OMNISCIENCE', 'KIND_TECH'),
('TECH_OPTICS', 'KIND_TECH'),
('TECH_PASS_THROUGH_THE_ETHER', 'KIND_TECH'),
('TECH_POISONS', 'KIND_TECH'),
('TECH_PRECISION', 'KIND_TECH'),
('TECH_SAILING', 'KIND_TECH'),
('TECH_SANITATION', 'KIND_TECH'),
('TECH_SMELTING', 'KIND_TECH'),
('TECH_SORCERY', 'KIND_TECH'),
('TECH_STIRRUPS', 'KIND_TECH'),
('TECH_STRENGTH_OF_WILL', 'KIND_TECH'),
('TECH_TRADE', 'KIND_TECH'),
('TECH_WARHORSES', 'KIND_TECH'),
('TECH_WRITING', 'KIND_TECH'),
('CIVIC_ANCIENT_CHANTS', 'KIND_CIVIC'),
('CIVIC_CURRENCY', 'KIND_CIVIC'),
('CIVIC_CODE_OF_LAWS', 'KIND_CIVIC'),
('CIVIC_DRAMA', 'KIND_CIVIC'),
('CIVIC_EXPLORATION', 'KIND_CIVIC'),
('CIVIC_EDUCATION', 'KIND_CIVIC'),
('CIVIC_FESTIVALS', 'KIND_CIVIC'),
('CIVIC_FEUDALISM', 'KIND_CIVIC'),
('CIVIC_GUILDS', 'KIND_CIVIC'),
('CIVIC_MERCANTILISM', 'KIND_CIVIC'),
('CIVIC_MILITARY_STRATEGY', 'KIND_CIVIC'),
('CIVIC_WARFARE', 'KIND_CIVIC'),
('CIVIC_COMMUNE_WITH_NATURE', 'KIND_CIVIC'),
('CIVIC_DIVINE_ESSENCE', 'KIND_CIVIC'),
('CIVIC_FANATICISM', 'KIND_CIVIC'),
('CIVIC_FERAL_BOND', 'KIND_CIVIC)',
('CIVIC_MALEVOLENT_DESIGNS', 'KIND_CIVIC'),
('CIVIC_MYSTICISM', 'KIND_CIVIC'),
('CIVIC_PHILOSOPHY', 'KIND_CIVIC'),
('CIVIC_PRIESTHOOD', 'KIND_CIVIC'),
('CIVIC_RAGE', 'KIND_CIVIC'),
('CIVIC_RELIGIOUS_LAW', 'KIND_CIVIC'),
('CIVIC_RIGHTEOUSNESS', 'KIND_CIVIC'),
('CIVIC_THEOLOGY', 'KIND_CIVIC'),
('CIVIC_WAY_OF_THE_WICKED', 'KIND_CIVIC'),
('CIVIC_WAY_OF_THE_WISE', 'KIND_CIVIC'),
('CIVIC_WAY_OF_THE_EARTHMOTHER', 'KIND_CIVIC'),
('CIVIC_WAY_OF_THE_FORESTS', 'KIND_CIVIC'),
('CIVIC_MESSAGE_FROM_THE_DEEP', 'KIND_CIVIC'),
('CIVIC_HONOR', 'KIND_CIVIC'),
('CIVIC_DECEPTION', 'KIND_CIVIC'),
('CIVIC_ORDERS_FROM_HEAVEN', 'KIND_CIVIC'),
('CIVIC_CORRUPTION_OF_SPIRIT', 'KIND_CIVIC'),
('CIVIC_ARETE', 'KIND_CIVIC'),
('CIVIC_HIDDEN_PATHS', 'KIND_CIVIC'),
('CIVIC_MIND_STAPLING', 'KIND_CIVIC'),
('CIVIC_INFERNAL_PACT', 'KIND_CIVIC');
-- break
INSERT INTO CivicPrereqs(Civic, PrereqCivic)
VALUES	
('CIVIC_EDUCATION', 'CIVIC_ANCIENT_CHANTS'),
('CIVIC_WARFARE', 'CIVIC_EDUCATION'),
('CIVIC_MILITARY_STRATEGY', 'CIVIC_WARFARE'),
('CIVIC_MILITARY_STRATEGY', 'CIVIC_PHILOSOPHY'),
('CIVIC_DRAMA', 'CIVIC_FESTIVALS'),
('CIVIC_DRAMA', 'CIVIC_EDUCATION'),
('CIVIC_CODE_OF_LAWS', 'CIVIC_EDUCATION'),
('CIVIC_CURRENCY', 'CIVIC_CODE_OF_LAWS'),
('CIVIC_TAXATION', 'CIVIC_CURRENCY'),
('CIVIC_GUILDS', 'CIVIC_TAXATION'),
('CIVIC_MERCANTILISM', 'CIVIC_TAXATION'),
('CIVIC_MYSTICISM', 'CIVIC_ANCIENT_CHANTS'),
('CIVIC_PHILOSOPHY', 'CIVIC_MYSTICISM'),
('CIVIC_WAY_OF_THE_WISE', 'CIVIC_PHILOSOPHY'),
('CIVIC_WAY_OF_THE_WICKED', 'CIVIC_PHILOSOPHY'),
('CIVIC_PRIESTHOOD', 'CIVIC_PHILOSOPHY'),
('CIVIC_PRIESTHOOD', 'CIVIC_EDUCATION'),
('CIVIC_FANATICISM', 'CIVIC_PRIESTHOOD'),
('CIVIC_FANATICISM', 'CIVIC_CODE_OF_LAWS'),
('CIVIC_RIGHTEOUSNESS', 'CIVIC_FANATICISM'),
('CIVIC_RIGHTEOUSNESS', 'CIVIC_WAY_OF_THE_WISE'),
('CIVIC_MALEVOLENT_DESIGNS', 'CIVIC_FANATICISM'),
('CIVIC_MALEVOLENT_DESIGNS', 'CIVIC_WAY_OF_THE_WICKED'),
('CIVIC_RAGE', 'CIVIC_FANATICISM'),
('CIVIC_RELIGIOUS_LAW', 'CIVIC_PRIESTHOOD'),
('CIVIC_RELIGIOUS_LAW', 'CIVIC_CODE_OF_LAWS'),
('CIVIC_THEOLOGY', 'CIVIC_RELIGIOUS_LAW'),
('CIVIC_DIVINE_ESSENCE', 'CIVIC_THEOLOGY'),
('CIVIC_COMMUNE_WITH_NATURE', 'CIVIC_FERAL_BOND'),
('CIVIC_COMMUNE_WITH_NATURE', 'CIVIC_PRIESTHOOD'),
('CIVIC_FEUDALISM', 'CIVIC_CODE_OF_LAWS'),
('CIVIC_WAY_OF_THE_EARTHMOTHER', 'CIVIC_MYSTICISM'),
('CIVIC_ARETE', 'CIVIC_WAY_OF_THE_EARTHMOTHER'),
('CIVIC_WAY_OF_THE_FOREST', 'CIVIC_MYSTICISM'),
('CIVIC_HIDDEN_PATHS', 'CIVIC_WAY_OF_THE_FOREST'),
('CIVIC_MESSAGE_FROM_THE_DEEP', 'CIVIC_MYSTICISM'),
('CIVIC_MIND_STAPLING', 'CIVIC_MESSAGE_FROM_THE_DEEP'),
('CIVIC_DECEPTION', 'CIVIC_WAY_OF_THE_WICKED'),
('CIVIC_HONOR', 'CIVIC_WAY_OF_THE_WISE'),
('CIVIC_ORDERS_FROM_HEAVEN', 'CIVIC_CODE_OF_LAWS'),
('CIVIC_ORDERS_FROM_HEAVEN', 'CIVIC_WAY_OF_THE_WISE'),
('CIVIC_CORRUPTION_OF_SPIRIT', 'CIVIC_WAY_OF_WICKED');
INSERT INTO TechnologyPrereqs(Technology, PrereqTech)
VALUES
    ('TECH_ALTERATION',	'TECH_KNOWLEDGE_OF_THE_ETHER'),
	('TECH_ANIMAL_HANDLING', 'TECH_HUNTING'),
	('TECH_ANIMAL_HANDLING', 'TECH_ANIMAL_HUSBANDRY'),
	('TECH_ANIMAL_HUSBANDRY', 'TECH_AGRICULTURE'),
	('TECH_ANIMAL_MASTERY', 'TECH_IRON_WORKING'),
	('TECH_ARCANE_LORE', 'TECH_SORCERY'),
	('TECH_ARCHERY', 'TECH_HUNTING'),
	('TECH_ARCHERY', 'TECH_MINING'),
	('TECH_ASTRONOMY', 'TECH_OPTICS'),
	('TECH_ASTRONOMY', 'TECH_MATHEMATICS'),
	('TECH_BLASTING_POWDER', 'TECH_IRON_WORKING'),
	('TECH_BLASTING_POWDER', 'TECH_ENGINEERING'),
	('TECH_BOWYERS', 'TECH_BRONZE_WORKING'),
	('TECH_BOWYERS', 'TECH_ARCHERY'),
	('TECH_BRONZE_WORKING', 'TECH_MINING'),
	('TECH_CALENDAR', 'TECH_AGRICULTURE'),
	('TECH_CARTOGRAPHY', 'TECH_EXPLORATION'),
	('TECH_CONSTRUCTION', 'TECH_MASONRY'),
	('TECH_DIVINATION', 'TECH_KNOWLEDGE_OF_THE_ETHER'),
	('TECH_ELEMENTALISM', 'TECH_KNOWLEDGE_OF_THE_ETHER'),
	('TECH_ENGINEERING', 'TECH_CONSTRUCTION'),
	('TECH_ENGINEERING', 'TECH_MATHEMATICS'),
	('TECH_FISHING', 'TECH_EXPLORATION'),
	('TECH_FUTURE_TECH', 'TECH_OMNISCIENCE'),
	('TECH_HORSEBACK_RIDING', 'TECH_ANIMAL_HUSBANDRY'),
	('TECH_IRON_WORKING', 'TECH_SMELTING'),
	('TECH_MACHINERY', 'TECH_BOWYERS'),
	('TECH_MACHINERY', 'TECH_ENGINEERING'),
	('TECH_MASONRY', 'TECH_CRAFTING'),
	('TECH_MATHEMATICS', 'TECH_WRITING'),
	('TECH_MEDICINE', 'TECH_SANITATION'),
	('TECH_MINING', 'TECH_CRAFTING'),
	('TECH_MITHRIL_WEAPONS', 'TECH_MITHRIL_WORKING'),
	('TECH_MITHRIL_WORKING', 'TECH_ENGINEERING'),
	('TECH_MITHRIL_WORKING', 'TECH_IRON_WORKING'),
	('TECH_NECROMANCY', 'TECH_KNOWLEDGE_OF_THE_ETHER'),
	('TECH_OMNISCIENCE', 'TECH_STRENGTH_OF_WILL'),
	('TECH_OMNISCIENCE', 'TECH_PASS_THROUGH_THE_ETHER'),
	('TECH_OPTICS', 'TECH_SAILING'),
	('TECH_PASS_THROUGH_THE_ETHER', 'TECH_ARCANE_LORE'),
	('TECH_POISONS', 'TECH_HUNTING'),
	('TECH_PRECISION', 'TECH_BOWYERS'),
	('TECH_SAILING', 'TECH_FISHING'),
	('TECH_SANITATION', 'TECH_CONSTRUCTION'),
	('TECH_SANITATION', 'TECH_BRONZE_WORKING'),
	('TECH_SMELTING', 'TECH_BRONZE_WORKING'),
	('TECH_SORCERY', 'TECH_WRITING'),
	('TECH_SORCERY', 'TECH_ALTERATION'),
	('TECH_SORCERY', 'TECH_DIVINATION'),
	('TECH_SORCERY', 'TECH_ELEMENTALISM'),
	('TECH_SORCERY', 'TECH_NECROMANCY'),
	('TECH_STIRRUPS', 'TECH_ARCHERY'),
	('TECH_STIRRUPS', 'TECH_HORSEBACK_RIDING'),
	('TECH_STRENGTH_OF_WILL', 'TECH_ARCANE_LORE'),
	('TECH_TRADE', 'TECH_WRITING'),
	('TECH_TRADE', 'TECH_HORSEBACK_RIDING'),
	('TECH_TRADE', 'TECH_SAILING'),
	('TECH_WARHORSES', 'TECH_HORSEBACK_RIDING'),
	('TECH_WARHORSES', 'TECH_IRON_WORKING');
