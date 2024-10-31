local tSpiritual = {['SLTH_LEADER_ARENDEL']=1, ['SLTH_LEADER_AURIC']=1, ['SLTH_LEADER_CAPRIA']=1, ['SLTH_LEADER_JONAS']=1,
            ['SLTH_LEADER_OS-GABELLA']=1, ['SLTH_LEADER_VARN']=1}

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

function onSpawnApplyPromotions(playerID, unitID)
    if playerID == nil then return end
    if unitID == nil then return end
    local pPlayer = Players[playerID]
    if pPlayer == nil then return end
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    if pUnit == nil then return end
    local sCivName = PlayerConfigurations[playerID]:GetLeaderTypeName()         -- do traits
    local sPromoClass
    local iPromoToGive
    local pUnitExp = pUnit:GetExperience()
    if tSpiritual[sCivName] then
        sPromoClass = GameInfo.Units[pUnit:GetType()].PromotionClass
        iPromoToGive = tSpiritualPromos[sPromoClass]
        if iPromoToGive then
            pUnitExp:SetPromotion(iPromoToGive, true)
        end
    end

    local resources = pPlayer:GetResources()
    if resources then                -- DealManager.GetPlayerDeals(0,1)[1]:FindItemByID(2):()
        pUnit = pPlayer:GetUnits():FindID(unitID);
        local pUnitAbilities = pUnit:GetAbility()
        if pUnitAbilities:HasAbility('ABILITY_DIVINE') then return; end                 -- if divine we ignore it
        local tCurrentResource = {}
        local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
        local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
        local iResource
        for sResourceName, iPromoIndex in pairs(tFreePromos) do
            iResource = pCapitalPlot:GetProperty(sResourceName) or 0;
            if iResource > 1 then
                pUnitExp:SetPromotion(iPromoIndex)
            end
            tCurrentResource[sResourceName] = iResource             -- CACHE it
        end

        if pUnitAbilities:HasAbility('ABILITY_CHANNELING1') then
            for sResourceName, iPromoIndex in pairs(tAllowSphereOne) do
                iResource = tCurrentResource[sResourceName]
                if iResource > 0 then                                                    -- grant sphere ability
                    pUnitExp:SetPromotion(iPromoIndex)
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

    -- weird checks for fear, for twincast
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
end


GameEvents.UnitCreated.Add(onSpawnApplyPromotions)       -- not arcane or spiritual as implemented do as abilities that lua picks up on
Events.CivicCompleted.Add(GrantPromoPrereqFromCivicCompleted)
Events.ResearchCompleted.Add(GrantPromoPrereqFromTechCompleted)
Events.UnitPromoted.Add(PostPromoGrant)
print('----------------- Promotions Lua Loaded --------------------------------')
