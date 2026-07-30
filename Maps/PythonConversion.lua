if not Game then
    require('mobdebug').coro()
end

local SoftenPeakPercent = 0.0           -- percentage of peaks into hills in order to break up the worlds valleys.
local RiverThreshold = 5.0      -- drainage needed before water shapes the terrain
-- Drainage needed before a river is actually DRAWN. Deliberately separate from
-- RiverThreshold: the terrain rules (pass carving, rainfall, altitude) want to
-- know whether any water runs here at all, while rendering only wants channels
-- big enough to look like rivers. Driving both off one number forces a choice
-- between waterlogged maps and mountain mazes -- at a shared 40.0 the rivers
-- look right but 30 pct of the land ends up walled off.
local RiverDrawThreshold = 20.0

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

-- Square corner adapter, still used by the gate / height / flow code below.
-- The hex vertex lattice further down is built and verified but NOT yet wired
-- in -- the in-progress rebase lives in PythonConversion.HEX_WIP.lua.
local RX_CORNER_PLOT_DIRS = {NE, NW, SE, SW}  -- plots that share a corner
local RX_STEP_DIRS        = {N, S, E, W}      -- corner -> adjacent corner
local RX_REGIONS_AT_GATE  = 2                 -- a gate corner spans exactly 2 regions

-- ===========================================================================
-- HEX VERTEX LATTICE
--
-- The river layer works on tile CORNERS, not tiles: a river runs corner to
-- corner, so every flow step traverses exactly one tile edge, and a gate (hence
-- a mountain pass) is a corner where two regions meet.
--
-- This used to model corners as a square (W+1)x(H+1) grid, 4 tiles per corner,
-- 4 corner-neighbours. Civ VI is hexagonal and that is simply a different
-- lattice:
--
--     * 3 tiles meet at a vertex, not 4
--     * there are 2 vertices per hex, not 1 corner per tile
--     * each vertex has exactly 3 vertex-neighbours, not 4
--
-- The 3-valence is what matters most. Civ VI requires a river to turn +/-60
-- degrees on EVERY step (see TurnLeft/TurnRightFlowDirections in the base game's
-- RiversLakes.lua) -- it may never run straight. On a 3-valent vertex graph that
-- is automatic: arriving along one edge, the other two are exactly the +/-60
-- turns, and the third option is reverse, which downhill flow already excludes.
-- On the old square lattice half of all junctions were illegal, which is why
-- rivers rendered as doubled lines and source caps.
--
-- Vertices are identified by the SORTED TRIPLE of plot indices touching them,
-- and adjacency is derived from that (two vertices are adjacent exactly when
-- they share two plots -- those two plots name the edge between them). Deriving
-- it this way rather than hand-rolling offset algebra means the lattice cannot
-- silently disagree with the game's own idea of adjacency.
--
-- Every hex owns two vertices: its TOP (north) corner, shared with its NW and NE
-- neighbours, and its BOT (south) corner, shared with its SW and SE neighbours.
-- Those two families tile every vertex exactly once.
-- ===========================================================================

-- Pointy-top offset neighbours. This is the single place the parity convention
-- lives; verifyHexLattice() below checks it against Map.GetAdjacentPlot.
local HEX_E, HEX_W, HEX_NE, HEX_NW, HEX_SE, HEX_SW = 1, 2, 3, 4, 5, 6
local HEX_DIRS = {HEX_E, HEX_W, HEX_NE, HEX_NW, HEX_SE, HEX_SW}
local HEX_OPPOSITE = {[HEX_E]=HEX_W, [HEX_W]=HEX_E, [HEX_NE]=HEX_SW,
                      [HEX_SW]=HEX_NE, [HEX_NW]=HEX_SE, [HEX_SE]=HEX_NW}

local function hexNeighbourXY(x, y, dir)
    local odd = (y % 2 == 1)
    local dx, dy
    if     dir == HEX_E  then dx, dy = 1, 0
    elseif dir == HEX_W  then dx, dy = -1, 0
    elseif dir == HEX_NE then dx, dy = (odd and 1 or 0), 1
    elseif dir == HEX_NW then dx, dy = (odd and 0 or -1), 1
    elseif dir == HEX_SE then dx, dy = (odd and 1 or 0), -1
    elseif dir == HEX_SW then dx, dy = (odd and 0 or -1), -1
    else return nil, nil end
    local nx, ny = x + dx, y + dy
    if nx < 0 or nx >= g_iW or ny < 0 or ny >= g_iH then return nil, nil end
    return nx, ny
end

local function hexNeighbourIndex(x, y, dir)
    local nx, ny = hexNeighbourXY(x, y, dir)
    if not nx then return -1 end
    return ny * g_iW + nx
end

function plotXY(i)
    local y = math.floor(i / g_iW)
    return i - y * g_iW, y
end

-- Approximate screen position, used only to name a flow direction from a step.
local function plotPos(i)
    local x, y = plotXY(i)
    return x + (y % 2) * 0.5, y * 0.8660254
end

-- The lattice itself, built once per map.
local vertexPlots       = {}   -- vertexID -> {plotA, plotB, plotC} sorted
local vertexNeighbours  = {}   -- vertexID -> { {v=otherID, a=plot, b=plot}, ... }
local vertexPos         = {}   -- vertexID -> {fx, fy}
local vertexOfPlotTop   = {}   -- plotIndex -> vertexID
local vertexOfPlotBot   = {}
local plotVertices      = {}   -- plotIndex -> { vertexID, ... } (its 6 corners)
local vertexCount       = 0

