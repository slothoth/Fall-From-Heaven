
function onSpawnApplyPromotions(playerID, unitID)
    if playerID == nil then return end
    if unitID == nil then return end
    pPlayer = Players[playerID]
    if pPlayer == nil then return end
    local pUnit = pPlayer:GetUnits():FindID(unitID)
    if pUnit == nil then return end
    local sCivName = PlayerConfigurations[playerID]:GetLeaderTypeName()
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
end

Events.UnitAddedToMap.Add(onSpawnApplyPromotions)       -- not arcane or spiritual as implemented do as abilities that lua picks up on

tAggressive = {'SLTH_LEADER_ALEXIS', 'SLTH_LEADER_BASIUM', 'SLTH_LEADER_CHARADON', 'SLTH_LEADER_KANDROS',
'SLTH_LEADER_SHEELBA', 'SLTH_LEADER_TASUNKE'}
tAggressivePromos = {['PROMOTION_CLASS_MELEE']=GameInfo.UnitPromotions['PROMOTION_COMBAT1_MELEE'].Index,
                     ['PROMOTION_CLASS_LIGHT_CAVALRY']=GameInfo.UnitPromotions['PROMOTION_COMBAT1_LIGHT_CAVALRY'].Index}

tSpiritual = {'SLTH_LEADER_ARENDEL', 'SLTH_LEADER_AURIC', 'SLTH_LEADER_CAPRIA', 'SLTH_LEADER_JONAS',
'SLTH_LEADER_OS-GABELLA', 'SLTH_LEADER_VARN'}

tSpiritualPromos = {['PROMOTION_CLASS_DISCIPLE']=GameInfo.UnitPromotions['PROMOTION_MOBILITY1_DISCIPLE'].Index}