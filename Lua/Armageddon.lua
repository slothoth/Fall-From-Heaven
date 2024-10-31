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
    else
        print('Armageddon count not initilizaed!')
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
                print ("this city was (we think) razed by a steppe civ!")
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

-- Santifying City Ruins improvements. not Event driven afaik. todo IN SPELLS

-- unit tracker, create increase armageddon, delete decrease
-- not doing 'BASIUM:5', 'HYBOREM:5' as covered in spawning civ
tArmageddonUnits = {['SLTH_UNIT_BEAST_OF_AGARES']=1, ['SLTH_UNIT_ROSIER']=2, ['SLTH_UNIT_EIDOLON']=1,
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
tArmageddonBuildings = {[GameInfo.Buildings['PILLAR_OF_CHAINS'].Index]=4,
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


function Samhain(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Spawn frostling barbarian units in some tundra and snow tiles. Based on number of Snow and Tundra tiles?
    -- spawn Mokka barbarian
end

function Deepening(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- When it is completed, the entire world will be cooled down - changing some of the deserts to plains,
    -- some of the plains and grassland to tundra, and some of the tundra to snow tiles. Additionally, it spawns a
    -- random amount of Blizzards on the map. Blizzards are more like a Feature that changes a tile to Snow in civ
end

function TheDraw(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Illians will declare war on all other civilizations,
    -- the population of all Illian cities will be halved,
    -- The Illians cannot attempt diplomacy after the Draw has been completed.
end

function Ascension(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Give Godslayer to highest Score/ Highest military strength
end

function BaneDivine(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- All Disciple Units in the world are replaced with Tier 1 Disciples of the same religion
end

function BirthrightRegained(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Set Player Property that controls if can do world spell
end

function Genesis(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- All tiles have Vitalize cast upon them, if tile is grassland with no improvments Bloom is cast
    -- Vitalize: Converts Snow-Tundra, Tundra - Plains, Desert - Plains, Plains - Grassland, Grassland gets Forest
end

function NaturesRevolt(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Turns Barbarian units into Animals
    --            Goblin Worker-> Wolf, Goblin-> Lion, Warrior-> Lion, Lizardman->Tiger, Axeman->Bear
    --            wtf happens to skeletons, to goblin archers
    --All animals in the world receive Heroic Strength I, Heroic Strength II, Heroic Defense I, and Heroic Defense II
    -- can do this second part as abilities in Modifier system
end

function RitesOghma(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    --  Grant Manas           Duel: 4, Tiny: 5, Small: 6, Standard: 7, Large: 8, Huge: 10
end

function PurgeUnfaithful(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    --   	Removes any non-state Religions and religious buildings from all cities
    --      Causes revolts in cities where multiple religions are removed
end

function BloodOfThePhoenix(playerID, cityID, projectID, buildingIndex, x, y)
    print('in custom project action UNIMPLEMENTED')
    -- Grant all units an ability that respawns the unit in the capital. This doesnt exist sadly.
end

-- CityProjectCompleted for Elohim, Sheaim, Illian the Draw.
tProjectArmaCost = { [GameInfo.Projects['PROJECT_ELEGY_OF_THE_SHEAIM'].Index]   = 5,
                     [GameInfo.Projects['PROJECT_HALLOWING_OF_ELOHIM'].Index]      = -5,
                     [GameInfo.Projects['PROJECT_PURGE_THE_UNFAITHFUL'].Index]      = 3,
                     [GameInfo.Projects['PROJECT_THE_DRAW'].Index]              = 10}

tProjectFunctions = {
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

-- done elsewhere? Hyborem or Basium entered. Veil holy city founded

-- not tracking veil religion state as its hard


function fWarning ()
    -- display popup warning for local player
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

-- nicked from Leugi Wildlife++
function ViableWildernessPlots()
    local tTable = Map.Plots()
    local tNewTable = {}
    local iCount = 1
    for i, iPlotIndex in ipairs(tTable) do
        local pPlot = Map.GetPlotByIndex(iPlotIndex)
        if (pPlot ~= nil) then
            local iPlotX, iPlotY = pPlot:GetX(), pPlot:GetY()
            if (pPlot:IsAdjacentOwned() == false) and (pPlot:IsOwned() == false) and (pPlot:IsMountain() == false) and (pPlot:IsWater() == false) and (pPlot:IsNaturalWonder() == false) and (pPlot:IsImpassable() == false) and (pPlot:IsCity() == false) then
                local bPlotHasUnit = false
                local unitList = Units.GetUnitsInPlotLayerID(iPlotX, iPlotY, MapLayers.ANY)
                if unitList ~= nil then
                    for i, pUnit in ipairs(unitList) do
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
    end
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
tHellTerrains = {[GameInfo.Terrains['TERRAIN_BURNING_SANDS'].Index]=1,          -- cba with mountains
                 [GameInfo.Terrains["TERRAIN_BURNING_SANDS_HILLS"].Index]=1,
                 [GameInfo.Terrains['TERRAIN_BROKEN_LANDS'].Index]=1,
                 [GameInfo.Terrains["TERRAIN_BROKEN_LANDS_HILLS"].Index]=1,
                 [GameInfo.Terrains['TERRAIN_FIELDS_OF_PERDITION'].Index]=1,
                 [GameInfo.Terrains["TERRAIN_FIELDS_OF_PERDITION_HILLS"].Index]=1}

tHellTransforms = { [GameInfo.Terrains['TERRAIN_DESERT'].Index]=GameInfo.Terrains['TERRAIN_BURNING_SANDS'].Index,
                    [GameInfo.Terrains["TERRAIN_BURNING_SANDS_HILLS"].Index]=GameInfo.Terrains["TERRAIN_DESERT_HILLS"].Index,
                    [GameInfo.Terrains['TERRAIN_BROKEN_LANDS'].Index]=GameInfo.Terrains['TERRAIN_GRASS'].Index,
                    [GameInfo.Terrains["TERRAIN_BROKEN_LANDS_HILLS"].Index]=GameInfo.Terrains["TERRAIN_GRASS_HILLS"].Index,
                    [GameInfo.Terrains['TERRAIN_FIELDS_OF_PERDITION'].Index]=GameInfo.Terrains['TERRAIN_PLAINS'].Index,
                    [GameInfo.Terrains["TERRAIN_FIELDS_OF_PERDITION_HILLS"].Index]=GameInfo.Terrains["TERRAIN_PLAINS_HILLS"].Index}

tResourceTransform = {  [GameInfo.Resources['RESOURCE_PIG'].Index]=GameInfo.Resources['RESOURCE_TOAD'].Index,
                        [GameInfo.Resources['RESOURCE_SHEEP'].Index]=GameInfo.Resources['RESOURCE_TOAD'].Index,
                        [GameInfo.Resources['RESOURCE_COW'].Index]=GameInfo.Resources['RESOURCE_NIGHTMARE'].Index,
                        [GameInfo.Resources['RESOURCE_HORSE'].Index]=GameInfo.Resources['RESOURCE_NIGHTMARE'].Index,
                        [GameInfo.Resources['RESOURCE_MARBLE'].Index]=GameInfo.Resources['RESOURCE_SHEUT_STONE'].Index,
                        [GameInfo.Resources['RESOURCE_BANANA'].Index]=GameInfo.Resources['RESOURCE_GULAGARM'].Index,
                        [GameInfo.Resources['RESOURCE_SUGAR'].Index]=GameInfo.Resources['RESOURCE_GULAGARM'].Index,
                        [GameInfo.Resources['RESOURCE_SILK'].Index]=GameInfo.Resources['RESOURCE_RAZORWEED'].Index,
                        [GameInfo.Resources['RESOURCE_COTTON'].Index]=GameInfo.Resources['RESOURCE_RAZORWEED'].Index}

tResourceReverse = {  [GameInfo.Resources['RESOURCE_TOAD'].Index]=GameInfo.Resources['RESOURCE_SHEEP'].Index,
                        [GameInfo.Resources['RESOURCE_NIGHTMARE'].Index]=GameInfo.Resources['RESOURCE_HORSE'].Index,
                        [GameInfo.Resources['RESOURCE_SHEUT_STONE'].Index]=GameInfo.Resources['RESOURCE_MARBLE'].Index,
                        [GameInfo.Resources['RESOURCE_GULAGARM'].Index]=GameInfo.Resources['RESOURCE_SUGAR'].Index,
                        [GameInfo.Resources['RESOURCE_RAZORWEED'].Index]=GameInfo.Resources['RESOURCE_SILK'].Index}

tHellReverse = reverse_table(tHellTransforms)
function HellSpread()
    local pPlot
    local sTerrainType
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
        sTerrainType = pPlot:GetTerrainType()
        if tHellTerrains[sTerrainType] then
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


Events.CityReligionFollowersChanged.Add(religionLostCity)
Events.DistrictRemovedFromMap.Add(OnCityRaze)
Events.UnitAddedToMap.Add(ArmageddonUnitSpawning)
Events.UnitKilledInCombat.Add(ArmageddonUnitDied)
GameEvents.BuildingConstructed.Add(ArmageddonBuildingMade)
Events.CityProjectCompleted.Add(ArmaProjectComplete)

-- hell terrain spread
Events.TurnEnd.Add(HellSpread)

function OnStart()
    --local bNoGoodies = GameConfiguration.GetValue("GAME_NO_GOODY_HUTS"); use this to remove hell terrain later as opt
	--if (bNoGoodies == true) then
	--	print("** The game specified NO GOODY HUTS");
	--	return false;
	-- end
    local iW, iH = Map.GetGridSize();
    tLandTiles = {}
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
    tTransformableTiles = {}
    for iPlotID, pLandPlot in pairs(tLandTiles) do
        tType = pLandPlot:GetTerrainType()
        if tHellTransforms[tType] then
            tTransformableTiles[iPlotID] = 1
        end
    end
end

OnStart()