-- Accessors. Everything downstream goes through these, so the lattice can be
-- swapped without touching gate / height / flow logic.
function hexVertexCount()          return vertexCount end
function hexVertexPlots(id)        return vertexPlots[id] end
function hexVertexNeighbours(id)   return vertexNeighbours[id] or {} end
function hexVertexPos(id)          return vertexPos[id] end
function hexPlotVertices(i)        return plotVertices[i] or {} end

local function tripleKey(a, b, c)
    local t = {a, b, c}
    table.sort(t)
    return t[1] .. "_" .. t[2] .. "_" .. t[3], t
end

function buildHexLattice()
    vertexPlots, vertexNeighbours, vertexPos = {}, {}, {}
    vertexOfPlotTop, vertexOfPlotBot, vertexCount = {}, {}, 0
    plotVertices = {}
    local byKey = {}

    local function makeVertex(pa, pb, pc)
        local key, t = tripleKey(pa, pb, pc)
        local id = byKey[key]
        if not id then
            vertexCount = vertexCount + 1
            id = vertexCount
            byKey[key] = id
            vertexPlots[id] = t
            local fx, fy = 0, 0
            for _, p in ipairs(t) do
                local px, py = plotPos(p)
                fx, fy = fx + px / 3, fy + py / 3
            end
            vertexPos[id] = {fx, fy}
        end
        return id
    end

    -- Only vertices whose three plots are all on the map are usable; a vertex
    -- hanging off the edge has no well-defined region set.
    for y = 0, g_iH - 1 do
        for x = 0, g_iW - 1 do
            local i = y * g_iW + x
            local nw, ne = hexNeighbourIndex(x, y, HEX_NW), hexNeighbourIndex(x, y, HEX_NE)
            if nw ~= -1 and ne ~= -1 then
                vertexOfPlotTop[i] = makeVertex(i, nw, ne)
            end
            local sw, se = hexNeighbourIndex(x, y, HEX_SW), hexNeighbourIndex(x, y, HEX_SE)
            if sw ~= -1 and se ~= -1 then
                vertexOfPlotBot[i] = makeVertex(i, sw, se)
            end
        end
    end

    -- Adjacency: two vertices are neighbours exactly when they share two plots.
    local byPair = {}
    for id, t in ipairs(vertexPlots) do
        for m = 1, 3 do
            for n = m + 1, 3 do
                local pk = t[m] .. "_" .. t[n]
                byPair[pk] = byPair[pk] or {}
                table.insert(byPair[pk], id)
            end
        end
    end
    for id, t in ipairs(vertexPlots) do
        for _, p in ipairs(t) do
            plotVertices[p] = plotVertices[p] or {}
            table.insert(plotVertices[p], id)
        end
    end

    for id = 1, vertexCount do vertexNeighbours[id] = {} end
    for pk, list in pairs(byPair) do
        if #list == 2 then
            local a, b = pk:match("^(%d+)_(%d+)$")
            a, b = tonumber(a), tonumber(b)
            table.insert(vertexNeighbours[list[1]], {v = list[2], a = a, b = b})
            table.insert(vertexNeighbours[list[2]], {v = list[1], a = a, b = b})
        end
    end
    return vertexCount
end

