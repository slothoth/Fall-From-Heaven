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
local PlainsThreshold = .50
local DesertThreshold = .30

-- These variables control the altitude of tundra and ice. Also, in Civ,
-- deserts are supposed to be hot, so we'll limit the altitude for deserts
local TundraThreshold = .74
local IceThreshold = .84
local MaxDesertAltitude = .65


-- Map constants
----------------------------------------------------------------------
local RegionsPerPlot = 0.009              -- Map regions(valleys, seas) per map plot
local WaterRegionsPerPlot = 0.002         -- Water regions per map plot
local MinSeedRange = 5                    -- Closest that a region seed can be placed to another
local MinEdgeRange = 5                    -- Closest that a region seed can be to map edge
local ChanceToGrow = 0.25                 -- Base chance for each tile in region to grow
local EdgeLimit = 2                       -- Region stops growing this far from edge
local RiverAltitudeSubtraction = 2.0      -- Amount subtracted from a plots altitude depending on river size
local RiverAltRangeFactor = 2.0           -- Amount of RiverThreshold to use for altitude calc
local MinRegionSizeStart = 40             -- Minimum region size for a starting plot
local MinRegionSizeTower = 30             -- Minimum region size for a tower placement
local ChokePointAreaSize = 10             -- chokepoint needs this size area on both sides
local ChokePointWalkAroundDistance = 12   -- chokepoint must cause this much extra walking to be considered a choke
local WrapX = false                       -- Dont touch these, this map has no wrap
local WrapY = false



-- new defines:
local L = 0
local N = 1
local S = 2
local E = 3
local W = 4
local NE = 5
local NW = 6
local SE = 7
local SW = 8
local directionXmap = {[N]=0,[S]=0,[E]=1,[W]=-1, [NE]=1, [NW]=-1, [SE]=1, [SW]=-1}
local directionYmap = {[N]=1,[S]=-1,[E]=0,[W]=0, [NE]=1, [NW]=1, [SE]=-1, [SW]=-1}

local rxXMap = {[NE]= 0, [NW] = -1, [SE] = 0, [SW] = -1}
local rxYMap = {[NE]= 0, [NW] = 0, [SE] = -1, [SW] = -1}
local highestRegionAltitude = 0
local OCEAN = 0
local LAND = 1
local HILLS = 2
local PEAK = 3

LeafyAltitude = 0.3

g_iW, g_iH = Map.GetGridSize();

local RegionCharMap = {}
local CharRegionMap = {}
-- conversion table for prints
local function mapChar(integer)
    local c
    if integer <= 26 then
        c = string.char(integer + 96)  -- 'a' to 'z'
    else
        c = string.char(integer + 38)  -- 'A' to 'Z'
    end
    return c
end

for count=1, 52 do
    table.insert(RegionCharMap, mapChar(count))
end

for key, val in ipairs(RegionCharMap) do
    CharRegionMap[val] = key
end

local function canRegionGrowHere(x, y, regionID)
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

local function rxTouchesMapEdge(x, y)
    if x >= (g_iW + 1) - EdgeLimit or x < EdgeLimit then
        return true
    end
    if y >= (g_iH + 1) - EdgeLimit or y < EdgeLimit then
        return true
    end
    return false
end
local function plotFromRx(rxX, rxY, direction)
    local x = rxX + rxXMap[direction]
    local y = rxY + rxYMap[direction]
    if x < 0 or x >= g_iW or y < 0 or y >= g_iH then
        return -1, -1
    end
    return x, y
end

local function isSeedBlocked(seedX, seedY)
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

-- helper functions
local tXDirections = {}
local tYDirections = {}
local function GetDirection(direction, plot)
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

local function list_contains(list, val)
    for _, v in ipairs(list) do
        if v == val then
            return true
        end
    end
    return false
end

local function print_table(tbl_)
    for key, val in pairs(tbl_) do
        if type(val) == "table" then
            slthLog('recursive table on ', key)
            print_table(val)
        else
            slthLog(string.format('key: %s . val: %s', key, val))
        end
    end
end

local function check_in_table(tbl, val)
  for _, v in ipairs(tbl) do
    if v == val then
      return true
    end
  end
  return false
end

local function make_grid(tPlots, use_keys)
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

