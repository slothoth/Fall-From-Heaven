include "MapEnums"
include "MapUtilities"
include "MountainsCliffs"
include "RiversLakes"
include "FeatureGenerator"
include "TerrainGenerator"
include "NaturalWonderGenerator"
include "ResourceGenerator"
include "CoastalLowlands"
include "AssignStartingPlots"
-- TODO CURRENTLY NOT RANDOM KEEP GETTING SAME MAP SHAPES. Strangely only on windows, not mac!!!!

include "PythonConversion"
include "IO_Fake"

doErebusFeatures = true

local g_riverStartPlots = {};
local g_riverPlots = {};
local g_iRiverID = 0;

local JungleThreshold = .90
-- Chance for jungle to have marsh, and chance for marsh to replace jungle
local ChanceForMarsh = 0.30
local ChanceForOnlyMarsh = 0.33
local OasisChance = .08             -- Chance for an oasis to appear in desert
local LeafyAltitude = 0.3

local OCEAN, LAND, HILLS, PEAK = 0, 1, 2, 3

local plotErebusFxsMapper = {[OCEAN] = g_PLOT_TYPE_OCEAN, [LAND] = g_PLOT_TYPE_LAND,
                                [HILLS] = g_PLOT_TYPE_HILLS, [PEAK] = g_PLOT_TYPE_MOUNTAIN,
                                ["O"] = g_PLOT_TYPE_OCEAN, ["L"] = g_PLOT_TYPE_LAND,
                                ["H"] = g_PLOT_TYPE_HILLS, ["P"] = g_PLOT_TYPE_MOUNTAIN
                                }
local terrainErebusFxsMapper = {
     ['0'] = g_TERRAIN_TYPE_DESERT,
     ['1'] = g_TERRAIN_TYPE_PLAINS,
     ['2'] = g_TERRAIN_TYPE_SNOW,
     ['3'] = g_TERRAIN_TYPE_TUNDRA,
     ['4'] = g_TERRAIN_TYPE_GRASS,
     ['5'] = g_TERRAIN_TYPE_GRASS_HILLS,
     ['6'] = g_TERRAIN_TYPE_COAST,
     ['7'] = g_TERRAIN_TYPE_OCEAN,
     ['8'] = g_TERRAIN_TYPE_GRASS_MOUNTAIN,
     ['9'] = g_TERRAIN_TYPE_GRASS               -- was marsh
}

local TerrainTextMapper = {
    [g_TERRAIN_TYPE_DESERT] = 'DESERT',
    [g_TERRAIN_TYPE_DESERT_HILLS] = 'DESERT HILLS',
    [g_TERRAIN_TYPE_DESERT_MOUNTAIN] = 'DESERT MOUNTAINS',
    [g_TERRAIN_TYPE_PLAINS] = 'PLAINS',
    [g_TERRAIN_TYPE_PLAINS_HILLS] = 'PLAINS HILLS',
    [g_TERRAIN_TYPE_PLAINS_MOUNTAIN] = 'PLAINS MOUNTAINS',
    [g_TERRAIN_TYPE_SNOW] = 'SNOW',
    [g_TERRAIN_TYPE_SNOW_HILLS] = 'SNOW HILLS',
    [g_TERRAIN_TYPE_SNOW_MOUNTAIN] = 'SNOW MOUNTAINS',
    [g_TERRAIN_TYPE_TUNDRA] = 'TUNDRA',
    [g_TERRAIN_TYPE_TUNDRA_HILLS] = 'TUNDRA HILLS',
    [g_TERRAIN_TYPE_TUNDRA_MOUNTAIN] = 'TUNDRA MOUNTAINS',
    [g_TERRAIN_TYPE_GRASS] = 'GRASS ',
    [g_TERRAIN_TYPE_GRASS_HILLS] = 'GRASS HILLS',
    [g_TERRAIN_TYPE_GRASS_MOUNTAIN] = 'GRASS MOUNTAIN',
    [g_TERRAIN_TYPE_COAST] = 'COAST',
    [g_TERRAIN_TYPE_OCEAN] = 'OCEAN',
}

local terrainKeyMapper = {
[g_TERRAIN_TYPE_GRASS] = "green",
[g_TERRAIN_TYPE_GRASS_HILLS] = "",
[g_TERRAIN_TYPE_GRASS_MOUNTAIN] = "red",
[g_TERRAIN_TYPE_PLAINS] = "orange",
[g_TERRAIN_TYPE_PLAINS_HILLS] = "",
[g_TERRAIN_TYPE_PLAINS_MOUNTAIN] = "red",
[g_TERRAIN_TYPE_DESERT] = "",
[g_TERRAIN_TYPE_DESERT_HILLS] = "",
[g_TERRAIN_TYPE_DESERT_MOUNTAIN] = "red",
[g_TERRAIN_TYPE_TUNDRA] = "cream",
[g_TERRAIN_TYPE_TUNDRA_HILLS] = "",
[g_TERRAIN_TYPE_TUNDRA_MOUNTAIN] = "red",
[g_TERRAIN_TYPE_SNOW] = "white",
[g_TERRAIN_TYPE_SNOW_HILLS] = "",
[g_TERRAIN_TYPE_SNOW_MOUNTAIN] = "red",
[g_TERRAIN_TYPE_COAST] = "",
[g_TERRAIN_TYPE_OCEAN] = ""
}

local function mapVarsSetup()
	-- g_iFlags = TerrainBuilder.GetFractalFlags();
    local temperature = MapConfiguration.GetValue("temperature"); -- Default setting is Temperate.
    if temperature == 4 then
        temperature  =  1 + TerrainBuilder.GetRandomNumber(3, "Random Temperature- Lua");
    end
    local world_age = MapConfiguration.GetValue("world_age");
    local tWorldAges = {5, 3, 2}
    world_age = tWorldAges[world_age]
    if not world_age then
        world_age = 2 + TerrainBuilder.GetRandomNumber(4, "Random World Age - Lua");
    end
