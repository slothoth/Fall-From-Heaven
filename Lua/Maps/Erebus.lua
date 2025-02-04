-- compatability
function MapSize()
    return 100
end

--[[include "MapEnums"
include "MapUtilities"
include "MountainsCliffs"
include "RiversLakes"
include "FeatureGenerator"
include "TerrainGenerator"
include "NaturalWonderGenerator"
include "ResourceGenerator"
include "AssignStartingPlots"
]]--
local g_iW, g_iH;
local g_iFlags = {};
local g_iNumTotalLandTiles = 0;

function simplecopy(t)
    local copy = {}
    for k, v in pairs(t) do
        copy[k] = v
    end
    return copy
end

-- This variable will make a percentage of peaks into hills in order to break
-- up the worlds valleys. I set this to zero because I feel it diminishes the
-- illusion of differing climates between valleys and looks bad.
local SoftenPeakPercent = 0.0

-- This variable decides how many tiles of drainage is needed to create a
-- river.
local RiverThreshold = 5.0

-- The amount of rainfall in the dryest desert. Must be between 1.0 and 0.0
local MinRainfall = .25

-- This number is multiplied by the RiverThreshold to determine when a river
-- is large enough to have a 100% chance to flatten nearby hills and peaks.
local RiverFactorFlattensAll = 10.0

local RiverAddsMoistureRange = .20
local RiverAddsMoistureMax = 10.0

-- These variables control the frequency of hills and peaks at the lowest
-- and highest altitudes
local HillChanceAtZero = .15
local HillChanceAtOne = .90
local PeakChanceAtZero = .0
local PeakChanceAtOne = .20

-- These valiables control the moisture thresholds for desert and plains
local JungleThreshold = .90
local PlainsThreshold = .50
local DesertThreshold = .30

-- Chance for jungle to have marsh, and chance for marsh to replace jungle
local ChanceForMarsh = 0.30
local ChanceForOnlyMarsh = 0.33

-- These variables control the altitude of tundra and ice. Also, in Civ,
-- deserts are supposed to be hot, so we'll limit the altitude for deserts
local TundraThreshold = .74
local IceThreshold = .84
local MaxDesertAltitude = .65

-- The type of trees are controlled by altitude. Snowy trees use TundraThreshold.
-- Lower than leafy is Jungle.
local LeafyAltitude = .30
local EvergreenAltitude = .60

-- Chance for an oasis to appear in desert
local OasisChance = .08

-- Map constants - I'm making a point on this map to hardcode nothing, so some
-- of these may seem a bit obscure.
-- -------------------------------------------------------------------
local RegionsPerPlot = 0.009  -- Map regions(valleys, seas) per map plot
local WaterRegionsPerPlot = 0.002  -- Water regions per map plot
local MinSeedRange = 5  -- Closest that a region seed can be placed to another
local MinEdgeRange = 5  -- Closest that a region seed can be to map edge
local ChanceToGrow = 0.25  -- Base chance for each tile in region to grow
local EdgeLimit = 2  -- Region stops growing this far from edge
local RiverAltitudeSubtraction = 2.0  -- Amount subtracted from a plots altitude depending on river size
local RiverAltRangeFactor = 2.0  -- Amount of RiverThreshold to use for altitude calc
local MinRegionSizeStart = 40  -- Minimum region size for a starting plot
local MinRegionSizeTower = 30  -- Minimum region size for a tower placement
local ChokePointAreaSize = 10  -- chokepoint needs this size area on both sides
local ChokePointWalkAroundDistance = 12  -- chokepoint must cause this much extra walking to be considered a choke


function GetCivPreferences()
    --  Civs without preferences will use default values.
    --  These weights influence the effect of each preference. moistureWeight
    --  is hard coded as 1.0 for civ placement
    --  pref['altitudeWeight'] = 0.25
    --  pref['distanceWeight'] = 0.25 #how hard to try to start away from other civs

    local default_civ = {idealAltitude = 0.35, idealMoisture = 0.7, altitudeWeight = 1.0, distanceWeight = 2.0}
    local civPreferenceList = {}

    local pref = simplecopy(default_civ)
    pref['civ'] = 'CIVILIZATION_MALAKIM'
    pref['idealMoisture'] = 0.1
    pref['idealAltitude'] = 0.25
    pref['altitudeWeight'] = 0.25
    pref['distanceWeight'] = 0.25
    pref['needCoastalStart'] = nil
    pref['allowForestStart'] = nil
    table.insert(civPreferenceList, pref)

    pref = simplecopy(default_civ)
	pref['civ'] = 'CIVILIZATION_DOVIELLO'
    pref['idealMoisture'] = 0.8
    pref['idealAltitude'] = 0.95
    pref['altitudeWeight'] = 2.0
    pref['distanceWeight'] = 0.75
    pref['needCoastalStart'] = nil
    pref['allowForestStart'] = nil
    table.insert(civPreferenceList, pref)

    pref = simplecopy(default_civ)
	pref['civ'] = 'CIVILIZATION_ILLIANS'
    pref['idealMoisture'] = 0.5
    pref['idealAltitude'] = 0.95
    pref['altitudeWeight'] = 2.0
    pref['distanceWeight'] = 0.75
    pref['needCoastalStart'] = nil
    pref['allowForestStart'] = nil
    table.insert(civPreferenceList, pref)

    pref = simplecopy(default_civ)
	pref['civ'] = 'CIVILIZATION_KHAZAD'
    pref['idealMoisture'] = 0.35
    pref['idealAltitude'] = 0.75
    pref['altitudeWeight'] = 2.0
    pref['distanceWeight'] = 0.75
    pref['needCoastalStart'] = nil
    pref['allowForestStart'] = nil
    table.insert(civPreferenceList, pref)

    pref = simplecopy(default_civ)
	pref['civ'] = 'CIVILIZATION_LUCHUIRP'
    pref['idealMoisture'] = 0.35
    pref['idealAltitude'] = 0.75
    pref['altitudeWeight'] = 2.0
    pref['distanceWeight'] = 0.75
    pref['needCoastalStart'] = nil
    pref['allowForestStart'] = nil
    table.insert(civPreferenceList, pref)

    pref = simplecopy(default_civ)
	pref['civ'] = 'CIVILIZATION_LJOSALFAR'
    pref['idealMoisture'] = 0.75
    pref['idealAltitude'] = 0.23
    pref['altitudeWeight'] = 2.0
    pref['distanceWeight'] = 0.25
    pref['needCoastalStart'] = nil
    pref['allowForestStart'] = true
    table.insert(civPreferenceList, pref)

    pref = simplecopy(default_civ)
	pref['civ'] = 'CIVILIZATION_LANUN'
    pref['idealMoisture'] = 0.5
    pref['idealAltitude'] = 0.0
    pref['altitudeWeight'] = 2.0
    pref['distanceWeight'] = 0.25
    pref['needCoastalStart'] = true
    pref['allowForestStart'] = nil
    table.insert(civPreferenceList, pref)

    pref = simplecopy(default_civ)
	pref['civ'] = 'CIVILIZATION_HIPPUS'
    pref['idealMoisture'] = 0.4
    pref['idealAltitude'] = 0.1
    pref['altitudeWeight'] = 0.5
    pref['distanceWeight'] = 0.25
    pref['needCoastalStart'] = nil
    pref['allowForestStart'] = nil
    table.insert(civPreferenceList, pref)

    pref = simplecopy(default_civ)
	pref['civ'] = 'CIVILIZATION_SVARTALFAR'
    pref['idealMoisture'] = 0.7
    pref['idealAltitude'] = 0.35
    pref['altitudeWeight'] = 1.0
    pref['distanceWeight'] = 2.0
    pref['needCoastalStart'] = nil
    pref['allowForestStart'] = true
    table.insert(civPreferenceList, pref)

    return civPreferenceList
end

function GetImprovementPreferences()
    -- These values are similar to the way civs work except distanceWeight is
    -- hardcoded as 1.0
    local default_NWon = {idealAltitude = 0.5, idealMoisture = 0.6, altitudeWeight = 1.0, moistureWeight = 2.0}
    local impPreferenceList = {}
    local pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_GUARDIAN"
    pref['idealAltitude'] = .8
    pref['moistureWeight'] = .5
    pref['needChoke'] = true  -- Only for guardian at this time
    table.insert(impPreferenceList, pref)

    -- Removed to prevent 2 brigits from appearing upon moving improvement
    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_RING_OF_CARCER"
    pref['idealAltitude'] = 1.0
    pref['moistureWeight'] = .25
    pref['altitudeWeight'] = 3.0
    pref['needHill'] = true
    pref['favoredTerrain'] = GetInfoType("TERRAIN_SNOW")
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_SEVEN_PINES"
    pref['idealAltitude'] = .6
    pref['moistureWeight'] = 1.0
    pref['altitudeWeight'] = .5
    pref['favoredTerrain'] = GetInfoType("TERRAIN_GRASS")
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_STANDING_STONES"
    pref['idealMoisture'] = .75
    pref['idealAltitude'] = .5
    pref['moistureWeight'] = 1.0
    pref['altitudeWeight'] = .5
    pref['needFlat'] = true
    pref['favoredTerrain'] = GetInfoType("TERRAIN_GRASS")
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_BROKEN_SEPULCHER"
    pref['idealAltitude'] = .5
    pref['moistureWeight'] = .5
    pref['altitudeWeight'] = .5
    pref['needFlat'] = true
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_MIRROR_OF_HEAVEN"
    pref['idealMoisture'] = .0
    pref['idealAltitude'] = .0
    pref['altitudeWeight'] = .25
    pref['favoredTerrain'] = GetInfoType("TERRAIN_DESERT")
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_DRAGON_BONES"
    pref['idealMoisture'] = .35
    pref['idealAltitude'] = .35
    pref['moistureWeight'] = 1.0
    pref['needFlat'] = true
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_LETUM_FRIGUS"
    pref['idealMoisture'] = .7
    pref['idealAltitude'] = 1.0
    pref['moistureWeight'] = .5
    pref['altitudeWeight'] = 2.0
    pref['needFlat'] = true
    pref['favoredTerrain'] = GetInfoType("TERRAIN_SNOW")
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_ODIOS_PRISON"
    pref['idealMoisture'] = .35
    pref['idealAltitude'] = .75
    pref['moistureWeight'] = 1.0
    pref['altitudeWeight'] = 2.0
    pref['needFlat'] = true
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_POOL_OF_TEARS"
    pref['idealMoisture'] = .5
    pref['idealAltitude'] = .5
    pref['moistureWeight'] = 1.0
    pref['needFlat'] = true
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_PYRE_OF_THE_SERAPHIC"
    pref['idealMoisture'] = 1.0
    pref['idealAltitude'] = 0.0
    pref['altitudeWeight'] = .5
    pref['needFlat'] = true
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_REMNANTS_OF_PATRIA"
    pref['idealAltitude'] = .5
    pref['moistureWeight'] = .5
    pref['altitudeWeight'] = .5
    pref['needFlat'] = true  -- Forest hill gives 9 hammers which is OP imo.
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_TOMB_OF_SUCELLUS"
    pref['idealAltitude'] = .5
    pref['moistureWeight'] = 1.0
    pref['altitudeWeight'] = .5
    pref['needFlat'] = true
    table.insert(impPreferenceList, pref)

    pref = simplecopy(default_NWon)
	pref['improvement'] = "IMPROVEMENT_YGGDRASIL"
    pref['idealMoisture'] = .75
    pref['idealAltitude'] = .25
    pref['favoredTerrain'] = GetInfoType("TERRAIN_GRASS")
    table.insert(impPreferenceList, pref)

    return impPreferenceList
end

function GetRxIndex(x, y)
    -- Check X for wrap
    local yy
    local xx
    if WrapX == True then
        xx = x % (mapSize.MapWidth + 1)
    elseif x < 0 or x >= (mapSize.MapWidth + 1) then
        return -1
    else
        xx = x
    end
    -- Check y for wrap
    if WrapY == True then
        yy = y % (mapSize.MapHeight + 1)
    elseif y < 0 or y >= (mapSize.MapHeight + 1) then
        return -1
    else
        yy = y
    end
    return yy * (mapSize.MapWidth + 1) + xx
end

-- RegionMap class implementation in Lua
RegionMap = {}
RegionMap.__index = RegionMap

function RegionMap.new()
    local self = setmetatable({}, RegionMap)
    return self
end

