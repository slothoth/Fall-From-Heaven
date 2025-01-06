INSERT INTO Technologies(TechnologyType, Name, Cost, Description, EraType, AdvisorType) VALUES
('TECH_ARCHERY_SKIP', 'LOC_TECH_ARCHERY_SKIPNAME', '9000', 'LOC_TECH_ARCHERY_SKIPDESCRIPTION', 'ERA_ANCIENT', 'ADVISOR_GENERIC'),
('TECH_OMNISCIENCE_SKIP', 'LOC_TECH_OMNISCIENCE_SKIPNAME', '9000', 'LOC_TECH_OMNISCIENCE_SKIPDESCRIPTION', 'ERA_ANCIENT', 'ADVISOR_GENERIC'),
('TECH_SANITATION_SKIP', 'LOC_TECH_SANITATION_SKIPNAME', '9000', 'LOC_TECH_SANITATION_SKIPDESCRIPTION', 'ERA_ANCIENT', 'ADVISOR_GENERIC'),
('TECH_SORCERY_SKIP', 'LOC_TECH_SORCERY_SKIPNAME', '9000', 'LOC_TECH_SORCERY_SKIPDESCRIPTION', 'ERA_ANCIENT', 'ADVISOR_GENERIC'),
('TECH_TRADE_SKIP', 'LOC_TECH_TRADE_SKIPNAME', '9000', 'LOC_TECH_TRADE_SKIPDESCRIPTION', 'ERA_ANCIENT', 'ADVISOR_GENERIC');

INSERT INTO TechnologyPrereqs(Technology, PrereqTech) VALUES
('TECH_ARCHERY_SKIP', 'TECH_HUNTING'),
('TECH_ARCHERY_SKIP', 'TECH_MINING'),
('TECH_OMNISCIENCE_SKIP', 'TECH_STRENGTH_OF_WILL'),
('TECH_OMNISCIENCE_SKIP', 'TECH_PASS_THROUGH_THE_ETHER'),
('TECH_SANITATION_SKIP', 'TECH_CONSTRUCTION'),
('TECH_SANITATION_SKIP', 'TECH_BRONZE_WORKING'),
('TECH_SORCERY_SKIP', 'TECH_ALTERATION'),
('TECH_SORCERY_SKIP', 'TECH_DIVINATION'),
('TECH_SORCERY_SKIP', 'TECH_ELEMENTALISM'),
('TECH_SORCERY_SKIP', 'TECH_NECROMANCY'),
('TECH_TRADE_SKIP', 'TECH_HORSEBACK_RIDING'),
('TECH_TRADE_SKIP', 'TECH_SAILING'),

('TECH_ARCHERY', 'TECH_ARCHERY_SKIP'),
('TECH_OMNISCIENCE', 'TECH_OMNISCIENCE_SKIP'),
('TECH_SANITATION', 'TECH_SANITATION_SKIP'),
('TECH_SORCERY', 'TECH_SORCERY_SKIP'),
('TECH_TRADE', 'TECH_TRADE_SKIP');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent) VALUES
('MODIFIER_GRANT_TECH_ARCHERY_SKIP', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', '1', '1'),
('MODIFIER_GRANT_TECH_OMNISCIENCE_SKIP', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', '1', '1'),
('MODIFIER_GRANT_TECH_SANITATION_SKIP', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', '1', '1'),
('MODIFIER_GRANT_TECH_SORCERY_SKIP', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', '1', '1'),
('MODIFIER_GRANT_TECH_TRADE_SKIP', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', '1', '1');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('MODIFIER_GRANT_TECH_ARCHERY_SKIP', 'TechType', 'TECH_ARCHERY_SKIP'),
('MODIFIER_GRANT_TECH_OMNISCIENCE_SKIP', 'TechType', 'TECH_OMNISCIENCE_SKIP'),
('MODIFIER_GRANT_TECH_SANITATION_SKIP', 'TechType', 'TECH_SANITATION_SKIP'),
('MODIFIER_GRANT_TECH_SORCERY_SKIP', 'TechType', 'TECH_SORCERY_SKIP'),
('MODIFIER_GRANT_TECH_TRADE_SKIP', 'TechType', 'TECH_TRADE_SKIP');

INSERT INTO TechnologyModifiers(TechnologyType, ModifierId) VALUES
('TECH_HUNTING', 'MODIFIER_GRANT_TECH_ARCHERY_SKIP'),
('TECH_MINING', 'MODIFIER_GRANT_TECH_ARCHERY_SKIP'),
('TECH_STRENGTH_OF_WILL', 'MODIFIER_GRANT_TECH_OMNISCIENCE_SKIP'),
('TECH_PASS_THROUGH_THE_ETHER', 'MODIFIER_GRANT_TECH_OMNISCIENCE_SKIP'),
('TECH_CONSTRUCTION', 'MODIFIER_GRANT_TECH_SANITATION_SKIP'),
('TECH_BRONZE_WORKING', 'MODIFIER_GRANT_TECH_SANITATION_SKIP'),
('TECH_ALTERATION', 'MODIFIER_GRANT_TECH_SORCERY_SKIP'),
('TECH_DIVINATION', 'MODIFIER_GRANT_TECH_SORCERY_SKIP'),
('TECH_ELEMENTALISM', 'MODIFIER_GRANT_TECH_SORCERY_SKIP'),
('TECH_NECROMANCY', 'MODIFIER_GRANT_TECH_SORCERY_SKIP'),
('TECH_HORSEBACK_RIDING', 'MODIFIER_GRANT_TECH_TRADE_SKIP'),
('TECH_SAILING', 'MODIFIER_GRANT_TECH_TRADE_SKIP');

INSERT INTO Types(Type, Kind) VALUES
('TECH_ARCHERY_SKIP', 'KIND_TECH'),
('TECH_OMNISCIENCE_SKIP', 'KIND_TECH'),
('TECH_SANITATION_SKIP', 'KIND_TECH'),
('TECH_SORCERY_SKIP', 'KIND_TECH'),
('TECH_TRADE_SKIP', 'KIND_TECH');