end
-- ENTRY POINT
function GenerateMap()
    g_iW, g_iH = Map.GetGridSize();
    mapVarsSetup()
    createRegions()
    createRiverMap()
    createPlotMap()
    createTerrainMap()

    local terrainMap_out_plots = {}
    for y = g_iH - 1, 0, -1 do
        for x = 0, g_iW - 1 do
            local mapLoc = tostring(terrainMap[GetIndex(x, y)])
            terrainMap_out_plots[GetIndex(x, y)] =  mapLoc
        end
    end

    out_plots = plotMap
    plotTypes = ConvertToFiraxisFormSimple(out_plots, plotErebusFxsMapper)
    terrainTypes = ConvertToFiraxisFormSimple(terrainMap_out_plots, terrainErebusFxsMapper)
    simpleGridPrint(plotTypes, 'final plots',
			{[g_PLOT_TYPE_LAND]='green', [g_PLOT_TYPE_HILLS]='orange',
			 [g_PLOT_TYPE_OCEAN]='blue', [g_PLOT_TYPE_MOUNTAIN]='red'})
    simpleGridPrint(terrainTypes, 'final terrains', terrainKeyMapper)
    ApplyTerrain(plotTypes, terrainTypes);

    -- Temp
    AreaBuilder.Recalculate();
    TerrainBuilder.AnalyzeChokepoints();
    TerrainBuilder.StampContinents();
    local iContinentBoundaryPlots = GetContinentBoundaryPlotCount(g_iW, g_iH);
    local biggest_area = Areas.FindBiggestArea(false);
    slthLog("After Adding Hills: ", biggest_area:GetPlotCount());
    -- AddTerrainFromContinents(plotTypes, terrainTypes, world_age, g_iW, g_iH, iContinentBoundaryPlots);

    AreaBuilder.Recalculate();

    -- River generation is affected by plot types, originating from highlands and preferring to traverse lowlands.
    --AddRivers();
    -- AddRiversSkipEmpty()
    for x = 0, g_iW - 1 do
		for y = 0, g_iH - 1 do
			local i = y * g_iW + x; -- C++ Plot indices, starting at 0.
            slthLog('defining riverPlot at', i)
			g_riverPlots[i] = 0;
		end
	end
    -- AddRiversInlandLake()
    -- new rivers
    simpleGridPrint(riverMap, 'River Map')
    simpleGridPrint(flowMap, 'Flow Map')

	makeErebusRivers()
    -- Lakes would interfere with rivers, causing them to stop and not reach the ocean, if placed any sooner.
    local numLargeLakes = GameInfo.Maps[Map.GetMapSize()].Continents;
    AddLakesToPresentAreas(numLargeLakes);

    AddFeatures();
    TerrainBuilder.AnalyzeChokepoints();

    slthLog("Adding cliffs");
    AddCliffs(plotTypes, terrainTypes);

    local args = {
        numberToPlace = GameInfo.Maps[Map.GetMapSize()].NumNaturalWonders,
    };
    NaturalWonderGenerator.__InitNWData = newInitNWData
    local nwGen = NaturalWonderGenerator.Create(args);
    if not doErebusFeatures then
        AddFeaturesFromContinents();
    end
    MarkCoastalLowlands();

    do_ascii(plotTypes, terrainTypes, true, 'RESULT')

    local resourcesConfig = MapConfiguration.GetValue("resources");
    local startConfig = MapConfiguration.GetValue("start");-- Get the start config
    local args = {
        iWaterLux = 1,
		iWaterBonus = 1.0,
        resources = resourcesConfig,
        START_CONFIG = startConfig,
    };

    -- NewPlaceLuxuryResources
    iLuxAdjuster = 0.8
    iStratAdjuster = 0.8
    iBonusAdjuster = 0.5
    tContinentMountainRatio = {}
    tContinentNonMountainPlots = {}
    local totalPlaceable = 0
    local continentsInUse = Map.GetContinentsInUse();
    for _, eContinent in ipairs(continentsInUse) do
        local plots = Map.GetContinentPlots(eContinent);
        local iNumMountains = 0
        local iNumNonMountains = 0
        for i, idx in ipairs(plots) do
            local pPlot = Map.GetPlotByIndex(idx);
            if pPlot:IsMountain() then
                iNumMountains = iNumMountains + 1
            else
                iNumNonMountains = iNumNonMountains + 1
            end
        end
        tContinentNonMountainPlots[eContinent] = iNumNonMountains
        totalPlaceable = totalPlaceable + iNumNonMountains
        tContinentMountainRatio[eContinent] = iNumMountains / #plots
    end
    tContinentPlotPortions = {}
    for eContinent, iNumNonMountains in pairs(tContinentNonMountainPlots) do
        slthLog('continent', eContinent)
        slthLog('has this many non-mountain plots', iNumNonMountains)
        slthLog('and the total placeable plot count is', totalPlaceable)
        slthLog('and so its ratio of plots is', iNumNonMountains / totalPlaceable)
        tContinentPlotPortions[eContinent] = (iNumNonMountains / totalPlaceable)
    end

    ResourceGenerator.__PlaceLuxuryResources = NewPlaceLuxuryResources
    ResourceGenerator.__PlaceStrategicResources = NewPlaceStrategicResources
    ResourceGenerator.__PlaceOtherResources = NewPlaceOtherResources

	local resGen = ResourceGenerator.Create(args);

	slthLog("Creating start plot database.");

	-- START_MIN_Y and START_MAX_Y is the percent of the map ignored for major civs' starting positions.
	local args = {
		MIN_MAJOR_CIV_FERTILITY = 150,
		MIN_MINOR_CIV_FERTILITY = 50,
		MIN_BARBARIAN_FERTILITY = 1,
		START_MIN_Y = 15,
		START_MAX_Y = 15,
		START_CONFIG = startConfig,
	};
    -- AssignStartingPlots.__InitStartingData = newInitStartingPlotsData
	local start_plot_database = AssignStartingPlots.Create(args)
	local GoodyGen = AddGoodies(g_iW, g_iH);
end

function newInitStartingPlotsData(self)
    if(self.uiMinMajorCivFertility <= 0) then
		self.uiMinMajorCivFertility = 5;
	end

	if(self.uiMinMinorCivFertility <= 0) then
		self.uiMinMinorCivFertility = 5;
	end

	--Find Default Number
	MapSizeTypes = {};
	for row in GameInfo.Maps() do
		MapSizeTypes[row.RowId] = row.DefaultPlayers;
	end
	local sizekey = Map.GetMapSize() + 1;
	local iDefaultNumberPlayers = MapSizeTypes[sizekey] or 8;
	self.iDefaultNumberMajor = iDefaultNumberPlayers ;
	self.iDefaultNumberMinor = math.floor(iDefaultNumberPlayers * 1.5);

	-- See if there are any civs starting out in the water
	local tempMajorList = {};
	self.majorList = {};
	self.waterMajorList = {};
	self.iNumMajorCivs = 0;
	self.iNumWaterMajorCivs = 0;

	tempMajorList = PlayerManager.GetAliveMajorIDs();
	for i = 1, PlayerManager.GetAliveMajorsCount() do
		local leaderType = PlayerConfigurations[tempMajorList[i]]:GetLeaderTypeName();
		if (not self.startAllOnLand and GameInfo.Leaders_XP2[leaderType] ~= nil and GameInfo.Leaders_XP2[leaderType].OceanStart == true) then
			table.insert(self.waterMajorList, tempMajorList[i]);
			self.iNumWaterMajorCivs = self.iNumWaterMajorCivs + 1;
			slthLog ("Found the Maori");
		else
			table.insert(self.majorList, tempMajorList[i]);
			self.iNumMajorCivs = self.iNumMajorCivs + 1;
		end
	end

	-- Do we have enough water on this map for the number of water civs specified?
	local TILES_NEEDED_FOR_WATER_START = 8;
	if (self.waterMap == true) then
		TILES_NEEDED_FOR_WATER_START = 1;
	end
	local iCandidateWaterTiles = StartPositioner.GetTotalOceanStartCandidates(self.waterMap);
	if (iCandidateWaterTiles < (TILES_NEEDED_FOR_WATER_START * self.iNumWaterMajorCivs)) then

		-- Not enough so reset so all civs start on land
		self.iNumMajorCivs = 0;
		self.majorList = {};
		for i = 1, PlayerManager.GetAliveMajorsCount() do
			table.insert(self.majorList, tempMajorList[i]);
			self.iNumMajorCivs = self.iNumMajorCivs + 1;
		end
	end

	self.iNumMinorCivs = PlayerManager.GetAliveMinorsCount();
	self.minorList = {};
	self.minorList = PlayerManager.GetAliveMinorIDs();
	self.iNumRegions = self.iNumMajorCivs + self.iNumMinorCivs;
	local iMinNumBarbarians = self.iNumMajorCivs / 2;

	StartPositioner.DivideMapIntoMajorRegions(self.iNumMajorCivs, self.uiMinMajorCivFertility, self.uiMinMinorCivFertility, self.startLargestLandmassOnly);
	local iMajorCivStartLocs = StartPositioner.GetNumMajorCivStarts();

	-- Place the major civ start plots in an array
	self.majorStartPlots = {};
	local failed = 0;
	for i = self.iNumMajorCivs - 1, 0, - 1 do
		plots = StartPositioner.GetMajorCivStartPlots(i);
		local startPlot = self:__SetStartMajor(plots, i);
		if(startPlot ~= nil) then
			StartPositioner.MarkMajorRegionUsed(i);
			table.insert(self.majorStartPlots, startPlot);
			info = StartPositioner.GetMajorCivStartInfo(i);
