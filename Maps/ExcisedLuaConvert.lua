
AreaMap = {}
AreaMap.__index = AreaMap
function AreaMap.new(width, height)
    local self = setmetatable({}, AreaMap)
    self.mapWidth = width
    self.mapHeight = height
    self.IDs_issued = 0
    self.areaMap ={}
    for i=1, self.mapHeight * self.mapWidth do
        self.areaMap[i] = 0
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
   for i=1, self.mapHeight * self.mapWidth do -- Using 1-based indexing
       if self.areaMap[i] == 0 and plotMap[i] == OCEAN then -- Check both conditions
            local areaID = self:getNextAreaID() -- Use a unique ID for each area
            local areaSize = self:fillArea(i, areaID)
       end
   end
end

function AreaMap:getNextAreaID()
    self.IDs_issued = self.IDs_issued + 1
    return self.IDs_issued
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
            --                slthLog "areaID = %(id)d, size = %(s)d" % {"id":areaID,"s":areaSize}
            table.insert(self.areaList, areaSize)
        end
    end
end

function AreaMap:fillArea(index, areaID)
    -- first divide index into x and y
    local y = math.floor((index - 1) / self.mapWidth)
    local x = math.floor((index - 1) / self.mapWidth)
    -- We check 8 neigbors for land,but 4 for water. This is because
    -- the game connects land squares diagonally across water, but
    -- water squares are not passable diagonally across land
    local segStack = {}
    local size = 0
    -- place seed on stack for both directions
    local seg = {y=y, xLeft=x, xRight=x, dy=1}
    table.insert(segStack, seg)
    seg = {y=y + 1, xLeft=x, xRight=x, dy=-1}
    table.insert(segStack, seg)
    while #segStack > 0 do
        seg = table.remove(segStack)
        self:scanAndFillLine(seg, areaID, segStack, size)
    end
    return size
end

function AreaMap:scanAndFillLine(seg, areaID, segStack, size)
    -- check for y + dy being off map
    local i = GetIndex(seg['xLeft'], seg['y'] + seg['dy'])
    if i < 0 then
        ----            slthLog "scanLine off map ignoring",str(seg)
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
        slthLog('')
        slthLog(seg)
        slthLog("Going left")
    end
    local xLeftExtreme
    for xLeftExtremeLoc = seg['xLeft'] - landOffset, -1, -1 do
        if xLeftExtremeLoc < 0 then -- Add this check
            xLeftExtreme = -1
            break
        end
        xLeftExtreme = xLeftExtremeLoc
        i = GetIndex(xLeftExtreme, seg['y'] + seg['dy'])
        if debugReport then
            slthLog("xLeftExtreme = %d", xLeftExtreme)
        end
        if self.areaMap[i] == 0 and plotMap[i] ~= PEAK then
            self.areaMap[i] = areaID
            slthLog('ASSIGNING PLOT:AREA ID, ', i, areaID)
            size = size + 1
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
        slthLog("xLeftExtreme finally = %d",xLeftExtreme)
        slthLog("Going Right")
    end
    -- now scan right to find extreme right, place each found segment on stack
    --        xRightExtreme = seg['xLeft'] - landOffset --needed sometimes? one time it was not initialized before use.
    local xRightExtreme
    for xRightExtreme_loc = seg['xLeft'], self.mapWidth, 1 do
        if xRightExtreme_loc >= self.mapWidth then -- Add this check
            xRightExtreme = self.mapWidth
            break
        end
        xRightExtreme = xRightExtreme_loc
        if debugReport then
            slthLog("xRightExtreme = %d", xRightExtreme)
        end
        i = GetIndex(xRightExtreme, seg['y'] + seg['dy'])
        if self.areaMap[i] == 0 and plotMap[i] ~= PEAK then
            self.areaMap[i] = areaID
            slthLog('ASSIGNING PLOT:AREA ID, ', i, areaID)
            size = size + 1
            if lineFound == false then
                lineFound = true
                xLeftExtreme = xRightExtreme  -- starting new line
                if debugReport then
                    slthLog("starting new line at xLeftExtreme= %d", xLeftExtreme)
                end
            end
        elseif lineFound == true then  -- found the right end of a line segment!
            lineFound = false
            -- put same direction on stack
            newSeg = {y=seg['y'] + seg['dy'], xLeft=xLeftExtreme, xRight=xRightExtreme - 1, dy=seg['dy']}
            table.insert(segStack, newSeg)
            if debugReport then
                slthLog("same direction to stack", newSeg)
            end
            -- determine if we must put reverse direction on stack
            if xLeftExtreme < seg['xLeft'] or xRightExtreme >= seg['xRight'] then
                -- out of shadow so put reverse direction on stack also
                local newSeg = {y=seg['y'] + seg['dy'], xLeft=xLeftExtreme, xRight=xRightExtreme - 1, dy=-seg['dy']}
                table.insert(segStack, newSeg)
                if debugReport then
                    slthLog("opposite direction to stack", newSeg)
                end
            end
            if xRightExtreme >= seg['xRight'] + landOffset then
                if debugReport then
                    slthLog("finished with line")
                end
                break;  -- past the end of the parent line and this line ends
            end
        elseif lineFound == false and xRightExtreme >= seg['xRight'] + landOffset then
            if debugReport then
                slthLog("no additional lines found")
            end
            break;  -- past the end of the parent line and no line found
        -- else                                                                 -- this clause does nothing
        --     continue  -- keep looking for more line segments
        end
    end
    if lineFound == true then  -- still a line needing to be put on stack
        if debugReport then
            slthLog("still needing to stack some segs")
        end
        lineFound = false
        -- put same direction on stack
        local newSeg = {y=seg['y'] + seg['dy'], xLeft=xLeftExtreme, xRight=xRightExtreme - 1, dy=seg['dy']}
        table.insert(segStack, newSeg)
        if debugReport then
            slthLog(newSeg)
        end
        -- determine if we must put reverse direction on stack
        if xLeftExtreme < seg['xLeft'] or xRightExtreme - 1 > seg['xRight'] then
            -- out of shadow so put reverse direction on stack also
            newSeg = {y=seg['y'] + seg['dy'], xLeft=xLeftExtreme, xRight=xRightExtreme - 1, dy=-seg['dy']}
            table.insert(segStack, newSeg)
            if debugReport then
                slthLog(newSeg)
            end
        end
    end
end


-- for debugging
function AreaMap:PrintAreaMap()
    slthLog("Area Map")
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
        slthLog(lineString)
    end
    slthLog(" ")
end