function RegionMap:createRegions()
    -- Direction constants
    self.L = 0
    self.N = 1
    self.S = 2
    self.E = 3
    self.W = 4
    self.NE = 5
    self.NW = 6
    self.SE = 7
    self.SW = 8

    self.highestRegionAltitude = 0
    local numTiles = mapSize.MapWidth * mapSize.MapHeight
    local numRx = (mapSize.MapWidth + 1) * (mapSize.MapHeight + 1)

    print(string.format("MapWidth = %d, MapHeight = %d", mapSize.MapWidth, mapSize.MapHeight))

    -- Initialize arrays
    self.regionMap = {}
    self.regionRxMap = {}
    self.regionList = {}
    self.regionPlotList = {}

    -- Fill arrays with -1
    for i = 1, numTiles do
        self.regionMap[i] = -1
    end

    for i = 1, numRx do
        self.regionRxMap[i] = -1
    end

    local numRegions = math.floor(numTiles * RegionsPerPlot)
    print(string.format("numTiles = %d, numRegions = %d", numTiles, numRegions))

    -- Create regions
    for i = 1, numRegions do
        local iterations = 0
        while true do
            iterations = iterations + 1
            if iterations > 10000 then
                error("endless loop in region seed placement")
            end

            local seedX = math.random(mapSize.MapWidth + 1, 0)
            local seedY = math.random(mapSize.MapHeight + 1, 0)

            if not self:isSeedBlocked(seedX, seedY) then
                local region = Region.new(i, seedX, seedY)
                table.insert(self.regionList, region)
                local n = GetRxIndex(seedX, seedY)
                self.regionRxMap[n] = i
                local plot = RegionPlot.new(i, seedX, seedY)
                table.insert(self.regionPlotList, plot)

                for direction = 1, 8 do
                    local xx, yy = self:getXYFromDirection(seedX, seedY, direction)
                    local nn = GetRxIndex(xx, yy)
                    self.regionRxMap[nn] = i
                    plot = RegionPlot.new(i, xx, yy)
                    table.insert(self.regionPlotList, plot)
                end
                break
            end
        end
    end

    -- Region growth
    local iterations = 0
    while #self.regionPlotList > 0 do
        iterations = iterations + 1
        if iterations > 200000 then
            self:PrintRegionRxMap(false)
            error("endless loop in region growth")
        end

        local plot = self.regionPlotList[1]
        local region = self:getRegionByID(plot.regionID)

        if not region.isGrowing then
            table.remove(self.regionPlotList, 1)
            goto continue
        end

        local roomLeft = false
        for direction = 1, 4 do
            local xx, yy = self:getXYFromDirection(plot.x, plot.y, direction)
            local i = GetRxIndex(xx, yy)

            if i == -1 or self:rxTouchesMapEdge(xx, yy) then
                if self:canRegionGrowHere(xx, yy, plot.regionID) then
                    self.regionRxMap[i] = plot.regionID
                    local newPlot = RegionPlot.new(plot.regionID, xx, yy)
                    table.insert(self.regionPlotList, newPlot)
                end
                if region.isTouchingNeighbor then
                    region.isGrowing = false
                end
                goto nextDirection
            end

            if self:canRegionGrowHere(xx, yy, plot.regionID) then
                roomLeft = true
                if math.random(100) < ChanceToGrow then
                    self.regionRxMap[i] = plot.regionID
                    local newPlot = RegionPlot.new(plot.regionID, xx, yy)
                    table.insert(self.regionPlotList, newPlot)
                end
            end
            ::nextDirection::
        end

        if roomLeft then
            table.insert(self.regionPlotList, plot)
        end
        table.remove(self.regionPlotList, 1)
        ::continue::
    end

    -- Process regions
    for y = 0, mapSize.MapHeight do
        for x = 0, mapSize.MapWidth do
            local i = GetRxIndex(x, y)
            local regionID = self.regionRxMap[i]

            if regionID ~= -1 then
                local region = self:getRegionByID(regionID)
                for direction = 5, 8 do
                    local xx, yy = self:plotFromRx(x, y, direction)
                    if xx == 71 and yy == 71 then
                        print(string.format("x=%d,y=%d,xx=%d,yy=%d", x, y, xx, yy))
                    end

                    local ii = GetIndex(xx, yy)
                    if ii ~= -1 then
                        self.regionMap[ii] = regionID
                        local newPlot = RegionPlot.new(regionID, xx, yy)
                        table.insert(region.plotList, newPlot)
                    end
                end
            end
        end
    end

    -- Process borders
    for _, region in ipairs(self.regionList) do
        for _, plot in ipairs(region.plotList) do
            local i = GetIndex(plot.x, plot.y)
            for direction = 1, 4 do
                local xx, yy
                if direction == 1 then
                    xx = plot.x
                    yy = plot.y + 1
                elseif direction == 2 then
                    xx = plot.x
                    yy = plot.y - 1
                elseif direction == 3 then
                    xx = plot.x + 1
                    yy = plot.y
                else
                    xx = plot.x - 1
                    yy = plot.y
                end

                local ii = GetIndex(xx, yy)
                if ii ~= -1 and self.regionMap[ii] ~= -1 and
                   self.regionMap[ii] ~= region.ID then
                    plot.bBorder = true
                    plot.bEdge = true
                    AppendUnique(region.neighborList, self.regionMap[ii])
                elseif self.regionMap[ii] == -1 then
                    plot.bEdge = true
                end
            end
        end
    end

    -- Water regions
    local numWaterRegions = math.floor(numTiles * WaterRegionsPerPlot)
    print(string.format("numTiles = %d, numWaterRegions = %d", numTiles, numWaterRegions))
    self.regionList = ShuffleList(self.regionList)

    local i = GetIndex(math.floor(mapSize.MapWidth / 2), math.floor(mapSize.MapHeight / 2))
    local regionID = self.regionMap[i]

    if regionID == -1 then
        self.regionList[1].isWater = true
    else
        local region = self:getRegionByID(regionID)
        region.isWater = true
    end

    for i = 1, numWaterRegions do
        self.regionList = ShuffleList(self.regionList)

        for _, nRegion in ipairs(self.regionList) do
            nRegion.waterNeighborCount = nRegion:getWaterNeighborCount()
        end

        table.sort(self.regionList, function(a, b)
            return a.waterNeighborCount < b.waterNeighborCount
        end)

        for _, nRegion in ipairs(self.regionList) do
            if nRegion.waterNeighborCount > 0 and not nRegion.isWater then
                nRegion.isWater = true
                break
            end
        end
    end

    for _, region in ipairs(self.regionList) do
        if not region.isWater then
            goto continue
        end

        local regionExpanding = true
        while regionExpanding do
            regionExpanding = region:expandWaterRegion()
        end
        ::continue::
    end
end

function RegionMap:canRegionGrowHere(x, y, regionID)
    local i = GetRxIndex(x, y)
    if i == -1 then
        return false
    end

    if self.regionRxMap[i] ~= -1 then
        return false
    end

    local region = self:getRegionByID(regionID)
    if not region.isGrowing then
        return false
    end

    local assume = true
    for direction = 1, 8 do
        local xx, yy = self:getXYFromDirection(x, y, direction)
        local ii = GetRxIndex(xx, yy)

        if ii == -1 or self.regionRxMap[ii] == regionID then
            -- continue
        elseif self.regionRxMap[ii] == -1 then
            -- continue
        else
            region.isTouchingNeighbor = true
            assume = false
        end
    end

    return assume
end

function RegionMap:rxTouchesMapEdge(x, y)
    if x >= (mapSize.MapWidth + 1) - EdgeLimit or x < EdgeLimit then
        return true
    end
    if y >= (mapSize.MapHeight + 1) - EdgeLimit or y < EdgeLimit then
        return true
    end
    return false
end

function RegionMap:plotFromRx(rxX, rxY, direction)
    local x, y

    if direction == self.NE then
        x = rxX
        y = rxY
    elseif direction == self.NW then
        x = rxX - 1
        y = rxY
    elseif direction == self.SE then
        x = rxX
        y = rxY - 1
    else
        x = rxX - 1
        y = rxY - 1
    end

    if x < 0 or x >= mapSize.MapWidth then
        return -1, -1
    end
    if y < 0 or y >= mapSize.MapHeight then
        return -1, -1
    end
    return x, y
end

function RegionMap:getXYFromDirection(x, y, direction)
    local xx = x
    local yy = y

    if direction == self.N then
        yy = yy + 1
    elseif direction == self.S then
        yy = yy - 1
    elseif direction == self.E then
        xx = xx + 1
    elseif direction == self.W then
        xx = xx - 1
    elseif direction == self.NW then
        yy = yy + 1
        xx = xx - 1
    elseif direction == self.NE then
        yy = yy + 1
        xx = xx + 1
    elseif direction == self.SW then
        yy = yy - 1
        xx = xx - 1
    elseif direction == self.SE then
        yy = yy - 1
        xx = xx + 1
    end

    return xx, yy
end

function RegionMap:isSeedBlocked(seedX, seedY)
    for _, region in ipairs(self.regionList) do
        if seedX > region.seedX - MinSeedRange and seedX < region.seedX + MinSeedRange then
            if seedY > region.seedY - MinSeedRange and seedY < region.seedY + MinSeedRange then
                return true
            end
        end
    end

    if seedX < MinEdgeRange or seedX >= (mapSize.MapWidth + 1) - MinEdgeRange then
        return true
    end
    if seedY < MinEdgeRange or seedY >= (mapSize.MapHeight + 1) - MinEdgeRange then
        return true
    end
    return false
end

function RegionMap:getRegionByID(ID)
    for _, region in ipairs(self.regionList) do
        if region.ID == ID then
            return region
        end
    end
    return nil
end

function RegionMap:PrintRegionMap(bShowWater)
    print("Region Map")
    for y = mapSize.MapHeight - 1, 0, -1 do
        local lineString = ""
        for x = 0, mapSize.MapWidth - 1 do
            local mapLoc = self.regionMap[GetIndex(x, y)]
            local region = self:getRegionByID(mapLoc)
            if mapLoc == -1 then
                lineString = lineString .. "X"
            elseif bShowWater and region.isWater then
                lineString = lineString .. " "
            else
                lineString = lineString .. string.char(mapLoc + 33)
            end
        end
        print(lineString)
    end
    print(" ")
end

function RegionMap:PrintRegionRxMap(bShowWater)
    print("Region Map")
    for y = mapSize.MapHeight, 0, -1 do
        local lineString = ""
        for x = 0, mapSize.MapWidth do
            local mapLoc = self.regionRxMap[GetRxIndex(x, y)]
            local region = self:getRegionByID(mapLoc)
            if mapLoc == -1 then
                lineString = lineString .. "X"
            elseif bShowWater and region.isWater then
                lineString = lineString .. " "
            else
                lineString = lineString .. string.char(mapLoc + 33)
            end
        end
        print(lineString)
    end
    print(" ")
end

