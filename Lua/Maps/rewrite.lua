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

function createRegions()
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
    local gateListToNeighbor = {}
    for rPlot in self.gateList do
        if isRxTouchingRegion(rPlot.x, rPlot.y, neighborID) then
            table.insert(gateListToNeighbor, rPlot)
        end
    end
    --        print "%(ng)d gates from %(s)d to %(n)d" % \
    --        {"ng":#gateListToNeighbor,"s":self.ID,"n":neighborID}
    return gateListToNeighbor
end

function Region:defineValidGateList()
    -- This function is called in createFlowMap so the riverMap functions
    -- can be called from here. We now complile a list of all possible river
    -- gates
    self.gateList = {}
    print('id is')
    print(self.ID)
    currentRegion = self.ID
    for rxY=1, g_iH + 1 do
        for rxX=1, g_iW + 1 do
            if isRxTouchingRegion(rxX, rxY, self.ID) then
                print('RX is touching region')
                if isValidFullGate(self.ID, rxX, rxY) then
                    local rPlot = {x=rxX, y=rxY, direction=-1, self.ID}
                    print(string.format('valid gate for region %d is at: %d, %d', self.ID, rxX, rxY))
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
    local gatedList = {}
    for regionID in self.neighborList do
        region = getRegionByID(regionID)
        if region.isWater or region.gateRegion ~= -1 then
            local validGateList = self.getGateListToNeighbor(regionID)
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

function createCharacterImageSVG(grid, rx_data, debug_mode)
    local excludedPlots = {}
    local highlighted_regions = {}
    print('examining rx')
    if rx_data then
        for k, v in pairs(rx_data) do
            print(k)
            for part in string.gmatch(k, "[^/]+") do
                print(part)
                highlighted_regions[tonumber(part)] = tonumber(part)
                break
            end
            print('---')
        end
        print('regions to highlight:')
        for k,v  in pairs(highlighted_regions) do
            print(k)
        end

        for key, val in pairs(rx_data) do
            for key_, val_ in pairs(val) do
                excludedPlots[val_['x'] .. '/' .. val_['y']] = true
            end
        end
    end
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
    for key, val in pairs(highlighted_regions) do
        symbols[key] = '#FF0000' -- Red
    end

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
    if true then
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
        for char, color in pairs(colors) do
            local colour = color
            if symbols[char] then
                colour = symbols[char]
            end
            local keyString = string.format('  <text x="%d" y="%d" fill="#FFFFFF" font-size="%d">',
            xPosition, varKeyHeight, math.floor(pixelWidth)) .. char .. ":"
            table.insert(keyParts, keyString .. '</text>')
            local rect = string.format(
                    '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                    xPosition+10, varKeyHeight-5, pixelWidth, pixelWidth, colour
                )
            table.insert(keyParts, rect)
            if xPosition > svgWidth - 80 then
                xPosition = 10
                varKeyHeight = varKeyHeight + 20
            else
                xPosition = xPosition + 40
            end
        end
    end

    -- Process string line by line
    local regionsEncountered = {}
    table.insert(keyParts, '  <!-- first of labelling -->')
    for y = 1, height do
        for x = 1, #grid[y] do
            if not excludedPlots[x .. '/' .. y] then
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
            print('found wrapping region')
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
    -- mark char_centres WORLD WRAP on X is why they are weird!
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
                print(string.format('for region: %d and plot %s', key, key_))
                local x = val_['x']
                local y = val_['y']
                local reason = val_['failure']
                local colour = '#000000'
                if not used_plots[x .. '/' .. y] then
                    used_plots[x .. '/' .. y] = true
                    if reason == 'RX not in region, and 2 regions adjacent, but every direction did not have an RX in region' then
                        print(string.format('highlighted region plot %d/%d is red', x, y))
                        colour = '#AA0000'                      -- Red
                    elseif reason == 'not_two_gates' then
                        colour = '#00FF00'                      -- GREEN
                        print(string.format('highlighted region plot %d/%d is green', x, y))
                    elseif reason == 'RX_being_in_region' then
                        colour = '#FFFF00'                      -- yellow
                        print(string.format('highlighted region plot %d/%d is yellow', x, y))
                    elseif reason == 'FULL_GATE' then
                        colour = '#FFFFFF'                      -- yellow
                        print(string.format('highlighted region plot %d/%d is White as full gate', x, y))
                    else        -- success!
                        colour = '#000000'
                        print(string.format('highlighted region plot %d/%d is black', x, y))
                    end

                    local rect = string.format(
                            '  <rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>',
                            ((x-1) * pixelWidth)+pixelWidth, ((y-1) * pixelWidth)+pixelWidth, pixelWidth, pixelWidth, colour
                    )
                    table.insert(keyParts, rect)
                else
                    print('plot already used!')
                end
            end
        end
    end


    -- Close SVG
    table.insert(keyParts, '</svg>')
    local full =  {table.concat(svgParts, '\n'),  table.concat(keyParts, '\n')}
    return table.concat(full, '\n')
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
    for i=1, (g_iH + 1) * (g_iW + 1) do
        -- append(0)
        table.insert(riverMap, 0)
    end
    for y=1, g_iH + 1 do
        for x=1, g_iW + 1 do
            local i = getRiverIndex(x, y)
            local direction = flowMap[i]
            local regionID = getRegion(x, y)
            local region = getRegionByID(regionID)
            local xx = x
            local yy = y
            while direction ~= -1 and direction ~= L do
                xx, yy = getXYFromDirection(xx, yy, direction)
                local ii = getRiverIndex(xx, yy)
                riverMap[ii] = riverMap[ii] + MinRainfall + (1.0 - MinRainfall) * region.moisture
                direction = flowMap[ii]
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
    for i=1, (g_iH + 1) * (g_iW + 1) do
        table.insert(flowMap, -1)
        table.insert(heightMap, -1.0)
    end
    defineGates()
    print("Gates Defined !!!!!!!!!!!!!!!!!!!!!!!!")
    local for_continue = true
    for region in regionList do
        if for_continue then
            if region.isWater then
                for_continue = false
            end
            if for_continue then
                -- randomly choose an outflow gate
                -- print "region.gateRegion = %(gr)d" % {"gr":region.gateRegion}
                local validGateList = region.getGateListToNeighbor(region.gateRegion)
                if #validGateList  == 0 then
                    print("validGateList == 0!!!!!!!!!!!!!!!!!!!!")
                    print("region = %s", str(region))
                    local gRegion = getRegionByID(region.gateRegion)
                    print("gateRegion = %s", str(gRegion))
                    error("region has neighbor but no valid gates. see debug file")
                end
                region.gatePlot = validGateList[PRand.randint(0, #validGateList - 1)]
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
                        local xx, yy = getXYFromDirection(rxX, rxY, direction)
                        if isRxInRegion(xx, yy, region.gateRegion) then
                            flowMap[rxI] = direction
                            heightMap[rxI] = 0.01
                            continuing = false
                        end
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
    for region in regionList do
        if for_continue then
            if not region.gatePlot then
            for_continue = false
            end
            local rxX = region.gatePlot.x
            local rxY = region.gatePlot.y
            -- print "rxX=%(x)d, rxY=%(y)d" % {"x":rxX,"y":rxY}
            riverPlot = {x=rxX, y=rxY, direction=0,  region.ID}
            table.insert(plotList, riverPlot)
        end
    end
    while #plotList > 0 do
        --            print "len plotList = v"
        --            print #plotList
        local count = #plotList
        plotList = ShuffleList(plotList)
        for n=1, count do
            thisPlot = plotList.pop(0)  -- queue method, not stack
            --                print "popping"
            local rxI = getRiverIndex(thisPlot.x, thisPlot.y)
            local altitude = heightMap[rxI]
            for direction=1, 5 do
                local x, y = getXYFromDirection(thisPlot.x, thisPlot.y, direction)
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
    --                        print "newPlot appended"
    -- Create flow map
    for y=1, g_iH + 1 do
        for x=1, g_iW + 1 do
            local paths = getPossiblePaths(x, y)
            if #paths > 0 then
                local i = getRiverIndex(x, y)
                local pathIndex = PRand.randint(0, #paths - 1)
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
    local regionList = {}
    for region in regionList do
        table.insert(regionList, region)
    end
    table.sort(regionList, function(a, b)
            return a.altitude < b.altitude
        end)
    regionList.reverse()

    region = regionList[1]
    while region.altitude > 0 do
        region = getRegionByID(region.gateRegion)
        if region.altitude == 1 then
            wetSpot = plotFromRx(region.gatePlot.x, region.gatePlot.y, SW)
        end
    end
    -- Now calculate moisture for each region
    local minMoisture = 1.0
    for region in regionList do
        local gate = region.gatePlot
        if gate then
            wetSpotX, wetSpotY = wetSpot
            distance = GetDistance(gate.x, gate.y, wetSpotX, wetSpotY)
            region.moisture = 1.0 - distance / float(g_iW)
            minMoisture = min(region.moisture, minMoisture)
        end
    end
    scaler = 1.0 / (1.0 - minMoisture)
    for _, region in ipairs(regionList) do
        region.moisture = (region.moisture - minMoisture) * scaler
    end
end

function defineGates()
    -- Now each region picks one gate that is not in the current gate line
    -- to avoid recursive loops
    numRegions = #regionList
    numGatesPlaced = 0
    iterations = 0
    -- water is considered gated for this purpose
    for i, region in ipairs(regionList) do
        region:defineValidGateList()
        -- regions should always have gates
        print(string.format('checking region %d', region.ID))
        if #(region.gateList) == 0 then
            print(" has no gates!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            -- print(PrintRegionMap(False))
            local squareGrid = make_grid(regionMap)
            local svgContent = createCharacterImageSVG(squareGrid, failedGateAttempts)
            saveSVG(svgContent, "flow_regions.svg")
            error(string.format("region has no gates, got to iter %d", i))
        end
    end
    while numGatesPlaced < numRegions do
        if iterations > 500 then
            error("Endless loop occured in gate placement")
        else
            iterations = iterations + 1
            regionList = ShuffleList(regionList)
            for _, region in ipairs(regionList) do
                if region.gateRegion == -1 then
                    gatedNeighborList = region.getGatedNeighborList()
                    if #gatedNeighborList > 0 then
                        gatedNeighborList = ShuffleList(gatedNeighborList)
                        region.gateRegion = gatedNeighborList[1]
                        if region.isWater then
                            region.altitude = 0
                        else
                            gateRegion = getRegionByID(region.gateRegion)
                            region.altitude = gateRegion.altitude + 1
                        --                        print "region %(r)d gateRegion is %(g)d" % \
                        --                        {"r":region.ID,"g":region.gateRegion}
                        numGatesPlaced = numGatesPlaced + 1
                        end
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
        print('region existed alreaedy')
    else
        failedGateAttempts[currentRegion] = {}
    end

    if failedGateAttempts[currentRegion][key] then
        print('region plot existed alreaedy')
    else
        failedGateAttempts[currentRegion][key] = {x=rxX, y=rxY}
    end
    for direction=5, 9 do
        local px, py = plotFromRx(rxX, rxY, direction)
        local i = GetIndex(px, py)
        local pRegID = regionMap[i]
        if not pRegID or pRegID == -1 then
            print(string.format('RX is not valid half gate by cant find region ID or id is -1 for index %d and x/y: %d/%d', i, px, py))
            return false
        end
        if not check_in_table(forGatesRegionList, pRegID) then
            table.insert(forGatesRegionList, pRegID)
            failedGateAttempts[currentRegion][key][direction] = pRegID
        end
    end
    local table_contents = ''
    for key, val in ipairs(forGatesRegionList) do table_contents = table_contents .. ' ' .. val; end
    if #forGatesRegionList ~= 2 then
        print(string.format('RX %d/%d is not valid half gate by not touching 2 regions, instead touching %d regions: %s',rxX, rxY, #forGatesRegionList, table_contents))
        failedGateAttempts[currentRegion][key]['failure'] = 'not_two_gates'
        return false
    end
    if isRxInRegion(rxX, rxY, regionID) then
        print(string.format('RX %d/%d is not valid half gate by RX being in region, but does touch %d regions: %s',rxX, rxY, #forGatesRegionList, table_contents))
        failedGateAttempts[currentRegion][key]['failure'] = 'RX_being_in_region'
        return false
    end
    for direction=1, 5 do
        local xx, yy = getXYFromDirection(rxX, rxY, direction)
        if isRxInRegion(xx, yy, regionID) then
            print(string.format('RX %d/%d is valid half gate by RX being in region, it is not in region, but it touches %d regions: %s',rxX, rxY, #forGatesRegionList, table_contents))
            failedGateAttempts[currentRegion][key]['failure'] = 'success!'
            return true
        end
    end
    print('RX is not valid half gate as RX was not in region in all 4 directions ')
    failedGateAttempts[currentRegion][key]['failure'] = 'RX not in region, and 2 regions adjacent, but every direction did not have an RX in region'
    return false
end

function isValidFullGate(regionID, rxX, rxY)
    if not isValidHalfGate(regionID, rxX, rxY) then
        return false
    end
    print('passed owner region can have gate check')
    local region = getRegionByID(regionID)
    print(#(region.neighborList))          -- !! NEIGHBOURLIST WAS EMPTY
    local key = tostring(regionID) .. '/' .. tostring(rxX) .. '/' .. tostring(rxY)
    for nRegionID in ipairs(region.neighborList) do
        print('checking valid neighbours....')
        if isValidHalfGate(nRegionID, rxX, rxY) then
            print('other adjacent region has valid gate')
            failedGateAttempts[currentRegion][key]['failure'] = 'FULL_GATE'
            return true
        end
        for direction=1, 5 do
            local xx, yy = getXYFromDirection(rxX, rxY, direction)          -- TODO this seems wrong to not use them
            if isValidHalfGate(nRegionID, rxX, rxY) then
                print('alternate path valid gate, shouldnt work')
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
    for direction=1, 5 do
        local x, y = getXYFromDirection(rxX, rxY, direction)
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

    for direction=1, 5 do
        local x, y = getXYFromDirection(rxX, rxY, direction)
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
    for direction=1, 5 do
        local x, y = getXYFromDirection(rxX, rxY, direction)
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
    for direction=1, 5 do
        local x, y = getXYFromDirection(rxX, rxY, direction)
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
--[[
function getXYFromDirection(x, y, direction)
    local xx = x
    local yy = y
    if direction == N then
        yy += 1
    elseif direction == S then
        yy -= 1
    elseif direction == E then
        xx += 1
    elseif direction == W then
        xx -= 1
    return xx, yy
]]
function getRiverIndex(x, y)
    local xx
    local yy
    if x < 0 or x >= g_iW + 1 then
        return -1
    else
        xx = x
    end
    if y < 0 or y >= g_iH + 1 then
        return -1
    else
        yy = y
    end
    local i = yy * (g_iW + 1) + xx
    return i
end
function isRxInRegion(x, y, regionID)
    -- Rxs on the border are not in region. All plots touching rx must
    -- be in region
    for direction=5, 9 do
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
    local invalidRegion = False
    for direction=5, 9 do
        xx, yy = plotFromRx(x, y, direction)
        i = GetIndex(xx, yy)
        local nRegionID = regionMap[i]
        if nRegionID ~= -1 then
        -- test if this main plot is gate for this region
            nRegion = getRegionByID(nRegionID)
            if nRegion.gatePlot ~= None and x == nRegion.gatePlot.x and y == nRegion.gatePlot.y then
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
        for x=1, g_iW + 1 do
            mapLoc = flowMap[getRiverIndex(x, y)]
            if mapLoc == -1 then
                lineString = lineString  + "X"
            elseif mapLoc == N then
                lineString = lineString  + "N"
            elseif mapLoc == S then
                lineString = lineString  + "S"
            elseif mapLoc == E then
                lineString = lineString  + "E"
            elseif mapLoc == W then
                lineString = lineString  + "W"
            else
                lineString = lineString  + "X"
            end
        end
        print(lineString)
    end
end

currentRegion = -99
createRegions()
final_reg_map = PrintRegionMap()
print('reg map')
print(final_reg_map)
-- PrintRegionList()

region_plots = PrintRegionMap(true)
print('reg map water')
print(region_plots)

squareGrid = make_grid(regionMap)
local svgContent = createCharacterImageSVG(squareGrid)
saveSVG(svgContent, "rewrite_regions.svg")

failedGateAttempts = {}
createRiverMap()
river_plots = PrintFlowMap()
--[[
plotMap = PlotMap()
terrainMap = TerrainMap()
spf = StartingPlotFinder()
]]