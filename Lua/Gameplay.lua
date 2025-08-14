include('WorldSpellSupport')
include('SpawnSupport')
include('Lairs')

include("GameCapabilities");                -- NOT SURE IF exists outside of UI

local FreeXPUnits = { SLTH_UNIT_ADEPT = 8, SLTH_UNIT_IMP = 8, SLTH_UNIT_SHAMAN = 8, SLTH_UNIT_ARCHMAGE = 16, SLTH_UNIT_EATER_OF_DREAMS = 16,
                      SLTH_UNIT_CORLINDALE = 8, SLTH_UNIT_DISCIPLE_OF_ACHERON = 8, SLTH_UNIT_GAELAN = 12, SLTH_UNIT_GIBBON = 8,
                      SLTH_UNIT_GOVANNON = 8, SLTH_UNIT_HEMAH = 8, SLTH_UNIT_LICH = 16, SLTH_UNIT_ILLUSIONIST = 12, SLTH_UNIT_MAGE = 12,
                      SLTH_UNIT_WIZARD = 12, SLTH_UNIT_MOBIUS_WITCH = 12, SLTH_UNIT_MOKKA = 12, SLTH_UNIT_SON_OF_THE_INFERNO = 16}
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
                        setPlayerPropForRequirementsCapital(pCountdownPlayer, pCapitalPlot, plotPropKey, 0)
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
            local iX = pCapitalCity:GetX()
            local iY = pCapitalCity:GetY()
            local pCapitalPlot = Map.GetPlot(iX, iY)
            local countDownDelay = pCapitalPlot:GetProperty(countdown_propKey)
            if countDownDelay and countDownDelay > 1 then
                setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, countdown_propKey, countDownDelay - 1)
            elseif countDownDelay and countDownDelay == 1 then
                setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, countdown_propKey, countDownDelay - 1)
                -- turn off property in all city centre plots
                 for _, pCity in pPlayer:GetCities():Members() do
                    local pPlot = pCity:GetPlot();
                    if pPlot then
                        pPlot:SetProperty(plotPropKey, 0);
                    end
                end
                if countdown_propKey == 'GoldenAgeDuration' then
                    local iPlayer = pPlayer:GetID()
                    local pConfig = PlayerConfigurations[iPlayer]
                    local sLeaderType = pConfig:GetLeaderTypeName()
                    local notificationData = {[ParameterTypes.MESSAGE]=Locale.Lookup('LOC_GOLDEN_AGE_ENDED_NOTIFICATION_TITLE'),
                                              [ParameterTypes.SUMMARY]=Locale.Lookup('LOC_GOLDEN_AGE_ENDED_NOTIFICATION_DESCRIPTION', sLeaderType, "'s")
                    }
                    -- notify yourself differently
                    NotifyMetHumans(iPlayer, notificationData, iX, iY)
                    notificationData[ParameterTypes.SUMMARY] = Locale.Lookup('LOC_GOLDEN_AGE_ENDED_NOTIFICATION_DESCRIPTION', 'Your', '')
                    NotifySelf(iPlayer, notificationData)
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


local tTraitPropKeys = {
        SELECTED_AGGRESSIVE=true,
        SELECTED_ARCANE=true,
        SELECTED_CHARISMATIC=true,
        SELECTED_CREATIVE=true,
        SELECTED_DEFENDER=true,
        SELECTED_EXPANSIVE=true,
        SELECTED_FINANCIAL=true,
        SELECTED_INDUSTRIOUS=true,
        SELECTED_ORGANIZED=true,
        SELECTED_PHILOSOPHICAL=true,
        SELECTED_RAIDERS=true,
        SELECTED_SPIRITUAL=true,
        SELECTED_SUMMONER=true
    }

local tTraitPropStrings = {
        SELECTED_AGGRESSIVE='Aggressive',
        SELECTED_ARCANE='Arcane',
        SELECTED_CHARISMATIC='Charismatic',
        SELECTED_CREATIVE='Creative',
        SELECTED_DEFENDER='Defender',
        SELECTED_EXPANSIVE='Expansive',
        SELECTED_FINANCIAL='Financial',
        SELECTED_INDUSTRIOUS='Industrious',
        SELECTED_ORGANIZED='Organized',
        SELECTED_PHILOSOPHICAL='Philosophical',
        SELECTED_RAIDERS='Raiders',
        SELECTED_SPIRITUAL='Spiritual',
        SELECTED_SUMMONER='Summoner'
    }


function getCurrentTraits(pPlayer)
    local tCurrentTraits = {}
    local tIndexedCurrentTraits = {}
    for propKey, _ in pairs(tTraitPropKeys) do
        local iTraitActive = pPlayer:GetProperty(propKey)
        if iTraitActive and iTraitActive > 0 then
            tCurrentTraits[propKey] = true
            table.insert(tIndexedCurrentTraits, tTraitPropStrings[propKey])
        end
    end
    return tCurrentTraits, tIndexedCurrentTraits
end

