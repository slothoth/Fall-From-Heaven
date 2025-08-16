CREATE TABLE IF NOT EXISTS Lairs(
    LairType text primary key,
    Callback text,
    LairDestroyChance integer,
    SimpleText text);

INSERT INTO Lairs(LairType, Callback, LairDestroyChance, SimpleText) VALUES
('DEATH', 'onLairKill', '0', NULL),
('COLLAPSE', 'onLairCollapse', '100', NULL),
('DISEASED', 'onLairGrantAbility', '80', 'DISEASED'),
('PLAGUED', 'onLairGrantAbility', '80', 'PLAGUED'),
('POISONED', 'onLairGrantAbility', '80', 'POISONED'),
('WITHERED', 'onLairGrantAbility', '80', 'WITHERED'),
('RUSTED', 'onLairGrantAbility', '80', 'BUFF_RUSTED'),
('SPIRIT_GUIDE', 'onLairGrantAbility', '80', 'BUFF_SPIRIT_GUIDE'),
('ENCHANTED_BLADE', 'onLairGrantAbility', '100', 'BUFF_ENCHANTED_BLADE'),
('POISONED_BLADE', 'onLairGrantAbility', '100', 'ABILITY_POISONED_BLADE'),
('FLAMING_ARROWS', 'onLairGrantAbility', '100', 'ABILITY_FLAMING_ARROWS'),
('SHIELD_OF_FAITH', 'onLairGrantAbility', '100', 'BUFF_SHIELD_OF_FAITH'),
('MITHRIL_WEAPONS', 'onLairGrantAbility', '100', 'ABILITY_MITHRIL_WEAPONS'),
('IRON_WEAPONS', 'onLairGrantAbility', '100', 'ABILITY_IRON_WEAPONS'),
('BRONZE_WEAPONS', 'onLairGrantAbility', '100', 'ABILITY_BRONZE_WEAPONS'),
('CRAZED', 'onLairGrantAbility', '80', 'BUFF_CRAZED'),
('DEMONIC_POSSESSION', 'onLairGrantDemonic', '80', 'BUFF_CRAZED'),
('ENRAGED', 'onLairGrantAbility', '80', 'BUFF_ENRAGED'),
('MUTATED', 'onLairGrantAbility', '50', 'BUFF_MUTATED'),
('CAGE', 'SLTH_Todo', '0', 'BUFF_HELD'),
('SPAWN_DROWN', 'onSpawnBarb', '50', 'SLTH_UNIT_DROWN'),
('SPAWN_SEA_SERPENT', 'onSpawnBarb', '50', 'SLTH_UNIT_SEA_SERPENT'),
('SPAWN_SPIDER', 'onSpawnBarb', '50', 'SLTH_UNIT_GIANT_SPIDER'),
('SPAWN_SPECTRE', 'onSpawnBarb', '50', 'SLTH_UNIT_SPECTRE'),
('SPAWN_SCORPION_BAD', 'onSpawnBadScorpion', '50', NULL),
('SPAWN_SKELETON', 'onSpawnBarb', '50', 'SLTH_UNIT_SKELETON'),
('SPAWN_LIZARDMAN', 'onSpawnBarb', '50', 'SLTH_UNIT_LIZARDMAN'),
('SPAWN_FROSTLING', 'onSpawnBarb', '50', 'SLTH_UNIT_FROSTLING'),
('SPAWN_SCORPION', 'onSpawnBarb', '50', 'SLTH_UNIT_SCORPION'),
('SUPPLIES', 'onGrantUnit', '100', 'SLTH_UNIT_SUPPLIES'),
('PRISONER_DISCIPLE_ASHEN', 'onGrantUnit', '100', 'SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL'),
('PRISONER_DISCIPLE_EMPYREAN', 'onGrantUnit', '100', 'SLTH_UNIT_DISCIPLE_EMPYREAN'),
('PRISONER_DISCIPLE_LEAVES', 'onGrantUnit', '100', 'SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES'),
('PRISONER_DISCIPLE_OVERLORDS', 'onGrantUnit', '100', 'SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS'),
('PRISONER_DISCIPLE_RUNES', 'onGrantUnit', '100', 'SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH'),
('PRISONER_DISCIPLE_ORDER', 'onGrantUnit', '100', 'SLTH_UNIT_DISCIPLE_THE_ORDER'),
('PRISONER_SEA_SERPENT', 'onGrantUnit', '100', 'SLTH_UNIT_SEA_SERPENT'),
('PRISONER_ADVENTURER', 'onGrantUnit', '100', 'UNIT_GREAT_WRITER'),
('PRISONER_ARTIST', 'onGrantGreatUnit', '100', 'UNIT_GREAT_ARTIST'),
('PRISONER_COMMANDER', 'onGrantGreatUnit', '100', 'UNIT_GREAT_GENERAL'),
('PRISONER_ENGINEER', 'onGrantGreatUnit', '100', 'UNIT_GREAT_ENGINEER'),
('PRISONER_MERCHANT', 'onGrantGreatUnit', '100', 'UNIT_GREAT_MERCHANT'),
('PRISONER_PROPHET', 'onGrantGreatUnit', '100', 'UNIT_GREAT_PROPHET'),
('PRISONER_SCIENTIST', 'onGrantGreatUnit', '100', 'UNIT_GREAT_SCIENTIST'),
('ITEM_HEALING_SALVE', 'onGrantItem', '100', 'SLTH_EQUIPMENT_HEALING_SALVE'),
('ITEM_JADE_TORC', 'onGrantItem', '100', 'SLTH_EQUIPMENT_JADE_TORC'),
('ITEM_ROD_OF_WINDS', 'onGrantItem', '100', 'SLTH_EQUIPMENT_ROD_OF_WINDS'),
('ITEM_TIMOR_MASK', 'onGrantItem', '100', 'SLTH_EQUIPMENT_TIMOR_MASK'),
('SPELLSTAFF', 'onGrantItem', '100', 'SLTH_EQUIPMENT_SPELL_STAFF'),
('PRISONER_ANGEL', 'onGrantUnit', '100', 'SLTH_UNIT_ANGEL'),
('PRISONER_MONK', 'onGrantUnit', '100', 'SLTH_UNIT_MONK'),
('PRISONER_ASSASSIN', 'onGrantUnit', '100', 'SLTH_UNIT_ASSASSIN'),
('PRISONER_CHAMPION', 'onGrantUnit', '100', 'SLTH_UNIT_CHAMPION'),
('PRISONER_MAGE', 'onGrantUnit', '100', 'SLTH_UNIT_MAGE'),
('BONUS_CLAM', 'onGrantResource', '100', 'RESOURCE_CLAM'),
('BONUS_CRAB', 'onGrantResource', '100', 'RESOURCE_CRABS'),
('BONUS_FISH', 'onGrantResource', '100', 'RESOURCE_FISH'),
('BONUS_COPPER', 'onGrantResource', '100', 'RESOURCE_COPPER'),
('BONUS_GEMS', 'onGrantResource', '100', 'RESOURCE_DIAMONDS'),
('BONUS_GOLD', 'onGrantResource', '100', 'RESOURCE_GOLD'),
('BONUS_IRON', 'onGrantResource', '100', 'RESOURCE_IRON'),
('NOTHING', 'onLairNothing', '100', NULL),
('HIGH_GOLD', 'onLairGrantGold', '90', NULL),
('TREASURE', 'onFarTreasure', '80', 'SLTH_EQUIPMENT_TREASURE'),
('EXPERIENCE', 'OnLairGrantExperience', '100', NULL),
('DEPTHS', 'SLTH_Todo', '0', NULL),
('DWARF_VS_LIZARDMEN', 'SLTH_Todo', '100', NULL),
('PORTAL', 'SLTH_Todo', '0', NULL),
('TREASURE_VAULT', 'onLairTreasureVault', '100', NULL),
('GOLDEN_AGE', 'onLairGoldenAge', '100', NULL),
('TECH', 'SLTH_Todo', '100', NULL);


