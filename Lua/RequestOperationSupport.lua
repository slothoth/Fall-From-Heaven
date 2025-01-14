local function SetCapitalProperty(iPlayer, tParameters)
    local sPropKey = tParameters.sPropKey;
    local iPropValue = tParameters.iPropValue;
    local pPlayer = Players[iPlayer];
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    local pCapitalPlot = pCapitalCity:GetPlot()
    pCapitalPlot:SetProperty(sPropKey, iPropValue)
end

local function SetPlayerProperty(iPlayer, tParameters)
    local sPropKey = tParameters.sPropKey;
    local iPropValue = tParameters.iPropValue;
    local pPlayer = Players[iPlayer];
    pPlayer:SetProperty(sPropKey, iPropValue)
    print('set '.. sPropKey .. 'to ' .. iPropValue)
end

local function OnSummon(iPlayer, tParameters)
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local iUnitToSummon = GameInfo.Units[OperationInfo.SimpleText].Index
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local pUnitExp = pUnit:GetExperience()
    local pUnitAbility = pUnit:GetAbility()
    local tNewUnits = BaseSummon(pUnit, iPlayer, iUnitToSummon)
    for iUnitID, pNewUnit in pairs(tNewUnits) do
        print(OperationInfo.SimpleText)
        pUnit:SetProperty(OperationInfo.SimpleText, iUnitID)                -- used to link summoner and summoned
        pNewUnit:SetProperty('owner', tParameters.iCastingUnit)             -- used to link summoner and summoned
        if pNewUnit:GetProperty('LifespanRemaining') == 1 then
            if pUnitAbility:HasAbility('SLTH_ABILITY_SUMMONER') then
                pNewUnit:SetProperty('LifespanRemaining', 2)                -- set duration
            else
                pNewUnit:SetProperty('LifespanRemaining', 1)
            end
        end
        InheritSummon(pNewUnit, pUnitExp, pUnitAbility)
    end
    pUnit:SetProperty('HasCast', 1)
end

local tPromoCombat = {
    [GameInfo.UnitPromotions['PROMOTION_COMBAT1_ADEPT'].Index] = 1,
    [GameInfo.UnitPromotions['PROMOTION_COMBAT2_ADEPT'].Index] = 1,
    [GameInfo.UnitPromotions['PROMOTION_COMBAT3_ADEPT'].Index] = 1,
    [GameInfo.UnitPromotions['PROMOTION_COMBAT4_ADEPT'].Index] = 1,
    [GameInfo.UnitPromotions['PROMOTION_COMBAT5_ADEPT'].Index] = 1,
}

local SUMMONER_PROMOTION_IDX = GameInfo.UnitPromotions['PROMOTION_SUMMONER_ADEPT'].Index

function InheritSummon(pSummonedUnit, pSummonerUnitExp, pSummonerUnitAbility)
    local pSummonUnitAbility = pSummonedUnit:GetAbility()
    if pSummonerUnitAbility:HasAbility('SLTH_ABILITY_SUMMONER') or pSummonerUnitExp:HasPromotion(SUMMONER_PROMOTION_IDX) then
        pSummonUnitAbility:AddAbilityCount('ABILITY_SUMMONER_INHERITED_STRENGTH')
        -- also work out a way to add an additional turn of duration
        local lifespan = pSummonedUnit:GetProperty('LIFESPAN') or 1
        pSummonedUnit:SetProperty('LIFESPAN', lifespan + 1)
    end

    for iPromoCombatIndex, _ in pairs(tPromoCombat) do
        if pSummonerUnitExp:HasPromotion(iPromoCombatIndex) then
            pSummonUnitAbility:AddAbilityCount('ABILITY_SUMMONER_INHERITED_STRENGTH')
        end
    end
end

