include('WorldSpellSupport')
include('SpawnSupport')

local FreeXPUnits = { SLTH_UNIT_ADEPT = 8, SLTH_UNIT_IMP = 8, SLTH_UNIT_SHAMAN = 8, SLTH_UNIT_ARCHMAGE = 16, SLTH_UNIT_EATER_OF_DREAMS = 16,
                      SLTH_UNIT_CORLINDALE = 8, SLTH_UNIT_DISCIPLE_OF_ACHERON = 8, SLTH_UNIT_GAELAN = 12, SLTH_UNIT_GIBBON = 8,
                      SLTH_UNIT_GOVANNON = 8, SLTH_UNIT_HEMAH = 8, SLTH_UNIT_LICH = 16, SLTH_UNIT_ILLUSIONIST = 12, SLTH_UNIT_MAGE = 12,
                      SLTH_UNIT_WIZARD = 12, SLTH_UNIT_MOBIUS_WITCH = 12, SLTH_UNIT_MOKKA = 12, SLTH_UNIT_SON_OF_THE_INFERNO = 16}
local iNotifType = NotificationTypes.USER_DEFINED_2;
local iIMP_INDEX = GameInfo.Units['SLTH_UNIT_IMP'].Index
local tArcaneUnits = {
    [GameInfo.Units['SLTH_UNIT_ADEPT'].Index] = true, iIMP_INDEX = true, [GameInfo.Units['SLTH_UNIT_SHAMAN'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_ARCHMAGE'].Index] = true, [GameInfo.Units['SLTH_UNIT_EATER_OF_DREAMS'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_CORLINDALE'].Index] = true, [GameInfo.Units['SLTH_UNIT_DISCIPLE_OF_ACHERON'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_GAELAN'].Index] = true, [GameInfo.Units['SLTH_UNIT_GIBBON'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_GOVANNON'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_HEMAH'].Index] = true, [GameInfo.Units['SLTH_UNIT_LICH'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_ILLUSIONIST'].Index] = true, [GameInfo.Units['SLTH_UNIT_MAGE'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_WIZARD'].Index] = true, [GameInfo.Units['SLTH_UNIT_MOBIUS_WITCH'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_MOKKA'].Index] = true, [GameInfo.Units['SLTH_UNIT_SON_OF_THE_INFERNO'].Index] = true
}
local tBinaryMap = {
    ['0']={['8']= 0, ['4']=0, ['2']=0, ['1']=0},
    ['1']={['8']=0, ['4']=0, ['2']=0, ['1']=1,},
    ['2']={['8']=0, ['4']=0, ['2']=1, ['1']=0,},
    ['3']={['8']=0, ['4']=0, ['2']=1, ['1']=1,},
    ['4']={['8']=0, ['4']=1, ['2']=0, ['1']=0,},
    ['5']={['8']=0, ['4']=1, ['2']=0, ['1']=1,},
    ['6']={['8']=0, ['4']=1, ['2']=1, ['1']=0,},
    ['7']={['8']=0, ['4']=1, ['2']=1, ['1']=1,},
    ['8']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['9']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['10']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['11']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['12']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['13']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['14']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['15']={['8']=1, ['4']=1, ['2']=1, ['1']=1,}
}
local iCOTTAGE_INDEX = GameInfo.Improvements['IMPROVEMENT_COTTAGE'].Index
local iHAMLET_INDEX = GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index
local iTOWN_INDEX = GameInfo.Improvements['IMPROVEMENT_TOWN'].Index
local iVILLAGE_INDEX = GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index
local iENCLAVE_INDEX = GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index
local iPIRATE_COVE_INDEX = GameInfo.Improvements['IMPROVEMENT_PIRATE_COVE'].Index
local iPIRATE_HARBOR_INDEX = GameInfo.Improvements['IMPROVEMENT_PIRATE_COVE'].Index
local iPIRATE_PORT_INDEX = GameInfo.Improvements['IMPROVEMENT_FEITORIA'].Index

local tImprovementsProgression = {
        [iCOTTAGE_INDEX]        = iHAMLET_INDEX,
        [iHAMLET_INDEX]         = iVILLAGE_INDEX,
        [iVILLAGE_INDEX]        = iTOWN_INDEX,
        [iTOWN_INDEX]           = iENCLAVE_INDEX,
        [iPIRATE_COVE_INDEX]    = iPIRATE_HARBOR_INDEX,
        [iPIRATE_HARBOR_INDEX]  = iPIRATE_PORT_INDEX}
local tImprovementsRegression = {
    [iHAMLET_INDEX]         = iCOTTAGE_INDEX,
    [iVILLAGE_INDEX]        = iHAMLET_INDEX,
    [iTOWN_INDEX]           = iVILLAGE_INDEX,
    [iENCLAVE_INDEX]        = iTOWN_INDEX,
    [iPIRATE_HARBOR_INDEX]  = iPIRATE_COVE_INDEX,
    [iPIRATE_PORT_INDEX]       = iPIRATE_HARBOR_INDEX}
local tImprovementsCivProgression = {
    [iTOWN_INDEX]           = iENCLAVE_INDEX}

local tImprovementsTurnAmount = {
        [iCOTTAGE_INDEX]        = 6,                        -- extra duration on gamespeed, but unsure is actually. Wiki and civpedia conflict /10/15/30
        [iHAMLET_INDEX]         = 13,                       -- /20/30/60
        [iVILLAGE_INDEX]        = 26,                       -- 40/60/120
        [iTOWN_INDEX]           = 40,                       -- /60/120/160 no wiki details...
        [iPIRATE_COVE_INDEX]    = 6,
        [iPIRATE_HARBOR_INDEX]  = 13
}

local tBarbNW = {
	[GameInfo.Features['FEATURE_UBSUNUR_HOLLOW'].Index] = 1,
	[GameInfo.Features['FEATURE_NWON_BRADELINES_WELL'].Index] = 1,
	[GameInfo.Features['FEATURE_DELICATE_ARCH'].Index] = 1,
	[GameInfo.Features['FEATURE_YOSEMITE'].Index] = 1}


local transientBuffKeys = {
        BUFF_HASTE = 0, BUFF_DANCE_OF_BLADES = 0, BUFF_CHARMED = 80, BUFF_SLOW = 70,
        BUFF_BLUR = 50, BUFF_SHADOWWALK = 75, BUFF_FAIR_WINDS = 95, BUFF_BURNING_BLOOD = 90,
        BUFF_FATIGUED = 50, BUFF_CROWN_OF_BRILLIANCE = 80, BUFF_MORALE = 90, BUFF_WARCRY = 95
    }

local tResourcePropKeys = { 'RESOURCE_MANA_AIR', 'RESOURCE_MANA_BODY', 'RESOURCE_MANA_CHAOS',
    'RESOURCE_MANA_DEATH', 'RESOURCE_MANA_EARTH', 'RESOURCE_MANA_ENCHANTMENT',
    'RESOURCE_MANA_ENTROPY', 'RESOURCE_MANA_FIRE', 'RESOURCE_MANA_LAW', 'RESOURCE_MANA_LIFE',
    'RESOURCE_MANA_METAMAGIC', 'RESOURCE_MANA_MIND', 'RESOURCE_MANA_NATURE',
    'RESOURCE_MANA_SHADOW', 'RESOURCE_MANA_SPIRIT', 'RESOURCE_MANA_SUN', 'RESOURCE_MANA_WATER'
    }

function SlthAppend(tFirst, tSecond)
    local tNewTable = tFirst
    for _, val in ipairs(tSecond) do
        table.insert(tNewTable, val)
    end
    return tNewTable
end

function SlthLog(sMessage)
    SLTH_DEBUG_ON = nil
    if SLTH_DEBUG_ON then
        print(sMessage)
    end
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


local function ConvertUnitType( iPlayer, tParameters)
    -- print('converting unit on Gameplay side')
    local iUnitID = tParameters.iUnitID
    local iNewUnitIndex = tParameters.iUpgradeUnitIndex
    local iUpgradeCost = tParameters.iCost
    local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local pPlayer = Players[iPlayer]
    pPlayer:GetTreasury():ChangeGoldBalance(-iUpgradeCost)
    local iHealth, iX, iY, tPromos, tAbilities = InheritUnitAttributes(iPlayer, iUnitID)
    local tNewUnits = BaseSummon(pUnit, iPlayer, iNewUnitIndex)
    ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
    pUnit:SetDamage(0)
    -- do UnitManager delete on UI side
end

local iHALL_OF_MIRRORS_INDEX = GameInfo.Buildings['SLTH_BUILDING_HALL_OF_MIRRORS'].Index
local iPLANAR_GATE_INDEX = GameInfo.Buildings['SLTH_BUILDING_PLANAR_GATE'].Index
local tPlanarBuildingUnitMap = {    [GameInfo.Buildings['SLTH_BUILDING_PUBLIC_BATHS'].Index] = GameInfo.Units['SLTH_UNIT_SUCCUBUS'].Index,
                                    [GameInfo.Buildings['SLTH_BUILDING_CARNIVAL'].Index] = GameInfo.Units['SLTH_UNIT_CHAOS_MARAUDER'].Index,
                                    [GameInfo.Buildings['BUILDING_STUPA'].Index] = GameInfo.Units['SLTH_UNIT_TAR_DEMON'].Index,
                                    [GameInfo.Buildings['SLTH_BUILDING_GAMBLING_HOUSE'].Index] = GameInfo.Units['SLTH_UNIT_REVELERS'].Index,
                                    [GameInfo.Buildings['BUILDING_MAGE_GUILD'].Index] = GameInfo.Units['SLTH_UNIT_MOBIUS_WITCH'].Index
}
local iGOVERNORS_MANOR_INDEX = GameInfo.Buildings['SLTH_BUILDING_GOVERNORS_MANOR'].Index
local function SpawnAcheron()
    -- find city states
    -- choose first as reduces randomness, and location is already random. Might screw over ppl.
    local tMinorCivs = PlayerManager.GetAliveMinors()
    local pCity
    local pChosenCityState
    for _, pPlayer in ipairs(tMinorCivs) do
        if not pCity then
            pCity = pPlayer:GetCities():GetCapitalCity()
            pChosenCityState = pPlayer
        end
    end
    if pCity then
        local pPlot = pCity:GetPlot()
        local iX =  pPlot:GetX()
        local iY =  pPlot:GetY()
        local playerUnits = pChosenCityState:GetUnits();
        playerUnits:Create(GameInfo.Units['SLTH_UNIT_ACHERON'].Index, iX, iY);      -- spawn acheron for that city state
        pCity:AttachModifierByID('MODIFIER_GRANT_ACHERONS_LAIR')      -- then add a building that allows the disciples of the inferno
        pCity:AttachModifierByID('MODIFIER_GRANT_THE_DRAGONS_HORDE_BUILDING')
    else
        print('no barbarian cities for acheron to inhabit. Dragon spawn not used :(')
    end
end

local function SpawnOrthus()
    local tEligiblePlots = ViableWildernessPlots()
    local iNumEligiblePlots = table.count(tEligiblePlots)
    if iNumEligiblePlots > 0 then
        local iRandomEligiblePlotsPosition = Game.GetRandNum((iNumEligiblePlots + 1) - 1, 'RNG_barb_placement') + 1
        local spawnPlot = tEligiblePlots[iRandomEligiblePlotsPosition]
        local iSpawnX = spawnPlot:GetX()
        local iSpawnY = spawnPlot:GetY()
        NotifyAllHumans(Locale.Lookup('LOC_ORTHUS_SPAWN_NOTIFICATION_TITLE'), Locale.Lookup('LOC_ORTHUS_SPAWN_NOTIFICATION_DESCRIPTION'), iSpawnX, iSpawnY)
        UnitManager.InitUnitValidAdjacentHex(63, GameInfo.Units['SLTH_UNIT_ORTHUS'].Index, iSpawnX, iSpawnY);
    end
end

function CountdownReduceGame(countdown_propKey, plotPropKey)
    local countDownDelay = Game:GetProperty(countdown_propKey)
    if countDownDelay then
        if countDownDelay > 1 then
            Game:SetProperty(countdown_propKey, countDownDelay - 1)
        elseif countDownDelay == 1 then
            Game:SetProperty(countdown_propKey, countDownDelay - 1)              -- turn off stasis
            for iPlayerID, pCountdownPlayer in ipairs(Players) do
                local pCapitalCity = pCountdownPlayer:GetCities():GetCapitalCity()
                if pCapitalCity then
                    local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
                    local iCurrentPlotAmount = pCapitalPlot:GetProperty(plotPropKey)
                    if iCurrentPlotAmount then
                        pCapitalPlot:SetProperty(plotPropKey, 0)
                    end
                end
            end
        end
    end
end

function CountdownReducePlayer(pPlayer, countdown_propKey, plotPropKey)
    if pPlayer:GetCities() then
        local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
        if pCapitalCity then
            local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
            local countDownDelay = pCapitalPlot:GetProperty(countdown_propKey)
            if countDownDelay and countDownDelay > 1 then
                pCapitalPlot:SetProperty(countdown_propKey, countDownDelay - 1)
            elseif countDownDelay and countDownDelay == 1 then
                pCapitalPlot:SetProperty(countdown_propKey, countDownDelay - 1)
                -- turn off property in all city centre plots
                 for _, pCity in pPlayer:GetCities():Members() do
                    local pPlot = pCity:GetPlot();
                    if pPlot then
                        pPlot:SetProperty(plotPropKey, 0);
                    end
                end
                if countdown_propKey == 'GoldenAgeDuration' then
                    NotifyMetHumans()
                    print("(Leader name)'s Golden Age has ended")
                end
            end
        end
    end
end

function AddExperienceIfAble(pUnit, iFXP_gain)
    local pExp = pUnit:GetExperience()
    local iExpForNextLevel = pExp:GetExperienceForNextLevel()
    if iExpForNextLevel > iFXP_gain then
        pExp:ChangeExperience(iFXP_gain);
    else
        local iReservedXP = iFXP_gain - iExpForNextLevel
        pUnit:SetProperty('xp_portion', iReservedXP);
        pExp:ChangeExperience(iExpForNextLevel);
    end