function RegionMap:PrintRegionList()
    print(string.format("Number of regions = %d", #self.regionList))
    for _, region in ipairs(self.regionList) do
        print(tostring(region))
    end
end

-- Region class definition
Region = {}
Region.__index = Region

-- Constructor
function Region.new(ID, seedX, seedY)
    local self = setmetatable({}, Region)
    self.ID = ID
    self.seedX = seedX
    self.seedY = seedY
    self.isGrowing = true
    self.neighborList = {}
    self.gateRegion = -1
    self.gatePlot = nil
    self.plotList = {}
    self.isWater = false
    self.isTouchingNeighbor = false
    self.altitude = 0.0
    self.moisture = 1.0
    return self
end

-- Convert to string representation
function Region:__tostring()
    local string = string.format("ID=%d(%s), size=%d, altitude=%d\n",
        self.ID,
        string.char(self.ID + 33),
        #self.plotList,
        self.altitude)
    string = string .. string.format("gateRegion=%d(%s)\n",
        self.gateRegion,
        string.char(self.gateRegion + 33))
    string = string .. "    " .. self:NeighborListString() .. "\n"
    return string
end

function Region:NeighborListString()
    local string = "["
    for _, ID in ipairs(self.neighborList) do
        string = string .. string.char(ID + 33) .. ","
    end
    string = string .. "]"
    return string
end

function Region:getWaterNeighborCount()
    local count = 0
    for _, regionID in ipairs(self.neighborList) do
        local region = regMap:getRegionByID(regionID)
        if region.isWater == true then
            count = count + 1
        end
    end
    return count
end

function Region:getBorderPlotList(neighborID)
    local borderPlotList = {}
    local borderPlotCount = 0

    for _, plot in ipairs(self.plotList) do
        if plot.bBorder == true then
            borderPlotCount = borderPlotCount + 1
            for direction = 1, 4 do
                local xx, yy
                if direction == 1 then     -- N
                    xx = plot.x
                    yy = plot.y + 1
                elseif direction == 2 then -- S
                    xx = plot.x
                    yy = plot.y - 1
                elseif direction == 3 then -- E
                    xx = plot.x + 1
                    yy = plot.y
                else                       -- W
                    xx = plot.x - 1
                    yy = plot.y
                end

                local ii = GetIndex(xx, yy)
                if ii ~= -1 and regMap.regionMap[ii] == neighborID then
                    table.insert(borderPlotList, plot)
                    break
                end
            end
        end
    end

    print(string.format("borderPlotCount=%d", borderPlotCount))
    return borderPlotList
end

function Region:getGateListToNeighbor(neighborID)
    local gateListToNeighbor = {}
    for _, rPlot in ipairs(self.gateList) do
        if riverMap:isRxTouchingRegion(rPlot.x, rPlot.y, neighborID) then
            table.insert(gateListToNeighbor, rPlot)
        end
    end
    return gateListToNeighbor
end

function Region:defineValidGateList()
    -- This function is called in createFlowMap so the riverMap functions
    -- can be called from here. We now compile a list of all possible river gates
    self.gateList = {}
    for rxY = 0, mapSize.MapHeight do
        for rxX = 0, mapSize.MapWidth do
            if riverMap:isRxTouchingRegion(rxX, rxY, self.ID) then
                if riverMap:isValidFullGate(self.ID, rxX, rxY) then
                    local rPlot = RiverPlot.new(rxX, rxY, -1, self.ID)
                    table.insert(self.gateList, rPlot)
                end
            end
        end
    end
end

function Region:expandWaterRegion()
    local expanded = false
    for _, plot in ipairs(self.plotList) do
        for direction = 1, 4 do
            local xx, yy
            if direction == 1 then     -- N
                xx = plot.x
                yy = plot.y + 1
            elseif direction == 2 then -- S
                xx = plot.x
                yy = plot.y - 1
            elseif direction == 3 then -- E
                xx = plot.x + 1
                yy = plot.y
            else                       -- W
                xx = plot.x - 1
                yy = plot.y
            end

            local ii = GetIndex(xx, yy)
            if ii ~= -1 and regMap.regionMap[ii] == -1 then
                local naPlot = RegionPlot.new(self.ID, xx, yy)
                regMap.regionMap[ii] = self.ID
                table.insert(self.plotList, naPlot)
                expanded = true
                break
            end
        end
    end
    return expanded
end

function Region:getGatedNeighborList()
    local gatedList = {}
    for _, regionID in ipairs(self.neighborList) do
        local region = regMap:getRegionByID(regionID)
        if region.isWater or region.gateRegion ~= -1 then
            local validGateList = self:getGateListToNeighbor(regionID)
            if #validGateList > 0 then
                table.insert(gatedList, region.ID)
            end
        end
    end
    return gatedList
end

function Region:getDistanceToClosestBorderPlot(plot)
    local minDistance = 100.0
    for _, bPlot in ipairs(self.plotList) do
        if bPlot.bEdge == false then
            goto continue
        end
        local distance = GetDistance(plot.x, plot.y, bPlot.x, bPlot.y)
        if distance < minDistance then
            minDistance = distance
        end
        ::continue::
    end
    return minDistance
end

function Region:getCenter()
    local maxDistance = 0.0
    local center
    for _, plot in ipairs(self.plotList) do
        local distance = self:getDistanceToClosestBorderPlot(plot)
        if maxDistance < distance then
            maxDistance = distance
            center = plot
        end
    end
    return center
end

-- RiverMap class
RiverMap = {}
RiverMap.__index = RiverMap

function RiverMap.new()
    local self = setmetatable({}, RiverMap)
    return self
end

function RiverMap:createRiverMap()
    self:createFlowMap()
    self:calculateWetAndDry()
    self.riverMap = {}
    for i = 1, (mapSize.MapHeight + 1) * (mapSize.MapWidth + 1) do
        self.riverMap[i] = 0
    end
    for y = 0, mapSize.MapHeight do
        for x = 0, mapSize.MapWidth do
            local i = self:getRiverIndex(x, y)
            local direction = self.flowMap[i]
            local regionID = self:getRegion(x, y)
            local region = regMap:getRegionByID(regionID)
            local xx, yy = x, y
            while direction ~= -1 and direction ~= self.L do
                xx, yy = self:getXYFromDirection(xx, yy, direction)
                local ii = self:getRiverIndex(xx, yy)
                self.riverMap[ii] = self.riverMap[ii] + MinRainfall + (1.0 - MinRainfall) * region.moisture
                direction = self.flowMap[ii]
            end
        end
    end
end

function RiverMap:createFlowMap()
    self.L = 0
    self.N = 1
    self.S = 2
    self.E = 3
    self.W = 4
    self.NE = 5
    self.NW = 6
    self.SE = 7
    self.SW = 8
    self.heightMap = {}
    self.flowMap = {}
    for i = 1, (mapSize.MapHeight + 1) * (mapSize.MapWidth + 1) do
        self.flowMap[i] = -1
        self.heightMap[i] = -1.0
    end
    self:defineGates()
    print("Gates Defined !!!!!!!!!!!!!!!!!!!!!!!!")

    for _, region in ipairs(regMap.regionList) do
        if region.isWater then
            goto continue
        end

        local validGateList = region:getGateListToNeighbor(region.gateRegion)
        if #validGateList == 0 then
            print("validGateList == 0!!!!!!!!!!!!!!!!!!!!")
            print(string.format("region = %s", tostring(region)))
            local gRegion = regMap:getRegionByID(region.gateRegion)
            print(string.format("gateRegion = %s", tostring(gRegion)))
            error("region has neighbor but no valid gates. see debug file")
        end
        region.gatePlot = validGateList[math.random(1, #validGateList)]
        local rxX = region.gatePlot.x
        local rxY = region.gatePlot.y
        local rxI = self:getRiverIndex(rxX, rxY)

        local iterations = 0
        while true do
            iterations = iterations + 1
            if iterations > 100 then
                error("endless loop in gate setter")
            end
            local gateRegion = regMap:getRegionByID(region.gateRegion)
            if gateRegion.isWater then
                self.flowMap[rxI] = self.L
                self.heightMap[rxI] = 0.01
                break
            end

            local direction = math.random(1, 4)
            local xx, yy = self:getXYFromDirection(rxX, rxY, direction)
            if self:isRxInRegion(xx, yy, region.gateRegion) then
                self.flowMap[rxI] = direction
                self.heightMap[rxI] = 0.01
                break
            end
        end
        ::continue::
    end

    local plotList = {}
    regMap:PrintRegionList()
    for _, region in ipairs(regMap.regionList) do
        if region.gatePlot == nil then
            goto continue
        end
        local rxX = region.gatePlot.x
        local rxY = region.gatePlot.y

        local riverPlot = RiverPlot.new(rxX, rxY, 0, region.ID)
        table.insert(plotList, riverPlot)
        ::continue::
    end

    while #plotList > 0 do
        local count = #plotList
        ShuffleList(plotList)
        for n = 1, count do
            local thisPlot = table.remove(plotList, 1)
            local rxI = self:getRiverIndex(thisPlot.x, thisPlot.y)
            local altitude = self.heightMap[rxI]

            for direction = 1, 4 do
                local x, y = self:getXYFromDirection(thisPlot.x, thisPlot.y, direction)
                local rxII = self:getRiverIndex(x, y)

                if rxII ~= -1 and self.heightMap[rxII] == -1.0 and
                   self:isRxInRegion(x, y, thisPlot.regionID) then
                    local randomScaler = 1.0 + math.random(1, 20) / 100.0
                    self.heightMap[rxII] = altitude * randomScaler
                    local newPlot = RiverPlot.new(x, y, 0, thisPlot.regionID)
                    table.insert(plotList, newPlot)
                end
            end
        end
    end

    for y = 0, mapSize.MapHeight do
        for x = 0, mapSize.MapWidth do
            local paths = self:getPossiblePaths(x, y)
            if #paths > 0 then
                local i = self:getRiverIndex(x, y)
                local pathIndex = math.random(1, #paths)
                self.flowMap[i] = paths[pathIndex]
            end
        end
    end
end

function RiverMap:calculateWetAndDry()
    local regionList = {}
    for _, region in ipairs(regMap.regionList) do
        table.insert(regionList, region)
    end

    table.sort(regionList, function(a, b)
        return a.altitude > b.altitude
    end)

    local region = regionList[1]
    while region.altitude > 0 do
        region = regMap:getRegionByID(region.gateRegion)
        if region.altitude == 1 then
            self.wetSpot = self:plotFromRx(region.gatePlot.x, region.gatePlot.y, self.SW)
        end
    end

    local minMoisture = 1.0
    for _, region in ipairs(regMap.regionList) do
        local gate = region.gatePlot
        if gate == nil then
            goto continue
        end
        local wetSpotX, wetSpotY = self.wetSpot[1], self.wetSpot[2]
        local distance = GetDistance(gate.x, gate.y, wetSpotX, wetSpotY)
        region.moisture = 1.0 - distance / mapSize.MapWidth
        minMoisture = math.min(region.moisture, minMoisture)
        ::continue::
    end

    local scaler = 1.0 / (1.0 - minMoisture)
    for _, region in ipairs(regMap.regionList) do
        region.moisture = (region.moisture - minMoisture) * scaler
    end
end

-- Continue with rest of the methods...
function RiverMap:defineGates()
    local numRegions = #regMap.regionList
    local numGatesPlaced = 0
    local iterations = 0

    for _, region in ipairs(regMap.regionList) do
        region:defineValidGateList()

        if #region.gateList == 0 then
            print(tostring(region))
            print("has no gates!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            regMap:PrintRegionMap(false)
            error("region has no gates")
        end
    end

    while numGatesPlaced < numRegions do
        if iterations > 500 then
            error("Endless loop occurred in gate placement")
        end
        iterations = iterations + 1

        ShuffleList(regMap.regionList)
        for _, region in ipairs(regMap.regionList) do
            if region.gateRegion == -1 then
                local gatedNeighborList = region:getGatedNeighborList()
                if #gatedNeighborList > 0 then
                    ShuffleList(gatedNeighborList)
                    region.gateRegion = gatedNeighborList[1]
                    if region.isWater then
                        region.altitude = 0
                    else
                        local gateRegion = regMap:getRegionByID(region.gateRegion)
                        region.altitude = gateRegion.altitude + 1
                    end
                    numGatesPlaced = numGatesPlaced + 1
                end
            end
        end
    end
end

-- Helper methods
function RiverMap:getRiverIndex(x, y)
    if x < 0 or x >= mapSize.MapWidth + 1 then
        return -1
    end
    if y < 0 or y >= mapSize.MapHeight + 1 then
        return -1
    end

    return y * (mapSize.MapWidth + 1) + x + 1  -- +1 for Lua's 1-based indexing
end

function RiverMap:getXYFromDirection(x, y, direction)
    local xx, yy = x, y
    if direction == self.N then
        yy = yy + 1
    elseif direction == self.S then
        yy = yy - 1
    elseif direction == self.E then
        xx = xx + 1
    elseif direction == self.W then
        xx = xx - 1
    end
    return xx, yy
end

function RiverMap:isRxInRegion(x, y, regionID)
    for direction = 5, 8 do
        local xx, yy = self:plotFromRx(x, y, direction)
        local i = GetIndex(xx, yy)
        if i == -1 or regMap.regionMap[i] ~= regionID then
            return false
        end
    end
    return true
end

-- Create a new instance
-- local river = RiverMap.new()

-- PlotMap class definition
PlotMap = {}
PlotMap.__index = PlotMap

-- Constructor
function PlotMap.new()
    local self = setmetatable({}, PlotMap)
    return self
end

-- Constants
PlotMap.OCEAN = 0
PlotMap.LAND = 1
PlotMap.HILLS = 2
PlotMap.PEAK = 3
PlotMap.L = 0
PlotMap.N = 1
PlotMap.S = 2
PlotMap.E = 3
PlotMap.W = 4
PlotMap.NE = 5
PlotMap.NW = 6
PlotMap.SE = 7
PlotMap.SW = 8

function PlotMap:createPlotMap()
    self.plotMap = {}
    local scrambledPlotList = {}

    -- Sort regions by altitude (descending)
    table.sort(regMap.regionList, function(a, b) return a.altitude > b.altitude end)
    regMap.highestRegionAltitude = regMap.regionList[1].altitude

    -- Initialize plot map
    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            table.insert(self.plotMap, self.OCEAN)
            table.insert(scrambledPlotList, {x = x, y = y})
        end
    end

    -- Shuffle plot list
    ShuffleList(scrambledPlotList)

    -- Place peaks and land
    for _, plot in ipairs(scrambledPlotList) do
        local x, y = plot.x, plot.y
        local i = GetIndex(x, y)
        if self:shouldPlacePeak(x, y) then
            if self.plotMap[i] ~= self.HILLS then
                self.plotMap[i] = self.PEAK
            end
        else
            local regionID = regMap.regionMap[i]
            local region = regMap:getRegionByID(regionID)
            if region and not region.isWater then
                self.plotMap[i] = self.LAND
            end
            self:placeLandInWater(x, y)
        end
    end

    -- Process water regions
    for _, plot in ipairs(scrambledPlotList) do
        local x, y = plot.x, plot.y
        local i = GetIndex(x, y)
        local regionID = regMap.regionMap[i]
        if regionID == -1 then goto continue end

        local region = regMap:getRegionByID(regionID)
        if region.isWater and plotMap.plotMap[i] ~= plotMap.OCEAN then
            for direction = 1, 4 do
                local xx, yy = self:getXYFromDirection(x, y, direction)
                local ii = GetIndex(xx, yy)
                local nRegionID = regMap.regionMap[ii]
                if nRegionID == -1 then goto continue_inner end

                local nRegion = regMap:getRegionByID(nRegionID)
                if not nRegion.isWater then
                    regMap.regionMap[i] = nRegionID
                    break
                end
                ::continue_inner::
            end
        end
        ::continue::
    end

    -- Process terrain features
    for _, plot in ipairs(scrambledPlotList) do
        local x, y = plot.x, plot.y
        local i = GetIndex(x, y)

        if self.plotMap[i] == self.LAND then
            local altitude = GetPlotAltitude(x, y)
            local hillChanceRange = HillChanceAtOne - HillChanceAtZero
            local hillChance = HillChanceAtZero + (altitude * hillChanceRange)
            if math.random() < hillChance then
                self.plotMap[i] = self.HILLS
            end

            local peakChanceRange = PeakChanceAtOne - PeakChanceAtZero
            local peakChance = PeakChanceAtZero + (altitude * peakChanceRange)
            if math.random() < peakChance then
                self.plotMap[i] = self.PEAK
            end

            if self.plotMap[i] ~= self.LAND then
                local riverSize = GetRiverSize(x, y)
                local maxRiverSize = RiverThreshold * RiverFactorFlattensAll
                riverSize = math.min(maxRiverSize, riverSize)
                local flattenChance = riverSize / maxRiverSize

                if math.random() < flattenChance then
                    self.plotMap[i] = self.LAND
                end
            end
        end

        if self.plotMap[i] == self.PEAK then
            if self:shouldFlattenRiverPeak(x, y) then
                local riverSize = GetRiverSize(x, y)
                local maxRiverSize = RiverThreshold * RiverFactorFlattensAll
                if riverSize > maxRiverSize then
                    self.plotMap[i] = self.LAND
                else
                    self.plotMap[i] = self.HILLS
                end
            end
        end
    end

    -- Soften peaks
    for y = 1, mapSize.MapHeight - 2 do
        for x = 1, mapSize.MapWidth - 2 do
            local i = GetIndex(x, y)
            if self.plotMap[i] == self.PEAK then
                if SoftenPeakPercent >= math.random() then
                    self.plotMap[i] = self.HILLS
                end
            end
        end
    end

    -- Process impassable areas
    local areaMap = Areamap.new(mapSize.MapWidth, mapSize.MapHeight)
    areaMap:findImpassableAreas()

    for i = 1, mapSize.MapWidth * mapSize.MapHeight do
        if areaMap.areaMap[i] == 0 then
            if self.plotMap[i] ~= self.PEAK then
                self.plotMap[i] = self.PEAK
            else
                areaMap.areaMap[i] = 1
            end
        end
    end
end

function PlotMap:shouldFlattenRiverPeak(x, y)
    local function checkDirection(direction)
        local rxX, rxY = riverMap:rxFromPlot(x, y, direction)
        local rxI = riverMap:getRiverIndex(rxX, rxY)
        if riverMap.riverMap[rxI] > RiverThreshold then
            local pDir = direction
            local xx, yy = self:getXYFromDirection(x, y, pDir)
            local ii = GetIndex(xx, yy)
            if self.plotMap[ii] == self.PEAK then
                return true
            end

            -- Check flow directions
            if direction == riverMap.NW then
                if riverMap.flowMap[rxI] == riverMap.E then
                    local xx, yy = self:getXYFromDirection(x, y, self.N)
                    if self.plotMap[GetIndex(xx, yy)] == self.PEAK then
                        return true
                    end
                elseif riverMap.flowMap[rxI] == riverMap.S then
                    local xx, yy = self:getXYFromDirection(x, y, self.W)
                    if self.plotMap[GetIndex(xx, yy)] == self.PEAK then
                        return true
                    end
                end
            elseif direction == riverMap.NE then
                -- Similar checks for NE direction
                -- Add other directional checks here
            end
        end
        return false
    end

    return checkDirection(riverMap.NW) or
           checkDirection(riverMap.NE) or
           checkDirection(riverMap.SE) or
           checkDirection(riverMap.SW)
end

function PlotMap:placeLandInWater(x, y)
    local i = GetIndex(x, y)
    local regionID = regMap.regionMap[i]
    if regionID == -1 then return false end

    local region = regMap:getRegionByID(regionID)

    for direction = 1, 4 do
        local xx, yy = self:getXYFromDirection(x, y, direction)
        local ii = GetIndex(xx, yy)
        if ii == -1 then goto continue end

        if self.plotMap[ii] ~= self.OCEAN and regMap.regionMap[ii] ~= regionID then
            if IsPlotTouchingRiver(x, y) then
                local oceanNeighborTouchingRiver = false
                for dir2 = 1, 4 do
                    local xxx, yyy = self:getXYFromDirection(x, y, dir2)
                    local iii = GetIndex(xxx, yyy)
                    if self.plotMap[iii] == self.OCEAN and IsPlotTouchingRiver(xxx, yyy) then
                        oceanNeighborTouchingRiver = true
                        break
                    end
                end
                if not oceanNeighborTouchingRiver then goto continue end
            end

            local oppDirection = self:getOppositeDirection(direction)
            local xxx, yyy = self:getXYFromDirection(x, y, oppDirection)
            if not IsPlotSurroundedByOcean(xxx, yyy) then goto continue end

            if math.random(0, 1) == 0 then
                local nRegion = regMap:getRegionByID(regMap.regionMap[ii])
                if nRegion then
                    print("placing land in water")
                    if nRegion.altitude < 2 then
                        self.plotMap[i] = self.LAND
                    elseif nRegion.altitude < 3 and regMap.highestRegionAltitude >= 3 then
                        self.plotMap[i] = self.HILLS
                    else
                        self.plotMap[i] = self.PEAK
                    end
                end
            end
        end
        ::continue::
    end
    return false
end

function PlotMap:getOppositeDirection(direction)
    local opposites = {
        [self.N] = self.S,
        [self.S] = self.N,
        [self.E] = self.W,
        [self.W] = self.E,
        [self.NW] = self.SE,
        [self.SE] = self.NW,
        [self.SW] = self.NE,
        [self.NE] = self.SW,
        [self.L] = self.L
    }
    return opposites[direction] or self.L
end

function PlotMap:shouldPlacePeak(x, y)
    local i = GetIndex(x, y)
    local regionID = regMap.regionMap[i]
    if regionID == -1 then return true end

    local region = regMap:getRegionByID(regionID)
    if region.isWater then return false end

    for direction = 1, 8 do
        local xx, yy = self:getXYFromDirection(x, y, direction)
        local ii = GetIndex(xx, yy)
        if ii == -1 then return true end

        if self.plotMap[ii] ~= self.PEAK then
            local nRegionID = regMap.regionMap[ii]
            if nRegionID == -1 then goto continue end

            local nRegion = regMap:getRegionByID(nRegionID)
            if nRegion.isWater and region.altitude < 2 then
                return false
            elseif nRegion.isWater and region.altitude < 3 and regMap.highestRegionAltitude >= 3 then
                self.plotMap[i] = self.HILLS
                return true
            end
            if nRegionID ~= regionID then
                return true
            end
        end
        ::continue::
    end
    return false
end

function PlotMap:getXYFromDirection(x, y, direction)
    local directions = {
        [self.N]  = {x = 0,  y = 1},
        [self.S]  = {x = 0,  y = -1},
        [self.E]  = {x = 1,  y = 0},
        [self.W]  = {x = -1, y = 0},
        [self.NW] = {x = -1, y = 1},
        [self.NE] = {x = 1,  y = 1},
        [self.SW] = {x = -1, y = -1},
        [self.SE] = {x = 1,  y = -1}
    }

    local dir = directions[direction] or {x = 0, y = 0}
    return x + dir.x, y + dir.y
end

function PlotMap:PrintPlotMap()
    print("Plot Map")
    for y = mapSize.MapHeight - 1, 0, -1 do
        local lineString = ""
        for x = 0, mapSize.MapWidth - 1 do
            local mapLoc = self.plotMap[GetIndex(x, y)]
            local symbols = {
                [self.OCEAN] = "O",
                [self.PEAK] = "P",
                [self.HILLS] = "H",
                [self.LAND] = "L"
            }
            lineString = lineString .. (symbols[mapLoc] or " ")
        end
        print(lineString)
    end
    print(" ")
end

TerrainMap = {}
TerrainMap.__index = TerrainMap

function TerrainMap.new()
    local self = setmetatable({}, TerrainMap)
    return self
end

function TerrainMap:createTerrainMap()
    -- Direction constants
    self.L = 0
    self.N = 1
    self.S = 2
    self.E = 3
    self.W = 4
    self.NE = 5
    self.NW = 6
    self.SE = 7
    self.SW = 8

    -- Terrain type constants
    self.DESERT = 0
    self.PLAINS = 1
    self.ICE = 2
    self.TUNDRA = 3
    self.GRASS = 4
    self.HILL = 5
    self.COAST = 6
    self.OCEAN = 7
    self.PEAK = 8
    self.MARSH = 9

    -- Initialize terrain map array
    self.terrainMap = {}

    -- Fill map with OCEAN
    for i = 0, mapSize.MapHeight * mapSize.MapWidth - 1 do
        self.terrainMap[i] = self.OCEAN
    end

    -- First pass: Set basic terrain
    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            local i = GetIndex(x, y)
            if plotMap.plotMap[i] ~= plotMap.OCEAN then
                self.terrainMap[i] = self.GRASS
            else
                for direction = 1, 8 do
                    local xx, yy = self:getXYFromDirection(x, y, direction)
                    local ii = GetIndex(xx, yy)
                    if ii ~= -1 and plotMap.plotMap[ii] ~= plotMap.OCEAN then
                        self.terrainMap[i] = self.COAST
                    end
                end
            end
        end
    end

    -- Second pass: Apply climate and altitude effects
    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            local i = GetIndex(x, y)
            if plotMap.plotMap[i] ~= plotMap.OCEAN then
                local rainFall = GetRainfall(x, y)
                if rainFall < DesertThreshold then
                    if rainFall < ((math.random(100) * DesertThreshold) / 2.0) + (DesertThreshold / 2.0) then
                        self.terrainMap[i] = self.DESERT
                    else
                        self.terrainMap[i] = self.PLAINS
                    end
                elseif rainFall < PlainsThreshold then
                    if rainFall < ((math.random(100) * (PlainsThreshold - DesertThreshold)) / 2.0) +
                        DesertThreshold + ((PlainsThreshold - DesertThreshold) / 2.0) then
                        self.terrainMap[i] = self.PLAINS
                    else
                        self.terrainMap[i] = self.GRASS
                    end
                else
                    self.terrainMap[i] = self.GRASS
                end

                local altitude = GetPlotAltitude(x, y)
                if altitude > IceThreshold then
                    self.terrainMap[i] = self.ICE
                elseif altitude > TundraThreshold then
                    self.terrainMap[i] = self.TUNDRA
                elseif altitude > MaxDesertAltitude and self.terrainMap[i] == self.DESERT then
                    self.terrainMap[i] = self.PLAINS
                end
            end
        end
    end

    -- Third pass: Handle peaks
    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            local i = GetIndex(x, y)
            if plotMap.plotMap[i] == plotMap.PEAK then
                self.terrainMap[i] = self.TUNDRA
                for direction = 1, 8 do
                    local xx, yy = self:getXYFromDirection(x, y, direction)
                    local ii = GetIndex(xx, yy)
                    if plotMap.plotMap[ii] ~= plotMap.PEAK and
                       plotMap.plotMap[ii] ~= plotMap.OCEAN then
                        self.terrainMap[i] = self.terrainMap[ii]
                        break
                    end
                end
            end
        end
    end
end

function TerrainMap:getXYFromDirection(x, y, direction)
    local xx = x
    local yy = y

    if direction == self.N then
        yy = yy + 1
    elseif direction == self.S then
        yy = yy - 1
    elseif direction == self.E then
        xx = xx + 1
    elseif direction == self.W then
        xx = xx - 1
    elseif direction == self.NW then
        yy = yy + 1
        xx = xx - 1
    elseif direction == self.NE then
        yy = yy + 1
        xx = xx + 1
    elseif direction == self.SW then
        yy = yy - 1
        xx = xx - 1
    elseif direction == self.SE then
        yy = yy - 1
        xx = xx + 1
    end

    return xx, yy
end

-- LineSegment class definition (needed by Areamap)
LineSegment = {}
LineSegment.__index = LineSegment

function LineSegment.new(y, xLeft, xRight, dy)
    local self = setmetatable({}, LineSegment)
    self.y = y
    self.xLeft = xLeft
    self.xRight = xRight
    self.dy = dy
    return self
end

function LineSegment:__tostring()
    return string.format("y = %d, xLeft = %d, xRight = %d, dy = %d",
        self.y, self.xLeft, self.xRight, self.dy)
end

-- Helper function (equivalent to GetIndex in the original)
local function GetIndex(x, y, mapWidth)
    return y * mapWidth + x
end

-- Areamap class definition
Areamap = {}
Areamap.__index = Areamap

function Areamap.new(width, height)
    local self = setmetatable({}, Areamap)
    self.mapWidth = width
    self.mapHeight = height
    self.areaMap = {}

    -- Initialize areaMap with zeros
    for i = 0, self.mapHeight * self.mapWidth - 1 do
        self.areaMap[i] = 0
    end

    return self
end

function Areamap:findImpassableAreas()
    -- Reset areaMap
    for i = 0, self.mapHeight * self.mapWidth - 1 do
        self.areaMap[i] = 0
    end

    -- Find ocean areas
    for i = 0, self.mapHeight * self.mapWidth - 1 do
        if plotMap.plotMap[i] == plotMap.OCEAN then
            self:fillArea(i, 1)
        end
    end
end

function Areamap:findChokePointAreas()
    -- Assuming gameMap and CyGlobalContext are available in the Lua environment
    local gameMap = CyMap()

    -- Initialize areas
    for i = 0, self.mapHeight * self.mapWidth - 1 do
        local gamePlot = gameMap:plotByIndex(i)
        if gamePlot:isWater() then
            self.areaMap[i] = -1
        elseif gamePlot:isImpassable() then
            self.areaMap[i] = -3
        end
    end

    self.areaList = {-1}  -- Initialize with -1
    local areaID = 0

    for i = 0, self.mapHeight * self.mapWidth - 1 do
        if self.areaMap[i] == 0 then
            areaID = areaID + 1
            local areaSize = self:fillArea(i, areaID)
            table.insert(self.areaList, areaSize)
        end
    end
end

function Areamap:fillArea(index, areaID)
    local y = math.floor(index / self.mapWidth)
    local x = index % self.mapWidth

    self.segStack = {}
    self.size = 0

    -- Push initial segments
    table.insert(self.segStack, LineSegment.new(y, x, x, 1))
    table.insert(self.segStack, LineSegment.new(y + 1, x, x, -1))

    while #self.segStack > 0 do
        local seg = table.remove(self.segStack)  -- pop
        self:scanAndFillLine(seg, areaID)
    end

    return self.size
end

function Areamap:scanAndFillLine(seg, areaID)
    local i = GetIndex(seg.xLeft, seg.y + seg.dy, self.mapWidth)
    if i < 0 then return end

    local debugReport = false
    local landOffset = 1
    local lineFound = false

    -- Scan left
    local xLeftExtreme = seg.xLeft - landOffset
    while xLeftExtreme >= 0 do
        i = GetIndex(xLeftExtreme, seg.y + seg.dy, self.mapWidth)
        if self.areaMap[i] == 0 and plotMap.plotMap[i] ~= plotMap.PEAK then
            self.areaMap[i] = areaID
            self.size = self.size + 1
            lineFound = true
        else
            if lineFound then
                xLeftExtreme = xLeftExtreme + 1
            end
            break
        end
        xLeftExtreme = xLeftExtreme - 1
    end

    -- Scan right
    local xRightExtreme = seg.xLeft
    while xRightExtreme < self.mapWidth do
        i = GetIndex(xRightExtreme, seg.y + seg.dy, self.mapWidth)
        if self.areaMap[i] == 0 and plotMap.plotMap[i] ~= plotMap.PEAK then
            self.areaMap[i] = areaID
            self.size = self.size + 1
            if not lineFound then
                lineFound = true
                xLeftExtreme = xRightExtreme
            end
        elseif lineFound then
            lineFound = false

            -- Add new segments to stack
            local newSeg = LineSegment.new(seg.y + seg.dy, xLeftExtreme, xRightExtreme - 1, seg.dy)
            table.insert(self.segStack, newSeg)

            if xLeftExtreme < seg.xLeft or xRightExtreme >= seg.xRight then
                newSeg = LineSegment.new(seg.y + seg.dy, xLeftExtreme, xRightExtreme - 1, -seg.dy)
                table.insert(self.segStack, newSeg)
            end

            if xRightExtreme >= seg.xRight + landOffset then
                break
            end
        elseif not lineFound and xRightExtreme >= seg.xRight + landOffset then
            break
        end
        xRightExtreme = xRightExtreme + 1
    end

    -- Handle remaining line if needed
    if lineFound then
        local newSeg = LineSegment.new(seg.y + seg.dy, xLeftExtreme, xRightExtreme - 1, seg.dy)
        table.insert(self.segStack, newSeg)

        if xLeftExtreme < seg.xLeft or xRightExtreme - 1 > seg.xRight then
            newSeg = LineSegment.new(seg.y + seg.dy, xLeftExtreme, xRightExtreme - 1, -seg.dy)
            table.insert(self.segStack, newSeg)
        end
    end
end

function Areamap:PrintAreaMap()
    print("Area Map")
    for y = self.mapHeight - 1, 0, -1 do
        local lineString = ""
        for x = 0, self.mapWidth - 1 do
            local mapLoc = self.areaMap[GetIndex(x, y, self.mapWidth)]
            if mapLoc > 0 then
                if mapLoc + 34 > 127 then
                    mapLoc = 127 - 34
                end
                lineString = lineString .. string.char(mapLoc + 34)
            elseif mapLoc == 0 then
                lineString = lineString .. "!"
            elseif mapLoc == -1 then
                lineString = lineString .. "."
            elseif mapLoc == -2 then
                lineString = lineString .. "X"
            elseif mapLoc == -3 then
                lineString = lineString .. "^"
            end
        end
        lineString = lineString .. "-" .. y
        print(lineString)
    end
    print(" ")
end

-- Usage example:
-- local areamap = Areamap.new(width, height)

-- skip LineSegment Class

-- skip StartRegion Class

StartingPlotFinder = {}
StartingPlotFinder.__index = StartingPlotFinder

function StartingPlotFinder.new()
    local self = setmetatable({}, StartingPlotFinder)
    return self
end

function StartingPlotFinder:initialize()
    self.availableRegionList = {}
    self.occupiedRegionList = {}
end

function StartingPlotFinder:assignStartingPlots()
    local gc = CyGlobalContext()
    local gameMap = CyMap()

    local playerList = {}
    for plrCheckLoop = 0, gc:getMAX_CIV_PLAYERS() - 1 do
        if CyGlobalContext():getPlayer(plrCheckLoop):isEverAlive() then
            table.insert(playerList, plrCheckLoop)
        end
    end
    ShuffleList(playerList)

    for _, region in ipairs(regMap.regionList) do
        if not region.isWater then
            local startRegion = StartRegion.new(region)
            table.insert(self.availableRegionList, startRegion)
        end
    end

    local civPreferenceList = GetCivPreferences()

    for _, playerIndex in ipairs(playerList) do
        local player = gc:getPlayer(playerIndex)
        player:AI_updateFoundValues(true)
        local civType = player:getCivilizationType()
        local civInfo = gc:getCivilizationInfo(civType)
        print(string.format("Civ = %s", civInfo:getType()))

        local civPref = self:getCivPreference(civPreferenceList, civType)
        local bestRegion = self:getBestStartRegion(self.availableRegionList, self.occupiedRegionList, civPref)
        local startPlot = self:getStartPlotInRegion(bestRegion.region, player, civPref)

        DeleteFromList(self.availableRegionList, bestRegion)
        table.insert(self.occupiedRegionList, bestRegion)
        player:setStartingPlot(startPlot, true)
    end
end

function StartingPlotFinder:getStartPlotInRegion(region, player, civPref)
    local gc = CyGlobalContext()
    local gameMap = CyMap()
    local bestValue = 0
    local bestPlot = nil

    for _, plot in ipairs(region.plotList) do
        local startPlot = gameMap:plot(plot.x, plot.y)
        if not (civPref.needCoastalStart and not isCoast(startPlot)) then
            if not startPlot:isPeak() then
                local value = startPlot:getFoundValue(player:getID())
                if value > bestValue then
                    bestValue = value
                    bestPlot = startPlot
                end
            end
        end
    end

    if bestPlot == nil then
        error("best plot in region is null")
    end
    return bestPlot
end

function StartingPlotFinder:getBestStartRegion(availableRegionList, occupiedRegionList, civPref)
    local bestRegionList = {}

    for _, startRegion in ipairs(availableRegionList) do
        if civPref.needCoastalStart then
            local gateRegion = regMap:getRegionByID(startRegion.region.gateRegion)
            if not gateRegion.isWater then
                goto continue
            end
        end

        if #startRegion.region.plotList >= MinRegionSizeStart then
            table.insert(bestRegionList, startRegion)
        end
        ::continue::
    end

    for _, startRegion in ipairs(bestRegionList) do
        local normalizedAlt = startRegion.region.altitude / regMap.highestRegionAltitude
        local altitudeDiff = math.abs(normalizedAlt - civPref.idealAltitude)
        local moistureDiff = math.abs(startRegion.region.moisture - civPref.idealMoisture)

        local maxDistance = GetDistance(0, 0, mapSize.MapWidth - 1, mapSize.MapHeight - 1)
        local distanceToNearest = self:getDistToNearestOccRegion(occupiedRegionList, startRegion)
        local distanceFactor = 1.0 - (distanceToNearest / maxDistance)

        local weightedAverageDiff = ((civPref.altitudeWeight * altitudeDiff) +
            (distanceFactor * civPref.distanceWeight) + moistureDiff) /
            (civPref.altitudeWeight + civPref.distanceWeight + 1)

        startRegion.differenceFromIdeal = weightedAverageDiff
    end

    table.sort(bestRegionList, function(a, b)
        return a.differenceFromIdeal < b.differenceFromIdeal
    end)

    local startRegion = bestRegionList[1]
    print(string.format("chosen regionID = %d", startRegion.region.ID))
    return startRegion
end

function StartingPlotFinder:getDistToNearestOccRegion(occupiedRegionList, startRegion)
    local minDistance = GetDistance(0, 0, mapSize.MapWidth - 1, mapSize.MapHeight - 1)

    for _, occRegion in ipairs(occupiedRegionList) do
        local startGatePlot = startRegion.region.gatePlot
        if startGatePlot ~= nil then
            local occGatePlot = occRegion.region.gatePlot
            local distance = GetDistance(startGatePlot.x, startGatePlot.y, occGatePlot.x, occGatePlot.y)
            minDistance = math.min(distance, minDistance)
        end
    end

    return minDistance
end

function StartingPlotFinder:getCivPreference(civPreferenceList, civType)
    for _, civPref in ipairs(civPreferenceList) do
        if civPref.civ == civType then
            return civPref
        end
    end

    return CivPreference.new(civType)
end

-- JOIN
-- Replace unique improvements
function StartingPlotFinder:replaceUniqueImprovements()
    local gc = CyGlobalContext()
    local gameMap = CyMap()
    local impPrefList = GetImprovementPreferences()
    local availableRegionList = {}
    local occupiedRegionList = {}

    for _, region in ipairs(regMap.regionList) do
        local startRegion = StartRegion(region)
        table.insert(availableRegionList, startRegion)
    end

    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            local plot = gameMap:plot(x, y)
            local impType = plot:getImprovementType()
            local impInfo = gc:getImprovementInfo(impType)

            if impInfo ~= nil then
                print(string.format("Found %s", impInfo:getType()))
                local impPref = nil

                for _, foundImpPref in ipairs(impPrefList) do
                    if foundImpPref.improvement == impType then
                        impPref = foundImpPref
                        break
                    end
                end

                if impPref ~= nil then
                    impInfo = gc:getImprovementInfo(impType)
                    print(string.format("Removing %s at %d, %d", impInfo:getType(), x, y))
                    plot:setImprovementType(GetInfoType("NO_IMPROVEMENT"))
                    plot:setBonusType(GetInfoType("NO_BONUS"))

                    local bestRegion = self:getBestImprovementRegion(availableRegionList, occupiedRegionList, impPref)
                    DeleteFromList(availableRegionList, bestRegion)
                    table.insert(occupiedRegionList, bestRegion)

                    local bestPlot = self:getBestImpPlotInRegion(bestRegion.region, impPref)
                    DeleteFromList(impPrefList, impPref)
                    print(string.format("Adding %s at %d, %d", impInfo:getType(), bestPlot:getX(), bestPlot:getY()))
                    bestPlot:setImprovementType(impType)
                end
            end
        end
    end
end

-- Get best improvement region
function StartingPlotFinder:getBestImprovementRegion(availableRegionList, occupiedRegionList, impPref)
    local bestRegionList = {}

    for _, startRegion in ipairs(availableRegionList) do
        if impPref.needCoast then
            local gateRegion = regMap:getRegionByID(startRegion.region.gateRegion)
            if not gateRegion.isWater then
                goto continue
            end
        end

        if impPref.needWater and not startRegion.region.isWater then
            goto continue
        end

        if startRegion.region.isWater then
            goto continue
        end

        if #startRegion.region.plotList < MinRegionSizeTower then
            goto continue
        end

        if impPref.needChoke and self:findChokePoint(startRegion.region) == nil then
            goto continue
        end

        table.insert(bestRegionList, startRegion)

        ::continue::
    end

    for _, startRegion in ipairs(bestRegionList) do
        local normalizedAlt = startRegion.region.altitude / regMap.highestRegionAltitude
        local altitudeDiff = math.abs(normalizedAlt - impPref.idealAltitude)
        local moistureDiff = math.abs(startRegion.region.moisture - impPref.idealMoisture)

        local maxDistance = GetDistance(0, 0, mapSize.MapWidth - 1, mapSize.MapHeight - 1)
        local distanceToNearest = self:getDistToNearestOccRegion(occupiedRegionList, startRegion)
        local distanceFactor = 1.0 - (distanceToNearest / maxDistance)

        local weightedAverageDiff = ((impPref.altitudeWeight * altitudeDiff) + distanceFactor +
            (moistureDiff * impPref.moistureWeight)) / (impPref.altitudeWeight + impPref.moistureWeight + 1)

        print(string.format("regionID = %d, altitudeDiff = %f, moistureDiff = %f, altitudeWeight = %f, weightedAverageDiff = %f",
            startRegion.region.ID, altitudeDiff, moistureDiff, impPref.altitudeWeight, weightedAverageDiff))

        startRegion.differenceFromIdeal = weightedAverageDiff
    end

    table.sort(bestRegionList, function(a, b)
        return a.differenceFromIdeal < b.differenceFromIdeal
    end)

    local startRegion = bestRegionList[1]
    print(string.format("chosen regionID = %d", startRegion.region.ID))
    return startRegion
end

-- Get best improvement plot in region
function StartingPlotFinder:getBestImpPlotInRegion(region, impPref)
    local gc = CyGlobalContext()
    local gameMap = CyMap()
    local midPoint = region:getCenter()

    local minDistance = 100.0
    local bestPlot = gameMap:plot(midPoint.x, midPoint.y)
    region.plotList = ShuffleList(region.plotList)

    for _, plot in ipairs(region.plotList) do
        local i = GetIndex(plot.x, plot.y)
        local gamePlot = gameMap:plot(plot.x, plot.y)
        print(string.format("gamePlot = %d,%d", plot.x, plot.y))

        if gamePlot:getBonusType(TeamTypes.NO_TEAM) ~= GetInfoType("NO_BONUS") then
            goto continue
        end

        if gamePlot:isPeak() and not impPref.needChoke then
            print("rejected for peak")
            goto continue
        end

        if impPref.needHill and plotMap.plotMap[i] ~= plotMap.HILLS then
            print("rejected for not hill")
            goto continue
        end

        if impPref.needFlat and plotMap.plotMap[i] ~= plotMap.LAND then
            print("rejected for not flat")
            goto continue
        end

        if impPref.needCoast and not isCoast(gamePlot) then
            goto continue
        end

        if impPref.favoredTerrain ~= TerrainTypes.NO_TERRAIN
            and gamePlot:getTerrainType() ~= impPref.favoredTerrain then
            print("rejected for not favored terrain")
            goto continue
        end

        if impPref.needChoke then
            local chokePlot = self:findChokePoint(region)
            if plot.x >= chokePlot:getX() - 1 and plot.x <= chokePlot:getX() + 1
                and plot.y >= chokePlot:getY() - 1 and plot.y <= chokePlot:getY() + 1
                and gamePlot:isPeak() then
                print("Found choke")

                local reagents = GetInfoType("BONUS_REAGENTS")
                if reagents ~= -1 then
                    for direction = 1, 8 do
                        local xx, yy = plotMap:getXYFromDirection(plot.x, plot.y, direction)
                        local baitPlot = gameMap:plot(xx, yy)
                        local forest = GetInfoType("FEATURE_FOREST")
                        if forest ~= -1 and baitPlot:getFeatureType() == forest then
                            baitPlot:setFeatureType(FeatureTypes.NO_FEATURE, 0)
                        end
                        if baitPlot:canHaveBonus(reagents, true) then
                            baitPlot:setBonusType(reagents)
                            break
                        end
                    end
                end
            else
                print(string.format("rejected not next to choke=%d,%d or not peak",
                    chokePlot:getX(), chokePlot:getY()))
                goto continue
            end
        end

        bestPlot = gameMap:plot(plot.x, plot.y)
        break

        ::continue::
    end

    return bestPlot
end

-- JOIN again

function StartingPlotFinder:collectAllWatchtowers()
    local gc = CyGlobalContext()
    local gameMap = CyMap()
    local count = 0

    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            local plot = gameMap:plot(x, y)
            local impType = plot:getImprovementType()
            if impType == GetInfoType("IMPROVEMENT_TOWER") then
                count = count + 1
                plot:setImprovementType(GetInfoType("NO_IMPROVEMENT"))
            end
        end
    end

    print(string.format("razed %d watchtowers", count))
    return count
end

function StartingPlotFinder:replaceWatchtowers(count)
    local gc = CyGlobalContext()
    local gameMap = CyMap()
    local towersPlacedAtChoke = 0
    local towersPlacedInMiddle = 0

    self:createChokePointList()
    for _, region in ipairs(regMap.regionList) do
        if not region.isWater then
            if #region.plotList >= MinRegionSizeTower then
                if math.random(3, 0) ~= 0 then
                    if math.random(1, 0) == 0 then
                        local chokePoint = self:findChokePoint(region)
                        local badNeighbor = false

                        if chokePoint then
                            for direction = 1, 8 do
                                local x, y = plotMap.getXYFromDirection(chokePoint:getX(), chokePoint:getY(), direction)
                                local nPlot = gameMap:plot(x, y)
                                if nPlot:getImprovementType() ~= ImprovementTypes.NO_IMPROVEMENT then
                                    badNeighbor = true
                                    break
                                end
                            end

                            if not badNeighbor then
                                chokePoint:setImprovementType(GetInfoType("IMPROVEMENT_TOWER"))
                                towersPlacedAtChoke = towersPlacedAtChoke + 1
                                goto continue
                            end
                        end
                    end

                    local midPoint = region:getCenter()
                    local minDistance = 100.0
                    local bestPlot = nil

                    for _, plot in ipairs(region.plotList) do
                        local i = GetIndex(plot.x, plot.y)
                        local gamePlot = gameMap:plot(plot.x, plot.y)
                        if gamePlot:getBonusType(TeamTypes.NO_TEAM) == GetInfoType("NO_BONUS") then
                            if plotMap.plotMap[i] == plotMap.HILLS then
                                local distance = GetDistance(plot.x, plot.y, midPoint.x, midPoint.y)
                                if minDistance > distance then
                                    bestPlot = plot
                                    minDistance = distance
                                end
                            end
                        end
                    end

                    if bestPlot then
                        local midHill = gameMap:plot(bestPlot.x, bestPlot.y)
                        midHill:setImprovementType(GetInfoType("IMPROVEMENT_TOWER"))
                        towersPlacedInMiddle = towersPlacedInMiddle + 1
                    end
                end
            end
        end
        ::continue::
    end

    print(string.format("towersPlacedAtChoke= %d, towersPlacedInMiddle= %d, total= %d",
        towersPlacedAtChoke, towersPlacedInMiddle, towersPlacedAtChoke + towersPlacedInMiddle))
end

-- join again 2

function StartingPlotFinder:createChokePointList()
    local gc = CyGlobalContext()
    local gameMap = CyMap()

    local areaMap = Areamap.new(mapSize.MapWidth, mapSize.MapHeight)
    local possibleChokeList = {}
    local likelyChokeList = {}
    self.chokePointList = {}
    local chokeAreaList = {}

    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            local i = GetIndex(x, y)
            if self:isPossibleChokePoint(x, y) then
                areaMap.areaMap[i] = -2
                table.insert(possibleChokeList, ChokePoint.new(x, y))
            end
        end
    end

    areaMap:findChokePointAreas()

    for i = 1, #areaMap.areaList do
        table.insert(chokeAreaList, ChokeArea.new(i, areaMap.areaList[i]))
    end

    for _, possibleChoke in ipairs(possibleChokeList) do
        self:findChokeNeighbors(possibleChoke, areaMap, chokeAreaList, possibleChokeList)
    end

    for _, possibleChoke in ipairs(possibleChokeList) do
        for _, area in ipairs(possibleChoke.neighborAreaList) do
            if area.size > ChokePointAreaSize then
                local chokesCheckedList = {}

                if self:canFindAdditionalAreaThroughChokes(possibleChoke, area, chokesCheckedList, true) then
                    table.insert(likelyChokeList, possibleChoke)
                end
                break
            end
        end
    end

    for _, chokePoint in ipairs(likelyChokeList) do
        if self:isConfirmedChokePoint(chokePoint) then
            print(string.format("Confirmed chokepoint at %s", tostring(chokePoint)))
            table.insert(self.chokePointList, chokePoint)
        else
            print(string.format("Rejected chokepoint at %d, %d", chokePoint.x, chokePoint.y))
        end
    end
end

function StartingPlotFinder:isConfirmedChokePoint(choke)
    local gc = CyGlobalContext()
    local gameMap = CyMap()
    local gamePlot = gameMap:plot(choke.x, choke.y)

    local oldPlotType = gamePlot:getPlotType()
    gamePlot:setPlotType(PlotTypes.PLOT_PEAK, true, true)

    for _, inGate in ipairs(choke.gateList) do
        for _, outGate in ipairs(choke.gateList) do
            if not (outGate[1] == inGate[1] and outGate[2] == inGate[2]) then
                gameMap:resetPathDistance()
                local inPlot = gameMap:plot(inGate[1], inGate[2])
                local outPlot = gameMap:plot(outGate[1], outGate[2])
                local distance = gameMap:calculatePathDistance(inPlot, outPlot)

                if distance >= ChokePointWalkAroundDistance or distance == -1 then
                    gamePlot:setPlotType(oldPlotType, true, true)
                    return true
                end
            end
        end
    end

    gamePlot:setPlotType(oldPlotType, true, true)
    return false
end

function StartingPlotFinder:canFindAdditionalAreaThroughChokes(possibleChoke, origionalArea, chokesCheckedList, bTopLayer)
    local twoAreasFound = false
    local returnValue = false

    for _, area in ipairs(possibleChoke.neighborAreaList) do
        if not bTopLayer and area == origionalArea then
            return false
        elseif area ~= origionalArea and area.size > ChokePointAreaSize then
            twoAreasFound = true
        end
    end

    if twoAreasFound then
        returnValue = true
    end

    table.insert(chokesCheckedList, possibleChoke)

    local largeAreaFound = false

    for _, neighborChoke in ipairs(possibleChoke.neighborChokeList) do
        local alreadyChecked = false
        for _, checkedChoke in ipairs(chokesCheckedList) do
            if checkedChoke == neighborChoke then
                alreadyChecked = true
                break
            end
        end

        if not alreadyChecked then
            largeAreaFound = self:canFindAdditionalAreaThroughChokes(neighborChoke, origionalArea, chokesCheckedList, false)
            if largeAreaFound then
                if bTopLayer then
                    table.insert(possibleChoke.gateList, {neighborChoke.x, neighborChoke.y})
                end
                returnValue = true
            end
        end
    end

    for _, neighborArea in ipairs(possibleChoke.neighborAreaList) do
        if area ~= origionalArea then
            for _, neighborChoke in ipairs(neighborArea.neighborChokeList) do
                local alreadyChecked = false
                for _, checkedChoke in ipairs(chokesCheckedList) do
                    if checkedChoke == neighborChoke then
                        alreadyChecked = true
                        break
                    end
                end

                if not alreadyChecked then
                    largeAreaFound = self:canFindAdditionalAreaThroughChokes(neighborChoke, origionalArea, chokesCheckedList, false)
                    if largeAreaFound then
                        if bTopLayer then
                            table.insert(possibleChoke.gateList, {neighborChoke.x, neighborChoke.y})
                        end
                        returnValue = true
                    end
                end
            end
        end
    end

    return returnValue
end

function StartingPlotFinder:findChokeNeighbors(possibleChoke, areaMap, chokeAreaList, possibleChokeList)
    for direction = 1, 8 do
        local xx, yy = plotMap.getXYFromDirection(possibleChoke.x, possibleChoke.y, direction)
        local i = GetIndex(xx, yy)
        if i == -1 then
            goto continue
        end

        if areaMap.areaMap[i] == -2 then
            for _, neighborChoke in ipairs(possibleChokeList) do
                if neighborChoke.x == xx and neighborChoke.y == yy then
                    table.insert(possibleChoke.neighborChokeList, neighborChoke)
                end
            end
        elseif areaMap.areaMap[i] > 0 then
            local alreadyInList = false
            for _, area in ipairs(possibleChoke.neighborAreaList) do
                if area.ID == areaMap.areaMap[i] then
                    alreadyInList = true
                    break
                end
            end

            if not alreadyInList then
                for _, area in ipairs(chokeAreaList) do
                    if area.ID == areaMap.areaMap[i] then
                        table.insert(possibleChoke.neighborAreaList, area)
                        table.insert(area.neighborChokeList, possibleChoke)
                        if area.size > ChokePointAreaSize then
                            table.insert(possibleChoke.gateList, {xx, yy})
                        end
                    end
                end
            end
        end
        ::continue::
    end
end

function StartingPlotFinder:isPossibleChokePoint(x, y)
    local gc = CyGlobalContext()
    local gameMap = CyMap()
    local gamePlot = gameMap:plot(x, y)

    local i = GetIndex(x, y)
    if gamePlot:isWater() or gamePlot:isImpassable() then
        return false
    end
    if gamePlot:getBonusType(TeamTypes.NO_TEAM) ~= GetInfoType("NO_BONUS") then
        return false
    end

    local direction = plotMap.W
    local xx, yy = plotMap.getXYFromDirection(x, y, direction)
    local passable = self:isPassableLand(xx, yy)
    local oppDir = plotMap.getOppositeDirection(direction)
    local xxx, yyy = plotMap.getXYFromDirection(x, y, oppDir)

    if passable == self:isPassableLand(xxx, yyy) then
        direction = plotMap.N
        xx, yy = plotMap.getXYFromDirection(x, y, direction)
        oppDir = plotMap.getOppositeDirection(direction)
        xxx, yyy = plotMap.getXYFromDirection(x, y, oppDir)
        if passable ~= self:isPassableLand(xx, yy) and passable ~= self:isPassableLand(xxx, yyy) then
            return true
        end
    end

    -- Check diagonal directions
    local directions = {
        {dir = plotMap.NW, check1 = plotMap.N, check2 = plotMap.W},
        {dir = plotMap.NE, check1 = plotMap.N, check2 = plotMap.E},
        {dir = plotMap.SW, check1 = plotMap.S, check2 = plotMap.W},
        {dir = plotMap.SE, check1 = plotMap.S, check2 = plotMap.E}
    }

    for _, dirSet in ipairs(directions) do
        xx, yy = plotMap.getXYFromDirection(x, y, dirSet.dir)
        if self:isPassableLand(xx, yy) then
            local check1X, check1Y = plotMap.getXYFromDirection(x, y, dirSet.check1)
            local check2X, check2Y = plotMap.getXYFromDirection(x, y, dirSet.check2)
            if not self:isPassableLand(check1X, check1Y) and not self:isPassableLand(check2X, check2Y) then
                return true
            end
        end
    end

    return false
end

function StartingPlotFinder:isPassableLand(x, y)
    local gc = CyGlobalContext()
    local gameMap = CyMap()
    local gamePlot = gameMap:plot(x, y)

    local i = GetIndex(x, y)
    if i == -1 then
        return false
    end
    if gamePlot:isWater() or gamePlot:isImpassable() then
        return false
    end
    return true
end

function StartingPlotFinder:findChokePoint(region)
    local gc = CyGlobalContext()
    local gameMap = CyMap()

    for _, choke in ipairs(self.chokePointList) do
        for _, plot in ipairs(region.plotList) do
            if plot.x == choke.x and plot.y == choke.y then
                return gameMap:plot(plot.x, plot.y)
            end
        end
    end

    return nil
end

-- ChokePoint class implementation
ChokePoint = {}
ChokePoint.__index = ChokePoint

function ChokePoint.new(x, y)
    local self = setmetatable({}, ChokePoint)
    self.x = x
    self.y = y
    self.neighborChokeList = {}
    self.neighborAreaList = {}
    self.gateList = {}
    return self
end

function ChokePoint:__tostring()
    local rstring = string.format("%d,%d\n", self.x, self.y)
    rstring = rstring .. " neighborChokeList = \n"
    for _, nChoke in ipairs(self.neighborChokeList) do
        rstring = rstring .. string.format("   %d,%d\n", nChoke.x, nChoke.y)
    end
    rstring = rstring .. " neighborAreaList = \n"
    for _, nArea in ipairs(self.neighborAreaList) do
        rstring = rstring .. string.format("   ID=%d, char=%s, size=%d\n",
            nArea.ID, string.char(nArea.ID + 34), nArea.size)
    end
    rstring = rstring .. " gateList = \n"
    for _, gate in ipairs(self.gateList) do
        rstring = rstring .. string.format("   %d,%d\n", gate[1], gate[2])
    end
    return rstring
end

-- ChokeArea class implementation
ChokeArea = {}
ChokeArea.__index = ChokeArea

function ChokeArea.new(ID, size)
    local self = setmetatable({}, ChokeArea)
    self.ID = ID
    self.size = size
    self.neighborChokeList = {}
    return self
end

function ChokeArea:__tostring()
    local rstring = string.format("ID=%d, char=%s, size=%d\n",
        self.ID, string.char(self.ID + 34), self.size)
    rstring = rstring .. " neighborChokeList = \n"
    for _, nChoke in ipairs(self.neighborChokeList) do
        rstring = rstring .. string.format("   %d,%d\n", nChoke.x, nChoke.y)
    end
    return rstring
end

-- isCoast function implementation
function isCoast(plot)
    local WaterArea = plot:waterArea()
    if WaterArea and not WaterArea:isNone() then
        if not WaterArea:isLake() then
            return true
        end
    end
    return false
end

function AppendUnique(theList, newItem)
    if not IsInList(theList, newItem) then
        table.insert(theList, newItem)
    end
end

function IsInList(theList, newItem)
    local itemFound = false
    for _, item in ipairs(theList) do
        if item == newItem then
            itemFound = true
            break
        end
    end
    return itemFound
end

function DeleteFromList(theList, oldItem)
    for i = 1, #theList do
        if theList[i] == oldItem then
            table.remove(theList, i)
            break
        end
    end
end

function ShuffleList(theList)
    local preshuffle = {}
    local shuffled = {}
    local numElements = #theList

    for i = 1, numElements do
        preshuffle[i] = theList[i]
    end

    for i = 1, numElements do
        local n = math.random(1, #preshuffle)
        table.insert(shuffled, preshuffle[n])
        table.remove(preshuffle, n)
    end
    return shuffled
end

function GetInfoType(string)
    local cgc = CyGlobalContext()
    return cgc:getInfoTypeForString(string)
end

function GetPlotAltitude(x, y)
    if regMap.highestRegionAltitude == 0 then
        table.sort(regMap.regionList, function(a, b) return a.altitude > b.altitude end)
        regMap.highestRegionAltitude = regMap.regionList[1].altitude
    end

    local i = GetIndex(x, y)
    local regionID = regMap.regionMap[i]
    if regionID == -1 then
        return -1.0
    end
    local region = regMap:getRegionByID(regionID)

    local regionAlt = (region.altitude + 1) / (regMap.highestRegionAltitude + 1)

    local riverAltRange = RiverAltRangeFactor * RiverThreshold
    local riverSize = GetRiverSize(x, y)
    if riverSize > riverAltRange then
        riverSize = riverAltRange
    end

    local riverSubtract = riverSize *
        ((RiverAltitudeSubtraction / riverAltRange) / (regMap.highestRegionAltitude + 1))

    local altitude = regionAlt - riverSubtract

    return altitude
end

function GetRiverSize(x, y)
    local riverAverage = 0.0
    for direction = 5, 8 do
        local rxX, rxY = riverMap:rxFromPlot(x, y, direction)
        local rxI = riverMap:getRiverIndex(rxX, rxY)
        riverAverage = riverAverage + riverMap.riverMap[rxI]
    end
    riverAverage = riverAverage / 4.0
    return riverAverage
end

function IsPlotTouchingRiver(x, y)
    for direction = 5, 8 do
        local rxX, rxY = riverMap:rxFromPlot(x, y, direction)
        local rxI = riverMap:getRiverIndex(rxX, rxY)
        if riverMap.riverMap[rxI] > RiverThreshold then
            return true
        end
    end
    return false
end

function IsPlotSurroundedByOcean(x, y)
    for direction = 1, 8 do
        local xx, yy = regMap:getXYFromDirection(x, y, direction)
        local i = GetIndex(xx, yy)
        if plotMap.plotMap[i] ~= plotMap.OCEAN then
            return false
        end
    end
    return true
end

function SetClimateOptions()
    local climate = CyMap():getClimate()
    if climate == GetInfoType("CLIMATE_ARID") then
        JungleThreshold = 0.98
        PlainsThreshold = 0.80
        DesertThreshold = 0.70
    elseif climate == GetInfoType("CLIMATE_TROPICAL") then
        JungleThreshold = 0.50
        PlainsThreshold = 0.35
        DesertThreshold = 0.10
        LeafyAltitude = 0.40
    elseif climate == GetInfoType("CLIMATE_COLD") then
        TundraThreshold = 0.35
        IceThreshold = 0.55
        MaxDesertAltitude = 0.25
        LeafyAltitude = 0.20
        EvergreenAltitude = 0.30
    end
end

function GetRainfall(x, y)
    local rainfall = 0
    local i = GetIndex(x, y)
    local regionID = regMap.regionMap[i]
    if regionID ~= -1 then
        local region = regMap:getRegionByID(regionID)
        rainfall = region.moisture
        local riverSize = GetRiverSize(x, y)
        local riverSizeMax = RiverThreshold * RiverAddsMoistureMax
        riverSize = math.min(riverSize, riverSizeMax)
        rainfall = rainfall + (riverSize / riverSizeMax) * RiverAddsMoistureRange
    end
    return rainfall
end

function GetDistance(x, y, dx, dy)
    local distance = math.sqrt(math.abs((x - dx) * (x - dx) + (y - dy) * (y - dy)))
    return distance
end

function generatePlotTypes()
    NiTextOut("Generating Plot Types  ...")
    print("Adding Terrain")
    local gc = CyGlobalContext()
    local mmap = gc:getMap()
    mapSize.MapWidth = mmap:getGridWidth()
    mapSize.MapHeight = mmap:getGridHeight()
    SetClimateOptions()
    print(string.format("MapWidth = %d, MapHeight = %d", mapSize.MapWidth, mapSize.MapHeight))

    local plotTypes = {}
    for i = 1, mapSize.MapWidth * mapSize.MapHeight do
        plotTypes[i] = PlotTypes.PLOT_OCEAN
    end

    local NumberOfPlayers = gc:getGame():countCivPlayersEverAlive()
    regMap:createRegions()
    riverMap:createRiverMap()
    plotMap:createPlotMap()

    for i = 1, mapSize.MapWidth * mapSize.MapHeight do
        local mapLoc = plotMap.plotMap[i]
        if mapLoc == plotMap.PEAK then
            plotTypes[i] = PlotTypes.PLOT_PEAK
        elseif mapLoc == plotMap.HILLS then
            plotTypes[i] = PlotTypes.PLOT_HILLS
        elseif mapLoc == plotMap.LAND then
            plotTypes[i] = PlotTypes.PLOT_LAND
        else
            plotTypes[i] = PlotTypes.PLOT_OCEAN
        end
    end
    print("Finished generating plot types.")
    return plotTypes
end

function generateTerrainTypes()
    NiTextOut("Generating Terrain  ...")
    print("Adding Terrain")
    local gc = CyGlobalContext()
    local terrainDesert = gc:getInfoTypeForString("TERRAIN_DESERT")
    local terrainPlains = gc:getInfoTypeForString("TERRAIN_PLAINS")
    local terrainIce = gc:getInfoTypeForString("TERRAIN_SNOW")
    local terrainTundra = gc:getInfoTypeForString("TERRAIN_TUNDRA")
    local terrainGrass = gc:getInfoTypeForString("TERRAIN_GRASS")
    local terrainHill = gc:getInfoTypeForString("TERRAIN_HILL")
    local terrainCoast = gc:getInfoTypeForString("TERRAIN_COAST")
    local terrainOcean = gc:getInfoTypeForString("TERRAIN_OCEAN")
    local terrainPeak = gc:getInfoTypeForString("TERRAIN_PEAK")
    local terrainMarsh = gc:getInfoTypeForString("TERRAIN_MARSH")

    terrainMap:createTerrainMap()
    local terrainTypes = {}
    for i = 1, mapSize.MapWidth * mapSize.MapHeight do
        if terrainMap.terrainMap[i] == terrainMap.OCEAN then
            terrainTypes[i] = terrainOcean
        elseif terrainMap.terrainMap[i] == terrainMap.COAST then
            terrainTypes[i] = terrainCoast
        elseif terrainMap.terrainMap[i] == terrainMap.DESERT then
            terrainTypes[i] = terrainDesert
        elseif terrainMap.terrainMap[i] == terrainMap.PLAINS then
            terrainTypes[i] = terrainPlains
        elseif terrainMap.terrainMap[i] == terrainMap.GRASS then
            terrainTypes[i] = terrainGrass
        elseif terrainMap.terrainMap[i] == terrainMap.TUNDRA then
            terrainTypes[i] = terrainTundra
        elseif terrainMap.terrainMap[i] == terrainMap.ICE then
            terrainTypes[i] = terrainIce
        elseif terrainMap.terrainMap[i] == terrainMap.MARSH then
            terrainTypes[i] = terrainMarsh
        end
    end
    print("Finished generating terrain types.")
    return terrainTypes
end

function addRivers()
    NiTextOut("Adding Rivers....")
    print("Adding Rivers")
    local gc = CyGlobalContext()
    local pmap = gc:getMap()
    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            placeRiversInPlot(x, y)
        end
    end
end

function placeRiversInPlot(x, y)
    local gc = CyGlobalContext()
    local pmap = gc:getMap()
    local plot = pmap:plot(x, y)

    local xx, yy = riverMap:rxFromPlot(x, y, riverMap.NE)
    local ii = riverMap:getRiverIndex(xx, yy)
    if riverMap.riverMap[ii] > RiverThreshold and riverMap.flowMap[ii] == riverMap.S then
        plot:setWOfRiver(true, CardinalDirectionTypes.CARDINALDIRECTION_SOUTH)
    end

    xx, yy = riverMap:rxFromPlot(x, y, riverMap.SW)
    ii = riverMap:getRiverIndex(xx, yy)
    if riverMap.riverMap[ii] > RiverThreshold and riverMap.flowMap[ii] == riverMap.E then
        plot:setNOfRiver(true, CardinalDirectionTypes.CARDINALDIRECTION_EAST)
    end

    xx, yy = riverMap:rxFromPlot(x, y, riverMap.SE)
    ii = riverMap:getRiverIndex(xx, yy)
    if riverMap.riverMap[ii] > RiverThreshold and riverMap.flowMap[ii] == riverMap.N then
        plot:setWOfRiver(true, CardinalDirectionTypes.CARDINALDIRECTION_NORTH)
    elseif riverMap.riverMap[ii] > RiverThreshold and riverMap.flowMap[ii] == riverMap.W then
        plot:setNOfRiver(true, CardinalDirectionTypes.CARDINALDIRECTION_WEST)
    end
end

function addFeatures()
    NiTextOut("Generating Features  ...")
    print("Adding Features")
    local gc = CyGlobalContext()
    local mmap = gc:getMap()
    local featureIce = gc:getInfoTypeForString("FEATURE_ICE")
    local featureJungle = gc:getInfoTypeForString("FEATURE_JUNGLE")
    local featureOasis = gc:getInfoTypeForString("FEATURE_OASIS")
    local featureFloodPlains = gc:getInfoTypeForString("FEATURE_FLOOD_PLAINS")
    local featureForest = gc:getInfoTypeForString("FEATURE_FOREST")
    local featureScrub = gc:getInfoTypeForString("FEATURE_SCRUB")
    local FORESTLEAFY = 0
    local FORESTEVERGREEN = 1
    local FORESTSNOWY = 2

    for y = 0, mapSize.MapHeight - 1 do
        for x = 0, mapSize.MapWidth - 1 do
            local i = GetIndex(x, y)
            local plot = mmap:plot(x, y)

            if not plot:isWater() and terrainMap.terrainMap[i] ~= terrainMap.DESERT and
                plotMap.plotMap[i] ~= plotMap.PEAK then

                local rainfall = GetRainfall(x, y)
                if rainfall >= math.random(100) then
                    local altitude = GetPlotAltitude(x, y)
                    if altitude < LeafyAltitude then
                        if rainfall >= JungleThreshold then
                            if plot:isFlatlands() and math.random(100) < ChanceForMarsh then
                                plot:setTerrainType(gc:getInfoTypeForString("TERRAIN_MARSH"), true, true)
                                if math.random(100) >= ChanceForOnlyMarsh then
                                    plot:setFeatureType(featureJungle, 0)
                                end
                            else
                                plot:setFeatureType(featureJungle, 0)
                            end
                        else
                            if altitude < EvergreenAltitude then
                                plot:setFeatureType(featureForest, FORESTLEAFY)
                            elseif altitude < TundraThreshold then
                                plot:setFeatureType(featureForest, FORESTEVERGREEN)
                            else
                                plot:setFeatureType(featureForest, FORESTSNOWY)
                            end
                        end
                    elseif altitude < EvergreenAltitude then
                        plot:setFeatureType(featureForest, FORESTLEAFY)
                    elseif altitude < TundraThreshold then
                        plot:setFeatureType(featureForest, FORESTEVERGREEN)
                    else
                        plot:setFeatureType(featureForest, FORESTSNOWY)
                    end
                end
            end

            if featureScrub ~= -1 and terrainMap.terrainMap[i] == terrainMap.DESERT and
                plotMap.plotMap[i] ~= plotMap.PEAK and
                plotMap.plotMap[i] ~= plotMap.HILLS then
                local rainfall = GetRainfall(x, y)
                local randValue = math.random(100)
                if rainfall * 3.0 >= randValue then
                    plot:setFeatureType(featureScrub, 0)
                end
            end

            if terrainMap.terrainMap[i] == terrainMap.DESERT and
                plotMap.plotMap[i] ~= plotMap.HILLS and
                plotMap.plotMap[i] ~= plotMap.PEAK and
                not plot:isWater() then
                if plot:isRiver() then
                    plot:setFeatureType(featureFloodPlains, 0)
                else
                    local foundNonDesert = false

                    for yy = y - 1, y + 1 do
                        for xx = x - 1, x + 1 do
                            local ii = GetIndex(xx, yy)
                            local surPlot = mmap:plot(xx, yy)
                            if terrainMap.terrainMap[ii] ~= terrainMap.DESERT and
                                plotMap.plotMap[ii] ~= plotMap.PEAK then
                                foundNonDesert = true
                            elseif surPlot == 0 then
                                foundNonDesert = true
                            elseif surPlot:isWater() then
                                foundNonDesert = true
                            elseif surPlot:getFeatureType() == featureOasis then
                                foundNonDesert = true
                            end
                        end
                    end
                    if not foundNonDesert then
                        if math.random(100) < OasisChance then
                            plot:setFeatureType(featureOasis, 0)
                        end
                    end
                end
            end
        end
    end
end

function normalizeRemoveBadFeatures()
    local gc = CyGlobalContext()
    local gameMap = CyMap()

    local civPrefList = GetCivPreferences()

    for playerIndex = 0, gc:getMAX_CIV_PLAYERS() - 1 do
        local player = gc:getPlayer(playerIndex)
        if player:isEverAlive() then
            local civType = player:getCivilizationType()
            local civPref = spf:getCivPreference(civPrefList, civType)
            if civPref.allowForestStart then
                goto continue
            end
            local plot = player:getStartingPlot()
            local featureType = plot:getFeatureType()
            if featureType == GetInfoType("FEATURE_FOREST") or
                featureType == GetInfoType("FEATURE_JUNGLE") then
                plot:setFeatureType(GetInfoType("NO_FEATURE"), 0)
            end
            for direction = 1, 8 do
                local xx, yy = plotMap:getXYFromDirection(plot:getX(), plot:getY(), direction)
                local nPlot = gameMap:plot(xx, yy)
                featureType = nPlot:getFeatureType()
                if featureType == GetInfoType("FEATURE_FOREST") or
                    featureType == GetInfoType("FEATURE_JUNGLE") then
                    nPlot:setFeatureType(GetInfoType("NO_FEATURE"), 0)
                end
            end
            ::continue::
        end
    end
end

function getGridSize(argsList)
    -- Adjust grid sizes for optimum results
    initialize()
    local seaLevel = CyMap():getSeaLevel()
    local scaler = 1.0

    if seaLevel == GetInfoType("SEALEVEL_LOW") then
        scaler = math.sqrt(
            (RegionsPerPlot - WaterRegionsPerPlot) /
            (RegionsPerPlot - WaterRegionsPerPlot * 0.5))
        WaterRegionsPerPlot = WaterRegionsPerPlot * 0.5
        print(string.format("Sea level is low, map dimension scaler = %f", scaler))
    elseif seaLevel == GetInfoType("SEALEVEL_HIGH") then
        scaler = math.sqrt(
            (RegionsPerPlot - WaterRegionsPerPlot) /
            (RegionsPerPlot - WaterRegionsPerPlot * 3.0))
        WaterRegionsPerPlot = WaterRegionsPerPlot * 2.0
        print(string.format("Sea level is high, map dimension scaler = %f", scaler))
    end

    local grid_sizes = {
        [WorldSizeTypes.WORLDSIZE_DUEL] = {math.floor(8 * scaler), math.floor(8 * scaler)},
        [WorldSizeTypes.WORLDSIZE_TINY] = {math.floor(9 * scaler), math.floor(9 * scaler)},
        [WorldSizeTypes.WORLDSIZE_SMALL] = {math.floor(10 * scaler), math.floor(10 * scaler)},
        [WorldSizeTypes.WORLDSIZE_STANDARD] = {math.floor(13 * scaler), math.floor(13 * scaler)},
        [WorldSizeTypes.WORLDSIZE_LARGE] = {math.floor(15 * scaler), math.floor(15 * scaler)},
        [WorldSizeTypes.WORLDSIZE_HUGE] = {math.floor(18 * scaler), math.floor(18 * scaler)}
    }

    if argsList[1] == -1 then  -- Lua arrays start at 1
        return {}
    end
    local eWorldSize = argsList[1]
    return grid_sizes[eWorldSize]
end

function afterGeneration()
    print("Doing after-generation stuff")
    spf.initialize()
    if FFHSpecific == false then
        return
    end
    local count = spf.collectAllWatchtowers()
    spf.replaceWatchtowers(count)
    spf.replaceUniqueImprovements()
end

function assignStartingPlots()
    spf.assignStartingPlots()
end

-- Global variables
mapSize = MapSize()
print('entering region Map')
regMap = RegionMap.new()
print('entering River Map')
riverMap = RiverMap.new()
print('entering Plot Map')
plotMap = PlotMap.new()
print('entering Terrain Map')
terrainMap = TerrainMap.new()
print('entering StartingPlotFinder')
spf = StartingPlotFinder.new()

-- Usage example:
-- local finder = StartingPlotFinder.new()
-- finder:initialize()
-- finder:assignStartingPlots()
-------------------------------------------------------------------------------