--			slthLog ("ContinentType: " .. tostring(info.ContinentType));
--			slthLog ("LandmassID: " .. tostring(info.LandmassID));
--			slthLog ("Fertility: " .. tostring(info.Fertility));
--			slthLog ("TotalPlots: " .. tostring(info.TotalPlots));
--			slthLog ("WestEdge: " .. tostring(info.WestEdge));
--			slthLog ("EastEdge: " .. tostring(info.EastEdge));
--			slthLog ("NorthEdge: " .. tostring(info.NorthEdge));
--			slthLog ("SouthEdge: " .. tostring(info.SouthEdge));
		else
			failed = failed + 1;
			info = StartPositioner.GetMajorCivStartInfo(i);

			slthLog("-- START FAILED MAJOR --");
			if(info) then
				slthLog("ContinentType: " .. tostring(info.ContinentType));
				slthLog("LandmassID: " .. tostring(info.LandmassID));
				slthLog("Fertility: " .. tostring(info.Fertility));
				slthLog("TotalPlots: " .. tostring(info.TotalPlots));
				slthLog("WestEdge: " .. tostring(info.WestEdge));
				slthLog("EastEdge: " .. tostring(info.EastEdge));
				slthLog("NorthEdge: " .. tostring(info.NorthEdge));
				slthLog("SouthEdge: " .. tostring(info.SouthEdge));
			end
			slthLog("-- END FAILED MAJOR --");
		end
	end
	for k, plot in ipairs(self.majorStartPlots) do
		table.insert(self.majorCopy, plot);
	end

	--Begin Start Bias for major
	if (self.noStartBiases or (GameInfo.StartBiasResources() == nil and GameInfo.StartBiasFeatures() == nil and GameInfo.StartBiasTerrains() == nil and GameInfo.StartBiasRivers() == nil)) then
		self.playerStarts = {};
		for i = 1, self.iNumMajorCivs do
			local playerStart = {}
			for j, plot in ipairs(self.majorStartPlots) do
				playerStart[j] = plot;
			end
			self.playerStarts[i] = playerStart;
		end

		for j, playerIndex in ipairs(self.majorList) do
			local hasPlot = false;
			local index = playerIndex + 1;

			if(index > 0 and self:__ArraySize(self.playerStarts, index) > 1) then
				for k, v in pairs(self.playerStarts[index]) do
					if(v~= nil and hasPlot == false) then
						hasPlot = true;
						--Call Removal
						self:__StartBiasPlotRemoval(v, false, index);
					end
				end
			end
		end
	else
		self:__InitStartBias(false);
	end

	if(self.uiStartConfig == 1 ) then
		self:__AddResourcesBalanced();
	elseif(self.uiStartConfig == 3 ) then
		self:__AddResourcesLegendary();
	end

	local aMajorStartPlotIndices = {};
	for i = 1, self.iNumMajorCivs do
		local player = Players[self.majorList[i]]

		if(player == nil) then
			slthLog("THIS PLAYER FAILED");
		else
			local hasPlot = false;
			for k, v in pairs(self.playerStarts[i]) do
				if(v~= nil and hasPlot == false) then
					hasPlot = true;
					self:__AddLeyLine(v);
					player:SetStartingPlot(v);
					table.insert(aMajorStartPlotIndices, v:GetIndex());
					slthLog("Major Start X: ", v:GetX(), "Major Start Y: ", v:GetY());
				end
			end
		end
	end
    -- skip placing minors too
    StartPositioner.DivideMapIntoMinorRegions(self.iNumMinorCivs);

	local iMinorCivStartLocs = StartPositioner.GetNumMinorCivStarts();
	local i = 0;
	local valid = 0;
	while i <= iMinorCivStartLocs - 1 and valid < self.iNumMinorCivs do
		plots = StartPositioner.GetMinorCivStartPlots(i);
		local startPlot = self:__SetStartMinor(plots);
		info = StartPositioner.GetMinorCivStartInfo(i);
		if(startPlot ~= nil) then
			table.insert(self.minorStartPlots, startPlot);
--			slthLog("Minor ContinentType: " .. tostring(info.ContinentType));
--			slthLog("Minor LandmassID: " .. tostring(info.LandmassID));
--			slthLog("Minor Fertility: " .. tostring(info.Fertility));
--			slthLog("Minor TotalPlots: " .. tostring(info.TotalPlots));
--			slthLog("Minor WestEdge: " .. tostring(info.WestEdge));
--			slthLog("Minor EastEdge: " .. tostring(info.EastEdge));
--			slthLog("Minor NorthEdge: " .. tostring(info.NorthEdge));
--			slthLog("Minor SouthEdge: " .. tostring(info.SouthEdge));
			valid = valid + 1;
		else
			slthLog("-- START FAILED MINOR --");
			slthLog("Minor ContinentType: " .. tostring(info.ContinentType));
			slthLog("Minor LandmassID: " .. tostring(info.LandmassID));
			slthLog("Minor Fertility: " .. tostring(info.Fertility));
			slthLog("Minor TotalPlots: " .. tostring(info.TotalPlots));
			slthLog("Minor WestEdge: " .. tostring(info.WestEdge));
			slthLog("Minor EastEdge: " .. tostring(info.EastEdge));
			slthLog("Minor NorthEdge: " .. tostring(info.NorthEdge));
			slthLog("Minor SouthEdge: " .. tostring(info.SouthEdge));
			slthLog("-- END FAILED MINOR --");
		end

		i = i + 1;
	end

	for k, plot in ipairs(self.minorStartPlots) do
		table.insert(self.minorCopy, plot);
	end

	--Begin Start Bias for minor
	if (self.noStartBiases or (GameInfo.StartBiasResources() == nil and GameInfo.StartBiasFeatures() == nil and GameInfo.StartBiasTerrains() == nil and GameInfo.StartBiasRivers() == nil)) then
		self.playerStarts = {};
		for i = 1, self.iNumMinorCivs do
			local playerStart = {}
			for j, plot in ipairs(self.minorStartPlots) do
				playerStart[j] = plot;
			end
			self.playerStarts[self.iNumMajorCivs + i] = playerStart
		end

		for j, playerIndex in ipairs(self.minorList) do
			local hasPlot = false;
			local index = playerIndex + 1;

			if(index > 0 and self:__ArraySize(self.playerStarts, index) > 1) then
				for k, v in pairs(self.playerStarts[index]) do
					if(v~= nil and hasPlot == false) then
						hasPlot = true;
						--Call Removal
						self:__StartBiasPlotRemoval(v, true, index);
					end
				end
			end
		end
	else
		self:__InitStartBias(true);
	end

	for i = 1, self.iNumMinorCivs do
		local player = Players[self.minorList[i]]

		if(player == nil) then
			slthLog("THIS PLAYER FAILED");
		else
			local hasPlot = false;
			for k, v in pairs(self.playerStarts[i + self.iNumMajorCivs]) do
				if(v~= nil and hasPlot == false) then
					hasPlot = true;
					player:SetStartingPlot(v);
					slthLog("Minor Start X: ", v:GetX(), "Minor Start Y: ", v:GetY());
				end
			end
		end
	end
	-- skip placing the ocean civs
end

