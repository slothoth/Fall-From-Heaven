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
-- TODO CURRENTLY NOT RANDOM KEEP GETTING SAME MAP SHAPES


-- This variable will make a percentage of peaks into hills in order to break
-- up the worlds valleys. I set this to zero because I feel it diminishes the
-- illusion of differing climates between valleys and looks bad.
SoftenPeakPercent = 0.0

-- This variable decides how many tiles of drainage is needed to create a
-- river.
RiverThreshold = 5.0

-- The amount of rainfall in the dryest desert. Must be between 1.0 and 0.0
MinRainfall = .25

-- This number is multiplied by the RiverThreshold to determine when a river
-- is large enough to have a 100% chance to flatten nearby hills and peaks.
RiverFactorFlattensAll = 10.0

RiverAddsMoistureRange = .20
RiverAddsMoistureMax = 10.0

-- These variables control the frequency of hills and peaks at the lowest
-- and highest altitudes
HillChanceAtZero = .15

HillChanceAtOne = .90
PeakChanceAtZero = .0
PeakChanceAtOne = .20

-- These valiables control the moisture thresholds for desert and plains
JungleThreshold = .90
PlainsThreshold = .50
DesertThreshold = .30

-- Chance for jungle to have marsh, and chance for marsh to replace jungle
ChanceForMarsh = 0.30
ChanceForOnlyMarsh = 0.33

-- These variables control the altitude of tundra and ice. Also, in Civ,
-- deserts are supposed to be hot, so we'll limit the altitude for deserts
TundraThreshold = .74
IceThreshold = .84
MaxDesertAltitude = .65

-- Chance for an oasis to appear in desert
OasisChance = .08

-- Map constants - I'm making a point on this map to hardcode nothing, so some
-- of these may seem a bit obscure.
-- -------------------------------------------------------------------
RegionsPerPlot = 0.009              -- Map regions(valleys, seas) per map plot
WaterRegionsPerPlot = 0.002         -- Water regions per map plot
MinSeedRange = 5                    -- Closest that a region seed can be placed to another
MinEdgeRange = 5                    -- Closest that a region seed can be to map edge
ChanceToGrow = 0.25                 -- Base chance for each tile in region to grow
EdgeLimit = 2                       -- Region stops growing this far from edge
RiverAltitudeSubtraction = 2.0      -- Amount subtracted from a plots altitude depending on river size
RiverAltRangeFactor = 2.0           -- Amount of RiverThreshold to use for altitude calc
MinRegionSizeStart = 40             -- Minimum region size for a starting plot
MinRegionSizeTower = 30             -- Minimum region size for a tower placement
ChokePointAreaSize = 10             -- chokepoint needs this size area on both sides
ChokePointWalkAroundDistance = 12   -- chokepoint must cause this much extra walking to be considered a choke
WrapX = false                       -- Dont touch these, this map has no wrap
WrapY = false



-- new defines:
L = 0
N = 1
S = 2
E = 3
W = 4
NE = 5
NW = 6
SE = 7
SW = 8
directionXmap = {[N]=0,[S]=0,[E]=1,[W]=-1, [NE]=1, [NW]=-1, [SE]=1, [SW]=-1}
directionYmap = {[N]=1,[S]=-1,[E]=0,[W]=0, [NE]=1, [NW]=1, [SE]=-1, [SW]=-1}

rxXMap = {[NE]= 0, [NW] = -1, [SE] = 0, [SW] = -1}
rxYMap = {[NE]= 0, [NW] = 0, [SE] = -1, [SW] = -1}
highestRegionAltitude = 0
OCEAN = 0
LAND = 1
HILLS = 2
PEAK = 3
-- conversion table for prints
function mapChar(integer)
    local c
    if integer <= 26 then
        c = string.char(integer + 96)  -- 'a' to 'z'
    else
        c = string.char(integer + 38)  -- 'A' to 'Z'
    end
    return c
end
RegionCharMap = {}
CharRegionMap = {}

for count=1, 52 do
    table.insert(RegionCharMap, mapChar(count))
end

for key, val in ipairs(RegionCharMap) do
    CharRegionMap[val] = key
end