end
local iGameSpeedMult = GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100
function onTurnStartGameplay(playerId)
    local pPlayer = Players[playerId];
    local iArcaneLacuna = Game:GetProperty('ARCANE_LACUNA_COUNTDOWN') or 0
    local bAllowSpells
    if iArcaneLacuna > 0 then
        local iArcaneLacunaCaster = Game:GetProperty('ARCANE_LACUNA_CASTER') or -1
        if playerId == 63 then          -- barbs are always existing, so once per global turn
            Game:SetProperty('ARCANE_LACUNA_COUNTDOWN', iArcaneLacuna - 1)
        elseif playerId == iArcaneLacunaCaster then
            bAllowSpells = true
        end
    else
        bAllowSpells = true
    end
    -- SECTION: count down Timer effects like Stasis and Arcane Lacuna worldspell
    CountdownReduceGame('STASIS_COUNTDOWN', 'InStasis')
    CountdownReducePlayer(pPlayer,'GoldenAgeDuration', 'InGoldenAge')

    for _, unit in pPlayer:GetUnits():Members() do              -- SECTION: do reset castable
        if unit:GetProperty('HasCast') and bAllowSpells then
            -- print('setting HasCast to 0')
            unit:SetProperty('HasCast', 0)
        end
        local iUnitIndex = unit:GetType();                      -- SECTION: passive experience gain
        local sUnitType = GameInfo.Units[iUnitIndex].UnitType
        if sUnitType then                       -- remove once table correct
            local fXP_gain = FreeXPUnits[sUnitType] or 0
            local pUnitAbilities = unit:GetAbility()
            if pUnitAbilities and pUnitAbilities:HasAbility('SLTH_ABILITY_POTENCY') or pUnitAbilities:HasAbility('SLTH_ABILITY_HERO') then
                fXP_gain = fXP_gain + 8
            end
            if fXP_gain > 0 then
                if fXP_gain == math.floor(fXP_gain) then
                    AddExperienceIfAble(unit, fXP_gain)        -- if integer, simple add xp
                else                                                    -- if float, use property to set state.
                    local iXP_portion, fXP_portion = math.modf(fXP_gain);
                    local existing_xp_portion = unit:GetProperty('xp_portion');
                    if not existing_xp_portion then
                        unit:SetProperty('xp_portion', fXP_portion);
                    else
                        local new_xp_portion = existing_xp_portion + fXP_portion;
                        if new_xp_portion > 1 then
                            local iIntegerXp = math.floor(new_xp_portion)
                            iXP_portion = iXP_portion + iIntegerXp;
                            new_xp_portion = new_xp_portion -iIntegerXp;
                        end
                        unit:SetProperty('xp_portion', new_xp_portion);
                    end
                    AddExperienceIfAble(unit, iXP_portion)
                end
            end
        end
    end
    -- SECTION: update altars. done so all luonnotars arent granted at once
    local bLuonnotarApplied
    for _, pCity in pPlayer:GetCities():Members() do
        if not bLuonnotarApplied then
            local sLuonnotarDummyModifier = pCity:GetProperty('luonnotar_dummy')
            if sLuonnotarDummyModifier then
                -- print('player turn started: and city valid for next altar. attaching:', sLuonnotarDummyModifier)
                pCity:AttachModifierByID(sLuonnotarDummyModifier)
                bLuonnotarApplied = true
                -- print('player turn started: removed blocker')
            end
        end
    end
    -- SECTION: transient buff cycling
    for sBuffAbility, percent_gate in pairs(transientBuffKeys) do
        local sPropbuff_propkey = sBuffAbility .. ('_UNITS')
        local tSpecificBuffState = Game:GetProperty(sPropbuff_propkey) or {}
        local tNewBuffState = {}
        for _, tUnitInfos in ipairs(tSpecificBuffState) do
            local iCasterPlayer = tUnitInfos['iCasterPlayer']
            if playerId == iCasterPlayer then
                local percent_roll = math.random(100)
                local iPlayer = tUnitInfos['iPlayer']
                local iUnit = tUnitInfos['iUnit']
                local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
                if pUnit then
                    if percent_roll > percent_gate then
                        local pAbility = pUnit:GetAbility()
                        if pAbility and pAbility:HasAbility(sBuffAbility) then
                            pAbility:RemoveAbilityCount(sBuffAbility)
                        end
                    else
                        table.insert(tNewBuffState, tUnitInfos)         -- only include in new state if unit exists,
                    end                                                 -- it has ability, and failed RNG
                end
            end
        end
    end
    -- BUFF_REGENERATION -- when full
    -- local afterCombat = {BUFF_BLESSED=true, BUFF_ENRAGED=true, BUFF_STONESKIN=true}

    -- SECTION: BarbarianSpawnEvents
    if playerId == 63 then              -- barbarian proxy
        local iCurrentTurn = Game.GetCurrentGameTurn()
        -- print('current turn is', iCurrentTurn)
        if iCurrentTurn == 100 then
            SpawnAcheron()
        elseif iCurrentTurn == math.floor(75 * iGameSpeedMult) then
            SpawnOrthus()            -- Spawns automatically depending on game speed: Quick- 50, Normal- 75, Epic- 113, Marathon- 225
        end
    end

    IncrementCottages(playerId, pPlayer)

    -- SECTION: Hall of Mirror. Currently restricted to Balseraphs
    if PlayerConfigurations[playerId]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_BALSERAPHS' then
        for _, pCity in pPlayer:GetCities():Members() do
            if pCity:GetBuildings():HasBuilding(iHALL_OF_MIRRORS_INDEX) then
                local iX =  pCity:GetX()
                local iY =  pCity:GetY()
                local pUnitClone
                local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
                for _, plot in ipairs(tNeighborPlots) do
                    if not pUnitClone then
                        for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
                            if (pNearUnit) and (not pUnitClone) then
                                local iOwnerPlayer = pNearUnit:GetOwner();
                                if (iOwnerPlayer ~= playerId) then
                                    if Players[playerId]:GetDiplomacy():IsAtWarWith(iOwnerPlayer) then
                                        pUnitClone = pNearUnit
                                    end
                                end
                            end
                        end
                    end
                end
                if pUnitClone then
                    local iUnitIndex = pUnitClone:GetType()
                    local tNewUnits = SimpleSummon(iX, iY, playerId, iUnitIndex)
                    for iUnitSummonID, pNewUnit in pairs(tNewUnits) do
                        pNewUnit:SetProperty('LifespanRemaining', 1)                -- set duration
                    end
                end
            end
        end
    end
    -- SECTION: Planar Gate spawning
    if PlayerConfigurations[playerId]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_SHEAIM' then
        local iArmageddonCount =  Game.GetProperty('ARMAGEDDON') or 0
        local iChance = 6
        local iNumUnitsSpawnable = 1
        if iArmageddonCount > 50 then
            iChance = iChance + 3
            iNumUnitsSpawnable = iNumUnitsSpawnable + 1
            if iArmageddonCount > 74 then
                iChance = iChance + 3
                iNumUnitsSpawnable = iNumUnitsSpawnable + 1
                if iArmageddonCount > 99 then
                    iChance = iChance + 3
                    iNumUnitsSpawnable = iNumUnitsSpawnable + 1
                end
            end
        end
        for _, pCity in pPlayer:GetCities():Members() do
            local pBuildings = pCity:GetBuildings()
            if pBuildings:HasBuilding(iPLANAR_GATE_INDEX) then
                -- do dice roll to see if succeeds
                local iRoll = math.random(100)
                print('rolling for planar gate: ' .. tostring(iRoll) .. ' comared to threshold' .. tostring(iChance))
                if iRoll >= iChance then
                    local tUnitsPossible = {}
                    for iBuildingIndex, iUnitIndex in pairs(tPlanarBuildingUnitMap) do
                        if pBuildings:HasBuilding(iBuildingIndex) then
                            table.insert(tUnitsPossible, iUnitIndex)
                        end
                    end
                    if #tUnitsPossible > 0 then
                        for _=1, iNumUnitsSpawnable do
                            local iUnitSelectedIndex = tUnitsPossible[math.random(#tUnitsPossible)]
                            local iX =  pCity:GetX()
                            local iY =  pCity:GetY()
                            SimpleSummon(iX, iY, playerId, iUnitSelectedIndex)
                        end
                    end
                end
            end
        end
    end
    -- SECTION: Governor Manor Amenity PlotProperty BinaryMagic state management.
    if PlayerConfigurations[playerId]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_CALABIM' then
        for _, pCity in pPlayer:GetCities():Members() do
            if pCity:GetBuildings():HasBuilding(iGOVERNORS_MANOR_INDEX) then
                updatePlotPropertyAmenities(pCity)
            end
        end
    end
    local iPillarOfChainsPlayer = Game:GetProperty('PILLAR_OF_CHAINS_OWNER') or -1
    if playerId == iPillarOfChainsPlayer then
        local iPillarCityId = Game:GetProperty('PILLAR_OF_CHAINS_CITY')
        if iPillarCityId then
            local pCity = CityManager.GetCity(playerId, iPillarCityId)
            if pCity then
                updatePlotPropertyAmenities(pCity)
            end
        end
    end
end

function updatePlotPropertyAmenities(pCity)
    local iNeededAmenities = math.floor(pCity:GetPopulation() / 2)
    local pPlot =  pCity:GetPlot()
    local tPlotPropertyChanges = tBinaryMap[tostring(iNeededAmenities)]
    for idx, bin_val in pairs(tPlotPropertyChanges) do
        pPlot:SetProperty('CITY_AMENITIES_REQUIRED_'.. idx, bin_val)
    end
end
------------ Cottage / Pirate Cove improvement upgrading over turns  ---------

function ImprovementsWorkOrPillageChange(x, y, improvementIndex, improvementPlayerID, resourceIndex, isPillaged, isWorked)
    local iImprovementToDowngradeIndex = tImprovementsRegression[improvementIndex]
    local pPlot
    if iImprovementToDowngradeIndex and isPillaged > 0 then
        pPlot = Map.GetPlot(x, y)
        ImprovementBuilder.SetImprovementType(pPlot, iImprovementToDowngradeIndex, improvementPlayerID)
        return
    end
    if tImprovementsProgression[improvementIndex] then
         pPlot = Map.GetPlot(x, y)
         if tImprovementsCivProgression[improvementIndex] then
             if PlayerConfigurations[improvementPlayerID]:GetCivilizationTypeName() ~= 'SLTH_CIVILIZATION_KURIOTATES' then
                 pPlot:SetProperty('currently_worked', 0)
                 return
             end
         end
         local iImprovementWorkedState =  pPlot:GetProperty('currently_worked') or 0
         -- print( 'tile worked status was now: ' .. tostring(iImprovementWorkedState or "nil") )
         -- print( 'tile worked status is now: ' .. tostring(isWorked or "nil") )
         if isWorked and iImprovementWorkedState == 0 then
             pPlot:SetProperty('currently_worked', 1)
         elseif iImprovementWorkedState > 0 and not isWorked then
             pPlot:SetProperty('currently_worked', 0)
         end
     end
end

local TRIBE_CLAN_SCORPION = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_OPEN'].Index
local TRIBE_CLAN_SKELETON = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_HILLS'].Index
local TRIBE_CLAN_LIZARDMEN = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_FOREST'].Index
-- local TRIBE_CLAN_BEAR = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_OPEN'].Index
-- local TRIBE_CLAN_LION = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_CHARIOT'].Index

local tBarbClanUnitMapper = {
    [GameInfo.Units['SLTH_UNIT_ARCHER'].Index] = TRIBE_CLAN_SCORPION,
    [GameInfo.Units['SLTH_UNIT_GOBLIN'].Index] = TRIBE_CLAN_SCORPION,
    [GameInfo.Units['SLTH_UNIT_SKELETON'].Index] = TRIBE_CLAN_SKELETON,
    [GameInfo.Units['SLTH_UNIT_LIZARDMAN'].Index] = TRIBE_CLAN_LIZARDMEN,
    -- [GameInfo.Units['SLTH_UNIT_LION'].Index] = TRIBE_CLAN_BEAR,
    -- [GameInfo.Units['SLTH_UNIT_BEAR'].Index] = TRIBE_CLAN_LION
}
local iBarbCampImprovement = GameInfo.Improvements['IMPROVEMENT_BARBARIAN_CAMP'].Index
function InitCottage(x, y, improvementIndex, playerID)
    local iImprovementUpgradeIndex = tImprovementsProgression[improvementIndex]
    if iImprovementUpgradeIndex then
        local pPlayer = Players[playerID]
        local tImprovingImprovements = pPlayer:GetProperty('improvements_to_increment') or  {}
        if iImprovementUpgradeIndex == GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index then    -- enclave exception
            local civ = PlayerConfigurations[playerID]:GetCivilizationTypeName()
            if civ ~= 'SLTH_CIVILIZATION_KURIOTATES' then
                -- print('removing from list of incrementers')
                tImprovingImprovements[tostring(x) .. '_' .. tostring(y)] = nil
                pPlayer:SetProperty('improvements_to_increment', tImprovingImprovements)
                return
            end
        end
        local pPlot = Map.GetPlot(x, y)
        pPlot:SetProperty('worked_turns', 0)
        local iIsWorked = pPlot:GetWorkerCount()
        -- print('Is tile worked: '.. tostring(iIsWorked or "nil"))
        if iIsWorked > 0 then
            pPlot:SetProperty('currently_worked', 1)
        else
            pPlot:SetProperty('currently_worked', 0)
        end
        tImprovingImprovements[tostring(x) .. '_' .. tostring(y)] = {['x']=x, ['y']=y}
        pPlayer:SetProperty('improvements_to_increment', tImprovingImprovements)
    end
end

function IncrementCottages(playerId, pPlayer)
    local tImprovingImprovements = pPlayer:GetProperty('improvements_to_increment')
    if not tImprovingImprovements then return end
    for idx, plot_tuple in pairs(tImprovingImprovements) do
        local iX, iY = plot_tuple['x'], plot_tuple['y']
        local pPlot = Map.GetPlot(iX, iY)
        local bIsWorked = pPlot:GetProperty('currently_worked')
        local bIsImprovementPillaged = pPlot:IsImprovementPillaged()
        if bIsWorked > 0 and not bIsImprovementPillaged then
            local iWorkedTurns = pPlot:GetProperty('worked_turns')
            local iImprovementIndex = pPlot:GetImprovementType()
            local iUpgradeTurns = tImprovementsTurnAmount[iImprovementIndex] or 2               -- fallback, shouldnt happen
            if iWorkedTurns > iUpgradeTurns then
                -- print( 'tile will upgrade to: ' .. tostring(iImprovementIndex or "nil") )
                local iImprovementUpgradedIndex = tImprovementsProgression[iImprovementIndex]
                if iImprovementUpgradedIndex then
                    ImprovementBuilder.SetImprovementType(pPlot, iImprovementUpgradedIndex, playerId)
                end
            else
                pPlot:SetProperty('worked_turns', iWorkedTurns+1)
                -- print( 'tile upgrade turns: ' .. tostring(1 - iWorkedTurns or "nil") )
            end
        end
    end
end

--------------- Barbarian Lair Events -----------------------

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

local iUNIT_AZER = GameInfo.Units['SLTH_UNIT_AZER'].Index
local iUNIT_AIRELEM = GameInfo.Units['SLTH_UNIT_AIR_ELEMENTAL'].Index
local iUNIT_WATER_ELEM = GameInfo.Units['SLTH_UNIT_WATER_ELEMENTAL'].Index
local iUNIT_KRAKEN = GameInfo.Units['SLTH_UNIT_KRAKEN'].Index
local iUNIT_SEA_SERPENT = GameInfo.Units['SLTH_UNIT_SEA_SERPENT'].Index
local iUNIT_STYGIAN_GUARD = GameInfo.Units['SLTH_UNIT_STYGIAN_GUARD'].Index
local iUNIT_PIRATE = GameInfo.Units['SLTH_UNIT_PIRATE'].Index
local iUNIT_GRIFFON = GameInfo.Units['SLTH_UNIT_GRIFFON'].Index
local iUNIT_DROWN = GameInfo.Units['SLTH_UNIT_DROWN'].Index

local iUNIT_ASSASSIN = GameInfo.Units['SLTH_UNIT_ASSASSIN'].Index
local iUNIT_OGRE = GameInfo.Units['SLTH_UNIT_OGRE'].Index
local iUNIT_GIANT_SPIDER = GameInfo.Units['SLTH_UNIT_GIANT_SPIDER'].Index
local iUNIT_HILL_GIANT = GameInfo.Units['SLTH_UNIT_HILL_GIANT'].Index
local iUNIT_SPECTRE = GameInfo.Units['SLTH_UNIT_SPECTRE'].Index
local iUNIT_SCORPION = GameInfo.Units['SLTH_UNIT_SCORPION'].Index
local iUNIT_AXEMAN = GameInfo.Units['SLTH_UNIT_SWORDSMAN'].Index
local iUNIT_WOLF = GameInfo.Units['SLTH_UNIT_WOLF'].Index
local iUNIT_WOLF_RIDER = GameInfo.Units['SLTH_UNIT_WOLF_RIDER'].Index
local iUNIT_CHAOS_MARAUDER = GameInfo.Units['SLTH_UNIT_CHAOS_MARAUDER'].Index
local iUNIT_MISTFORM = GameInfo.Units['SLTH_UNIT_MISTFORM'].Index
local iUNIT_LION = GameInfo.Units['SLTH_UNIT_LION'].Index
local iUNIT_TIGER = GameInfo.Units['SLTH_UNIT_TIGER'].Index
local iUNIT_BABY_SPIDER = GameInfo.Units['SLTH_UNIT_BABY_SPIDER'].Index
local iUNIT_FAWN = GameInfo.Units['SLTH_UNIT_FAWN'].Index
local iTREANT_INDEX = GameInfo.Units['SLTH_UNIT_TREANT'].Index
local tBigBadWaterLeader = { iUNIT_AZER, iUNIT_SEA_SERPENT, iUNIT_STYGIAN_GUARD, iUNIT_PIRATE}
local tBigBadFailedGraceWaterLeader = { iUNIT_AZER,       iUNIT_SEA_SERPENT, iUNIT_STYGIAN_GUARD, iUNIT_PIRATE,
                                        iUNIT_WATER_ELEM, iUNIT_KRAKEN,      iUNIT_AIRELEM }

local tBigBadWaterHench = { iUNIT_AZER, iUNIT_GRIFFON }
local tBigBadFailedGraceWaterHench = { iUNIT_AZER, iUNIT_GRIFFON, iUNIT_DROWN }

local tBigBadLeader = {iUNIT_ASSASSIN, iUNIT_OGRE, iUNIT_GIANT_SPIDER, iUNIT_HILL_GIANT, iUNIT_SPECTRE, iUNIT_SCORPION}

local tBigBadHench = {iUNIT_AZER, iUNIT_GRIFFON, iUNIT_AXEMAN, iUNIT_WOLF, iUNIT_CHAOS_MARAUDER, iUNIT_WOLF_RIDER,
                      iUNIT_MISTFORM, iUNIT_LION, iUNIT_TIGER, iUNIT_BABY_SPIDER, iUNIT_FAWN, iUNIT_SCORPION
}

local tBigBadFailedGraceLeader = {iUNIT_ASSASSIN, iUNIT_OGRE, iUNIT_GIANT_SPIDER, iUNIT_HILL_GIANT, iUNIT_SPECTRE,
                                  iUNIT_SCORPION, iUNIT_AIRELEM, GameInfo.Units['SLTH_UNIT_EARTH_ELEMENTAL'].Index,
                                  GameInfo.Units['SLTH_UNIT_FIRE_ELEMENTAL'].Index,
                                  GameInfo.Units['SLTH_UNIT_GARGOYLE'].Index, GameInfo.Units['SLTH_UNIT_VAMPIRE'].Index,
                                  GameInfo.Units['SLTH_UNIT_MYCONID'].Index, GameInfo.Units['SLTH_UNIT_EIDOLON'].Index,
                                  GameInfo.Units['SLTH_UNIT_LICH'].Index, GameInfo.Units['SLTH_UNIT_OGRE_WARCHIEF'].Index,
                                  GameInfo.Units['SLTH_UNIT_SATYR'].Index, GameInfo.Units['SLTH_UNIT_WEREWOLF'].Index }

local tBigBadFailedGraceHench = {iUNIT_AZER, iUNIT_GRIFFON, iUNIT_AXEMAN, iUNIT_WOLF, iUNIT_CHAOS_MARAUDER, iUNIT_WOLF_RIDER,
                                 iUNIT_MISTFORM, iUNIT_LION, iUNIT_TIGER, iUNIT_BABY_SPIDER, iUNIT_FAWN, iUNIT_SCORPION,
                                 GameInfo.Units['SLTH_UNIT_OGRE'].Index
}

local tSnowHenchMan = { GameInfo.Units['SLTH_UNIT_FROSTLING_ARCHER'].Index,
                        GameInfo.Units['SLTH_UNIT_FROSTLING_WOLF_RIDER'].Index,
                        GameInfo.Units['SLTH_UNIT_POLAR_BEAR'].Index }

local tArmaLeaders = { GameInfo.Units['SLTH_UNIT_PIT_BEAST'].Index, GameInfo.Units['SLTH_UNIT_DEATH_KNIGHT'].Index,
                           GameInfo.Units['SLTH_UNIT_BALOR'].Index}
local tArmaHench = { iIMP_INDEX, GameInfo.Units['SLTH_UNIT_HELLHOUND'].Index }
local tBarbClanExtraUnits = {
    [TRIBE_CLAN_SKELETON]= {'SLTH_UNIT_SKELETON', 'SLTH_UNIT_PYRE_ZOMBIE'},
    [TRIBE_CLAN_LIZARDMEN]= {'SLTH_UNIT_LIZARDMAN', 'SLTH_UNIT_GORILLA'},

}

local tBarbClanExtraGraceUnits = {
    [TRIBE_CLAN_SKELETON]= {'SLTH_UNIT_WRAITH'},
    [TRIBE_CLAN_LIZARDMEN]= {'SLTH_UNIT_MANTICORE'},
}

local iFEATURE_FOREST = GameInfo.Features['FEATURE_FOREST'].Index
local iSnowTerrain = GameInfo.Terrains['TERRAIN_SNOW'].Index
local iSnowTerrainHills = GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index

function BigBadGroupSpawn(pPlot, pUnit, bGraceFailed, iBarbClanType, iFeatureType, bIsWater)
    local leaderTable, henchTable, iPlayer
    local iChosenLeaderIndex, iChosenLeader, iChosenHenchIndex, iChosenHench
    local playerUnits = Players[63]:GetUnits();
    local iX = pPlot:GetX()
    local iY = pPlot:GetY()
    if bIsWater then
        if bGraceFailed then
            leaderTable = tBigBadFailedGraceWaterLeader
            henchTable = tBigBadFailedGraceWaterHench
        else
            leaderTable = tBigBadWaterLeader
            henchTable = tBigBadWaterHench
        end
    else
        if bGraceFailed then
            leaderTable = tBigBadFailedGraceLeader
            if iFeatureType == iFEATURE_FOREST then                             -- maybe should include ancient forest too
                table.insert(leaderTable, iTREANT_INDEX)
            end
            henchTable = tBigBadFailedGraceHench
            print('failed grace leaders and henchman')
        else
            print('didnt fail grace, leaders and henchman')
            leaderTable = tBigBadLeader
            henchTable = tBigBadHench
            local iTerrain = pPlot:GetTerrainType()
            if (iTerrain == iSnowTerrain) or (iTerrain == iSnowTerrainHills) then
                henchTable = SlthAppend(henchTable, tSnowHenchMan)
            end
            local tExtras = tBarbClanExtraUnits[iBarbClanType]
            if tExtras then
                henchTable = SlthAppend(henchTable, tExtras)
                if bGraceFailed then
                    tExtras = tBarbClanExtraGraceUnits[iBarbClanType]
                    if tExtras then
                        henchTable = SlthAppend(henchTable, tExtras)
                    end
                end
            end
            if Game:GetProperty('ARMAGEDDON') > 40 then
                leaderTable = SlthAppend(leaderTable,tArmaLeaders)
                henchTable = SlthAppend(henchTable,tArmaHench)
            end
        end
    end
    print('doing Lair Event BigBad')
    local bSuccess = DisplaceUnits(pPlot, pUnit, iX, iY)
    if not bSuccess then return; end
    if leaderTable then
        iChosenLeaderIndex = math.random(#leaderTable)
        iChosenLeader = leaderTable[iChosenLeaderIndex]
        playerUnits:Create(iChosenLeader, iX, iY);
    end

    if henchTable then
        iChosenHenchIndex = math.random(#henchTable)
        iChosenHench = henchTable[iChosenHenchIndex]
        for _=1, 5 do
            playerUnits:Create(iChosenHench, iX, iY);
        end
    end
    local sTitle = 'LOC_NOTIFICATION_LAIR_BIGBAD_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_BIGBAD_DESCRIPTION'
    if pUnit then
        iPlayer = pUnit:GetOwner()
    else
        iPlayer = pPlot:GetOwner()
    end
    if iPlayer then
        NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    end
    -- seems like promo list gives a random promo from the list to the leader, TODO
end

local tLairExtraInfos = {['DISEASED'] = 'DISEASED', ['PLAGUED'] = 'PLAGUED', ['POISONED']= 'POISONED',
                         ['WITHERED'] = 'WITHERED', ['BUFF_RUSTED'] = 'RUSTED', ['MUTATED'] = 'BUFF_MUTATED',
                         ['SPIRIT_GUIDE'] = 'BUFF_SPIRIT_GUIDE', ['ENCHANTED_BLADE']='BUFF_ENCHANTED_BLADE',
                         ['SPELLSTAFF'] = 'SLTH_EQUIPMENT_SPELL_STAFF', ['POISONED_BLADE'] = 'ABILITY_POISONED_BLADE',
                         ['FLAMING_ARROWS']='ABILITY_FLAMING_ARROWS', ['SHIELD_OF_FAITH']='BUFF_SHIELD_OF_FAITH',
                         ['MITHRIL_WEAPONS'] = 'ABILITY_MITHRIL_WEAPONS', ['IRON_WEAPONS']= 'ABILITY_IRON_WEAPONS',
                         ['BRONZE_WEAPONS']= 'ABILITY_BRONZE_WEAPONS',

                         ['SPAWN_DROWN']= 'SLTH_UNIT_DROWN', ['SPAWN_SEA_SERPENT']='SLTH_UNIT_SEA_SERPENT',
                         ['SPAWN_SPIDER']= 'SLTH_UNIT_GIANT_SPIDER', ['SPAWN_SPECTRE']='SLTH_UNIT_SPECTRE',
                         ['SPAWN_SKELETON'] = 'SLTH_UNIT_SKELETON', ['SPAWN_LIZARDMAN']= 'SLTH_UNIT_LIZARDMAN',
                         ['SPAWN_FROSTLING']='SLTH_UNIT_FROSTLING', ['SPAWN_SCORPION']= 'SLTH_UNIT_SCORPION',

                         ['PRISONER_DISCIPLE_ASHEN'] = 'SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL',
                         ['PRISONER_DISCIPLE_EMPYREAN'] = 'SLTH_UNIT_DISCIPLE_EMPYREAN',
                         ['SUPPLIES'] = 'SLTH_UNIT_SUPPLIES',
                         ['PRISONER_DISCIPLE_LEAVES'] = 'SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES',
                         ['PRISONER_DISCIPLE_OVERLORDS'] = 'SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS',
                         ['PRISONER_DISCIPLE_RUNES'] = 'SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH',
                         ['PRISONER_DISCIPLE_ORDER'] = 'SLTH_UNIT_DISCIPLE_THE_ORDER',
                         ['PRISONER_SEA_SERPENT'] = 'SLTH_UNIT_SEA_SERPENT',
                         ['PRISONER_ADVENTURER'] = 'UNIT_GREAT_WRITER', ['PRISONER_ARTIST'] = 'UNIT_GREAT_ARTIST',
                         ['PRISONER_COMMANDER'] = 'UNIT_GREAT_GENERAL', ['PRISONER_ENGINEER'] = 'UNIT_GREAT_ENGINEER',
                         ['PRISONER_MERCHANT'] = 'UNIT_GREAT_MERCHANT', ['PRISONER_PROPHET'] = 'UNIT_GREAT_PROPHET',
                         ['PRISONER_SCIENTIST'] = 'UNIT_GREAT_SCIENTIST',

                         ['PRISONER_ANGEL'] = 'SLTH_UNIT_ANGEL', ['PRISONER_MONK'] = 'SLTH_UNIT_MONK',
                         ['PRISONER_ASSASSIN'] = 'SLTH_UNIT_ASSASSIN', ['PRISONER_CHAMPION'] = 'SLTH_UNIT_CHAMPION',
                         ['PRISONER_MAGE'] = 'SLTH_UNIT_MAGE',

                         ['ITEM_JADE_TORC'] = 'SLTH_EQUIPMENT_JADE_TORC',
                         ['ITEM_HEALING_SALVE']='SLTH_EQUIPMENT_HEALING_SALVE',
                         ['ITEM_ROD_OF_WINDS'] = 'SLTH_EQUIPMENT_ROD_OF_WINDS',
                         ['ITEM_TIMOR_MASK'] = 'SLTH_EQUIPMENT_TIMOR_MASK', ['TREASURE'] = 'SLTH_EQUIPMENT_TREASURE',

                         ['BONUS_CLAM'] = 'RESOURCE_CLAM', ['BONUS_CRAB'] = 'RESOURCE_CRABS',
                         ['BONUS_FISH'] = 'RESOURCE_FISH', ['BONUS_COPPER'] = 'RESOURCE_COPPER',
                         ['BONUS_GEMS'] = 'RESOURCE_DIAMONDS', ['BONUS_GOLD'] ='RESOURCE_GOLD',
                         ['BONUS_IRON'] = 'RESOURCE_IRON'}
function onLairTreasureVault(pUnit, pPlot, sEventInfo)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    pPlayer:GetTreasury():ChangeGoldBalance(1000)
end

function onGrantResource(pUnit, pPlot, sEventInfo)
    local iResourceIndex = GameInfo.Resources[sEventInfo].Index
    WorldBuilder.MapManager():SetResourceType(pPlot, iResourceIndex, 1)
end

function onGrantItem(pUnit, pPlot, sEventInfo)
    local sAbility = sEventInfo .. '_ABILITY'
    local pUnitAbilities = pUnit:GetAbility()
    if pUnitAbilities:CanHaveAbility(sAbility) then
        if pUnitAbilities:HasAbility(sAbility) then
            local iPlayer = pUnit:GetOwner()
            local pPlayer = Players[iPlayer]
            local playerUnits = pPlayer:GetUnits()
            local iX, iY = pUnit:GetX(), pUnit:GetY()
            local iUnitIndex = GameInfo.Units[sEventInfo].Index
            playerUnits:Create(iUnitIndex, iX, iY); -- spawn the unit version
        else
            pUnitAbilities:AddAbilityCount(sAbility)
        end
    end
end

function onSpawnBarb(pUnit, pPlot, sUnitType)
    local pBarbPlayer = Players[63]
    local barbUnits = pBarbPlayer:GetUnits();
    local tUnitInfo =  GameInfo.Units[sUnitType]
    if not tUnitInfo then
        print('ERROR. No info for :' .. sUnitType)
        return;
    end
    local iUnitIndex = tUnitInfo.Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    local bSuccess = DisplaceUnits(pPlot, pUnit, iX, iY)
    if not bSuccess then return; end
    barbUnits:Create(iUnitIndex, iX, iY);
end

function onLairGrantGold(pUnit, pPlot, sEventInfo)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    pPlayer:GetTreasury():ChangeGoldBalance(200)                -- should scale this by speed possibly
end

function OnLairGrantExperience(pUnit, pPlot, sEventInfo)
    local pUnitExp = pUnit:GetExperience()
    pUnitExp:ChangeExperience(30)
end

function onLairGrantAbility(pUnit, pPlot, sEventInfo)
    local pUnitAbilities = pUnit:GetAbility()
    pUnitAbilities:AddAbilityCount(sEventInfo)
end

function onGrantUnit(pUnit, pPlot, sUnitType)
    -- print('After event unit is', pUnit)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    local playerUnits = pPlayer:GetUnits();
    local iUnitIndex = GameInfo.Units[sUnitType].Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    playerUnits:Create(iUnitIndex, iX, iY);
end

function onGrantGreatUnit(pUnit, pPlot, sUnitType)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    local playerUnits = pPlayer:GetUnits();
    local iUnitIndex = GameInfo.Units[sUnitType].Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    playerUnits:Create(iUnitIndex, iX, iY);
end

function onLairNothing(pUnit, pPlot, sEventInfo)
    print('roll failed')
end

function onLairKill(pUnit, pPlot, sEventInfo)
    UnitManager.Kill(pUnit)
end

function onLairCollapse(pUnit, pPlot, sEventInfo)
    local iDamageDealt = math.random(50, 90)
    pUnit:ChangeDamage(iDamageDealt)
    if pUnit:GetDamage() < 1 then           -- is it at 0 or at 100?
        UnitManager.Kill(pUnit)
    end
end

function onSpawnBadScorpion(pUnit, pPlot, sEventInfo)
    print('do nothing')
end
function EventCollapse(x, y)
    local pPlot = Map.GetPlot(x, y)
    local tUnits = Map.GetUnitsAt(pPlot)
    for pUnit in tUnits:Units() do
        -- print('remove health')
        pUnit:ChangeDamage(20)
        if pUnit:GetDamage() < 1 then           -- is it at 0 or at 100?
            UnitManager.Kill(pUnit)
        end
    end
end
function SLTH_Todo(pUnit, pPlot, sEventInfo)
    print('placeholder')
end


local tLairEvents = {['DEATH'] = onLairKill, ['COLLAPSE']= onLairCollapse,
                     ['DISEASED'] = onLairGrantAbility, ['PLAGUED'] = onLairGrantAbility,
                     ['POISONED'] = onLairGrantAbility, ['WITHERED'] = onLairGrantAbility,
                     ['RUSTED'] = onLairGrantAbility, ['SPIRIT_GUIDE'] = onLairGrantAbility,
                     ['ENCHANTED_BLADE'] = onLairGrantAbility, ['POISONED_BLADE'] = onLairGrantAbility,
                     ['FLAMING_ARROWS'] = onLairGrantAbility, ['SHIELD_OF_FAITH'] = onLairGrantAbility,
                     ['MITHRIL_WEAPONS'] = onLairGrantAbility, ['IRON_WEAPONS'] = onLairGrantAbility,
                     ['BRONZE_WEAPONS'] = onLairGrantAbility,
                     ['CRAZED'] = SLTH_Todo, ['DEMONIC_POSSESSION'] = SLTH_Todo, ['ENRAGED'] = SLTH_Todo,
                     ['MUTATED'] = SLTH_Todo, ['CAGE'] = SLTH_Todo,

                     ['SPAWN_DROWN'] = onSpawnBarb, ['SPAWN_SEA_SERPENT'] = onSpawnBarb, ['SPAWN_SPIDER']= onSpawnBarb,
                     ['SPAWN_SPECTRE'] = onSpawnBarb, ['SPAWN_SCORPION_BAD'] = onSpawnBadScorpion,
                     ['SPAWN_SKELETON'] = onSpawnBarb, ['SPAWN_LIZARDMAN'] = onSpawnBarb, ['SPAWN_FROSTLING'] = onSpawnBarb,
                     ['SPAWN_SCORPION'] = onSpawnBarb,

                     ['SUPPLIES'] = onGrantUnit, ['PRISONER_DISCIPLE_ASHEN'] = onGrantUnit,
                     ['PRISONER_DISCIPLE_EMPYREAN'] = onGrantUnit, ['PRISONER_DISCIPLE_LEAVES'] = onGrantUnit,
                     ['PRISONER_DISCIPLE_OVERLORDS'] = onGrantUnit, ['PRISONER_DISCIPLE_RUNES'] = onGrantUnit,
                     ['PRISONER_DISCIPLE_ORDER'] = onGrantUnit, ['PRISONER_SEA_SERPENT'] = onGrantUnit,
                     ['PRISONER_ADVENTURER'] = onGrantUnit, ['PRISONER_ARTIST'] = onGrantGreatUnit,
                     ['PRISONER_COMMANDER'] = onGrantGreatUnit, ['PRISONER_ENGINEER'] = onGrantGreatUnit,
                     ['PRISONER_MERCHANT'] = onGrantGreatUnit, ['PRISONER_PROPHET'] = onGrantGreatUnit,
                     ['PRISONER_SCIENTIST'] = onGrantGreatUnit,
                     ['ITEM_HEALING_SALVE'] = onGrantItem, ['ITEM_JADE_TORC'] = onGrantItem,
                     ['ITEM_ROD_OF_WINDS'] = onGrantItem, ['ITEM_TIMOR_MASK'] = onGrantItem,  ['SPELLSTAFF'] = onGrantItem,
                     ['PRISONER_ANGEL'] = onGrantUnit, ['PRISONER_MONK'] = onGrantUnit,
                     ['PRISONER_ASSASSIN'] = onGrantUnit, ['PRISONER_CHAMPION'] = onGrantUnit,
                     ['PRISONER_MAGE'] = onGrantUnit,
                     ['BONUS_CLAM'] = onGrantResource, ['BONUS_CRAB'] = onGrantResource,
                     ['BONUS_FISH'] = onGrantResource, ['BONUS_COPPER'] = onGrantResource, ['BONUS_GEMS'] = onGrantResource,
                     ['BONUS_GOLD'] = onGrantResource, ['BONUS_IRON'] = onGrantResource,
                     ['NOTHING'] = onLairNothing, ['HIGH_GOLD'] = onLairGrantGold,
                     ['TREASURE'] = onGrantUnit, ['EXPERIENCE'] = OnLairGrantExperience,
                     ['DEPTHS'] = SLTH_Todo, ['DWARF_VS_LIZARDMEN'] = SLTH_Todo, ['PORTAL'] = SLTH_Todo,
                     ['TREASURE_VAULT'] = onLairTreasureVault, ['GOLDEN_AGE'] = SLTH_Todo, ['TECH'] = SLTH_Todo}

local tLairDestroyChance = {['DEATH'] = 0, ['COLLAPSE']= 100,
                            ['CRAZED'] = 80, ['DEMONIC_POSSESSION'] = 80, ['ENRAGED'] = 80, ['MUTATED'] = 50,
                            ['DISEASED'] = 80, ['PLAGUED'] = 80, ['POISONED'] = 80, ['WITHERED'] = 80,
                            ['RUSTED'] = 80, ['SPIRIT_GUIDE'] = 80,
                            ['ENCHANTED_BLADE'] = 100, ['POISONED_BLADE'] = 100, ['FLAMING_ARROWS'] = 100,
                            ['SHIELD_OF_FAITH'] = 100,
                            ['MITHRIL_WEAPONS'] = 100, ['IRON_WEAPONS'] = 100, ['BRONZE_WEAPONS'] = 100, ['CAGE'] = 0,

                            ['SPAWN_DROWN'] = 50, ['SPAWN_SEA_SERPENT'] = 50, ['SPAWN_SPIDER'] = 50,
                            ['SPAWN_SPECTRE'] = 50, ['SPAWN_SCORPION_BAD'] = 50,
                            ['SPAWN_SKELETON'] = 50, ['SPAWN_LIZARDMAN'] = 50, ['SPAWN_FROSTLING'] = 50,
                            ['SPAWN_SCORPION'] = 50,

                            ['SUPPLIES'] = 100, ['PRISONER_DISCIPLE_ASHEN'] = 100,
                            ['PRISONER_DISCIPLE_EMPYREAN'] = 100, ['PRISONER_DISCIPLE_LEAVES'] = 100,
                            ['PRISONER_DISCIPLE_OVERLORDS'] = 100, ['PRISONER_DISCIPLE_RUNES'] = 100,
                            ['PRISONER_DISCIPLE_ORDER'] = 100, ['PRISONER_SEA_SERPENT'] = 100,
                            ['PRISONER_ADVENTURER'] = 100, ['PRISONER_ARTIST'] = 100, ['PRISONER_COMMANDER'] = 100,
                            ['PRISONER_ENGINEER'] = 100, ['PRISONER_MERCHANT'] = 100, ['PRISONER_PROPHET'] = 100,
                            ['PRISONER_SCIENTIST'] = 100,
                            ['ITEM_HEALING_SALVE'] = 100, ['ITEM_JADE_TORC'] = 100,
                            ['ITEM_ROD_OF_WINDS'] = 100, ['ITEM_TIMOR_MASK'] = 100,  ['SPELLSTAFF'] = 100,
                            ['PRISONER_ANGEL'] = 100, ['PRISONER_MONK'] = 100,
                            ['PRISONER_ASSASSIN'] = 100, ['PRISONER_CHAMPION'] = 100, ['PRISONER_MAGE'] = 100,
                            ['DEPTHS'] = 0, ['DWARF_VS_LIZARDMEN'] = 100,
                            ['PORTAL'] = 0, ['BONUS_CLAM'] = 100, ['BONUS_CRAB'] = 100,
                            ['BONUS_FISH'] = 100, ['BONUS_COPPER'] = 100, ['BONUS_GEMS'] = 100,
                            ['BONUS_GOLD'] = 100, ['BONUS_IRON'] = 100,
                            ['NOTHING'] = 100, ['HIGH_GOLD'] = 90, ['TREASURE'] = 80,
                            ['EXPERIENCE'] = 100, ['TREASURE_VAULT'] = 100, ['GOLDEN_AGE'] = 100, ['TECH'] = 100}

function doBad(pPlot, iBarbClanType, pUnit, bIsWater)
    local tPossible = {'COLLAPSE'}
    if pUnit then
        local pUnitExp = pUnit:GetExperience()
        if pUnitExp:GetExperienceForNextLevel() == 15 then
            table.insert(tPossible, 'DEATH')
        end
        local iUnitIndex = pUnit:GetType()
        local sUnitName = GameInfo.Units[iUnitIndex].UnitType
        if GameInfo.UnitsNotAlive[sUnitName] then
            tPossible = SlthAppend(tPossible, {'CRAZED', 'DEMONIC_POSSESSION', 'DISEASED', 'ENRAGED',
                                               'PLAGUED', 'POISONED', 'WITHERED'})
        end
        local sPromoClass = GameInfo.Units[iUnitIndex].PromotionClass
        if sPromoClass == 'PROMOTION_CLASS_MELEE' then
            table.insert(tPossible, 'RUSTED')
        end
    end
    if bIsWater then
        tPossible = SlthAppend(tPossible, {'SPAWN_DROWN', 'SPAWN_SEA_SERPENT'})
    else
        tPossible = SlthAppend(tPossible, {'SPAWN_SPIDER', 'SPAWN_SPECTRE'})
    end
    if iBarbClanType == TRIBE_CLAN_SCORPION then
        tPossible = SlthAppend(tPossible, {'SPAWN_SCORPION_BAD', 'SPAWN_SCORPION_BAD', 'SPAWN_SCORPION_BAD'})
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local fEvent = tLairEvents[sEvent]
    local sUnitType = tLairExtraInfos[sEvent]
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    local iPlayer = pUnit:GetOwner()
    NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    local iThreshold = tLairDestroyChance[sEvent]
    return iThreshold
end

function testLairs(pUnit, pPlot)                        -- just for activating in console as debug
    for sEvent, fEvent in pairs(tLairEvents) do
        local sUnitType = tLairExtraInfos[sEvent]
        fEvent(pUnit, pPlot, sUnitType)
    end
end

function doNeutral(pPlot, iBarbClanType, pUnit, bIsWater)
    local tPossible = {'NOTHING'}
    if not bIsWater then
        tPossible = SlthAppend(tPossible, {'SPAWN_SKELETON', 'SPAWN_LIZARDMAN', 'SPAWN_SPIDER', 'PORTAL', 'DEPTHS', 'DWARF_VS_LIZARDMEN', 'CAGE'})
        local iTerrain = pPlot:GetTerrainType()
        if (iTerrain == iSnowTerrain) or (iTerrain == iSnowTerrainHills) then
            table.insert(tPossible, 'SPAWN_FROSTLING')
        end
        if iBarbClanType == TRIBE_CLAN_SKELETON then
            tPossible =  SlthAppend(tPossible, {'SPAWN_SKELETON', 'SPAWN_SKELETON'})
        elseif iBarbClanType == TRIBE_CLAN_LIZARDMEN then
            tPossible =  SlthAppend(tPossible, {'SPAWN_LIZARDMAN', 'SPAWN_LIZARDMAN'})
        elseif iBarbClanType == TRIBE_CLAN_SCORPION then
            tPossible =  SlthAppend(tPossible, {'SPAWN_SCORPION', 'SPAWN_SCORPION', 'SPAWN_SCORPION'})
        end
    else
        table.insert(tPossible, 'SPAWN_DROWN')
    end
    if pUnit then
        local iUnitIndex = pUnit:GetType()
        local sUnitName = GameInfo.Units[iUnitIndex].UnitType
        if GameInfo.UnitsNotAlive[sUnitName] then
            if not pUnitAbilities:HasAbility('BUFF_MUTATED') then           -- todo add buff mutated.
                table.insert(tPossible, 'MUTATED')
            end
        end
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local fEvent = tLairEvents[sEvent]
    local sUnitType = tLairExtraInfos[sEvent]
    fEvent(pUnit, pPlot, sUnitType)
    local iThreshold = tLairDestroyChance[sEvent]
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pPlot:GetX(), pPlot:GetY()
    if pUnit then
        local iPlayer = pUnit:GetOwner()
        NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    end
    return iThreshold
end

local iCIVIC_MYSTICISM = GameInfo.Civics['CIVIC_MYSTICISM'].Index

function doGood(pPlot, pUnit, bIsWater)
    local tPossible =  {'HIGH_GOLD', 'TREASURE', 'EXPERIENCE'}
    local pPlayer, iPlayer
    if pUnit then
        iPlayer = pUnit:GetOwner()
        pPlayer = Players[iPlayer]
        local iUnitIndex = pUnit:GetType()
        local pUnitAbilities = pUnit:GetAbility()
        local tUnitInfos = GameInfo.Units[iUnitIndex]
        local sUnitName = tUnitInfos.UnitType
        local sUnitPromoClass = tUnitInfos.PromotionClass
        if GameInfo.UnitsNotAlive[sUnitName] then
            if not pUnitAbilities:HasAbility('BUFF_SPIRIT_GUIDE') then          -- todo implement
                table.insert(tPossible, 'SPIRIT_GUIDE')
            end
        end

        if sUnitPromoClass == 'PROMOTION_CLASS_MELEE' then
            if not pUnitAbilities:HasAbility('BUFF_ENCHANTED_BLADE') then
                table.insert(tPossible, 'ENCHANTED_BLADE')
            end
        elseif sUnitPromoClass == 'PROMOTION_CLASS_ADEPT' then
            if not pUnitAbilities:HasAbility('SLTH_EQUIPMENT_SPELL_STAFF_ABILITY') then
                table.insert(tPossible, 'SPELLSTAFF')
            end
        elseif sUnitPromoClass == 'PROMOTION_CLASS_RECON' then
            if not pUnitAbilities:HasAbility('ABILITY_POISONED_BLADE') then
                table.insert(tPossible, 'POISONED_BLADE')
            end
        elseif sUnitPromoClass == 'PROMOTION_CLASS_RANGED' then
            if not pUnitAbilities:HasAbility('ABILITY_FLAMING_ARROWS') then
                table.insert(tPossible, 'FLAMING_ARROWS')
            end
        elseif sUnitPromoClass == 'PROMOTION_CLASS_DISCIPLE' then
            if not pUnitAbilities:HasAbility('BUFF_SHIELD_OF_FAITH') then
                table.insert(tPossible, 'SHIELD_OF_FAITH')
            end
        end
        if pUnitAbilities:CanHaveAbility('ABILITY_BRONZE_WEAPONS') then
            if pUnitAbilities:HasAbility('ABILITY_BRONZE_WEAPONS') then
                local pTechs = pPlayer:GetTechs()
                if pUnitAbilities:HasAbility('ABILITY_IRON_WEAPONS') then
                    if not pUnitAbilities:HasAbility('ABILITY_MITHRIL_WEAPONS') then
                        if pUnitAbilities:CanHaveAbility('ABILITY_MITHRIL_WEAPONS') and pTechs:HasTech('TECH_IRON_WORKING') then
                            table.insert(tPossible, 'MITHRIL_WEAPONS')
                        end
                    end
                elseif pUnitAbilities:CanHaveAbility('ABILITY_IRON_WEAPONS') and pTechs:HasTech('TECH_BRONZE_WORKING') then
                    table.insert(tPossible, 'IRON_WEAPONS')
                end
            else
                table.insert(tPossible, 'BRONZE_WEAPONS')
            end
        end
    end
    if not bIsWater then
        tPossible = SlthAppend(tPossible, {'ITEM_HEALING_SALVE', 'SUPPLIES'})
        if not pUnit then
            if pPlot then
                iPlayer = pPlot:GetOwner()
                pPlayer = Players[iPlayer]
            end
        end
        local pCulture = pPlayer:GetCulture()
        if pCulture and pCulture:HasCivic(iCIVIC_MYSTICISM) then
            tPossible = SlthAppend(tPossible, {'PRISONER_DISCIPLE_ASHEN', 'PRISONER_DISCIPLE_EMPYREAN',
                                               'PRISONER_DISCIPLE_LEAVES', 'PRISONER_DISCIPLE_OVERLORDS',
                                               'PRISONER_DISCIPLE_RUNES', 'PRISONER_DISCIPLE_ORDER'})
        end
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local fEvent = tLairEvents[sEvent]
    local sUnitType = tLairExtraInfos[sEvent]
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pPlot:GetX(), pPlot:GetY()
    if pPlayer then
        NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    end
    local iThreshold = tLairDestroyChance[sEvent]
    return iThreshold
end

function doBigGood(pPlot, bGraceFailed, pUnit, bIsWater)
    local iPlayer, pPlayer
    local tPossible = {'TREASURE_VAULT', 'GOLDEN_AGE'}
    if false then         -- was pPlayer.canReceiveGoody(pPlot, gc.getInfoTypeForString('GOODY_GRAVE_TECH'), caster) ???
        table.insert(tPossible, 'TECH')
    end
    if bIsWater then
        table.insert(tPossible, 'PRISONER_SEA_SERPENT')
        if bNoBonusResource then
            tPossible = SlthAppend(tPossible, {'BONUS_CLAM', 'BONUS_CRAB', 'BONUS_FISH'})
        end
    else
        tPossible = SlthAppend(tPossible, {'ITEM_JADE_TORC', 'ITEM_ROD_OF_WINDS', 'ITEM_TIMOR_MASK',
                                           'PRISONER_ADVENTURER', 'PRISONER_ARTIST', 'PRISONER_COMMANDER', 'PRISONER_ENGINEER',
                                           'PRISONER_MERCHANT', 'PRISONER_PROPHET', 'PRISONER_SCIENTIST'})

        if pUnit then
            iPlayer = pUnit:GetOwner()
            pPlayer = Players[iPlayer]
        else
            iPlayer = pPlot:GetOwner()
            pPlayer = Players[iPlayer]
        end
        if pPlayer then
            local pTechs = pPlayer:GetTechs()
            if pTechs:HasTech('TECH_MINING') then
                tPossible = SlthAppend(tPossible, {'BONUS_COPPER', 'BONUS_GEMS', 'BONUS_GOLD'})
                if pTechs:HasTech('TECH_SMELTING') then
                    table.insert(tPossible, 'BONUS_IRON')
                end
            end
        end
    end

    if bGraceFailed then
        tPossible = SlthAppend(tPossible, {'PRISONER_ANGEL', 'PRISONER_MONK', 'PRISONER_ASSASSIN', 'PRISONER_CHAMPION',
                                           'PRISONER_MAGE'})
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local fEvent = tLairEvents[sEvent]
    local sUnitType = tLairExtraInfos[sEvent]
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pPlot:GetX(), pPlot:GetY()
    if iPlayer then
        NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    end
end

local tGameSpeedScalings = {GAMESPEED_ONLINE= 1,
                            GAMESPEED_QUICK= 2,
                            GAMESPEED_STANDARD= 3,
                            GAMESPEED_EPIC= 4,
                            GAMESPEED_MARATHON= 5
}

local hash_GameSpeed = GameConfiguration.GetGameSpeedType()
local name_GameSpeed = GameInfo.GameSpeeds[hash_GameSpeed].GameSpeedType
local iGameSpeed = tGameSpeedScalings[name_GameSpeed]

-- this shit is just super unstable, it triggers twice during the formation of a city over a camp which is really not good.
local sDontDoBarbLairRemoval = 'BarbNoLair_'
function RemovedBarbCamp(x, y, owningPlayerID)
    local pPlot = Map.GetPlot(x, y)
    local iPlotOwner = pPlot:GetOwner()
    local tribeIndex = pPlot:GetProperty('barbclantype')
    local pUnit
    local bIsBarbOccupied = true
    local iPlotID = pPlot:GetIndex()
    local isPartOfCleanup = Game:GetProperty('BarbFree_' .. iPlotID)
    local dontDoLairReveal = Game:GetProperty(sDontDoBarbLairRemoval .. iPlotID)
    local isDisperseCamp = pPlot:GetProperty('DisperseCamp')
    for _, pOnTileUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do
        -- print('units in plot :', pOnTileUnit)
        if (pOnTileUnit) and (not pUnit) then
            local iUnitOwner = pOnTileUnit:GetOwner()
            -- print('unit owner is:', iUnitOwner)
            if iUnitOwner > -1 and iUnitOwner ~= 63 then
                bIsBarbOccupied = false
            end
            pUnit = pOnTileUnit
        end
    end
    print('are we do cleaning up an unplanned barb camp spawn', dontDoLairReveal or isPartOfCleanup)
    if (isPartOfCleanup or dontDoLairReveal) then
        print('had an barb clan improvement spawn naturally that was cleant up, attempting to kill unit and not continue lair spawn')
        if pUnit and tribeIndex then
            UnitManager.Kill(pUnit)
        end
        print('not respawning barb camp.')
        return
    end
    -- print('plotowner/tribeIndex/isBarbOcuppied on destroying improvement...', iPlotOwner, tribeIndex, bIsBarbOccupied)
    --[[
    if tribeIndex then          -- still not perfect, barb camps will be destroyed on settle if a non-barb unit is occupying it
        if iPlotOwner > -1 and bIsBarbOccupied then
            print('spawning tribe because someone owns the plot and a barb unit is on it', iPlotOwner)
            spawnTribeSafe(iPlotID, tribeIndex)
            for _, pOnTileUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do            -- but kill new spawned unit. This also kills any unit you have on there too...
                if pOnTileUnit then
                    local iUnitOwner = pOnTileUnit:GetOwner()
                    if  iUnitOwner == 63 then
                        UnitManager.Kill(pOnTileUnit)
                    end
                end
            end
        end
    else]]if (owningPlayerID == 63 or iPlotOwner == -1) and not dontDoLairReveal and isDisperseCamp then                        -- we do lair clearing
        pPlot:SetProperty('DisperseCamp', nil)
        local iFeatureType = pPlot:GetFeatureType()
        local bIsWater = pPlot:IsWater()
        tribeIndex = pPlot:GetProperty('barbclantype') or 1             -- or logic, unsure why
        local iDiceRoll = math.random(100)
        local iThreshold
        local bGraceFailed
        local iGrace = 20 * iGameSpeed
        local iUnitOwner = pUnit:GetOwner()                 -- assume causer is pUnit owner
        local iDifficultyHash = PlayerConfigurations[iUnitOwner]:GetHandicapTypeID()
        local iPlayerDifficulty = GameInfo.Difficulties[iDifficultyHash].Index
        -- print('difficulty and amount', GameInfo.Difficulties[iDifficultyHash].DifficultyType, iPlayerDifficulty)
        local iDiff =  7 - iPlayerDifficulty        -- converted from python gc.getNumHandicapInfos() + 1 - int(gc.getGame().getHandicapType())
        iGrace = iGrace * iDiff
        print('grace is..', iGrace)
        iGrace = math.random(iGrace) + iGrace
        bGraceFailed = iGrace < Game.GetCurrentGameTurn()     -- if grace fails, we can get baaaad outcomes
        if tBarbNW[iFeatureType] then
            if iDiceRoll < 54 then
                BigBadGroupSpawn(pPlot, pUnit, bGraceFailed, tribeIndex, iFeatureType, bIsWater)
            else
                doBigGood(pPlot, bGraceFailed, pUnit, bIsWater)
            end
            print('spawning tribe because natural wonder exists on plot, superlair')
            spawnTribeSafe(pPlot:GetIndex(), tribeIndex)
        else
            if iDiceRoll < 14 then
                BigBadGroupSpawn(pPlot, pUnit, bGraceFailed, tribeIndex, iFeatureType, bIsWater)
                iThreshold = 0
            elseif iDiceRoll < 44 then
                iThreshold = doBad(pPlot, tribeIndex, pUnit, bIsWater)
            elseif iDiceRoll < 74 then
                iThreshold = doNeutral(pPlot, tribeIndex, pUnit, bIsWater)
            elseif iDiceRoll < 94 then
                iThreshold = doGood(pPlot, pUnit, bIsWater)
            else
                doBigGood(pPlot, bGraceFailed, pUnit, bIsWater)
                iThreshold = 100
            end
            local iDestroyLairDiceRoll = math.random(100)
            if iDestroyLairDiceRoll <= iThreshold then
                print('spawning tribe, as failed destroy dice roll')
                spawnTribeSafe(iPlotID, tribeIndex)
            else
                print('not respawning barb camp')
            end
        end
    else
        print('not respawning barb camp.')
    end
end

function spawnTribeSafe(iPlotID, tribeIndex)
    Game:SetProperty('BarbFree_' .. iPlotID, 1)
    Game.GetBarbarianManager():CreateTribeOfType(tribeIndex, iPlotID)       -- recreate camp
    Game:SetProperty('BarbFree_' .. iPlotID, nil)
end

function deleteTribeSafe(pPlot, playerID)
    local iPlotID = pPlot:GetIndex()
    Game:SetProperty(sDontDoBarbLairRemoval .. iPlotID, 1)
    ImprovementBuilder.SetImprovementType(pPlot, -1, playerID)
    Game:SetProperty(sDontDoBarbLairRemoval .. iPlotID, nil)
end

local tLuonnotar = {
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR'].Index]= {civic=GameInfo.Civics['CIVIC_MYSTICISM'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_ANOINTED'].Index]= {civic=GameInfo.Civics['CIVIC_POLITICAL_PHILOSOPHY'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_BLESSED'].Index]= {civic=GameInfo.Civics['CIVIC_PRIESTHOOD'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_CONSECRATED'].Index]= {civic=GameInfo.Civics['CIVIC_FANATICISM'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_DIVINE'].Index]= {civic=GameInfo.Civics['CIVIC_RIGHTEOUSNESS'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_EXALTED'].Index]= {tech=GameInfo.Technologies['TECH_OMNISCIENCE'].Index}
}

local iLunnotarBlocker = GameInfo.Buildings['BUILDING_BLOCK_ALTAR'].Index
local iAltarBase = GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR'].Index

local tLuonnotarCivics = {
    [GameInfo.Civics['CIVIC_MYSTICISM'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR'].Index,
    [GameInfo.Civics['CIVIC_POLITICAL_PHILOSOPHY'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_ANOINTED'].Index,
    [GameInfo.Civics['CIVIC_PRIESTHOOD'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_BLESSED'].Index,
    [GameInfo.Civics['CIVIC_FANATICISM'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_CONSECRATED'].Index,
    [GameInfo.Civics['CIVIC_RIGHTEOUSNESS'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_DIVINE'].Index,
    [GameInfo.Technologies['TECH_OMNISCIENCE'].Index] = GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_EXALTED'].Index
}
local iPillarOfChains = GameInfo.Buildings['BUILDING_CHICHEN_ITZA'].Index
local iBonePalace = GameInfo.Buildings['BUILDING_TAJ_MAHAL'].Index
local iBuildingPalace = GameInfo.Buildings['BUILDING_PALACE'].Index
-- luonnotar checking, also marking plot prop for pillar of chains, for amenity updates
function BuildingBuilt(playerID, cityID, buildingID, plotID, isOriginalConstruction)
    local tLuonnotarInfo = tLuonnotar[buildingID]
    if tLuonnotarInfo then
        local pPlot = Map.GetPlotByIndex(plotID)
        local iAltarLevel = pPlot:GetProperty('altar_level')
        if not iAltarLevel then
            pPlot:SetProperty('altar_level', 0)
        end
        local iCivicForNext = tLuonnotarInfo['civic']
        local failedCheck
        if iCivicForNext then
            -- check if has culture
            local pPlayer = Players[playerID]
            if not pPlayer then return; end
            local pCulture = pPlayer:GetCulture()
            if not pCulture then return; end
            if not pCulture:HasCivic(iCivicForNext) then
                failedCheck = true
            end
        end
        local iTechForNext = tLuonnotarInfo['tech']
        if iTechForNext then
            local pPlayer = Players[playerID]
            if not pPlayer then return; end
            local pPlayerTechs = pPlayer:GetTechs()
            if not pPlayerTechs then return; end
            if not pPlayerTechs:HasTech(iTechForNext) then
                failedCheck = true
            end
        end
        if failedCheck then
            local pCity = CityManager.GetCity(playerID, cityID)                                         -- this was using Players[playerID], why?
            -- print('player didnt have tech or civic for next lunnotar, blocking with building.')
            pCity:AttachModifierByID('MODIFIER_FREE_SLTH_BUILDING_NO_ALTAR_ALWAYS')         -- makes a building to block the altar, iLunnotarBlocker, BUILDING_BLOCK_ALTAR
        end
    end
    if buildingID == iPillarOfChains then
        Game:SetProperty('PILLAR_OF_CHAINS_OWNER', playerID)
        Game:SetProperty('PILLAR_OF_CHAINS_CITY', cityID)
    end
    if buildingID == iBonePalace then
        GoldenAgeGrant(Players[playerID],10)
    end
    if buildingID == iBuildingPalace then                       -- mostly aesthetic, just ensures science isnt way small before maintenance kicks in on turn 1
        if Game.GetCurrentGameTurn() < 5 then
            local pPlot = Map.GetPlotByIndex(plotID)
            pPlot:SetProperty('CommIntoScience', 9)
            pPlot:SetProperty('CommIntoGold', 1)
        end
    end
end

-- on base Luonnotar building built, an altar level property is set.

-- the luonnotar index is used to find in a table the dummyprereq building for next tier, and the civic it requires
-- if the player has the civic, a property A is set on the city so that next turn, it grants the building. This is so one GP activation doesnt grant them all
-- otherwise, the city has a modifier attached to spawn the dummy that blocks gp activation on the city. CHANGE TO LUA ACTIVATION

-- to deal with the player getting the civic after constructing the building, we attach an event triggering on the
-- the unlocking civics being completed. It iterates over all cities, finds the city with Altar, and removes the blocker

-- we also increment the plotProperty altar_level on activating the GreatProphet. this plotProp is used as a requirement
-- for the modifiers granting altars.

-- on player turn start, i.e. the next turn, iterate over player cities, and if the city has the property A, use it
-- as a modifierID to attach a Modifier onto the city, granting the next dummyprereq.


-- Great general on Mil Strategy
-- Great Bard on Drama
-- there are others im pretty sure one on engineering

local iTechArcaneLore = GameInfo.Technologies['TECH_ARCANE_LORE'].Index
local iTechEngineering = GameInfo.Technologies['TECH_MACHINERY'].Index
local iCivicMilTraining = GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index
local iCivicDrama = GameInfo.Civics['CIVIC_DRAMA_POETRY'].Index
local iCivicMercantilism = GameInfo.Civics['CIVIC_MERCANTILISM'].Index

local iGreatGeneral = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_GENERAL'].Index
local iGreatArtist = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ARTIST'].Index
local iGreatSage = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_SCIENTIST'].Index
local iGreatEngineer = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ENGINEER'].Index
local iGreatMerchant = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_MERCHANT'].Index
local tCivicsGreatPeople = {[iCivicMilTraining] = iGreatGeneral, [iCivicDrama] = iGreatArtist,
                            [iTechArcaneLore] = iGreatSage, [iTechEngineering] = iGreatEngineer,
                            [iCivicMercantilism] = iGreatMerchant
                        }          -- also techs

function grantGreatPersonFirstToTechCivic(civicIndex, gamePropKey, pPlayer, playerID)
    local bMilTrainingDiscovered = Game:GetProperty(gamePropKey)
    if not bMilTrainingDiscovered then
        local pGreatPeople = Game.GetGreatPeople()
        local pTimeline = pGreatPeople:GetTimeline();
        local sGreatPersonType
        for i,entry in ipairs(pTimeline) do
            if entry.Class ==  tCivicsGreatPeople[civicIndex] then
                sGreatPersonType = GameInfo.GreatPersonIndividuals[entry.Individual].GreatPersonIndividualType
            end
        end
        local pCapital = pPlayer:GetCities():GetCapitalCity()
        Game.GetGreatPeople():CreatePerson(playerID, sGreatPersonType, pCapital:GetX(), pCapital:GetY())
        -- grant a modifier to offset additional GP cost as this one is 'free'
        pPlayer:AttachModifierByID('GREATPERSON_GREAT_PERSON_FREE_POINTS')
        Game:SetProperty(gamePropKey, 1)
    end
end

local tORTechs = {
    [GameInfo.Technologies['SLTH_TECH_ARCHERY'].Index] = GameInfo.Technologies['TECH_ARCHERY_SKIP'].Index,
    [GameInfo.Technologies['TECH_OMNISCIENCE'].Index] = GameInfo.Technologies['TECH_OMNISCIENCE_SKIP'].Index,
    [GameInfo.Technologies['TECH_SANITATION'].Index] = GameInfo.Technologies['TECH_SANITATION_SKIP'].Index,
    [GameInfo.Technologies['TECH_SORCERY'].Index] = GameInfo.Technologies['TECH_SORCERY_SKIP'].Index,
    [GameInfo.Technologies['TECH_TRADE'].Index] = GameInfo.Technologies['TECH_TRADE_SKIP'].Index
}
function OnTechnologyResearch(playerID, technologyIndex)
    local pPlayer = Players[playerID]
    local iCurrentLuonnotar = tLuonnotarCivics[technologyIndex]
    if iCurrentLuonnotar then
        -- print('unlocking altar after tech unlock')
        for _, pCity in pPlayer:GetCities():Members() do
            if pCity:GetBuildings():HasBuilding(iCurrentLuonnotar) then
                pCity:GetBuildings():RemoveBuilding(iLunnotarBlocker)           -- removes the building that blocks next altar
                return
            end
        end
    end
    local iOrTechReqIndex = tORTechs[technologyIndex]
    if iOrTechReqIndex then
        -- check player has tech
        local pPlayerTechs = pPlayer:GetTechs()
        if pPlayerTechs then
            local hasTech = pPlayerTechs:HasTech(iOrTechReqIndex)
            if hasTech then
                pPlayerTechs:SetResearchProgress(50)            -- no clue what this does, and i wrote it
            end
        end
    end
    if technologyIndex == iTechArcaneLore then
        grantGreatPersonFirstToTechCivic(technologyIndex, 'ARCANE_LORE_DISCOVERED', pPlayer, playerID)
    elseif technologyIndex == iTechEngineering then
        grantGreatPersonFirstToTechCivic(technologyIndex, 'MACHINERY_DISCOVERED', pPlayer, playerID)
    end
end

function OnCivicGrantFirst(playerID, civicIndex, isCancelled)
    local pPlayer = Players[playerID]
    local iCurrentLuonnotar = tLuonnotarCivics[civicIndex]
    if iCurrentLuonnotar then
        -- print('unlocking altar after civic unlock')
        for _, pCity in pPlayer:GetCities():Members() do
            if pCity:GetBuildings():HasBuilding(iCurrentLuonnotar) then
                pCity:GetBuildings():RemoveBuilding(iLunnotarBlocker)           -- removes the building that blocks next altar
                return
            end
        end
    end
    if civicIndex == iCivicMilTraining then
        grantGreatPersonFirstToTechCivic(civicIndex,'MIL_TRAINING_DISCOVERED', pPlayer, playerID)
    elseif civicIndex == iCivicDrama then
        grantGreatPersonFirstToTechCivic(civicIndex,'DRAMA_DISCOVERED', pPlayer, playerID)
    elseif civicIndex == iCivicMercantilism then
        grantGreatPersonFirstToTechCivic(civicIndex,'MERCANTILISM_DISCOVERED', pPlayer, playerID)
    end
end

local iGreatProphetIndex = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_PROPHET'].Index
function onGreatPersonActivated(unitOwner, unitID, greatPersonClassID, greatPersonIndividualID)
    -- print('Great person activated!', greatPersonClassID)
    if greatPersonClassID == iGreatProphetIndex then
        -- print('Great person recognised as prophet')
        local pPlayerCities = Players[unitOwner]:GetCities()
        for _, pCity in pPlayerCities:Members() do
            if pCity:GetBuildings():HasBuilding(iAltarBase) then
                local pPlot = pCity:GetPlot();
                local iAltarLevel = pPlot:GetProperty('altar_level')
                if iAltarLevel then
                    pPlot:SetProperty('altar_level', iAltarLevel + 1)
                    -- print('plot prop update GP suceeded')
                end
                return
            end
        end
    end
end

-- Gives 2 to 5 new random promotions to the unit from any promotions with bMutation flag set in Civ4PromotionsInfo.xml
-- that are possible (equal chance of each):
-- 'AMPHIBIOUS', 'BLITZ', 'CANNABILIZE', 'COLD_RESISTANCE', 'COMBAT1', 'FIRE_RESISTANCE', 'HEROIC_DEFENSE', 'HEROIC_STRENGTH',
-- 'LIGHTNING_RESISTANCE', 'POISON_RESISTANCE', 'MOBILITY1', 'SENTRY',
-- 'DISEASED', 'BUFF_EMPOWER', 'ABILITY_HEAVY', 'ABILITY_IMMUNE_TO_DISEASE', 'ABILITY_LIGHT', 'BUFF_REGENERATION', 'BUFF_STONESKIN',
-- 'ABILITY_STRONG', 'ABILITY_WEAK', 'VULNERABLE_TO_FIRE', 'WITHERED'

-- VULN_fire will not work as it requires tags
local iABILITY_MUTATED = GameInfo.UnitAbilities['BUFF_MUTATED'].Index
local iABILITY_HASTE = GameInfo.UnitAbilities['BUFF_HASTE'].Index
local iABILITY_FAIR_WINDS = GameInfo.UnitAbilities['BUFF_FAIR_WINDS'].Index
local tMovementBuffAbility = {[iABILITY_HASTE]=1, [iABILITY_FAIR_WINDS]=1}


local iAMPH_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_MELEE'].Index
local iBLITZ_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_BLITZ_MELEE'].Index
local iCANNIBALIZE_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_MELEE'].Index
local iCOLD_RES_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_MELEE'].Index
local iFIRE_RES_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_MELEE'].Index
local iLIGHTNING_RES_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_MELEE'].Index
local iPOISON_RES_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_MELEE'].Index
local iMOBILITY_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_MELEE'].Index
local iSENTRY_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_SENTRY_MELEE'].Index

local tMutationPromotionsMelee = {
    ['AMPHIBIOUS'] = iAMPH_MELEE_INDEX,
    ['BLITZ'] = iBLITZ_MELEE_INDEX,
    ['CANNABILIZE'] = iCANNIBALIZE_MELEE_INDEX,
    ['COLD_RESISTANCE'] = iCOLD_RES_MELEE_INDEX,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_MELEE'].Index,
    ['FIRE_RESISTANCE'] = iFIRE_RES_MELEE_INDEX,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_MELEE'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_MELEE'].Index,
    ['LIGHTNING_RESISTANCE'] = iLIGHTNING_RES_MELEE_INDEX,
    ['POISON_RESISTANCE'] = iPOISON_RES_MELEE_INDEX,
    ['MOBILITY1'] = iMOBILITY_MELEE_INDEX,
    ['SENTRY'] = iSENTRY_MELEE_INDEX
}

local tMutationPromotionsRecon = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_RECON'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_RECON'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_RECON'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_RECON'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_RECON'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_RECON'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_RECON'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_RECON'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_RECON'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_RECON'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_RECON'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_RECON'].Index
}

local tMutationPromotionsRanged = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_RANGED'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_RANGED'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_RANGED'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_RANGED'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_RANGED'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_RANGED'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_RANGED'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_RANGED'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_RANGED'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_RANGED'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_RANGED'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_RANGED'].Index
}

local tMutationPromotionsLightCav = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_LIGHT_CAVALRY'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_LIGHT_CAVALRY'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_LIGHT_CAVALRY'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_LIGHT_CAVALRY'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_LIGHT_CAVALRY'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_LIGHT_CAVALRY'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_LIGHT_CAVALRY'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_LIGHT_CAVALRY'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_LIGHT_CAVALRY'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_LIGHT_CAVALRY'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_LIGHT_CAVALRY'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_LIGHT_CAVALRY'].Index
}

local tMutationPromotionsSiege = {
    ['AMPHIBIOUS'] = iAMPH_MELEE_INDEX,
    ['BLITZ'] = iBLITZ_MELEE_INDEX,
    ['CANNABILIZE'] = iCANNIBALIZE_MELEE_INDEX,
    ['COLD_RESISTANCE'] = iCOLD_RES_MELEE_INDEX,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_SIEGE'].Index,
    ['FIRE_RESISTANCE'] = iFIRE_RES_MELEE_INDEX,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_SIEGE'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_SIEGE'].Index,
    ['LIGHTNING_RESISTANCE'] = iLIGHTNING_RES_MELEE_INDEX,
    ['POISON_RESISTANCE'] = iPOISON_RES_MELEE_INDEX,
    ['MOBILITY1'] = iMOBILITY_MELEE_INDEX,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_SIEGE'].Index
}

local tMutationPromotionsAnimal = {
    ['AMPHIBIOUS']= iAMPH_MELEE_INDEX,
    ['BLITZ'] = iBLITZ_MELEE_INDEX,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_ANIMAL'].Index,
    ['COLD_RESISTANCE'] = iCOLD_RES_MELEE_INDEX,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_ANIMAL'].Index,
    ['FIRE_RESISTANCE'] = iFIRE_RES_MELEE_INDEX,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_ANIMAL'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_ANIMAL'].Index,
    ['LIGHTNING_RESISTANCE'] = iLIGHTNING_RES_MELEE_INDEX,
    ['POISON_RESISTANCE'] = iPOISON_RES_MELEE_INDEX,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_ANIMAL'].Index,
    ['SENTRY'] = iSENTRY_MELEE_INDEX           -- lost
}

local tMutationPromotionsBeast = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_BEAST'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_BEAST'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_BEAST'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_BEAST'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_BEAST'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_BEAST'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_BEAST'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_BEAST'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_BEAST'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_BEAST'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_BEAST'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_BEAST'].Index
}

local tMutationPromotionsAdept = {
    ['AMPHIBIOUS']= iAMPH_MELEE_INDEX,
    ['BLITZ'] = iBLITZ_MELEE_INDEX,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_ADEPT'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_ADEPT'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_ADEPT'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_ADEPT'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_ADEPT'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_ADEPT'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_ADEPT'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_ADEPT'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_ADEPT'].Index,
    ['SENTRY'] = iSENTRY_MELEE_INDEX
}

local tMutationPromotionsDisciple = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_DISCIPLE'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_DISCIPLE'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_DISCIPLE'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_DISCIPLE'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_DISCIPLE'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_DISCIPLE'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_DISCIPLE'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_DISCIPLE'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_DISCIPLE'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_DISCIPLE'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_DISCIPLE'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_DISCIPLE'].Index
}
local tMutationPromoTables = {['PROMOTION_CLASS_MELEE']=tMutationPromotionsMelee,
                              ['PROMOTION_CLASS_RECON']=tMutationPromotionsRecon,
                              ['PROMOTION_CLASS_RANGED']=tMutationPromotionsRanged,
                              ['PROMOTION_CLASS_LIGHT_CAVALRY']=tMutationPromotionsLightCav,
                              ['PROMOTION_CLASS_SIEGE']=tMutationPromotionsSiege,
                              ['PROMOTION_CLASS_ANIMAL']=tMutationPromotionsAnimal,
                              ['PROMOTION_CLASS_BEAST']=tMutationPromotionsBeast,
                              ['PROMOTION_CLASS_ADEPT']=tMutationPromotionsAdept,
                              ['PROMOTION_CLASS_DISCIPLE']=tMutationPromotionsDisciple
}

