UPDATE GlobalParameters SET Value = '1' WHERE Name = 'FORTIFY_BONUS_PER_TURN';
UPDATE GlobalParameters SET Value = '5' WHERE Name = 'FORTIFY_TURN_MAX';
UPDATE GlobalParameters SET Value = '30' WHERE Name = 'EXPERIENCE_MAX_LEVEL';
UPDATE GlobalParameters SET Value = '99' WHERE Name = 'INFLUENCE_TOKENS_MINIMUM_FOR_SUZERAIN';
UPDATE GlobalParameters SET Value = '1000' WHERE Name = 'RELIGION_PANTHEON_MIN_FAITH';

UPDATE GlobalParameters SET Value = '99' WHERE Name = 'EXPERIENCE_MAXIMUM_ONE_COMBAT';

INSERT INTO DynamicModifiers(ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_ALL_UNITS_PROMOTE_NO_FINISH_MOVES', 'COLLECTION_ALL_UNITS', 'EFFECT_ADJUST_UNIT_PROMOTE_NO_FINISH_MOVES');

INSERT INTO Types(Type, Kind) VALUES
('MODIFIER_ALL_UNITS_PROMOTE_NO_FINISH_MOVES', 'KIND_MODIFIER');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('GLOBAL_PROMOTION_DOESNT_END_TURN', 'MODIFIER_ALL_UNITS_PROMOTE_NO_FINISH_MOVES');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES ('GLOBAL_PROMOTION_DOESNT_END_TURN', 'NoFinishMoves', '1');

INSERT INTO GameModifiers(ModifierId) VALUES
('GLOBAL_PROMOTION_DOESNT_END_TURN');


-- UPDATE GlobalParameters SET Value = '0' WHERE Name = 'UPGRADE_BASE_COST';
-- UPDATE GlobalParameters SET Value = '0' WHERE Name = 'UPGRADE_MINIMUM_COST';


-- UPDATE GlobalParameters SET Value = '1' WHERE Name = 'GOVERNMENT_ALLOW_EMPTY_POLICY_SLOTS'; could be good

-- UPDATE GlobalParameters SET Value = '5' WHERE Name = 'PLOT_UNIT_LIMIT';      - i dont want this but? does it worK?