CREATE TABLE IF NOT EXISTS LairUnits(
    UnitType text primary key,
    BigBadWaterLeader boolean default 0,
    BigBadWaterHench boolean default 0,
    BigBadFailedGraceWaterLeader boolean default 0,
    BigBadFailedGraceWaterHench boolean default 0,
    BigBadLeader boolean default 0,
    BigBadHench boolean default 0,
    BigBadFailedGraceLeader boolean default 0,
    BigBadFailedGraceHench boolean default 0,
    SnowHenchMan boolean default 0,
    ArmaLeaders boolean default 0,
    ArmaHench boolean default 0,
    Barrow boolean default 0,
    Ruins boolean default 0,
    BarrowFailedGrace boolean default 0,
    RuinsFailedGrace boolean default 0,
    BigBadForestedFailedGraceLeader boolean default 0
);

INSERT INTO LairUnits
(UnitType,                   BigBadWaterLeader,BigBadWaterHench,BigBadFailedGraceWaterLeader,BigBadFailedGraceWaterHench,BigBadHench,BigBadFailedGraceHench) VALUES
('SLTH_UNIT_AZER',           1,                1,               1,                           1,                          1,          1);

INSERT INTO LairUnits
(UnitType,                   BigBadWaterLeader,BigBadFailedGraceWaterLeader) VALUES
('SLTH_UNIT_SEA_SERPENT',    1,               1),
('SLTH_UNIT_STYGIAN_GUARD',  1,               1),
('SLTH_UNIT_PIRATE',         1,               1);


