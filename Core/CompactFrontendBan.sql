INSERT INTO RulesetDomainOverrides (Ruleset, PlayerId, ParameterId, Domain) VALUES
('RULESET_EXPANSION_2', 1, 'PlayerLocked', 'PlayerLockedAlwaysLocked'),
('RULESET_EXPANSION_2', 2, 'PlayerLocked', 'PlayerLockedAlwaysLocked');

INSERT INTO RulesetSupportedValues (Ruleset, PlayerId, Domain, Value) VALUES
('RULESET_EXPANSION_2', 1, 'Players:Expansion2_Players', 'SLTH_LEADER_BASIUM'),
('RULESET_EXPANSION_2', 2, 'Players:Expansion2_Players', 'SLTH_LEADER_HYBOREM');

INSERT INTO RulesetUnsupportedValues(Ruleset, PlayerId, Domain, Value) VALUES
('RULESET_EXPANSION_2', '0', 'Players:Expansion2_Players', 'SLTH_LEADER_BASIUM'),
('RULESET_EXPANSION_2', '0', 'Players:Expansion2_Players', 'SLTH_LEADER_HYBOREM');

UPDATE MapSizes SET MinPlayers=4 WHERE MinPlayers=2 or MinPlayers=3;
UPDATE MapSizes SET DefaultPlayers=4 WHERE DefaultPlayers=2 or DefaultPlayers=3;
UPDATE MapSizes SET MaxPlayers=4 WHERE MaxPlayers=2 or MaxPlayers=3;