local function OnSummonPermanent(iPlayer, tParameters)
    print('in summon permanent')
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local iUnitToSummon = GameInfo.Units[OperationInfo.SimpleText].Index
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iCheckExistingUnit = pUnit:GetProperty(OperationInfo.SimpleText)
    local pUnitExp = pUnit:GetExperience()
    local pUnitAbility = pUnit:GetAbility()
    print(iCheckExistingUnit)
    if iCheckExistingUnit then
        local pUnitPrecursor = UnitManager.GetUnit(iPlayer, iCheckExistingUnit);
        if pUnitPrecursor then return end
    end
    local tNewUnits = BaseSummon(pUnit, iPlayer, iUnitToSummon)
    for iUnitID, pNewUnit in pairs(tNewUnits) do
        print('set inherited abilities here')
        print(OperationInfo.SimpleText)
        pUnit:SetProperty(OperationInfo.SimpleText, iUnitID)                -- used to link summoner and summoned. todo breaks on twinspell
        pNewUnit:SetProperty('owner', tParameters.iCastingUnit)             -- used to link summoner and summoned
        InheritSummon(pNewUnit, pUnitExp, pUnitAbility)
    end
    pUnit:SetProperty('HasCast', 1)
end

local function OnGrantBuffSelf(iPlayer, tParameters)
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local pAbilityUnit = pUnit:GetAbility()
    if not pAbilityUnit:HasAbility(OperationInfo.SimpleText) then
        pAbilityUnit:AddAbilityCount(OperationInfo.SimpleText)
        if transientBuffKeys[OperationInfo.SimpleText] then
            local sPropbuff_propkey = OperationInfo.SimpleText .. ('_UNITS')
            local tSpecificBuffState = Game:GetProperty(sPropbuff_propkey) or {}
            local tUnitInfos = {iPlayer=iPlayer, iUnit=tParameters.iCastingUnit, iCasterPlayer=iPlayer}
            table.insert(tSpecificBuffState, tUnitInfos)
            Game:SetProperty(sPropbuff_propkey, tSpecificBuffState)
        end
    end
    pUnit:SetProperty('HasCast', 1)
end

local function OnGrantBuffAoe(iPlayer, tParameters)
    local pAbilityUnit
    local tSpecificBuffState
    local sPropbuff_propkey
    local bBuffPropKeyChange
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
    if transientBuffKeys[OperationInfo.SimpleText] then
        sPropbuff_propkey = OperationInfo.SimpleText .. ('_UNITS')
        tSpecificBuffState = Game:GetProperty(sPropbuff_propkey) or {}
    end
    for _, plot in ipairs(tNeighborPlots) do
        for _, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
            if pNearUnit then
                local iOwnerPlayer = pNearUnit:GetOwner();
                if (iOwnerPlayer == iPlayer) then
                    pAbilityUnit = pNearUnit:GetAbility()
                    if not pAbilityUnit:HasAbility(OperationInfo.SimpleText) then
                        pAbilityUnit:AddAbilityCount(OperationInfo.SimpleText)
                        if transientBuffKeys[OperationInfo.SimpleText] then
                            local iUnit = pNearUnit:GetID()
                            local tUnitInfos = {iPlayer=iPlayer, iUnit=iUnit, iCasterPlayer=iPlayer}
                            table.insert(tSpecificBuffState, tUnitInfos)
                            bBuffPropKeyChange = true
                        end
                    end
                end
            end
        end
    end
    pUnit:SetProperty('HasCast', 1)
    if bBuffPropKeyChange then
        Game:SetProperty(sPropbuff_propkey, tSpecificBuffState)
    end
end

local function OnGrantDebuffAoe(iPlayer, tParameters)
    local pAbilityUnit
    local tSpecificBuffState
    local sPropbuff_propkey
    local bBuffPropKeyChange
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
    for _, plot in ipairs(tNeighborPlots) do
        for _, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
            if pNearUnit then
                local iOwnerPlayer = pNearUnit:GetOwner();
                if (iOwnerPlayer ~= iPlayer) then
                    pAbilityUnit = pNearUnit:GetAbility()
                    if not pAbilityUnit:HasAbility(OperationInfo.SimpleText) then
                        pAbilityUnit:AddAbilityCount(OperationInfo.SimpleText)
                        if transientBuffKeys[OperationInfo.SimpleText] then
                            local iUnit = pNearUnit:GetID()
                            local tUnitInfos = {iPlayer=iOwnerPlayer, iUnit=iUnit, iCasterPlayer=iPlayer}
                            table.insert(tSpecificBuffState, tUnitInfos)
                            bBuffPropKeyChange = true
                        end
                    end
                end
            end
        end
    end
    pUnit:SetProperty('HasCast', 1)
    if bBuffPropKeyChange then
        Game:SetProperty(sPropbuff_propkey, tSpecificBuffState)
    end