INSERT INTO LairUnits
(UnitType,                  BigBadFailedGraceWaterLeader,BigBadFailedGraceLeader) VALUES
('SLTH_UNIT_AIR_ELEMENTAL',  1,                           1);

INSERT INTO LairUnits
(UnitType,                  BigBadFailedGraceWaterLeader) VALUES
('SLTH_UNIT_WATER_ELEMENTAL',1),
('SLTH_UNIT_KRAKEN',         1);

INSERT INTO LairUnits
(UnitType,                  BigBadWaterHench, BigBadFailedGraceWaterHench, BigBadHench, BigBadFailedGraceHench) VALUES
('SLTH_UNIT_GRIFFON',1, 1, 1,1);

INSERT INTO LairUnits(UnitType, BigBadFailedGraceWaterHench) VALUES
('SLTH_UNIT_DROWN',1);

INSERT INTO LairUnits(UnitType, BigBadLeader, BigBadFailedGraceLeader, BigBadFailedGraceHench) VALUES
('SLTH_UNIT_OGRE',1, 1, 1);

INSERT INTO LairUnits(UnitType, BigBadLeader, BigBadFailedGraceLeader) VALUES
('SLTH_UNIT_ASSASSIN',1, 1),
('SLTH_UNIT_GIANT_SPIDER',1, 1),
('SLTH_UNIT_HILL_GIANT',1, 1),
('SLTH_UNIT_SPECTRE',1, 1);

INSERT INTO LairUnits(UnitType, BigBadLeader, BigBadHench, BigBadFailedGraceLeader, BigBadFailedGraceHench) VALUES
('SLTH_UNIT_SCORPION',1, 1, 1, 1);

INSERT INTO LairUnits(UnitType, BigBadHench, BigBadFailedGraceHench) VALUES
('SLTH_UNIT_SWORDSMAN',1, 1),
('SLTH_UNIT_WOLF',1, 1),
('SLTH_UNIT_WOLF_RIDER',1, 1),
('SLTH_UNIT_CHAOS_MARAUDER',1, 1),
('SLTH_UNIT_MISTFORM',1, 1),
('SLTH_UNIT_LION',1, 1),
('SLTH_UNIT_TIGER',1, 1),
('SLTH_UNIT_BABY_SPIDER',1, 1),
('SLTH_UNIT_FAWN',1, 1);

INSERT INTO LairUnits(UnitType, BigBadFailedGraceLeader) VALUES
('SLTH_UNIT_EARTH_ELEMENTAL',1),
('SLTH_UNIT_FIRE_ELEMENTAL',1),
('SLTH_UNIT_GARGOYLE',1),
('SLTH_UNIT_VAMPIRE',1),
('SLTH_UNIT_MYCONID',1),
('SLTH_UNIT_EIDOLON',1),
('SLTH_UNIT_LICH',1),
('SLTH_UNIT_OGRE_WARCHIEF',1),
('SLTH_UNIT_SATYR',1),
('SLTH_UNIT_WEREWOLF',1);

INSERT INTO LairUnits
(UnitType,                ArmaLeaders,ArmaHench) VALUES
('SLTH_UNIT_PIT_BEAST',   1,          0),
('SLTH_UNIT_DEATH_KNIGHT',1,          0),
('SLTH_UNIT_BALOR',       1,          0),
('SLTH_UNIT_IMP',         0,          1),
('SLTH_UNIT_HELLHOUND',   0,          1);

INSERT INTO LairUnits(UnitType,              Barrow) VALUES
                    ('SLTH_UNIT_SKELETON',   1),
                    ('SLTH_UNIT_PYRE_ZOMBIE',1);
INSERT INTO LairUnits(UnitType,             Ruins) VALUES
                     ('SLTH_UNIT_LIZARDMAN',1),
                     ('SLTH_UNIT_GORILLA',  1);
INSERT INTO LairUnits(UnitType,          BarrowFailedGrace) VALUES
                     ('SLTH_UNIT_WRAITH',1);
INSERT INTO LairUnits(UnitType,             RuinsFailedGrace) VALUES
                     ('SLTH_UNIT_MANTICORE',1);

INSERT INTO LairUnits(UnitType,    SnowHenchMan) VALUES
('SLTH_UNIT_FROSTLING_ARCHER',     0),
('SLTH_UNIT_FROSTLING_WOLF_RIDER', 0),
('SLTH_UNIT_POLAR_BEAR',           0);

INSERT INTO LairUnits(UnitType, BigBadForestedFailedGraceLeader) VALUES
                     ('SLTH_UNIT_TREANT',1);