function NewPlaceLuxuryResources(self, eChosenLux, eContinent)
	local iTotalPlaced = 0;
	local iNumToPlace = 1;
    slthLog('trying to place luxuries for continent. Inital occurence', eContinent, self.iOccurencesPerFrequency)
	if(self.iOccurencesPerFrequency > 1) then
		iNumToPlace = self.iOccurencesPerFrequency;
        if tContinentMountainRatio[eContinent] then
            iNumToPlace = iNumToPlace * tContinentMountainRatio[eContinent]
        end
	end
    slthLog('trying to place luxuries for continent. Post Mountain Ratio', eContinent, iNumToPlace)
    if tContinentPlotPortions[eContinent] then
        iNumToPlace = iNumToPlace * tContinentPlotPortions[eContinent] * iLuxAdjuster
    end
    slthLog('trying to place luxuries for continent. Post Continent Plot Portioning', eContinent, iNumToPlace)
	self:__ScoreLuxuryPlots(eChosenLux, eContinent);
	table.sort (self.aaPossibleLuxLocs[eChosenLux], function(a, b) return a.Score > b.Score; end);
	for iI = 1, iNumToPlace do
			if (iI <= #self.aaPossibleLuxLocs[eChosenLux]) then
				local iMapIndex = self.aaPossibleLuxLocs[eChosenLux][iI].MapIndex;
				local iScore = self.aaPossibleLuxLocs[eChosenLux][iI].Score;
				local pPlot = Map.GetPlotByIndex(iMapIndex);
				ResourceBuilder.SetResourceType(pPlot, self.eResourceType[eChosenLux], 1);
			iTotalPlaced = iTotalPlaced + 1;
		end
	end
end

function NewPlaceStrategicResources(self, eContinent)
	-- Go through continent placing the chosen strategic
	for i, row in ipairs(self.aResourcePlacementOrderStrategic) do
		local eResourceType = self.eResourceType[row.ResourceIndex]
		local iNumToPlace;
		iNumToPlace = self.iOccurencesPerFrequency * (self.iFrequency[row.ResourceIndex] / self.iFrequencyStrategicTotal) * row.Weight;
        slthLog('trying to place strategics for continent/num', eContinent, iNumToPlace)
        if tContinentMountainRatio[eContinent] then
            iNumToPlace = iNumToPlace * tContinentMountainRatio[eContinent]
            slthLog('new num to place is mountainRatio * iNumToPlace = ',tContinentMountainRatio[eContinent], iNumToPlace)
        end
        if tContinentPlotPortions[eContinent] then
            iNumToPlace = iNumToPlace * tContinentPlotPortions[eContinent]  * iStratAdjuster
        end
        slthLog('trying to place strategics for continent. Post Plot Portions', eContinent, iNumToPlace)
		self:__ScoreStrategicPlots(row.ResourceIndex, eContinent);
		table.sort (self.aaPossibleStratLocs[row.ResourceIndex], function(a, b) return a.Score > b.Score; end);

		if(self.iFrequency[row.ResourceIndex] > 1 and iNumToPlace < 1) then
			iNumToPlace = 1;
		end

		for iI = 1, iNumToPlace do
			if (iI <= #self.aaPossibleStratLocs[row.ResourceIndex]) then
				local iMapIndex = self.aaPossibleStratLocs[row.ResourceIndex][iI].MapIndex;
				local iScore = self.aaPossibleStratLocs[row.ResourceIndex][iI].Score;
				local pPlot = Map.GetPlotByIndex(iMapIndex);
				ResourceBuilder.SetResourceType(pPlot, eResourceType, 1);
			end
		end
	end
end

function NewPlaceOtherResources(self)
    local iContinentMountainRatio = 0
    local iContinentCount = 0
    for i, ratio in pairs(tContinentMountainRatio) do
        iContinentMountainRatio = iContinentMountainRatio + ratio
        slthLog('mountain total ratio:', iContinentMountainRatio)
        iContinentCount = iContinentCount + 1
    end
    if iContinentCount > 1 then
        iContinentMountainRatio = iContinentMountainRatio / iContinentCount
        slthLog('dividing mountain total by number of entries:', iContinentCount)
    else
        iContinentMountainRatio = 1
    end
    slthLog('starting other resourec placement with ratio', iContinentMountainRatio)
    for i, row in ipairs(self.aResourcePlacementOrder) do
		local eResourceType = self.eResourceType[row.ResourceIndex]
		local iNumToPlace;
		iNumToPlace = self.iOccurencesPerFrequency * self.iFrequency[row.ResourceIndex];
        slthLog('trying to place bonuses', iNumToPlace)
        iNumToPlace = iNumToPlace * iContinentMountainRatio
        slthLog('adjusted for continents', iNumToPlace)
		self:__ScorePlots(row.ResourceIndex);
		table.sort (self.aaPossibleLocs[row.ResourceIndex], function(a, b) return a.Score > b.Score; end);
		for iI = 1, iNumToPlace do
			if (iI <= #self.aaPossibleLocs[row.ResourceIndex]) then
				local iMapIndex = self.aaPossibleLocs[row.ResourceIndex][iI].MapIndex;
				local iScore = self.aaPossibleLocs[row.ResourceIndex][iI].Score;
				local pPlot = Map.GetPlotByIndex(iMapIndex);
				ResourceBuilder.SetResourceType(pPlot, eResourceType, 1);
			end
		end
	end
end

function newInitNWData(self)
    local iCount = 0;
	local iNonNW = 0;

	local excludedWonders = {};
	local excludeWondersConfig = GameConfiguration.GetValue("EXCLUDE_NATURAL_WONDERS");
	if(excludeWondersConfig and #excludeWondersConfig > 0) then
		slthLog("The following Natural Wonders have been marked as 'excluded':");
		for i,v in ipairs(excludeWondersConfig) do
			slthLog("* " .. v);
			excludedWonders[v] = true;
		end
	end

	for loop in GameInfo.Features() do
        -- slthLog(loop.FeatureType, GameInfo.NatWonders[loop.FeatureType])
		if(GameInfo.NatWonders[loop.FeatureType] and excludedWonders[loop.FeatureType] ~= true) then
            slthLog('added natWon')
			self.eFeatureType[iCount] = loop.Index;
			self.aaPossibleLocs[iCount] = {};
			iCount = iCount + 1;
		end
		iNonNW = iNonNW + 1;
	end

	self.iNumWondersInDB = iCount;
	iNonNW = iNonNW - iCount;

	local iJ = 1;
	for iI = 0, self.iNumWondersInDB - 1 do
		if(iJ <= #self.aInvalid and iI == self.aInvalid[iJ] - iNonNW) then
			self.aInvalidNaturalWonders[iI] = false;
			iJ = iJ + 1;
		else
			self.aInvalidNaturalWonders[iI] = true;
		end
	end
end

function AddLakesToPresentAreas(largeLakes)

	slthLog("Map Generation - Adding Lakes to correct areas");
	largeLakes = largeLakes or 0;

	local numLakesAdded = 0;
	local numLargeLakesAdded = 0;

	local lakePlotRand = GlobalParameters.LAKE_PLOT_RANDOM or 25;
	local iW, iH = Map.GetGridSize();

	for i = 0, (iW * iH) - 1, 1 do
		plot = Map.GetPlotByIndex(i);
		if(plot) then
			if (plot:IsWater() == false) then
				if (plot:IsCoastalLand() == false) then
                    if mountain_blocked[i] == largest_region then
                        if (plot:IsRiver() == false and plot:IsRiverAdjacent() == false) then
                            if (AdjacentToNaturalWonder(plot) == false) then
                                local r = TerrainBuilder.GetRandomNumber(lakePlotRand, "MapGenerator AddLakes");
                                if r == 0 then
                                    numLakesAdded = numLakesAdded + 1;
                                    if(largeLakes > numLargeLakesAdded) then
                                        local bLakes = AddMoreLake(plot);
                                        if(bLakes == true) then
                                            numLargeLakesAdded = numLargeLakesAdded + 1;
                                        end
                                    end

                                    TerrainBuilder.SetTerrainType(plot, g_TERRAIN_TYPE_COAST);
                                end
                            end
                        end
                    end
				end
			end
		end
	end

	-- this is a minimalist update because lakes have been added
	if numLakesAdded > 0 then
		slthLog(tostring(numLakesAdded).." lakes added")
		AreaBuilder.Recalculate();
	end
end

-- copied from inland sea. Used by master process. WrapX and Y are undefined, but doesnt matter
-- since they should be false.
function GetMapInitData(MapSize)
	local MapSizeTypes = {};
	local Width = 0;
	local Height = 0;

	for row in GameInfo.Maps() do
		if(MapSize == row.Hash) then
			Width = row.GridWidth;
			Height = row.GridHeight;
		end
	end

	return {Width = Width, Height = Height, WrapX = false, WrapY=false}				-- set for now, since was true???
end

-- from firaxis continents
function ApplyTerrain(plotTypes, terrainTypes)
    slthLog((g_iW * g_iH) - 1)
    slthLog(' final number above. length of terrainTypes and plotTypes is: ' .. #terrainTypes .. ', ' .. #plotTypes)
	for i = 0, (g_iW * g_iH) - 1, 1 do
		local pPlot = Map.GetPlotByIndex(i);
		if (plotTypes[i] == g_PLOT_TYPE_HILLS) then
			terrainTypes[i] = terrainTypes[i] + 1;
        elseif (plotTypes[i] == g_PLOT_TYPE_MOUNTAIN)  then
            terrainTypes[i] = terrainTypes[i] + 2;
		end
        if terrainTypes[i] then
            TerrainBuilder.SetTerrainType(pPlot, terrainTypes[i]);
        else
            slthLog('TRIED TO GET plot index ' .. i .. ' but did not exist or was NIL')
        end
	end
    -- fix 0, 0 being borked.
    local pPlot = Map.GetPlotByIndex(0);
    if pPlot then
        TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_GRASS_MOUNTAIN);
    end
end

function ConvertToFiraxisFormSimple(erebus_hex_grid, mapper)
    local loc_plotTypes = {}
    for idx, plot_info in pairs(erebus_hex_grid) do
        if plot_info then
            local converted_val = mapper[plot_info]
            if converted_val then
                table.insert(loc_plotTypes, converted_val)
            else
                slthLog('MAPPER COULDNT FIND CONVERSION FOR ITEM: $' .. plot_info .. '$ WITH index: ' .. idx)
                if idx == 0 then
                    slthLog('stopped insert in 0')
                else
                    slthLog('would inserting grass instead: ' .. g_TERRAIN_TYPE_GRASS)
                    table.insert(loc_plotTypes, g_TERRAIN_TYPE_GRASS)
                end
            end
        end
    end
    return loc_plotTypes
end

function FeatureGenerator:AddIceToMap()
    return
end

function AddFeatures()
	slthLog("Adding Features");
	-- Get Rainfall setting input by user.
	local rainfall = MapConfiguration.GetValue("rainfall");
	if rainfall == 4 then
		rainfall = 1 + TerrainBuilder.GetRandomNumber(3, "Random Rainfall - Lua");
	end
    if doErebusFeatures then
        local featureTypeMap = {featureIce='uhhh', featureJungle=GameInfo.Features['FEATURE_JUNGLE'].Index, featureOasis=GameInfo.Features['FEATURE_OASIS'].Index, featureFloodPlains=GameInfo.Features['FEATURE_FLOODPLAINS'].Index, featureForest=GameInfo.Features['FEATURE_FOREST'].Index, featureMarsh=GameInfo.Features['FEATURE_MARSH'].Index}
        -- Now plant forest or jungle and place floodplains and oasis
        for y = 1, g_iH do
            for x=1, g_iW do
                local plotIndex = GetIndex(x,y)
                local pPlot = Map.GetPlot(x, y)
                if plotIndex and pPlot then
                    -- forest and jungle
                    if not pPlot:IsWater() and terrainTypes[plotIndex] ~= g_TERRAIN_TYPE_DESERT and plotTypes[plotIndex] ~= g_PLOT_TYPE_MOUNTAIN then
                        -- Chance for trees based on rainfall
                        rainfall = GetRainfall(x,y)
                        if rainfall >= math.random() then       --Trees are present
                            local altitude = GetPlotAltitude(x,y)
                            if altitude < LeafyAltitude then
                                if rainfall >= JungleThreshold then
                                    if pPlot:IsFlatlands() and math.random() < ChanceForMarsh then
                                        TerrainBuilder.SetFeatureType(pPlot, featureTypeMap['featureJungle'])
                                        --TerrainBuilder.SetFeatureType(pPlot, featureTypeMap['featureMarsh'])
                                        -- if math.random() >= ChanceForOnlyMarsh then          --AHHH we cant have both marsh and jungle on a plot
                                            -- plot.setFeatureType(featureJungle,0)
                                    else
                                        TerrainBuilder.SetFeatureType(pPlot, featureTypeMap['featureJungle'])
                                    end
                                else
                                    TerrainBuilder.SetFeatureType(pPlot, featureTypeMap['featureForest'])
                                end
                            else
                                TerrainBuilder.SetFeatureType(pPlot, featureTypeMap['featureForest'])
                            end
                        end
                     end
                    -- scrub
                    if featureTypeMap['featureScrub'] and terrainTypes[plotIndex] == g_TERRAIN_TYPE_DESERT
                       and plotTypes[plotIndex] ~= g_PLOT_TYPE_MOUNTAIN
                       and plotTypes[plotIndex] ~= g_PLOT_TYPE_HILLS then
                        rainfall = GetRainfall(x,y)
                        if rainfall * 3.0 >= math.random() then
                            TerrainBuilder.SetFeatureType(pPlot, featureTypeMap['featureScrub'])
                        end
                    end
                    -- floodplains and Oasis
                    if terrainTypes[plotIndex] == g_TERRAIN_TYPE_DESERT and plotTypes[plotIndex] ~= g_PLOT_TYPE_MOUNTAIN and
                    plotTypes[plotIndex] ~= g_PLOT_TYPE_HILLS and not plotTypes[plotIndex] ~= g_PLOT_TYPE_OCEAN then
                        if pPlot:IsRiverAdjacent() then
                            TerrainBuilder.SetFeatureType(pPlot, featureTypeMap['featureFloodPlains'])
                        else
                            -- is this square surrounded by desert?
                            local foundNonDesert = False
                            -- slthLog"trying to place oasis"
                            for yy = y - 1, y + 2 do
                                for xx= x - 1, x + 2 do
                                    local ii = GetIndex(xx,yy)
                                    local surPlot = Map.GetPlotByIndex(xx,yy)
                                    if surPlot then
                                        if terrainTypes[plotIndex] ~= g_TERRAIN_TYPE_DESERT and plotTypes[plotIndex] ~= g_PLOT_TYPE_MOUNTAIN then
                                            -- slthLog"non desert neighbor"
                                            foundNonDesert = True
                                        elseif surPlot == 0 then
                                            -- slthLog"neighbor off map"
                                            foundNonDesert = True
                                        elseif plotTypes[plotIndex] ~= g_PLOT_TYPE_OCEAN then
                                            -- slthLog"water neighbor"
                                            foundNonDesert = True
                                        elseif surPlot.getFeatureType and surPlot.getFeatureType() == featureTypeMap['featureOasis'] then
                                            -- slthLog"oasis neighbor"
                                            foundNonDesert = True
                                        end
                                    end
                                end
                            end
                            if not foundNonDesert then
                                if math.random() < OasisChance then
                                    -- slthLog"placing oasis"
                                    TerrainBuilder.SetFeatureType(pPlot, featureTypeMap['featureOasis'])
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        local args = {rainfall = rainfall}
        featuregen = FeatureGenerator.Create(args);
        featuregen:AddFeatures(true, true);  --second parameter is whether or not rivers start inland);
    end
end

function AddFeaturesFromContinents()
	featuregen:AddFeaturesFromContinents();
end

function AddRiversSkipEmpty()
	--GlobalParameters.RIVER_SEA_WATER_RANGE_DEFAULT or
	local riverSourceRangeDefault = GlobalParameters.RIVER_SOURCE_RANGE_DEFAULT or 4;
	local seaWaterRangeDefault = 3;
	local plotsPerRiverEdge = GlobalParameters.RIVER_PLOTS_PER_EDGE or 12;

	slthLog("Map Generation - Adding Rivers, but skipping empty regions");

	local passConditions = {
		function(plot)
			return (plot:IsHills() or plot:IsMountain());
		end,

		function(plot)
			return (not plot:IsCoastalLand()) and (TerrainBuilder.GetRandomNumber(8, "MapGenerator AddRivers") == 0);
		end,

		function(plot)
			local area = plot:GetArea();
			return (plot:IsHills() or plot:IsMountain()) and (area:GetRiverEdgeCount() <	((area:GetPlotCount() / plotsPerRiverEdge) + 1));
		end,

		function(plot)
			local area = plot:GetArea();
			return (area:GetRiverEdgeCount() < (area:GetPlotCount() / plotsPerRiverEdge) + 1);
		end
	}

	for iPass, passCondition in ipairs(passConditions) do

		if (iPass <= 2) then
			riverSourceRange = riverSourceRangeDefault;
			seaWaterRange = seaWaterRangeDefault;
		else
			riverSourceRange = (riverSourceRangeDefault / 2);
			seaWaterRange = (seaWaterRangeDefault / 2);
		end

		local iW, iH = Map.GetGridSize();

		for i = 0, (iW * iH) - 1, 1 do
			local plot = Map.GetPlotByIndex(i);
			if(not plot:IsWater()) then
				if(passCondition(plot) and plot:IsNaturalWonder() == false and AdjacentToNaturalWonder(plot) == false) then
					if (not Map.FindWater(plot, riverSourceRange, true)) then
						if (not Map.FindWater(plot, seaWaterRange, false)) then
							local inlandCorner = TerrainBuilder.GetInlandCorner(plot);
							if(inlandCorner and plot:IsNaturalWonder() == false and AdjacentToNaturalWonder(plot) == false) then
                                local x = plot:GetX()
                                local y = plot:GetY()
                                local neighbours = newArea:get_valid_neighbors(x, y)
                                local legal_river
                                for _, neighbor_coords in ipairs(neighbours) do
                                    local nx, ny = neighbor_coords.x, neighbor_coords.y
                                    local nI = nx * ny
                                    if mountain_blocked[nI] and (mountain_blocked[nI] == largest_region) then
                                        legal_river = true
                                        break
                                    end
                                end
                                if legal_river then
                                    DoRiver(inlandCorner);
                                    slthLog('making river at plot', x, y)
                                end
							end
						end
					end
				end
			end
		end
	end
end

function AddRiversInlandLake()

	slthLog("Map Generation - Adding Rivers");

	local iW, iH = Map.GetGridSize();
	local orig_direction, current_direction, pStartPlot;

	for i = 0, (iW * iH) - 1, 1 do
		plot = Map.GetPlotByIndex(i);
		if (plot:IsCoastalLand()) then
			if (plot:IsNaturalWonder() == false and AdjacentToNaturalWonder(plot) == false) then
				local pNWPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
				local pNEPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
				local pEPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_EAST);
				local pSEPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_SOUTHEAST);
				local pSWPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_SOUTHWEST);
				local pWPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_WEST);

				-- Don't start any rivers really near the map edge
				if (pNWPlot ~= nil and pNEPlot ~= nil and pEPlot ~= nil and pSEPlot ~= nil and pSWPlot ~= nil and pWPlot ~= nil) then

				    -- ... or near another river
					if (plot and not pNWPlot:IsRiver() and not pNEPlot:IsRiver() and not pEPlot:IsRiver() and not pSEPlot:IsRiver() and not pSWPlot:IsRiver() and not pWPlot:IsRiver()) then

						if     (pEPlot:IsWater()  and not pSEPlot:IsWater() and not pSWPlot:IsWater() and not pWPlot:IsWater())  then
							TryStartRiver(plot, FlowDirectionTypes.FLOWDIRECTION_NORTHEAST);
						elseif (pSEPlot:IsWater() and not pSWPlot:IsWater() and not pWPlot:IsWater()  and not pNWPlot:IsWater()) then
							TryStartRiver(plot, FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST);
						elseif (pSWPlot:IsWater() and not pWPlot:IsWater()  and not pNWPlot:IsWater() and not pNEPlot:IsWater()) then
							TryStartRiver(plot, FlowDirectionTypes.FLOWDIRECTION_SOUTH);
						elseif (pWPlot:IsWater()  and not pNWPlot:IsWater() and not pNEPlot:IsWater() and not pEPlot:IsWater())  then
							TryStartRiver(plot, FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST);
						elseif (pNWPlot:IsWater() and not pNEPlot:IsWater() and not pEPlot:IsWater()  and not pSEPlot:IsWater()) then
							TryStartRiver(plot, FlowDirectionTypes.FLOWDIRECTION_NORTHWEST);
						elseif (pNEPlot:IsWater() and not pEPlot:IsWater()  and not pSEPlot:IsWater() and not pSWPlot:IsWater()) then
							TryStartRiver(plot, FlowDirectionTypes.FLOWDIRECTION_NORTH);
						end
					end
				end
			end
		end
	end
