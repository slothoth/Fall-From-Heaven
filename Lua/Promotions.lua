local tSpiritual = {['LEADER_ARENDEL']=1, ['LEADER_AURIC']=1, ['LEADER_CAPRIA']=1, ['LEADER_JONAS']=1,
            ['LEADER_OSGABELLA']=1, ['LEADER_VARN']=1}

local tSpiritualPromos = {['PROMOTION_CLASS_DISCIPLE']=GameInfo.UnitPromotions['PROMOTION_MOBILITY1_DISCIPLE'].Index}

local tAllowSphereOne = {
        ['RESOURCE_MANA_AIR']        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_BODY']        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_CHAOS']        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_DEATH']        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_EARTH']        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_ENCHANTMENT']        =    GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_ENTROPY']        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_FIRE']        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_LAW']        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_LIFE']        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_METAMAGIC']        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_MIND']        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_NATURE']        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_SHADOW']        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_SPIRIT']        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_SUN']        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED'].Index,
        ['RESOURCE_MANA_WATER']        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED'].Index
    }

local tFreePromos = {
        ['RESOURCE_MANA_AIR']        =    GameInfo.UnitPromotions['AIR_ONE'].Index,
        ['RESOURCE_MANA_BODY']        =    GameInfo.UnitPromotions['BODY_ONE'].Index,
        ['RESOURCE_MANA_CHAOS']        =    GameInfo.UnitPromotions['CHAOS_ONE'].Index,
        ['RESOURCE_MANA_DEATH']        =    GameInfo.UnitPromotions['DEATH_ONE'].Index,
        ['RESOURCE_MANA_EARTH']        =    GameInfo.UnitPromotions['EARTH_ONE'].Index,
        ['RESOURCE_MANA_ENCHANTMENT']=    GameInfo.UnitPromotions['DEATH_ONE'].Index,
        ['RESOURCE_MANA_ENTROPY']        =    GameInfo.UnitPromotions['ENTROPY_ONE'].Index,
        ['RESOURCE_MANA_FIRE']        =    GameInfo.UnitPromotions['FIRE_ONE'].Index,
        ['RESOURCE_MANA_LAW']        =    GameInfo.UnitPromotions['LAW_ONE'].Index,
        ['RESOURCE_MANA_LIFE']        =    GameInfo.UnitPromotions['LIFE_ONE'].Index,
        ['RESOURCE_MANA_METAMAGIC']        =    GameInfo.UnitPromotions['METAMAGIC_ONE'].Index,
        ['RESOURCE_MANA_MIND']        =    GameInfo.UnitPromotions['MIND_ONE'].Index,
        ['RESOURCE_MANA_NATURE']        =    GameInfo.UnitPromotions['NATURE_ONE'].Index,
        ['RESOURCE_MANA_SHADOW']        =    GameInfo.UnitPromotions['SHADOW_ONE'].Index,
        ['RESOURCE_MANA_SPIRIT']        =    GameInfo.UnitPromotions['SPIRIT_ONE'].Index,
        ['RESOURCE_MANA_SUN']        =    GameInfo.UnitPromotions['SUN_ONE'].Index,
        ['RESOURCE_MANA_WATER']        =    GameInfo.UnitPromotions['WATER_ONE'].Index
    }

local tSciencePromoUnlocks = {
    [GameInfo.Technologies['TECH_HORSEBACK_RIDING'].Index] = GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_HORSEBACK_RIDING'].Index
}

local tCivicPromoUnlocks = {
    [GameInfo.Civics['CIVIC_MILITARY_TRADITION'].Index] = GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WARFARE'].Index ,
    [GameInfo.Civics['CIVIC_CORRUPTION_OF_SPIRIT'].Index] = GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_CORRUPTION_OF_SPIRIT'].Index ,        -- stigmata pain
}