end

local function OnSpellChangeTerrain(iPlayer, tParameters)
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local pPlot = Map.GetPlot(iX, iY)
    local iCurrentTerrain = pPlot:GetTerrainType()
    local TerrainTransformInfo = GameInfo.TerrainTransforms[iCurrentTerrain]
    local sSpellType = OperationInfo.SimpleText
    local attempt = TerrainTransformInfo[sSpellType]
    print(attempt)
    local iNewTerrain = TerrainTransformInfo.sSpellType
    if iNewTerrain then
        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
    end
    pUnit:SetProperty('HasCast', 1)
end

local function OnSpellAoeDamage(iPlayer, tParameters)
    local pAbilityUnit
    local tagInfo
    local iNewTerrain
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
    local iDamage = OperationInfo.SecondAmount
    for _, plot in ipairs(tNeighborPlots) do
        for _, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
            if (pNearUnit) then
                local iOwnerPlayer = pNearUnit:GetOwner();
                if (iOwnerPlayer ~= iPlayer) then
                    if Players[iPlayer]:GetDiplomacy():IsAtWarWith(iOwnerPlayer) then
                        tagInfo = true
                        local UnitTypeInfo = GameInfo.Units[pNearUnit:GetType()]
                        if OperationInfo.SimpleText == 'IS_UNDEAD' then
                            tagInfo = GameInfo.TypeTags[{UnitTypeInfo.UnitType, 'IS_UNDEAD'}]
                        end
                        if (UnitTypeInfo.Combat ~= 0 and UnitTypeInfo.Domain ~= "DOMAIN_AIR") and tagInfo then
                            pNearUnit:ChangeDamage(iDamage);
                            if pNearUnit:GetDamage() >= 100 then
                                UnitManager.Kill(pNearUnit, false);
                            else
                                if OperationInfo.SimpleText == 'WITHERED' then
                                    pAbilityUnit = pNearUnit:GetAbility()
                                    if not pAbilityUnit:HasAbility(OperationInfo.SimpleText) then
                                        pAbilityUnit:AddAbilityCount(OperationInfo.SimpleText)
                                    end
                                end
                            end
                            if OperationInfo.SimpleText == 'TERRAIN_SNOW' then
                                local pPlot = Map.GetPlot(iX, iY)
                                local iCurrentTerrain = pPlot:GetTerrainType()
                                if pPlot:IsHills() then
                                    iNewTerrain = iSnowTerrainHills
                                    if iCurrentTerrain ~= iNewTerrain then
                                        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                                    end
                                elseif pPlot:IsMountain() then
                                    iNewTerrain = GameInfo.Terrains['TERRAIN_SNOW_MOUNTAIN'].Index
                                    if iCurrentTerrain ~= iNewTerrain then
                                        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                                    end
                                else
                                    iNewTerrain = iSnowTerrain
                                    if iCurrentTerrain ~= iNewTerrain then
                                        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    pUnit:SetProperty('HasCast', 1)
end

local function GrantGoldenAge(iPlayer, tParameters)
    local pPlayer = Players[iPlayer]
    local iUniqueGreatPeopleRequirement = pPlayer:GetProperty('GreatPeopleGoldenRequirement') or 1
    local t_iUnits = {}
    t_iUnits[1] = tParameters.iCastingUnit                      -- set to just the owner for now
    for iUnitType, iUnitID in pairs(t_iUnits) do
        local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
        UnitManager.Kill(pUnit);
    end
    local eGameSpeed = GameConfiguration.GetGameSpeedType()            -- this is actually a hash not a string return. But cant find the enum for it
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier
    local iGoldenAgeLength = math.floor(20 * iSpeedCostMultiplier)
    GoldenAgeGrant(pPlayer, iGoldenAgeLength)                                                             -- should scale by speed
    pPlayer:SetProperty('GreatPeopleGoldenRequirement', iUniqueGreatPeopleRequirement + 1)
end