end

function TryStartRiver(pStartPlot, directionIntoSea)
	local iW, iH = Map.GetGridSize();
	-- Check N/S flow direction for match
	if (pStartPlot:GetX() < iW / 2) then
		-- Should flow south
		if (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_NORTHEAST or directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_NORTH or directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_NORTHWEST) then
			return;
		end
	else
		-- Should flow north
		if (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST or directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_SOUTH or directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST) then
			return;
		end
	end
	if (pStartPlot:GetY() < iH / 2) then
		-- Should flow west
		if (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_NORTHEAST or directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST) then
			return;
		end
	else
		-- Should flow east
		if (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_NORTHWEST or directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST) then
			return;
		end
	end
	if NotCloseToAnotherRiver(pStartPlot) and not IsAdjacentMountain(pStartPlot) and not IsAdjacentRiver(pStartPlot, -1) then
		table.insert(g_riverStartPlots, pStartPlot:GetIndex());
		local current_direction;
		local iRand = TerrainBuilder.GetRandomNumber (2, "River First Turn Rand");
		if     (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_NORTHEAST) then
			TerrainBuilder.SetNWOfRiver(pStartPlot, true, directionIntoSea);
			current_direction = FlowDirectionTypes.FLOWDIRECTION_NORTH;
			if (iRand == 1) then
				current_direction = FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST;
			end
		elseif (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST) then
			TerrainBuilder.SetNEOfRiver(pStartPlot, true, directionIntoSea);
			local pWPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_WEST);
			pStartPlot = pWPlot;
			current_direction = FlowDirectionTypes.FLOWDIRECTION_SOUTH;
			if (iRand == 1) then
				current_direction = FlowDirectionTypes.FLOWDIRECTION_NORTHEAST;
			end
		elseif (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_SOUTH) then
			local pWPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_WEST);
			TerrainBuilder.SetWOfRiver(pWPlot, true, directionIntoSea);
			local pNWPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
			pStartPlot = pNWPlot;
			current_direction = FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST;
			if (iRand == 1) then
				current_direction = FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST;
			end
		elseif (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST) then
			local pNWPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
			TerrainBuilder.SetNWOfRiver(pNWPlot, true, directionIntoSea);
			pStartPlot = pNWPlot;
			current_direction = FlowDirectionTypes.FLOWDIRECTION_SOUTH;
			if (iRand == 1) then
				current_direction = FlowDirectionTypes.FLOWDIRECTION_NORTHWEST;
			end
		elseif (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_NORTHWEST) then
			local pNEPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
			TerrainBuilder.SetNEOfRiver(pNEPlot, true, directionIntoSea);
			pStartPlot = pNEPlot;
			current_direction = FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST;
			if (iRand == 1) then
				current_direction = FlowDirectionTypes.FLOWDIRECTION_NORTH;
			end

		elseif (directionIntoSea == FlowDirectionTypes.FLOWDIRECTION_NORTH) then
			TerrainBuilder.SetWOfRiver(pStartPlot, true, directionIntoSea);
			current_direction = FlowDirectionTypes.FLOWDIRECTION_NORTHWEST;
			if (iRand == 1) then
				current_direction = FlowDirectionTypes.FLOWDIRECTION_NORTHEAST;
			end
		end
		DoRiverReverse(pStartPlot, current_direction, directionIntoSea, 8 + (Map.GetMapSize() * 3), 1, g_iRiverID);
		g_iRiverID = g_iRiverID + 1;
	end
