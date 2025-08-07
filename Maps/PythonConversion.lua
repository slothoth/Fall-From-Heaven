if not Game then
    require('mobdebug').coro()
end

local SoftenPeakPercent = 0.0           -- percentage of peaks into hills in order to break up the worlds valleys.
local RiverThreshold = 5.0      -- how many tiles of drainage is needed to create a river
local MinRainfall = .25     --  The amount of rainfall in the dryest desert. Must be between 1.0 and 0.0
local RiverFactorFlattensAll = 10.0     -- factor on RiverThreshold to determine when a river
                                        -- is large enough to have a 100% chance to flatten nearby hills and peaks.
local RiverAddsMoistureRange = .20
local RiverAddsMoistureMax = 10.0
local HillChanceAtZero = .15        -- control the frequency of hills and peaks at the lowest  and highest altitudes
local HillChanceAtOne = .90
local PeakChanceAtZero = .0
local PeakChanceAtOne = .20
local PlainsThreshold = .50     -- control the moisture thresholds for desert and plains
local DesertThreshold = .30
local TundraThreshold = .74     -- control the altitude of tundra and ice. Also, in Civ,
local IceThreshold = .84        -- deserts are supposed to be hot, so we'll limit the altitude for deserts
local MaxDesertAltitude = .65
LeafyAltitude = 0.3
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
local L,N,S,E,W,NE,NW,SE,SW = 0,1,2,3,4,5,6,7,8
local directionXmap = {[N]=0,[S]=0,[E]=1,[W]=-1, [NE]=1, [NW]=-1, [SE]=1, [SW]=-1, [L]=0}
local directionYmap = {[N]=1,[S]=-1,[E]=0,[W]=0, [NE]=1, [NW]=1, [SE]=-1, [SW]=-1, [L]=0}
local rxXMap = {[NE]= 0, [NW] = -1, [SE] = 0, [SW] = -1}
local rxYMap = {[NE]= 0, [NW] = 0, [SE] = -1, [SW] = -1}
local highestRegionAltitude = 0
local OCEAN, LAND,HILLS,PEAK = 0,1,2,3

g_iW, g_iH = Map.GetGridSize();

local RegionCharMap, CharRegionMap = {}, {}
local function mapChar(integer)         -- conversion table for prints
    if integer <= 26 then
        return string.char(integer + 96)  -- 'a' to 'z'
    end
    return string.char(integer + 38)  -- 'A' to 'Z'
end
for count=1, 52 do table.insert(RegionCharMap, mapChar(count)) end
for key, val in ipairs(RegionCharMap) do CharRegionMap[val] = key end

local function flipVertical(tiles, w, h)
    local width, height = w, h
    if not width then
        width,height = g_iW, g_iH
    end
    local flipped = {}
    for row = 0, height - 1 do
        local srcRow = height - 1 - row
        for col = 0, width - 1 do
            flipped[row * width + col + 1] = tiles[srcRow * width + col + 1]
        end
    end
    return flipped
end

local function canRegionGrowHere(x, y, regionID)
    local i = GetRxIndex(x, y)
    if i == -1 then return false end
    if regionRxMap[i] ~= -1 then return false end
    local region = tRegionIdMap[regionID]
    if not region.isGrowing then return false end
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
    if x >= (g_iW + 1) - EdgeLimit or x < EdgeLimit then return true end
    if y >= (g_iH + 1) - EdgeLimit or y < EdgeLimit then return true end
    return false
end
local function plotFromRx(rxX, rxY, direction)
    local x = rxX + rxXMap[direction]
    local y = rxY + rxYMap[direction]
    if x < 0 or x >= g_iW or y < 0 or y >= g_iH then return -1, -1 end
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

local tDirAdditions = {[1]={0,1}, [2]={0,-1},[3]={1,0},[4]={-1,0}}
local function GetDirection(direction, plot)
    local tAdditions = tDirAdditions[direction]
    local xx = plot.x + tAdditions[1]
    local yy = plot.y + tAdditions[2]
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
            print_table(val)
        else
            print(string.format('key: %s . val: %s', key, val))
        end
    end
end

local function check_in_table(tbl, val)
  for _, v in ipairs(tbl) do if v == val then return true end end
  return false
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
        if WrapY then       -- Check y for wrap
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
    function GetXY(index)
        local y = math.floor(index / g_iW)
        local x = index % g_iW
        return x, y
    end
end