local function GoldenAgeGrant(pPlayer, iGoldenDuration)
    for _, pCity in pPlayer:GetCities():Members() do
        local pPlot = pCity:GetPlot();
        if pPlot then
            pPlot:SetProperty('InGoldenAge', 1);		-- but =function expected instead of nil?
        end
    end
    pPlayer:SetProperty('GoldenAgeDuration', (pPlayer:GetProperty('GoldenAgeDuration') or 0) + iGoldenDuration)
end



local function ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
    for _, pNewUnit in pairs(tNewUnits) do
        pNewUnit:SetDamage(iHealth)
        local pUnitExp = pNewUnit:GetExperience()
        local pUnitAbilities = pNewUnit:GetAbility()
        for _, iUnitPromotionIndex in ipairs(tPromos) do
            if not pUnitExp:HasPromotion(iUnitPromotionIndex) then
                pUnitExp:SetPromotion(iUnitPromotionIndex)
            end
        end
        for _, sAbility in ipairs(tAbilities) do
            if not pUnitAbilities:HasAbility(sAbility) then
                pUnitAbilities:AddAbilityCount(sAbility)
            end
        end
    end
end

local tBuildingGrantModiferMap = {
    ['SLTH_BUILDING_CODE_OF_JUNIL'] = 'SLTH_MODIFIER_GRANT_CODE_OF_JUNIL',
    ['BUILDING_ANGKOR_WAT'] = 'SLTH_MODIFIER_GRANT_DIES_DEI',
    ['SLTH_BUILDING_TABLETS_OF_BAMBUR'] = 'SLTH_MODIFIER_GRANT_TABLETS_OF_BAMBUR',
    ['SLTH_BUILDING_SONG_OF_AUTUMN'] = 'SLTH_MODIFIER_GRANT_SONG_OF_AUTUMN',
    ['SLTH_BUILDING_THE_NECRONOMICON'] = 'SLTH_MODIFIER_GRANT_THE_NECRONOMICON',
    ['SLTH_BUILDING_NOX_NOCTIS'] = 'SLTH_MODIFIER_GRANT_NOX_NOCTIS',
    ['SLTH_BUILDING_STIGMATA_ON_THE_UNBORN'] = 'SLTH_MODIFIER_GRANT_STIGMATA_ON_THE_UNBORN'
}

local function GrantBuildingFunction(iPlayer, tParameters)
    local iUnit = tParameters.iCastingUnit
    local sUnitOperationType =  tParameters.UnitOperationType
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local sModifierGrant = tBuildingGrantModiferMap[OperationInfo.SimpleText]
    if not sModifierGrant then print('building didnt have a modifier grant mapping, returning..'); return; end
    print(sModifierGrant)
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local pCity = Cities.GetCityInPlot(iX, iY)
    pCity:AttachModifierByID(sModifierGrant);
    UnitManager.Kill(pUnit);
end

local function GrantSuperSpecialist(iPlayer, tParameters)
    local iUnit = tParameters.iCastingUnit
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local iUnitType = pUnit:GetType();
    local pCity = Cities.GetCityInPlot(iX, iY)
    for _, sModifier in ipairs(tSuperSpecialistModifiers[iUnitType]) do
        pCity:AttachModifierByID(sModifier)									-- maybe do binary magic and plotProp
    end
    for _, sModifier in ipairs(tSuperSpecialistGenericModifiers) do
        pCity:AttachModifierByID(sModifier)
    end
    UnitManager.Kill(pUnit);
end

local function ConsumeAlly(iPlayer, tParameters)
    print('consuming ally')
    local iUnit = tParameters.iCastingUnit
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
    local iConsumeUnitID = tParameters.iTargetID
    local sUnitOperationType =  tParameters.UnitOperationType
    if sUnitOperationType == 'UNITOPERATION_CONSUME_BLOODPET' then
        local pConsumeUnit = UnitManager.GetUnit(iPlayer, iConsumeUnitID);
        local iUnitType = pConsumeUnit:GetType();
        if iUnitType == GameInfo.Units['UNIT_WARRIOR'].Index then
            UnitManager.RestoreMovement(pUnit)
            UnitManager.RestoreUnitAttacks(pUnit)
            UnitManager.Kill(pConsumeUnit);
        end
    elseif sUnitOperationType == 'UNITOPERATION_ABSORB_UNIT' then
        print('placeholder, flesh golem grafts seem painful.')
    else
        print('no behaviour defined for this UnitOp on ConsumeAlly: ' .. sUnitOperationType)
    end