-- DIDNT bother with PROMOTION_CLASS_NAVAL_MELEE as shouldnt mutate. Should i do this as a SQL table, where each row is a promoclass?
-- wait no as i have to use a . accessor, like rowInfo.SENTRY and that cant be a variable

local tMutationAbilitiesAndPromotions = {
'AMPHIBIOUS', 'BLITZ', 'CANNABILIZE', 'COLD_RESISTANCE', 'COMBAT1', 'FIRE_RESISTANCE', 'HEROIC_DEFENSE', 'HEROIC_STRENGTH',
'LIGHTNING_RESISTANCE', 'POISON_RESISTANCE', 'MOBILITY1', 'SENTRY',
'DISEASED', 'BUFF_EMPOWER', 'ABILITY_HEAVY', 'ABILITY_IMMUNE_TO_DISEASE', 'ABILITY_LIGHT', 'BUFF_REGENERATION', 'BUFF_STONESKIN',
'ABILITY_STRONG', 'ABILITY_WEAK', 'ABILITY_VULNERABLE_TO_FIRE', 'WITHERED'}
local tAbilityMutations = { ['DISEASED'] = true, ['BUFF_EMPOWER'] = true, ['ABILITY_HEAVY'] = true, ['ABILITY_IMMUNE_TO_DISEASE'] = true,
                            ['ABILITY_LIGHT'] = true, ['BUFF_REGENERATION'] = true, ['BUFF_STONESKIN'] = true, ['ABILITY_STRONG'] = true,
                            ['ABILITY_WEAK'] = true, ['ABILITY_VULNERABLE_TO_FIRE'] = true, ['WITHERED'] = true
}
local tFive = {2, 3, 4, 5}
function onAbilityGained(playerID, unitID, unitAbilityIndex)
    -- print(unitAbilityIndex)          -- also do the
    if unitAbilityIndex == iABILITY_MUTATED then
        local pUnit = UnitManager.GetUnit(playerID, unitID)
        local pUnitExp = pUnit:GetExperience()
        local pUnitAbilities = pUnit:GetAbility()
        local iUnitIndex = pUnit:GetType()
        local tUnitInfos = GameInfo.Units[iUnitIndex]
        local sUnitPromoClass = tUnitInfos.PromotionClass
        local tClassPromos = tMutationPromoTables[sUnitPromoClass]
        local iNumMutations = tFive[math.random(table.count(tFive))]
        local tMutationSelection = tMutationAbilitiesAndPromotions
        local iMutationSuccesses = 0
        for var=1, 10 do
            if iMutationSuccesses <= iNumMutations then
                local iMutationIndex = math.random(table.count(tMutationSelection))
                local sMutationGrant = tMutationSelection[iMutationIndex]
                table.remove(tMutationSelection, iMutationIndex)
                if tAbilityMutations[sMutationGrant] then
                    if not pUnitAbilities:HasAbility(sMutationGrant) then
                        pUnitAbilities:AddAbilityCount(sMutationGrant)
                        iMutationSuccesses = iMutationSuccesses + 1
                    end
                else
                    local iPromoGrant = tClassPromos[sMutationGrant]
                    if not pUnitExp:HasPromotion(iPromoGrant) then
                        pUnitExp:SetPromotion(iPromoGrant)
                        iMutationSuccesses = iMutationSuccesses + 1
                    end
                end
            end
        end
    end
    if tMovementBuffAbility[unitAbilityIndex] then
        local pUnit = UnitManager.GetUnit(playerID, unitID)
        UnitManager.ChangeMovesRemaining(pUnit, tMovementBuffAbility[unitAbilityIndex]);
    end
