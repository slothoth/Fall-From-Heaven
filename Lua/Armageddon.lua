-- [ ] Hijack Global Warming panel. We probably just steal the UI design of it.
-- [ ] actions that happen once counter reaches certain value     Lua: Event : PlayerTurnStarted check if some property has reached a point. Actually where would I store state, there is no Game:SetProperty()
 --[ ]  Attach some Projects when armageddon hits 70. To do not unlock, need it to be pPlot:SetProperty() on capital

tArmageddonEvents = {[10]=fWarning,[30]=Blight, [40]=ArmaSummonSteph, [50]=ArmaSummonBuboes, [60]=ArmaSummonYersinia,
                     [70]=ArmaSummonArs,  [90]=ArmaSpawnWrath, [100]=ArmaKillHalf}
-- helper
function reverse_table(t)
    local reversed = {}
    for k, v in pairs(t) do
        reversed[v] = k
    end
    return reversed
end


function AdjustArmageddonCount(iAmount)
    local iArmageddonCount = Game.GetProperty('ARMAGEDDON')
    if iArmageddonCount then
        local iNewArmageddonCount = iArmageddonCount + iAmount
        Game.SetProperty('ARMAGEDDON', iNewArmageddonCount)
        local iArmaEventTracker = Game.GetProperty('ARMAGEDDON_event_count') or 0
        local doEvent = 0
        for idx, fEvent in ipairs(tArmageddonEvents) do
            if doEvent > 0 then
                Game.SetProperty('ARMAGEDDON_event_count', idx)
                fEvent()
                break
            end
            if idx < iArmageddonCount and iNewArmageddonCount > idx then
                if idx > iArmaEventTracker then
                    doEvent = 1
                end
            end
        end
        if (iArmageddonCount < 70) and (iNewArmageddonCount >= 70) then
            local pFirstPlayer = next(PlayerManager.GetAliveMajors())
            local iHasHitSeventy = pFirstPlayer:GetProperty('ArmageddonAboveSeventy')
            if not iHasHitSeventy then
                for _, pPlayer in ipairs(PlayerManager.GetAliveMajors()) do
                    pPlayer:SetProperty('ArmageddonAboveSeventy', 1)
                end
            end
        end
    else
        print('Armageddon count not initilized!')
    end
end

-- Razing city Event, placing city ruins
local iCityCenter = GameInfo.Districts["DISTRICT_CITY_CENTER"].Index
local iCityRuins = GameInfo.Improvements['IMPROVEMENT_CITY_RUINS'].Index
local iReligionVeil = tostring(GameInfo.Religions["RELIGION_BUDDHISM"].Index)..'_HOLY_CITY'

-- nicked from Sui Generis steppe function
function OnCityRaze(playerID, districtID, icityID, idistrictX, idistrictY, iDistrictType)
	if iDistrictType == iCityCenter then
		print ("City Center Removed")

		local iTurn = Game.GetCurrentGameTurn()

		local iAlreadyDeletedCheck = Game:GetProperty("SteppeCityRemoved" .. idistrictX .. "_" .. idistrictY)

		if iAlreadyDeletedCheck ~= iTurn then -- has not already been removed this turn
			Game:SetProperty("SteppeCityRemoved".. idistrictX.. "_".. idistrictY, iTurn)
			print ("city removed for the first time this turn!")
		else -- has already been removed this turn
			print ("city removed for the second(!) time this turn!")
            local bConquerChecker = true
            local tUnitsInTile = Units.GetUnitsInPlotLayerID(idistrictX, idistrictY, mapLayerAny)
            if tUnitsInTile then
                for k, pUnit in ipairs(tUnitsInTile) do
                    if pUnit:GetType() then
                        local pUnitOwner = pUnit:GetOwner()
                        if pUnitOwner then
                            --print (pUnitOwner)
                            if pUnitOwner ~= playerID then
                                bConquerChecker = false
                                print ("uh-oh! a foreign unit is in the city! Guess it wasn't razed then!")
                            else
                                print ("this city is owned by the civ that lost the city- good!")
                            end
                        end
                    end
                end
            end

            if bConquerChecker == true then
                local pPlayer = Players[playerID];
                local pPlot = Map.GetPlot(idistrictX, idistrictY)
                ImprovementBuilder.SetImprovementType(pPlot, iCityRuins, 63)     -- barb
                local bIsVeilHoly = pPlot:GetProperty(iReligionVeil)
                if bIsVeilHoly and bIsVeilHoly > 0 then
                    AdjustArmageddonCount(-5)
                else
                    AdjustArmageddonCount(1)            -- can also do if majority religion veil, do -1
                end
                local pCity = CityManager.GetCity(pPlayer, icityID)
                for iBuildingIndex, iArmageddonChange in pairs(tArmageddonBuildings) do
                    if pCity:GetBuildings():HasBuilding(iBuildingIndex) then
                        AdjustArmageddonCount(-iArmageddonChange)
                    end
                end
            end
		end
	end
end

-- unit tracker, create increase armageddon, delete decrease
-- not doing 'BASIUM:5', 'HYBOREM:5' as covered in spawning civ
local tArmageddonUnits = {['SLTH_UNIT_BEAST_OF_AGARES']=1, ['SLTH_UNIT_ROSIER']=2, ['SLTH_UNIT_EIDOLON']=1,
                    ['SLTH_UNIT_WRATH']=3,  ['SLTH_UNIT_MARDERO']=3, ['SLTH_UNIT_MESHABBER']=3,
                    ['SLTH_UNIT_SPHENER']=-3, ['SLTH_UNIT_VALIN']=-2}
