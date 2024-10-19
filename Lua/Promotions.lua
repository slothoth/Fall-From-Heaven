
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

local tAllowSphereTwo = {
        ['RESOURCE_MANA_AIR']        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_BODY']        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_CHAOS']        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_DEATH']        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_EARTH']        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_ENCHANTMENT']=    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_ENTROPY']        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_FIRE']        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_LAW']        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_LIFE']        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_METAMAGIC']        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_MIND']        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_NATURE']        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_SHADOW']        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_SPIRIT']        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_SUN']        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_2'].Index,
        ['RESOURCE_MANA_WATER']        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_2'].Index
    }

local tAllowSphereThree = {
        ['RESOURCE_MANA_AIR']        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_BODY']        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_CHAOS']        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_DEATH']        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_EARTH']        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_ENCHANTMENT']=    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_ENTROPY']        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_FIRE']        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_LAW']        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_LIFE']        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_METAMAGIC']        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_MIND']        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_NATURE']        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_SHADOW']        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_SPIRIT']        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_SUN']        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_3'].Index,
        ['RESOURCE_MANA_WATER']        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_3'].Index
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
    [GameInfo.UnitPromotions['PROMOTION_EXTENSION1_ADEPT'].Index]={tech=GameInfo.Technologies['TECH_ARCANE_LORE'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ARCANE_LORE'].Index},
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_MELEE'].Index]={{civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WICKED'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WICKED'].Index},
                                                                {civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WISE'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WISE'].Index}
    },
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_BEAST'].Index]={{civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WICKED'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WICKED'].Index},
                                                                {civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WISE'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WISE'].Index}
    },
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_RECON'].Index]={{civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WICKED'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WICKED'].Index},
                                                                {tech=GameInfo.Technologies['TECH_ANIMAL_HUSBANDRY'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ANIMAL_HUSBANDRY'].Index}
    },
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_DISCIPLE'].Index]={{civic=GameInfo.Civics['CIVIC_WAY_OF_THE_WISE'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WISE'].Index}},

    [GameInfo.UnitPromotions['PROMOTION_DRILL4_MELEE'].Index]={{civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_MELEE'].Index} },
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_BEAST'].Index]={{civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_BEAST'].Index} },
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_RECON'].Index]={{civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_RECON'].Index }},
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_DISCIPLE'].Index]={{civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_DISCIPLE'].Index}},
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_LIGHT_CAVALRY'].Index] = {{civic=GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_BLITZ_LIGHT_CAVALRY'].Index }},
    [GameInfo.UnitPromotions['PROMOTION_DRILL4_RANGED'].Index]= { { civic = GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index, promo_grant = GameInfo.UnitPromotions['PROMOTION_BLITZ_RANGED'].Index}},

    [GameInfo.UnitPromotions['PROMOTION_WOODSMAN1_BEAST'].Index]={{civic=GameInfo.Civics['CIVIC_HIDDEN_PATHS'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_HIDDEN_PATHS'].Index} },
    [GameInfo.UnitPromotions['PROMOTION_WOODSMAN1_RECON'].Index]={{civic=GameInfo.Civics['CIVIC_HIDDEN_PATHS'].Index, promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_HIDDEN_PATHS'].Index }},
    [GameInfo.UnitPromotions['PROMOTION_COMBAT3_RECON'].Index]={{civic=GameInfo.Technologies['TECH_ANIMAL_MASTERY'].Index, extra_promo=GameInfo.UnitPromotions['PROMOTION_SUBDUE_ANIMAL_RECON'].Index,
                                                                 promo_grant=GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ANIMAL_MASTERY'].Index }},
}

-- not implemented as reversible
local tPolicyUnlocks ={
    GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ORDER_STATE'].Index ,
    GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ARETE'].Index
}

local tHasPromoAndUnlocks = {
    [GameInfo.UnitPromotions['PROMOTION_CAN_GET_FEAR'].Index] = 1,
    [GameInfo.UnitPromotions['PROMOTION_IS_HERO_COMBATV'].Index] = 1}

function onSpawnApplyPromotions(playerID, unitID)
    if not playerID  then return end
    if not unitID then return end
    local pPlayer = Players[playerID]
    if not pPlayer then return end
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    if not pUnit  then return end
    local pUnitExp = pUnit:GetExperience()
    -- complex tech and civic checks
    local pTechs = pPlayer:GetTechs()
    local pCulture = pPlayer:GetCulture()

    for iCheckPromo, tPromoInfo in pairs(tConditionalUnlocks) do
        local hasPromo = pUnitExp:HasPromotion(iCheckPromo)
        if hasPromo then
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
    -- weird checks for fear, for twincast
end

function PostPromoGrant(playerID, unitID)
    -- table of promos. check has promo. check if has prerq, if so grant promoprereq
    local pPlayer = Players[playerID]
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    local pUnitExp = pUnit:GetExperience()
    local pTechs = pPlayer:GetTechs()
    local pCulture = pPlayer:GetCulture()
    for iCheckPromo, tPromoInfo in pairs(tConditionalUnlocks) do
        local hasPromo = pUnitExp:HasPromotion(iCheckPromo)
        if hasPromo then
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


GameEvents.UnitCreated.Add(onSpawnApplyPromotions)       -- not arcane or spiritual as implemented do as abilities that lua picks up on
Events.CivicCompleted.Add(GrantPromoPrereqFromCivicCompleted)
Events.ResearchCompleted.Add(GrantPromoPrereqFromTechCompleted)
Events.UnitPromoted.Add(PostPromoGrant)
print('----------------- Promotions Lua Loaded --------------------------------')