-- This function converts x and y to an index. Useful in case of future wrapping. Overriden for performance
if WrapX or WrapY then
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
    function GetRxIndex(x, y)
        local xx, yy
        if WrapX then
            xx = x % (g_iW + 1)
        elseif x < 0 or x >= (g_iW + 1) then
            return -1
        else
            xx = x
        end
        -- Check y for wrap
        if WrapY then
            yy = y % (g_iH + 1)
        elseif y < 0 or y >= (g_iH + 1) then
            return -1
        else
            yy = y
        end
        return yy * (g_iW + 1) + xx
    end
else
    function GetIndex(x, y)
        if x < 0 or x > g_iW or y < 0 or y > g_iH then
            return -1
        else
            return  y * g_iW + x
        end
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
end


function createRegions()
    --Growing the regions directly according to the map size created
    --unsolvable problems for the river system. Instead, I am growing
    --on a map (regionRxMap) that corresponds to rivers rather than
    --map tiles. This ensures rivers have a path from region to
    --region.

    -- globals
    currentRegion = -99
    g_IV_iW = g_iW + 2
    g_IV_iH = g_iH + 2
    numTiles = (g_IV_iW ) * (g_IV_iH )
    numRx = (g_IV_iW) * (g_IV_iH)
    regionMap = {}
    regionRxMap = {}
    regionList = {}
    regionPlotList = {}

    --initialize map        backslash \
    --The value for unplayable areas will remain -1. playable regions
    --will stop growing when they touch a map edge.
    for i = 1, numTiles do
        regionMap[i] = -1
    end

    for i = 1, numRx do
        regionRxMap[i] = -1
    end
    local numRegions = math.floor(tonumber(numTiles) * RegionsPerPlot)
    slthLog('number of regions!: ', numRegions)
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
            slthLog('-- PLOT NOT FOUND')
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
                        slthLog('cancelled growth')
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
                        slthLog(string.format("x=%d,y=%d,xx=%d,yy=%d", x, y, xx, yy))
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
    for i, region in ipairs(regionList) do slthLog(i, region.ID); end
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

function getRegionByID(ID)
    if not ID then
        error('ID of region was nil')
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
        slthLog(lineString)
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

-- needs gate stuff defined first

local function getRiverIndex(x, y)
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

local function isRxInRegion(x, y, regionID)
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

local function isValidHalfGate(regionID, rxX, rxY)
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

local function isValidFullGate(regionID, rxX, rxY)
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
            -- local xx = rxX + directionXmap[direction]
            -- local yy = rxY + directionYmap[direction]
            -- local xx, yy = getXYFromDirection(rxX, rxY, direction)          -- TODO this seems wrong to not use them, but was the original logic
            if isValidHalfGate(nRegionID, rxX, rxY) then
                slthLog('alternate path valid gate, shouldnt work')
                failedGateAttempts[currentRegion][key]['failure'] = 'FULL_GATE'
                return true
            end
        end
    end
end

local function isRxTouchingRegion(x, y, regionID)
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
    self.gatePlot = nil
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
    slthLog("borderPlotCount=%dd", borderPlotCount)
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
    local center = nil
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


-- used in AssignPlots (well thats unused too, but still)
function ShuffleList(theList)
    for i = #theList, 2, -1 do
        local j = math.random(1, i)
        theList[i], theList[j] = theList[j], theList[i]
    end
    return theList
end