function ArmageddonUnitSpawning(playerID, unitID)
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local sUnitType = pUnit:GetUnitType()
    local iArmageddonCountRaise = tArmageddonUnits[sUnitType]
    if iArmageddonCountRaise then
        AdjustArmageddonCount(iArmageddonCountRaise)
    end
    local bHasProphecyMark = pUnit:GetAbility():HasAbility('ABILITY_PROPHECY_MARK')
    if bHasProphecyMark then
        AdjustArmageddonCount(1)
    end
end

function ArmageddonUnitDied(killedPlayerID, killedUnitID, playerID, unitID)
    local pUnit = UnitManager.GetUnit(killedPlayerID, killedUnitID);
    local bHasProphecyMark = pUnit:GetAbility():HasAbility('ABILITY_PROPHECY_MARK')
    if bHasProphecyMark then
        AdjustArmageddonCount(-1)
    end
end
-- building tracker, create increase armageddon, delete decrease
local tArmageddonBuildings = {[GameInfo.Buildings['PILLAR_OF_CHAINS'].Index]=4,
                        [GameInfo.Buildings['STIGMATA_FROM_UNBORN'].Index]=5}

function ArmageddonBuildingMade(playerID, cityID, buildingID, plotID, isOriginalConstruction)
    -- buildingID is hopefully Buildings.Index?
    local iArmaggeddonChange = tArmageddonBuildings[buildingID]
    if iArmaggeddonChange then
        AdjustArmageddonCount(iArmaggeddonChange)
    end
end
-- covered destroyed buildings in city raze logic