end

-- im not sure these even existed in base FFH
function InitializeClans()
    if not Game.GetProperty('Init_Barbs_Killed') then
        for _, pUnit in Players[63]:GetUnits():Members() do
            UnitManager.Kill(pUnit)
        end
        Game:SetProperty('Init_Barbs_Killed', 1)
    end

end

local iCIVIC_ANCIENT_CHANTS = GameInfo.Civics['CIVIC_ANCIENT_CHANTS'].Index
local tFreeAncientChants = {SLTH_CIVILIZATION_AMURITES=iCIVIC_ANCIENT_CHANTS, SLTH_CIVILIZATION_ELOHIM=iCIVIC_ANCIENT_CHANTS,
                            SLTH_CIVILIZATION_MALAKIM=iCIVIC_ANCIENT_CHANTS, SLTH_CIVILIZATION_SHEAIM=iCIVIC_ANCIENT_CHANTS,
                            SLTH_CIVILIZATION_SIDAR = iCIVIC_ANCIENT_CHANTS
}
function InitializeFreeCivics()
    if Game.GetCurrentGameTurn() == 1 then
        for playerId, pPlayer in ipairs(Players) do
            local civName = PlayerConfigurations[playerId]:GetCivilizationTypeName()
            if tFreeAncientChants[civName] then
                local pCivics = pPlayer:GetCulture()
                pCivics:SetCivic(tFreeAncientChants[civName], true)
            end
        end
    end