end

function NotCloseToAnotherRiver(pStartPlot)
	local iNotAllowedAsCloseAs = 4;
	local iPlotIndex = pStartPlot:GetIndex();
	for i, riverPlotIndex in ipairs(g_riverStartPlots) do
		if (Map.GetPlotDistance(iPlotIndex, riverPlotIndex) <= iNotAllowedAsCloseAs) then
		    return false;
		end
	end
	return true;
end

function IsAdjacentMountain(pPlot)
	local adjacentPlot;
	local numDirections = DirectionTypes.NUM_DIRECTION_TYPES;
	for direction = 0, numDirections - 1, 1 do
		adjacentPlot = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), direction);
		if (adjacentPlot ~= nil) then
	   		local i = adjacentPlot:GetY() * g_iW + adjacentPlot:GetX();
			if (plotTypes[i] == g_PLOT_TYPE_MOUNTAIN) then
				return true;
			end
		end
	end
	return false;
end

function IsAdjacentRiver(pPlot, iRiverID)
	local adjacentPlot;
	local numDirections = DirectionTypes.NUM_DIRECTION_TYPES;
	for direction = 0, numDirections - 1, 1 do
		adjacentPlot = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), direction);
		if (adjacentPlot ~= nil) then
	   		local i = adjacentPlot:GetY() * g_iW + adjacentPlot:GetX();
            slthLog('river plot is' ,i, g_riverPlots[i])
			if (g_riverPlots[i] > 0 and iRiverID ~= g_riverPlots[i]) then
				return true;
			end
		end
	end
	return false;
