INSERT INTO UnitOperations (OperationType, Description, Icon, VisibleInUI, HoldCycling, CategoryInUI) VALUES
('UNITOPERATION_SUMMON_AIR_ELEMENTAL', 'LOC_SUMMON_AIR_ELEMENTAL_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_DJINN', 'LOC_SUMMON_DJINN_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_EYE', 'LOC_SUMMON_EYE_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_EARTH_ELEMENTAL', 'LOC_SUMMON_EARTH_ELEMENTAL_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_FIRE_ELEMENTAL', 'LOC_SUMMON_FIRE_ELEMENTAL_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_FIREBALL', 'LOC_SUMMON_FIREBALL_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_ICE_ELEMENTAL', 'LOC_SUMMON_ICE_ELEMENTAL_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_EINHERJAR', 'LOC_SUMMON_EINHERJAR_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_AUREALIS', 'LOC_SUMMON_AUREALIS_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_PIT_BEAST', 'LOC_SUMMON_PIT_BEAST_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_MISTFORM', 'LOC_SUMMON_MISTFORM_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_SPECTRE', 'LOC_SUMMON_SPECTRE_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_WATER_ELEMENTAL', 'LOC_SUMMON_WATER_ELEMENTAL_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_WRAITH', 'LOC_SUMMON_WRAITH_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_FLESH_GOLEM', 'LOC_SUMMON_FLESH_GOLEM_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_SKELETON', 'LOC_SUMMON_SKELETON_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_SUMMON_IRA', 'LOC_SUMMON_IRA_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_GRANT_STONESKIN_SELF', 'LOC_GRANT_STONESKIN_SELF_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_GRANT_WATERWALKING_SELF', 'LOC_GRANT_WATERWALKING_SELF_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD'),
('UNITOPERATION_GRANT_SPELL_STAFF_SELF', 'LOC_GRANT_SPELL_STAFF_SELF_DESCRIPTION', 'ICON_UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE', 1, 1, 'BUILD');

INSERT INTO Types(Type, Kind) VALUES
('UNITOPERATION_SUMMON_AIR_ELEMENTAL', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_DJINN', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_EYE', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_EARTH_ELEMENTAL', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_FIRE_ELEMENTAL', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_FIREBALL', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_EINHERJAR', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_AUREALIS', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_PIT_BEAST', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_MISTFORM', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_SPECTRE', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_WATER_ELEMENTAL', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_WRAITH', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_FLESH_GOLEM', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_SKELETON', 'KIND_UNITOPERATION'),
('UNITOPERATION_SUMMON_IRA', 'KIND_UNITOPERATION'),
('UNITOPERATION_GRANT_STONESKIN_SELF', 'KIND_UNITOPERATION'),
('UNITOPERATION_GRANT_WATERWALKING_SELF', 'KIND_UNITOPERATION'),
('UNITOPERATION_GRANT_SPELL_STAFF_SELF', 'KIND_UNITOPERATION'),
('UNITOPERATION_$', 'KIND_UNITOPERATION');


CREATE TABLE IF NOT EXISTS CustomOperations(OperationType text primary key, Callback text, simpleText text, simpleAmount integer);