------------------- RIVER ----------
local function defineGates()
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
            slthLog(" has no gates!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            -- slthLog(PrintRegionMap(false))
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

local function getPossiblePaths(rxX, rxY)
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

local function createFlowMap()
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
                slthLog("validGateList == 0!!!!!!!!!!!!!!!!!!!!")
                slthLog("region = %s", str(region))
                local gRegion = getRegionByID(region.gateRegion)
                slthLog("gateRegion = %s", str(gRegion))
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
    local svgContent = createCharacterImageSVG(squareGrid)
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
local function calculateWetAndDry()
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
    for _, pRegion in ipairs(regionList) do
        local gate = pRegion.gatePlot
        if gate then
            local distance = math.sqrt(math.abs(((gate.x - wetSpotX) * (gate.x - wetSpotX)) + ((gate.y - wetSpotY) * (gate.y - wetSpotY))))
            region.moisture = 1.0 - distance / g_iW
            minMoisture = math.min(region.moisture, minMoisture)
        end
    end
    local scaler = 1.0 / (1.0 - minMoisture)
    for _, pRegion in ipairs(regionList) do
        region.moisture = (pRegion.moisture - minMoisture) * scaler
    end
end

function createRiverMap()
    failedGateAttempts = {}
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
            -- slthLog(string.format('region is %d: %d, %d', regionID, x, y))
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

local function rxFromPlot(plotX, plotY, direction)
    local x, y
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


-- deprecated for now?
local function fillInLake(rxX, rxY)
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
local function isLake(rxX, rxY)                 -- deprecated
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

-- deprecated? Feels like it shouldnt be...
local function isOutFlowGate(rxX, rxY)
    for region in regionList do
        if not region.isWater then
            local gateRxX, gateRxY = rxFromPlot(region.gatePlot.x, region.gatePlot.y, SW)
            if gateRxX == rxX and gateRxY == rxY then
                return true
            end
        end
    end
end
-- used in assignStarts
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

function getRegion(x, y)            -- Used in AssignStartPlots
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
            -- slthLog(string.format('couldnt find region for index %d and %d/%d values', i, xx, yy))
        end
        if nRegionID and nRegionID ~= -1 then
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




function PrintFlowMap()
    slthLog("Flow Map")
    local lineString
    for y=g_iH, -1, -1 do
        lineString = ""
        for x=1, g_iW do
            local mapLoc = flowMap[getRiverIndex(x, y)]
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
-- Deprecated
local function getRiverRegionByID(x,y)
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

---- PLOT MAP -----------
--- Locals
local function flattenPeakSubFunc(x, y, rxI, pDir, direction_2, direction_3, direction_2_change, direction_3_change)
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

local function shouldFlattenRiverPeak(x,y)
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

local function IsPlotTouchingRiver(x, y)
    for direction=5, 8 do
        local rxX, rxY = rxFromPlot(x, y, direction)
        local rxI = getRiverIndex(rxX, rxY)
        if riverMap[rxI] and riverMap[rxI] > RiverThreshold then                  -- TODO this may cause fail throughs as rivers should be gettable
            return true
        end
    end
end

local function IsPlotSurroundedByOcean(x, y)
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

local OppositeDirections = {[N]=S, [S]=N, [E]=W, [W]=E, [NW]=SE, [SE]=NW, [SW]=NE, [NE]=SW}
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

local function shouldPlacePeak(x,y)
    local i = GetIndex(x,y)
    slthLog('trying to find region of index, at plot ', i, ':', x, y)
    local regionID = regionMap[i]
    slthLog('region, x, y:', regionID, x, y)
    if regionID == -1 or not regionID then
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
            if nRegionID and nRegionID ~= -1 then
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

local function getBorders(x, y)
    local i = GetIndex(x,y)
    local regionID = regionMap[i]
    if regionID and regionID ~= -1 then
        local region = getRegionByID(regionID)
        if not region.isWater then
            for direction = 1, 8, 1 do
                local xx = x + directionXmap[direction]
                local yy = y + directionYmap[direction]
                local ii = GetIndex(xx,yy)
                if ii ~= -1 then
                    if plotMap[ii] ~= PEAK then
                        local nRegionID = regionMap[ii]
                        if nRegionID and nRegionID ~= -1 then
                            if nRegionID ~= regionID then
                                if borderPeaks[i] then
                                    borderPeaks[i][direction] = {region=regionID, adjacent_region=nRegionID}
                                else
                                    borderPeaks[i] = {[direction]={region=regionID, adjacent_region=nRegionID}}
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function GetRiverSize(x, y)
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

function GetPlotAltitude(x, y)      -- calculate highest region altitude if necessary and save it for later. Used in main script.
    local loc_regionList = regionList
    if highestRegionAltitude == 0 then
        table.sort(loc_regionList, function(a, b)
            return a.altitude > b.altitude
        end)
        local highestRegionAltitude = loc_regionList[1].altitude            -- TODO BUG
    end
    local i = GetIndex(x, y)
    local regionID = regionMap[i]
    if regionID == -1 then
        return -1.0
    end
    local region = getRegionByID(regionID)
    ----    slthLog "GetPlotAltitude"
    local regionAlt = (region.altitude + 1) / (highestRegionAltitude + 1)
    ----    slthLog "regionAlt = %(ra)f" % {"ra":regionAlt}
    local riverAltRange = RiverAltRangeFactor * RiverThreshold
    local riverSize = GetRiverSize(x, y)
    if riverSize > riverAltRange then
        riverSize = riverAltRange
    end----    slthLog "riverSize = %(r)f" % {"r":riverSize}
    local riverSubtract = riverSize * ((RiverAltitudeSubtraction / riverAltRange) / (highestRegionAltitude + 1))
    ----    slthLog "riverSubtract = %(rs)f" % {"rs":riverSubtract}
    local altitude = regionAlt - riverSubtract
    ----    slthLog "altitude = %(a)f" % {"a":altitude}
    ----    slthLog ""
    return altitude
end

function createPlotMap()            -- Entry point from main script
    plotMap = {}
    slthLog('map dimensions', g_iH, g_iW)
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
    slthLog('plot_total: ', plot_total)
    scrambledPlotList = ShuffleList(scrambledPlotList)

    slthLog('scrambled plots: ', #scrambledPlotList)
    borderPeaks = {}
    for n=1, #scrambledPlotList do
        slthLog('n at', n)
        local plot = scrambledPlotList[n]
        local x = plot[1]
        local y = plot[2]
        local i = GetIndex(x,y)
        if shouldPlacePeak(x,y) then
            getBorders(x,y)
            if plotMap[i] ~= HILLS then
                plotMap[i] = PEAK
            end
        else
            getBorders(x,y)
            local regionID = regionMap[i]
            local region = getRegionByID(regionID)
            if not region.isWater then
                plotMap[i] = LAND
            end
            placeLandInWater(x,y)
        end
    end

    slthLog('border peaks')
    for i, info in pairs(borderPeaks) do
        for direction, regions in pairs(info) do
            slthLog('plot: ' .. i .. ' Dir: ' .. direction .. ' RegionSpan: ' .. regions['region'] .. '/' .. regions['adjacent_region'])
        end
    end
    local borderMap = {}
    for i, j in ipairs(plotMap) do
        if borderPeaks[i] then
            borderMap[i] = '3'
        else
            borderMap[i] = '1'
        end
    end
    simpleGridPrint(borderMap, 'bordermap')
    simpleGridPrint(plotMap, 'post_land_water_mountain')

    for n=1, #scrambledPlotList do
        local plot = scrambledPlotList[n]
        local x = plot[1]
        local y = plot[2]
        local i = GetIndex(x,y)
        local regionID = regionMap[i]
        if regionID and regionID ~= -1 then
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

    -- fix silly bottom row.
    for i = 1, g_iW do
        slthLog('From/To: ', plotMap[i], plotMap[i + g_iW])
        plotMap[i] = plotMap[i + g_iW]
    end

    simpleGridPrint(plotMap, '2_post_river_peaks')

    -- Now for SoftenPeakPercent of peaks, make them hills
    for y=1,g_iH do
        for x= 1,g_iW do
            local i = GetIndex(x,y)
            if plotMap[i] == PEAK then
                if SoftenPeakPercent >= math.random() then
                    plotMap[i] = HILLS
                end
            end
        end
    end
    simpleGridPrint(plotMap, 'post_river_peaks')
    -- simpleGridPrint(plotMap, 'post soften peaks')
    -- Now make sure there are no passable areas that are blocked in
    -- PrintPlotMap()

    --[[
    local areaMap = AreaMap.new(g_iW, g_iH)
    slthLog(areaMap)
    areaMap:findImpassableAreas()
    -- areaMap:PrintAreaMap()
    simpleGridPrint(areaMap.areaMap, '3_Area Map')
    for i=1, g_iW*g_iH do
        if areaMap.areaMap[i] == 0 then
            if plotMap[i] ~= PEAK then
                slthLog('changing plot ', i)
                plotMap[i] = PEAK
            else
                areaMap.areaMap[i] = 1
            end
        end
    end
    ]]--
    newArea = newAreaMap.new()
    mountain_blocked = newArea:get_grid_regions(plotMap, {PEAK})
    simpleGridPrint(mountain_blocked, 'post area map new')
    largest_region = newArea:find_largest_region()
    -- roll for areas we will unblock.

    for i=1, g_iW*g_iH do
        if mountain_blocked[i] and mountain_blocked[i] > 0 and mountain_blocked[i] ~= largest_region then
            if plotMap[i] ~= PEAK then
                slthLog('plot x was region y, changing to peak', i, mountain_blocked[i])
                plotMap[i] = PEAK
            end
        end
    end
    simpleGridPrint(plotMap, 'post fix impassable areas')
    slthLog('plot map dim', #plotMap)
end


local bShowMap = false
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


newAreaMap = {}
newAreaMap.__index = newAreaMap

---
-- Constructor to create a new newAreaMap instance.
function newAreaMap.new()
    local instance = setmetatable({}, newAreaMap)

    instance.absorbed_into_region = {}
    instance.num_rows = 0
    instance.row_lengths = {}
    instance.current_tiles_in_region = 0
    instance.region_sizes = {}
    instance.smaller_regions = {}

    return instance
end

---
-- Calculates the 6 neighbor coordinates for a pointy-topped hex grid.
-- Adjusted for Lua's 1-based indexing.
-- @param y The 1-based row index.
-- @param x The 1-based column index.
-- @return A table of neighbor coordinate pairs, e.g., {{y=1, x=1}, {y=1, x=2}, ...}
function newAreaMap:get_valid_neighbors(y, x)
    local candidates = {}

    -- In Python, the check was y % 2 == 0 for even rows (0, 2, 4...).
    -- In Lua (1-based), the equivalent rows are odd (1, 3, 5...).
    if y % 2 == 1 then -- Equivalent to Python's "even" rows
        candidates = {
            {y = y, x = x - 1}, {y = y, x = x + 1},      -- W, E
            {y = y - 1, x = x - 1}, {y = y - 1, x = x},  -- NW, NE
            {y = y + 1, x = x - 1}, {y = y + 1, x = x}   -- SW, SE
        }
    else -- Equivalent to Python's "odd" rows
        candidates = {
            {y = y, x = x - 1}, {y = y, x = x + 1},      -- W, E
            {y = y - 1, x = x}, {y = y - 1, x = x + 1},  -- NW, NE
            {y = y + 1, x = x}, {y = y + 1, x = x + 1}   -- SW, SE
        }
    end

    local valid_neighbors = {}
    for _, coords in ipairs(candidates) do
        local nr, nc = coords.y, coords.x
        -- Boundary check using 1-based indexing
        if nr >= 1 and nr <= self.num_rows and nc >= 1 and nc <= self.row_lengths[nr] then
            table.insert(valid_neighbors, coords)
        end
    end

    return valid_neighbors
end


---
-- Iteratively builds a region using a stack to avoid recursion limits.
-- This is a non-recursive flood-fill algorithm.
-- @param start_x The starting X coordinate.
-- @param start_y The starting Y coordinate.
-- @param current_region The integer ID for the new region.
function newAreaMap:build_region(start_x, start_y, current_region)
    -- A stack to hold the coordinates of tiles to visit.
    local stack = {{y = start_y, x = start_x}}
    while #stack > 0 do
        local current_coords = table.remove(stack) -- Pop the last element (LIFO)
        local x, y = current_coords.x, current_coords.y
        -- Check if the tile has already been assigned. If so, skip.
        if self.absorbed_into_region[y][x] == -1 then
            self.absorbed_into_region[y][x] = current_region
            self.current_tiles_in_region = self.current_tiles_in_region + 1
            local adjacent_plots = self:get_valid_neighbors(y, x)
            for _, neighbor_coords in ipairs(adjacent_plots) do
                local nx, ny = neighbor_coords.x, neighbor_coords.y
                -- If a neighbor hasn't been assigned a region yet, add it to the stack
                if self.absorbed_into_region[ny][nx] == -1 then
                    table.insert(stack, neighbor_coords)
                end
            end
        end
    end
end

---
-- Main function to process a grid and identify all contiguous regions.
-- @param grid A 2D table representing the map grid.
-- @param blockers A list-like table of tile values that are not traversable (e.g., {-2, -3}).
-- @return A new 2D table where each cell has an integer region ID.
function newAreaMap:get_grid_regions(grid, blockers)
    -- 1. Create a deep copy of the grid to avoid modifying the original
    -- first check if grid is 1d or 2d
    local mountain_mapper = {['6'] = -3, ['1'] = -2, ['W'] = -2, ['M'] = -3}
    local gridDim = 2
    if type(grid[1]) == "number" then
        gridDim = 1
        slthLog('grid dim is 1')
        slthLog('grid size is', #grid)
    end
    local new_grid = {}
    if gridDim == 2 then
        for i = 1, #grid do
            new_grid[i] = {}
            for j = 1, #grid[i] do
                new_grid[i][j] = grid[i][j]
            end
        end
    else
        local idx = 1
        for y = 1, g_iH do
            new_grid[y] = {}
            for x = 1, g_iW do
                new_grid[y][x] = grid[idx]
                idx = idx + 1
            end
        end
    end

    -- 2. Map string values to consistent integer IDs
    local mountain_mapper = {['6'] = -3, ['1'] = -2, ['W'] = -2, ['M'] = -3}
    for y = 1, #new_grid do
        for x = 1, #new_grid[y] do
            local tile = new_grid[y][x]
            new_grid[y][x] = mountain_mapper[tile] or tile
        end
    end

    -- 3. Initialize instance properties and the results grid
    self.num_rows = #new_grid
    self.row_lengths = {}
    for i = 1, self.num_rows do
        self.row_lengths[i] = #new_grid[i]
    end

    self.absorbed_into_region = {}
    for y = 1, self.num_rows do
        self.absorbed_into_region[y] = {}
        for x = 1, self.row_lengths[y] do
            local tile_val = new_grid[y][x]
            if list_contains(blockers, tile_val) then
                self.absorbed_into_region[y][x] = -20
            else
                self.absorbed_into_region[y][x] = -1
            end
        end
    end

    -- 4. Iterate through the grid and build regions
    local current_region = 1
    for y = 1, self.num_rows do
        for x = 1, self.row_lengths[y] do
            if self.absorbed_into_region[y][x] == -1 then
                self.current_tiles_in_region = 0
                self:build_region(x, y, current_region)
                self.region_sizes[current_region]= self.current_tiles_in_region
                current_region = current_region + 1
            end
        end
    end

    if gridDim == 1 then
        -- convert back to flat structure for export
        local final_grid = {}
        local idx = 1
        slthLog('length of absorb y', #self.absorbed_into_region)
        slthLog('length of absorb X', #self.absorbed_into_region[2])
        slthLog('length of row lengths', self.row_lengths[2])
        slthLog('length of grid', #grid)
        slthLog('length of grid',  #new_grid)
        slthLog('length of new grid lengths', #new_grid[2])
        slthLog('expected total', #self.absorbed_into_region * #self.absorbed_into_region[2])
        for y = 1, self.num_rows do
            for x = 1, self.row_lengths[y] do
                final_grid[idx] = self.absorbed_into_region[y][x]
                idx = idx + 1
            end
        end
        slthLog('final idx is', idx)
        return final_grid
    else
        return self.absorbed_into_region
    end
end

function newAreaMap:find_largest_region()
    local largest_size = 0
    local largest_region = -1
    for idx, size in pairs(self.region_sizes) do
        if size > largest_size then
            largest_size = size
            largest_region = idx
        end
        slthLog('region, size:', idx, size)
    end
    slthLog('largest region, with size', largest_region, largest_size)
    for idx, size in pairs(self.region_sizes) do
        if idx == largest_region then
            slthLog('')
        else
            table.insert(self.smaller_regions, idx)
        end
    end
    return largest_region
end

local function addTerrain(index, value) if plotMap[index] then terrainMap[index] = value end end

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
    for y=1, g_iH do
        for x=1, g_iW do
            table.insert(terrainMap, OCEAN_TERRAIN)
        end
    end
    slthLog('terrain_total is:', #terrainMap)
    for y=0, g_iH do
        for x=0, g_iW do
            local i = GetIndex(x, y)
            if plotMap[i] and plotMap[i] ~= OCEAN then
                addTerrain(i, GRASS)
            else
                for direction=1, 8 do
                    local xx = x + directionXmap[direction]
                    local yy = y + directionYmap[direction]
                    local ii = GetIndex(xx, yy)
                    if ii ~= -1 and plotMap[i] and plotMap[ii] ~= OCEAN then
                        addTerrain(i, COAST)
                    end
                end
            end
        end
    end
    slthLog('terrain_total is:', #terrainMap)
    simpleGridPrint(terrainMap, 'post_terrain_init_ocean')

    for y=1, g_iH-1 do
        for x=1, g_iW-1 do
            local i = GetIndex(x, y)
            if plotMap[i] ~= OCEAN then
                slthLog('doing x/y', x, y)
                local rainFall = GetRainfall(x, y)
                if rainFall < DesertThreshold then
                    if rainFall < ((math.random() * DesertThreshold) / 2.0) + (DesertThreshold / 2.0) then
                        addTerrain(i, DESERT)
                    else
                        addTerrain(i, PLAINS)
                    end
                elseif rainFall < PlainsThreshold then
                    if rainFall < ((math.random() * (
                            PlainsThreshold - DesertThreshold)) / 2.0) + DesertThreshold + (
                            (PlainsThreshold - DesertThreshold) / 2.0) then
                        addTerrain(i, PLAINS)
                    else
                        addTerrain(i, GRASS)
                    end
                else
                    addTerrain(i, GRASS)
                end
                local altitude = GetPlotAltitude(x, y)
                if altitude > IceThreshold then
                    addTerrain(i, ICE)
                elseif altitude > TundraThreshold then
                    addTerrain(i, TUNDRA)
                elseif altitude > MaxDesertAltitude and terrainMap[i] == DESERT then
                    addTerrain(i, PLAINS)
                end
            end
        end
    end
    slthLog('terrain_total is:', #terrainMap)
    simpleGridPrint(terrainMap, 'post terrain biome')
    -- clean up desert peaks to avoid burning peaks all over the map
    for y=1,g_iH -1 do
        for x=1, g_iW-1 do
            local i = GetIndex(x, y)
            if plotMap[i] == PEAK then
                addTerrain(i, TUNDRA)
                for direction=1, 8 do
                    local xx = x + directionXmap[direction]
                    local yy = y + directionYmap[direction]
                    local ii = GetIndex(xx, yy)
                    if plotMap[ii] ~= PEAK and plotMap[ii] ~= OCEAN then
                        addTerrain(i, terrainMap[ii])
                        break
                    end
                end
            end
        end
    end
    simpleGridPrint(terrainMap, 'post cleanup desert mountains')
    simpleGridPrint(plotMap,'post terrain gen PLOTS')
    slthLog('terrain map dim', #terrainMap)
end

function GetRainfall(x, y)              -- used in main script.
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

-- River section, maybe move this
local function tryPlaceRiver(x, y, direction1, direction2, flow_direction)
    local xx,yy = rxFromPlot(x,y,direction1)
    local ii = getRiverIndex(xx,yy)
    if riverMap[ii] and flowMap[ii] then
        if riverMap[ii] > RiverThreshold and flowMap[ii] == direction2 then
            TryStartRiver(plot, flow_direction);
        end
    end
end

function makeErebusRivers()
    for y=1, g_iH do
        for x=1, g_iW do
            local plot = Map.GetPlot(x, y)
            tryPlaceRiver(x, y, NE, S, FlowDirectionTypes.FLOWDIRECTION_SOUTH)
            tryPlaceRiver(x, y, SW, E, FlowDirectionTypes.FLOWDIRECTION_EAST)
            local xx,yy = rxFromPlot(x,y,SE)
            local ii = getRiverIndex(xx,yy)
            if riverMap[ii] and flowMap[ii] then
                if riverMap[ii] > RiverThreshold and flowMap[ii] == N then
                    TryStartRiver(plot, FlowDirectionTypes.FLOWDIRECTION_NORTH);
                elseif riverMap[ii] > RiverThreshold and flowMap[ii] == W then
                    TryStartRiver(plot, FlowDirectionTypes.FLOWDIRECTION_WEST);
                end
            end
        end
    end
end
