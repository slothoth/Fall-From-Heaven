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

local iOrder = GameInfo.Religions["RELIGION_PROTESTANTISM"].Index
local iEmpyrean = GameInfo.Religions["RELIGION_JUDAISM"].Index
local iRunes = GameInfo.Religions["RELIGION_CONFUCIANISM"].Index
local iLeaves = GameInfo.Religions["RELIGION_CATHOLICISM"].Index
local iOverlords = GameInfo.Religions["RELIGION_HINDUISM"].Index
local iEsus = GameInfo.Religions["RELIGION_ISLAM"].Index
local iVeil = GameInfo.Religions["RELIGION_BUDDHISM"].Index
local tReligionUnits = {
[GameInfo.Units['SLTH_UNIT_DISCIPLE_THE_ORDER'].Index]= iOrder,
[GameInfo.Units['SLTH_UNIT_DISCIPLE_EMPYREAN'].Index]=iEmpyrean,
[GameInfo.Units['SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH'].Index]=iRunes,
[GameInfo.Units['SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES'].Index]=iLeaves,
[GameInfo.Units['SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS'].Index]=iOverlords,
[GameInfo.Units['SLTH_UNIT_NIGHTWATCH'].Index]=iEsus,
[GameInfo.Units['SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL'].Index]=iVeil,
[GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_ORDER'].Index]=iOrder,
[GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_EMPYREAN'].Index]=iEmpyrean,
[GameInfo.Units['SLTH_UNIT_PRIEST_OF_KILMORPH'].Index]=iRunes,
[GameInfo.Units['SLTH_UNIT_PRIEST_OF_LEAVES'].Index]=iLeaves,
[GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_OVERLORDS'].Index]=iOverlords,
[GameInfo.Units['SLTH_UNIT_SHADOWRIDER'].Index]=iEsus,
[GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_VEIL'].Index]=iVeil}

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
            setReligion(pOnTileUnit)
        end
    end
    return tNewUnits
end

function setReligion(pUnit)
    local iUnitIndex = pUnit:GetType()
    local pReligion = pUnit:GetReligion()
    if pReligion then
        local iReligionIndex = tReligionUnits[iUnitIndex]
        if iReligionIndex then
            print('found religion of unit')
            pReligion:SetReligionType(iReligionIndex)
        end
    end
end

function ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
    print('applying attributes')
    for _, pNewUnit in pairs(tNewUnits) do
        print('new unit!')
        pNewUnit:SetDamage(iHealth)
        local pUnitExp = pNewUnit:GetExperience()
        local pUnitAbilities = pNewUnit:GetAbility()
        print('granting promos')
        for _, iUnitPromotionIndex in ipairs(tPromos) do
            if not pUnitExp:HasPromotion(iUnitPromotionIndex) then
                pUnitExp:SetPromotion(iUnitPromotionIndex)
                print('grant promo', GameInfo.UnitPromotions[iUnitPromotionIndex].UnitPromotionType)
            end
        end
        print('granting abilitiees')
        for _, sAbility in ipairs(tAbilities) do
            if not pUnitAbilities:HasAbility(sAbility) then
                pUnitAbilities:AddAbilityCount(sAbility)
                print('grant ability', sAbility)
            end
        end
    end
end

function GoldenAgeGrant(iPlayer, iGoldenDuration)
    local pPlayer = Players[iPlayer]
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
    setPlayerPropForRequirements(iPlayer, 'GoldenAgeDuration', iPropertyGoldenAge)
    print('confirm golden age exists on capital', pCapitalPlot:GetProperty('GoldenAgeDuration'))
    if bNewGoldenAge then
        print("(Leader name)'s Golden Age has just begun for x turns." )
    end
end

local iUserDefNotif = NotificationTypes.USER_DEFINED_2;
function NotifyAllHumans(sMessage, sSummary, iX, iY)
    local notificationData = {}
    notificationData[ParameterTypes.MESSAGE] = sMessage
    notificationData[ParameterTypes.SUMMARY] = sSummary
    for iPlayer, pPlayer in ipairs(Players) do
        if pPlayer:IsHuman() then
            NotificationManager.SendNotification(iPlayer, iUserDefNotif, notificationData, nil, iX, iY)
        end
    end
end

function NotifyMetHumans(iSourcePlayer, notificationData, iX, iY)
    for iPlayer, pPlayer in ipairs(Players) do
        if pPlayer:IsHuman() then
            if pPlayer:GetDiplomacy():HasMet(iSourcePlayer) then
                NotificationManager.SendNotification(iPlayer, iUserDefNotif, notificationData, nil, iX, iY)
            end
        end
    end
end

function NotifySelf(iSourcePlayer, notificationData, iX, iY)
    local pPlayer = Players[iSourcePlayer]
    if pPlayer:IsHuman() then
        NotificationManager.SendNotification(iSourcePlayer, iUserDefNotif, notificationData, nil, iX, iY)
    end
end

local sPropTrackKey = 'property_tracking'
function setPlayerPropForRequirements(iPlayer, sPropKey, value)
    local pPlayer = Players[iPlayer]
    if pPlayer then
        local pCities = pPlayer:GetCities()
        if pCities:GetCapitalCity() then                                             -- ZZ some properties could be set before city settlement
            local pCapitalPlot = pCities:GetCapitalCity():GetPlot()
            pCapitalPlot:SetProperty(sPropKey, value)
        end
        pPlayer:SetProperty(sPropKey, value)
        local tPropertyList = pPlayer:GetProperty(sPropTrackKey)          -- SHOULD NEVER FAIL so no fallback
        if tPropertyList[sPropKey] then
            if not value then
                tPropertyList[sPropKey] = nil
            end
        else
            tPropertyList[sPropKey] = true
        end
        pPlayer:SetProperty(sPropTrackKey, tPropertyList)
    end
    print('setting and tracking', sPropKey, value)
end

function setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, sPropKey, value)                -- faster version, when setting many and dont wanna reget capital
    if pCapitalPlot then
        pCapitalPlot:SetProperty(sPropKey, value)
    end
    pPlayer:SetProperty(sPropKey, value)
    local tPropertyList = pPlayer:GetProperty(sPropTrackKey)          -- SHOULD NEVER FAIL so no fallback
    if tPropertyList[sPropKey] then
        if not value then
            tPropertyList[sPropKey] = nil
        end
    else
        tPropertyList[sPropKey] = true
    end
    pPlayer:SetProperty(sPropTrackKey, tPropertyList)
    print('setting and tracking', sPropKey, value)
end

function initPropertyTracking()                     -- property tracking list is a key:val list of properties to migrate when losing a capital
    for iPlayer, pPlayer in ipairs(Players) do          -- by referencing the cached version on the player object
        if pPlayer:IsMajor() then
            local tPropertyList = pPlayer:GetProperty(sPropTrackKey)        -- NOTE: Not all properties assigned to a city should migrate
            if not tPropertyList then                                       -- for example, holy city property, so dont blanket use it
                pPlayer:SetProperty(sPropTrackKey, {})                     -- it needs to be keyed for fast lookup when adjust property that may already be in table
            end                                                             -- as otherwise could grow very long
        end
    end
end

function migrateCapitalProperties(pPlayer, newCapitalPlot, oldCapitalPlot)
    local tPropertyList = pPlayer:GetProperty(sPropTrackKey)
    print('migrating plot properties')
    for sPropKey, val in pairs(tPropertyList) do
        local propValue = pPlayer:GetProperty(sPropKey)
        print('migrating plot prop to new capital', sPropKey, propValue)
        if propValue then
            newCapitalPlot:SetProperty(sPropKey, propValue)
        end
        oldCapitalPlot:SetProperty(sPropKey, nil)
    end

end

function setCapitalProperties(pPlayer, newCapitalPlot)
    local tPropertyList = pPlayer:GetProperty(sPropTrackKey)
    for sPropKey, val in pairs(tPropertyList) do
        local propValue = pPlayer:GetProperty(sPropKey)
        if propValue then
            newCapitalPlot:SetProperty(sPropKey, propValue)
            print('setting plot prop on newly settled capital', sPropKey, propValue)
        else
            print('could not find property on player! issue with setCapitalProperties')
        end
    end
end

function getValidDisplacementPlot(pUnit, iX, iY)
    local chosenPlot
    local chosenPlotWater
    for dx = -1, 1 - 1, 1 do
		for dy = -1, 1 - 1, 1 do
            if not chosenPlot then
                local otherPlot = Map.GetPlotXYWithRangeCheck(iX, iY, dx, dy, 1);
                if otherPlot then
                    local iPlotID = otherPlot:GetIndex()
                    local tPlots = UnitManager.GetMoveToPath( pUnit, iPlotID )
                    -- print(tPlots)
                    if (table.count(tPlots) > 1) then            -- broken
                        if otherPlot:IsWater() then
                            chosenPlotWater = otherPlot
                        else
                            chosenPlot = otherPlot
                        end
                    end
                end
            end
		end
	end
    if chosenPlot then
        return chosenPlot
    else
        if chosenPlotWater then
            return chosenPlotWater
        else
            return -1
        end
    end
end

function DisplaceUnits(pPlot, pUnit, iX, iY)
    local chosenPlot = getValidDisplacementPlot(pUnit, iX, iY)
    if chosenPlot == -1 then
        print("ERROR, PANIC! no adjacent tile suitable to place units. Not spawning barbarians as safety measure.")
        return nil
    end
    local iNewX = chosenPlot:GetX()
    local iNewY = chosenPlot:GetY()
    local tUnitsInPlot = Units.GetUnitsInPlot(pPlot)
    for _, pTileUnit in ipairs(tUnitsInPlot) do
        UnitManager.PlaceUnit(pTileUnit, iNewX, iNewY)              -- displace to new tiles
    end
    return true
end

print('initialised spawn support')
initPropertyTracking()