INSERT INTO CustomOperations (OperationType, Callback, simpleText, simpleAmount) VALUES
('UNITOPERATION_SUMMON_AIR_ELEMENTAL', 'SlthOnSummon', 'SLTH_UNIT_AIR_ELEMENTAL', NULL),
('UNITOPERATION_SUMMON_DJINN', 'SlthOnSummon', 'SLTH_UNIT_DJINN', NULL),
('UNITOPERATION_SUMMON_EYE', 'SlthOnSummon', 'SLTH_UNIT_EYE', NULL),
('UNITOPERATION_SUMMON_EARTH_ELEMENTAL', 'SlthOnSummon', 'SLTH_UNIT_EARTH_ELEMENTAL', NULL),
('UNITOPERATION_SUMMON_FIRE_ELEMENTAL', 'SlthOnSummon', 'SLTH_UNIT_FIRE_ELEMENTAL', NULL),
('UNITOPERATION_SUMMON_FIREBALL', 'SlthOnSummon', 'SLTH_UNIT_FIREBALL', NULL),
('UNITOPERATION_SUMMON_ICE_ELEMENTAL', 'SlthOnSummon', 'SLTH_UNIT_ICE_ELEMENTAL', NULL),
('UNITOPERATION_SUMMON_EINHERJAR', 'SlthOnSummon', 'SLTH_UNIT_EINHERJAR', NULL),
('UNITOPERATION_SUMMON_AUREALIS', 'SlthOnSummon', 'SLTH_UNIT_AUREALIS', NULL),
('UNITOPERATION_SUMMON_PIT_BEAST', 'SlthOnSummon', 'SLTH_UNIT_PIT_BEAST', NULL),
('UNITOPERATION_SUMMON_MISTFORM', 'SlthOnSummon', 'SLTH_UNIT_MISTFORM', NULL),
('UNITOPERATION_SUMMON_SPECTRE', 'SlthOnSummon', 'SLTH_UNIT_SPECTRE', NULL),
('UNITOPERATION_SUMMON_WATER_ELEMENTAL', 'SlthOnSummon', 'SLTH_UNIT_WATER_ELEMENTAL', NULL),
('UNITOPERATION_SUMMON_WRAITH', 'SlthOnSummon', 'SLTH_UNIT_WRAITH', NULL),

('UNITOPERATION_SUMMON_FLESH_GOLEM', 'SlthOnSummonPerm', 'SLTH_UNIT_FLESH_GOLEM', NULL),
('UNITOPERATION_SUMMON_SKELETON', 'SlthOnSummonPerm', 'SLTH_UNIT_SKELETON', NULL),
('UNITOPERATION_SUMMON_IRA', 'SlthOnSummonPerm', 'SLTH_UNIT_IRA', NULL),

('UNITOPERATION_GRANT_STONESKIN_SELF', 'SlthOnGrantBuffSelf', 'BUFF_STONESKIN', NULL),
('UNITOPERATION_GRANT_WATERWALKING_SELF', 'SlthOnGrantBuffSelf', 'BUFF_WATERWALKING', NULL),
('UNITOPERATION_GRANT_SPELL_STAFF_SELF', 'SlthOnGrantBuffSelf', 'SLTH_EQUIPMENT_SPELL_STAFF_ABILITY', NULL);

-- ('UNITOPERATION_$', '', '', NULL),

-- 	['LOC_UNITOPERATION_SUMMON_FLESH_GOLEM_DESCRIPTION'] = {OnStart=OnSummonPerm, iUnit=GameInfo.Units['SLTH_UNIT_FLESH_GOLEM'].Index},
-- 	['LOC_UNITOPERATION_SUMMON_SKELETON_DESCRIPTION'] = {OnStart=OnSummonPerm, iUnit=GameInfo.Units['SLTH_UNIT_SKELETON'].Index},
-- 	['LOC_UNITOPERATION_SUMMON_IRA_DESCRIPTION'] = {OnStart=OnSummonPerm, iUnit=GameInfo.Units['SLTH_UNIT_IRA'].Index},
--
-- 	['LOC_UNITOPERATION_GRANT_ABILITY_SELF_DESCRIPTION'] = {OnStart=OnGrantBuffSelf, iAbility=GameInfo.UnitAbilities[''].Index},
--
-- 	['LOC_UNITOPERATION_GRANT_AOE_ABILITY_DESCRIPTION'] = {OnStart=OnGrantBuff, iAbility=GameInfo.UnitAbilities[''].Index},
--
-- 	['LOC_UNITOPERATION_SET_PLOT_PROPERTY_DESCRIPTION'] = {OnStart=OnSetPlotProperty, iPlotProperty='', iAmount=0},
--
-- 	['LOC_UNITOPERATION_REMOVE_AOE_ABILITY_DESCRIPTION'] = {OnStart=OnRemoveBuff, iAbility=GameInfo.UnitAbilities[''].Index},
--
-- 	['LOC_UNITOPERATION_CHANGE_TILE_TERRAIN_DESCRIPTION'] = {OnStart=OnChangeTerrain, tTerrainMap={[GameInfo.Terrains[''].Index]=1}},
--
-- 	['LOC_UNITOPERATION_CHANGE_RESOURCE_DESCRIPTION'] = {OnStart=OnChangeREsource,  tResourceMap={[GameInfo.Terrains[''].Index]=1}},
--
-- }