local iGameSpeedMult = GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier / 100
local tTrackBuff = {[GameInfo.UnitAbilities['BUFF_CRAZED'].Index]='BUFF_CRAZED',
                    [GameInfo.UnitAbilities['BUFF_ENRAGED'].Index]='BUFF_ENRAGED'}
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
            if pUnitAbilities and pUnitAbilities:HasAbility('BUFF_CRAZED') and not pUnitAbilities:HasAbility('BUFF_ENRAGED') then
                local iRoll = math.random(100)
                if iRoll >= 10 then
                    pUnitAbilities:AddAbilityCount('BUFF_ENRAGED')
                end
            end
            if pUnitAbilities and pUnitAbilities:HasAbility('BUFF_ENRAGED') then
                -- enraged
                print('do enraged stuff, move towards nearest enemy, or move into fog of war to find enemies')
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
    if HasTrait("SLTH_TRAIT_INSANE", playerId) then
        if math.random(100) < 2 then
            print('doing insane change trait')
            local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
            if pCapitalCity then
                local pCapitalPlot = pCapitalCity:GetPlot()
                local tCurrentTraits, tNotifyStrings = getCurrentTraits(pPlayer)
                local tPossibleNewTraits = {}
                for propKey, _ in pairs(tTraitPropKeys) do
                    if not tCurrentTraits[propKey] then
                        table.insert(tPossibleNewTraits, propKey)
                        print('possible to get this trait', propKey)
                    end
                end
                local tNewTraits = {}
                for propKey, _ in pairs(tCurrentTraits) do
                    print('changing current trait', propKey)
                    local iChoice = math.random(#tPossibleNewTraits)
                    local sNewTrait = tPossibleNewTraits[iChoice]
                    table.remove(tPossibleNewTraits, iChoice)
                    tNewTraits[propKey] = sNewTrait
                    table.insert(tNotifyStrings, tTraitPropStrings[sNewTrait])
                    print('choosing this trait', tTraitPropStrings[sNewTrait])
                end
                -- now the payoff
                for oldPropKey, newPropKey in pairs(tNewTraits) do
                    setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, oldPropKey, 0)
                    setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, newPropKey, 1)
                end
                -- finally, notify
                local pConfig = PlayerConfigurations[playerId]
                local sLeaderType = pConfig:GetLeaderTypeName()
                print('trying to do summary, args',tNotifyStrings[1],
                                                tNotifyStrings[2], tNotifyStrings[3], tNotifyStrings[4], tNotifyStrings[5],
                                                tNotifyStrings[6])
                local sSummary = Locale.Lookup('LOC_INSANE_CHANGE_TRAIT_NOTIFICATION_DESCRIPTION', 'Your', '', tNotifyStrings[1],
                                                tNotifyStrings[2], tNotifyStrings[3], tNotifyStrings[4], tNotifyStrings[5],
                                                tNotifyStrings[6])
                local notificationData = {[ParameterTypes.MESSAGE]=Locale.Lookup('LOC_INSANE_CHANGE_TRAIT_NOTIFICATION_TITLE', 'You', 'have'),
                                          [ParameterTypes.SUMMARY]=sSummary
                }
                NotifySelf(playerId, notificationData)
                sSummary = Locale.Lookup('LOC_INSANE_CHANGE_TRAIT_NOTIFICATION_DESCRIPTION', sLeaderType, "'s", tNotifyStrings[1],
                                                tNotifyStrings[2], tNotifyStrings[3], tNotifyStrings[4], tNotifyStrings[5],
                                                tNotifyStrings[6])
                notificationData = {[ParameterTypes.MESSAGE]=Locale.Lookup('LOC_INSANE_CHANGE_TRAIT_NOTIFICATION_TITLE', sLeaderType, 'has'),
                                    [ParameterTypes.SUMMARY]=sSummary
                }
                NotifyMetHumans(playerId, notificationData, pCapitalPlot:GetX(), pCapitalPlot:GetY())               -- LEADER_NAME traits have changed from x, y, z to a, b, c
            end
        end
    end
    if HasTrait("SLTH_TRAIT_ADAPTIVE", playerId) then
        local iCurrentTurn = Game.GetCurrentGameTurn()
        if iCurrentTurn == 100 then
            -- offerChangeTrait()
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
    if tribeIndex then          -- still not perfect, barb camps will be destroyed on settle if a non-barb unit is occupying it         -- REMOVED because instability
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
    else]]
    if (owningPlayerID == 63 or iPlotOwner == -1) and not dontDoLairReveal and isDisperseCamp then                        -- we do lair clearing
        lairRoll(pPlot, pUnit)
    else
        print('not respawning barb camp. not triggering lair roll')
    end
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
        GoldenAgeGrant(playerID,10)
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
    print('adding abilities', unitAbilityIndex)          -- also do the
    if unitAbilityIndex == iABILITY_MUTATED then
        print('doing mutatation!')
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
        local iBar = 0
        if unitAbilityIndex == iABILITY_FAIR_WINDS then
            local pPlot = Map.GetPlot(pUnit:GetX(), pUnit:GetY())
            if pPlot:IsWater() then
                iBar = 1
            end
        else
            iBar = 1
        end
        if iBar > 1 then
            UnitManager.ChangeMovesRemaining(pUnit, tMovementBuffAbility[unitAbilityIndex]);
        end
    end
    if tTrackBuff[unitAbilityIndex] then
        local pPlayer = Players[playerID]
        local sAbilityName = tTrackBuff[unitAbilityIndex] .. '_UNITS'
        local tTrackedAbility = pPlayer:GetProperty(sAbilityName) or {}
        tTrackedAbility[unitID] = true
        pPlayer:SetProperty(sAbilityName, tTrackedAbility)
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
local tStartingTraitsInsane = { 'SELECTED_ARCANE', 'SELECTED_CHARISMATIC', 'SELECTED_CREATIVE' }
function IntializeVariableTraits()
    if Game.GetCurrentGameTurn() == 1 then
        for playerId, pPlayer in ipairs(Players) do
            if pPlayer:IsMajor() then
                if HasTrait("SLTH_TRAIT_INSANE", playerId) then
                    for _, propKey in ipairs(tStartingTraitsInsane) do
                        setPlayerPropForRequirements(playerId, propKey, 1)
                    end
                elseif HasTrait("SLTH_TRAIT_ADAPTIVE", playerId) then
                    setPlayerPropForRequirements(playerId, 'SELECTED_PHILOSOPHICAL', 1)
                end
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
    IntializeVariableTraits()
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
    GoldenAgeGrant(iPlayer,20)
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