local tConditionalUnlocks = {
    [GameInfo.UnitPromotions['PROMOTION_EXTENSION1_ADEPT'].Index]={[1]={tech=GameInfo.Technologies['TECH_ARCANE_LORE'].Index,
                                                                        promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ARCANE_LORE'].Index}},
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_MELEE'].Index]={[1]={civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WICKED'].Index,
                                                                     promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WICKED'].Index},
                                                                [2]={civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WISE'].Index,
                                                                     promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WISE'].Index}
    },
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_BEAST'].Index]={[1]={civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WICKED'].Index,
                                                                     promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WICKED'].Index},
                                                                [2]={civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WISE'].Index,
                                                                     promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WISE'].Index}
    },
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_RECON'].Index]={[1]={civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WICKED'].Index,
                                                                     promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WICKED'].Index},
                                                                [2]={tech=GameInfo.Technologies['TECH_ANIMAL_HUSBANDRY'].Index,
                                                                     promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ANIMAL_HUSBANDRY'].Index}
    },
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_DISCIPLE'].Index]={[1]={civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WISE'].Index,
                                                                        promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WISE'].Index}},

    [GameInfo.UnitPromotions['PROMOTION_DRILL4_MELEE'].Index]={[1]={civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index,
                                                                    promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_MELEE'].Index} },
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_BEAST'].Index]={[1]={civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index,
                                                                    promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_BEAST'].Index} },
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_RECON'].Index]={[1]={civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index,
                                                                    promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_RECON'].Index }},
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_DISCIPLE'].Index]={[1]={civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index,
                                                                       promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_DISCIPLE'].Index}},
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_LIGHT_CAVALRY'].Index] = {[1]={civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index,
                                                                              promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_LIGHT_CAVALRY'].Index }},
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_RANGED'].Index]= {[1]={civic = GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index,
                                                                      promo_grant = GameInfo.UnitPromotions['PROMOTION_BLITZ_RANGED'].Index}},

    [GameInfo.UnitPromotions['PROMOTION_WOODSMAN1_BEAST'].Index]={[1]={civic=GameInfo.Civics['CIVIC_HIDDEN_PATHS'].Index,
                                                                       promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_HIDDEN_PATHS'].Index} },
    [GameInfo.UnitPromotions['PROMOTION_WOODSMAN1_RECON'].Index]={[1]={civic=GameInfo.Civics['CIVIC_HIDDEN_PATHS'].Index,
                                                                       promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_HIDDEN_PATHS'].Index }},
    [GameInfo.UnitPromotions['PROMOTION_COMBAT3_RECON'].Index]={[1]={civic=GameInfo.Technologies['TECH_ANIMAL_MASTERY'].Index,
                                                                     extra_promo=GameInfo.UnitPromotions['PROMOTION_SUBDUE_ANIMAL_RECON'].Index,
                                                                 promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ANIMAL_MASTERY'].Index }},
    [GameInfo.UnitPromotions['AIR_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['BODY_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['CHAOS_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['DEATH_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['EARTH_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['ENCHANTMENT_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['ENTROPY_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['FIRE_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['ICE_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['ICE_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['LAW_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['LIFE_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['METAMAGIC_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['MIND_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['NATURE_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['SPIRIT_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['WATER_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['WATER_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['SUN_ONE'].Index]={[1]={ability='ABILITY_CHANNELING2',
                                                                        promo_grant=GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_2'].Index}},
    [GameInfo.UnitPromotions['AIR_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['BODY_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['CHAOS_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['DEATH_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['EARTH_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['ENCHANTMENT_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['ENTROPY_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['FIRE_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['ICE_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['ICE_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['LAW_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['LIFE_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['METAMAGIC_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['MIND_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['NATURE_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['SPIRIT_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['WATER_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['WATER_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_3'].Index}},
    [GameInfo.UnitPromotions['SUN_TWO'].Index]={[1]={ability='ABILITY_CHANNELING3',
                                                                        promo_grant=GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_3'].Index}}
}

-- not implemented as reversible
local tPolicyUnlocks ={
    GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ORDER_STATE'].Index ,
    GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ARETE'].Index
}

local tHasPromoAndUnlocks = {
    [GameInfo.UnitPromotions['PROMOTION_CAN_GET_FEAR'].Index] = 1,
    [GameInfo.UnitPromotions['PROMOTION_IS_HERO_COMBATV'].Index] = 1}

-- upgrade only, marksmen, immortal, skuld, ogre warchief

-- we are missing channelling two for brujah, death knight,
-- devout channelling 1
-- disciple of acheron fire 1 and 2, and channelling 2,
-- druid life 1 and chan 3.
-- dwarven driud, earth 1
-- firebow, channelling 1
local tUnitFreePromos = {
    [GameInfo.Units['SLTH_UNIT_ARCANE_BARGE'].Index] = {GameInfo.UnitPromotions['FIRE_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_BRUJAH'].Index] = {GameInfo.UnitPromotions['BODY_ONE'].Index, GameInfo.UnitPromotions['DEATH_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_CRUSADER'].Index] = {GameInfo.UnitPromotions['PROMOTION_DEMON_SLAYING_DISCIPLE'].Index},
    [GameInfo.Units['SLTH_UNIT_DEATH_KNIGHT'].Index] = {GameInfo.UnitPromotions['DEATH_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_DEVOUT'].Index] = {GameInfo.UnitPromotions['LIFE_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_DISCIPLE_OF_ACHERON'].Index] = {GameInfo.UnitPromotions['FIRE_ONE'].Index, GameInfo.UnitPromotions['FIRE_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_DRUID'].Index] = {GameInfo.UnitPromotions['LIFE_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_DWARVEN_DRUID'].Index] = {GameInfo.UnitPromotions['LIFE_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_EIDOLON'].Index] = {GameInfo.UnitPromotions['PROMOTION_MARCH_DISCIPLE'].Index},
    [GameInfo.Units['SLTH_UNIT_FAWN'].Index] = {GameInfo.UnitPromotions['PROMOTION_WOODSMAN1_RECON'].Index},             -- could be done as modifier
    [GameInfo.Units['SLTH_UNIT_FIREBOW'].Index] = {GameInfo.UnitPromotions['FIRE_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_FLURRY'].Index] = {GameInfo.UnitPromotions['PROMOTION_BLITZ_RANGED'].Index},
    [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_WINTER'].Index] = {GameInfo.UnitPromotions['ICE_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_LIGHTBRINGER'].Index] = {GameInfo.UnitPromotions['PROMOTION_SENTRY_DISCIPLE'].Index},            -- modifier?
    [GameInfo.Units['SLTH_UNIT_MONK'].Index] = {GameInfo.UnitPromotions['PROMOTION_DEMON_SLAYING_DISCIPLE'].Index},
    [GameInfo.Units['SLTH_UNIT_PALADIN'].Index] = {GameInfo.UnitPromotions['PROMOTION_DEMON_SLAYING_DISCIPLE'].Index},
    [GameInfo.Units['SLTH_UNIT_PARAMANDER'].Index] = {GameInfo.UnitPromotions['PROMOTION_DEMON_SLAYING_DISCIPLE'].Index},
    [GameInfo.Units['SLTH_UNIT_PRIEST_OF_WINTER'].Index] = {GameInfo.UnitPromotions['ICE_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_PYRE_ZOMBIE'].Index] = {GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_MELEE'].Index},
    [GameInfo.Units['SLTH_UNIT_RADIANT_GUARD'].Index] = {GameInfo.UnitPromotions['SUN_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_RATHA'].Index] = {GameInfo.UnitPromotions['SUN_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_ROYAL_GUARD'].Index] = {GameInfo.UnitPromotions['SPIRIT_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_PRIEST_OF_WINTER'].Index] = {GameInfo.UnitPromotions['ICE_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_SATYR'].Index] = {GameInfo.UnitPromotions['PROMOTION_WOODSMAN1_RECON'].Index},             -- could be done as modifier
    [GameInfo.Units['SLTH_UNIT_SERAPH'].Index] = {GameInfo.UnitPromotions['FIRE_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_SON_OF_THE_INFERNO'].Index] = {GameInfo.UnitPromotions['FIRE_ONE'].Index, GameInfo.UnitPromotions['FIRE_TWO'].Index, GameInfo.UnitPromotions['FIRE_THREE'].Index},
    [GameInfo.Units['SLTH_UNIT_STYGIAN_GUARD'].Index] = {GameInfo.UnitPromotions['PROMOTION_MARCH_MELEE'].Index},
    [GameInfo.Units['SLTH_UNIT_SUCCUBUS'].Index] = {GameInfo.UnitPromotions['MIND_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_VAMPIRE'].Index] = {GameInfo.UnitPromotions['BODY_ONE'].Index, GameInfo.UnitPromotions['DEATH_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_VAMPIRE_LORD'].Index] = {GameInfo.UnitPromotions['BODY_ONE'].Index, GameInfo.UnitPromotions['DEATH_ONE'].Index, GameInfo.UnitPromotions['MIND_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_ABASHI'].Index] = {GameInfo.UnitPromotions['PROMOTION_SENTRY_BEAST'].Index},
    [GameInfo.Units['SLTH_UNIT_ACHERON'].Index] = {GameInfo.UnitPromotions['PROMOTION_SENTRY_BEAST'].Index},              -- also sentry 2 but diff promo GameInfo.UnitPromotions['class'].Index},
    [GameInfo.Units['SLTH_UNIT_ARTHENDAIN'].Index] = {GameInfo.UnitPromotions['LIFE_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_BAMBUR'].Index] = {GameInfo.UnitPromotions['ENCHANTMENT_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_DUIN'].Index] = {GameInfo.UnitPromotions['PROMOTION_MAGIC_RESISTANCE_BEAST'].Index},
    [GameInfo.Units['SLTH_UNIT_BASIUM'].Index] = {GameInfo.UnitPromotions['PROMOTION_SENTRY_MELEE'].Index},
    [GameInfo.Units['SLTH_UNIT_BUBOES'].Index] = {GameInfo.UnitPromotions['PROMOTION_BLITZ_LIGHT_CAVALRY'].Index, GameInfo.UnitPromotions['PROMOTION_FEAR_LIGHT_CAVALRY'].Index},
    [GameInfo.Units['SLTH_UNIT_CHALID'].Index] = {GameInfo.UnitPromotions['LAW_ONE'].Index, GameInfo.UnitPromotions['SUN_ONE'].Index, GameInfo.UnitPromotions['PROMOTION_SENTRY_DISCIPLE'].Index},
    [GameInfo.Units['SLTH_UNIT_CORLINDALE'].Index] = {GameInfo.UnitPromotions['EARTH_ONE'].Index, GameInfo.UnitPromotions['MIND_ONE'].Index, GameInfo.UnitPromotions['SPIRIT_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_DONAL'].Index] = {GameInfo.UnitPromotions['SPIRIT_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_DRIFA'].Index] = {GameInfo.UnitPromotions['PROMOTION_SENTRY_BEAST'].Index},
    [GameInfo.Units['SLTH_UNIT_EURABATRES'].Index] = {GameInfo.UnitPromotions['PROMOTION_SENTRY_BEAST'].Index},
    [GameInfo.Units['SLTH_UNIT_HYBOREM'].Index] = {GameInfo.UnitPromotions['PROMOTION_SENTRY_MELEE'].Index},
    [GameInfo.Units['SLTH_UNIT_LOKI'].Index] = {GameInfo.UnitPromotions['CHAOS_ONE'].Index, GameInfo.UnitPromotions['MIND_ONE'].Index, GameInfo.UnitPromotions['PROMOTION_EXTENSION1_ADEPT'].Index},
    [GameInfo.Units['SLTH_UNIT_LOSHA'].Index] = {GameInfo.UnitPromotions['BODY_ONE'].Index, GameInfo.UnitPromotions['DEATH_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_MARDERO'].Index] = {GameInfo.UnitPromotions['PROMOTION_MARCH_DISCIPLE'].Index, GameInfo.UnitPromotions['ENTROPY_ONE'].Index},
    [GameInfo.Units['SLTH_UNIT_MESHABBER'].Index] = {GameInfo.UnitPromotions['FIRE_TWO'].Index},
    [GameInfo.Units['SLTH_UNIT_SPHENER'].Index] = {GameInfo.UnitPromotions['LIFE_ONE'].Index, GameInfo.UnitPromotions['PROMOTION_DEMON_SLAYING_DISCIPLE'].Index},
    [GameInfo.Units['SLTH_UNIT_VALIN'].Index] = {GameInfo.UnitPromotions['PROMOTION_DEMON_SLAYING_DISCIPLE'].Index},                             -- technically more like an ability as cav dont get access
    [GameInfo.Units['SLTH_UNIT_YVAIN'].Index] = { GameInfo.UnitPromotions['LIFE_ONE'].Index, GameInfo.UnitPromotions['NATURE_ONE'].Index }
}

-- these numbers seem wrong on small and medium to BIG
local tExperienceAbilities = {GRANT_EXPERIENCE_SMALL_ABILITY_CONQUEST=16, GRANT_EXPERIENCE_SMALL_ABILITY_APPRENTICESHIP=16,
                        GRANT_EXPERIENCE_SMALL_ABILITY_THEOCRACY=16, GRANT_EXPERIENCE_SMALL_ABILITY_TITAN=16,
                        GRANT_EXPERIENCE_SMALL_ABILITY_ADVENT_GUILD=16, GRANT_EXPERIENCE_SMALL_ABILITY_DESERT_SHRINE_DISCIPLE=16,
                        GRANT_EXPERIENCE_SMALL_ABILITY_NOX_NOCTIS_RECON=16, GRANT_EXPERIENCE_SMALL_ABILITY_DIES_DEII_DISCIPLE=16,
                        GRANT_EXPERIENCE_SMALL_ABILITY_COMMAND_POST=16, GRANT_EXPERIENCE_SMALL_ABILITY_LUONNOTAR_DISCIPLE=16,
                        GRANT_EXPERIENCE_MEDIUM_ABILITY_LUONNOTAR=32,
                        GRANT_EXPERIENCE_SMALL_ABILITY_SHIPYARD_NAVAL=32,
                        GRANT_EXPERIENCE_BIG_ABILITY_LUONNOTAR=25,
                        GRANT_EXPERIENCE_LARGE_ABILITY_LUONNOTAR=33,
                        GRANT_EXPERIENCE_HUGE_ABILITY_LUONNOTAR=41,
                        GRANT_EXPERIENCE_MASSIVE_ABILITY_LUONNOTAR=49,
                        GRANT_EXPERIENCE_ENORMOUS_ABILITY_LUONNOTAR= 58
}


local tInherentReligion = { [GameInfo.Units['SLTH_UNIT_DISCIPLE_EMPYREAN'].Index] = 'RELIGION_JUDAISM',
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES'].Index] = 'RELIGION_CATHOLICISM',
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS'].Index] = 'RELIGION_HINDUISM',
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH'].Index] = 'RELIGION_CONFUCIANISM',
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL'].Index] = 'RELIGION_BUDDHISM',
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_THE_ORDER'].Index] = 'RELIGION_PROTESTANTISM',
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_KILMORPH'].Index] = 'RELIGION_CONFUCIANISM',
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_OVERLORDS'].Index] = 'RELIGION_HINDUISM',
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_ORDER'].Index] = 'RELIGION_PROTESTANTISM',
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_VEIL'].Index] = 'RELIGION_BUDDHISM',
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_LEAVES'].Index] = 'RELIGION_CATHOLICISM',
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_EMPYREAN'].Index] = 'RELIGION_JUDAISM',
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH'].Index] = 'RELIGION_CONFUCIANISM',
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS'].Index] = 'RELIGION_HINDUISM',
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN'].Index] = 'RELIGION_JUDAISM',
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER'].Index] = 'RELIGION_PROTESTANTISM',
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL'].Index] = 'RELIGION_BUDDHISM',
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_LEAVES'].Index] = 'RELIGION_CATHOLICISM',
                            [GameInfo.Units['SLTH_UNIT_ARTHENDAIN'].Index] = 'RELIGION_CONFUCIANISM',
                            [GameInfo.Units['SLTH_UNIT_BAMBUR'].Index] = 'RELIGION_CONFUCIANISM',
                            [GameInfo.Units['SLTH_UNIT_MITHRIL_GOLEM'].Index] = 'RELIGION_CONFUCIANISM',
                            [GameInfo.Units['SLTH_UNIT_PARAMANDER'].Index] = 'RELIGION_CONFUCIANISM',
                            [GameInfo.Units['SLTH_UNIT_DROWN'].Index] = 'RELIGION_HINDUISM',
                            [GameInfo.Units['SLTH_UNIT_HEMAH'].Index] = 'RELIGION_HINDUISM',
                            [GameInfo.Units['SLTH_UNIT_SAVEROUS'].Index] = 'RELIGION_HINDUISM',
                            [GameInfo.Units['SLTH_UNIT_STYGIAN_GUARD'].Index] = 'RELIGION_HINDUISM',
                            [GameInfo.Units['SLTH_UNIT_CRUSADER'].Index] = 'RELIGION_PROTESTANTISM',
                            [GameInfo.Units['SLTH_UNIT_VALIN'].Index] = 'RELIGION_PROTESTANTISM',
                            [GameInfo.Units['SLTH_UNIT_SPHENER'].Index] = 'RELIGION_PROTESTANTISM',
                            [GameInfo.Units['SLTH_UNIT_BEAST_OF_AGARES'].Index] = 'RELIGION_BUDDHISM',
                            [GameInfo.Units['SLTH_UNIT_DISEASED_CORPSE'].Index] = 'RELIGION_BUDDHISM',
                            [GameInfo.Units['SLTH_UNIT_ROSIER'].Index] = 'RELIGION_BUDDHISM',
                            [GameInfo.Units['SLTH_UNIT_MARDERO'].Index] = 'RELIGION_BUDDHISM',
                            [GameInfo.Units['SLTH_UNIT_FAWN'].Index] = 'RELIGION_CATHOLICISM',
                            [GameInfo.Units['SLTH_UNIT_SATYR'].Index] = 'RELIGION_CATHOLICISM',
                            [GameInfo.Units['SLTH_UNIT_KITHRA'].Index] = 'RELIGION_CATHOLICISM',
                            [GameInfo.Units['SLTH_UNIT_YVAIN'].Index] = 'RELIGION_CATHOLICISM',
                            [GameInfo.Units['SLTH_UNIT_RATHA'].Index] = 'RELIGION_JUDAISM',
                            [GameInfo.Units['SLTH_UNIT_RADIANT_GUARD'].Index] = 'RELIGION_JUDAISM',
                            [GameInfo.Units['SLTH_UNIT_CHALID'].Index] = 'RELIGION_JUDAISM',
                            [GameInfo.Units['SLTH_UNIT_SHADOW'].Index] = 'RELIGION_ISLAM',
                            [GameInfo.Units['SLTH_UNIT_SHADOWRIDER'].Index] = 'RELIGION_ISLAM',
                            [GameInfo.Units['SLTH_UNIT_NIGHTWATCH'].Index] = 'RELIGION_ISLAM',
                            [GameInfo.Units['SLTH_UNIT_GIBBON'].Index] = 'RELIGION_ISLAM'
}

local tReligionAbility = {
    ['RELIGION_ISLAM']='ABILITY_WORSHIPS_ESUS', ['RELIGION_HINDUISM']='ABILITY_WORSHIPS_OCTOPUS',
    ['RELIGION_BUDDHISM']='ABILITY_WORSHIPS_VEIL',
    ['RELIGION_CATHOLICISM']='ABILITY_WORSHIPS_LEAVES', ['RELIGION_JUDAISM']='ABILITY_WORSHIPS_EMPYREAN',
    ['RELIGION_CONFUCIANISM']='ABILITY_WORSHIPS_KILMORPH', ['RELIGION_PROTESTANTISM']='ABILITY_WORSHIPS_ORDER'
}

local tReligionAlignment = {
    ['RELIGION_ISLAM']=0, ['RELIGION_HINDUISM']=0, ['RELIGION_BUDDHISM']=0,
    ['RELIGION_CATHOLICISM']=1,
    ['RELIGION_JUDAISM']=2, ['RELIGION_CONFUCIANISM']=2, ['RELIGION_PROTESTANTISM']=2
}

function GrantUnitReligion(pUnit, sReligion)
    local pUnitAbilities = pUnit:GetAbility()
    local sReligionAbility = tReligionAbility[sReligion]
    pUnitAbilities:AddAbilityCount(sReligionAbility)
    local iAlignment = tReligionAlignment[sReligion]
    if iAlignment then
        if iAlignment == 0 then
            pUnitAbilities:AddAbilityCount('ALIGNMENT_EVIL')
        elseif iAlignment == 2 then
            pUnitAbilities:AddAbilityCount('ALIGNMENT_GOOD')
        end
    end
end



function onSpawnApplyPromotions(playerID, unitID)
    if playerID == nil then return end
    if unitID == nil then return end
    local pUnitAbilities
    local pPlayer = Players[playerID]
    if pPlayer == nil then return end
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    if pUnit == nil then return end
    local sCivName = PlayerConfigurations[playerID]:GetLeaderTypeName()         -- do traits
    local iPromoToGive
    local pUnitExp = pUnit:GetExperience()
    local iUnitIndex = pUnit:GetType()
    local sPromoClass = GameInfo.Units[iUnitIndex].PromotionClass
    if tSpiritual[sCivName] then
        iPromoToGive = tSpiritualPromos[sPromoClass]
        if iPromoToGive then
            pUnitExp:SetPromotion(iPromoToGive, true)
        end
    end

    local resources = pPlayer:GetResources()
    pUnit = pPlayer:GetUnits():FindID(unitID);
    pUnitAbilities = pUnit:GetAbility()
    if resources then                -- DealManager.GetPlayerDeals(0,1)[1]:FindItemByID(2):()
        if pUnitAbilities:HasAbility('ABILITY_DIVINE') then return; end                 -- if divine we ignore it
        local tCurrentResource = {}
        local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
        if pCapitalCity then
            local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
            local iResource
            local hasChannellingOne = pUnitAbilities:HasAbility('ABILITY_CHANNELING1')
            for sResourceName, iPromoIndex in pairs(tFreePromos) do
                iResource = pCapitalPlot:GetProperty(sResourceName) or 0;
                if iResource > 1 and hasChannellingOne then
                    pUnitExp:SetPromotion(iPromoIndex)
                end
                tCurrentResource[sResourceName] = iResource             -- CACHE it
            end
            local tWeaponResources = {
                ['RESOURCE_COPPER']    =    'ABILITY_BRONZE_WEAPONS',
                ['RESOURCE_IRON']      =    'ABILITY_IRON_WEAPONS',
                ['RESOURCE_MITHRIL']   =    'ABILITY_MITHRIL_WEAPONS'
            }

            for sResourceName, sAbilityToGrant in pairs(tWeaponResources) do
                iResource = pCapitalPlot:GetProperty(sResourceName) or 0;
                if iResource > 0 then
                    pUnitAbilities:AddAbilityCount(sAbilityToGrant)
                end
            end

            if hasChannellingOne then
                for sResourceName, iPromoIndex in pairs(tAllowSphereOne) do
                    iResource = tCurrentResource[sResourceName]
                    if iResource > 0 then                                                    -- grant sphere ability
                        pUnitExp:SetPromotion(iPromoIndex)
                    end
                end
            end
        end
    end
    -- complex tech and civic checks
    local pTechs = pPlayer:GetTechs()
    local pCulture = pPlayer:GetCulture()

    for iCheckPromo, tPossiblePromos in pairs(tConditionalUnlocks) do
        local hasPromo = pUnitExp:HasPromotion(iCheckPromo)
        if hasPromo then
            for _, tPromoInfo in ipairs(tPossiblePromos) do
                local promo_grant = tPromoInfo['promo_grant']
                if not pUnitExp:HasPromotion(promo_grant) then
                    local tech_req = tPromoInfo['tech']
                    local civic_req = tPromoInfo['civic']
                    local promo_extra = tPromoInfo['extra_promo']
                    local bar = 0
                    local score = 0
                    if tech_req then
                        bar = bar + 1
                        if pTechs:HasTech(tech_req) then
                            score = score + 1
                        end
                    end
                    if civic_req then
                        bar = bar + 1
                        if pCulture:HasCivic(civic_req) then
                            score = score + 1
                        end
                    end
                    if promo_extra then
                        bar = bar + 1
                        if pUnitExp:HasPromotion(promo_extra) then
                            score = score + 1
                        end
                    end

                    if bar == score then
                        print('passed promo gating')
                        pUnitExp:SetPromotion(promo_grant)
                    end
                end
            end
        end
    end
    -- simple checks
    for iTechIndex, iPromoIndex in pairs(tSciencePromoUnlocks) do
        if pTechs:HasTech(iTechIndex) then
            pUnitExp:SetPromotion(iPromoIndex)
            print('granting promo to unit by tech on spawn')
        end
    end

    for iCivicIndex, iPromoIndex in pairs(tCivicPromoUnlocks) do
        if pCulture:HasCivic(iCivicIndex) then
            pUnitExp:SetPromotion(iPromoIndex)
            print('granting promo to unit by civic on spawn')
        end
    end

    local tFreeUnitSpecificPromos = tUnitFreePromos[iUnitIndex]
    if tFreeUnitSpecificPromos then
        for i, iPromoIndex in pairs(tFreeUnitSpecificPromos) do
            pUnitExp:SetPromotion(iPromoIndex)
        end
    end

    -- weird checks for fear, for twincast

    -- SECTION Grant unit Religion
    -- deal with Encampment district issues
    -- if somehow not in a city, its a summon, implement that later (or dont even)?
    local sReligionAbility
    if not pUnit then print('UNIT NOT FOUND ON SPAWN BIG ERROR'); return; end
    local iUnitType = pUnit:GetType()                       -- check that the unit doesnt have a default religion
    local sInherentReligion = tInherentReligion[iUnitType]
    if sInherentReligion then
        GrantUnitReligion(pUnit, sInherentReligion)
        return;
    end
    local iX, iY = pUnit:GetLocation()
    local pPlot = Map.GetPlot(iX, iY)
    local pCity = Cities.GetPlotPurchaseCity(pPlot:GetIndex())

    if pCity then
        local tiReligions = City:GetReligion():GetReligionsInCity()
        if tiReligions then
            local CHANCE_OF_GRANT_RELIGION = 15                     -- TODO currently this will favour first table entries of religions
            for idx, val in ipairs(tiReligions) do                  --TODO needs testing to see what this table contains
                local iAttempt = math.random(0, 99)
                if iAttempt > CHANCE_OF_GRANT_RELIGION then
                    GrantUnitReligion(pUnit, val)
                    return
                end
            end
        end
    end
end

function GrantPromoPrereqFromCivicCompleted(playerID, civicIndex, isCancelled)
    local iPromoToGive = tCivicPromoUnlocks[civicIndex]
    if iPromoToGive then
        local pPlayer = Players[playerID]
        if not pPlayer then return end
        print('granting promo across techs')
        for idx, pUnit in pPlayer:GetUnits():Members() do
            local pUnitExp = pUnit:GetExperience()
            pUnitExp:SetPromotion(iPromoToGive, true)
            print('granting promo to unit by tech')
        end
    end
end

function GrantPromoPrereqFromTechCompleted(playerID, techIndex)
    local iPromoToGive = tSciencePromoUnlocks[techIndex]
    if iPromoToGive then
        local pPlayer = Players[playerID]
        if not pPlayer then return end
        print('granting promo across civics')
        for idx, pUnit in pPlayer:GetUnits():Members() do
            local pUnitExp = pUnit:GetExperience()
            pUnitExp:SetPromotion(iPromoToGive, true)
            print('granting promo to unit by civic')
        end
    end
end

function PostPromoGrant(playerID, unitID)
    -- table of promos. check has promo. check if has prerq, if so grant promoprereq
    local pPlayer = Players[playerID]
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    if not pUnit then print('CRITICAL: couldnt find unit after promoting'); return; end
    local pUnitExp = pUnit:GetExperience()
    local pTechs = pPlayer:GetTechs()
    local pCulture = pPlayer:GetCulture()
    local pUnitAbilities = pUnit:GetAbility()
    for iCheckPromo, tPossiblePromos in pairs(tConditionalUnlocks) do
        local hasPromo = pUnitExp:HasPromotion(iCheckPromo)
        if hasPromo then
            for _, tPromoInfo in ipairs(tPossiblePromos) do
                local promo_grant = tPromoInfo['promo_grant']
                if not pUnitExp:HasPromotion(promo_grant) then
                    local tech_req = tPromoInfo['tech']
                    local civic_req = tPromoInfo['civic']
                    local promo_extra = tPromoInfo['extra_promo']
                    local sAbility_req = tPromoInfo['ability']
                    local bar = 0
                    local score = 0
                    if tech_req then
                        bar = bar + 1
                        if pTechs:HasTech(tech_req) then
                            score = score + 1
                        end
                    end
                    if civic_req then
                        bar = bar + 1
                        if pCulture:HasCivic(civic_req) then
                            score = score + 1
                        end
                    end
                    if promo_extra then
                        bar = bar + 1
                        if pUnitExp:HasPromotion(promo_extra) then
                            score = score + 1
                        end
                    end

                    if sAbility_req then
                        bar = bar + 1
                        if pUnitAbilities:HasAbility(sAbility_req) then
                            score = score + 1
                        end
                    end

                    if bar == score then
                        print('passed promo gating. Granting : ' .. GameInfo.UnitPromotions[promo_grant].Name)
                        pUnitExp:SetPromotion(promo_grant)
                    end
                end
            end
        end
    end
    -- SECTION: experience overflow
    local iReservedExperience = pUnit:GetProperty('reservedExperience')
    if not iReservedExperience then                     -- on first promotion, define exp overflow property
        local freeExpAmount = 0
        for sExperienceGrantingAbility, amount in pairs(tExperienceAbilities) do
            print('checking: ' .. sExperienceGrantingAbility)
            if pUnitAbilities:HasAbility(sExperienceGrantingAbility) then
                freeExpAmount = freeExpAmount + amount
                print('Has ' .. sExperienceGrantingAbility .. '. So grant this much reserved xp: ' .. tostring(amount))
            end
        end
        iReservedExperience = freeExpAmount - 15
        if iReservedExperience < 0 then
            iReservedExperience = 0
        end
        pUnit:SetProperty('reservedExperience', iReservedExperience)
        -- currently acting like you always get a free promo. this is kinda bad ugh.
        -- Maybe can check for uses of FreePromotion abilities / unit is of the type it gets a freePromo.
        -- make sure not to use -1 for granting experience.
    end
    print('checking after promotion if unit needs granting extra xp')
    local iExperienceNeeded = pUnitExp:GetExperienceForNextLevel()
    local iCurrentExperience = pUnitExp:GetExperiencePoints()
    local iNeededExperience = iExperienceNeeded - iCurrentExperience
    print('Experience needed on this level: ' .. tostring(iExperienceNeeded) .. '. Current experience is: ' .. tostring(iCurrentExperience) .. '. required: '.. tostring(iNeededExperience))
    if iReservedExperience > 0 and iNeededExperience > 0 then
        print('it does need extra xp. Granting this much ' .. tostring(iNeededExperience) .. ' from reserves ' .. tostring(iReservedExperience))
        if iReservedExperience > iExperienceNeeded then
            iReservedExperience = iReservedExperience - iExperienceNeeded
            pUnitExp:ChangeExperience(iExperienceNeeded)
        else
            pUnitExp:ChangeExperience(iReservedExperience)
            iReservedExperience = 0
        end
        pUnit:SetProperty('reservedExperience', iReservedExperience)
    end

end


GameEvents.UnitCreated.Add(onSpawnApplyPromotions)       -- not arcane or spiritual as implemented do as abilities that lua picks up on
Events.CivicCompleted.Add(GrantPromoPrereqFromCivicCompleted)
Events.ResearchCompleted.Add(GrantPromoPrereqFromTechCompleted)
Events.UnitPromoted.Add(PostPromoGrant)
print('----------------- Promotions Lua Loaded --------------------------------')
