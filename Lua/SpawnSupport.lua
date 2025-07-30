local tColdTerrain = {  [GameInfo.Terrains['TERRAIN_TUNDRA'].Index]       = true,
                        [GameInfo.Terrains['TERRAIN_TUNDRA_HILLS'].Index] = true,
                        [GameInfo.Terrains['TERRAIN_SNOW'].Index]         = true,
                        [GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index]   = true
}

local tAllPromotions = {}
for row in GameInfo.UnitPromotions() do
    table.insert(tAllPromotions, row.Index)
end

local tAllAbilities = {}
for row in GameInfo.UnitAbilities() do
    table.insert(tAllAbilities, row.UnitAbilityType)
end

local iGameSpeedMult = GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100
if not iGameSpeedMult then
    iGameSpeedMult = 1
end

-- nicked from Leugi Wildlife++
function ViableWildernessPlots(bOnlyTundraOrSnow)
    local tNewTable = {}
    local iCount = 1
    local bViablePlot
    local iW, iH = Map.GetGridSize();
    for x = 0, iW - 1 do
        for y = 0, iH - 1 do
            local i = y * iW + x;
            local pPlot = Map.GetPlotByIndex(i);
            if (pPlot ~= nil) then
                if (pPlot:IsAdjacentOwned() == false) and (pPlot:IsOwned() == false) and (pPlot:IsMountain() == false) and (pPlot:IsWater() == false) and (pPlot:IsNaturalWonder() == false) and (pPlot:IsImpassable() == false) and (pPlot:IsCity() == false) then
                    if bOnlyTundraOrSnow then
                        local iTerrainIndex = pPlot:GetTerrainType()
                        bViablePlot = tColdTerrain[iTerrainIndex]
                    else
                        bViablePlot = true
                    end
                    local bPlotHasUnit = false
                    local unitList = Units.GetUnitsInPlotLayerID(x, y, MapLayers.ANY)
                    if unitList ~= nil then
                        for _, pUnit in ipairs(unitList) do
                            local tUnitDetails = GameInfo.Units[pUnit:GetType()]
                            if tUnitDetails ~= nil then
                                if not pUnit:IsDead() and not pUnit:IsDelayedDeath() then
                                    bPlotHasUnit = true
                                    break
                                end
                            end
                        end
                    end
                    if (bPlotHasUnit == false) then
                        tNewTable[iCount] = pPlot
                        iCount = iCount + 1
                    end
                end
            end
        end
    end
    return tNewTable
end

function InheritUnitAttributes(iPlayer, iUnit)
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit)
    local pUnitExp = pUnit:GetExperience()
    local pUnitAbilities = pUnit:GetAbility()
    local iUnitHealth = pUnit:GetDamage()
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    local tPromosToGrant = {}
    for _, iUnitPromotionIndex in ipairs(tAllPromotions) do
        if pUnitExp:HasPromotion(iUnitPromotionIndex) then
            table.insert(tPromosToGrant, iUnitPromotionIndex)            -- need to watch out for dummy promos being granted twice
        end
    end

    local tAbilitiesToGrant = {}
    for _, sUnitAbilityType in ipairs(tAllAbilities) do
        if pUnitAbilities:HasAbility(sUnitAbilityType) then
            table.insert(tAbilitiesToGrant, sUnitAbilityType)
        end
    end
    return iUnitHealth, iX, iY, tPromosToGrant, tAbilitiesToGrant
end

function BaseSummon(pCasterUnit, iPlayer, iUnitIndex)
    local iX =  pCasterUnit:GetX()
    local iY =  pCasterUnit:GetY()
    local tNewUnits = SimpleSummon(iX, iY, iPlayer, iUnitIndex)
    return tNewUnits
end

function SimpleSummon(iX, iY, iPlayer, iUnitIndex)
    local playerReal = Players[iPlayer];
    local playerUnits = playerReal:GetUnits();
    local pPlot = Map.GetPlot(iX, iY)
    local tBeforeSummonUnits = {}
    for _, pOnTileUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do
        if pOnTileUnit then
            tBeforeSummonUnits[pOnTileUnit:GetID()] = true
        end
    end
    playerUnits:Create(iUnitIndex, iX, iY);
    local tNewUnits = {}
    for _, pOnTileUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do
        if pOnTileUnit then
            local iUnitID = pOnTileUnit:GetID()
            if not tBeforeSummonUnits[iUnitID] then
                tNewUnits[iUnitID] = pOnTileUnit
            end
        end
    end
    return tNewUnits
end

function GoldenAgeGrant(pPlayer, iGoldenDuration)
    local iAdjustedGoldenAgeDuration = iGoldenDuration * iGameSpeedMult
    for _, pCity in pPlayer:GetCities():Members() do
        local pPlot = pCity:GetPlot();
        if pPlot then
            pPlot:SetProperty('InGoldenAge', 1);
        end
    end
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    local pCapitalPlot = pCapitalCity:GetPlot()
    local iPropertyGoldenAge = pCapitalPlot:GetProperty('GoldenAgeDuration') or 0
    local bNewGoldenAge = iPropertyGoldenAge < 1
    iPropertyGoldenAge = iPropertyGoldenAge + iAdjustedGoldenAgeDuration
    print('setting golden age duration to', iPropertyGoldenAge)
    pCapitalPlot:SetProperty('GoldenAgeDuration', iPropertyGoldenAge)
    print('confirm golden age exists on capital', pCapitalPlot:GetProperty('GoldenAgeDuration'))
    if bNewGoldenAge then
        print("(Leader name)'s Golden Age has just begun for x turns." )
    end
end

function NotifyAllHumans(sMessage, sSummary, iX, iY)
    local notificationData = {}
    notificationData[ParameterTypes.MESSAGE] = sMessage
    notificationData[ParameterTypes.SUMMARY] = sSummary
    for iPlayer, pPlayer in ipairs(Players) do
        if pPlayer:IsHuman() then
            NotificationManager.SendNotification(iPlayer, iNotifType, notificationData, nil, iX, iY)
        end
    end
end

function NotifyMetHumans(iSourcePlayer, notificationData, iX, iY)
    for iPlayer, pPlayer in ipairs(Players) do
        if pPlayer:IsHuman() then
            if pPlayer:GetDiplomacy():HasMet(iSourcePlayer) then
                NotificationManager.SendNotification(iPlayer, iNotifType, notificationData, nil, iX, iY)
            end
        end
    end
end

print('initialised spawn support')