end
tNoBuildDistricts = {['DISTRICT_WONDER']=true, ['DISTRICT_CITY_CENTER']=true}
tDistricts = {}
for row in GameInfo.Districts() do
    if not tNoBuildDistricts[row.DistrictType] then
        tDistricts[row.Index] = row.DistrictType
    end
end

function OnCityProductionChanged( ePlayer, cityID, productionID, objectID)
	print('city prod changed, productionid', productionID, 'objectID', objectID)
    -- check what city is making
    local pCity = CityManager.GetCity(ePlayer, cityID)
    if pCity then
        local pDistricts = pCity:GetDistricts()
        if pDistricts then
            for DistrictIndex, DistrictType in pairs(tDistricts) do
                print('checking if city has', DistrictType)
                local hasDistrict = pDistricts:GetDistrict(DistrictIndex)
                print('do have?', hasDistrict)
                if hasDistrict then
                    local isComplete = hasDistrict:IsComplete()
                    print('is complete?', isComplete)
                    if not isComplete then
                        local pBuildQueue = pCity:GetBuildQueue()
                        local buildCurrent = pBuildQueue:CurrentlyBuilding()
                        print('currently building', buildCurrent)
                        -- CurrentlyBuilding
                        if DistrictType == buildCurrent then
                            pBuildQueue:FinishProgress()
                        end
                    end
                end
            end
        end
    end