end

function DoRiverReverse(startPlot, thisFlowDirection, originalFlowDirection, minLength, curLength, iRiverID)

	slthLog("Creating River at: " .. tostring(startPlot:GetX()) .. ", ".. tostring(startPlot:GetY()));

	thisFlowDirection = thisFlowDirection or FlowDirectionTypes.NO_FLOWDIRECTION;
	originalFlowDirection = originalFlowDirection or FlowDirectionTypes.NO_FLOWDIRECTION;

	slthLog("thisFlowDirection: " .. tostring(thisFlowDirection));
	slthLog("originalFlowDirection: " .. tostring(originalFlowDirection));
	slthLog("minLength: " .. tostring(minLength));
	slthLog("curLength: " .. tostring(curLength));
	slthLog("iRiverID: " .. tostring(iRiverID));

	-- pStartPlot = the plot at whose SE corner the river is starting
	local riverPlot;

	local bestFlowDirection = FlowDirectionTypes.NO_FLOWDIRECTION;
	if (thisFlowDirection == FlowDirectionTypes.FLOWDIRECTION_NORTH) then

		riverPlot = Map.GetAdjacentPlot(startPlot:GetX(), startPlot:GetY(), DirectionTypes.DIRECTION_SOUTHWEST);
		if (riverPlot == nil) then
			return;
		end

		local adjacentPlot = Map.GetAdjacentPlot(riverPlot:GetX(), riverPlot:GetY(), DirectionTypes.DIRECTION_EAST);
		if (adjacentPlot == nil or riverPlot:IsWOfRiver() or riverPlot:IsWater() or adjacentPlot:IsWater()) then
			if (riverPlot:IsWater()) then
				TerrainBuilder.SetWOfRiver(riverPlot, true, thisFlowDirection);
			end
			return;
		end

		TerrainBuilder.SetWOfRiver(riverPlot, true, thisFlowDirection);
		-- riverPlot does not change
		slthLog("At (x,y) SetWOfRiver, flowDirection = ", riverPlot:GetX(), riverPlot:GetY(), thisFlowDirection);

	elseif (thisFlowDirection == FlowDirectionTypes.FLOWDIRECTION_NORTHEAST) then

		riverPlot = startPlot;
		local adjacentPlot = Map.GetAdjacentPlot(riverPlot:GetX(), riverPlot:GetY(), DirectionTypes.DIRECTION_SOUTHEAST);
		if (adjacentPlot == nil or riverPlot:IsNWOfRiver() or riverPlot:IsWater() or adjacentPlot:IsWater()) then
			if (riverPlot:IsWater()) then
				TerrainBuilder.SetNWOfRiver(riverPlot, true, thisFlowDirection);
			end
			return;
		end

		TerrainBuilder.SetNWOfRiver(riverPlot, true, thisFlowDirection);
		-- riverPlot does not change
		slthLog("At (x,y) SetNWOfRiver, flowDirection = ", riverPlot:GetX(), riverPlot:GetY(), thisFlowDirection);

	elseif (thisFlowDirection == FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST) then

		riverPlot = startPlot;
		local adjacentPlot = Map.GetAdjacentPlot(riverPlot:GetX(), riverPlot:GetY(), DirectionTypes.DIRECTION_SOUTHWEST);
		if (adjacentPlot == nil or riverPlot:IsNEOfRiver() or riverPlot:IsWater() or adjacentPlot:IsWater()) then
			if (riverPlot:IsWater()) then
					TerrainBuilder.SetNEOfRiver(riverPlot, true, thisFlowDirection);
			end
			return;
		end

		TerrainBuilder.SetNEOfRiver(riverPlot, true, thisFlowDirection);
        local riverX = riverPlot:GetX()
        local riverY = riverPlot:GetY()
		riverPlot = Map.GetAdjacentPlot(riverX, riverY, DirectionTypes.DIRECTION_WEST);
		slthLog("At (x,y) SetNEOfRiver, flowDirection = ", riverX, riverY, thisFlowDirection);

	elseif (thisFlowDirection == FlowDirectionTypes.FLOWDIRECTION_SOUTH) then

		riverPlot = startPlot;
		local adjacentPlot = Map.GetAdjacentPlot(riverPlot:GetX(), riverPlot:GetY(), DirectionTypes.DIRECTION_EAST);
		if (adjacentPlot == nil or riverPlot:IsWOfRiver() or riverPlot:IsWater() or adjacentPlot:IsWater() ) then
			if (riverPlot:IsWater()) then
				TerrainBuilder.SetWOfRiver(riverPlot, true, thisFlowDirection);
			end
			return;
		end

		TerrainBuilder.SetWOfRiver(riverPlot, true, thisFlowDirection);
        local riverX = riverPlot:GetX()
        local riverY = riverPlot:GetY()
		riverPlot = Map.GetAdjacentPlot(riverX, riverY, DirectionTypes.DIRECTION_NORTHEAST);
		slthLog("At (x,y) SetWOfRiver, flowDirection = ", riverX, riverY, thisFlowDirection);

	elseif (thisFlowDirection == FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST) then

		riverPlot = startPlot;
		local adjacentPlot = Map.GetAdjacentPlot(riverPlot:GetX(), riverPlot:GetY(), DirectionTypes.DIRECTION_SOUTHEAST);
		if (adjacentPlot == nil or riverPlot:IsNWOfRiver() or riverPlot:IsWater() or adjacentPlot:IsWater() ) then
			if (riverPlot:IsWater()) then
				TerrainBuilder.SetNWOfRiver(riverPlot, true, thisFlowDirection);
			end
				return;
		end

		TerrainBuilder.SetNWOfRiver(riverPlot, true, thisFlowDirection);
		-- riverPlot does not change
		slthLog("At (x,y) SetNWOfRiver, flowDirection = ", riverPlot:GetX(), riverPlot:GetY(), thisFlowDirection);

	elseif (thisFlowDirection == FlowDirectionTypes.FLOWDIRECTION_NORTHWEST) then

		riverPlot = Map.GetAdjacentPlot(startPlot:GetX(), startPlot:GetY(), DirectionTypes.DIRECTION_EAST);
		if (riverPlot == nil) then
			return;
		end

		local adjacentPlot = Map.GetAdjacentPlot(riverPlot:GetX(), riverPlot:GetY(), DirectionTypes.DIRECTION_SOUTHWEST);
		if (adjacentPlot == nil or riverPlot:IsNEOfRiver() or riverPlot:IsWater() or adjacentPlot:IsWater()) then
			if (riverPlot:IsWater()) then
				TerrainBuilder.SetNEOfRiver(riverPlot, true, thisFlowDirection);
			end
			return;
		end

		TerrainBuilder.SetNEOfRiver(riverPlot, true, thisFlowDirection);
		-- riverPlot does not change
		slthLog("At (x,y) SetNEOfRiver, flowDirection = ", riverPlot:GetX(), riverPlot:GetY(), thisFlowDirection);

	else
		-- River is starting here, set the direction in the next step
		riverPlot = startPlot;
	end

	if riverPlot and (IsAdjacentRiver(riverPlot, iRiverID)
		    or (IsAdjacentMountain(riverPlot) and curLength > minLength)
		    or (curLength > minLength * 1.5)) then

		-- The river has flowed off into a lake or another river, next to a mountain (having met minimum distance), or equalled min length +50%.  We are done.
		slthLog("DoRiverReverse() success");
		return;
	end
    if riverPlot then
        -- Storing X,Y positions as locals to prevent redundant function calls.
        local riverPlotX = riverPlot:GetX();
        local riverPlotY = riverPlot:GetY();

        slthLog("River Plot now (x, y): ", riverPlotX, riverPlotY);

        -- Mark this plot as having a river so we don't come here again
        local iMapIndex = riverPlotY * g_iW + riverPlotX;
        g_riverPlots[iMapIndex] = iRiverID;
        slthLog('setting river plot', iMapIndex, iRiverID)

        -- Table of methods used to determine the adjacent plot.
        local adjacentPlotFunctions = {
            [FlowDirectionTypes.FLOWDIRECTION_NORTH] = function()
                return Map.GetAdjacentPlot(riverPlotX, riverPlotY, DirectionTypes.DIRECTION_NORTHWEST);
            end,

            [FlowDirectionTypes.FLOWDIRECTION_NORTHEAST] = function()
                return Map.GetAdjacentPlot(riverPlotX, riverPlotY, DirectionTypes.DIRECTION_NORTHEAST);
            end,

            [FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST] = function()
                return Map.GetAdjacentPlot(riverPlotX, riverPlotY, DirectionTypes.DIRECTION_EAST);
            end,

            [FlowDirectionTypes.FLOWDIRECTION_SOUTH] = function()
                return Map.GetAdjacentPlot(riverPlotX, riverPlotY, DirectionTypes.DIRECTION_SOUTHWEST);
            end,

            [FlowDirectionTypes.FLOWDIRECTION_SOUTHWEST] = function()
                return Map.GetAdjacentPlot(riverPlotX, riverPlotY, DirectionTypes.DIRECTION_WEST);
            end,

            [FlowDirectionTypes.FLOWDIRECTION_NORTHWEST] = function()
                return Map.GetAdjacentPlot(riverPlotX, riverPlotY, DirectionTypes.DIRECTION_NORTHWEST);
            end
        }

        if(bestFlowDirection == FlowDirectionTypes.NO_FLOWDIRECTION) then

            -- Attempt to calculate the best flow direction.
            local bestValue = math.huge;
            for flowDirection, getAdjacentPlot in pairs(adjacentPlotFunctions) do

                if (GetOppositeFlowDirection(flowDirection) ~= originalFlowDirection) then

                    if (thisFlowDirection == FlowDirectionTypes.NO_FLOWDIRECTION or
                        flowDirection == TurnRightFlowDirections[thisFlowDirection] or
                        flowDirection == TurnLeftFlowDirections[thisFlowDirection]) then

                        local adjacentPlot = getAdjacentPlot();

                        if (adjacentPlot ~= nil) then

                            local value = GetRiverValueAtPlot(adjacentPlot);
                            if (flowDirection == originalFlowDirection) then
                                value = value / 4;
                            end

                            if (value < bestValue) then
                                bestValue = value;
                                bestFlowDirection = flowDirection;
                            end
                        end
                    end
                end
            end

            if(bestFlowDirection == FlowDirectionTypes.NO_FLOWDIRECTION) then

                -- Patch river to north edge of map if can't flow off their normally
                if (originalFlowDirection == FlowDirectionTypes.FLOWDIRECTION_NORTHEAST) then
                    TerrainBuilder.SetNWOfRiver(riverPlot, true, FlowDirectionTypes.FLOWDIRECTION_NORTHEAST, riverID);
                    TerrainBuilder.SetWOfRiver(riverPlot, true, FlowDirectionTypes.FLOWDIRECTION_NORTH, riverID);
                    slthLog("*** NORTH EDGE OF MAP RIVER REPAIR ***");
                end
            end
        end
    end

		--Recursively generate river.
	if (bestFlowDirection ~= FlowDirectionTypes.NO_FLOWDIRECTION) then
		DoRiverReverse(riverPlot, bestFlowDirection, originalFlowDirection, minLength, curLength +1, iRiverID);
	end