-- Sanity check the parity convention against the game's own adjacency, and the
-- lattice invariants. Cheap, and catches a flipped offset immediately instead of
-- letting it produce a subtly wrong map.
function verifyHexLattice()
    local problems = {}
    if Map and Map.GetAdjacentPlot and DirectionTypes then
        local mapping = {
            [HEX_E]  = DirectionTypes.DIRECTION_EAST,
            [HEX_W]  = DirectionTypes.DIRECTION_WEST,
            [HEX_NE] = DirectionTypes.DIRECTION_NORTHEAST,
            [HEX_NW] = DirectionTypes.DIRECTION_NORTHWEST,
            [HEX_SE] = DirectionTypes.DIRECTION_SOUTHEAST,
            [HEX_SW] = DirectionTypes.DIRECTION_SOUTHWEST,
        }
        local checked, mismatch = 0, 0
        for y = 1, g_iH - 2, 7 do
            for x = 1, g_iW - 2, 7 do
                for dir, gameDir in pairs(mapping) do
                    local nx, ny = hexNeighbourXY(x, y, dir)
                    local p = Map.GetAdjacentPlot(x, y, gameDir)
                    checked = checked + 1
                    if p and nx then
                        if p:GetX() ~= nx or p:GetY() ~= ny then mismatch = mismatch + 1 end
                    elseif p or nx then
                        mismatch = mismatch + 1
                    end
                end
            end
        end
        if mismatch > 0 then
            problems[#problems+1] = string.format(
                "hex parity disagrees with Map.GetAdjacentPlot on %d of %d samples", mismatch, checked)
        end
    end
    local badPlots, badNbrs = 0, 0
    for id = 1, vertexCount do
        if #vertexPlots[id] ~= 3 then badPlots = badPlots + 1 end
        local n = #vertexNeighbours[id]
        if n > 3 then badNbrs = badNbrs + 1 end
    end
    if badPlots > 0 then problems[#problems+1] = badPlots .. " vertices not touching exactly 3 plots" end
    if badNbrs  > 0 then problems[#problems+1] = badNbrs  .. " vertices with more than 3 neighbours" end
    if #problems > 0 then
        print("Erebus: HEX LATTICE PROBLEMS -- " .. table.concat(problems, "; "))
        return false
    end
    return true
end

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
        -- Strict upper bound. x == g_iW used to be accepted and wrapped into the
        -- next row; every plot loop is 0-based now so that can be rejected.
        if x < 0 or x >= g_iW or y < 0 or y >= g_iH then
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
    for y = 0, height - 1 do
        for x = 0, width - 1 do
            local i = GetIndex(x, y)
            local neighbours = {}
            for dy = -1, 1 do
                local ny = y + dy
                if ny >= 0 and ny <= height - 1 then
                    for dx = -1, 1 do
                        local nx = x + dx
                        if not (dx == 0 and dy == 0) and nx >= 0 and nx <= width - 1 then
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
    for i = 0, numTiles - 1 do regionMap[i] = -1 end
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
    for y=0, g_iH do
        for x=0, g_iW do
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
    for i=0, numTiles - 1 do
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
    -- PRNG is seeded once in GenerateMap from Civ's map seed. It used to be
    -- reseeded here from os.time(), which meant the same map seed produced a
    -- different map every run (and two runs inside the same second produced the
    -- same one) -- so Civ's "Map Seed = N" never actually controlled anything.
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

-- ---------------------------------------------------------------------------
-- VERTEX-SPACE PRIMITIVES
--
-- A vertex is a single integer id from the hex lattice above. heightMap,
-- flowMap and riverMap are all keyed by it, and flowMap[v] holds the NEXT
-- VERTEX ID rather than a compass direction -- on a 3-valent lattice the
-- direction is implied by which neighbour you moved to, and storing the target
-- directly is what makes river placement exact.
-- ---------------------------------------------------------------------------

local function isVertexInRegion(v, regionID)
    -- All three tiles touching the vertex must be in the region. A vertex on a
    -- region border is deliberately NOT "in" either region.
    local t = vertexPlots[v]
    if not t then return false end
    for k = 1, 3 do
        if regionMap[t[k]] ~= regionID then return false end
    end
    return true
end

local function isVertexTouchingRegion(v, regionID)
    local t = vertexPlots[v]
    if not t then return false end
    for k = 1, 3 do
        if regionMap[t[k]] == regionID then return true end
    end
    return false
end

local function isValidHalfGate(regionID, v)
    -- A valid half gate is a VERTEX that:
    --   * has a region on every tile touching it,
    --   * spans exactly RX_REGIONS_AT_GATE regions (a two-region border, not a
    --     three-way junction),
    --   * is not itself fully inside regionID, and
    --   * is adjacent to a vertex that IS fully inside regionID.
    local t = vertexPlots[v]
    if not t then return false end
    local seen, nRegions = {}, 0
    for k = 1, 3 do
        local plotRegion = regionMap[t[k]]
        if plotRegion == nil or plotRegion == -1 then return false end
        if not seen[plotRegion] then
            seen[plotRegion] = true
            nRegions = nRegions + 1
        end
    end
    if nRegions ~= RX_REGIONS_AT_GATE then return false end
    if isVertexInRegion(v, regionID) then return false end
    for _, e in ipairs(vertexNeighbours[v] or {}) do
        if isVertexInRegion(e.v, regionID) then return true end
    end
    return false
end

local function isValidFullGate(regionID, v)
    -- A full gate is a half gate for this region that also sits on the border
    -- with a real neighbour region, so a river can cross out of here.
    --
    -- The square version asked the OTHER region to be a half gate too. That is
    -- unsatisfiable on a hex lattice: a two-region vertex splits its three tiles
    -- 2/1, and the minority region can never have a neighbouring vertex wholly
    -- inside it (any neighbour shares two of this vertex's tiles, at most one of
    -- which is the minority one). Asking instead that the far side simply BE an
    -- adjacent region keeps the intent -- water can cross here -- without the
    -- impossible symmetry.
    if not isValidHalfGate(regionID, v) then return false end
    local region = tRegionIdMap[regionID]
    if not region then return false end
    local t = vertexPlots[v]
    for k = 1, 3 do
        local other = regionMap[t[k]]
        if other and other ~= -1 and other ~= regionID then
            for _, nRegionID in ipairs(region.neighborList) do
                if nRegionID == other then return true end
            end
        end
    end
    return false
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
    self.gateVertex = nil
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
        if isVertexTouchingRegion(rPlot, neighborID) then
            table.insert(gateListToNeighbor, rPlot)
        end
    end
    slthLog(string.format("%d gates from %d to %d", #gateListToNeighbor, self.ID, neighborID))
    return gateListToNeighbor
end

function Region:defineValidGateList()
    -- Every vertex this region could drain through. Gates are vertices, so this
    -- walks the vertex lattice, not the region's tiles.
    self.gateList = {}
    for v = 1, hexVertexCount() do
        if isVertexTouchingRegion(v, self.ID) and isValidFullGate(self.ID, v) then
            table.insert(self.gateList, v)
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

------------------- RIVER ----------
local function defineGates()
    local totalGates, starved = 0, {}
    for _, region in ipairs(regionList) do
        region:defineValidGateList()
        totalGates = totalGates + #region.gateList
        if #region.gateList == 0 then
            starved[#starved+1] = region.ID
        end
    end
    print(string.format("Erebus: %d gates across %d regions", totalGates, #regionList))
    if #starved > 0 then
        print("Erebus: WARNING regions with no valid gate: " .. table.concat(starved, ", "))
    end

    -- Debug overlay: mark the tiles around every gate corner.
    local gateMap = {}
    for i, v in ipairs(regionMap) do gateMap[i] = v end
    for _, region in ipairs(regionList) do
        for _, gate in ipairs(region.gateList) do
            for _, p in ipairs(hexVertexPlots(gate) or {}) do
                gateMap[p] = 100
            end
        end
    end
    simpleSquareGridPrint(flipVertical(gateMap), 'All_Gates', {[100]='white'}, true, true)
end

local function placeGates()
    -- Assign each land region the neighbour it drains into.
    --
    -- This is a multi-source BFS outward from the water regions over the graph
    -- of "regions with a valid gate between them". Two properties matter:
    --   * it terminates in O(V+E) -- the old shuffled retry loop spun until an
    --     iteration cap whenever any region had no reachable gate, and
    --   * the resulting gateRegion graph is a FOREST rooted at water, so
    --     following gateRegion (or flow downhill) can never cycle. Every
    --     later loop over the flow field depends on that.
    for _, region in ipairs(regionList) do
        region.gateRegion = -1
        region.altitude   = 0
    end

    local frontier = {}
    for _, region in ipairs(regionList) do
        if region.isWater then
            region.altitude = 0
            frontier[#frontier+1] = region
        end
    end
    if #frontier == 0 then
        print("Erebus: WARNING no water regions -- nothing to drain into")
        return
    end

    local settled = #frontier
    while #frontier > 0 do
        local nextFrontier = {}
        for _, downstream in ipairs(ShuffleList(frontier)) do
            local neighbours = {}
            for _, nID in ipairs(downstream.neighborList) do neighbours[#neighbours+1] = nID end
            for _, nID in ipairs(ShuffleList(neighbours)) do
                local upstream = tRegionIdMap[nID]
                if upstream and not upstream.isWater and upstream.gateRegion == -1
                   and #upstream:getGateListToNeighbor(downstream.ID) > 0 then
                    upstream.gateRegion = downstream.ID
                    upstream.altitude   = downstream.altitude + 1
                    nextFrontier[#nextFrontier+1] = upstream
                    settled = settled + 1
                end
            end
        end
        frontier = nextFrontier
    end

    if settled < #regionList then
        -- Left deliberately ungated rather than force-attached: attaching a
        -- stranded region to an arbitrary neighbour can close a gateRegion
        -- cycle, which is exactly what makes the flow walk hang. Downstream
        -- code tolerates gateRegion == -1.
        local stranded = {}
        for _, region in ipairs(regionList) do
            -- Water regions are the roots of the BFS and never get a
            -- gateRegion of their own; only land counts as stranded.
            if not region.isWater and region.gateRegion == -1 then
                stranded[#stranded+1] = region.ID
            end
        end
        if #stranded > 0 then
            print(string.format("Erebus: WARNING %d region(s) could not be drained to water: %s",
                                #stranded, table.concat(stranded, ", ")))
        end
    end
end

local function getPossiblePaths(v)
    -- Every returned neighbour is STRICTLY LOWER. Heights are globally monotone
    -- away from the sea (region band from the gate forest, plus a rise that
    -- stays inside the band), so this one rule covers movement within a region
    -- AND across a gate. A cycle would need h(a) > h(b) > ... > h(a), so it
    -- cannot occur -- do not relax the < comparison.
    local paths = {}
    local altitude = heightMap[v]
    if altitude == nil or altitude < 0 then return paths end
    for _, e in ipairs(vertexNeighbours[v] or {}) do
        local h = heightMap[e.v]
        if h and h >= 0 and h < altitude then
            paths[#paths+1] = e.v
        end
    end
    return paths
end

local function initFlowMap()
    flowMap, heightMap = {}, {}
    for v = 1, hexVertexCount() do
        flowMap[v]   = 0        -- 0 = no outflow (terminates a river)
        heightMap[v] = -1.0
    end
end

local function setFlow()
    -- Pick each land region's outflow vertex and point it out of the region.
    -- That vertex is the region's low point and the sink every river inside the
    -- region descends to.
    for _, region in ipairs(regionList) do
        if not region.isWater and region.gateRegion ~= -1 then
            local validGateList = region:getGateListToNeighbor(region.gateRegion)
            if #validGateList == 0 then
                print(string.format("Erebus: region %d drains to %d but has no gate to it",
                                    region.ID, region.gateRegion))
            else
                local gv = validGateList[math.random(1, #validGateList)]
                region.gateVertex = gv
                -- Base the gate at the region's depth in the gate forest, so
                -- height rises globally with distance from the sea. Every region
                -- used to start at 0.01, which made a gate LOWER than the region
                -- it drains into -- water then flowed straight back and cycled.
                heightMap[gv] = region.altitude
                -- No explicit outflow direction here any more. setFlow used to
                -- point the gate at an arbitrary neighbour touching the
                -- downstream region without comparing heights -- an uphill step,
                -- and exactly what made the flow field cycle. With a globally
                -- monotone field, the gate's downhill neighbour is just found by
                -- makeFlowPaths like every other step.
            end
        end
    end
end

-- Seed every vertex touching a water region at height 0 -- the sea is the floor
-- of the whole height field. Without this, land bands started at altitude 1 and
-- nothing was lower, so flow stopped at the last land vertex: rivers ended
-- wherever the descent ran out rather than at a mouth. That produced many short
-- landlocked systems instead of a few long ones, which is the root of both the
-- pockmarked spring-heads and the fragmentation.
local function seedOceanSinks()
    local seeded = 0
    for v = 1, hexVertexCount() do
        if heightMap[v] == -1.0 then
            for _, plot in ipairs(hexVertexPlots(v) or {}) do
                local rid = regionMap[plot]
                local region = rid and rid ~= -1 and tRegionIdMap[rid]
                if region and region.isWater then
                    heightMap[v] = 0.0
                    seeded = seeded + 1
                    break
                end
            end
        end
    end
    print(string.format("Erebus: seeded %d ocean-adjacent vertices as river mouths", seeded))
end

local function makeHeightMap()
    -- Rise outward from each gate, every step strictly higher than its parent.
    -- That strictness is what makes the downhill flow field acyclic.
    local current = {}
    for _, region in ipairs(regionList) do
        if region.gateVertex then
            current[#current+1] = {v = region.gateVertex, regionID = region.ID,
                                   ceiling = region.altitude + 1}
        end
    end
    local filled = 0
    while #current > 0 do
        local nextWave = {}
        for _, cur in ipairs(current) do
            local altitude = heightMap[cur.v]
            for _, e in ipairs(vertexNeighbours[cur.v] or {}) do
                if heightMap[e.v] == -1.0 and isVertexTouchingRegion(e.v, cur.regionID) then
                    -- Rise toward, but never reach, the next band up. This keeps
                    -- each region inside [altitude, altitude+1) so bands never
                    -- overlap and the field stays globally monotone.
                    heightMap[e.v] = altitude
                                     + (cur.ceiling - altitude) * (math.random(1, 20) / 100.0)
                    filled = filled + 1
                    nextWave[#nextWave+1] = {v = e.v, regionID = cur.regionID,
                                             ceiling = cur.ceiling}
                end
            end
        end
        current = ShuffleList(nextWave)
    end
    print(string.format('Erebus: height map filled %d vertices from %d gates.',
                        filled, #regionList))
end

local function makeFlowPaths()
    buildRiverRegionLookupTable()
    for v = 1, hexVertexCount() do
        local paths = getPossiblePaths(v)
        if #paths > 0 then
            flowMap[v] = paths[math.random(1, #paths)]
        end
    end
end

-- Dryness should be calculated by getting the highest altitude region and
-- making its base the wettest region.
local function calculateWetAndDry()
    local sorted = {}
    for _, region in ipairs(regionList) do sorted[#sorted+1] = region end
    table.sort(sorted, function(a, b) return a.altitude > b.altitude end)

    local region = sorted[1]
    local wetX, wetY = 0, 0
    local visited = {}
    while region and region.altitude > 0 and not visited[region.ID] do
        visited[region.ID] = true
        if region.altitude == 1 and region.gateVertex then
            local pos = hexVertexPos(region.gateVertex)
            if pos then wetX, wetY = pos[1], pos[2] end
            break
        end
        if region.gateRegion == -1 then break end
        region = tRegionIdMap[region.gateRegion]
    end

    local minMoisture = 1.0
    for _, pRegion in ipairs(regionList) do
        if pRegion.gateVertex then
            local pos = hexVertexPos(pRegion.gateVertex)
            if pos then
                local dx, dy = pos[1] - wetX, pos[2] - wetY
                pRegion.moisture = 1.0 - math.sqrt(dx*dx + dy*dy) / g_iW
                minMoisture = math.min(pRegion.moisture, minMoisture)
            end
        end
    end
    local scaler = 1.0 / (1.0 - minMoisture)
    for _, pRegion in ipairs(regionList) do
        pRegion.moisture = (pRegion.moisture - minMoisture) * scaler
    end
end

local function initRiverMap()
    riverMap = {}
    for v = 1, hexVertexCount() do riverMap[v] = 0 end
end

local function applyRiverMap()
    -- Walk downhill from every vertex, accumulating drainage. Termination rests
    -- on the flow field being strictly downhill and the gate graph being a
    -- forest rooted at water. The step cap is a tripwire, not the mechanism.
    local maxSteps = hexVertexCount()
    local runaway = 0
    for v = 1, hexVertexCount() do
        local regionID = getRegion(v)
        if regionID ~= -1 then
            local region = tRegionIdMap[regionID]
            if region then
                local contribution = MinRainfall + (1.0 - MinRainfall) * region.moisture
                local cur, steps = flowMap[v], 0
                while cur and cur ~= 0 do
                    steps = steps + 1
                    if steps > maxSteps then runaway = runaway + 1 break end
                    riverMap[cur] = (riverMap[cur] or 0) + contribution
                    cur = flowMap[cur]
                end
            end
        end
    end
    if runaway > 0 then
        print(string.format(
            "Erebus: WARNING %d flow walks exceeded lattice size -- flow field has a cycle",
            runaway))
    end
end

function createRiverMap()
    buildHexLattice()
    verifyHexLattice()
    initFlowMap()
    defineGates()
    placeGates()
    setFlow()
    seedOceanSinks()
    makeHeightMap()
    makeFlowPaths()
    calculateWetAndDry()
    initRiverMap()
    applyRiverMap()
end

-- (rxFromPlot / fillInLake / isLake / isOutFlowGate removed: square-corner
-- helpers, all unused, superseded by the hex vertex lattice.)

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

-- Region a vertex belongs to. Border vertices belong to no region, except the
-- vertex that is a region's own gate.
local function calculateRegion(v)
    -- Majority of the three tiles. A border vertex used to resolve to -1, which
    -- meant it contributed no drainage and rivers could not run along or across
    -- a region boundary at all.
    local t = vertexPlots[v]
    if not t then return -1 end
    local a, b, c = regionMap[t[1]], regionMap[t[2]], regionMap[t[3]]
    if a ~= nil and a ~= -1 and (a == b or a == c) then return a end
    if b ~= nil and b ~= -1 and b == c then return b end
    if a ~= nil and a ~= -1 then return a end
    if b ~= nil and b ~= -1 then return b end
    if c ~= nil and c ~= -1 then return c end
    return -1
end

function getRegion(v)
    return riverRegionLookupTable[v] or -1
end

function buildRiverRegionLookupTable()
    riverRegionLookupTable = {}
    for v = 1, hexVertexCount() do
        riverRegionLookupTable[v] = calculateRegion(v)
    end
end

-- (getRiverRegionByID removed: deprecated square-corner duplicate of
-- calculateRegion, and the last reader of the old gatePlot field.)

---- PLOT MAP -----------
--- Locals
-- A river must not run between two mountains: that would wall the pass shut
-- again. If a river runs along any of this tile's corners and a neighbouring
-- tile is also a peak, this one gets flattened so the water -- and the pass --
-- stays open.
local function shouldFlattenRiverPeak(x, y)
    local i = GetIndex(x, y)
    if i == -1 then return false end
    local onRiver = false
    for _, v in ipairs(hexPlotVertices(i)) do
        if (riverMap[v] or 0) > RiverThreshold then onRiver = true break end
    end
    if not onRiver then return false end
    for _, dir in ipairs(HEX_DIRS) do
        local n = hexNeighbourIndex(x, y, dir)
        if n ~= -1 and plotMap[n] == PEAK then return true end
    end
    return false
end

local function IsPlotTouchingRiver(x, y)
    local i = GetIndex(x, y)
    if i == -1 then return false end
    for _, v in ipairs(hexPlotVertices(i)) do
        if (riverMap[v] or 0) > RiverThreshold then return true end
    end
    return false
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
    local i = GetIndex(x, y)
    if i == -1 then return 0.0 end
    local verts = hexPlotVertices(i)
    if #verts == 0 then return 0.0 end
    local total = 0.0
    for _, v in ipairs(verts) do total = total + (riverMap[v] or 0) end
    return total / #verts
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
    for y=0, g_iH - 1 do
        for x=0, g_iW - 1 do
            plotMap[GetIndex(x, y)] = OCEAN      -- keyed by GetIndex, not append order
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

-- (fixBottomEdge removed. It overwrote row 0 with row 1 to paper over the old
-- 1-based plot loops never generating row 0. The loops are 0-based now, so row 0
-- is real data and copying over it would discard it.)

local function softenPeaks()
    for y=0,g_iH - 1 do
        for x= 0,g_iW - 1 do
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
    for i=0, g_iW*g_iH - 1 do
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
    -- Anything walled off from the main body of the map gets filled in with
    -- mountains. Ocean counts as traversable, so this seals land pockets that
    -- no river gate ever opened a pass into.
    --
    -- The count below is the health check on the whole gate/river/pass chain:
    -- if a lot of land is being sacrificed here, gates are not producing
    -- passes and the map is a mountain maze.
    local sealed, totalLand = 0, 0
    for i=0, g_iW*g_iH - 1 do
        if plotMap[i] == LAND or plotMap[i] == HILLS then totalLand = totalLand + 1 end
        if area_region[i] and area_region[i] > 0 and area_region[i] ~= largest_region then
            if plotMap[i] ~= PEAK then
                slthLog('plot x was region y, changing to peak', i, area_region[i])
                plotMap[i] = PEAK
                sealed = sealed + 1
            end
        end
    end
    -- No literal '%' in the string: Civ's Lua.log writer mangles it (the same
    -- corruption shows up in base-game MarkCoastalLowlands output).
    print(string.format("Erebus: sealed %d walled-off tiles into mountains (%.1f pct of %d land)",
                        sealed, totalLand > 0 and (sealed / totalLand * 100) or 0, totalLand))
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
        for y = 1, g_iH do
            new_grid[y] = {}
            for x = 1, g_iW do
                new_grid[y][x] = grid[GetIndex(x - 1, y - 1)]
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
                final_grid[GetIndex(x - 1, y - 1)] = self.absorbed_into_region[y][x]
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
    for y=0, g_iH - 1 do
        for x=0, g_iW - 1 do
            terrainMap[GetIndex(x, y)] = OCEAN_TERRAIN
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

    for y=0, g_iH-1 do
        for x=0, g_iW-1 do
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

    for y=0,g_iH-1 do
        for x=0, g_iW-1 do
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

-- ---------------------------------------------------------------------------
-- RIVER PLACEMENT
--
-- Civ VI's river model is vertex based, same as this script's rx layer. Base
-- RiversLakes.lua says so directly: "pStartPlot = the plot at whose SE corner
-- the river is starting". A river is a chain of hex EDGES, and each edge is
-- addressed as (anchor plot, flow direction) via one of three setters.
--
-- The table below is mirrored exactly from that file -- which plot each flow
-- direction paints, and with which setter. Do not "simplify" it: the anchor
-- plot differs per direction because the two edges leaving a vertex along the
-- same axis belong to different hexes.
--
-- NOTE ON GEOMETRY: our flow map is a SQUARE corner lattice, so a flow step is
-- N/S/E/W. Hexes have no due-east or due-west edge, so E and W steps are
-- collapsed onto the nearest diagonals. Vertical steps map exactly; horizontal
-- ones are approximate, which is the main source of raggedness in the result.
-- Rebasing the rx layer on real hex vertices (see the geometry adapter near the
-- top of this file) is what removes the approximation.
-- ---------------------------------------------------------------------------
-- RIVER PLACEMENT
--
-- Now a direct 1:1 map. A flow step v -> v' traverses exactly one hex edge, and
-- that edge is named by the two tiles the vertices share (e.a, e.b). Because
-- the lattice is 3-valent, consecutive steps automatically satisfy Civ VI's
-- rule that a river must turn +/-60 degrees every step -- there is no way to
-- express a straight run, so the doubled lines and source caps that the old
-- square lattice produced cannot occur.
-- ---------------------------------------------------------------------------

-- Which of the three setters owns the edge between adjacent tiles a and b, and
-- which plot to call it on.
--
-- The flag names are stated relative to the RIVER, not to the tile.
-- IsWOfRiver(P) means "P lies west OF the river", so the river is on P's EAST
-- edge. The engine's own paired getters spell this out -- the flag set by
-- SetWOfRiver is read back through GetRiverEFlowDirection, SetNWOfRiver through
-- GetRiverSEFlowDirection, SetNEOfRiver through GetRiverSWFlowDirection. So each
-- hex owns its E, SE and SW edges, NOT its W, NW and NE edges.
--
-- Verified in WorldBuilder by diffing whole-map river state around EditRiver
-- (the editor's own river brush) in all six directions. Each call changed
-- exactly one plot, and the pairs agree on the same edge from either side:
--     EditRiver(P,E)  -> P     gets W-flag     EditRiver(P,W)  -> W(P)  gets W-flag
--     EditRiver(P,SE) -> P     gets NW-flag    EditRiver(P,NW) -> NW(P) gets NW-flag
--     EditRiver(P,SW) -> P     gets NE-flag    EditRiver(P,NE) -> NE(P) gets NE-flag
--
-- Reading it backwards anchored every edge on the opposite side of its tile, and
-- because the offset differs per edge type (E vs SE vs SW) the displacement is
-- not a rigid translation -- it tears the network apart. Measured on one 74x46
-- map: the same 537 edges that form 28 rivers with 456 clean junctions under the
-- intended reading are seen by the engine as 230 fragments with 501 loose ends
-- and 22 illegal forks. That was the "rivers do not connect" artifact.
local function edgeSetterOwnedBy(owner, other)
    local ox, oy = plotXY(owner)
    for _, dir in ipairs({HEX_E, HEX_SE, HEX_SW}) do
        if hexNeighbourIndex(ox, oy, dir) == other then
            if dir == HEX_E  then return owner, TerrainBuilder.SetWOfRiver,  dir end
            if dir == HEX_SE then return owner, TerrainBuilder.SetNWOfRiver, dir end
            return owner, TerrainBuilder.SetNEOfRiver, dir
        end
    end
    return nil, nil, nil
end

local function edgeSetterFor(a, b)
    -- Exactly one of the two tiles owns any given edge (if b is a's E/SE/SW
    -- neighbour then a is b's W/NW/NE neighbour, and only the first list owns
    -- edges), so at most one of these two lookups can succeed. Both are still
    -- tried, and a non-water anchor preferred, purely as belt and braces --
    -- collectRiverEdges already rejects any edge with a water tile on either
    -- side, because the engine refuses those outright (EditRiver answers
    -- INVALID_LOCATION for every direction facing water; verified in WorldBuilder).
    local pa, sa, da = edgeSetterOwnedBy(a, b)
    if pa then
        local x, y = plotXY(pa)
        local pl = Map.GetPlot(x, y)
        if pl and not pl:IsWater() then return pa, sa, da end
    end
    local pb, sb, db = edgeSetterOwnedBy(b, a)
    if pb then
        local x, y = plotXY(pb)
        local pl = Map.GetPlot(x, y)
        if pl and not pl:IsWater() then return pb, sb, db end
    end
    return pa or pb, sa or sb, da or db
end



-- Name the flow direction from the actual movement between the two vertices.
local FLOW_VECTORS = nil
local function flowDirectionFor(vFrom, vTo)
    if not FLOW_VECTORS then
        local FD = FlowDirectionTypes
        FLOW_VECTORS = {
            {FD.FLOWDIRECTION_NORTH,      0.0,  1.0},
            {FD.FLOWDIRECTION_NORTHEAST,  0.866,  0.5},
            {FD.FLOWDIRECTION_SOUTHEAST,  0.866, -0.5},
            {FD.FLOWDIRECTION_SOUTH,      0.0, -1.0},
            {FD.FLOWDIRECTION_SOUTHWEST, -0.866, -0.5},
            {FD.FLOWDIRECTION_NORTHWEST, -0.866,  0.5},
        }
    end
    local a, b = hexVertexPos(vFrom), hexVertexPos(vTo)
    if not a or not b then return nil end
    local dx, dy = b[1] - a[1], b[2] - a[2]
    local best, bestDot = nil, -math.huge
    for _, fv in ipairs(FLOW_VECTORS) do
        local dot = dx * fv[2] + dy * fv[3]
        if dot > bestDot then bestDot, best = dot, fv[1] end
    end
    return best
end

-- Assign river IDs from GEOMETRIC connectivity of the edges we actually paint.
--
-- This must happen after deciding which edges get painted, not before. IDs used
-- to come from the flow chains, but an edge mid-chain can fail to paint (anchor
-- off-map, or the owning tile is water), which splits the chain in two while
-- both halves keep the same ID. Civ VI then sees one river ID in two
-- disconnected places, fails to build a river object for it, and the whole thing
-- renders as nothing -- 55 pct of painted edges were orphaned that way, with
-- only 8 of 24 IDs becoming real named rivers.
--
-- Grouping by shared endpoint vertex instead makes one ID == one connected
-- river, which is what the game expects.
local function collectRiverEdges()
    local edges = {}
    for v = 1, hexVertexCount() do
        local nxt = flowMap[v]
        if nxt and nxt ~= 0
           and (riverMap[v] or 0) > RiverDrawThreshold
           and (riverMap[nxt] or 0) > RiverDrawThreshold then
            local edge
            for _, e in ipairs(hexVertexNeighbours(v)) do
                if e.v == nxt then edge = e break end
            end
            if edge then
                local anchor, setter, hexDir = edgeSetterFor(edge.a, edge.b)
                local eFlow = flowDirectionFor(v, nxt)
                if anchor and setter and eFlow then
                    local ax, ay = plotXY(anchor)
                    local pPlot = Map.GetPlot(ax, ay)
                    -- RULE 1 (probed live in WorldBuilder): a river edge may not
                    -- sit on a land/water boundary -- EditRiver answers
                    -- INVALID_LOCATION. BOTH tiles must be land, so a river stops
                    -- at the last land-land edge rather than running into the sea.
                    local oax, oay = plotXY(edge.a == anchor and edge.b or edge.a)
                    local otherPlot = Map.GetPlot(oax, oay)
                    if pPlot and not pPlot:IsWater()
                       and otherPlot and not otherPlot:IsWater() then
                        edges[#edges+1] = {a = v, b = nxt, plot = pPlot,
                                           setter = setter, flow = eFlow,
                                           hexDir = hexDir,
                                           edgeA = edge.a, edgeB = edge.b}
                    end
                end
            end
        end
    end
    return edges
end

local function groupRiverEdges(edges)
    local parent = {}
    local function find(x)
        while parent[x] and parent[x] ~= x do x = parent[x] end
        return x
    end
    local function union(x, y)
        local rx, ry = find(x), find(y)
        if rx and ry and rx ~= ry then parent[rx] = ry end
    end
    local firstAtVertex = {}
    for n, e in ipairs(edges) do
        parent[n] = n
        for _, v in ipairs({e.a, e.b}) do
            if firstAtVertex[v] then union(n, firstAtVertex[v]) else firstAtVertex[v] = n end
        end
    end
    -- No landlocked filtering here. Dropping systems with no ocean mouth cost
    -- 45-60 pct of all edges and did not fix the reported artifacts: in-game the
    -- rendering and non-rendering tiles turned out to be the SAME river (type 3),
    -- sea-connected, so the mouth was never the discriminator. Crowding was.
    local ids, nextId = {}, 0
    local kept = {}
    for n = 1, #edges do
        local root = find(n)
        if ids[root] == nil then ids[root] = nextId; nextId = nextId + 1 end
        edges[n].id = ids[root]
        kept[#kept+1] = edges[n]
    end
    return nextId, kept, 0
end

-- (Braid suppression removed. Capping edges-per-tile at 2 looked right against
-- the stock histogram but a river routing AROUND a tile legitimately needs three
-- edges on it, so the cap punched holes in chains and shattered the network into
-- 145 fragments of which the engine built only 27. Crowding was a symptom of too
-- many short systems, not the cause.)

function makeErebusRivers()
    -- Paint the flow map straight onto hex edges. Deliberately does NOT go via
    -- TryStartRiver: that is the coastal seeder, which grows its own procedural
    -- river and rejects anything beside a mountain -- discarding exactly the
    -- mountain-pass rivers this map is built around.
    local candidates = collectRiverEdges()
    local nRivers, edges = groupRiverEdges(candidates)

    -- Emit mouth-first, walking upstream, one river at a time. This mirrors the
    -- base game: TryStartRiver seeds on coastal land and DoRiver walks inland.
    -- (That claim was once dismissed because EditRiver looked like it addressed
    -- a different edge than the one asked for. It does not -- the flag names are
    -- relative to the river, see edgeSetterOwnedBy. WorldBuilder's brush really
    -- does enforce four rules, which it reports as INVALID_LOCATION (edge faces
    -- water), NOT_NEAR_RIVER_OR_WATER (new edge is isolated), SPLITTING_RIVER
    -- (would fork a river, also blocks removing a mid-chain edge) and
    -- JOINING_RIVERS (would merge two rivers). Only the water rule is filtered
    -- on here: those are the *editor's* validity rules, and TerrainBuilder does
    -- not enforce them at generation time, so whether the renderer needs the
    -- other three is still unmeasured. Note we do emit confluences, which the
    -- editor would reject as JOINING_RIVERS -- suspect if artifacts remain.)
    local upstreamOf, hasDownstream, emitted = {}, {}, {}
    for n, e in ipairs(edges) do
        upstreamOf[e.b] = upstreamOf[e.b] or {}
        table.insert(upstreamOf[e.b], n)
        hasDownstream[e.a] = true
    end

    local order = {}
    local function walkUpstream(v)
        for _, n in ipairs(upstreamOf[v] or {}) do
            if not emitted[n] then
                emitted[n] = true
                order[#order+1] = edges[n]
                walkUpstream(edges[n].a)      -- keep going away from the sea
            end
        end
    end
    -- Mouths first: an edge whose downstream vertex has no further edge.
    for _, e in ipairs(edges) do
        if not hasDownstream[e.b] then walkUpstream(e.b) end
    end
    for n, e in ipairs(edges) do              -- anything left (loops, orphans)
        if not emitted[n] then
            emitted[n] = true
            order[#order+1] = e
            walkUpstream(e.a)
        end
    end

    -- DO NOT call WorldBuilder.MapManager():EditRiver here. It exists in the
    -- map-generation state but hard-crashes the game with
    -- EXCEPTION_INT_DIVIDE_BY_ZERO -- WorldBuilder is not initialised during
    -- generation (WorldBuilder.IsActive() is false), so its internals divide by a
    -- zero it never set up. Verified the hard way.
    --
    -- Pass the river id (4-arg form). Dropping it so the engine could allocate
    -- one registers NO river object at all: GetNumRivers fell to 0, while a
    -- vanilla map of the same size reports 32. GetNumRivers tracks the ids we
    -- supply exactly (26 components -> 26), and the base game's DoRiver passes an
    -- id on every call too.
    for _, e in ipairs(order) do
        e.setter(e.plot, true, e.flow, e.id)
    end
    print(string.format("Erebus: placed %d river edges across %d rivers", #order, nRivers))
    print(string.format(
        "Erebus: placed %d river edges across %d rivers (emitted %d in chain order)",
        #edges, nRivers, #order))
end