end


-- Hook in events
function onStart()
    GameEvents.PlayerTurnStarted.Add(onTurnStartGameplay);
    Events.ImprovementChanged.Add(ImprovementsWorkOrPillageChange)
    Events.ImprovementAddedToMap.Add(InitCottage)

    Events.CivicCompleted.Add(OnCivicGrantFirst)
    Events.ResearchCompleted.Add(OnTechnologyResearch)
    Events.ImprovementRemovedFromMap.Add(RemovedBarbCamp)
    GameEvents.BuildingConstructed.Add(BuildingBuilt)
    Events.UnitGreatPersonActivated.Add(onGreatPersonActivated)
    Events.UnitAbilityGained.Add(onAbilityGained)
    GameEvents.SlthOnConvertUnitType.Add(ConvertUnitType)
    Events.CityProductionChanged.Add(OnCityProductionChanged);

    InitializeClans()
    InitializeFreeCivics()
    print('-----------------Gameplay loaded')
end

-- WORLDSPELLS
local sWorldSpellPropKey = 'WorldSpellReady'

local iDEMAGOG_INDEX = GameInfo.Units['SLTH_UNIT_DEMAGOG'].Index
local function Rally(iPlayer, tParameters)
	-- denagog in every city, degrade each town to village and get demagog
	-- requires crusade TODO
    -- iterate over each of player city
    local pPlayer = Players[iPlayer]
    local playerUnits = pPlayer:GetUnits();
    for _, pCity in pPlayer:GetCities():Members() do
        local tOwnedPlots = pCity:GetOwnedPlots()
        for idx, pPlot in ipairs(tOwnedPlots) do
            if pPlot then
                local eImprovement = pPlot:GetImprovementType();
                if (eImprovement == iTOWN_INDEX) then
                    -- make demagog unit
                    -- displace enemy units if on tile?
                    local iX = pPlot:GetX()
                    local iY = pPlot:GetY()
                    for _, pNearUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do
                        if (pNearUnit) then
                            local iOwnerPlayer = pNearUnit:GetOwner();
                            if (iOwnerPlayer ~= iPlayer) then
                                DisplaceUnits(pPlot, pNearUnit, iX, iY)
                            end
                        end
                    end
                    playerUnits:Create(iDEMAGOG_INDEX, iX, iY);
                    ImprovementBuilder.SetImprovementType(pPlot, iVILLAGE_INDEX, iPlayer)
                end
            end
        end
    end
    NotifyAllHumans(Locale.Lookup('LOC_WORLDSPELL_RALLY_NOTIFICATION_TITLE'), Locale.Lookup('LOC_WORLDSPELL_RALLY_NOTIFICATION_DESCRIPTION'))
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end
local iESUS_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_ESUS'].Index
local iOCTOPUS_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_OCTOPUS'].Index
local iEMPYREAN_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_EMPYREAN'].Index
local iRUNES_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_RUNES'].Index
local iORDER_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_ORDER'].Index
local iVEIL_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_VEIL'].Index
local iLEAVES_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_LEAVES'].Index
local iNO_STATE_RELIGION_INDEX = GameInfo.Policies['SLTH_POLICY_NO_STATE_RELIGION'].Index