end

function do_ascii(plot_types, terrain_types,do_feature, text, by_actual)
    local tPlotString = {[0] = 'W', [1] = 'L', [2] = 'H', [3] = 'M', ['0'] = 'W', ['1'] = 'L', ['2'] = 'H', ['3'] = 'M'}

    local tTerrainString = {['0'] = 'D',
     ['1'] = 'P',
     ['2'] =  'I',
     ['3'] = 'T',
     ['4'] = 'G',
     ['5'] =  'H',
     ['6'] = 'C',
     ['7'] = 'W',
     ['8'] = 'M',
     ['9'] = 'G'}

    local count = 0
    local plot_type_ascii = ''
    local terrain_type_ascii = ''
    local feature_type_ascii = ''
    local plot_ascii_list = {}
    local terrain_ascii_list = {}
    local feature_ascii_list = {}
    for i = 1, (g_iW * g_iH) - 1, 1 do
		local pPlot = Map.GetPlotByIndex(i);
        if count == g_iW then
            count = 0
            table.insert(plot_ascii_list, plot_type_ascii)
            table.insert(terrain_ascii_list, terrain_type_ascii)
            table.insert(feature_ascii_list, feature_type_ascii)
            plot_type_ascii = ''
            terrain_type_ascii = ''
            feature_type_ascii = ''
        end
        count = count + 1
        local plot_type
        local terrain_type
        if by_actual then
            plot_type = tPlotString[tostring(plot_types[i])] or tostring(plot_types[i])
            terrain_type = tTerrainString[tostring(terrain_types[i])] or tostring(terrain_types[i])
        else
            plot_type = pPlot:GetTerrainClassType()
            terrain_type = pPlot:GetTerrainType()
        end
        plot_type_ascii = plot_type_ascii .. plot_type .. '|'
        terrain_type_ascii = terrain_type_ascii .. terrain_type .. '|'
        if do_feature then
            feature_type_ascii = feature_type_ascii .. tostring(pPlot:GetFeatureType(i)) .. '|'
        end
	end

    slthLog('plot types, length:', #plot_ascii_list)
    slthLog('START; '.. 'plotTypes' .. text)
    for _, i in ipairs(plot_ascii_list) do
        slthLog(i)
    end
    slthLog('STOP')
    slthLog('terrain, length:', #terrain_ascii_list)
    slthLog('START; '.. 'terrainTypes' .. text)
    for _, i in ipairs(terrain_ascii_list) do
        slthLog(i)
    end
    slthLog('STOP')
    slthLog('features')
    slthLog('START; '.. 'featureTypes' .. text)
    for _, i in ipairs(feature_ascii_list) do
        slthLog(i)
    end
    slthLog('STOP')
end