function createRegions()
    --Growing the regions directly according to the map size created
    --unsolvable problems for the river system. Instead, I am growing
    --on a map (regionRxMap) that corresponds to rivers rather than
    --map tiles. This ensures rivers have a path from region to
    --region.

    -- globals
    numTiles = (g_iW +1) * (g_iH + 1)
    numRx = (g_iW + 1) * (g_iH + 1)
    regionMap = {}
    regionRxMap = {}
    regionList = {}
    regionPlotList = {}

    --initialize map
    --The value for unplayable areas will remain -1. playable regions
    --will stop growing when they touch a map edge.
    for i = 1, numTiles do
        regionMap[i] = -1
    end

    for i = 1, numRx do
        regionRxMap[i] = -1
    end
    local numRegions = math.floor(tonumber(numTiles) * RegionsPerPlot)
    print('number of regions!: ', numRegions)
    for i = 1, numRegions do
        -- first find a random seed point that is not blocked by
        -- previous points
        iterations = 0
        local notFoundSeed = true
        while notFoundSeed do
            iterations = iterations + 1
            if iterations > 10000 then
                error("endless loop in region seed placement")
            end
            seedX = math.random(0, g_iW + 1)
            seedY = math.random(0, g_iH + 1)
            if not isSeedBlocked(seedX, seedY) then
                local region = Region.new(i, seedX, seedY)
                table.insert(regionList, region)
                local n = GetRxIndex(seedX, seedY)
                regionRxMap[n] = i
                local plot = {regionId=i, x=seedX, y=seedY, gateRx=-1, bBorder=false, bEdge=false}
                table.insert(regionPlotList, plot)
                --Now fill a 3x3 area to insure a minimum region size
                for direction = 1, 8 do
                    local xx = seedX + directionXmap[direction]
                    local yy = seedY + directionYmap[direction]
                    local nn = GetRxIndex(xx, yy)
                    regionRxMap[nn] = i
                    plot = {regionId=i, x=xx, y=yy, gateRx=-1, bBorder=false, bEdge=false}
                    table.insert(regionPlotList, plot)
                end
                notFoundSeed = false
            end
        end
    end
    -- PrintRegionRxMap(false)
    --Now cause the seeds to grow into regions
    local iterations = 0
    while #regionPlotList > 0 do
        iterations = iterations + 1
        if iterations > 200000 then
            PrintRegionRxMap(false)
            error("endless loop in region growth")
        end
        local plot = regionPlotList[1]
        if not plot then
            print('-- PLOT NOT FOUND')
        end
        local region = getRegionByID(plot.regionId)
        if region.isGrowing then
            local roomLeft = false
            for direction = 1, 5 do
                local xx = plot.x+ directionXmap[direction]
                local yy = plot.y + directionYmap[direction]
                local i = GetRxIndex(xx, yy)
                if i == -1 or rxTouchesMapEdge(xx, yy) then
                    if canRegionGrowHere(xx, yy, plot.regionId) then
                        regionRxMap[i] = plot.regionId
                        local newPlot = {regionId=plot.regionId, x=xx, y=yy, gateRx=-1, bBorder=false, bEdge=false}
                        table.insert(regionPlotList, newPlot)
                    end
                    if region.isTouchingNeighbor then
                        region.isGrowing = false
                        print('cancelled growth')
                    end
                else
                    if canRegionGrowHere(xx, yy, plot.regionId) then
                        roomLeft = true
                        if math.random() < ChanceToGrow then
                            regionRxMap[i] = plot.regionId
                            local newPlot = {regionId=plot.regionId, x=xx, y=yy, gateRx=-1, bBorder=false, bEdge=false}
                            table.insert(regionPlotList, newPlot)
                        end
                    end
                end
            end
            --move plot to the end of the list if room left, otherwise
            --delete it if no room left
            if roomLeft then
                table.insert(regionPlotList, plot)
            end
            plot = table.remove(regionPlotList, 1)
        else
            plot = table.remove(regionPlotList, 1)
        end
    end
    --       PrintRegionRxMap(false)
    --Now convert regionRxMap to regionMap
    for y=1, g_iH do
        for x=1, g_iW do
            local i = GetRxIndex(x, y)
            local regionID = regionRxMap[i]
            if regionID and regionID ~= -1 then
                local region = getRegionByID(regionID)
                for direction= 5, 8 do
                    slthLog('direction', direction)
                    local xx, yy = plotFromRx(x, y, direction)
                    if xx == 71 and yy == 71 then
                        print(string.format("x=%d,y=%d,xx=%d,yy=%d", x, y, xx, yy))
                    end
                    local ii = GetIndex(xx, yy)
                    if ii ~= -1 then
                        regionMap[ii] = regionID
                        local newPlot = {regionId=regionID, x=xx, y=yy, gateRx=-1, bBorder=false, bEdge=false}
                        table.insert(region.plotList, newPlot)
                    end
                end
            end
        end
    end
    --Mark border tiles and neighbor regions
    for _, region in ipairs(regionList) do
        for _, plot in ipairs(region.plotList) do
            i = GetIndex(plot.x, plot.y)
            for direction=1, 4 do
                local xx, yy = GetDirection(direction, plot)
                local ii = GetIndex(xx, yy)
                if ii ~= -1 and regionMap[ii] ~= -1 and regionMap[ii] ~= region.ID then
                    plot.bBorder = true
                    plot.bEdge = true
                    if not check_in_table(region.neighborList, regionMap[ii])  then
                        table.insert(region.neighborList, regionMap[ii])
                    end
                elseif regionMap[ii] == -1 then
                    plot.bEdge = true
                end
            end
        end
    end
    -- PrintRegionMap(false)

    --Now choose areas to be water
    local numWaterRegions = math.floor(tonumber(numTiles) * WaterRegionsPerPlot)
    slthLog(string.format("numTiles = %d, numWaterRegions = %d", numTiles, numWaterRegions))
    for i, region in ipairs(regionList) do print(i, region.ID); end
    slthLog('first shuffle')
    regionList = ShuffleList(regionList)
    --Try to start with the region in the middle (there is a low chance that there isn't one)
    local middle_region_index = GetIndex(g_iW / 2, g_iH / 2)
    local regionID = regionMap[middle_region_index]
    if regionID == -1 then
        regionList[1].isWater = true                -- this seems odd
    else
        local region = getRegionByID(regionID)
        region.isWater = true
    end
    for i=1, numWaterRegions-1 do
        regionList = ShuffleList(regionList)
        for _, nRegion in ipairs(regionList) do
            nRegion.waterNeighborCount = nRegion:getWaterNeighborCount()
        end
        table.sort(regionList, function(a, b)
            return a.waterNeighborCount < b.waterNeighborCount
        end)
        -- python code for sort: regionList.sort(lambda x, y: cmp(x.waterNeighborCount, y.waterNeighborCount))

        for _, nRegion in ipairs(regionList) do
            if nRegion.waterNeighborCount > 0 and nRegion.isWater == false then
                nRegion.isWater = true
                break
            end
        end
    end

    --       PrintRegionMap(false)
    slthLog('fill water')
    --Now fill any non-areas adjacent to water with the water area
    for _, region in ipairs(regionList) do
        if region.isWater then
            local regionExpanding = true
            while regionExpanding do
                regionExpanding = region:expandWaterRegion()
            --       PrintRegionMap(false)
            end
        end
    end
end

function canRegionGrowHere(x, y, regionID)
    local i = GetRxIndex(x, y)
    if i == -1 then
        return false
    end
    if regionRxMap[i] ~= -1 then
        return false
    end
    local region = getRegionByID(regionID)
    if not region.isGrowing then
        return false
    end
    local assume = true
    for direction=1, 8 do
        local xx = x + directionXmap[direction]
        local yy = y + directionYmap[direction]
        local ii = GetRxIndex(xx, yy)
        if not(ii == -1 or regionRxMap[ii] == regionID or regionRxMap[ii] == -1) then
            region.isTouchingNeighbor = true
            assume = false
        end
    end
    return assume
end

function rxTouchesMapEdge(x, y)
    if x >= (g_iW + 1) - EdgeLimit or x < EdgeLimit then
        return true
    end
    if y >= (g_iH + 1) - EdgeLimit or y < EdgeLimit then
        return true
    end
    return false
end
function plotFromRx(rxX, rxY, direction)
    local x = rxX + rxXMap[direction]
    local y = rxY + rxYMap[direction]
    if x < 0 or x >= g_iW or y < 0 or y >= g_iH then
        return -1, -1
    end
    return x, y
end

function isSeedBlocked(seedX, seedY)
    for _, region in ipairs(regionList) do
        if seedX > region.seedX - MinSeedRange and seedX < region.seedX + MinSeedRange then
            if seedY > region.seedY - MinSeedRange and seedY < region.seedY + MinSeedRange then
                return true
            end
        end
    end
    --Check for edge
    if seedX < MinEdgeRange or seedX >= (g_iW + 1) - MinEdgeRange then
        return true
    end
    if seedY < MinEdgeRange or seedY >= (g_iH + 1) - MinEdgeRange then
        return true
    end
    return false
end

function getRegionByID(ID)
    if not ID then
        error('ID of region was nil')           -- TODO this intermittently errors... this time at shouldPlacePeak
    end
    for i, region in ipairs(regionList) do
        if region.ID == ID then
            return region
        end
    end
    error(string.format('couldnt find region: %d', ID))
end

function PrintRegionMap(bShowWater)
    local lineString = ""
    for y=g_iH - 1, -1, -1 do
        for x=0, g_iW do
            local mapLoc = regionMap[GetIndex(x, y)]
            if not mapLoc or mapLoc == -1 then
                lineString = lineString .. "X"
            else
                local region = getRegionByID(mapLoc)
                if bShowWater and region.isWater then
                    lineString = lineString .. " "
                else
                    lineString = lineString .. RegionCharMap[mapLoc]
                end
            end
        end
        print(lineString)
        lineString = ''
    end
    return lineString
end

function PrintRegionRxMap(bShowWater)
    for y=g_iH, -1, -1 do
        local lineString = ""
        for x=0, g_iW do
            local mapLoc = regionRxMap[GetRxIndex(x, y)]
            local region = getRegionByID(mapLoc)
            if mapLoc == -1 then
                lineString = lineString + "X"
            elseif bShowWater and region.isWater == true then
                lineString = lineString + " "
            else
                lineString = lineString .. RegionCharMap[mapLoc]
            end
        end
    end
end

function PrintRegionList()
    slthLog("Number of regions:", #regionList)
    for i, region in ipairs(regionList) do
        slthLog(region.ID)
    end
end

-- bleh Region Class

Region = {}
Region.__index = Region

function Region.new(ID, seedX, seedY)
    local self = setmetatable({}, Region)
    self.ID = ID
    self.seedX = seedX
    self.seedY = seedY
    self.isGrowing = true
    self.neighborList = {}
    self.gateRegion = -1
    self.gatePlot = None
    self.plotList = {}
    self.isWater = false
    self.isTouchingNeighbor = false
    self.altitude = 0.0
    self.moisture = 1.0
    return self
end


function Region:__str__()
    local str_ = string.format("ID=%dd(%ds), size=%dd, altitude=%dd \n", self.ID, RegionCharMap[self.ID],#self.plotList ,self.altitude)
    str_ = str_ + string.format("gateRegion=%dd(%ds) \n", self.gateRegion, RegionCharMap[self.gateRegion])
    str_ = str_ + "    " + self.NeighborListString() + "\n"
    return str_
end

function Region:NeighborListString()
    local str_ = "["
    for ID in self.neighborList do
        str_ = str_ + RegionCharMap[ID] + ","
    end
    str_ = str_ + "]"
    return str_
end

function Region:getWaterNeighborCount()
    local count = 0
    for i, regionID in ipairs(self.neighborList) do
        local region = getRegionByID(regionID)
        if region.isWater == true then
            count = count + 1
        end
    end
    return count
end

function Region:getBorderPlotList(neighborID)
    local borderPlotList = {}
    local borderPlotCount = 0
    for plot in self.plotList do
        if plot.bBorder == true then
            borderPlotCount = borderPlotCount + 1
            for direction=1, 4 do
                local xx, yy = GetDirection(direction, plot)
                local ii = GetIndex(xx, yy)
                if ii ~= -1 and regionMap[ii] == neighborID then
                    table.insert(borderPlotList, plot)
                    break
                end
            end
        end
    end
    print("borderPlotCount=%dd", borderPlotCount)
    return borderPlotList
end

function Region:getGateListToNeighbor(neighborID)
    local gateListToNeighbor = {}
    for _, rPlot in pairs(self.gateList) do
        if isRxTouchingRegion(rPlot.x, rPlot.y, neighborID) then
            table.insert(gateListToNeighbor, rPlot)
        end
    end
    slthLog(string.format("%d gates from %d to %d", #gateListToNeighbor, self.ID, neighborID))
    return gateListToNeighbor
end

function Region:defineValidGateList()
    -- This function is called in createFlowMap so the riverMap functions
    -- can be called from here. We now complile a list of all possible river
    -- gates
    self.gateList = {}
    currentRegion = self.ID
    for rxY=1, g_iH + 1 do
        for rxX=1, g_iW + 1 do
            if isRxTouchingRegion(rxX, rxY, self.ID) then
                if isValidFullGate(self.ID, rxX, rxY) then
                    local rPlot = {x=rxX, y=rxY, direction=-1, self.ID}
                    table.insert(self.gateList, rPlot)
                end
            end
        end
    end
end
function Region:expandWaterRegion()
    local expanded = false
    for _, plot in ipairs(self.plotList) do
        for direction=1, 4 do
            local xx, yy = GetDirection(direction, plot)
            local ii = GetIndex(xx,yy)
            if ii ~= -1 and regionMap[ii] == -1 then
                local naPlot = {regionId=self.ID, x=xx, y=yy, gateRx=-1, bBorder=false, bEdge=false}
                regionMap[ii] = self.ID
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
        region = getRegionByID(regionID)
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
    for bPlot in self.plotList do
        if bPlot.bEdge then
            local distance = GetDistance(plot.x, plot.y, bPlot.x, bPlot.y)
            if distance < minDistance then
                minDistance = distance
            end
        end
    end
    return minDistance
end
-- In this case the center is the plot farthest from any border
function Region:getCenter()
    local maxDistance = 0.0
    local center = None
    for plot in self.plotList do
        local distance = self.getDistanceToClosestBorderPlot(plot)
        if maxDistance < distance then
            maxDistance = distance
            --                print "maxDistance= %(m)f, plot.x= %(x)d, plot.y=%(y)d" % \
            --                {"m":maxDistance,"x":plot.x,"y":plot.y}
            center = plot
        end
    end
    return center
end

-- helper functions

function GetDirection(direction, plot)
    local xx, yy = 0, 0
    if direction == 1 then      -- N
        xx = plot.x
        yy = plot.y + 1
    elseif direction == 2 then  -- S
        xx = plot.x
        yy = plot.y - 1
    elseif direction == 3 then  -- E
        xx = plot.x + 1
        yy = plot.y
    else                        -- W
        xx = plot.x - 1
        yy = plot.y
    end
    -- ii = GetIndex(xx, yy)
    return xx, yy
end

function GetRxIndex(x, y)
    local xx, yy
    if WrapX then
        xx = x % (mapSize.MapWidth + 1)
    elseif x < 0 or x >= (g_iW + 1) then
        return -1
    else
        xx = x
    end
    -- Check y for wrap
    if WrapY then
        yy = y % (mapSize.MapHeight + 1)
    elseif y < 0 or y >= (g_iH + 1) then
        return -1
    else
        yy = y
    end
    return yy * (g_iW + 1) + xx
end

function GetRxIndex(x, y)
    local xx, yy
    if x < 0 or x >= (g_iW + 1) then
        return -1
    else
        xx = x
    end
    if y < 0 or y >= (g_iH + 1) then
        return -1
    else
        yy = y
    end
    return yy * (g_iW + 1) + xx
end

-- This function converts x and y to an index. Useful in case of future wrapping.
function GetIndex(x, y)
    local xx = x
    local yy = y
    if WrapX then
        xx = x % g_iW
    elseif x < 0 or x > g_iW then
        return -1
    end
    if WrapY then
        yy = y % g_iH
    elseif y < 0 or y > g_iH then
        return -1
    end
    return  y * g_iW + x
end

-- overriden as performance, and seemingly does nothing
function GetIndex(x, y)
    if x < 0 or x > g_iW or y < 0 or y > g_iH then
        return -1
    else
        return  y * g_iW + x
    end
end

function ShuffleList(theList)
    for i = #theList, 2, -1 do
        local j = math.random(1, i)
        theList[i], theList[j] = theList[j], theList[i]
    end
    return theList
end

function print_table(tbl_)
    for key, val in pairs(tbl_) do
        if type(val) == "table" then
            print('recursive table on ', key)
            print_table(val)
        else
            slthLog(string.format('key: %s . val: %s', key, val))
        end
    end
end

function check_in_table(tbl, val)
  for _, v in ipairs(tbl) do
    if v == val then
      return true
    end
  end
  return false
end

function checkRegions()
    local all_found = true
    for j=1, #regionList do
        local found = false
        for i, region in ipairs(regionList) do
            if region.ID == j then
                found = true        -- print(string.format('found region %d at index %d', region.ID, i))
            end
        end
        if not found then
            print(string.format('couldnt find region %d', j))
            all_found = false
        end
    end
    if all_found then
        slthLog('all good')
    end
end
function createCharacterImageSVG(grid, rx_data, debug_mode, symbol_mapper, key_mapper)
    return
end
--[[
function createCharacterImageSVG(grid, rx_data, debug_mode, symbol_mapper, key_mapper)
    if not key_mapper then
        key_mapper = {}
    end
    local excludedPlots = {}
    local highlighted_regions = {}
    if rx_data then
        for k, v in pairs(rx_data) do
            for part in string.gmatch(k, "[^/]+") do
                highlighted_regions[tonumber(part)] = tonumber(part)
                break
            end
        end
        for key, val in pairs(rx_data) do
            for key_, val_ in pairs(val) do
                local reason = val_['failure']
                if reason == 'FULL_GATE' then
                    excludedPlots[val_['x'] .. '/' .. val_['y']] -- = true
                --[[end
            end
        end
    end
    local height = #grid
    local width = 0
    for i = 1, height do
        width = math.max(width, #grid[i])
    end

    -- First find unique characters
    local uniqueChars = {}
    local charCount = 0

    -- Predefined symbols remain the same
    local symbols = {
        ["O"] = '#0000FF', -- Blue
        ["P"] = '#FF0000', -- Red
        ["H"] = '#FFFF00', -- Yellow
        ["L"] = '#00FF00', -- Green
        ["TERRAIN_OCEAN"]  = '#0000FF',
        ["TERRAIN_COAST"]  = '#00FFFF',
        ["TERRAIN_GRASS"]  = '#00FF00',
        ["TERRAIN_PLAINS"]  = '#FFA500',
        ["TERRAIN_DESERT"]  = '#FFFF00',
        ["TERRAIN_TUNDRA"]  = '#800080',
        ["TERRAIN_SNOW"]  = '#FFFFFF',
        [OCEAN] = "#0000FF",
        [HILLS] = "#FFA500",
        [LAND] = "#00FF00",
        [-1] = '#0000FF'
    }
    if symbol_mapper then
        symbols = symbol_mapper
    end

    -- Get unique characters (removed the charCount < 9 limitation)
    for y = 1, height do
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if not uniqueChars[char] then
                charCount = charCount + 1
                uniqueChars[char] = true
            end
            if debug_mode then
                print(x .. y)
            end
        end
    end

     -- Generate 256 distinct colors using HSV color space
    local function HSVtoRGB(h, s, v)
        local h_i = math.floor(h * 6)
        local f = h * 6 - h_i
        local p = v * (1 - s)
        local q = v * (1 - f * s)
        local t = v * (1 - (1 - f) * s)

        local r, g, b = 0, 0, 0
        if h_i == 0 then r, g, b = v, t, p
        elseif h_i == 1 then r, g, b = q, v, p
        elseif h_i == 2 then r, g, b = p, v, t
        elseif h_i == 3 then r, g, b = p, q, v
        elseif h_i == 4 then r, g, b = t, p, v
        elseif h_i == 5 then r, g, b = v, p, q
        end
        return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
    end

    -- Function to generate optimized colors for small character sets
    local function colorDistance(r1, g1, b1, r2, g2, b2)
        local dr, dg, db = r1 - r2, g1 - g2, b1 - b2
        return math.sqrt(dr * dr + dg * dg + db * db)
    end

    local function hexToRGB(hex)
        return tonumber(hex:sub(2, 3), 16),
               tonumber(hex:sub(4, 5), 16),
               tonumber(hex:sub(6, 7), 16)
    end

    local function generateOptimizedColors(count, excludeList)
        local colors = {}
        local excludeRGB = {}

        for _, hex in ipairs(excludeList or {}) do
            local r, g, b = hexToRGB(hex)
            table.insert(excludeRGB, {r, g, b})
        end

        if count <= 64 then
            local hueStep = 1.0 / (count * 2)  -- oversample to account for skipped colors
            local i, generated = 1, 0
            while generated < count and i <= count * 4 do
                local s = i % 2 == 0 and 1.0 or 0.8
                local v = i % 2 == 0 and 0.9 or 1.0
                local h = (i - 1) * hueStep
                local r, g, b = HSVtoRGB(h, s, v)
                local isTooClose = false
                for _, rgb in ipairs(excludeRGB) do
                    if colorDistance(r, g, b, rgb[1], rgb[2], rgb[3]) < 10 then
                        isTooClose = true
                        break
                    end
                end
                if not isTooClose then
                    colors[#colors + 1] = string.format('#%02X%02X%02X', r, g, b)
                    generated = generated + 1
                end
                i = i + 1
            end
            return colors
        end
    end

    -- Generate color palette based on character count
    local colorPalette = generateOptimizedColors(charCount, {'#0000FF'}) or {}
    if #colorPalette == 0 then
        for i = 0, 255 do
            local h = (i % 16) / 16
            local s = math.floor(i / 16) % 4 / 3
            local v = math.floor(i / 64) % 4 / 3
            local r, g, b = HSVtoRGB(h, 0.5 + s * 0.5, 0.5 + v * 0.5)
            colorPalette[i + 1] = string.format('#%02X%02X%02X', r, g, b)
        end
    end

    -- Assign colors to characters
    local colors = {}
    local colorIndex = 1
    local colour_string = ""
    for char in pairs(uniqueChars) do
        colors[char] = colorPalette[colorIndex]
        colour_string = colour_string .. string.format('%s = %s | ', char, colorPalette[colorIndex])
        colorIndex = (colorIndex % 256) + 1
    end
    if debug_mode then
        print(colour_string)
    end

    -- Calculate pixel size (make SVG 600px wide)
    local svgWidth = 600
    local pixelWidth = math.floor(svgWidth / width)
    local svgHeight = pixelWidth * height

    -- Start SVG string
    if debug_mode then
        print('width: ' .. width .. ' | svgWidth: ' .. svgWidth .. ' | svgHeight: ' .. svgHeight .. ' | pixelWidth: ' .. pixelWidth)
    end
    -- local doKey = charCount < 20
    local doKey = true
    local KeyOffset = 0
    if doKey then
        KeyOffset = 100
    end
    local rulerOffset = pixelWidth * 3
    local svgParts = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %d %d">', svgWidth + rulerOffset, svgHeight + KeyOffset + rulerOffset),
    }

    local keyParts = {}

    -- Add color key (only if there are less than 20 unique characters to keep it readable)
    if doKey then
        local varKeyHeight = svgHeight + rulerOffset + (pixelWidth * 4)
        table.insert(keyParts, '  <!-- Color Key -->')
        local xPosition = 10
        local keys = {}
        for char in pairs(colors) do
            table.insert(keys, char)
        end
        table.sort(keys)

        for _, char in ipairs(keys) do
            local colour = colors[char]
            local label = key_mapper[char] or char
            if symbols[char] then
                colour = symbols[char]
            end
            slthLog(string.format('label %s for char: %s. Colour: %s', label, char, colour))
            local labelLength = string.len(label) * 7
            local keyString = string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">',
            xPosition, varKeyHeight, math.floor(pixelWidth)) .. label .. ":"
            table.insert(keyParts, keyString .. '</text>')
            local rect = string.format(
                    '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                    xPosition+labelLength-5, varKeyHeight-5, pixelWidth, pixelWidth, colour
                )
            table.insert(keyParts, rect)
            if xPosition > svgWidth - labelLength then
                xPosition = 10
                varKeyHeight = varKeyHeight + 20
            else
                xPosition = xPosition + labelLength + 10
            end
        end
    end

    -- Process string line by line
    local regionsEncountered = {}
    table.insert(keyParts, '  <!-- first of labelling -->')
    for y = 1, height do
        for x = 1, #grid[y] do
            if true then
                local char = grid[y][x]
                if colors[char] or symbols[char] then
                    local colour
                    if symbols[char] then
                        colour = symbols[char]
                    else
                        colour = colors[char]
                    end
                    -- Create SVG rect element for this character
                    local rect = string.format(
                        '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                            ((x-1) * pixelWidth)+pixelWidth, ((y-1) * pixelWidth)+pixelWidth, pixelWidth, pixelWidth, colour
                    )
                    table.insert(svgParts, rect)
                    if not regionsEncountered[char] then
                        regionsEncountered[char] = true
                        table.insert(keyParts, string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">%s</text>',
                                ((x-1) * pixelWidth)+pixelWidth, (y * pixelWidth)+pixelWidth, math.floor(pixelWidth), char))
                    end
                end
            end
        end
    end
    for i, j in pairs(regionsEncountered) do
        slthLog(i)
    end

    -- centralised region numbers

    local function get_split_centres(char, char_xs, char_ys, char_centres)
        char_xs[char] = {}
        char_ys[char] = {}
        for y = 1, height do
            for x = 1, #grid[y] do
                local map_char = grid[y][x]
                if map_char == char then
                    table.insert(char_xs[char], x)
                    table.insert(char_ys[char], y)
                end
            end
        end

        if check_in_table(char_xs[char], 1) and check_in_table(char_xs[char], width) then
            slthLog('found wrapping region')
            -- this is a split region, so we want to plot both
            -- first find all plots that are closer to one side or the other
            -- so to find left plots, find all plots that are below width/2
            local left_plots_x = {}
            local left_plots_y = {}
            local right_plots_x = {}
            local right_plots_y = {}
            for i, x in ipairs(char_xs[char]) do
                 if x > width/2 then
                     table.insert(left_plots_x, x)
                     table.insert(left_plots_y, char_ys[char][i])
                 else
                     table.insert(right_plots_x, x)
                     table.insert(right_plots_y, char_ys[char][i])
                 end
            end
            local left_x_centre = calculateCentre(left_plots_x)
            local left_y_centre = calculateCentre(left_plots_y)
            local right_x_centre = calculateCentre(right_plots_x)
            local right_y_centre = calculateCentre(right_plots_y)
            char_centres[char] = {left_x=left_x_centre, left_y=left_y_centre, right_x=right_x_centre , right_y=right_y_centre}
        else
            local x_centre = calculateCentre(char_xs[char])
            local y_centre = calculateCentre(char_ys[char])
            char_centres[char] = {x=x_centre, y=y_centre}
        end
        return char_centres
    end
    if true then
        slthLog('')
    else
        local char_xs = {}
        local char_ys = {}
        local char_centres = {}
        for char, color in pairs(colors) do
            if char ~= -1 then
                char_centres = get_split_centres(char, char_xs, char_ys, char_centres)
            end
        end
        for key, val in pairs(highlighted_regions) do
            char_centres = get_split_centres(key, char_xs, char_ys, char_centres)
        end
        -- mark char_centres issues from world wrap on regions? fixed now
        table.insert(keyParts, '  <!-- centroids -->')
        for char, char_centroid in pairs(char_centres) do
            local fillcol = ''
            if highlighted_regions[char] then
                fillcol = '#000000'
            else
                fillcol = '#FFFFFF'
            end
            if char_centroid['left_x'] then
                local left_centre_x = char_centroid['left_x']
                local left_centre_y = char_centroid['left_y']
                local svg_string = string.format('  <text x="%d" y="%d" fill="%s" font-size="%d">%s</text>',
                        left_centre_x * pixelWidth, left_centre_y * pixelWidth, fillcol,  math.floor(pixelWidth)*2, char)
                table.insert(keyParts, svg_string)

                local right_centre_x = char_centroid['right_x']
                local right_centre_y = char_centroid['right_y']
                svg_string = string.format('  <text x="%d" y="%d" fill="%s" font-size="%d">%s</text>',
                        right_centre_x * pixelWidth, right_centre_y * pixelWidth, fillcol, math.floor(pixelWidth)*2, char)
                table.insert(keyParts, svg_string)
            else
                local centre_x = char_centroid['x']
                local centre_y = char_centroid['y']
                local svg_string = string.format('  <text x="%d" y="%d" fill="%s" font-size="%d">%s</text>',
                        (centre_x) * pixelWidth, centre_y * pixelWidth, fillcol, math.floor(pixelWidth)*2, char)
                table.insert(keyParts, svg_string)
            end
        end
    end

    table.insert(keyParts, '  <!-- Ruler label -->')
    local count = 0
    for i=0, svgWidth, pixelWidth*5 do
        table.insert(keyParts, string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">%s</text>',
                i+pixelWidth, svgHeight+ rulerOffset, math.floor(pixelWidth)*3, count))
        count = count + 5
    end

    count = 0
    for i=0, svgHeight, pixelWidth*5 do
        table.insert(keyParts, string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">%s</text>',
                svgWidth, i+pixelWidth, math.floor(pixelWidth)*3, count))
        count = count + 5
    end

    -- hightlighted region colour specifics
    if rx_data then
        local used_plots = {}
        for key, val in pairs(rx_data) do
            for key_, val_ in pairs(val) do
                slthLog(string.format('for region: %d and plot %s', key, key_))
                local x = val_['x']
                local y = val_['y']
                local reason = val_['failure']
                local colour = '#000000'
                if not used_plots[x .. '/' .. y] then
                    used_plots[x .. '/' .. y] = true
                    if reason == 'FULL_GATE' then
                        colour = '#FFFFFF'                      -- yellow
                        slthLog(string.format('highlighted region plot %d/%d is White as full gate', x, y))
                         local rect = string.format(
                            '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                            ((x-1) * pixelWidth)+pixelWidth, ((y-1) * pixelWidth)+pixelWidth, pixelWidth, pixelWidth, colour
                        )
                        table.insert(keyParts, rect)
                    end
                else
                    slthLog('plot already used!')
                end
            end
        end
    end

    -- Close SVG
    table.insert(keyParts, '</svg>')
    local full =  {table.concat(svgParts, '\n'),  table.concat(keyParts, '\n')}
    return table.concat(full, '\n')
end
--]]
--[[
function saveSVG(content, filename)
    local file = io.open(filename, "w")
    if file then
        file:write(content)
        file:close()
        return true
    else
        return false, "Could not open file for writing"
    end
end
--]]                    -- io not allowed in game

function saveSVG(content, filename)
    return
end

doLog = false
function slthLog(text)
    if doLog then
        print(text)
    end
end

function make_grid(tPlots, use_keys)
    -- iterate over combined string, to make the dict we want
    local squareGrid = {}
    local count = 0
    local row = 1
    squareGrid[row] = {}

    for _, i in ipairs(tPlots) do
        table.insert(squareGrid[row], i)
        count = count + 1
        if count == g_iW then
            count = 0
            row = row + 1
            squareGrid[row] = {}
        end
    end

    return squareGrid
end

-- Helper function to get averaged terrain from neighboring cells
function getAveragedTerrain(grid, x, y, default_val)
    local neighbors = {}
    local directions
    if y % 2 == 1 then          -- Hex grid neighbor directions (odd-r offset)
        directions = {
            {x=0, y=-1},  -- North
            {x=1, y=-1},  -- Northeast
            {x=1, y=0},   -- Southeast
            {x=0, y=1},   -- South
            {x=-1, y=0},  -- Southwest
            {x=-1, y=-1}  -- Northwest
        }
    else
        directions = {
            {x=0, y=-1},  -- North
            {x=1, y=0},   -- Northeast
            {x=1, y=1},   -- Southeast
            {x=0, y=1},   -- South
            {x=-1, y=1},  -- Southwest
            {x=-1, y=0}   -- Northwest
        }
    end
    for _, dir in ipairs(directions) do     -- Collect valid neighboring terrains
        local newX = x + dir.x
        local newY = y + dir.y
        if newX >= 1 and newX <= #grid[1] and
           newY >= 1 and newY <= #grid and
           grid[newY][newX] ~= nil then
            table.insert(neighbors, grid[newY][newX])
        end
    end
    if #neighbors > 0 then  -- Return most common terrain type among neighbors
        local terrainCount = {}
        local maxCount = 0
        local mostCommon = neighbors[1]
        for _, terrain in ipairs(neighbors) do
            terrainCount[terrain] = (terrainCount[terrain] or 0) + 1
            if terrainCount[terrain] > maxCount then
                maxCount = terrainCount[terrain]
                mostCommon = terrain
            end
        end
        return mostCommon
    else
        return "L"      -- Default to flatland if no neighbors found
    end
end

-- Function to create a new hex grid
function createHexGrid(squareGrid, default_filler)
    local height = #squareGrid
    local width = #squareGrid[1]
    -- Create empty hex grid, Hex grid needs different dimensions due to the offset pattern
    local hexWidth = width-- Hex tiles overlap horizontally
    local hexHeight = height                     -- was 3/4 for svg compression afaik, math.ceil(height * 3/4)
    local hexGrid = {}
    for y = 1, hexHeight do
        hexGrid[y] = {}
        for x = 1, hexWidth do
            hexGrid[y][x] = nil
        end
    end
    -- Convert square coordinates to hex coordinates and transfer terrain
    for y = 1, height do
        for x = 1, width do
            -- Convert square coordinates to hex coordinates using offset coordinates (odd-r offset)
            local hexX = x  -- Compress x coordinates
            local hexY = math.ceil(y * 3/4)          -- was less:  math.ceil(y * 3/4)
            if x % 2 == 1 then
                hexY = hexY + 0.5           -- Offset every other row
            end
            hexY = math.floor(hexY + 0.5)       -- Round to nearest hex cell
            if hexX >= 1 and hexX <= hexWidth and hexY >= 1 and hexY <= hexHeight then      -- Ensure coordinates are within bounds
                -- Transfer terrain type
                hexGrid[hexY][hexX] = squareGrid[y][x]
            end
        end
    end
    -- Fill in any gaps with averaged terrain from neighbors
    for y = 1, hexHeight do
        for x = 1, hexWidth do
            if hexGrid[y][x] == nil then
                hexGrid[y][x] = getAveragedTerrain(hexGrid, x, y, default_filler)
            end
        end
    end
    table.remove(hexGrid, #hexGrid)             -- TODO bodge fix here... worth looking into if we are doing weird stuff to get hexes, and if theres a simpler method
    return hexGrid
end

function createHexGridSVG(grid, debug_mode)
    -- Calculate dimensions
    local height = #grid
    local width = 0
    for i = 1, height do
        width = math.max(width, #grid[i])
    end
    -- Predefined symbols remain the same
    local symbols = {
        ["O"] = '#0000FF', -- Blue
        ["P"] = '#FF0000', -- Red
        ["H"] = '#FFFF00', -- Yellow
        ["L"] = '#00FF00', -- Green
    }
    -- Find unique characters (removed char count limitation)
    local uniqueChars = {}
    local charCount = 0
    for y = 1, height do
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if not uniqueChars[char] and not symbols[char] then
                charCount = charCount + 1
                uniqueChars[char] = true
            end
        end
    end
    -- Color generation functions
    local function HSVtoRGB(h, s, v)
        local h_i = math.floor(h * 6)
        local f = h * 6 - h_i
        local p = v * (1 - s)
        local q = v * (1 - f * s)
        local t = v * (1 - (1 - f) * s)

        local r, g, b = 0, 0, 0
        if h_i == 0 then r, g, b = v, t, p
        elseif h_i == 1 then r, g, b = q, v, p
        elseif h_i == 2 then r, g, b = p, v, t
        elseif h_i == 3 then r, g, b = p, q, v
        elseif h_i == 4 then r, g, b = t, p, v
        elseif h_i == 5 then r, g, b = v, p, q
        end

        return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
    end
    -- Function to generate optimized colors for small character sets
    local function generateOptimizedColors(count)
        local colors = {}
        if count <= 64 then
            -- For counts under 64, use distinct hues with optimized saturation and value
            local hueStep = 1.0 / count
            for i = 1, count do
                -- Alternate between high and medium saturation/value for better distinction
                local s = i % 2 == 0 and 1.0 or 0.8
                local v = i % 2 == 0 and 0.9 or 1.0
                local h = (i - 1) * hueStep
                local r, g, b = HSVtoRGB(h, s, v)
                colors[i] = string.format('#%02X%02X%02X', r, g, b)
            end
            return colors
        else
            return nil
        end
    end
    -- Generate color palette based on character count
    local colorPalette = generateOptimizedColors(charCount) or {}
    -- If optimized colors weren't generated, create 256-color palette
    if #colorPalette == 0 then
        for i = 0, 255 do
            local h = (i % 16) / 16
            local s = math.floor(i / 16) % 4 / 3
            local v = math.floor(i / 64) % 4 / 3
            local r, g, b = HSVtoRGB(h, 0.5 + s * 0.5, 0.5 + v * 0.5)
            colorPalette[i + 1] = string.format('#%02X%02X%02X', r, g, b)
        end
    end
    -- Assign colors to characters
    local colors = {}
    local colorIndex = 1
    local colour_string = ""
    for char in pairs(uniqueChars) do
        colors[char] = colorPalette[colorIndex]
        colour_string = colour_string .. string.format('%s = %s |', char, colorPalette[colorIndex])
        colorIndex = (colorIndex % #colorPalette) + 1
    end
    if debug_mode then
        print(colour_string)
    end
    local hexSize = 30  -- Size of hexagon (radius)
    local hexWidth = hexSize * 2
    local hexHeight = hexSize * math.sqrt(3)
    local horizontalSpacing = 3 * hexSize / 2
    local verticalSpacing = hexHeight
    local padding = hexSize * 2
    -- Calculate SVG dimensions with padding
    local svgWidth = width * horizontalSpacing + padding * 2
    local svgHeight = height * verticalSpacing + padding * 2
    local function getHexagonPoints(cx, cy)     -- Function to generate hexagon points
        local points = {}
        for i = 0, 5 do
            local angle = math.pi / 3 * i + math.pi / 6  -- Rotate 30 degrees to point up
            local x = cx + hexSize * math.cos(angle)
            local y = cy + hexSize * math.sin(angle)
            table.insert(points, string.format("%.2f,%.2f", x, y))
        end
        return table.concat(points, " ")
    end
    local svgParts = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %.2f %.2f">', svgWidth, svgHeight),
        '  <!-- Background -->',
        string.format('  <rect width="%.2f" height="%.2f" fill="#1a1a1a"/>', svgWidth, svgHeight)
    }
    for y = 1, height do            -- Add hexagons
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if colors[char] or symbols[char] then
                local colour = symbols[char] or colors[char]
                -- Calculate hex center position
                local cx = padding + x * horizontalSpacing + ((y-1) % 2) * (horizontalSpacing / 2)
                local cy = padding + y * verticalSpacing
                local hexPoints = getHexagonPoints(cx, cy)      -- Create hexagon
                local hex = string.format(
                    '  <polygon points="%s" fill="%s" stroke="#000000" stroke-width="1"/>',
                    hexPoints,
                    colour
                )
                table.insert(svgParts, hex)
                if x == 1 or y == 1 then        -- Add coordinate guides for first row and column
                    local guide
                    if x == 1 then guide = y else guide = x end
                    table.insert(svgParts, string.format(
                        '  <text x="%.2f" y="%.2f" fill="#000000" font-size="%d" text-anchor="middle" dominant-baseline="middle">%s</text>',
                        cx, cy, hexSize/2, guide
                    ))
                end
            end
        end
    end
    -- Add color key (only if there are less than 20 unique characters)
    if charCount < 20 then
        local keyY = svgHeight - 20
        table.insert(svgParts, string.format(
            '  <text x="10" y="%.2f" fill="#FFFFFF" font-size="14">Key: </text>',
            keyY
        ))
        local keyX = 50
        for char, color in pairs(colors) do
            table.insert(svgParts, string.format(
                '  <rect x="%.2f" y="%.2f" width="20" height="20" fill="%s"/>',
                keyX, keyY - 15, color
            ))
            table.insert(svgParts, string.format(
                '  <text x="%.2f" y="%.2f" fill="#FFFFFF" font-size="14">%s</text>',
                keyX + 25, keyY, char
            ))
            keyX = keyX + 60
        end
    end
    table.insert(svgParts, '</svg>')
    return table.concat(svgParts, '\n')
end

function calculateCentre(tbl)
    local sum_total = 0
    for _, y in ipairs(tbl) do
        sum_total = sum_total + y
    end
    local centre = math.floor(sum_total / #tbl)
    return centre
end

------------------- RIVER ----------


function createRiverMap()
    createFlowMap()
    calculateWetAndDry()
    riverMap = {}
    for i=1, ((g_iH + 1) * (g_iW + 1))-1 do                     -- should this be adjusted for python -> lua -1?
        table.insert(riverMap, 0)
    end
    for y=1, g_iH do
        for x=1, g_iW do
            local i = getRiverIndex(x, y)
            local direction = flowMap[i]
            local regionID = getRegion(x, y)
            -- print(string.format('region is %d: %d, %d', regionID, x, y))
            if regionID ~= -1 then
                local region = getRegionByID(regionID)
                local xx = x
                local yy = y
                while direction ~= -1 and direction ~= L do
                    xx = xx + directionXmap[direction]
                    yy = yy + directionYmap[direction]
                    local ii = getRiverIndex(xx, yy)
                    riverMap[ii] = riverMap[ii] + MinRainfall + (1.0 - MinRainfall) * region.moisture
                    direction = flowMap[ii]
                end
            end
        end
    end
end

function createFlowMap()
    -- Start with an outflow from the region, then randomly decide which neighbors
    -- will flow into this square by how many choices that neighbor has. If the
    -- neighbor has only one choice, then the chance is 100 percent. At least
    -- one neighbor must be chosen unless it is not possible, otherwise the
    -- process might end before each tile is set. Then put each chosen neighbor
    -- on the stack to be processed the same way.
    heightMap = {}
    flowMap = {}
    for i=1, ((g_iH + 1) * (g_iW + 1))-1 do
        table.insert(flowMap, -1)
        table.insert(heightMap, -1.0)
    end
    defineGates()
    slthLog("Gates Defined !!!!!!!!!!!!!!!!!!!!!!!!")
    local for_continue = true
    for _, region in ipairs(regionList) do
        if region.isWater then
            slthLog('skipping checking valid gates as water region')
        else
            -- randomly choose an outflow gate
            slthLog("region.gateRegion =", region.gateRegion)
            local validGateList = region:getGateListToNeighbor(region.gateRegion)
            if #validGateList  == 0 then
                print("validGateList == 0!!!!!!!!!!!!!!!!!!!!")
                print("region = %s", str(region))
                local gRegion = getRegionByID(region.gateRegion)
                print("gateRegion = %s", str(gRegion))
                error("region has neighbor but no valid gates. see debug file")
            end
            if #validGateList < 2 then
                slthLog('length of valid gate list is: ', #validGateList)
            end
            slthLog('length of valid gate list is: ', #validGateList)
            local partGatePlot = validGateList[math.random(1, #validGateList)]
            slthLog('part gateplot is')
            slthLog(partGatePlot['x'], partGatePlot['y'])
            region.gatePlot = partGatePlot
            local rxX = region.gatePlot.x
            local rxY = region.gatePlot.y
            local rxI = getRiverIndex(rxX, rxY)
            -- set flow so that it is pointing out of region
            local iterations = 0
            local continuing = true
            while continuing do
                iterations = iterations + 1
                if iterations > 100 then
                    error("endless loop in gate setter")
                end
                local gateRegion = getRegionByID(region.gateRegion)
                if gateRegion.isWater then
                    flowMap[rxI] = L
                    heightMap[rxI] = 0.01
                    continuing = false
                end
                if continuing then
                    -- pick random cardinal direction
                    local direction = math.random(1, 4)
                    --                print direction
                    local xx = rxX + directionXmap[direction]
                    local yy = rxY + directionYmap[direction]
                    if isRxInRegion(xx, yy, region.gateRegion) then
                        flowMap[rxI] = direction
                        heightMap[rxI] = 0.01
                        continuing = false
                    end
                end
            end
        end
    end
    -- Now create heightmap. Start from each gate and increase altitude of
    -- neighbors by a random percentage, and then place each neighbor on a
    -- queue for similar processing. Randomize the queue order for each pass.
    -- This method should avoid lakes.

    -- Place all gates on queue.
    plotList = {}
    PrintRegionList()
    for_continue = true
    for _, region in ipairs(regionList) do
        if for_continue then
            if not region.gatePlot then
                for_continue = false
            else
                local rxX = region.gatePlot.x
                local rxY = region.gatePlot.y
                -- print "rxX=%(x)d, rxY=%(y)d" % {"x":rxX,"y":rxY}
                local riverPlot = {x=rxX, y=rxY, direction=0,  region.ID}
                table.insert(plotList, riverPlot)
            end
        end
    end
    while #plotList > 0 do
        --            print "len plotList = v"
        --            print #plotList
        local count = #plotList
        plotList = ShuffleList(plotList)
        for n=1, count do
            local thisPlot = table.remove(plotList, 1)              -- or 0, unsure
            --                print "popping"
            local rxI = getRiverIndex(thisPlot.x, thisPlot.y)
            local altitude = heightMap[rxI]
            for direction=1, 4 do
                local x = thisPlot.x + directionXmap[direction]
                local y = thisPlot.y + directionYmap[direction]
                local rxII = getRiverIndex(x, y)
                --                    print "rxII=%(i)d, x=%(x)d, y=%(y)d, heightMap=%(h)f, isRxInRegion=%(ir)d" % \
                --                    {"i":rxII,"x":x,"y":y,"h":heightMap[rxII],"ir":isRxInRegion(x,y,thisPlot.regionID)}
                if rxII ~= -1 and heightMap[rxII] == -1.0 and isRxInRegion(x, y, thisPlot.regionID) then
                    local randomScaler = 1.0 + float(PRand.randint(1, 20)) / 100.0
                    heightMap[rxII] = altitude * randomScaler
                    local newPlot = {x=x, y=y, direction=0, regionID=thisPlot.regionID}
                    table.insert(plotList, newPlot)
                end
            end
        end
    end
    local squareGrid = make_grid(regionMap)
    local svgContent = createCharacterImageSVG(squareGrid, failedGateAttempts)
    saveSVG(svgContent, "complete_regions.svg")
    --                        print "newPlot appended"
    -- Create flow map
    for y=1, g_iH do
        for x=1, g_iW do
            local paths = getPossiblePaths(x, y)
            if #paths > 0 then
                local i = getRiverIndex(x, y)
                local pathIndex = math.random(1, #paths)
                flowMap[i] = paths[pathIndex]
            end
        end
    end
end
-- Dryness should be calculated by getting the highest altitude
-- region and making it's base the wettest region. Then eliminate
-- those regions from the list. Then get the highest of the remaining
-- regions and make it's base the dryest region.
function calculateWetAndDry()
    local loc_regionList = {}
    for _, region in ipairs(regionList) do
        table.insert(loc_regionList, region)
    end
    table.sort(loc_regionList, function(a, b)
            return a.altitude > b.altitude
        end)
    local region = loc_regionList[1]
    local wetSpotX, wetSpotY
    while region.altitude > 0 do
        region = getRegionByID(region.gateRegion)
        if region.altitude == 1 then
            wetSpotX, wetSpotY = plotFromRx(region.gatePlot.x, region.gatePlot.y, SW)
        end
    end
    -- Now calculate moisture for each region
    local minMoisture = 1.0
    for _, region in ipairs(regionList) do
        local gate = region.gatePlot
        if gate then
            local distance = math.sqrt(math.abs(((gate.x - wetSpotX) * (gate.x - wetSpotX)) + ((gate.y - wetSpotY) * (gate.y - wetSpotY))))
            region.moisture = 1.0 - distance / g_iW
            minMoisture = math.min(region.moisture, minMoisture)
        end
    end
    local scaler = 1.0 / (1.0 - minMoisture)
    for _, region in ipairs(regionList) do
        region.moisture = (region.moisture - minMoisture) * scaler
    end
end

function defineGates()
    -- Now each region picks one gate that is not in the current gate line
    -- to avoid recursive loops
    local numRegions = #regionList
    local numGatesPlaced = 0
    local iterations = 0
    -- water is considered gated for this purpose
    for i, region in ipairs(regionList) do
        region:defineValidGateList()
        -- regions should always have gates
        slthLog(string.format('checking region %d', region.ID))
        if #(region.gateList) == 0 then
            print(" has no gates!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            -- print(PrintRegionMap(false))
            local squareGrid = make_grid(regionMap)
            local svgContent = createCharacterImageSVG(squareGrid, failedGateAttempts)
            saveSVG(svgContent, "flow_regions.svg")
            error(string.format("region has no gates, got to iter %d", i))
        end
    end
    while numGatesPlaced < numRegions do
        if iterations > 10000 then
            error(string.format("Endless loop occured in gate placement, gates placed: %d, regions: %d", numGatesPlaced, numRegions))
        else
            iterations = iterations + 1
            regionList = ShuffleList(regionList)
            for _, region in ipairs(regionList) do
                if region.gateRegion == -1 then
                    local gatedNeighborList = region:getGatedNeighborList()
                    if #gatedNeighborList > 0 then
                        gatedNeighborList = ShuffleList(gatedNeighborList)
                        region.gateRegion = gatedNeighborList[1]
                        if region.isWater then
                            region.altitude = 0
                        else
                            gateRegion = getRegionByID(region.gateRegion)
                            region.altitude = gateRegion.altitude + 1
                            slthLog(string.format("region %d gateRegion is %d", region.ID, region.gateRegion))
                        end
                        numGatesPlaced = numGatesPlaced + 1
                    else
                        slthLog(string.format("Region %d has no gated neighbors", region.ID))
                    end
                end
            end
        end
    end
end

function isValidHalfGate(regionID, rxX, rxY)
    -- A valid half gate is a rx that is not in a region, touches
    -- only 2 regions and is 4-connected to an rx that is in the region
    local forGatesRegionList = {}
    local key = tostring(regionID) .. '/' .. tostring(rxX) .. '/' .. tostring(rxY)
    if failedGateAttempts[currentRegion] then
        slthLog('region existed alreaedy')
    else
        failedGateAttempts[currentRegion] = {}
    end

    if failedGateAttempts[currentRegion][key] then
        slthLog('region plot existed alreaedy')
    else
        failedGateAttempts[currentRegion][key] = {x=rxX, y=rxY}
    end
    for direction=5, 8 do
        local px, py = plotFromRx(rxX, rxY, direction)
        local i = GetIndex(px, py)
        local pRegID = regionMap[i]
        if not pRegID or pRegID == -1 then
            slthLog(string.format('RX is not valid half gate by cant find region ID or id is -1 for index %d and x/y: %d/%d', i, px, py))
            return false
        end
        if not check_in_table(forGatesRegionList, pRegID) then
            table.insert(forGatesRegionList, pRegID)
            failedGateAttempts[currentRegion][key][direction] = pRegID
        end
    end
    local table_contents = ''
    for _, val in ipairs(forGatesRegionList) do table_contents = table_contents .. ' ' .. val; end
    if #forGatesRegionList ~= 2 then
        slthLog(string.format('RX %d/%d is not valid half gate by not touching 2 regions, instead touching %d regions: %s',rxX, rxY, #forGatesRegionList, table_contents))
        failedGateAttempts[currentRegion][key]['failure'] = 'not_two_gates'
        return false
    end
    if isRxInRegion(rxX, rxY, regionID) then
        slthLog(string.format('RX %d/%d is not valid half gate by RX being in region, but does touch %d regions: %s',rxX, rxY, #forGatesRegionList, table_contents))
        failedGateAttempts[currentRegion][key]['failure'] = 'RX_being_in_region'
        return false
    end
    for direction=1, 4 do
        local xx = rxX + directionXmap[direction]
        local yy = rxY + directionYmap[direction]
        if isRxInRegion(xx, yy, regionID) then
            slthLog(string.format('RX %d/%d is valid half gate by RX being in region, it is not in region, but it touches %d regions: %s',rxX, rxY, #forGatesRegionList, table_contents))
            failedGateAttempts[currentRegion][key]['failure'] = 'success!'
            return true
        end
    end
    slthLog('RX is not valid half gate as RX was not in region in all 4 directions ')
    failedGateAttempts[currentRegion][key]['failure'] = 'RX not in region, and 2 regions adjacent, but every direction did not have an RX in region'
    return false
end

function isValidFullGate(regionID, rxX, rxY)
    if not isValidHalfGate(regionID, rxX, rxY) then
        return false
    end
    slthLog('passed owner region can have gate check')
    local region = getRegionByID(regionID)
    slthLog('neighbours of region count:', #(region.neighborList))
    slthLog(region.neighborList)          -- !! NEIGHBOURLIST WAS EMPTY
    local key = tostring(regionID) .. '/' .. tostring(rxX) .. '/' .. tostring(rxY)
    for _, nRegionID in ipairs(region.neighborList) do
        slthLog('checking valid neighbours....')
        if isValidHalfGate(nRegionID, rxX, rxY) then
            slthLog('other adjacent region has valid gate')
            failedGateAttempts[currentRegion][key]['failure'] = 'FULL_GATE'
            return true
        end
        for direction=1, 4 do
            local xx = rxX + directionXmap[direction]
            local yy = rxY + directionYmap[direction]
            -- local xx, yy = getXYFromDirection(rxX, rxY, direction)          -- TODO this seems wrong to not use them
            if isValidHalfGate(nRegionID, rxX, rxY) then
                slthLog('alternate path valid gate, shouldnt work')
                failedGateAttempts[currentRegion][key]['failure'] = 'FULL_GATE'
                return true
            end
        end
    end
end

function getPossiblePaths(rxX, rxY)
    local possiblePaths = {}
    local regionID = getRegion(rxX, rxY)
    if regionID == -1 then
        return possiblePaths
    end
    local region = getRegionByID(regionID)
    if region.isWater then
        return possiblePaths
    end
    local rxI = getRiverIndex(rxX, rxY)
    local altitude = heightMap[rxI]
    local rejectedDirection = L
    for direction=1, 4 do
        local x = rxX + directionXmap[direction]
        local y = rxY + directionYmap[direction]
        local i = getRiverIndex(x, y)
        if isRxInRegion(x, y, regionID) then
            if heightMap[i] > altitude then
                if rejectedDirection == L then
                    rejectedDirection = getOppositeDirection(direction)
                else
                    rejectedDirection = L
                end
            end
        end
    end

    for direction=1, 4 do
        local x = rxX + directionXmap[direction]
        local y = rxY + directionYmap[direction]
        if isRxInRegion(x, y, regionID) or (x == region.gatePlot.x and y == region.gatePlot.y) then
            local i = getRiverIndex(x, y)
            if i ~= -1 and heightMap[i] < altitude then
            table.insert(possiblePaths, direction)
            end
        end
    end

    if #possiblePaths > 1 then
        for n=1, #possiblePaths do
            if rejectedDirection == possiblePaths[n] then
                -- del possiblePaths[n]
                break
            end
        end
    end

    return possiblePaths
end
function fillInLake(rxX, rxY)
    local rxI = getRiverIndex(rxX, rxY)
    local altitude = heightMap[rxI]
    local regionID = getRegion(rxX, rxY)
    local lowestNeighbor = 1.0
    for direction=1, 4 do
        local x = rxX + directionXmap[direction]
        local y = rxY + directionYmap[direction]
        local i = getRiverIndex(x, y)
        if isRxInRegion(x, y, regionID) then
            if heightMap[i] < lowestNeighbor then
                lowestNeighbor = heightMap[i]
            end
        end
    end
    if altitude < lowestNeighbor then
        heightMap[rxI] = altitude + ((lowestNeighbor - altitude) / 2.0)
    else
        heightMap[rxI] = altitude * 1.05
    end
end
function isLake(rxX, rxY)
    local rxI = getRiverIndex(rxX, rxY)
    local altitude = heightMap[rxI]
    local regionID = getRegion(rxX, rxY)
    local lowestNeighbor = 1.0
    for direction=1, 4 do
        local x = rxX + directionXmap[direction]
        local y = rxY + directionYmap[direction]
        local i = getRiverIndex(x, y)
        if isRxInRegion(x, y, regionID) then
            if heightMap[i] < lowestNeighbor then
                lowestNeighbor = heightMap[i]
            end
        end
    end
    if lowestNeighbor >= altitude then
        return true
    end
end


function isOutFlowGate(rxX, rxY)
    for region in regionList do
        if not region.isWater then
            local gateRxX, gateRxY = rxFromPlot(region.gatePlot.x, region.gatePlot.y, SW)
            if gateRxX == rxX and gateRxY == rxY then
                return true
            end
        end
    end
end

function getOppositeDirection(direction)
    local opposite = L
    if direction == N then
        opposite = S
    elseif direction == S then
        opposite = N
    elseif direction == E then
        opposite = W
    elseif direction == W then
        opposite = E
    end
    return opposite
end

function getRiverIndex(x, y)
    local xx
    local yy
    if x < 0 or x >= g_iW + 1 then
        slthLog('when getting river index, x too small')
        return -1
    else
        xx = x
    end
    if y < 0 or y >= g_iH + 1 then
        slthLog('when getting river index, y too small')
        return -1
    else
        yy = y
    end
    local i = yy * (g_iW + 1) + xx
    slthLog('getting river index: ', i)
    return i
end
function isRxInRegion(x, y, regionID)
    -- Rxs on the border are not in region. All plots touching rx must
    -- be in region
    for direction=5, 8 do
        local xx, yy = plotFromRx(x, y, direction)
        local i = GetIndex(xx, yy)
        if i == -1 or regionMap[i] ~= regionID then
            return false
        end
    end
    return true
end

function getRegion(x, y)
    -- Rxs on the border are not in region. All plots touching rx must
    -- be in region, unless this is the gate for that region
    local xx, yy = plotFromRx(x, y, SW)
    local i = GetIndex(xx, yy)
    local regionID = regionMap[i]
    local invalidRegion = false
    for direction=5, 8 do
        xx, yy = plotFromRx(x, y, direction)
        i = GetIndex(xx, yy)
        local nRegionID = regionMap[i]
        if not nRegionID then
            -- print(string.format('couldnt find region for index %d and %d/%d values', i, xx, yy))
        end
        if nRegionID and nRegionID ~= -1 then                     -- TODO,unsure if checking exists is fine
        -- test if this main plot is gate for this region
            local nRegion = getRegionByID(nRegionID)
            if nRegion.gatePlot and x == nRegion.gatePlot.x and y == nRegion.gatePlot.y then
                return nRegionID
            end
            if nRegionID ~= regionID then
                invalidRegion = true
            end
        end
    end

    if invalidRegion then
        return -1
    end
    if not regionID then
        slthLog(string.format('Couldnt find region ID for %d, %d', x, y))
        return -1
    end
    return regionID
end
function isRxTouchingRegion(x, y, regionID)
    -- Check all four plots
    local plotX, plotY = plotFromRx(x, y, NW)
    local i = GetIndex(plotX, plotY)
    if i and i ~= -1 and regionMap[i] == regionID then
        return true
    end
    plotX, plotY = plotFromRx(x, y, NE)
    i = GetIndex(plotX, plotY)
    if i and i ~= -1 and regionMap[i] == regionID then
        return true
    end
    plotX, plotY = plotFromRx(x, y, SW)
    i = GetIndex(plotX, plotY)
    if i and i ~= -1 and regionMap[i] == regionID then
        return true
    end
    plotX, plotY = plotFromRx(x, y, SE)
    i = GetIndex(plotX, plotY)
    if i and i ~= -1 and regionMap[i] == regionID then
        return true
    end
end

function rxFromPlot(plotX, plotY, direction)
    if direction == SW then
        x = plotX
        y = plotY
    elseif direction == SE then
        x = plotX + 1
        y = plotY
    elseif direction == NW then
        x = plotX
        y = plotY + 1
    else  -- NE
        x = plotX + 1
        y = plotY + 1
    end
    -- check for validity
    if x < 0 or x >= g_iW + 1 then
        return -1, -1
    end
    if y < 0 or y >= g_iH + 1 then
        return -1, -1
    end
    return x, y
end

function PrintFlowMap()
    print("Flow Map")
    local lineString
    for y=g_iH, -1, -1 do
        lineString = ""
        for x=1, g_iW do
            mapLoc = flowMap[getRiverIndex(x, y)]
            if mapLoc == -1 then
                lineString = lineString .. "X"
            elseif mapLoc == N then
                lineString = lineString .. "N"
            elseif mapLoc == S then
                lineString = lineString .. "S"
            elseif mapLoc == E then
                lineString = lineString .. "E"
            elseif mapLoc == W then
                lineString = lineString .. "W"
            else
                lineString = lineString .. "X"
            end
        end
        slthLog(lineString)
    end
end

function getRiverRegionByID(x,y)
    -- Rxs on the border are not in region. All plots touching rx must
    -- be in region, unless this is the gate for that region
    local xx,yy = plotFromRx(x,y, SW)
    local i = GetIndex(xx,yy)
    local regionID = regionMap[i]
    local invalidRegion = false
    for direction=5,8  do
        xx,yy = plotFromRx(x,y,direction)
        i = GetIndex(xx,yy)
        local nRegionID = regionMap[i]
        if nRegionID ~= -1 then
            -- test if this main plot is gate for this region
            local nRegion = getRegionByID(nRegionID)
            if nRegion.gatePlot and x == nRegion.gatePlot.x and y == nRegion.gatePlot.y then
                return nRegionID
            end
            if nRegionID ~= regionID then
                invalidRegion = true
            end
        end
    end
    if invalidRegion then
        return -1
    else
        return regionID
    end
end

function helper_get_gridsize(table_of_tables)
    local count = 0
    local is_nested = true
    for y, x_row in pairs(table_of_tables) do
        if type(x_row) == 'table' then
            for x, val in ipairs(x_row) do
                count = count + 1
            end

        else
            count = count + 1
            is_nested = false
        end
    end
    print('table size is:', count)
    if is_nested then
        print('is nested')
    end
end

---- PLOT MAP -----------
function createPlotMap()
    plotMap = {}
    local scrambledPlotList = {}
    loc_regionList = regionList
    table.sort(loc_regionList, function(a, b)
        return a.altitude > b.altitude
    end)
    highestRegionAltitude = loc_regionList[1].altitude
    local plot_total = 0
    for y=1, g_iH do
        for x=1, g_iW do
            table.insert(plotMap, OCEAN)
            table.insert(scrambledPlotList, {x,y})
            plot_total = plot_total+1
        end
    end
    print('plot_total: ', plot_total)
    scrambledPlotList = ShuffleList(scrambledPlotList)

    -- print('START ; post ocean')
    -- simpleGridPrint(plotMap)
    -- print('STOP')
    slthLog('scrambled plots: ', #scrambledPlotList)
    for n=1, #scrambledPlotList do
        slthLog('n at', n)
        local plot = scrambledPlotList[n]
        local x = plot[1]
        local y = plot[2]
        local i = GetIndex(x,y)
        if shouldPlacePeak(x,y) then
            if plotMap[i] ~= HILLS then
                plotMap[i] = PEAK
            end
        else
            local regionID = regionMap[i]
            local region = getRegionByID(regionID)
            if not region.isWater then
                plotMap[i] = LAND
            end
            placeLandInWater(x,y)
        end
    end

    print('START ; 1_post_land_water_mountain')
    simpleGridPrint(plotMap)
    print('STOP')

    for n=1, #scrambledPlotList do
        local plot = scrambledPlotList[n]
        local x = plot[1]
        local y = plot[2]
        local i = GetIndex(x,y)
        local regionID = regionMap[i]
        if regionID ~= -1 then
            local region = getRegionByID(regionID)
            if region.isWater and plotMap[i] ~= OCEAN then
                for direction=1,4 do
                    local xx = x + directionXmap[direction]
                    local yy = y + directionYmap[direction]
                    local ii = GetIndex(xx,yy)
                    local nRegionID = regionMap[ii]
                    if nRegionID and nRegionID ~= -1 then
                        local nRegion = getRegionByID(nRegionID)
                        if not nRegion.isWater then
                            regionMap[i] = nRegionID
                            break
                        end
                    end
                end
            end
        end
    end


    for n=1, #scrambledPlotList do
        local plot = scrambledPlotList[n]
        local x = plot[1]
        local y = plot[2]
        local i = GetIndex(x,y)
         -- Decide if hill or peak should be here
        if plotMap[i] == LAND then
            local altitude = GetPlotAltitude(x,y)
            local hillChanceRange = HillChanceAtOne - HillChanceAtZero
            local hillChance = HillChanceAtZero + (altitude * hillChanceRange)
            if math.random() < hillChance then                                     -- was PRand.random(). what up to?
                plotMap[i] = HILLS
            end
            local peakChanceRange = PeakChanceAtOne - PeakChanceAtZero
            local peakChance = PeakChanceAtZero + (altitude * peakChanceRange)
            if math.random() < peakChance then
                plotMap[i] = PEAK
            end
            -- now there's a chance to flatten it again!
            if plotMap[i] ~= LAND then
                local riverSize = GetRiverSize(x,y)
                local maxRiverSize = RiverThreshold * RiverFactorFlattensAll
                riverSize = math.min(maxRiverSize,riverSize)
                local flattenChance = riverSize/maxRiverSize
                -- print flattenChance
                if math.random() < flattenChance then
                    plotMap[i] = LAND
                end
            end
        end
        -- now make sure that rivers are not flowing between peaks
        if plotMap[i] == PEAK then
            if shouldFlattenRiverPeak(x,y) then
                local riverSize = GetRiverSize(x,y)
                local maxRiverSize = RiverThreshold * RiverFactorFlattensAll
                if riverSize > maxRiverSize then
                    plotMap[i] = LAND
                else
                    plotMap[i] = HILLS
                end
            end
        end
    end

    print('START ; 2_post_river_peaks')
    simpleGridPrint(plotMap)
    print('STOP')

    -- Now for SoftenPeakPercent of peaks, make them hills
    for y=1,g_iH - 1 do
        for x= 1,g_iW - 1 do
            local i = GetIndex(x,y)
            if plotMap[i] == PEAK then
                if SoftenPeakPercent >= math.random() then
                    plotMap[i] = HILLS
                end
            end
        end
    end

    -- print('START ; post soften peaks')
    -- simpleGridPrint(plotMap)
    -- print('STOP')

    -- Now make sure there are no passable areas that are blocked in
    -- PrintPlotMap()
    local areaMap = AreaMap.new(g_iW, g_iH)
    print(areaMap)
    areaMap:findImpassableAreas()
    -- areaMap:PrintAreaMap()
    for i=1, g_iW*g_iH do
        if areaMap.areaMap[i] == 0 then
            if plotMap[i] ~= PEAK then
                plotMap[i] = PEAK
            else
                areaMap.areaMap[i] = 1
            end
        end
    end

    -- print('START ; post fix impassable areas')
    -- simpleGridPrint(plotMap)
    -- print('STOP')
end

function flattenPeakSubFunc(x, y, rxI, pDir, direction_2, direction_3, direction_2_change, direction_3_change)
    if riverMap[rxI] and riverMap[rxI] > RiverThreshold then            -- again TODO on fail forward with RiverMap finds
        local xx = x + directionXmap[pDir]
        local yy = y + directionYmap[pDir]
        local ii = GetIndex(xx,yy)
        if plotMap[ii] == PEAK then
            return true
        end
        if flowMap[rxI] == direction_2 then
            xx = x + directionXmap[direction_2_change]
            yy = y + directionYmap[direction_2_change]
            ii = GetIndex(xx,yy)
            if plotMap[ii] == PEAK then
                return true
            end
        end
        if flowMap[rxI] == direction_3 then
            xx = x + directionXmap[direction_3_change]
            yy = y + directionYmap[direction_3_change]
            ii = GetIndex(xx,yy)
            if plotMap[ii] == PEAK then
                return true
            end
        end
    end
end

function shouldFlattenRiverPeak(x,y)
    local rxX,rxY = rxFromPlot(x,y,NW)
    local rxI = getRiverIndex(rxX,rxY)
    if flattenPeakSubFunc(x, y, rxI, NW, E, S, N, W) then
        return true
    end
    rxX,rxY = rxFromPlot(x,y,NE)
    rxI = getRiverIndex(rxX,rxY)
    if flattenPeakSubFunc(x, y, rxI, NE, W, S, N, E) then
        return true
    end
    rxX,rxY = rxFromPlot(x,y,SE)
    rxI = getRiverIndex(rxX,rxY)
    if flattenPeakSubFunc(x, y, rxI, SE, W, N, S, E) then
        return true
    end
    rxX,rxY = rxFromPlot(x,y,SW)
    rxI = getRiverIndex(rxX,rxY)
    if flattenPeakSubFunc(x, y, rxI, SW, E, N, S, W) then
        return true
    end
end

function placeLandInWater(x,y)
    local i = GetIndex(x,y)
    local regionID = regionMap[i]
    if regionID == -1 then
        return false
    end
    local region = getRegionByID(regionID)
    local borderPlotIsLand = false
    for direction=1,5 do
        local xx = x + directionXmap[direction]
        local yy = y + directionYmap[direction]
        local ii = GetIndex(xx,yy)
        if ii ~= -1 then
            if plotMap[ii] ~= OCEAN and regionMap[ii] ~= regionID then
                local oceanNeighborTouchingRiver = true
                if IsPlotTouchingRiver(x,y) then
                    oceanNeighborTouchingRiver = false
                    for dir2= 1,5,1 do
                        local xxx = x + directionXmap[dir2]
                        local yyy = y + directionYmap[dir2]
                        local iii = GetIndex(xxx,yyy)
                        if plotMap[iii] == OCEAN and IsPlotTouchingRiver(xxx,yyy) then
                            oceanNeighborTouchingRiver = true
                        end
                    end
                end
                if oceanNeighborTouchingRiver then
                    local oppDirection = OppositeDirections[direction] or L
                    local xxx = x + directionXmap[oppDirection]
                    local yyy = y + directionYmap[oppDirection]
                    if IsPlotSurroundedByOcean(xxx,yyy) then
                        if math.random(0,1) == 0 then
                            local nRegionID = regionMap[ii]
                            if nRegionID and nRegionID ~= -1 then
                                local nRegion = getRegionByID(nRegionID)
                                slthLog("placing land in water")
                                if nRegion.altitude < 2 then
                                    plotMap[i] = LAND
                                elseif nRegion.altitude < 3 and highestRegionAltitude >= 3 then
                                    plotMap[i] = HILLS
                                else
                                    plotMap[i] = PEAK
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

OppositeDirections = {[N]=S, [S]=N, [E]=W, [W]=E, [NW]=SE, [SE]=NW, [SW]=NE, [NE]=SW}

function shouldPlacePeak(x,y)
    local i = GetIndex(x,y)
    local regionID = regionMap[i]
    slthLog('region, x, y:', regionID, x, y)
    if regionID == -1 then
        return true -- Plots without a region are always peaks
    end
    local region = getRegionByID(regionID)
    if region.isWater then
        return false -- Water regions have no peaks
    end
    -- if neighbor in different region not peak, then return true
    for direction = 1, 8, 1 do
        local xx = x + directionXmap[direction]
        local yy = y + directionYmap[direction]
        local ii = GetIndex(xx,yy)
        if ii == -1 then
            return true -- Land plots on map edge are peaks, water handled above
        end
        if plotMap[ii] ~= PEAK then
            local nRegionID = regionMap[ii]
            if nRegionID ~= -1 then
                -- if nRegionID == region.gateRegion then
                local nRegion = getRegionByID(nRegionID)
                if nRegion.isWater and region.altitude < 2 then
                    return false
                elseif nRegion.isWater and region.altitude < 3 and highestRegionAltitude >= 3 then
                    plotMap[i] = HILLS -- Cheating sorta
                    return true
                end
                if nRegionID ~= regionID then
                    return true
                end
            end
        end
    end
end

function IsPlotTouchingRiver(x, y)
    for direction=5, 8 do
        local rxX, rxY = rxFromPlot(x, y, direction)
        local rxI = getRiverIndex(rxX, rxY)
        if riverMap[rxI] and riverMap[rxI] > RiverThreshold then                  -- TODO this may cause fail throughs as rivers should be gettable
            return true
        end
    end
end

function IsPlotSurroundedByOcean(x, y)
    for direction=1, 8 do
        local xx = x + directionXmap[direction]
        local yy = y + directionYmap[direction]
        local i = GetIndex(xx, yy)
        if plotMap[i] ~= OCEAN then
            return false
        end
    end
    return true
end

function GetPlotAltitude(x, y)
    -- calculate highest region altitude if necessary and save it for later
    local loc_regionList = regionList
    if highestRegionAltitude == 0 then
        table.sort(loc_regionList, function(a, b)
            return a.altitude > b.altitude
        end)
        local highestRegionAltitude = loc_regionList[1].altitude
    end
    local i = GetIndex(x, y)
    local regionID = regionMap[i]
    if regionID == -1 then
        return -1.0
    end
    local region = getRegionByID(regionID)
    ----    print "GetPlotAltitude"
    local regionAlt = (region.altitude + 1) / (highestRegionAltitude + 1)
    ----    print "regionAlt = %(ra)f" % {"ra":regionAlt}
    local riverAltRange = RiverAltRangeFactor * RiverThreshold
    local riverSize = GetRiverSize(x, y)
    if riverSize > riverAltRange then
        riverSize = riverAltRange
    end----    print "riverSize = %(r)f" % {"r":riverSize}
    local riverSubtract = riverSize * ((RiverAltitudeSubtraction / riverAltRange) / (highestRegionAltitude + 1))
    ----    print "riverSubtract = %(rs)f" % {"rs":riverSubtract}
    local altitude = regionAlt - riverSubtract
    ----    print "altitude = %(a)f" % {"a":altitude}
    ----    print ""
    return altitude
end

function GetRiverSize(x, y)
    local riverAverage = 0.0
    for direction=5, 8 do
        local rxX, rxY = rxFromPlot(x, y, direction)
        local rxI = getRiverIndex(rxX, rxY)
        local riverVal = riverMap[rxI] or 0
        riverAverage = riverAverage + riverVal             -- sometimes we arent getting these
    end
    riverAverage = riverAverage / 4.0
    return riverAverage
end

function PrintPlotMap()
    local combined = ''
    local out_plots = {}
    local symbols = {
                [OCEAN] = "O",
                [PEAK] = "P",
                [HILLS] = "H",
                [LAND] = "L"
            }
    local lostSymbols = {}          -- 0, 3, nil
    for y = g_iH - 1, 0, -1 do
        local lineString = ""
        for x = 0, g_iW - 1 do
            local mapLoc = plotMap[GetIndex(x, y)]
            if not symbols[mapLoc] and not lostSymbols[mapLoc] and mapLoc then
                lostSymbols[mapLoc] = true
            end
            out_plots[GetIndex(x, y)] =  symbols[mapLoc] or " "             -- this probably causes pain downstream
            lineString = lineString .. (symbols[mapLoc] or " ")
        end
        if bShowMap then
            slthLog(lineString)
        end
        combined = combined .. lineString .. '\n'
    end
    return combined, out_plots
end

AreaMap = {}
AreaMap.__index = AreaMap
function AreaMap.new(width, height)
    local self = setmetatable({}, AreaMap)
    self.mapWidth = width
    self.mapHeight = height
    self.areaMap ={}
    for i=0, self.mapHeight * self.mapWidth do              -- 0 seems fine here, as its just inserts indexing
        table.insert(self.areaMap, 0)                -- initialize map with zeros
    end
    return self
end

function AreaMap:findImpassableAreas()
    --        self.areaSizes = array('i')
    ----        starttime = time.clock()
    -- make sure map is erased in case it is used multiple times
    for i=0, self.mapHeight * self.mapWidth do
        self.areaMap[i] = 0
    end
    --        for i in range(0,1):
    for i=0, self.mapHeight * self.mapWidth do
        if plotMap[i] == OCEAN then  -- not assigned to an area yet
            areaSize = self:fillArea(i, 1)
    ----        endtime = time.clock()
    ----        elapsed = endtime - starttime
    ----        print "defineAreas time ="
    ----        print elapsed
    ----        print()
        end
    end
end
function AreaMap:findChokePointAreas()
    -- fill water and peaks with non-zero value
    for i=0, self.mapHeight * self.mapWidth do
        gamePlot = gameMap.plotByIndex(i)
        if gamePlot.isWater() then
            self.areaMap[i] = -1
        elseif gamePlot.isImpassable() then
            self.areaMap[i] = -3
        end
    end

    self.areaList = {}
    table.insert(self.areaList, -1)  -- placeholder to avoid using a zero index
    local areaID = 0
    for i=0, self.mapHeight * self.mapWidth do
        if self.areaMap[i] == 0 then
            areaID = areaID + 1
            local areaSize = self:fillArea(i, areaID)
            --                print "areaID = %(id)d, size = %(s)d" % {"id":areaID,"s":areaSize}
            table.insert(self.areaList, areaSize)
        end
    end
end

function AreaMap:fillArea(index, areaID)
    -- first divide index into x and y
    local y = index / self.mapWidth
    local x = index % self.mapWidth
    -- We check 8 neigbors for land,but 4 for water. This is because
    -- the game connects land squares diagonally across water, but
    -- water squares are not passable diagonally across land
    self.segStack = {}
    self.size = 0
    -- place seed on stack for both directions
    local seg = {y=y, xLeft=x, xRight=x, dy=1}
    table.insert(self.segStack, seg)
    seg = {y=y + 1, xLeft=x, xRight=x, dy=-1}
    table.insert(self.segStack, seg)
    while #self.segStack > 0 do
        seg = table.remove(self.segStack)
        self:scanAndFillLine(seg, areaID)
    end
    return self.size
end

function AreaMap:scanAndFillLine(seg, areaID)
    -- check for y + dy being off map
    local i = GetIndex(seg['xLeft'], seg['y'] + seg['dy'])
    if i < 0 then
        ----            print "scanLine off map ignoring",str(seg)
        return
    end
    local debugReport = false
    ----        if (seg['y'] < 8 and seg['y'] > 4) or (seg['y'] < 70 and seg['y'] > 64) then
    ----        if (areaID == 4) then
    ----            debugReport = true
    -- landOffset = 1 for 8 connected neighbors, 0 for 4 connected neighbors
    local landOffset = 1
    local lineFound = false
    -- first scan and fill any left overhang
    if debugReport then
        print('')
        print(seg)
        print("Going left")
    end
    local xLeftExtreme
    for xLeftExtremeLoc=seg['xLeft'] - landOffset, -1, -1 do
        xLeftExtreme = xLeftExtremeLoc
        i = GetIndex(xLeftExtreme, seg['y'] + seg['dy'])
        if debugReport then
            print("xLeftExtreme = %d", xLeftExtreme)
        end
        if self.areaMap[i] == 0 and plotMap[i] ~= PEAK then
            self.areaMap[i] = areaID
            self.size = self.size + 1
            lineFound = true
        else
            -- if no line was found, then xLeftExtreme is fine, but if
            -- a line was found going left, then we need to increment
            -- xLeftExtreme to represent the inclusive end of the line
            if lineFound then
                xLeftExtreme = xLeftExtreme + 1
            end
            break
        end
    end
    if debugReport then
        print("xLeftExtreme finally = %d",xLeftExtreme)
        print("Going Right")
    end
    -- now scan right to find extreme right, place each found segment on stack
    --        xRightExtreme = seg['xLeft'] - landOffset --needed sometimes? one time it was not initialized before use.
    local xRightExtreme
    for xRightExtreme_loc=seg['xLeft'], self.mapWidth, 1 do
        xRightExtreme = xRightExtreme_loc
        if debugReport then
            print("xRightExtreme = %d", xRightExtreme)
        end
        i = GetIndex(xRightExtreme, seg['y'] + seg['dy'])
        if self.areaMap[i] == 0 and plotMap[i] ~= PEAK then
            self.areaMap[i] = areaID
            self.size = self.size + 1
            if lineFound == false then
                lineFound = true
                xLeftExtreme = xRightExtreme  -- starting new line
                if debugReport then
                    print("starting new line at xLeftExtreme= %d", xLeftExtreme)
                end
            end
        elseif lineFound == true then  -- found the right end of a line segment!
            lineFound = false
            -- put same direction on stack
            newSeg = {y=seg['y'] + seg['dy'], xLeft=xLeftExtreme, xRight=xRightExtreme - 1, dy=seg['dy']}
            table.insert(self.segStack, newSeg)
            if debugReport then
                print("same direction to stack", newSeg)
            end
            -- determine if we must put reverse direction on stack
            if xLeftExtreme < seg['xLeft'] or xRightExtreme >= seg['xRight'] then
                -- out of shadow so put reverse direction on stack also
                local newSeg = {y=seg['y'] + seg['dy'], xLeft=xLeftExtreme, xRight=xRightExtreme - 1, dy=-seg['dy']}
                table.insert(self.segStack, newSeg)
                if debugReport then
                    print("opposite direction to stack", newSeg)
                end
            end
            if xRightExtreme >= seg['xRight'] + landOffset then
                if debugReport then
                    print("finished with line")
                end
                break;  -- past the end of the parent line and this line ends
            end
        elseif lineFound == false and xRightExtreme >= seg['xRight'] + landOffset then
            if debugReport then
                print("no additional lines found")
            end
            break;  -- past the end of the parent line and no line found
        -- else                                                                 -- this clause does nothing
        --     continue  -- keep looking for more line segments
        end
    end
    if lineFound == true then  -- still a line needing to be put on stack
        if debugReport then
            print("still needing to stack some segs")
        end
        lineFound = false
        -- put same direction on stack
        local newSeg = {y=seg['y'] + seg['dy'], xLeft=xLeftExtreme, xRight=xRightExtreme - 1, dy=seg['dy']}
        table.insert(self.segStack, newSeg)
        if debugReport then
            print(newSeg)
        end
        -- determine if we must put reverse direction on stack
        if xLeftExtreme < seg['xLeft'] or xRightExtreme - 1 > seg['xRight'] then
            -- out of shadow so put reverse direction on stack also
            newSeg = {y=seg['y'] + seg['dy'], xLeft=xLeftExtreme, xRight=xRightExtreme - 1, dy=-seg['dy']}
            table.insert(self.segStack, newSeg)
            if debugReport then
                print(newSeg)
            end
        end
    end
end


-- for debugging
function AreaMap:PrintAreaMap()
    print("Area Map")
    for y=self.mapHeight - 1, -1, -1 do
        local lineString = ""
        for x=1, self.mapWidth do
            local mapLoc = self.areaMap[GetIndex(x, y)]
            if mapLoc > 0 then
                if mapLoc + 34 > 127 then
                    mapLoc = 127 - 34
                end
                lineString = lineString + chr(mapLoc + 34)
            ----                    if self.areaList[mapLoc] > ChokePointAreaSize then
            ----                        lineString = lineString +"*"
            ----                    else:
            ----                        lineString = lineString +"+"
            elseif mapLoc == 0 then
                lineString = lineString +"!"
            elseif mapLoc == -1 then
                lineString = lineString +"."
            elseif mapLoc == -2 then
                lineString = lineString +"X"
            elseif mapLoc == -3 then
                lineString = lineString +"^"
            end
        end
        lineString = lineString +"-" + str(y)
        print(lineString)
    end
    print(" ")
end

-- TERRAIN --
function createTerrainMap()
    DESERT = 0
    PLAINS = 1
    ICE = 2
    TUNDRA = 3
    GRASS = 4
    HILL = 5
    COAST = 6
    OCEAN_TERRAIN = 7
    PEAK_TERRAIN = 8
    MARSH = 9
    terrainMap = {}
    --  initialize terrainMap with OCEAN
    for i=0, g_iH * g_iW do
        table.insert(terrainMap, OCEAN_TERRAIN)
    end
    for y=1, g_iH do
        for x=1, g_iW do
            local i = GetIndex(x, y)
            if plotMap[i] ~= OCEAN then
                terrainMap[i] = GRASS
            else
                for direction=1, 8 do
                    local xx = x + directionXmap[direction]
                    local yy = y + directionYmap[direction]
                    local ii = GetIndex(xx, yy)
                    if ii ~= -1 and plotMap[ii] ~= OCEAN then
                        terrainMap[i] = COAST
                    end
                end
            end
        end
    end
    print('START ; 3_post_terrain_init_ocean')
    simpleGridPrint(terrainMap)
    print('STOP')

    for y=1, g_iH-1 do
        for x=1, g_iW-1 do
            local i = GetIndex(x, y)
            if plotMap[i] ~= OCEAN then
                slthLog('doing x/y', x, y)
                local rainFall = GetRainfall(x, y)
                if rainFall < DesertThreshold then
                    if rainFall < ((math.random() * DesertThreshold) / 2.0) + (DesertThreshold / 2.0) then
                        terrainMap[i] = DESERT
                    else
                        terrainMap[i] = PLAINS
                    end
                elseif rainFall < PlainsThreshold then
                    if rainFall < ((math.random() * (
                            PlainsThreshold - DesertThreshold)) / 2.0) + DesertThreshold + (
                            (PlainsThreshold - DesertThreshold) / 2.0) then
                        terrainMap[i] = PLAINS
                    else
                        terrainMap[i] = GRASS
                    end
                else
                    terrainMap[i] = GRASS
                end
                local altitude = GetPlotAltitude(x, y)
                if altitude > IceThreshold then
                    terrainMap[i] = ICE
                elseif altitude > TundraThreshold then
                    terrainMap[i] = TUNDRA
                elseif altitude > MaxDesertAltitude and terrainMap[i] == DESERT then
                    terrainMap[i] = PLAINS
                end
            end
        end
    end

    print('START ; 4_post terrain biome')
    simpleGridPrint(terrainMap)
    print('STOP')
    -- clean up desert peaks to avoid burning peaks all over the map
    for y=1,g_iH -1 do
        for x=1, g_iW-1 do
            local i = GetIndex(x, y)
            if plotMap[i] == PEAK then
                terrainMap[i] = TUNDRA
                for direction=1, 8 do
                    local xx = x + directionXmap[direction]
                    local yy = y + directionYmap[direction]
                    local ii = GetIndex(xx, yy)
                    if plotMap[ii] ~= PEAK and plotMap[ii] ~= OCEAN then
                        terrainMap[i] = terrainMap[ii]
                        break
                    end
                end
            end
        end
    end
    print('START ; 5_post cleanup desert mountains')
    simpleGridPrint(terrainMap)
    print('STOP')

    print('START ; 6_post terrain gen PLOTS')
    simpleGridPrint(plotMap)
    print('STOP')
end

function GetRainfall(x, y)
    local rainfall = 0
    local i = GetIndex(x, y)
    local regionID = regionMap[i]
    if regionID ~= -1 then
        local region = getRegionByID(regionID)
        rainfall = region.moisture
        slthLog(regionID)
        local riverSize = GetRiverSize(x, y)
        local riverSizeMax = RiverThreshold * RiverAddsMoistureMax
        riverSize = math.min(riverSize, riverSizeMax)
        rainfall = rainfall + (riverSize / riverSizeMax) * RiverAddsMoistureRange
    end
    return rainfall
end

function check_regions()
    local missed_region
    print('---- did regions all exist')
    for x=1, g_iW do
        for y=1, g_iH do
            local i = GetIndex(x,y)
            local regionID = regionMap[i]
            if not regionID then
                print(string.format('%d, %d: no region, index was %d', x, y, i))
                missed_region = true
            end
        end
    end
    if missed_region then
        print('ending check regions, REGIONS DONT EXIST')
    else
        print('ending check regions, all accounted for')
    end
end

function check_rx()
    for x=1, g_iW do
        for y=1, g_iH do
            local i = GetRxIndex(x, y)
            local regionID = regionRxMap[i]
            if not regionID then
                print(string.format('%d, %d: no region', x, y))
            end
        end
    end
end

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
     ['5'] = g_TERRAIN_TYPE_GRASS_HILLS,                     -- TODO need to deal with this just being hills..
     ['6'] = g_TERRAIN_TYPE_COAST,
     ['7'] = g_TERRAIN_TYPE_OCEAN,
     ['8'] = g_TERRAIN_TYPE_GRASS_MOUNTAIN,            -- TODO need a fallback for mountain type
     ['9'] = g_TERRAIN_TYPE_GRASS               -- was marsh
}
-- ENTRY POINT
function GenerateMap()
    -- g_iW, g_iH = 84, 52
    g_iW, g_iH = Map.GetGridSize();
    print('map size', g_iW, g_iH)
    g_iFlags = TerrainBuilder.GetFractalFlags();
	local temperature = MapConfiguration.GetValue("temperature"); -- Default setting is Temperate.
	if temperature == 4 then
		temperature  =  1 + TerrainBuilder.GetRandomNumber(3, "Random Temperature- Lua");
	end

	--	local world_age
	local world_age = MapConfiguration.GetValue("world_age");
	if (world_age == 1) then
		world_age = world_age_new;
	elseif (world_age == 2) then
		world_age = world_age_normal;
	elseif (world_age == 3) then
		world_age = world_age_old;
	else
		world_age = 2 + TerrainBuilder.GetRandomNumber(4, "Random World Age - Lua");
	end

    currentRegion = -99
    local success = false
    river_map_attempts = 0
    while not success and river_map_attempts < 2 do
        success, result = pcall(function()
            createRegions()
            print('START ;reg_map_1_final_regionmap')
            final_reg_map = PrintRegionMap()
            print('STOP')
            print('reg map')
            print(final_reg_map)
            -- PrintRegionList()
            print('reg map water')
             print('START ; reg_map_1_final_regionmap_no_water')
            region_plots = PrintRegionMap(true)
            print('STOP')
            print(region_plots)

            squareGrid = make_grid(regionMap)
            local svgContent = createCharacterImageSVG(squareGrid)
            saveSVG(svgContent, "rewrite_regions.svg")
            failedGateAttempts = {}
            createRiverMap()
        end)
        river_map_attempts = river_map_attempts + 1
        print('--------------------------- river attempt finished -----------------------\n\n\n\n\n\n\n\n\n')
    end
    if not success then
        error(result)
    end
    river_plots = PrintFlowMap()

    createPlotMap()
    createTerrainMap()
    combined, out_plots = PrintPlotMap()
    local squareGrid_plot_Types = make_grid(out_plots)
    local hexGrid_plot_Types = createHexGrid(squareGrid_plot_Types, "L")                -- DOES AWFU THINGS REDO

    print('START ; 7_square grid plots')
    list_o_lists_GridPrint(squareGrid_plot_Types)
    print('STOP')

    local svgContent = createCharacterImageSVG(squareGrid_plot_Types, nil, nil)
    saveSVG(svgContent, "output.svg")
    local terrainMap_out_plots = {}
    for y = g_iH - 1, 0, -1 do
        local lineString = ""
        for x = 0, g_iW - 1 do
            local mapLoc = tostring(terrainMap[GetIndex(x, y)])
            -- print(mapLoc)
            terrainMap_out_plots[GetIndex(x, y)] =  mapLoc
        end
    end
    local squareGrid_Terrain_Types = make_grid(terrainMap_out_plots)
    -- print('square grid dimensions:', #squareGrid_Terrain_Types, #(squareGrid_Terrain_Types[5]))
    local hexGrid_Terrain_Types = createHexGrid(squareGrid_Terrain_Types, g_TERRAIN_TYPE_GRASS)
    local svgContent = createHexGridSVG(squareGrid_Terrain_Types)
    saveSVG(svgContent, "output_hex.svg")
    plotTypes = ConvertToFiraxisFormSimple(out_plots, plotErebusFxsMapper)
    terrainTypes = ConvertToFiraxisFormSimple(terrainMap_out_plots, terrainErebusFxsMapper)
    ApplyTerrain(plotTypes, terrainTypes);

	-- Temp
	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();
	TerrainBuilder.StampContinents();

	local iContinentBoundaryPlots = GetContinentBoundaryPlotCount(g_iW, g_iH);
	local biggest_area = Areas.FindBiggestArea(false);
	print("After Adding Hills: ", biggest_area:GetPlotCount());
	-- AddTerrainFromContinents(plotTypes, terrainTypes, world_age, g_iW, g_iH, iContinentBoundaryPlots);

	AreaBuilder.Recalculate();

	-- River generation is affected by plot types, originating from highlands and preferring to traverse lowlands.
	AddRivers();

	-- Lakes would interfere with rivers, causing them to stop and not reach the ocean, if placed any sooner.
	local numLargeLakes = GameInfo.Maps[Map.GetMapSize()].Continents;
	AddLakes(numLargeLakes);

	AddFeatures();
	TerrainBuilder.AnalyzeChokepoints();

	print("Adding cliffs");
	AddCliffs(plotTypes, terrainTypes);

	local args = {
		numberToPlace = GameInfo.Maps[Map.GetMapSize()].NumNaturalWonders,
	};
	local nwGen = NaturalWonderGenerator.Create(args);

	AddFeaturesFromContinents();
	MarkCoastalLowlands();

    do_ascii(plotTypes, terrainTypes, true, 'RESULT')

	resourcesConfig = MapConfiguration.GetValue("resources");
	local startConfig = MapConfiguration.GetValue("start");-- Get the start config
	local args = {
		resources = resourcesConfig,
		START_CONFIG = startConfig,
	};
	local resGen = ResourceGenerator.Create(args);

	print("Creating start plot database.");

	-- START_MIN_Y and START_MAX_Y is the percent of the map ignored for major civs' starting positions.
	local args = {
		MIN_MAJOR_CIV_FERTILITY = 150,
		MIN_MINOR_CIV_FERTILITY = 50,
		MIN_BARBARIAN_FERTILITY = 1,
		START_MIN_Y = 15,
		START_MAX_Y = 15,
		START_CONFIG = startConfig,
	};
	local start_plot_database = AssignStartingPlots.Create(args)

	local GoodyGen = AddGoodies(g_iW, g_iH);

    do_ascii(plotTypes, terrainTypes, true, 'FINAL RESULT', true)

end

-- copied from inland sea
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

	return {Width = Width, Height = Height, WrapX = WrapX, WrapY=WrapY}
end

-- from firaxis continents
function ApplyTerrain(plotTypes, terrainTypes)
    print((g_iW * g_iH) - 1)
    print(' final number above. length of terrainTypes and plotTypes is: ' .. #terrainTypes .. ', ' .. #plotTypes)
	for i = 1, (g_iW * g_iH) - 1, 1 do
		local pPlot = Map.GetPlotByIndex(i);
		if (plotTypes[i] == g_PLOT_TYPE_HILLS) then
			terrainTypes[i] = terrainTypes[i] + 1;
        elseif (plotTypes[i] == g_PLOT_TYPE_MOUNTAIN)  then
            terrainTypes[i] = terrainTypes[i] + 2;
		end
        if terrainTypes[i] then
            TerrainBuilder.SetTerrainType(pPlot, terrainTypes[i]);
        else
            print('TRIED TO GET plot index ' .. i .. ' but did not exist or was NIL')
        end
	end
end


function ConvertToFiraxisForm(erebus_hex_grid, mapper)
    local plotTypes = {}
    print('printing hex shape')
    for y, x_row in pairs(erebus_hex_grid) do
        for x, plot_val in pairs(x_row) do
            local converted_val = mapper[plot_val]
            if converted_val then
                table.insert(plotTypes, converted_val)
            else
                print('ERROR: MAPPER COULDNT FIND CONVERSION FOR ITEM: $' .. plot_val .. '$ WITH COORDINATES: ' .. x .. ', ' .. y)
                print('inserting grass instead: ' .. g_TERRAIN_TYPE_GRASS)
                table.insert(plotTypes, g_TERRAIN_TYPE_GRASS)
            end
        end
    end
    return plotTypes
end

function ConvertToFiraxisFormSimple(erebus_hex_grid, mapper)
    local loc_plotTypes = {}
    print('printing hex shape')
    for idx, plot_info in pairs(erebus_hex_grid) do
        local converted_val = mapper[plot_info]
        if converted_val then
            table.insert(loc_plotTypes, converted_val)
        else
            print('ERROR: MAPPER COULDNT FIND CONVERSION FOR ITEM: $' .. plot_info .. '$ WITH index: ' .. idx)
            print('inserting grass instead: ' .. g_TERRAIN_TYPE_GRASS)
            table.insert(loc_plotTypes, g_TERRAIN_TYPE_GRASS)
        end
    end
    return loc_plotTypes
end

function FeatureGenerator:AddIceToMap()
    return
end

function AddFeatures()
	print("Adding Features");

	-- Get Rainfall setting input by user.
	local rainfall = MapConfiguration.GetValue("rainfall");
	if rainfall == 4 then
		rainfall = 1 + TerrainBuilder.GetRandomNumber(3, "Random Rainfall - Lua");
	end

	local args = {rainfall = rainfall}
	featuregen = FeatureGenerator.Create(args);
	featuregen:AddFeatures(true, true);  --second parameter is whether or not rivers start inland);
end

function AddFeaturesFromContinents()
	featuregen:AddFeaturesFromContinents();
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

    print('plot types, length:', #plot_ascii_list)
    print('START; '.. 'plotTypes' .. text)
    for _, i in ipairs(plot_ascii_list) do
        print(i)
    end
    print('STOP')
    print('terrain, length:', #terrain_ascii_list)
    print('START; '.. 'terrainTypes' .. text)
    for _, i in ipairs(terrain_ascii_list) do
        print(i)
    end
    print('STOP')
    print('features')
    print('START; '.. 'featureTypes' .. text)
    for _, i in ipairs(feature_ascii_list) do
        print(i)
    end
    print('STOP')
end

function simpleGridPrint(tbl)
    local count = 0
    local x_string = ''
    for i, val in pairs(tbl) do
        if count == g_iW then
            count = 0
            print(x_string)
            x_string = ''
        end
        count = count + 1
        x_string = x_string .. val
	end
end

function list_o_lists_GridPrint(tbl)
    local count = 0
    for y, x_row in pairs(tbl) do
        local x_string = ''
        for x, val in pairs(x_row) do
            x_string = x_string .. val
        end
        print(x_string)
        x_string = ''
	end
end

local terrainColorMapper = {
     ['0'] = '#FFFF00', -- YELLA
     ['1'] = '#964B00',                 -- BROWN
     ['2'] =  '#FFFFFF',                   -- WHITE
     ['3'] = '#AAAAAA',                 -- GREY
     ['4'] = '#00FF00',                  -- GREEN, GRASS
     ['5'] =  '#A020F0',                     -- UHH HILLS PURPLE
     ['6'] = '#ADD8E6',                     -- LIGHT BLUE
     ['7'] = '#0000FF',              -- BLUE, OCEAN_TERRAIN
     ['8'] = '#FF0000',            -- RED
     ['9'] = '#006400'               -- dark green
        }

local keyMapper = {
     ['0'] = 'DESERT',
     ['1'] = 'PLAINS',                 -- BROWN
     ['2'] =  'ICE',                   -- WHITE
     ['3'] = 'TUNDRA',                 -- GREY
     ['4'] = 'GRASS',                  -- GREEN, GRASS
     ['5'] =  'HILL',                     -- UHH HILLS PURPLE
     ['6'] = 'COAST',                     -- LIGHT BLUE
     ['7'] = 'OCEAN_TERRAIN',              -- BLUE, OCEAN_TERRAIN
     ['8'] = 'PEAK_TERRAIN',            -- RED
     ['9'] = 'MARSH'               -- dark green
}

local svgContent = createCharacterImageSVG(squareGrid, nil, nil, terrainColorMapper, keyMapper)
saveSVG(svgContent, "output_terrain.svg")