local iVEIL_RELIGION_INDEX = GameInfo.Religions["RELIGION_BUDDHISM"].Index
local tReligionPolicies = {iESUS_INDEX, iOCTOPUS_INDEX, iEMPYREAN_INDEX, iRUNES_INDEX, iORDER_INDEX,
                           iVEIL_INDEX, iLEAVES_INDEX, iNO_STATE_RELIGION_INDEX}

local tReligionMap = {[iESUS_INDEX]=GameInfo.Religions["RELIGION_ISLAM"].Index,
                      [iOCTOPUS_INDEX]=GameInfo.Religions["RELIGION_HINDUISM"].Index,
                      [iEMPYREAN_INDEX]=GameInfo.Religions["RELIGION_JUDAISM"].Index,
                      [iRUNES_INDEX]=GameInfo.Religions["RELIGION_CONFUCIANISM"].Index,
                      [iORDER_INDEX]=GameInfo.Religions["RELIGION_PROTESTANTISM"].Index,
                      [iVEIL_INDEX]=iVEIL_RELIGION_INDEX,
                      [iLEAVES_INDEX]=GameInfo.Religions["RELIGION_CATHOLICISM"].Index
}
local tReligionPriests = {[iESUS_INDEX]=GameInfo.Units['SLTH_UNIT_NIGHTWATCH'].Index,
                          [iOCTOPUS_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_OVERLORDS'].Index,
                          [iEMPYREAN_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_EMPYREAN'].Index,
                          [iRUNES_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_KILMORPH'].Index,
                          [iORDER_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_ORDER'].Index,
                          [iVEIL_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_VEIL'].Index,
                          [iLEAVES_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_LEAVES'].Index
}
local function ReligiousFervor(iPlayer, tParameters)
    -- Grants one priest of the state religion per city, with experience equal
    -- to the number of cities in the Malakim civilization with the state religion.
    local pPlayer = Players[iPlayer]
    local pCulture = pPlayer:GetCulture()
    local playerUnits = pPlayer:GetUnits()
    local iStateReligion
    for idx, iPolicyIndex in ipairs(tReligionPolicies) do
        if not iStateReligion then
            if pCulture:IsPolicyActive(iPolicyIndex) then
                iStateReligion = iPolicyIndex
            end
        end
    end
    if iStateReligion == iNO_STATE_RELIGION_INDEX then return; end;
    local iReligionToCheck = tReligionMap[iStateReligion]
    local iPriestGrantIndex = tReligionPriests[iStateReligion]
    local iStateReligionCities = 0
    local tReligions = Game.GetReligion():GetReligions()
    local cachedUnits = {}
    for idx, pUnit in pPlayer:GetUnits():Members() do cachedUnits[idx] = true; end
    for _, pCity in pPlayer:GetCities():Members() do
        local pPlot = pCity:GetPlot();
        local iX = pPlot:GetX()
        local iY = pPlot:GetY()
        playerUnits:Create(iPriestGrantIndex, iX, iY);
        local pCityReligion = pCity:GetReligion()
        for _, tReligion in pairs(tReligions) do
            local iReligion = tReligion.Religion
            if iReligion == iReligionToCheck then
                local iNumFollowers = pCityReligion:GetNumFollowers(iReligion)
                if iNumFollowers > 0 then
                    iStateReligionCities = iStateReligionCities + 1
                end
            end
        end
    end
    print('state religion policy is ' .. tostring(iStateReligion))
    print('state religion is ' .. tostring(iReligionToCheck))
    print('state religion cities is' .. tostring(iStateReligionCities))
    for id, pUnit in pPlayer:GetUnits():Members() do
        if (not cachedUnits[id]) then
            print('new unit!')
            local pUnitExp = pUnit:GetExperience()
            pUnitExp:ChangeExperience(iStateReligionCities * 2)
        end
    end
    NotifyAllHumans(Locale.Lookup('LOC_WORLDSPELL_RELIGIOUS_FERVOR_NOTIFICATION_TITLE'), Locale.Lookup('LOC_WORLDSPELL_RELIGIOUS_FERVOR_NOTIFICATION_DESCRIPTION'))
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end


local iFEATURE_ANCIENT_FOREST = GameInfo.Features['FEATURE_FOREST_ANCIENT'].Index
local function MarchOfTheTrees(iPlayer, tParameters)
	-- All forests and ancient forests in your cultural borders will turn into new forests, and create a Treant on the tile,
    -- provided it is not occupied by an enemy.
	-- After 5 turns, all the Treants will disappear. (N.B. does treant death advance forest growth?

    -- get all forest, ancient forest in civ
    -- reduce to new forest, or forest
    -- spawn treants, give treants duration 5.

    -- waiting for new forest/growth mechanics
    local pPlayer = Players[iPlayer]
    local playerUnits = pPlayer:GetUnits()
    local cachedUnits = {}
    for idx, pUnit in playerUnits:Members() do cachedUnits[idx] = true; end
    for _, pCity in pPlayer:GetCities():Members() do
        local tOwnedPlots = pCity:GetOwnedPlots()
        for _, pPlot in ipairs(tOwnedPlots) do
            local iFeatureType = pPlot:GetFeatureType()
            if iFeatureType == iFEATURE_FOREST then
                TerrainBuilder.SetFeatureType(pPlot, -1)                -- does this work
                playerUnits:Create(iTREANT_INDEX, pPlot:GetX(), pPlot:GetY());
            elseif iFeatureType == iFEATURE_ANCIENT_FOREST then
                TerrainBuilder.SetFeatureType(pPlot, iFEATURE_FOREST)
                playerUnits:Create(iTREANT_INDEX, pPlot:GetX(), pPlot:GetY());
            end
        end
    end
    local tNewUnits
    for id, pUnit in pPlayer:GetUnits():Members() do
        if (not cachedUnits[id]) then
            print('new unit, setting lifespan')
            pUnit:SetProperty('LifespanRemaining', 5)
        end
    end
    NotifyAllHumans(Locale.Lookup('LOC_WORLDSPELL_MARCH_OF_THE_TREES_NOTIFICATION_TITLE'), Locale.Lookup('LOC_WORLDSPELL_MARCH_OF_THE_TREES_NOTIFICATION_DESCRIPTION'))
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

local iMINE_INDEX = GameInfo.Improvements['IMPROVEMENT_MINE'].Index
local tFlatlands = {
                        [GameInfo.Terrains['TERRAIN_GRASS'].Index] = GameInfo.Terrains['TERRAIN_GRASS_HILLS'].Index,
                        [GameInfo.Terrains['TERRAIN_PLAINS'].Index] = GameInfo.Terrains['TERRAIN_PLAINS_HILLS'].Index,
                        [GameInfo.Terrains['TERRAIN_DESERT'].Index] = GameInfo.Terrains['TERRAIN_DESERT_HILLS'].Index,
                        [GameInfo.Terrains['TERRAIN_TUNDRA'].Index] = GameInfo.Terrains['TERRAIN_TUNDRA_HILLS'].Index,
                        [iSnowTerrain] = iSnowTerrainHills
    }
local function MotherLode(iPlayer, tParameters)
	-- he Mother Lode spell provides your empire with 25 gold for each mine in your cultural borders.
	-- For each flatlands square you own (Grassland, Plains, Desert, Tundra, Ice), there is a 10% chance of it turning into a hill. This includes Flood Plains.
    local pPlayer = Players[iPlayer]
    local iMineCount = 0
    -- section, converting flatlands to mountains
    local iThreshold = 90
    for _, pCity in pPlayer:GetCities():Members() do
        local tOwnedPlots = pCity:GetOwnedPlots()
        for idx, pPlot in ipairs(tOwnedPlots) do
            local iCurrentTerrain = pPlot:GetTerrainType()
            local iNewTerrain = tFlatlands[iCurrentTerrain]
            if (iNewTerrain) then           -- many rolls      and (math.random(100) > iThreshold)
                TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                print(idx)
            end
            local eImprovement = pPlot:GetImprovementType();
            if (eImprovement == iMINE_INDEX) then
                iMineCount = iMineCount + 1
            end
        end
    end
    if iMineCount > 0 then
        pPlayer:GetTreasury():ChangeGoldBalance(iMineCount * 25)
    end
    NotifyAllHumans(Locale.Lookup('LOC_WORLDSPELL_MOTHER_LODE_NOTIFICATION_TITLE'), Locale.Lookup('LOC_WORLDSPELL_MOTHER_LODE_NOTIFICATION_DESCRIPTION'))
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end


local function ArcaneLacuna(iPlayer, tParameters)
	-- . Prevents all spells from being cast, spell casters, priests, demons, or even your world spell can't be used. Not including Amurites?
    -- count mana in empire
    local pPlayer = Players[iPlayer]
    local iExpToGrant = 0
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    if pCapitalCity then
        local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
        for idx, sResourceName in ipairs(tResourcePropKeys) do
            local iResource = pCapitalPlot:GetProperty(sResourceName) or 0;
            iExpToGrant = iExpToGrant + iResource
        end
    end
    print(iExpToGrant)
    for _, pUnit in pPlayer:GetUnits():Members() do
        local iUnitIndex = pUnit:GetType()
        if tArcaneUnits[iUnitIndex] then
            pUnit:GetExperience():ChangeExperience(iExpToGrant);
        end
    end
    -- give xp to each adept unit
    -- get delay amount based on speed
    local eGameSpeed = GameConfiguration.GetGameSpeedType()            -- this is actually a hash not a string return. But cant find the enum for it
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier
    local iDelay = 20 * iSpeedCostMultiplier
    Game:SetProperty('ARCANE_LACUNA_COUNTDOWN', iDelay)
    Game:SetProperty('ARCANE_LACUNA_CASTER', iPlayer)
    -- go through all spell units, set their castable to 0
    for iPlayerIndex, pOtherPlayer in ipairs(Players) do
        if iPlayerIndex ~= iPlayer then
            if pOtherPlayer then
                local pOtherUnits = pOtherPlayer:GetUnits()
                if pOtherUnits then
                    for _, pUnit in pOtherUnits:Members() do
                        if pUnit:GetProperty('HasCast') then
                            pUnit:SetProperty('HasCast', 1)
                        end
                    end
                end
            end
        end
    end
    NotifyAllHumans(Locale.Lookup('LOC_WORLDSPELL_ARCANE_LACUNA_NOTIFICATION_TITLE'), Locale.Lookup('LOC_WORLDSPELL_ARCANE_LACUNA_NOTIFICATION_DESCRIPTION'))
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function WildHunt(iPlayer, tParameters)
	-- Grant a wolf for each combat unit you have. Wolf strength proportional to unit strength.
    local pPlayer = Players[iPlayer]
    local tCachedUnits = {}
    for _, pUnit in pPlayer:GetUnits():Members() do
        table.insert(tCachedUnits, pUnit)
    end
    for _, pUnit in ipairs(tCachedUnits) do
        local tNewUnits = BaseSummon(pUnit, iPlayer, iUNIT_WOLF)
        local iCombatStrength = pUnit:GetCombat()
        if iCombatStrength > 15 then
            local iExtraStrength = (iCombatStrength - 10) / 2
            local iMinorGrants = math.floor(iExtraStrength / 4)
            if iMinorGrants > 0 then
                for iUnitID, pWolfUnit in pairs(tNewUnits) do
                    local pUnitAbilities = pWolfUnit:GetAbility()
                    for var=1, iMinorGrants do
                        pUnitAbilities:AddAbilityCount('BUFF_EMPOWER')
                    end
                end
            end
        end
    end
    NotifyAllHumans(Locale.Lookup('LOC_WORLDSPELL_WILD_HUNT_NOTIFICATION_TITLE'), Locale.Lookup('LOC_WORLDSPELL_WILD_HUNT_NOTIFICATION_DESCRIPTION'))
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function Revelry(iPlayer, tParameters)            -- TODO
	-- Double length Golden age. Needs to check gamespeed for golden age speed. then fix golden age granting.
    local pPlayer = Players[iPlayer]
    GoldenAgeGrant(pPlayer,20)
    NotifyAllHumans(Locale.Lookup('LOC_WORLDSPELL_REVELRY_NOTIFICATION_TITLE'), Locale.Lookup('LOC_WORLDSPELL_REVELRY_NOTIFICATION_DESCRIPTION'))
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

local function ForTheHorde(iPlayer, tParameters)                -- TODO
    print('doing For the Horde spell')
	-- Convert half of the barbarians in the game to your control
    -- get barbarian units total
    -- get half that integer, iterate up to that point converting the units?
    -- converting is awkward, dll examples have been done with gifting.
    local pBarbPlayer = Players[63]
    local pBarbUnits = pBarbPlayer:GetUnits()
    local iBarbCount = pBarbUnits:GetCount()
    local iBarbsToConvert = math.ceil(iBarbCount / 2)
    local iIterCount = 0
    for iUnitID, pUnit in pBarbUnits:Members() do
        if iIterCount < iBarbsToConvert then
            if pUnit then
                local iUnitIndex = pUnit:GetType()
                local iHealth, iX, iY, tPromos, tAbilities = InheritUnitAttributes(63, iUnitID)
                pUnit:ChangeDamage(100);
                if pUnit:GetDamage() >= 100 then
                    UnitManager.Kill(pUnit, false);
                end
                print(iX)
                print(iY)
                local tNewUnits = SimpleSummon(iX, iY, iPlayer, iUnitIndex)
                ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
            end
            iIterCount = iIterCount + 1
        end
    end
    NotifyAllHumans(Locale.Lookup('LOC_WORLDSPELL_FOR_THE_HORDE_NOTIFICATION_TITLE'), Locale.Lookup('LOC_WORLDSPELL_FOR_THE_HORDE_NOTIFICATION_DESCRIPTION'))
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

-- world spells
GameEvents.SlthOnRally.Add(Rally);
GameEvents.SlthOnReligiousFervor.Add(ReligiousFervor);
GameEvents.SlthOnMarchOfTheTrees.Add(MarchOfTheTrees);
GameEvents.SlthOnMotherLode.Add(MotherLode);
GameEvents.SlthOnArcaneLacuna.Add(ArcaneLacuna);
GameEvents.SlthOnWildHunt.Add(WildHunt);
GameEvents.SlthOnForTheHorde.Add(ForTheHorde);
GameEvents.SlthOnRevelry.Add(Revelry);

onStart()