end

local tEquipmentOps = {
    ['SLTH_EQUIPMENT_ATHAME_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index,
    ['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index,
    ['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index,
    ['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index,
    ['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index,
    ['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index,
    ['SLTH_EQUIPMENT_GELA_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index,
    ['SLTH_EQUIPMENT_GODSLAYER_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index,
    ['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index,
    ['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index,
    ['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index,
    ['SLTH_EQUIPMENT_JADE_TORC_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index,
    ['SLTH_EQUIPMENT_MOKKA_CAULDRON_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_MOKKA_CAULDRON_ABILITY'].Index,
    ['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index,
    ['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index,
    ['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index,
    ['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index,
    ['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index,
    ['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index,
    ['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index,
    ['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index,
    ['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index,
    ['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index,
    ['SLTH_EQUIPMENT_WAR_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index,
    ['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'].Index}

local function UnitCityInteract(iPlayer, tParameters)
    local iUnit = tParameters.iCastingUnit
    local sUnitOperationType =  tParameters.UnitOperationType
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local sOperationAbility = OperationInfo.AbilityPrereq
    if sUnitOperationType == 'UNITOPERATION_LOKI_DISRUPT_CITY' then
        print('Causes unhappiness. Decreases city Culture. Converts citys without culture.')
    elseif sUnitOperationType == 'UNITOPERATION_LOKI_ENTERTAIN_CITY' then
        print('placeholder, grant gold to casting unit and amenity to city casted in for a turn. ideally will stay as long as loki is nearby, its the Inspiration problem')
    elseif sUnitOperationType == 'UNITOPERATION_DROWN_WARRIOR' then
        print('placeholder, kill warrior, replace with Drown. No carry over of state?')
    elseif sUnitOperationType == 'UNITOPERATION_SACRIFICE_ALTAR' then
        print('placeholder, kill unit, grant player science.')
    elseif sUnitOperationType == 'UNITOPERATION_ARENA_FIGHT' then
        print('placeholder, grant transient amenities, either unit experience or unit dies. no idea on calculation chance.')
    elseif sOperationAbility and tEquipmentOps[sOperationAbility] then
        local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
        local iX =  pUnit:GetX()
        local iY =  pUnit:GetY()
        local pCity = Cities.GetCityInPlot(iX, iY)
        pCity:AttachModifierByID(OperationInfo.SimpleText);
        local pUnitAbilityManager = pUnit:GetAbility()
        pUnitAbilityManager:RemoveAbilityCount(tEquipmentOps[sOperationAbility]);
    else
        print('no behaviour defined for this UnitOp on UnitCityInteract: ' .. sUnitOperationType)
    end
end

local function ConvertSelfUnit(iPlayer, tParameters)
    local sUnitOperationType =  tParameters.UnitOperationType
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local iUnitToSummon = GameInfo.Units[OperationInfo.SimpleText].Index
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    BaseSummon(pUnit, iPlayer, iUnitToSummon)
    UnitManager.Kill(pUnit);
end

local tEquipmentUnits = {
    [GameInfo.Units['SLTH_EQUIPMENT_ATHAME'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_BLACK_MIRROR'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_CROWN_OF_COMMAND'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_DRAGONS_HORDE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_EMPTY_BIER'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_GELA'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_GODSLAYER'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_GOLDEN_HAMMER'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_HEALING_SALVE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_JADE_TORC'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_NETHER_BLADE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_ORTHUSS_AXE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_POTION_OF_RESTORATION'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_ROD_OF_WINDS'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_SCORCHED_STAFF'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_STAFF_OF_SOULS'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_SPELL_STAFF'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_TIMOR_MASK'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_TREASURE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TREASURE_ABILITY'].Index,
    [GameInfo.Units['SLTH_EQUIPMENT_WAR'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index }

local tEquipmentAbilities = {
    [1] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index,
    [2] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index,
    [3] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index,
    [4] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index,
    [5] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index,
    [6] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index,
    [7] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index,
    [8] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index,
    [9] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index,
    [10] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index,
    [11] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index,
    [12] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index,
    [13] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index,
    [14] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index,
    [15] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index,
    [16] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index,
    [17] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index,
    [18] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index,
    [19] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index,
    [20] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index,
    [21] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index,
    [22] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index,
    [23] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index,
    [24] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'].Index}

local function ConsumeEquipment(iPlayer, tParameters)
    local hasEquipment
    local iEquipmentAbilityToGrant
    local iUnitID = tParameters.iCastingUnit
    local consumeUnitID = tParameters.iTargetID
    local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local pUnitAbilityManager = pUnit:GetAbility()
    local pConsumeUnit = UnitManager.GetUnit(iPlayer, consumeUnitID);			-- assumes consume unit is owned by same
    local iConsumeUnitType = pConsumeUnit:GetType()
    local equipAbility = tEquipmentUnits[iConsumeUnitType]
    if equipAbility then
        if not pUnitAbilityManager:HasAbility(equipAbility) then
            pUnit:GetAbility():AddAbilityCount(equipAbility)
            UnitManager.Kill(pConsumeUnit);
        else
            print('not granted as unit already has ability')
        end
    else
        local pConsumeUnitAbilityManager = pConsumeUnit:GetAbility()
        for _, equipAbilityAb in ipairs(tEquipmentAbilities) do
            hasEquipment = pConsumeUnitAbilityManager:HasAbility(equipAbilityAb)
            if hasEquipment then
                iEquipmentAbilityToGrant = equipAbilityAb
                break
            end
        end
        if iEquipmentAbilityToGrant then
            if not pUnitAbilityManager:HasAbility(iEquipmentAbilityToGrant) then
                pUnitAbilityManager:AddAbilityCount(iEquipmentAbilityToGrant)
                print('Added ability to unit')
                pConsumeUnitAbilityManager:RemoveAbilityCount(iEquipmentAbilityToGrant);
                print('removed ability from consumer')
            else
                print('dont get ability as already have it')
            end
        else
            print('ERROR: somehow sent command to consume equipment that wasnt configured or had ')
        end
    end
end

local function SummonClone( iPlayer, tParameters)
    local iUnitID = tParameters.iCastingUnit
    local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local iUnitToSummon = pUnit:GetType()
    local iHealth, iX, iY, tPromos, tAbilities = InheritUnitAttributes(iPlayer, iUnitID)
    local tNewUnits = BaseSummon(pUnit, iPlayer, iUnitToSummon)
    ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
    for iUnitSummonID, pNewUnit in pairs(tNewUnits) do
        pNewUnit:SetProperty('LifespanRemaining', 1)                -- set duration
    end
end

local function BreakStaff( iPlayer, tParameters)
    local iUnitID = tParameters.iCastingUnit
    local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local pUnitAbilityManager = pUnit:GetAbility()
    pUnitAbilityManager:RemoveAbilityCount('SLTH_EQUIPMENT_SPELL_STAFF_ABILITY');
    pUnit:SetProperty('HasCast', 0)
end

local function RefreshCastTakePop( iPlayer, tParameters)
    local iUnitID = tParameters.iCastingUnit
    local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local pCity = Cities.GetCityInPlot(iX, iY)
    pCity:ChangePopulation(-1)
    pUnit:SetProperty('HasCast', 0)
end

local function GainExperienceTakePop( iPlayer, tParameters)
    local iUnitID = tParameters.iCastingUnit
    local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local pCity = Cities.GetCityInPlot(iX, iY)
    local pUnitExp = pUnit:GetExperience()
    pUnitExp:ChangeExperience(10)
    pCity:ChangePopulation(-1)
end

local function SpreadEsus( iPlayer, tParameters)
    local targetCityID = tParameters.iTargetID
    local pCity = CityManager.GetCity(iPlayer, targetCityID);
    local pCityReligion = pCity:GetReligion()
    local iReligion = GameInfo.Religions["RELIGION_ISLAM"].Index
    pCityReligion:AddReligiousPressure(0, iReligion,300, iPlayer)
end

local function TeleportUnitToSummon( iPlayer, tParameters)
    local sUnitOperationType =  tParameters.UnitOperationType
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iUnitLink = pUnit:GetProperty(OperationInfo.SimpleText)
    local pUnitLink = UnitManager.GetUnit(iPlayer, iUnitLink)
    local iX =  pUnitLink:GetX()
    local iY =  pUnitLink:GetY()
    if pUnitLink then
        UnitManager.PlaceUnit(pUnit, iX, iY)
        UnitManager.Kill(pUnitLink)
    end
end

local function TeleportUnitToCapital( iPlayer, tParameters)
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local pPlayer = Players[iPlayer];
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    if pCapitalCity then
        local iX =  pCapitalCity:GetX()
        local iY =  pCapitalCity:GetY()
        UnitManager.PlaceUnit(pUnit, iX, iY)
    end
end
local function ForcePeace( iPlayer, tParameters)
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local pPlayer = Players[iPlayer];
    local pDiplo = pPlayer:GetDiplomacy()
    for iOtherPlayer, _ in ipairs(Players) do
        if pDiplo:IsAtWarWith(iOtherPlayer) then
            pDiplo:MakePeaceWith(iOtherPlayer)
        end
    end
    local iArmageddonCount = Game.GetProperty('ARMAGEDDON')
    if iArmageddonCount then
        local iNewArmageddonCount = math.floor(iArmageddonCount / 2)
        Game.SetProperty('ARMAGEDDON', iNewArmageddonCount)
    end
    UnitManager.Kill(pUnit)
end

local function HealSelf( iPlayer, tParameters)
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    Game.SetProperty('SIRONA_CAST', 1)                      -- todo setup gating
    local iCurrentHealth = pUnit:GetDamage() * -1
    pUnit:ChangeDamage(iCurrentHealth);
end

local function HealTileUnits( iPlayer, tParameters)
    local iUnitToHealID = tParameters.iTargetID
    local pUnitToHeal = UnitManager.GetUnit(iPlayer, iUnitToHealID);
    local iCurrentHealth = pUnitToHeal:GetDamage() * -1
    pUnitToHeal:ChangeDamage(iCurrentHealth);
end


-- UnitOperation Works
GameEvents.SlthSetCapitalProperty.Add(SetCapitalProperty);
GameEvents.SlthSetPlayerProperty.Add(SetPlayerProperty);
GameEvents.SlthSetResourcePromotions.Add(UpdateResourcePromotion);
GameEvents.SlthOnSummon.Add(OnSummon);
GameEvents.SlthOnSummonPerm.Add(OnSummonPermanent);
GameEvents.SlthOnGrantBuffSelf.Add(OnGrantBuffSelf);
GameEvents.SlthOnGrantBuffAoEAlly.Add(OnGrantBuffAoe);
GameEvents.SlthOnGrantAbilityAoeEnemy.Add(OnGrantDebuffAoe);
GameEvents.SlthOnChangeTerrain.Add(OnSpellChangeTerrain);
GameEvents.SlthOnAoeDamage.Add(OnSpellAoeDamage);
GameEvents.SlthOnBespokeSpell.Add(OnBespokeSpell);
GameEvents.SlthOnGrantGoldenAge.Add(GrantGoldenAge);
GameEvents.SlthOnGrantBuilding.Add(GrantBuildingFunction);
GameEvents.SlthOnGrantSuperSpecialist.Add(GrantSuperSpecialist);
GameEvents.SlthOnConsumeAlly.Add(ConsumeAlly);
GameEvents.SlthOnUnitCityInteract.Add(UnitCityInteract);
GameEvents.SlthOnConvertSelf.Add(ConvertSelfUnit);
GameEvents.SlthOnTakeEquipment.Add(ConsumeEquipment);
GameEvents.SlthOnCastMirror.Add(SummonClone)
GameEvents.SlthOnBreakStaff.Add(BreakStaff)
GameEvents.SlthDreamsConsume.Add(RefreshCastTakePop)
GameEvents.SlthVampireConsumePop.Add(GainExperienceTakePop)
GameEvents.SlthOnSpreadEsus.Add(SpreadEsus)
GameEvents.SlthOnTeleportToSummon.Add(TeleportUnitToSummon)
GameEvents.SlthOnTeleportToCapital.Add(TeleportUnitToCapital)
GameEvents.SlthOnForcePeace.Add(ForcePeace)
GameEvents.SlthOnHealSelf.Add(HealSelf)
GameEvents.SlthOnHealTargeted.Add(HealTileUnits)
