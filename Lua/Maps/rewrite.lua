UsePythonRandom = true
-- This variable turns on things that only make sense with Fall from Heaven 2
FFHSpecific = true

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

-- The type of trees are controlled by altitude. Snowy trees use TundraThreshold.
-- Lower than leafy is Jungle.
LeafyAltitude = .30
EvergreenAltitude = .60

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

--[[
g_iW, g_iH = Map.GetGridSize();
g_iFlags = TerrainBuilder.GetFractalFlags();
local temperature = MapConfiguration.GetValue("temperature"); -- Default setting is Temperate.
if temperature == 4 then
    temperature  =  1 + TerrainBuilder.GetRandomNumber(3, "Random Temperature- Lua");
end
 ]]

g_iW, g_iH = 84, 52
local temperate = 4


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
highestRegionAltitude = 0

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

function createRegions(self)
    --Growing the regions directly according to the map size created
    --unsolvable problems for the river system. Instead, I am growing
    --on a map (regionRxMap) that corresponds to rivers rather than
    --map tiles. This ensures rivers have a path from region to
    --region.

    -- globals
    numTiles = g_iW * g_iH
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
    print('number of regions: ', numRegions)
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
                    local xx, yy = getXYFromDirection(seedX, seedY, direction)
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
    print('-- STABLE', #regionPlotList)
    while #regionPlotList > 0 do
        iterations = iterations + 1
        if iterations > 200000 then
            PrintRegionRxMap(false)
            error("endless loop in region growth")
        end
        local plot = regionPlotList[1]
        if not plot then
            print('--- TABLE ---')
            print_table(regionPlotList)
            print(#regionPlotList)
            print('-- STABLE')
        end
        local region = getRegionByID(plot.regionId)
        if region.isGrowing then
            local roomLeft = false
            for direction = 1, 5 do
                local xx, yy = getXYFromDirection(plot.x, plot.y, direction)
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
    for y=1, g_iH + 1 do
        for x=1, g_iW + 1 do
            local i = GetRxIndex(x, y)
            local regionID = regionRxMap[i]
            if regionID and regionID ~= -1 then
                local region = getRegionByID(regionID)
                for direction= 5, 9 do
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
            for direction=1, 5 do
                local xx, yy = GetDirection(direction, plot)
                local ii = GetIndex(xx, yy)
                if ii ~= -1 and regionMap[ii] ~= -1 and regionMap[ii] ~= region.ID then
                    plot.bBorder = true
                    plot.bEdge = true
                    if check_in_table(region.neighborList, regionMap[ii])  then
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
    print(string.format("numTiles = %d, numWaterRegions = %d", numTiles, numWaterRegions))
    for i, region in ipairs(regionList) do print(i, region.ID); end
    print('first shuffle')
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
    for i=1, numWaterRegions do
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
    print('fill water')
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
    for direction=1, 9 do
        local xx, yy = getXYFromDirection(x, y, direction)
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
    local x, y
    if direction == NE then
        x = rxX
        y = rxY
    elseif direction == NW then
        x = rxX - 1
        y = rxY
    elseif direction == SE then
        x = rxX
        y = rxY - 1
    else                  --SW
        x = rxX - 1
        y = rxY - 1
    end
    --check for validity
    if x < 0 or x >= g_iW then
        return -1, -1
    end
    if y < 0 or y >= g_iH then
        return -1, -1
    end
    return x, y
end
function getXYFromDirection(x, y, direction)
    local xx = x
    local yy = y
    if direction == N then
        yy = yy + 1
    elseif direction == S then
        yy = yy -1
    elseif direction == E then
        xx = xx + 1
    elseif direction == W then
        xx = xx - 1
    elseif direction == NW then
        yy = yy + 1
        xx = xx - 1
    elseif direction == NE then
        yy = yy + 1
        xx = xx + 1
    elseif direction == SW then
        yy = yy - 1
        xx = xx - 1
    elseif direction == SE then
        yy = yy - 1
        xx = xx + 1
    end
    return xx, yy
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
    print("Number of regions:", #regionList)
    for i, region in ipairs(regionList) do
        print(region.ID)
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
    local str_ = string.format("ID=%dd(%ds), size=%dd, altitude=%dd \n", self.ID, RegionCharMap[self.ID],len(self.plotList),self.altitude)
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
        local region = regMap.getRegionByID(regionID)
        if region.isWater == true then
            count = count + 1
        end
    end
    return count
end

function Region:getBorderPlotList(neighborID)
    local borderPlotList = list()
    local borderPlotCount = 0
    for plot in self.plotList do
        if plot.bBorder == true then
            borderPlotCount = borderPlotCount + 1
            for direction=1, 5 do
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
    local gateListToNeighbor = list()
    for rPlot in self.gateList do
        if riverMap.isRxTouchingRegion(rPlot.x, rPlot.y, neighborID) then
            table.insert(gateListToNeighbor, rPlot)
        end
    end
    --        print "%(ng)d gates from %(s)d to %(n)d" % \
    --        {"ng":len(gateListToNeighbor),"s":self.ID,"n":neighborID}
    return gateListToNeighbor
end

function Region:defineValidGateList()
    -- This function is called in createFlowMap so the riverMap functions
    -- can be called from here. We now complile a list of all possible river
    -- gates
    self.gateList = {}
    for rxY in range(g_iH + 1) do
        for rxX in range(g_iW + 1) do
            if riverMap.isRxTouchingRegion(rxX, rxY, self.ID) then
                if riverMap.isValidFullGate(self.ID, rxX, rxY) then
                    local rPlot = RiverPlot(rxX, rxY, -1, self.ID)
                    table.insert(self.gateList, rPlot)
                end
            end
        end
    end
end
function Region:expandWaterRegion()
    local expanded = false
    for _, plot in ipairs(self.plotList) do
        for direction=1, 5 do
            xx, yy = GetDirection(direction, plot)
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
    local gatedList = list()
    for regionID in self.neighborList do
        region = regMap.getRegionByID(regionID)
        if region.isWater or region.gateRegion ~= -1 then
            local validGateList = self.getGateListToNeighbor(regionID)
            if len(validGateList) > 0 then
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
        xx = x % (g_iW + 1)
    elseif x < 0 or x >= (g_iW + 1) then
        return -1
    else
        xx = x
    end
    if WrapY then
        yy = y % (g_iH + 1)
    elseif y < 0 or y >= (g_iH + 1) then
        return -1
    else
        yy = y
    end
    local i = yy * (g_iW + 1) + xx
    return i
end

-- This function converts x and y to an index. Useful in case of future wrapping.
function GetIndex(x, y)
    -- Check X for wrap
    local xx, yy
    if WrapX then
        xx = x % g_iW
    elseif x < 0 or x >= g_iW then
        return -1
    else
        xx = x
    end
    -- Check y for wrap
    if WrapY then
        yy = y % g_iH
    elseif y < 0 or y >= g_iH then
        return -1
    else
        yy = y
    end
    local i = yy * g_iW + xx
    return i
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
            print(string.format('%s: %s', key, val))
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
        print('all good')
    end
end

function createCharacterImageSVG(grid, debug_mode)
    local height = #grid
    if debug_mode then
        print('height is ' .. tostring(height))
    end
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
        [-1] = '#0000FF'
    }

    -- Get unique characters (removed the charCount < 9 limitation)
    for y = 1, height do
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if not uniqueChars[char] and not symbols[char] then
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
                if colorDistance(r, g, b, rgb[1], rgb[2], rgb[3]) < 50 then
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

    local svgParts = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %d %d">', svgWidth, svgHeight),
        '  <!-- Background -->',
        string.format('  <rect width="%d" height="%d" fill="#000000"/>', svgWidth, svgHeight)
    }

    -- Add color key (only if there are less than 20 unique characters to keep it readable)
    if charCount < 20 then
        table.insert(svgParts, '  <!-- Color Key -->')
        table.insert(svgParts, string.format('  <text x="10" y="%d" fill="#FFFFFF" font-size="%d">',
            svgHeight - 10, math.floor(pixelWidth/2)))

        local keyString = "Key: "
        for char, color in pairs(colors) do
            keyString = keyString .. char .. "=" .. color .. " "
        end
        table.insert(svgParts, keyString .. '</text>')
    end

    -- Process string line by line
    for y = 1, height do
        for x = 1, #grid[y] do
            local char = grid[y][x]
            if colors[char] or symbols[char] then
                -- Create SVG rect element for this character
                local colour = symbols[char] or colors[char]
                local rect = string.format(
                    '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                    (x-1) * pixelWidth, (y-1) * pixelWidth, pixelWidth, pixelWidth, colour
                )
                table.insert(svgParts, rect)
            end
        end
    end

    -- Close SVG
    table.insert(svgParts, '</svg>')

    return table.concat(svgParts, '\n')
end

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

function make_grid(tPlots, use_keys)
    -- iterate over combined string, to make the dict we want
    local squareGrid = {{}}
    local count = 1
    local row = 1
    if use_keys then
        for _, i in pairs(tPlots) do
            if count == g_iW then
                count = 0
                row = row + 1
                squareGrid[row] = {}
            else
                count = count + 1
                table.insert(squareGrid[row], i)
            end
        end
    else
        for _, i in ipairs(tPlots) do
            if count == g_iW then
                count = 0
                row = row + 1
                squareGrid[row] = {}
            else
                count = count + 1
                table.insert(squareGrid[row], i)
            end
        end
    end

    return squareGrid
end

------------------- RIVER ----------


createRegions()
final_reg_map = PrintRegionMap()
print('reg map')
print(final_reg_map)
-- PrintRegionList()

region_plots = PrintRegionMap(true)
print('reg map water')
print(region_plots)

squareGrid = make_grid(regionMap)
local svgContent = createCharacterImageSVG(squareGrid, true)
saveSVG(svgContent, "rewrite_regions.svg")
riverMap = RiverMap()
--[[
plotMap = PlotMap()
terrainMap = TerrainMap()
spf = StartingPlotFinder()
]]