local function buildNeighbourTable(width, height)
    local neighboursTable = {}
    local nCounts = {0,0,0,0,0,0,0,0}
    for y = 1, height do
        for x = 1, width do
            local i = GetIndex(x, y)
            local neighbours = {}
            for dy = -1, 1 do
                local ny = y + dy
                if ny >= 1 and ny <= height then
                    for dx = -1, 1 do
                        local nx = x + dx
                        if not (dx == 0 and dy == 0) and nx >= 1 and nx <= width then
                            table.insert(neighbours, GetIndex(nx, ny))
                        end
                    end
                end
            end
            nCounts[#neighbours] = nCounts[#neighbours] + 1
            neighboursTable[i] = neighbours
        end
    end
    return neighboursTable
end

local function seedRegions()
    for i = 1, numTiles do regionMap[i] = -1 end
    for i = 1, numRx do regionRxMap[i] = -1 end
    local numRegions = math.floor(tonumber(numTiles) * RegionsPerPlot)
    slthLog('number of regions!: ', numRegions)
    for i = 1, numRegions do
        local iterations = 0            -- first find a random seed point that is not blocked by
        local notFoundSeed = true       -- previous points
        while notFoundSeed do
            iterations = iterations + 1
            if iterations > 1000 then error("endless loop in region seed placement") end
            local seedX = math.random(0, g_iW + 1)
            local seedY = math.random(0, g_iH + 1)
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
    tRegionIdMap = {}
    for i, region in ipairs(regionList) do
        tRegionIdMap[region.ID] = region
    end
end

local function growRegions()
    local iterations = 0
    while #regionPlotList > 0 do
        iterations = iterations + 1
        if iterations > 200000 then
            error("endless loop in region growth")
        end
        local plot = regionPlotList[1]
        if not plot then
            slthLog('-- PLOT NOT FOUND')
        end
        local region = tRegionIdMap[plot.regionId]
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

            if roomLeft then                    --move plot to the end of the list if room left
                table.insert(regionPlotList, plot)
            end
            plot = table.remove(regionPlotList, 1)
        else
            plot = table.remove(regionPlotList, 1)      --delete it if no room left
        end
    end
end

local function convertRxToRegion()          -- TODO we are getting spots that arent converted in RegionMap?
    simpleSquareGridPrint(flipVertical(regionRxMap), 'rxMap', {}, true, true)
    for y=1, g_iH do                        -- This may be intentional
        for x=1, g_iW do
            local i = GetRxIndex(x, y)
            local regionID = regionRxMap[i]
            if regionID and regionID ~= -1 then
                local region = tRegionIdMap[regionID]
                for direction= 5, 8 do
                    slthLog('direction', direction)
                    local xx, yy = plotFromRx(x, y, direction)
                    local ii = GetIndex(xx, yy)
                    if ii ~= -1 then
                        regionMap[ii] = regionID
                        local newPlot = {regionId=regionID, x=xx, y=yy, gateRx=-1, bBorder=false, bEdge=false}
                        local iPlotID = GetIndex(xx, yy)
                        region.plotList[iPlotID] = newPlot
                        regionPlotsInfo[iPlotID] = newPlot
                    end
                end
            end
        end
    end
    simpleSquareGridPrint(flipVertical(regionMap), 'region_map_post_RX_prefix', {}, true, true)
    local not_perimeter = {}
    for y = 3, g_iH - 3 do
        for x = 3, g_iW - 3 do
            local index = y * g_iW + x
            not_perimeter[index] = true
        end
    end
    for i=1, numTiles do
        if not_perimeter[i] and regionMap[i] and regionMap[i] == -1 then
            local nbors = regionNeighbours[i]
            local nbor_regions = {[-1]=0}
            local bHadNoRegionNeighbour = false
            for _, nPlotID in ipairs(nbors) do
                local nRegionID = regionMap[nPlotID]
                if not nbor_regions[nRegionID] then
                    nbor_regions[nRegionID] = 1
                else
                    nbor_regions[nRegionID] = nbor_regions[nRegionID] + 1
                end
            end
            local common_region_id = -10
            local largest_common = -20
            for nRegion, count in pairs(nbor_regions) do
                if count > largest_common then
                    largest_common = count
                    common_region_id = nRegion
                end
            end
            if common_region_id ~= -10 and nbor_regions[-1] < 2 then
                local newRegion = tRegionIdMap[common_region_id]
                local x,y = GetXY(i)
                local newPlot = {regionId=common_region_id, x=x, y=y, gateRx=-1}
                newRegion.plotList[i] = newPlot
                regionPlotsInfo[i] = newPlot
                regionMap[i] = common_region_id
                -- print('set index', i, 'to new region', common_region_id)
            end
        end
    end
    simpleSquareGridPrint(flipVertical(regionMap), 'region_map_post_RX_postidx', {}, true, true)
end

local function markBorders()
    for _, region in ipairs(regionList) do
        for iPlotID, plot in pairs(region.plotList) do
            local plotBordersRegions = {}
            local tUniqueRegionsBordered = {}
            for direction=1, 4 do
                local xx, yy = GetDirection(direction, plot)
                local ii = GetIndex(xx, yy)
                if ii ~= -1 and regionMap[ii] ~= -1 and regionMap[ii] and regionMap[ii] ~= region.ID then
                    plot.bBorder = true
                    plot.bEdge = true
                    if not check_in_table(region.neighborList, regionMap[ii])  then
                        table.insert(region.neighborList, regionMap[ii])            -- TODO THIS NEVER GETS THERE?
                    end
                    -- print('plot', iPlotID, 'with region', plot.regionId, 'borders region', regionMap[ii])
                    plotBordersRegions[ii] = regionMap[ii]
                    if not tUniqueRegionsBordered[regionMap[ii]] then
                        tUniqueRegionsBordered[regionMap[ii]] = true
                    end
                elseif regionMap[ii] == -1 then
                    plot.bEdge = true
                end
            end
            plot.bordersRegions = plotBordersRegions
            local iBorderCount = 0
            for key, val in pairs(tUniqueRegionsBordered) do
                iBorderCount = iBorderCount + 1
            end
            plot.numRegionsBordered = iBorderCount
        end
    end
end

local function defineWaterRegions()
    local numWaterRegions = math.floor(tonumber(numTiles) * WaterRegionsPerPlot)
    slthLog(string.format("numTiles = %d, numWaterRegions = %d", numTiles, numWaterRegions))
    for i, region in ipairs(regionList) do slthLog(i, region.ID); end
    slthLog('first shuffle')
    regionList = ShuffleList(regionList)
    --Try to start with the region in the middle (there is a low chance that there isn't one)
    local middle_region_index = GetIndex(g_iW / 2, g_iH / 2)
    local regionID = regionMap[middle_region_index]
    if regionID == -1 then
        regionList[1].isWater = true
    else
        local region = tRegionIdMap[regionID]
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
        for _, nRegion in ipairs(regionList) do
            if nRegion.waterNeighborCount > 0 and nRegion.isWater == false then
                nRegion.isWater = true
                break
            end
        end
    end
    --Now fill any non-areas adjacent to water with the water area
    for _, region in ipairs(regionList) do
        if region.isWater then
            local regionExpanding = true
            while regionExpanding do
                regionExpanding = region:expandWaterRegion()
            end
        end
    end
end

function createRegions()
    --Growing the regions directly according to the map size created
    --unsolvable problems for the river system. Instead, I am growing
    --on a map (regionRxMap) that corresponds to rivers rather than
    --map tiles. This ensures rivers have a path from region to
    --region.
    -- math.randomseed(1)
    math.randomseed(os.time())
    currentRegion = -99
    g_IV_iW = g_iW
    g_IV_iH = g_iH + 1
    numTiles = (g_IV_iW ) * (g_IV_iH )
    numRx = (g_IV_iW) * (g_IV_iH)
    regionMap = {}
    regionRxMap = {}
    regionList = {}
    regionPlotList = {}
    regionPlotsInfo = {}
    regionNeighbours = buildNeighbourTable(g_iW, g_iH)
    seedRegions()           --The value for unplayable areas will remain -1. playable regions
                            --will stop growing when they touch a map edge.
    growRegions()           --Now cause the seeds to grow into regions

    convertRxToRegion()             -- Now convert regionRxMap to regionMap
    markBorders()
    defineWaterRegions()            --Now choose areas to be water
end



-- needs gate stuff defined first

local function getRiverIndex(x, y)
    local xx, yy
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

local isPlotFullyInRegion = {}
local function precomputeRegionChecks()
    for y = 0, g_iH - 1 do
        for x = 0, g_iW - 1 do
            local i = GetIndex(x, y)
            if i ~= -1 then
                local regionID = regionMap[i]
                if regionID then
                    isPlotFullyInRegion[i] = true
                    for direction=5, 8 do
                        local xx, yy = plotFromRx(x, y, direction)
                        local ii = GetIndex(xx, yy)
                        if ii == -1 or regionMap[ii] ~= regionID then
                            isPlotFullyInRegion[i] = false
                            break
                        end
                    end
                else
                    isPlotFullyInRegion[i] = false
                end
            end
        end
    end
end

local function gateFailLog(masterPlotID, num)
    if first_furlong == 1 then
        firstFailLessTwoMap[masterPlotID] = num
    elseif first_furlong == 2 then
        firstFailLessTwoMap[masterPlotID] = num+50
    else
        firstFailLessTwoMap[masterPlotID] = num+75
    end
end

local function isValidHalfGate(regionID, rxX, rxY)
    -- A valid half gate is a rx that is not in a region, touches
    -- only 2 regions and is 4-connected to an rx that is in the region
    local masterPlotID = GetIndex(rxX, rxY)
    local testPlotRegionId = regionMap[masterPlotID]
    if testPlotRegionId == -1 then return end
    local tPlotBorders = tRegionIdMap[testPlotRegionId]
    tPlotBorders = tPlotBorders['plotList']
    tPlotBorders = tPlotBorders[masterPlotID]
    if not tPlotBorders then
        print('finding plot', masterPlotID)
    end
    local iPlotRegionsBordered = tPlotBorders['numRegionsBordered']
    tPlotBorders = tPlotBorders['bordersRegions']
    if not gateRegionAdjacents[currentRegion][testPlotRegionId] then
        gateRegionAdjacents[currentRegion][testPlotRegionId] = true;
    end
    slthLog('plot check on ' .. masterPlotID)
    if iPlotRegionsBordered ~= 1 then
        local sBorderedPlots = ''
        local tRegionsAdjacent = {}
        if tPlotBorders then
            for _, val in pairs(tPlotBorders) do
                if not gateRegionAdjacents[currentRegion][val] then
                    gateRegionAdjacents[currentRegion][val] = true;
                end
                if not tRegionsAdjacent[val] then
                    sBorderedPlots = sBorderedPlots .. val .. ', '
                    tRegionsAdjacent[val] = true
                end
            end
        end
        gateFailLog(masterPlotID,100)
        return false
    end
    if isRxInRegion(rxX, rxY, regionID) then
        slthLog(string.format('RX %d/%d: %d has RX in region so fails',rxX, rxY, masterPlotID))
        for _, val in pairs(tPlotBorders) do
            if not gateRegionAdjacents[currentRegion][val] then
                gateRegionAdjacents[currentRegion][val] = true;
            end
        end
        gateFailLog(masterPlotID,200)
        return false
    end
    for direction=1, 4 do
        local xx = rxX + directionXmap[direction]
        local yy = rxY + directionYmap[direction]
        if isRxInRegion(xx, yy, regionID) then
            slthLog(string.format('RX %d/%d is valid half gate by RX being in region, it is not in region, but it touches %d regions',rxX, rxY, iPlotRegionsBordered))
            return true
        end
    end
    slthLog('RX is not valid half gate as RX was not in region in all 4 directions ')
    gateFailLog(masterPlotID,300)
    return false
end

local function isValidFullGate(regionID, rxX, rxY)
    first_furlong = 1
    if not isValidHalfGate(regionID, rxX, rxY) then
        return false
    end
    first_furlong = 2
    local region = tRegionIdMap[regionID]
    slthLog('neighbours of region count:', #(region.neighborList))
    for _, nRegionID in ipairs(region.neighborList) do
        slthLog('checking valid neighbours....')
        if isValidHalfGate(nRegionID, rxX, rxY) then
            slthLog('other adjacent region has valid gate')
            return true
        end
        first_furlong = 3
        for direction=1, 4 do
            local xx = rxX + directionXmap[direction]
            local yy = rxY + directionYmap[direction]
            if isValidHalfGate(nRegionID, xx, yy) then
                slthLog('alternate path valid gate, shouldnt work')
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
        local region = tRegionIdMap[regionID]
        if region.isWater == true then
            count = count + 1
        end
    end
    return count
end

function Region:getBorderPlotList(neighborID)
    local borderPlotList = {}
    local borderPlotCount = 0
    for plotID, plot in pairs(self.plotList) do
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
    -- This function is called in createRiverMap so the riverMap functions
    -- can be called from here. We now complile a list of all possible river
    -- gates
    self.gateList = {}
    currentRegion = self.ID
    gateRegionAdjacents[currentRegion] = {}
    local neighbors
    for plotID, plot in pairs(self.plotList) do             -- get plots of region
        if plot['bBorder'] then
            neighbors = regionNeighbours[plotID]
            for idx, nPlotID in ipairs(neighbors) do
                local bIsInSameRegion = self.plotList[nPlotID]        -- if plot region is not same
                if not bIsInSameRegion then
                    local nPlotInfo = regionPlotsInfo[nPlotID]
                    if nPlotInfo then                               -- TODO Fail forward, getting plots outside map size, why?
                        if isValidFullGate(currentRegion, nPlotInfo.x, nPlotInfo.y) then
                            local rPlot = {x=nPlotInfo.x, y=nPlotInfo.y, direction=-1, currentRegion}
                            table.insert(self.gateList, rPlot)
                            gateMap[GetIndex(nPlotInfo.x, nPlotInfo.y)] = 100
                            firstFailLessTwoMap[GetIndex(nPlotInfo.x, nPlotInfo.y)] = 500
                        else
                            gateAttemptMap[GetIndex(nPlotInfo.x, nPlotInfo.y)] = 100
                        end
                    end
                end
            end
        end
	end
end
function Region:expandWaterRegion()
    local expanded = false
    for plotID, plot in pairs(self.plotList) do
        for direction=1, 4 do
            local xx, yy = GetDirection(direction, plot)
            local ii = GetIndex(xx,yy)
            if ii ~= -1 and regionMap[ii] == -1 then
                local naPlot = {regionId=self.ID, x=xx, y=yy, gateRx=-1, bBorder=false, bEdge=false}
                regionMap[ii] = self.ID
                local iPlotID = GetIndex(xx, yy)
                self.plotList[iPlotID] = naPlot
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
        local region = tRegionIdMap[regionID]
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
    for iPlotID, bPlot in pairs(self.plotList) do
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
    for iPlotID, plot in pairs(self.plotList) do
        local distance = self.getDistanceToClosestBorderPlot(plot)
        if maxDistance < distance then
            maxDistance = distance
            center = plot
        end
    end
    return center
end


function ShuffleList(theList)
    for i = #theList, 2, -1 do
        local j = math.random(1, i)
        theList[i], theList[j] = theList[j], theList[i]
    end
    return theList
end

local function failedGateLog(failedGates)
    local failed_string = ''
    local iFailedCount = 0
    for key, val in pairs(failedGates) do
        if val == 'red' then
            failed_string = failed_string .. key .. ', '
            iFailedCount = iFailedCount + 1
        end
    end
    failed_string = failed_string .. ' Total: ' .. iFailedCount
    slthLog(failed_string)
    local iGlobalGateCount = 0
    for i, region in ipairs(regionList) do
        local gateString = ''
        local iGateCount = 0
        for j, gatePlot in ipairs(region.gateList) do
            gateString = gateString .. '(' .. gatePlot.x .. ',' .. gatePlot.y .. ')' .. ', '
            iGateCount = iGateCount + 1
        end
        iGlobalGateCount = iGlobalGateCount + iGateCount
        gateString = region.ID .. ' region gate count' .. iGateCount .. ':' .. gateString
        slthLog(gateString)
    end
    slthLog('total gate count:', iGlobalGateCount)
end

local function gateError(region, failedGates)
    slthLog('no valid gates')
    failedGates[region.ID] = 'red'
    if not bLogLow then
        changeLogLevel(true)
        slthLog(string.format('checking region %d', region.ID))
        slthLog('------------------------------------')
        region:defineValidGateList()
        bLogLow = true
    end
    local iAdjacentColors, iAllColors = {[currentRegion]='red'}, {[currentRegion]='red'}
    local iCount = 1
    local tColours = {"yellow", "cream", "orange", "deepblue", "brown", "pink", "white", "blue"}
    for j, _ in pairs(gateRegionAdjacents[currentRegion]) do
        iAllColors[j] = tColours[iCount]
        iAdjacentColors[j] = tColours[iCount]
        iCount = iCount + 1
        slthLog('for region', currentRegion, 'had adjacent region',j)
    end
    for _, region_ in ipairs(regionList) do
        if not iAdjacentColors[region_.ID] then
            iAdjacentColors[region_.ID] = "green"
        end
    end
    simpleSquareGridPrint(regionMap, 'FAIL_Gate_error' .. region.ID, iAdjacentColors, true, true)
    simpleSquareGridPrint(regionMap, 'FAIL_All_Regions' .. region.ID, iAllColors, true)
    bLogLow = false
    changeLogLevel(false)
end

local function initGateMap()
    gateMap = {}
    for key, val in ipairs(regionMap) do
        gateMap[key] = val
    end
    gateAttemptMap = {}
    for key, val in ipairs(regionMap) do
        gateAttemptMap[key] = val
    end

    firstFailLessTwoMap = {}
    for key, val in ipairs(regionMap) do
        firstFailLessTwoMap[key] = val
    end
end
------------------- RIVER ----------
local function defineGates()
    -- Now each region picks one gate that is not in the current gate line
    -- to avoid recursive loops water is considered gated for this purpose
    gateRegionAdjacents = {}
    local bLogLow = false
    initGateMap()
    local failedGates = {[100]='white'}
    for i, region in ipairs(regionList) do
        region:defineValidGateList()                -- regions should always have gates
        if #(region.gateList) == 0 then
            gateError(region, failedGates)
        end
    end
    simpleSquareGridPrint(flipVertical(gateMap), 'All_Gates', failedGates, true, true)
    simpleSquareGridPrint(flipVertical(gateAttemptMap), 'Gate_Tiles_Tried', {[100]='white'}, true, true)
     local contrast = {[100]="yellow", [150]="cream", [175]="orange", [200]="deepblue", [250]="brown",
             [275]="pink", [300]="white", [350]="peach", [375]="goldenrod"}
    local sliding_scale = {[100]="redscale1", [150]="redscale2", [175]="redscale3", [200]="redscale4", [250]="redscale5",
             [275]="redscale6", [300]="redscale7", [350]="redscale8", [375]="redscale9", [500]="white"}
    simpleSquareGridPrint(flipVertical(firstFailLessTwoMap), 'Classified_Gate_Fails', sliding_scale, true, true)
    failedGateLog(failedGates)
end

local function placeGates()
    local numRegions = #regionList
    local numGatesPlaced = 0
    local iterations = 0
    while numGatesPlaced < numRegions do
        if iterations > 10000 then
            print(string.format("Endless loop occured in gate placement, gates placed: %d, regions: %d", numGatesPlaced, numRegions))
            break
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
                            local gateRegion = tRegionIdMap[region.gateRegion]
                            region.altitude = gateRegion.altitude + 1
                            -- print(string.format("region %d gateRegion is %d", region.ID, region.gateRegion))
                        end
                        numGatesPlaced = numGatesPlaced + 1
                    else
                        -- print(string.format("Region %d has no gated neighbors", region.ID))
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
    local region = tRegionIdMap[regionID]
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
        if region.gatePlot then                                                         -- more fudge
            if isRxInRegion(x, y, regionID) or (x == region.gatePlot.x and y == region.gatePlot.y) then
                local i = getRiverIndex(x, y)
                if i ~= -1 and heightMap[i] < altitude then
                table.insert(possiblePaths, direction)
                end
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

local function initFlowMap()
    for i=1, ((g_iH + 1) * (g_iW + 1))-1 do
        table.insert(flowMap, -1)
        table.insert(heightMap, -1.0)
    end
end

local function setFlow()
    for _, region in ipairs(regionList) do
        if not region.isWater then
            slthLog("region.gateRegion =", region.gateRegion)
            local validGateList = region:getGateListToNeighbor(region.gateRegion) -- randomly choose an outflow gate
            if #validGateList  == 0 then
                print("For region %s validGateList == 0!!!!", region.ID)
            end
            if #validGateList > 1 then
                local partGatePlot = validGateList[math.random(1, #validGateList)]
                -- print('part gateplot is', partGatePlot['x'], partGatePlot['y'])
                region.gatePlot = partGatePlot
                local rxX, rxY = region.gatePlot.x, region.gatePlot.y
                local rxI = getRiverIndex(rxX, rxY)
                local iterations = 0
                local continuing = true
                while continuing do                 -- set flow so that it is pointing out of region
                    iterations = iterations + 1         -- NOTE this seems not to build a flow map, just get
                    if iterations > 100 then                -- the first direction of it
                        print("endless loop in gate setter")
                        break
                    end
                    local gateRegion = tRegionIdMap[region.gateRegion]
                    if gateRegion.isWater then
                        flowMap[rxI] = L
                        heightMap[rxI] = 0.01
                        continuing = false
                    end
                    if continuing then
                        local direction = math.random(1, 4)      -- pick random cardinal direction
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
    end
end

local function makeHeightMap()              --- Rewritten makeHeightMap with a more efficient queueing system.
    -- Now create heightmap. Start from each gate and increase altitude of
    -- neighbors by a random percentage, and then place each neighbor on a
    -- queue for similar processing. Randomize the queue order for each pass.
    -- This method should avoid lakes.
    precomputeRegionChecks()
    local currentPlots = {}         -- Place all gates on queue.
    for _, region in ipairs(regionList) do
        if region.gatePlot then
            table.insert(currentPlots, {x=region.gatePlot.x, y=region.gatePlot.y, direction=0,  regionID=region.ID})
        end
    end
    while #currentPlots > 0 do
        local nextPlots = {}        -- Create a table to hold the plots for the *next* iteration.
        -- print('Processing plots in current batch:', #currentPlots)
        for _, thisPlot in ipairs(currentPlots) do
            local rxI = getRiverIndex(thisPlot.x, thisPlot.y)
            if rxI ~= -1 then                                    -- processed altitude tile
                local altitude = heightMap[rxI]
                for direction=1, 4 do
                    local x, y = thisPlot.x + directionXmap[direction], thisPlot.y + directionYmap[direction]
                    local rxII = getRiverIndex(x, y)
                    -- If the new plot is valid, un-processed, and within the same region...
                    if rxII ~= -1 and heightMap[rxII] == -1.0 and isPlotFullyInRegion[rxII] then
                        -- ...calculate its height and add it to the list for the next iteration.
                        local randomScaler = 1.0 + math.random(1, 20) / 100.0
                        heightMap[rxII] = altitude * randomScaler
                        local newPlot = {x=x, y=y, regionID=thisPlot.regionID}
                        table.insert(nextPlots, newPlot)
                    end
                end
            end
        end
        currentPlots = ShuffleList(nextPlots)       -- The next iteration will process the plots we just generated.
    end                                             -- The list is shuffled to maintain the random propagation pattern.
    print('Height map generation complete.')
end

local function makeFlowPaths()      -- Create flow map
    simpleSquareGridPrint(flowMap, 'FlowMap_1', {[0]='red'})
    -- first time we need riverRegion stuff
    buildRiverRegionLookupTable()
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
    simpleSquareGridPrint(flowMap, 'FlowMap_2', {[0]='red'}, nil, true)
end

-- Dryness should be calculated by getting the highest altitude
-- region and making it's base the wettest region. Then eliminate
-- those regions from the list. Then get the highest of the remaining
-- regions and make it's base the dryest region.
local function calculateWetAndDry()         -- TODO when this function works, it makes something downstream iterate forever
    local local_regionList = {}
    for _, region in ipairs(regionList) do
        table.insert(local_regionList, region)
    end
    table.sort(local_regionList, function(a, b)     -- sorted by altitude, reversed
            return a.altitude > b.altitude
        end)
    local region = local_regionList[1]          -- start at highest altitude
    local wetSpotX, wetSpotY = 0,0
    local iter = 0
    print('region altitude was', region.altitude, type(region.altitude))
    while region.altitude > 0 and iter <= #local_regionList + 1  do
        region = tRegionIdMap[region.gateRegion]
        print('region altitude was', region.altitude)
        if region.altitude == 1 then
            wetSpotX, wetSpotY = plotFromRx(region.gatePlot.x, region.gatePlot.y, SW)
            print('wetSpotX/wetSpotY', wetSpotX, wetSpotY)
        end
        iter = iter +1
    end
    -- Now calculate moisture for each region
    local minMoisture = 1.0
    for _, pRegion in ipairs(regionList) do
        local gate = pRegion.gatePlot
        if gate then
            local distance = math.sqrt(math.abs(((gate.x - wetSpotX) * (gate.x - wetSpotX)) + ((gate.y - wetSpotY) * (gate.y - wetSpotY))))
            -- print('region moisture changed from', pRegion.moisture, 'to', 1.0 - distance / g_iW)
            pRegion.moisture = 1.0 - distance / g_iW
            minMoisture = math.min(pRegion.moisture, minMoisture)
        end
    end
    local scaler = 1.0 / (1.0 - minMoisture)
-- print('min moisture', minMoisture, 'scaler value', scaler)
    for _, pRegion in ipairs(regionList) do
        -- print('region moisture scaled from', pRegion.moisture, 'to',(pRegion.moisture - minMoisture) * scaler)
        pRegion.moisture = (pRegion.moisture - minMoisture) * scaler
    end
end

local function initRiverMap()
    riverMap = {}
    for i=1, ((g_iH + 1) * (g_iW + 1))-1 do                     -- should this be adjusted for python -> lua -1?
        table.insert(riverMap, 0)
    end
end

local function printAltitudes()
    local tCounts = {}
    for iPlotIndex, altitude in pairs(heightMap) do
        if not tCounts[altitude] then
            tCounts[altitude] = 1
        else
            tCounts[altitude] = tCounts[altitude] + 1
        end
    end
    for iAltitude, count in pairs(tCounts) do
        print('altitude', iAltitude, 'count:', count)
    end
end

local function applyRiverMap()
    for y=1, g_iH do
        for x=1, g_iW do
            local i = getRiverIndex(x, y)
            local direction = flowMap[i]
            local regionID = getRegion(x, y)
            if regionID ~= -1 and i< 2000 then          -- TODO REMOVE arbitrary limit
                local region = tRegionIdMap[regionID]
                local xx, yy, iter = x, y, 0
                while direction ~= -1 and direction ~= L and iter < 3 do
                    xx = xx + directionXmap[direction]
                    yy = yy + directionYmap[direction]
                    local ii = getRiverIndex(xx, yy)
                    riverMap[ii] = riverMap[ii] + MinRainfall + (1.0 - MinRainfall) * region.moisture
                    direction = flowMap[ii]
                    iter = iter + 1
                end
            end
        end
    end
end

-- =================================================================
-- ONE-TIME SETUP: Cache globals in local variables for the module
-- =================================================================
-- Map tables (cache them all)


-- Constants and Globals
local RiverW = g_iW + 1 -- Stride for the river index

-- Pre-define the directions to iterate over for getRegion
local region_check_directions = {SW, NE, NW, SE}

-- =================================================================
-- OPTIMIZED FUNCTIONS
-- =================================================================

local function getRegionOptimized(x, y)
    local local_regionMap = regionMap
    local local_tRegionIdMap = tRegionIdMap
    local local_rxXMap = rxXMap
    local local_rxYMap = rxYMap
    local base_xx = x + local_rxXMap[SW]
    local base_yy = y + local_rxYMap[SW]
    if base_xx < 0 or base_xx >= g_iW or base_yy < 0 or base_yy >= g_iH then return -1 end

    local regionID = local_regionMap[base_yy * g_iW + base_xx]
    if not regionID or regionID == -1 then return -1 end

    for _, direction in ipairs(region_check_directions) do
        local xx = x + local_rxXMap[direction]
        local yy = y + local_rxYMap[direction]

        if xx >= 0 and xx < g_iW and yy >= 0 and yy < g_iH then
            local i = yy * g_iW + xx
            local nRegionID = local_regionMap[i]
            if nRegionID and nRegionID ~= -1 then
                local nRegion = local_tRegionIdMap[nRegionID]
                if nRegion.gatePlot and x == nRegion.gatePlot.x and y == nRegion.gatePlot.y then
                    return nRegionID
                end
                if nRegionID ~= regionID then return -1 end
            end
        end
    end
    return regionID
end

function precomputeAllRegions()
    local regionCache = {}
    print("Starting region pre-computation...")
    for y = 0, g_iH do -- Iterate through all possible coordinates
        for x = 0, g_iW do
            -- GetIndex uses g_iW as its stride, matching this loop
            local index = y * g_iW + x
            regionCache[index] = getRegionOptimized(x, y)
        end
    end
    print("Region pre-computation complete.")
    return regionCache
end

local function applyRiverMapOptimized()
    local regionCache = precomputeAllRegions()
    for y=0, g_iH do
        for x=0, g_iW do
            local i = getRiverIndex(x, y)
            local direction = flowMap[i]
            local regionID = regionCache[i]
            if regionID ~= -1 then          -- TODO REMOVE arbitrary limit
                local region = tRegionIdMap[regionID]
                local xx, yy = x, y
                while direction ~= -1 and direction ~= L do
                    xx = xx + directionXmap[direction]
                    yy = yy + directionYmap[direction]
                    local ii = getRiverIndex(xx, yy)
                    riverMap[ii] = riverMap[ii] +( MinRainfall + (1.0 - MinRainfall) * region.moisture)
                    direction = flowMap[ii]
                end
            end
        end
    end
end

function createRiverMap()
    -- Start with an outflow from the region, then randomly decide which neighbors
    -- will flow into this square by how many choices that neighbor has. If the
    -- neighbor has only one choice, then the chance is 100 percent. At least
    -- one neighbor must be chosen unless it is not possible, otherwise the
    -- process might end before each tile is set. Then put each chosen neighbor
    -- on the stack to be processed the same way.
    heightMap = {}
    flowMap = {}
    initFlowMap()
    defineGates()
    placeGates()

    setFlow()
    printAltitudes()
    makeHeightMap()
    makeFlowPaths()
    calculateWetAndDry()
    initRiverMap()
    applyRiverMapOptimized()
    simpleGridPrint(riverMap, 'rivermap', {[1]='blue', [0]='green'}, nil, nil, true)         -- BEWARE: IF YOU HAVE TONS OF VALUES THIS DIES
    simpleGridPrint(flowMap, 'flowmap', {[1]='blue', [0]='green'}, nil, nil, true)
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

local function calculateRegion(x, y)            -- Used in AssignStartPlots      -- renamed from GetRegion, overriden
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
        if nRegionID and nRegionID ~= -1 then
            local nRegion = tRegionIdMap[nRegionID]
            if nRegion.gatePlot and x == nRegion.gatePlot.x and y == nRegion.gatePlot.y then
                return nRegionID
            end
            if nRegionID ~= regionID then
                invalidRegion = true
            end
        end
    end

    if invalidRegion or not regionID then
        return -1
    else
        return regionID
    end
end

function getRegion(x, y)
    local i = GetIndex(x, y)
    return riverRegionLookupTable[i] or -1
end

function buildRiverRegionLookupTable()
    riverRegionLookupTable = {}
    for y=1, g_iH do
        for x=1, g_iW do
            local index = GetIndex(x, y)
            riverRegionLookupTable[index] = calculateRegion(x, y)
        end
    end
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
            local nRegion = tRegionIdMap[nRegionID]
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
    local directions = {{NW, E, S, N, W}, { NE, W, S, N, E },
                        { SE, W, N, S, E }, { SW, E, N, S, W }}
    for _, dList in ipairs(directions) do
        local rxX,rxY = rxFromPlot(x, y, dList[1])
        local rxI = getRiverIndex(rxX,rxY)
        if flattenPeakSubFunc(x, y, rxI, dList[1], dList[2], dList[3], dList[4], dList[5]) then
            return true
        end
    end
end

local function IsPlotTouchingRiver(x, y)
    for direction=5, 8 do
        local rxX, rxY = rxFromPlot(x, y, direction)
        local rxI = getRiverIndex(rxX, rxY)             -- its fine we dont get rivers as some directions go outside map
        if riverMap[rxI] and riverMap[rxI] > RiverThreshold then
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
local function placeLandInWater(x,y)
    local i = GetIndex(x,y)
    local regionID = regionMap[i]
    if regionID == -1 then
        return false
    end
    local region = tRegionIdMap[regionID]
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
                                local nRegion = tRegionIdMap[nRegionID]
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
    local region = tRegionIdMap[regionID]
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
                local nRegion = tRegionIdMap[nRegionID]
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
        local region = tRegionIdMap[regionID]
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
    local region = tRegionIdMap[regionID]
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

local function initOceanPlots()
    local scrambledPlotList = {}
    local plot_total = 0
    for y=1, g_iH do
        for x=1, g_iW do
            table.insert(plotMap, OCEAN)
            table.insert(scrambledPlotList, {x,y})
            plot_total = plot_total+1
        end
    end
    return scrambledPlotList
end

local function placeBorderPeaks(scrambledPlotList)
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
            local region = tRegionIdMap[regionID]
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
    return borderMap
end

local function resettingRegions(scrambledPlotList)
    for n=1, #scrambledPlotList do
        local plot = scrambledPlotList[n]
        local x = plot[1]
        local y = plot[2]
        local i = GetIndex(x,y)
        local regionID = regionMap[i]
        if regionID and regionID ~= -1 then
            local region = tRegionIdMap[regionID]
            if region.isWater and plotMap[i] ~= OCEAN then
                for direction=1,4 do
                    local xx = x + directionXmap[direction]
                    local yy = y + directionYmap[direction]
                    local ii = GetIndex(xx,yy)
                    local nRegionID = regionMap[ii]
                    if nRegionID and nRegionID ~= -1 then
                        local nRegion = tRegionIdMap[nRegionID]
                        if not nRegion.isWater then
                            regionMap[i] = nRegionID
                            break
                        end
                    end
                end
            end
        end
    end
end

local function setPeaksLandHills(scrambledPlotList)
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
            if plotMap[i] ~= LAND then          -- now there's a chance to flatten it again!
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
end

local function fixBottomEdge()
    for i = 1, g_iW do
        slthLog('From/To: ', plotMap[i], plotMap[i + g_iW])
        plotMap[i] = plotMap[i + g_iW]
    end
end

local function softenPeaks()
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
end

local function applyAreaChanges(areaMap)
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
end

local function applyNewAreaChanges(area_region)
    for i=1, g_iW*g_iH do
        if area_region[i] and area_region[i] > 0 and area_region[i] ~= largest_region then
            if plotMap[i] ~= PEAK then
                slthLog('plot x was region y, changing to peak', i, area_region[i])
                plotMap[i] = PEAK
            end
        end
    end
end

function createPlotMap()
    plotMap = {}
    slthLog('map dimensions', g_iH, g_iW)

    local_regionList = regionList
    table.sort(local_regionList, function(a, b)
        return a.altitude > b.altitude
    end)
    highestRegionAltitude = local_regionList[1].altitude
    print('highest altitude', highestRegionAltitude)
    local scrambledPlotList = initOceanPlots()
    scrambledPlotList = ShuffleList(scrambledPlotList)
    slthLog('scrambled plots: ', #scrambledPlotList)
    local borderMap = placeBorderPeaks(scrambledPlotList)
    simpleGridPrint(borderMap, 'bordermap', {['3']='red', ['1']='green'})
    simpleGridPrint(plotMap, 'post_land_water_mountain', {[3]='red'})

    resettingRegions(scrambledPlotList)             -- last instance of changing regions, redo regionMap lookup?
    setPeaksLandHills(scrambledPlotList)
    fixBottomEdge()         -- fix silly bottom row.

    if SoftenPeakPercent > 0 then
        softenPeaks()
    end
    simpleGridPrint(plotMap, 'post_river_peaks', {[3]='red'})
    -- simpleGridPrint(plotMap, 'post soften peaks')
    -- Now make sure there are no passable areas that are blocked in

    -- local areaMap = AreaMap.new(g_iW, g_iH)
    -- areaMap:findImpassableAreas()
    -- simpleGridPrint(areaMap.areaMap, '3_Area Map')
    -- applyAreaChanges(areaMap)
    newArea = newAreaMap.new()
    mountain_blocked = newArea:get_grid_regions(plotMap, {PEAK})
    simpleGridPrint(mountain_blocked, 'post area map new', {[-20]='red'})
    largest_region = newArea:find_largest_region()
    -- apply new area changes
    applyNewAreaChanges(mountain_blocked)
    simpleGridPrint(plotMap, 'post fix impassable areas', {[HILLS]='green', [LAND]='green', [PEAK]='red'})
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
    local DESERT = 0
    local PLAINS = 1
    local ICE = 2
    local TUNDRA = 3
    local GRASS = 4
    local HILL = 5
    local COAST = 6
    local OCEAN_TERRAIN = 7
    local PEAK_TERRAIN = 8
    local MARSH = 9
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
    simpleGridPrint(terrainMap, 'post_terrain_init_ocean', {[4]='green', [6]='yellow', [7]='blue'})

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
    simpleGridPrint(terrainMap, 'post terrain biome',
            {[COAST]='blue', [OCEAN_TERRAIN]='deepblue', [GRASS]='green', [DESERT]='yellow', [PLAINS]='orange',
            [TUNDRA]='cream'})
    -- clean up desert peaks to avoid burning peaks all over the map

    for y=1,g_iH -1 do
        for x=1, g_iW-1 do
            local i = GetIndex(x, y)
            if plotMap[i] == PEAK then
                addTerrain(i, TUNDRA)
            end
        end
    end
    simpleGridPrint(terrainMap, 'post cleanup desert mountains')

    simpleGridPrint(plotMap,'plotType_post_terrain_gen')
    slthLog('terrain map dim', #terrainMap)
end

function GetRainfall(x, y)              -- used in main script.
    local rainfall = 0
    local i = GetIndex(x, y)
    local regionID = regionMap[i]
    if regionID ~= -1 then
        local region = tRegionIdMap[regionID]
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

local function placeRiversInPlot(x,y)
    local pPlot = Map.GetPlot(x, y)
    local xx,yy = rxFromPlot(x,y,NE)
    local ii = getRiverIndex(xx,yy)
    if ii > -1 and riverMap[ii] > RiverThreshold and flowMap[ii] == S then
        print('placing river', riverMap[ii], 'index',ii, 'using flowmap direction South')
        TerrainBuilder.SetWOfRiver(pPlot, true,FlowDirectionTypes.FLOWDIRECTION_SOUTH)
    end
    xx,yy = rxFromPlot(x,y,SW)
    ii = getRiverIndex(xx,yy)
    if ii > -1 and riverMap[ii] > RiverThreshold and flowMap[ii] == E then
        print('placing river', riverMap[ii], 'index',ii, 'using flowmap direction East')
        TerrainBuilder.SetNEOfRiver(pPlot, true, FlowDirectionTypes.FLOWDIRECTION_SOUTHEAST)
    end
    xx,yy = rxFromPlot(x,y,SE)
    ii = getRiverIndex(xx,yy)
    if ii > -1 and riverMap[ii] > RiverThreshold and flowMap[ii] == N then
        print('placing river', riverMap[ii], 'index',ii, 'using flowmap direction North')
        TerrainBuilder.SetWOfRiver(pPlot, true,FlowDirectionTypes.FLOWDIRECTION_NORTH)
    elseif ii > -1 and riverMap[ii] > RiverThreshold and flowMap[ii] == W then
        print('placing river', riverMap[ii], 'index',ii, 'using flowmap direction West')
        TerrainBuilder.SetNEOfRiver(pPlot, true,FlowDirectionTypes.FLOWDIRECTION_NORTHWEST)
    end
    -- two west, two north???
end
--[[
function makeErebusRivers()
    -- unlike IV, rivers have IDs we need to set.
    -- precompute rivers by adjacency?
    -- slightly more complicated than that, since also branchs right?
    for y=1, g_iH do
        for x=1, g_iW do
            placeRiversInPlot(x,y)
        end
    end
end
]]

