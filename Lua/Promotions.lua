
function onSpawnApplyPromotions(playerID, unitID)
    if playerID == nil then return end
    if unitID == nil then return end
    pPlayer = Players[playerID]
    if pPlayer == nil then return end
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    if pUnit == nil then return end
    local sCivName = PlayerConfigurations[playerID]:GetLeaderTypeName()         -- do traits
    local sPromoClass
    local iPromoToGive
    local pUnitExp
    if tAggressive[sCivName] then
        sPromoClass = GameInfo.Units[pUnit:GetUnitType()].PromotionClass
        iPromoToGive = tAggressivePromos[sPromoClass]
        if iPromoToGive then
            pUnitExp = pUnit:GetExperience()
            pUnitExp:SetPromotion(iPromoToGive, true)
        end
    end;

    if tSpiritual[sCivName] then
        sPromoClass = GameInfo.Units[pUnit:GetUnitType()].PromotionClass
        iPromoToGive = tSpiritualPromos[sPromoClass]
        if iPromoToGive then
            pUnitExp = pUnit:GetExperience()
            pUnitExp:SetPromotion(iPromoToGive, true)
        end
    end

    local pPlayer = Players[playerID]
    local resources = pPlayer:GetResources()
    if resources then                -- DealManager.GetPlayerDeals(0,1)[1]:FindItemByID(2):()
        pUnit = pPlayer:GetUnits():FindID(unitID);
        local pUnitExperience = pUnit:GetExperience()
        local pUnitAbilities = pUnit:GetAbility()
        for iResourceIndex, iPromoIndex in ipairs(tFreePromos) do
            local iResource = resources:GetResourceAmount(iResourceIndex) or 0;
            if iResource > 1 then
                pUnitExperience:SetPromotion(iPromoIndex)
            end
        end
        if pUnitAbilities:HasAbility('ABILITY_DIVINE') then return; end                 -- if divine we ignore it
        local tHasResource = {}
        if pUnitAbilities:HasAbility('ABILITY_CHANNELING1') then
            for iResourceIndex, iPromoIndex in ipairs(tAllowSphereOne) do
                local iResource = resources:GetResourceAmount(iResourceIndex) or 0;      -- absolutely doesnt work on imported resources
                if iResource > 0 then                                                    -- grant sphere ability
                    pUnitExperience:SetPromotion(iPromoIndex)           -- choose relevant promotion index, currently scout
                    tHasResource[iResourceIndex] = 1
                end
            end
        end
        if pUnitAbilities:HasAbility('ABILITY_CHANNELING2') then
             for iResourceIndex, iPromoIndex in ipairs(tAllowSphereTwo) do
                 if tHasResource[iResourceIndex] > 0 then
                     pUnitExperience:SetPromotion(iPromoIndex)
                 end
            end
        end
        if pUnitAbilities:HasAbility('ABILITY_CHANNELING3') then
            for iResourceIndex, iPromoIndex in ipairs(tAllowSphereThree) do
                 if tHasResource[iResourceIndex] > 0 then
                     pUnitExperience:SetPromotion(iPromoIndex)
                 end
            end
        end
    end
end

function OnStart()
    tAggressive = {'SLTH_LEADER_ALEXIS', 'SLTH_LEADER_BASIUM', 'SLTH_LEADER_CHARADON', 'SLTH_LEADER_KANDROS',
'SLTH_LEADER_SHEELBA', 'SLTH_LEADER_TASUNKE'}
    tAggressivePromos = {['PROMOTION_CLASS_MELEE']=GameInfo.UnitPromotions['PROMOTION_COMBAT1_MELEE'].Index,
                        ['PROMOTION_CLASS_LIGHT_CAVALRY']=GameInfo.UnitPromotions['PROMOTION_COMBAT1_LIGHT_CAVALRY'].Index}

    tSpiritual = {'SLTH_LEADER_ARENDEL', 'SLTH_LEADER_AURIC', 'SLTH_LEADER_CAPRIA', 'SLTH_LEADER_JONAS',
    'SLTH_LEADER_OS-GABELLA', 'SLTH_LEADER_VARN'}

    tSpiritualPromos = {['PROMOTION_CLASS_DISCIPLE']=GameInfo.UnitPromotions['PROMOTION_MOBILITY1_DISCIPLE'].Index}

    tAllowSphereOne = {
            [GameInfo.Resources['RESOURCE_MANA_AIR'].Index]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_BODY'].Index]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index]        =    GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_LAW'].Index]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_MIND'].Index]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SUN'].Index]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED'].Index,
            [GameInfo.Resources['RESOURCE_MANA_WATER'].Index]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED'].Index
        }

    tAllowSphereTwo = {
            [GameInfo.Resources['RESOURCE_MANA_AIR'].Index]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_BODY'].Index]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index]=    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_LAW'].Index]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_MIND'].Index]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SUN'].Index]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_2'].Index,
            [GameInfo.Resources['RESOURCE_MANA_WATER'].Index]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_2'].Index
        }

    tAllowSphereThree = {
            [GameInfo.Resources['RESOURCE_MANA_AIR'].Index]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_BODY'].Index]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index]=    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_LAW'].Index]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_MIND'].Index]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SUN'].Index]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_3'].Index,
            [GameInfo.Resources['RESOURCE_MANA_WATER'].Index]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_3'].Index
        }

    tFreePromos = {
            [GameInfo.Resources['RESOURCE_MANA_AIR'].Index]        =    GameInfo.UnitPromotions['AIR_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_BODY'].Index]        =    GameInfo.UnitPromotions['BODY_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index]        =    GameInfo.UnitPromotions['CHAOS_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index]        =    GameInfo.UnitPromotions['DEATH_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index]        =    GameInfo.UnitPromotions['EARTH_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index]=    GameInfo.UnitPromotions['DEATH_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index]        =    GameInfo.UnitPromotions['ENTROPY_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index]        =    GameInfo.UnitPromotions['FIRE_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_LAW'].Index]        =    GameInfo.UnitPromotions['LAW_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index]        =    GameInfo.UnitPromotions['LIFE_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index]        =    GameInfo.UnitPromotions['METAMAGIC_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_MIND'].Index]        =    GameInfo.UnitPromotions['MIND_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index]        =    GameInfo.UnitPromotions['NATURE_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index]        =    GameInfo.UnitPromotions['SHADOW_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index]        =    GameInfo.UnitPromotions['SPIRIT_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_SUN'].Index]        =    GameInfo.UnitPromotions['SUN_ONE'].Index,
            [GameInfo.Resources['RESOURCE_MANA_WATER'].Index]        =    GameInfo.UnitPromotions['WATER_ONE'].Index
        }
end

onStart()

Events.UnitCreated.Add(onSpawnApplyPromotions)       -- not arcane or spiritual as implemented do as abilities that lua picks up on