function customFunc(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
end
-- helper
function selectPercentage(sourceTable, percentage)
    local result = {}
    local numElements = math.ceil(#sourceTable * (percentage / 100))
    -- Create a copy of indices to randomly select from
    local indices = {}
    for i = 1, #sourceTable do
        indices[i] = i
    end

    -- Randomly select elements
    for i = 1, numElements do
        -- Get a random index from our remaining indices
        local randomIndex = math.random(1, #indices)
        -- Add the element at that index to our result
        result[i] = sourceTable[indices[randomIndex]]
        -- Remove the used index to avoid duplicates
        table.remove(indices, randomIndex)
    end
    return result
end

local iSamhainUnitSpawnPercent = 10
local iFROSTLING_INDEX = GameInfo.Units['SLTH_UNIT_FROSTLING'].Index
local iFROSTLING_ARCHER_INDEX = GameInfo.Units['SLTH_UNIT_FROSTLING_ARCHER'].Index
local iFROSTLING_RIDER_INDEX = GameInfo.Units['SLTH_UNIT_FROSTLING_WOLF_RIDER'].Index
local tFrostlingProportions = {iFROSTLING_INDEX, iFROSTLING_ARCHER_INDEX, iFROSTLING_RIDER_INDEX, iFROSTLING_INDEX}
function Samhain(playerID, cityID, projectID, buildingIndex, x, y)
    -- get number of units to spawn based on viable plots
    local tEligiblePlots = ViableWildernessPlots(true)

    local tUsedPlots = selectPercentage(tEligiblePlots, iSamhainUnitSpawnPercent)
    tUsedPlots = SpawnUnitInWilderness(GameInfo.Units['SLTH_UNIT_MOKKA'].Index, tEligiblePlots)
    local iLoopIterations = math.floor(#tUsedPlots / # tFrostlingProportions)
    for var=0, iLoopIterations do
        for _, iUnitToSpawnIndex in ipairs(tFrostlingProportions) do
            tUsedPlots = SpawnUnitInWilderness(iUnitToSpawnIndex, tUsedPlots)
        end
    end
    -- Spawn frostling barbarian units in some tundra and snow tiles.
    -- spawn Mokka barbarian
end

-- not bothering with mountains right now
-- also not affecting hell terrain for now
local iGRASSLAND = GameInfo.Terrains['TERRAIN_GRASS'].Index
local iGRASSLAND_HILLS = GameInfo.Terrains['TERRAIN_GRASS_HILLS'].Index
local iPLAINS = GameInfo.Terrains['TERRAIN_PLAINS'].Index
local iPLAINS_HILLS = GameInfo.Terrains['TERRAIN_PLAINS_HILLS'].Index
local iDESERT = GameInfo.Terrains['TERRAIN_DESERT'].Index
local iDESERT_HILLS = GameInfo.Terrains['TERRAIN_DESERT_HILLS'].Index
local iTUNDRA = GameInfo.Terrains['TERRAIN_TUNDRA'].Index
local iTUNDRA_HILLS = GameInfo.Terrains['TERRAIN_TUNDRA_HILLS'].Index
local tPlotsByTerrainType = {
                                [iGRASSLAND] = {},
                                [iGRASSLAND_HILLS] = {},
                                [iPLAINS] = {},
                                [iPLAINS_HILLS] = {},
                                [iDESERT] = {},
                                [iDESERT_HILLS] = {},
                                [iTUNDRA] = {},
                                [iTUNDRA_HILLS] = {},
}
local tPlotConversionDeepeningMap = {
                                [iGRASSLAND] = iTUNDRA,
                                [iGRASSLAND_HILLS] = iTUNDRA_HILLS,
                                [iPLAINS] = iTUNDRA,
                                [iPLAINS_HILLS] = iTUNDRA_HILLS,
                                [iDESERT] = iPLAINS,
                                [iDESERT_HILLS] = iPLAINS_HILLS,
                                [iTUNDRA] = GameInfo.Terrains['TERRAIN_SNOW'].Index,
                                [iTUNDRA_HILLS] = GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index
}
local iPlotProportionChanged = 20
function Deepening(playerID, cityID, projectID, buildingIndex, x, y)
    local iTerrainType
    local tMapPlots = Map.Plots()
    local iCount = 1
    for _, iPlotIndex in ipairs(tMapPlots) do
        local pPlot = Map.GetPlotByIndex(iPlotIndex)
        if (pPlot ~= nil) then
            iTerrainType = pPlot:GetTerrainType()
            if tPlotsByTerrainType[iTerrainType] then
                table.insert(tPlotsByTerrainType[iTerrainType], iPlotIndex)
            end
        end
    end
    local tPlotsToChange, iNewTerrainIndex, pPlot
    for idx, tPlotTable in ipairs(tPlotConversionDeepeningMap) do
        tPlotsToChange = selectPercentage(tPlotTable, iPlotProportionChanged)
        iNewTerrainIndex = tPlotConversionDeepeningMap[idx]
        for _, iPlotIndex in ipairs(tPlotsToChange) do
            pPlot = Map.GetPlotByIndex(iPlotIndex)
            TerrainBuilder.SetTerrainType(pPlot, iNewTerrainIndex)
        end
    end
    -- When it is completed, the entire world will be cooled down - changing some of the deserts to plains,
    -- some of the plains and grassland to tundra, and some of the tundra to snow tiles.
end

function TheDraw(playerID, cityID, projectID, buildingIndex, x, y)
    local pPlayer = Players[playerID];
    local pDiplo = pPlayer:GetDiplomacy()
    local pAllMajors = PlayerManager.GetAliveMajorIDs();            -- just hating on all civs
    for k, iterPlayerID in ipairs(pAllMajors) do
        if (pPlayer:GetID() ~= iterPlayerID) then
            pDiplo:SetHasMet(iterPlayerID);
            pDiplo:DeclareWarOn(iterPlayerID, WarTypes.FORMAL_WAR, true);           -- Illians will declare war on all other civilizations
            pDiplo:NeverMakePeaceWith(iterPlayerID);
            local pOtherPlayer = Players[iterPlayerID];
            if(pOtherPlayer ~= nil) then
                local pOtherDiplo = pOtherPlayer:GetDiplomacy();
                if(pOtherDiplo ~= nil) then
                    pOtherDiplo:NeverMakePeaceWith(playerID);    -- The Illians cannot attempt diplomacy after the Draw has been completed.
                end
            end
        end
    end
    local pPlayerCities = pPlayer:GetCities()
    local iCityPop
    local iPopReduction
    for idx, pCity in pPlayerCities:Members() do
        iCityPop = pCity:GetPopulation()
        if iCityPop > 1 then
            iPopReduction = math.floor(iCityPop / 2) * -1
            if iPopReduction < 0 then
                pCity:ChangePopulation(iPopReduction)       -- the population of all Illian cities will be halved
            end
        end
    end
end

function Ascension(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Give Godslayer to highest Score/ Highest military strength
    -- annoying as its pPlayer:GetStats():GetMilitaryStrength() which is UI only
end

local tBaneDivineMap = {
    [GameInfo.Units['SLTH_UNIT_PRIEST_OF_KILMORPH'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH'].Index,
    [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_OVERLORDS'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS'].Index,
    [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_ORDER'].Index] = GameInfo .Units['SLTH_UNIT_DISCIPLE_THE_ORDER'].Index,
    [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_VEIL'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL'].Index,
    [GameInfo.Units['SLTH_UNIT_PRIEST_OF_LEAVES'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES'].Index,
    [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_EMPYREAN'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_EMPYREAN'].Index,
    [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH'].Index,
    [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS'].Index,
    [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_EMPYREAN'].Index,
    [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER'].Index] = GameInfo .Units['SLTH_UNIT_DISCIPLE_THE_ORDER'].Index,
    [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL'].Index,
    [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_LEAVES'].Index] = GameInfo.Units['SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES'].Index
}     -- All Disciple Units in the world are replaced with Tier 1 Disciples of the same religion
function BaneDivine(playerID, cityID, projectID, buildingIndex, x, y)
    local pPlayer = Players[playerID]
    local playerUnits = pPlayer:GetUnits();
    for _, pUnit in pPlayer:GetUnits():Members() do
        local iUnitIndex = pUnit:GetType();
        local iDiscipleIndex = tBaneDivineMap[iUnitIndex]
        local iX =  pUnit:GetX()
        local iY =  pUnit:GetY()
        playerUnits:Create(iDiscipleIndex, iX, iY);
        UnitManager.Kill(pUnit)
    end
end

function BirthrightRegained(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Set Player Property that controls if can do world spell
end

local m_iFOREST_FEATURE = GameInfo.Features['FEATURE_FOREST'].Index
function Genesis(playerID, cityID, projectID, buildingIndex, x, y)
    -- All owned tiles have Vitalize cast upon them, if tile is grassland with no improvments Bloom is cast
    -- Vitalize: Converts Snow-Tundra, Tundra - Plains, Desert - Plains, Plains - Grassland, Grassland gets Forest
    -- loop over all player plots
    local tPlots
    local iCurrentTerrain
    local TerrainTransformInfo
    local sNewTerrain
    local iNewTerrainIndex
    local pPlayer = Players[playerID]
    local pPlayerCities = pPlayer:GetCities();
    local tCachedTerrains                               -- saves GameInfo lookups
    for idx, pCity in pPlayerCities:Members() do
        tPlots = pCity:GetOwnedPlots()
        for _, pPlot in ipairs(tPlots) do
            iCurrentTerrain = pPlot:GetTerrainType()
            TerrainTransformInfo = GameInfo.TerrainTransforms[iCurrentTerrain]
            sNewTerrain = TerrainTransformInfo.VitalizeTo
            if sNewTerrain then
                iNewTerrainIndex = tCachedTerrains[sNewTerrain]
                if not iNewTerrainIndex then
                    iNewTerrainIndex = GameInfo.Terrains[sNewTerrain].Index
                    tCachedTerrains[sNewTerrain] = iNewTerrainIndex
                end
                TerrainBuilder.SetTerrainType(pPlot, iNewTerrainIndex)
            end
            if sNewTerrain == 'TERRAIN_GRASS_HILLS' or sNewTerrain == 'TERRAIN_GRASS' then
                TerrainBuilder.SetFeatureType(pPlot, m_iFOREST_FEATURE)
            end
        end
    end
    --
end

local iBEAR_INDEX = GameInfo.Units['SLTH_UNIT_BEAR'].Index
local iWOLF_INDEX = GameInfo.Units['SLTH_UNIT_WOLF'].Index
local iLION_INDEX = GameInfo.Units['SLTH_UNIT_LION'].Index
local iTIGER_INDEX = GameInfo.Units['SLTH_UNIT_TIGER'].Index
local tBarbarianAnimalMap = {[GameInfo.Units['UNIT_BUILDER'].Index] = iWOLF_INDEX,
                             [GameInfo.Units['SLTH_UNIT_GOBLIN'].Index] = iLION_INDEX,
                             [GameInfo.Units['SLTH_UNIT_ARCHER_SCORPION_CLAN'].Index] = iLION_INDEX,
                             [GameInfo.Units['UNIT_WARRIOR'].Index] = iLION_INDEX,
                             [GameInfo.Units['SLTH_UNIT_LIZARDMAN'].Index] = iTIGER_INDEX,
                             [GameInfo.Units['SLTH_UNIT_SWORDSMAN'].Index] = iBEAR_INDEX
    }
local tAnimals = {
    [GameInfo.Units['SLTH_UNIT_BABY_SPIDER'].Index] = true,
    [iBEAR_INDEX] = true,
    [GameInfo.Units['SLTH_UNIT_POLAR_BEAR'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_ELEPHANT'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_GIANT_SPIDER'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_GIANT_TORTOISE'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_GORILLA'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_GRIFFON'].Index] = true,
    [iLION_INDEX] = true,
    [GameInfo.Units['SLTH_UNIT_LION_PRIDE'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_SEA_SERPENT'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_SCORPION'].Index] = true,
    [iWOLF_INDEX] = true,
    [GameInfo.Units['SLTH_UNIT_WOLF_PACK'].Index] = true,
    [iTIGER_INDEX] = true
}

local tExclusionList = {
                            [GameInfo.Units['SLTH_UNIT_ACHERON'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_ARS'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_BUBOES'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_STEPHANOS'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_GURID'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_KRAKEN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_LEVIATHAN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_MARGALARD'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_MANTICORE'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_MOKKA'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_ORTHUS'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_TUMTUM'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_WRATH'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_YERSINIA'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_AZER'].Index] = true
}
                                    -- we also need to apply this to city states that are actually barbarians
local tAnimalPromotions = {[1] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_ANIMAL'].Index,
                           [2] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH2_ANIMAL'].Index,
                           [3] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_ANIMAL'].Index,
                           [4] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE2_ANIMAL'].Index
}
function NaturesRevolt(playerID, cityID, projectID, buildingIndex, x, y)
    -- Turns Barbarian units into Animals
    --            Worker-> Wolf, Goblin-> Lion, Warrior-> Lion, Lizardman->Tiger, Axeman->Bear
    --            wtf happens to skeletons, to goblin archers, currently set to bears and lions respectively
    --All animals in the world receive Heroic Strength I, Heroic Strength II, Heroic Defense I, and Heroic Defense II
    local iX, iY, pUnitExp, pPlayerUnits, iUnitIndex
    local tMinorPlayers = PlayerManager.GetAliveMinors()        -- we are doing city states because they are barbarians
    table.insert(tMinorPlayers, Players[63])                -- include barbarian units
    for _, pPlayer in ipairs(tMinorPlayers) do
        local pUnits =  pPlayer:GetUnits()
        for _, pUnit in pUnits:Members() do
            iUnitIndex = pUnit:GetType()
            local iAnimalUnitIndex = tBarbarianAnimalMap[iUnitIndex]
            if not iAnimalUnitIndex then
                if not tAnimals[iUnitIndex] and not tExclusionList[iUnitIndex] then   -- check its not already an animal or beast or demon or apoc
                    iAnimalUnitIndex = iBEAR_INDEX                                    -- otherwise default to bear
                end
            end
            if iAnimalUnitIndex then
                iX = pUnit:GetX()
                iY = pUnit:GetY()
                UnitManager.Kill(pUnit);
                pUnits:Create(iAnimalUnitIndex, iX, iY);
            end
        end
    end
    -- iterate over all animal units granting them relevant promotions
    for _, pPlayer in ipairs(Players) do
        pPlayerUnits = pPlayer:GetUnits()
        for _, pUnit in pPlayerUnits:Members() do
            iUnitIndex = pUnit:GetType()
            if tAnimals[iUnitIndex] then
                pUnitExp = pUnit:GetExperience()
                for _, iPromotionIndex in ipairs(tAnimalPromotions) do
                    if not pUnitExp:HasPromotion(iPromotionIndex) then
                        pUnitExp:SetPromotion(iPromotionIndex, true)
                    end
                end
            end
        end
    end
end

-- Helper function
function contains(table, value)
    for _, v in ipairs(table) do
        if v == value then return true end
    end
    return false
end

function selectEquidistantPoints(validPlots, width, height, count)          -- need to test this its GPT
    local points = {}
    local candidates = {}
    -- Convert to x,y coordinates
    for index in pairs(validPlots) do
        local x = 1 + (index-1) % width
        local y = 1 + math.floor((index-1) / width)
        table.insert(candidates, {x=x, y=y, index=index})
    end

    -- Select first point               .. isnt this always the first plot in the table? does that matter?
    points[1] = candidates[1].index

    -- Select remaining points maximizing minimum distance to existing points
    for i = 2, count do
        local bestCandidate = nil
        local maxMinDist = 0

        for _, candidate in ipairs(candidates) do
            if not contains(points, candidate.index) then
                local minDist = math.huge
                for _, selectedIndex in ipairs(points) do
                    local sx = 1 + (selectedIndex-1) % width
                    local sy = 1 + math.floor((selectedIndex-1) / width)
                    local dist = math.sqrt((candidate.x-sx)^2 + (candidate.y-sy)^2)
                    minDist = math.min(minDist, dist)
                end
                if minDist > maxMinDist then
                    maxMinDist = minDist
                    bestCandidate = candidate.index
                end
            end
        end
        points[i] = bestCandidate
    end
    return points
end

local tMapSizeManaCount = {[0]=4, [1]=5, [2]=6, [3]=7, [4]=8, [5]= 10}      -- assuming these are
local iRAW_MANA_INDEX = GameInfo.Resources['RESOURCE_MANA'].Index
function RitesOghma(playerID, cityID, projectID, buildingIndex, x, y)
    local pPlot
    local iMapSize = Map.GetMapSize()                       -- returns an index, need to check they are correct
    local iResourceCount = tMapSizeManaCount[iMapSize]
    local iW, iH = Map.GetGridSize();
    local tAllPlots = Map.Plots()
    local tValidResourcePlots = {}
    for _, iPlotIndex in ipairs(tAllPlots) do
        pPlot = Map.GetPlotByIndex(iPlotIndex)
        if (pPlot ~= nil) then
            if (pPlot:IsMountain() == false) and (pPlot:IsWater() == false) and (pPlot:IsNaturalWonder() == false) and (pPlot:IsImpassable() == false) and (pPlot:IsCity() == false) then
                tValidResourcePlots[iPlotIndex] = true
            end
        end
    end
    local tPlotsToPlaceMana = selectEquidistantPoints(tValidResourcePlots, iW, iH, iResourceCount)
    for _, iPlotIndex in ipairs(tPlotsToPlaceMana) do
        pPlot = Map.GetPlotByIndex(iPlotIndex)
        TerrainBuilder.SetResourceType(pPlot, iRAW_MANA_INDEX, 1)       -- what is ResourceAmount
        TerrainBuilder.CanHaveResource(pPlot, iRAW_MANA_INDEX)
    end
    -- get map size MapConfiguration.GetValue(""), need to find what value. cant use MapConfiguration.GetMapSize() as its UI onlu
    -- distribute resource throughout map
    --  Grant Manas           Duel: 4, Tiny: 5, Small: 6, Standard: 7, Large: 8, Huge: 10
end

local tPolicyReligionMap = {[GameInfo.Policies['SLTH_POLICY_STATE_ESUS'].Index]     = 'RELIGION_ISLAM',
                            [GameInfo.Policies['SLTH_POLICY_STATE_OCTOPUS'].Index]  = 'RELIGION_HINDUISM',
                            [GameInfo.Policies['SLTH_POLICY_STATE_EMPYREAN'].Index] = 'RELIGION_JUDAISM',
                            [GameInfo.Policies['SLTH_POLICY_STATE_RUNES'].Index]    = 'RELIGION_CONFUCIANISM',
                            [GameInfo.Policies['SLTH_POLICY_STATE_ORDER'].Index]    = 'RELIGION_PROTESTANTISM',
                            [GameInfo.Policies['SLTH_POLICY_STATE_VEIL'].Index]     = 'RELIGION_BUDDHISM',
                            [GameInfo.Policies['SLTH_POLICY_STATE_LEAVES'].Index]   = 'RELIGION_CATHOLICISM',
                            [GameInfo.Policies['SLTH_POLICY_NO_STATE_RELIGION'].Index]   = 'NO_RELIGION'}

function PurgeUnfaithful(playerID, cityID, projectID, buildingIndex, x, y)
    --   	Removes any non-state Religions and religious buildings from all cities
    --      Causes revolts in cities where multiple religions are removed
    --      get current policy slotted in religion section. Have a map of policy to religion.
    local sStateReligion            -- should we allow removing all religions if agnostic? Yes.
    local pCityReligion
    local pPlayer = Players[playerID]
    local pPlayerCities = pPlayer:GetCities();
    local pPlayerCulture = pPlayer:GetCulture()
    for iPolicy, sReligion in pairs(tPolicyReligionMap) do
        if not sStateReligion then
            if pPlayerCulture:IsPolicyActive(iPolicy) then          -- dont trust this function sadly
                sStateReligion = sReligion
            end
        end
    end
    if sStateReligion then
        if sStateReligion == 'NO_RELIGION' then
            for idx, pCity in pPlayerCities:Members() do
                pCityReligion = pCity:GetReligion()
                pCityReligion:RemoveOtherReligions()            -- need to find a better way to remove all religions
            end
        else
            for idx, pCity in pPlayerCities:Members() do
                pCityReligion = pCity:GetReligion()
                pCityReligion:RemoveOtherReligions(sStateReligion)      -- this function unused in game, needs testing
            end
        end
    end
    -- also would need to map revolts. Do that as like -5 amenities for a time period?
end

function BloodOfThePhoenix(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Grant all units an ability that respawns the unit in the capital. This doesnt exist sadly is a DLL problem.
end

-- CityProjectCompleted for Elohim, Sheaim, Illian the Draw.
local tProjectArmaCost = { [GameInfo.Projects['PROJECT_ELEGY_OF_THE_SHEAIM'].Index]   = 5,
                     [GameInfo.Projects['PROJECT_HALLOWING_OF_ELOHIM'].Index]      = -5,
                     [GameInfo.Projects['PROJECT_PURGE_THE_UNFAITHFUL'].Index]      = 3,
                     [GameInfo.Projects['PROJECT_THE_DRAW'].Index]              = 10}

local tProjectFunctions = {
    [GameInfo.Projects['PROJECT_SAMHAIN'].Index]   = Samhain,
    [GameInfo.Projects['PROJECT_DEEPENING'].Index]   = Deepening,
    [GameInfo.Projects['PROJECT_THE_DRAW'].Index]   = TheDraw,
    [GameInfo.Projects['PROJECT_ASCENSION'].Index]   = Ascension,
    [GameInfo.Projects['PROJECT_BANE_DIVINE'].Index]   = BaneDivine,
    [GameInfo.Projects['PROJECT_BIRTHRIGHT_REGAINED'].Index]   = BirthrightRegained,
    [GameInfo.Projects['PROJECT_GENESIS'].Index]   = Genesis,
    [GameInfo.Projects['PROJECT_NATURES_REVOLT'].Index]   = NaturesRevolt,
    [GameInfo.Projects['PROJECT_RITES_OGHMA'].Index]   = RitesOghma,
    [GameInfo.Projects['PROJECT_PURGE_THE_UNFAITHFUL'].Index]   = PurgeUnfaithful,
    [GameInfo.Projects['PROJECT_PHOENIX'].Index]   = BloodOfThePhoenix
}

function ArmaProjectComplete(playerID, cityID, projectID, buildingIndex, x, y, isCancelled)
    if isCancelled then return; end
    local iArmaCost = tProjectArmaCost[projectID]
    if iArmaCost then
        AdjustArmageddonCount(iArmaCost)
    end
    local fCustomAction = tProjectFunctions[projectID]
    if fCustomAction then
        fCustomAction(playerID, cityID, projectID, buildingIndex, x, y)
    end
end

-- war equipment ability on kill to increase count. Lets just do that with the rest of the OnKill stuff

-- not tracking veil religion state as its hard

function fWarning ()
    -- display armageddon popup warning for local player
end

function Blight ()
    --apply a -20 food to each city or something that decays over time? Also half hp of all living units?
end

function ArmaSummonSteph ()
    local tEligiblePlots = ViableWildernessPlots()
    SpawnUnitInWilderness(GameInfo.Units['SLTH_UNIT_STEPHANOS'].Index, tEligiblePlots)
end

function ArmaSummonBuboes()
    local tEligiblePlots = ViableWildernessPlots()
    SpawnUnitInWilderness(GameInfo.Units['SLTH_UNIT_BUBOES'].Index, tEligiblePlots)
    -- hell terrain now spreads in all Evil civ terrain
end

function ArmaSummonYersinia ()
    local tEligiblePlots = ViableWildernessPlots()
    SpawnUnitInWilderness(GameInfo.Units['SLTH_UNIT_YERSINIA'].Index, tEligiblePlots)
end

function ArmaSummonArs ()
    local tEligiblePlots = ViableWildernessPlots()
    SpawnUnitInWilderness(GameInfo.Units['SLTH_UNIT_ARS'].Index, tEligiblePlots)
end

function ArmaSpawnWrath ()
    local tEligiblePlots = ViableWildernessPlots()
    SpawnUnitInWilderness(GameInfo.Units['UNIT_WRATH'].Index, tEligiblePlots)
end

function ArmaKillHalf ()
    -- lose half of ALL units, half of all city pop
end

local tColdTerrain = {  [GameInfo.Terrains['TERRAIN_TUNDRA'].Index]       = true,
                        [GameInfo.Terrains['TERRAIN_TUNDRA_HILLS'].Index] = true,
                        [GameInfo.Terrains['TERRAIN_SNOW'].Index]         = true,
                        [GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index]   = true
}
-- nicked from Leugi Wildlife++
function ViableWildernessPlots(bOnlyTundraOrSnow)
    local tTable = Map.Plots()
    local tNewTable = {}
    local iCount = 1
    local bViablePlot
    for _, iPlotIndex in ipairs(tTable) do
        local pPlot = Map.GetPlotByIndex(iPlotIndex)
        if (pPlot ~= nil) then
            local iPlotX, iPlotY = pPlot:GetX(), pPlot:GetY()
            if (pPlot:IsAdjacentOwned() == false) and (pPlot:IsOwned() == false) and (pPlot:IsMountain() == false) and (pPlot:IsWater() == false) and (pPlot:IsNaturalWonder() == false) and (pPlot:IsImpassable() == false) and (pPlot:IsCity() == false) then
                if bOnlyTundraOrSnow then
                    local iTerrainIndex = pPlot:GetTerrainType()
                    bViablePlot = tColdTerrain[iTerrainIndex]
                else
                    bViablePlot = true
                end
                local bPlotHasUnit = false
                local unitList = Units.GetUnitsInPlotLayerID(iPlotX, iPlotY, MapLayers.ANY)
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
    return tNewTable
end
-- nicked from Leugi Wildlife++
function SpawnUnitInWilderness(iUnitToSpawn, eligiblePlots)
    local iNumEligiblePlots = table.Count(eligiblePlots)
    if iNumEligiblePlots > 0 then
        local iRandomEligiblePlotsPosition = Game.GetRandNum((iNumEligiblePlots + 1) - 1, 'RNG_barb_placement') + 1
        local spawnPlot = eligiblePlots[iRandomEligiblePlotsPosition]
        UnitManager.InitUnitValidAdjacentHex(63, iUnitToSpawn, spawnPlot:GetX(), spawnPlot:GetY());
        eligiblePlots[iRandomEligiblePlotsPosition] = nil
    end
    return eligiblePlots
end

--[[WIKI: The plot counter is what determines if a tile is hell or not. It has a range from 0 to 100, and anything over 10 is hell. Infernal lands are set to 100 every turn. Tiles that are eligible (good civs' lands are never eligible, nor or neutral or non-AV evil lands when the AC is low enough) have their plot counter increased by 1 each turn if they are adjacent to a tile with a plot counter greater than 10; otherwise, the counter decreases by 1 each turn.
--Whether an individual tile is in hell or not depends on that tile's plot counter - which is different than the AC. If the plot counter is over 10, then it is hell. Most tiles change to a different "Hellish" terrain at this point, and change back when the counter dips below 10 (it used to be 20, but the code clearly says 10 now). There are some terrains, like tundras and water, that currently have no different version for hell.
--Each tile is updated once per turn. All tiles owned by the Infernals have their plot counters set to 100. The Mercurian lands had their counters slowly dimished (in previous version it was set to zero).
--Any tile belonging to an Ashen Veil civ regardless of the AC, to any Evil civ at an AC of 25 or greater, or any Neutral civ at an AC of 75 or greater that borders a tile with an plot counter of at least 10 will have its plot counter increased by one each turn. Good Civs are never effected. Unowned tiles likewise have their plot counter increased by 1 each turn if they border a tile with a counter of 10+, if the AC is at least 25 (I could have sworn that non-AV evil lands turned to hell before unowned lands, but thats not what the code seems to say.) Tiles with positive plot counters that haven't been increased will have theirs decreased.
--Note that while changing the plot counter immediately changes the terrain (e.g., the sanctify spell sets the plot counter of the surrounding tiles to 0, and immediately reclaims the hell terrain, temporarily), the resources aren't updated but once per turn.
]]
-- not implemented as different, [80]=HellFireCanSpawn, need to do as barb tribe?
-- big performance concerns on this as getting every land tile, checking terrain, then checking adjacent tiles. every turn
-- need some initial starting plots, as otherwise it cant spread. Also needs some plots on each landmass, down to a min size. Apparently this last point wasnt in og
-- Infernal cities alywas convert their terrain to hell equivalent. Thats the seed. Also HellFire improvement but we'll cross that bridge when we come to it
local tHellTerrains = {[GameInfo.Terrains['TERRAIN_BURNING_SANDS'].Index]=1,          -- cba with mountains
                 [GameInfo.Terrains["TERRAIN_BURNING_SANDS_HILLS"].Index]=1,
                 [GameInfo.Terrains['TERRAIN_BROKEN_LANDS'].Index]=1,
                 [GameInfo.Terrains["TERRAIN_BROKEN_LANDS_HILLS"].Index]=1,
                 [GameInfo.Terrains['TERRAIN_FIELDS_OF_PERDITION'].Index]=1,
                 [GameInfo.Terrains["TERRAIN_FIELDS_OF_PERDITION_HILLS"].Index]=1}

local tHellTransforms = { [GameInfo.Terrains['TERRAIN_DESERT'].Index]=GameInfo.Terrains['TERRAIN_BURNING_SANDS'].Index,
                    [GameInfo.Terrains["TERRAIN_BURNING_SANDS_HILLS"].Index]=GameInfo.Terrains["TERRAIN_DESERT_HILLS"].Index,
                    [GameInfo.Terrains['TERRAIN_BROKEN_LANDS'].Index]=GameInfo.Terrains['TERRAIN_GRASS'].Index,
                    [GameInfo.Terrains["TERRAIN_BROKEN_LANDS_HILLS"].Index]=GameInfo.Terrains["TERRAIN_GRASS_HILLS"].Index,
                    [GameInfo.Terrains['TERRAIN_FIELDS_OF_PERDITION'].Index]=GameInfo.Terrains['TERRAIN_PLAINS'].Index,
                    [GameInfo.Terrains["TERRAIN_FIELDS_OF_PERDITION_HILLS"].Index]=GameInfo.Terrains["TERRAIN_PLAINS_HILLS"].Index}

local tResourceTransform = {  [GameInfo.Resources['RESOURCE_PIG'].Index]=GameInfo.Resources['RESOURCE_TOAD'].Index,
                        [GameInfo.Resources['RESOURCE_SHEEP'].Index]=GameInfo.Resources['RESOURCE_TOAD'].Index,
                        [GameInfo.Resources['RESOURCE_COW'].Index]=GameInfo.Resources['RESOURCE_NIGHTMARE'].Index,
                        [GameInfo.Resources['RESOURCE_HORSE'].Index]=GameInfo.Resources['RESOURCE_NIGHTMARE'].Index,
                        [GameInfo.Resources['RESOURCE_MARBLE'].Index]=GameInfo.Resources['RESOURCE_SHEUT_STONE'].Index,
                        [GameInfo.Resources['RESOURCE_BANANA'].Index]=GameInfo.Resources['RESOURCE_GULAGARM'].Index,
                        [GameInfo.Resources['RESOURCE_SUGAR'].Index]=GameInfo.Resources['RESOURCE_GULAGARM'].Index,
                        [GameInfo.Resources['RESOURCE_SILK'].Index]=GameInfo.Resources['RESOURCE_RAZORWEED'].Index,
                        [GameInfo.Resources['RESOURCE_COTTON'].Index]=GameInfo.Resources['RESOURCE_RAZORWEED'].Index}

local tResourceReverse = {  [GameInfo.Resources['RESOURCE_TOAD'].Index]=GameInfo.Resources['RESOURCE_SHEEP'].Index,
                        [GameInfo.Resources['RESOURCE_NIGHTMARE'].Index]=GameInfo.Resources['RESOURCE_HORSE'].Index,
                        [GameInfo.Resources['RESOURCE_SHEUT_STONE'].Index]=GameInfo.Resources['RESOURCE_MARBLE'].Index,
                        [GameInfo.Resources['RESOURCE_GULAGARM'].Index]=GameInfo.Resources['RESOURCE_SUGAR'].Index,
                        [GameInfo.Resources['RESOURCE_RAZORWEED'].Index]=GameInfo.Resources['RESOURCE_SILK'].Index}

local tHellReverse = reverse_table(tHellTransforms)
function HellSpread()
    local pPlot
    local iTerrainType
    local tAdjacentPlots
    local bIsOwned
    local iAdjPlotID
    local bIncludeTile
    local HellConversion
    local NewHellConversion
    local tCurrentHellTiles = {}
    local tPotentialHellTiles = {}
    local tCoveredTiles = {}
    local iArmageddonCount = Game.GetProperty('ARMAGEDDON') or 0
    for idx, plotID in tLandTiles do
        pPlot = Map.GetPlotByIndex(plotID)
        iTerrainType = pPlot:GetTerrainType()
        if tHellTerrains[iTerrainType] then
            tCurrentHellTiles[plotID] = 1
        end
    end
    -- get potential hell tiles
    for iPlotID, _ in pairs(tCurrentHellTiles) do
        pPlot = Map.GetPlotByIndex(iPlotID)
        -- not implemented yet, state religion Veil.
        tAdjacentPlots = Map.GetAdjacentPlots(pPlot:GetX(), pPlot:GetY())       -- Plots?
        for idx, pAdjPlot in ipairs(tAdjacentPlots) do
            iAdjPlotID = pAdjPlot:GetIndex()                    -- maybe the idx is in tAdjacentPlots? then dont need this line
            if not tCoveredTiles[iAdjPlotID] then
                if tTransformableTiles[iAdjPlotID] then         -- is on list of tiles possible
                    bIsOwned = pAdjPlot:IsOwned()
                    if bIsOwned then
                        local owner = pAdjPlot:GetOwner()       -- no idea on typing, is it player, or city?
                        local pPlayer = Players[owner]
                        local sCivName = PlayerConfigurations[owner]:GetCivilizationTypeName()
                        if sCivName == 'SLTH_CIVILIZATION_INFERNAL' then
                            HellConversion =  pAdjPlot:GetProperty('HellConversion') or 0
                            pAdjPlot:SetProperty('HellConversion', 100)
                            if HellConversion < 10 then
                                ConvertTerrain(pAdjPlot, tHellTransforms, tResourceTransform)
                            end
                        else
                            -- todo do some logic to get state religion and then allow if is veil
                            local iAlignment = pPlayer:GetProperty('alignment')
                            if iAlignment then
                                if iAlignment == 0 and iArmageddonCount > 49 then
                                    bIncludeTile = 1                                 -- evil player spread
                                end
                                if iAlignment == 1 and iArmageddonCount > 74 then
                                    bIncludeTile = 1             -- neutral player spread
                                end
                            else
                                print('ERROR NO alignment on owner of owned tile')          -- wait what about city states
                            end
                        end
                    else
                        if iArmageddonCount > 24 then
                            bIncludeTile = 1
                        end
                    end
                    if bIncludeTile then
                        tPotentialHellTiles[iAdjPlotID] = pAdjPlot
                    end
                    tCoveredTiles[iAdjPlotID] = pAdjPlot
                end
            end
        end
    end
    for iPotentialHellPlotID, pAdjPlot in pairs(tPotentialHellTiles) do
        HellConversion = pAdjPlot:GetProperty('HellConversion') or 0
        NewHellConversion = HellConversion + 1
        if NewHellConversion < 101 then
            pAdjPlot:SetProperty('HellConversion', NewHellConversion)
        end
        if NewHellConversion == 10 then                                 -- think we can assume only increments of 1
            ConvertTerrain(pAdjPlot, tHellTransforms, tResourceTransform)
        end
    end
    for idx, iPlotID in tLandTiles do
        if not tPotentialHellTiles[iPlotID] then                        -- filter non hell adjacent tiles
            pPlot = Map.GetPlotByIndex(iPlotID)
            HellConversion = pPlot:GetProperty('HellConversion') or 0
            NewHellConversion = HellConversion -1
            if HellConversion > -1 then
                pPlot:SetProperty('HellConversion', HellConversion - 1)
            end
            if NewHellConversion == 9 then                                  -- reverse hell terrain
                ConvertTerrain(pPlot, tHellReverse, tResourceReverse)
            end
        end
    end
end

function ConvertTerrain(pPlot, tTerrainConverter, tResourceConverter)
    local iCurrentResource
    local iCurrentTerrain
    local iNewResource
    local iNewTerrain
    iCurrentTerrain = pPlot:GetTerrainType()                 -- does this return indexof terrain?
    iNewTerrain = tTerrainConverter[iCurrentTerrain]
    if iNewTerrain then
        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain);           -- unsure if needed index of terrain
        iCurrentResource = pPlot:GetResourceType()
        if iCurrentResource then
            iNewResource =  tResourceConverter[iCurrentResource]
            if iNewResource then
                TerrainBuilder.SetResourceType(pPlot, iNewResource, 1)       -- what does amount do
            end
        end
    end
end

local tTransformableTiles = {}
local tLandTiles = {}
function OnStart()
    local iW, iH = Map.GetGridSize();

    for x = 0, iW - 1 do
        for y = 0, iH - 1 do
            local i = y * iW + x;
            local pPlot = Map.GetPlotByIndex(i);
            if not pPlot:IsWater() then
                tLandTiles[i] = pPlot
            end
        end
    end
    local tType
    for iPlotID, pLandPlot in pairs(tLandTiles) do
        tType = pLandPlot:GetTerrainType()
        if tHellTransforms[tType] then
            tTransformableTiles[iPlotID] = 1
        end
    end
end

Events.CityReligionFollowersChanged.Add(religionLostCity)
Events.DistrictRemovedFromMap.Add(OnCityRaze)
Events.UnitAddedToMap.Add(ArmageddonUnitSpawning)
Events.UnitKilledInCombat.Add(ArmageddonUnitDied)
GameEvents.BuildingConstructed.Add(ArmageddonBuildingMade)
Events.CityProjectCompleted.Add(ArmaProjectComplete)

-- hell terrain spread
GameEvents.OnGameTurnStarted.Add(HellSpread)

OnStart()