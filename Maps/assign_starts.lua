-- partitioned from Erebus.lua as want to test by running without civ, and it needs engine calls
-- also we can maybe get by without it. Currently unused.
availableRegionList = {}
occupiedRegionList = {}
maxCivPlayers = 6               -- gc.getMAX_CIV_PLAYERS(), or VI version
function assignStartingPlots()
    --Shuffle players so the same player doesn't always get the first pick.
    local playerList = {}
    for plrCheckLoop=0, maxCivPlayers do                                    -- local starts at 0
        if Players[plrCheckLoop].isEverAlive() then
            table.insert(playerList, plrCheckLoop)
        end
    end
    playerList = ShuffleList(playerList)
    for region in regionList do
        if not region.isWater then
            startRegion = StartRegion(region)
            table.insert(availableRegionList, startRegion)
        end
    end

    local civPreferenceList = GetCivPreferences()

    for _, playerIndex in ipairs(playerList) do
        local player = Players[playerIndex]
                                --  player.AI_updateFoundValues(true)                   -- no clue what this does
        local playerConfig = PlayerConfigurations[playerIndex]
        local civType = playerConfig:GetCivilizationTypeName()
        local civInfo = GameInfo.Civilizations[civType]         -- convert
        print(string.format("Civ = %s", civInfo.getType()))
        local civPref = getCivPreference(civPreferenceList, civType)
        local bestRegion = getBestStartRegion(availableRegionList,occupiedRegionList,civPref)
        local startPlot = getStartPlotInRegion(bestRegion.region,player,civPref)
        DeleteFromList(availableRegionList,bestRegion)
        table.insert(occupiedRegionList, bestRegion)
        player.setStartingPlot(startPlot,true)
    end
end

function getStartPlotInRegion(region,player,civPref)
    bestValue = 0
    bestPlot = nil
    for _, plot in ipairs(region.plotList) do
        local startPlot = Map.GetPlot(plot.x,plot.y)
        if not(civPref.needCoastalStart and not startPlot.IsShallowWater()) and not startPlot.IsMountain() then
            value = startPlot.getFoundValue(player.getID())
            if value > bestValue then
                bestValue = value
                bestPlot = startPlot
            end
        end
    end
    if not bestPlot then
        error( "best plot in region is null")
    end
    return bestPlot
end

function getBestStartRegion(availableRegionList,occupiedRegionList,civPref)
    local bestRegionList = {}
    for _, startRegion in ipairs(availableRegionList) do
        --first make sure region has a water gateRegion if coastal start
        --is desired
        if civPref.needCoastalStart then
            local gateRegion = getRegionByID(startRegion.region.gateRegion)
            if gateRegion.isWater then
                if #startRegion.region.plotList >= MinRegionSizeStart then
                    table.insert(bestRegionList, startRegion)
                end
            end
        end
    end

    for _, startRegion in ipairs(bestRegionList) do
        local normalizedAlt = startRegion.region.altitude / highestRegionAltitude
        local altitudeDiff = math.abs(normalizedAlt - civPref.idealAltitude)

        local moistureDiff = math.abs(startRegion.region.moisture - civPref.idealMoisture)

        local maxDistance = GetDistance(0,0,g_iW - 1,g_iH - 1)
        local distanceToNearest = getDistToNearestOccRegion(occupiedRegionList,startRegion)
        local distanceFactor = 1.0 - (distanceToNearest/maxDistance)

        local weightedAverageDiff = ((civPref.altitudeWeight * altitudeDiff) + (distanceFactor * civPref.distanceWeight) + moistureDiff)/(civPref.altitudeWeight + civPref.distanceWeight + 1)
        print(string.format("regionID = %d, altitudeDiff= %f, moistureDiff= %f, altitudeWeight= %f, weightedAverageDiff= %f",
                startRegion.region.ID, altitudeDiff, moistureDiff, civPref.altitudeWeight, weightedAverageDiff))
        startRegion.differenceFromIdeal = weightedAverageDiff
    end

    table.sort(bestRegionList, function(a, b)
            return a.differenceFromIdeal > b.differenceFromIdeal
        end)
    startRegion = bestRegionList[1]
    badderRegion = bestRegionList[10]
    print(string.format("chosen regionID = %d", startRegion.region.ID))
    print(string.format("start region %d has differenceFromIdeal=", startRegion.region.ID, startRegion.differenceFromIdeal))
    print(string.format("badder region %d has differenceFromIdeal=", badderRegion.region.ID, badderRegion.differenceFromIdeal))
    return startRegion
end

function getDistToNearestOccRegion(occupiedRegionList,startRegion)
    minDistance = GetDistance(0,0,g_iW - 1,g_iH - 1)
    for _, occRegion in ipairs(occupiedRegionList) do
        startGatePlot = startRegion.region.gatePlot
        if startGatePlot then
            occGatePlot = occRegion.region.gatePlot
            distance = GetDistance(startGatePlot.x,startGatePlot.y,occGatePlot.x,occGatePlot.y)
            minDistance = min(distance,minDistance)
        end
    end
    return minDistance
end

function getCivPreference(civPreferenceList,civType)
    for civPref in civPreferenceList do
        if civPref.civ == civType then
            return civPref
        end
    end
    --None defined so let's make a generic one
    civPref = CivPreference(civType)
    return civPref
end

function replaceUniqueImprovements()
    gc = CyGlobalContext()
    gameMap = CyMap()
    impPrefList = GetImprovementPreferences()
    availableRegionList = {}
    local occupiedRegionList = {}
    for region in regionList do
        local startRegion = StartRegion(region)
        table.insert(availableRegionList, startRegion)
    end
    for y in range(g_iH) do
        for x in range(g_iW) do
            plot = gameMap.plot(x,y)
            impType = plot.getImprovementType()
            impInfo = gc.getImprovementInfo(impType)
            if impInfo then
                print("Found %(i)s", impInfo.getType())
                impPref = nil
                --Find impType in preference list
                for foundImpPref in impPrefList do
                    if foundImpPref.improvement == impType then
                        impPref = foundImpPref
                        break
                    end
                end
                if impPref then
                    impInfo = gc.getImprovementInfo(impType)
                    print("Removing %s at %d, %d", impInfo.getType(), x, y)
                    plot.setImprovementType(GetInfoType("NO_IMPROVEMENT"))
        ----                numUnits = plot.getNumUnits()
        ----                unitList = {}
        ----                for n in range(numUnits):
        ----                    unit = plot.getUnit(n)
        ----                    table.insert(unitList, unit)
                    plot.setBonusType(GetInfoType("NO_BONUS"))
                    bestRegion = getBestImprovementRegion(availableRegionList,occupiedRegionList,impPref)
                    DeleteFromList(availableRegionList,bestRegion)
                    table.insert(occupiedRegionList, bestRegion)
                    bestPlot = getBestImpPlotInRegion(bestRegion.region,impPref)
                    DeleteFromList(impPrefList,impPref)
                    print("Adding %s at %d, %d", impInfo.getType(), bestPlot.getX(), bestPlot.getY())
                    bestPlot.setImprovementType(impType)
        ----                for n in range(numUnits):
        ----                    unit = unitList[n]
        ----                    unit.setXY(bestPlot.getX(),bestPlot.getY(),false,true,false)
                end
            end
        end
    end
end

function getBestImprovementRegion(availableRegionList,occupiedRegionList,impPref)
    bestRegionList = {}
    for _, startRegion in ipairs(availableRegionList) do
        --first make sure region has a water gateRegion if coastal plot
        --is desired
        local Failed = false
        if impPref.needCoast then
            gateRegion = getRegionByID(startRegion.region.gateRegion)
            if not gateRegion.isWater then
                Failed = true
            end
        end
        if impPref.needWater then
            if not startRegion.region.isWater then
                Failed = true
            end
        end
        if startRegion.region.isWater then
            Failed = true --water regions not supported right now
        end
        if len(startRegion.region.plotList) < MinRegionSizeTower then
            Failed = true
        end
        if impPref.needChoke then
            if findChokePoint(startRegion.region) == nil then
                Failed = true
            end
        end
        if Failed then
            table.insert(bestRegionList, startRegion)
        end
    end

    for _, startRegion in ipairs(bestRegionList) do
        normalizedAlt = startRegion.region.altitude/highestRegionAltitude
        altitudeDiff = math.abs(normalizedAlt - impPref.idealAltitude)

        moistureDiff = math.abs(startRegion.region.moisture - impPref.idealMoisture)

        maxDistance = GetDistance(0,0,g_iW - 1,g_iH - 1)
        distanceToNearest = getDistToNearestOccRegion(occupiedRegionList,startRegion)
        distanceFactor = 1.0 - (distanceToNearest/maxDistance)

        weightedAverageDiff = ((impPref.altitudeWeight * altitudeDiff) + distanceFactor + (moistureDiff * impPref.moistureWeight))/(impPref.altitudeWeight + impPref.moistureWeight + 1)
        print("regionID = %d, altitudeDiff= %f, moistureDiff= %f, altitudeWeight= %f, weightedAverageDiff= %f", startRegion.region.ID, altitudeDiff, moistureDiff, impPref.altitudeWeight, weightedAverageDiff)
        startRegion.differenceFromIdeal = weightedAverageDiff
    end

    table.sort(bestRegionList, function(a, b)
            return a.differenceFromIdeal > b.differenceFromIdeal
        end)
    startRegion = bestRegionList[1]
    print ("chosen regionID = %d", startRegion.region.ID)
    return startRegion
end

function getBestImpPlotInRegion(region,impPref)
    gc = CyGlobalContext()
    gameMap = CyMap()
    midPoint = region.getCenter()
    ----        print "midPoint.x= %(mx)d, midPoint.y= %(my)d" % {"mx":midPoint.x,"my":midPoint.y}
    minDistance = 100.0
    bestPlot = gameMap.plot(midPoint.x,midPoint.y)
    region.plotList = ShuffleList(region.plotList)
    for _, plot in ipairs(region.plotList) do
        local passedCheck = true
        local i = GetIndex(plot.x,plot.y)
        gamePlot = gameMap.plot(plot.x,plot.y)
        print(string.format("gamePlot = %d,%d", plot.x,plot.y))
        if gamePlot.getBonusType(TeamTypes.NO_TEAM) ~= GetInfoType("NO_BONUS") or
                (gamePlot.isPeak() and impPref.needChoke == false) or
                (impPref.needHill and plotMap.plotMap[i] ~= plotMap.HILLS) or
                (impPref.needFlat and plotMap.plotMap[i] ~= plotMap.LAND) or
                (impPref.needCoast and not isCoast(gamePlot)) or
                (impPref.favoredTerrain ~= TerrainTypes.NO_TERRAIN and gamePlot.getTerrainType() ~= impPref.favoredTerrain) then
            passedCheck = false
        end
        if impPref.needChoke and passedCheck then
            chokePlot = findChokePoint(region)
            if (plot.x >= chokePlot.getX() - 1 and plot.x <= chokePlot.getX() + 1 and plot.y >= chokePlot.getY() - 1 and plot.y <= chokePlot.getY() + 1 and gamePlot.isPeak()) then
                print("Found choke")
                --place bait
                reagents = GetInfoType("BONUS_REAGENTS")
                if reagents ~= -1 then
                    for direction=1,8 do
                        xx,yy = plotMap.getXYFromDirection(plot.x,plot.y,direction)
                        baitPlot = gameMap.plot(xx,yy)
                        forest = GetInfoType("FEATURE_FOREST")
                        if forest ~= -1 and baitPlot.getFeatureType() == forest then
                            baitPlot.setFeatureType(FeatureTypes.NO_FEATURE,0)
                        end
                        if baitPlot.canHaveBonus(reagents,true) then
                            baitPlot.setBonusType(reagents)
                            break
                        end
                    end
                end
            else
                print(string.format("rejected not next to choke=%(x)d,%(y)d or not peak", chokePlot.getX(), chokePlot.getY()))
                passedCheck = false
            end
        end
        if passedCheck then
            bestPlot = gameMap.plot(plot.x,plot.y)
            break
        end
    end
    return bestPlot
end
function collectAllWatchtowers()
    gc = CyGlobalContext()
    gameMap = CyMap()
    count = 0
    for y in range(g_iH) do
        for x in range(g_iW) do
            plot = gameMap.plot(x,y)
            impType = plot.getImprovementType()
            if impType == GetInfoType("IMPROVEMENT_TOWER") then
                count = count + 1
                plot.setImprovementType(GetInfoType("NO_IMPROVEMENT"))
            end
        end
    end
    print("razed %d watchtowers", count)
    return count
end

function replaceWatchtowers(count)
    gc = CyGlobalContext()
    gameMap = CyMap()
    towersPlacedAtChoke = 0
    towersPlacedInMiddle = 0

    createChokePointList()
    for _, region in ipairs(regionList) do          --not all regions should have a tower
        local passedCheck = true
        if region.isWater or len(region.plotList) < MinRegionSizeTower or math.random(0,3) == 0 then
            passedCheck = false
        end
        if math.random(0,1) == 0 and passedCheck then
            chokePoint = findChokePoint(region)
            badNeighbor = false
            if chokePoint ~= None then
                for direction=1,8 do
                    x,y = plotMap.getXYFromDirection(chokePoint.getX(),chokePoint.getY(),direction)
                    nPlot = gameMap.plot(x,y)
                    if nPlot.getImprovementType() ~= ImprovementTypes.NO_IMPROVEMENT then
                        badNeighbor = true
                    end
                end
            end

            if chokePoint and not badNeighbor then
                chokePoint.setImprovementType(GetInfoType("IMPROVEMENT_TOWER"))
                towersPlacedAtChoke = towersPlacedAtChoke + 1
                passedCheck = false -- regions should not have a choke tower and mid tower or else they might appear together
            end
        end
        if passedCheck then
            --If a chokepoint is not found or if mid tower is randomly selected,
            --place tower in the middle of a region
            midPoint = region.getCenter()
            ----  print "midPoint.x= %(mx)d, midPoint.y= %(my)d" % {"mx":midPoint.x,"my":midPoint.y}
            minDistance = 100.0
            bestPlot = None
            for _, plot in ipairs(region.plotList) do
                i = GetIndex(plot.x,plot.y)
                gamePlot = gameMap.plot(plot.x,plot.y)
                if gamePlot.getBonusType(TeamTypes.NO_TEAM) ~= GetInfoType("NO_BONUS") then
                    passedCheck = false
                end

                if plotMap.plotMap[i] == plotMap.HILLS and passedCheck then
                    distance = GetDistance(plot.x,plot.y,midPoint.x,midPoint.y)
                    if minDistance > distance then
                        bestPlot = plot
                        minDistance = distance
                    end
                end
            end
            if bestPlot ~= None and passedCheck then
                midHill = gameMap.plot(bestPlot.x,bestPlot.y)
                midHill.setImprovementType(GetInfoType("IMPROVEMENT_TOWER"))
                towersPlacedInMiddle = towersPlacedInMiddle + 1
            end
        end
    end
    print(string.format("towersPlacedAtChoke= %d, towersPlacedInMiddle= %d, total= %d", towersPlacedAtChoke, towersPlacedInMiddle, towersPlacedAtChoke + towersPlacedInMiddle))
end

function createChokePointList()
    gc = CyGlobalContext()
    gameMap = CyMap()

    areaMap = Areamap(g_iW,g_iH)
    possibleChokeList = {}
    likelyChokeList = {}
    chokePointList = {}
    chokeAreaList = {}

    --First compile a list of local chokepoints
    for y=1, g_iH do
        for x=1, g_iW do
            i = GetIndex(x,y)
            if isPossibleChokePoint(x,y) then
                areaMap.areaMap[i] = -2
                table.insert(possibleChokeList, ChokePoint(x,y))
            end
        end
    end

    --Then eliminate chokes that don't connect significant areas
    areaMap.findChokePointAreas()

    for i=1, #areaMap.areaList do
        table.insert(chokeAreaList, ChokeArea(i,areaMap.areaList[i]))
    end

    for _, possibleChoke in ipairs(possibleChokeList) do
        findChokeNeighbors(possibleChoke,areaMap,chokeAreaList,possibleChokeList)
    end

    for possibleChoke in possibleChokeList do
        for area in possibleChoke.neighborAreaList do
            if area.size > ChokePointAreaSize then
                chokesCheckedList = {}
----                    print "Starting area search through %(p)s ----------------------------------------------------------" % \
----                    {"p":str(possibleChoke)}
                if canFindAdditionalAreaThroughChokes(possibleChoke,area,chokesCheckedList,true) then
                    table.insert(likelyChokeList, possibleChoke)        -- upgrade!!!
----                        print "choke %(x)d,%(y)d is valid \n------------------------------------------------------\n" \
----                        % {"x":possibleChoke.x,"y":possibleChoke.y}
----                    else:
----                        print "choke %(x)d,%(y)d is NOT valid \n------------------------------------------------------\n" \
----                        % {"x":possibleChoke.x,"y":possibleChoke.y}
                end
                break
            end
        end
     end

----        areaMap.PrintAreaMap()
----        for chokePoint in likelyChokeList:
----            print "Likely chokepoint at %(x)d, %(y)d" % {"x":chokePoint.x,"y":chokePoint.y}

    --Now you have a list of good chokepoints, but some areas may have so many
    --choke points that none of them are useful. Now we block the choke points
    --and test the walk-around distance to see if this choke point is useful
    for chokePoint in likelyChokeList do
        if isConfirmedChokePoint(chokePoint) then
            print("Confirmed chokepoint at %s", str(chokePoint))
            table.insert(chokePointList, chokePoint)
        else
            print ("Rejected chokepoint at %d, %d", chokePoint.x, chokePoint.y)
        end
    end
end

function isConfirmedChokePoint(choke)
    gc = CyGlobalContext()
    gameMap = CyMap()
    gamePlot = gameMap.plot(choke.x,choke.y)

    --remember old plot type so we can replace
    oldPlotType = gamePlot.getPlotType()
    --change plot type to peak to block path
    gamePlot.setPlotType(PlotTypes.PLOT_PEAK,true,true)

    for inX,inY in choke.gateList do
        for outX,outY in choke.gateList do
            if not (outX == inX and outY == inY )then
                gameMap.resetPathDistance()
                inPlot = gameMap.plot(inX,inY)
                outPlot = gameMap.plot(outX,outY)
                distance = gameMap.calculatePathDistance(inPlot,outPlot)
                ----    print "distance from %(ix)d,%(iy)d to %(ox)d,%(oy)d = %(d)d" % \
                ----    {"ix":inX,"iy":inY,"ox":outX,"oy":outY,"d":distance}
                if distance >= ChokePointWalkAroundDistance or distance == -1 then
                    gamePlot.setPlotType(oldPlotType,true,true)
                    return true
                end
            end
        end
    end
    gamePlot.setPlotType(oldPlotType,true,true)
end

function canFindAdditionalAreaThroughChokes(self,possibleChoke,origionalArea,chokesCheckedList,bTopLayer)
    --First try to find a large area that is not the origional area
    twoAreasFound = false
    returnValue = false
    for area in possibleChoke.neighborAreaList do
        if bTopLayer == false and area == origionalArea then
----                print "This secondary choke touches origional area and must be declared a dead end."
            return false
        elseif area ~= origionalArea and area.size > ChokePointAreaSize then
            twoAreasFound = true
        end
     end

    if twoAreasFound then
----            print "Chokepoint %(c)s leads to second large area" % {"c":str(possibleChoke)}
        returnValue = true
    end

    --These coordinates are checked and can not be checked again or else endless loop possible
    table.insert(chokesCheckedList, possibleChoke)
    largeAreaFound = false
    --Now loop through neighbor choke points and recurse this function if they aren't
    --in checked list
    for neighborChoke in possibleChoke.neighborChokeList do
        alreadyChecked = false
        for checkedChoke in chokesCheckedList do
            if checkedChoke == neighborChoke then
                alreadyChecked = true
            end
        end
        if not alreadyChecked then
----                print "possibleChoke(%(x)d,%(y)d) searching through %(n)s" % \
----                {"x":possibleChoke.x,"y":possibleChoke.y,"n":str(neighborChoke)}
            largeAreaFound = canFindAdditionalAreaThroughChokes(neighborChoke,origionalArea,chokesCheckedList,false)
            if largeAreaFound then
----                    print "Found second area through neighbor chokepoint"
                if bTopLayer then
                    table.insert(possibleChoke.gateList, { neighborChoke.x, neighborChoke.y })     --for final path check
                end
                returnValue = true
            end
        end

    --Now loop through small areas neighbor choke points
    for neighborArea in possibleChoke.neighborAreaList do
        if area ~= origionalArea then
----                print "possibleChoke(%(x)d,%(y)d) searching through %(n)s" % \
----                {"x":possibleChoke.x,"y":possibleChoke.y,"n":str(area)}
            for neighborChoke in neighborArea.neighborChokeList do
                alreadyChecked = false
                for checkedChoke in chokesCheckedList do
                    if checkedChoke == neighborChoke then
                        alreadyChecked = true
                    end
                end
                if not alreadyChecked then
----                        print "possibleChoke(%(x)d,%(y)d) searching through %(n)s which is through area=%(a)d,%(c)s" % \
----                        {"x":possibleChoke.x,"y":possibleChoke.y,"n":str(neighborChoke),"a":area.ID,"c":chr(area.ID + 34)}
                    largeAreaFound = canFindAdditionalAreaThroughChokes(neighborChoke,origionalArea,chokesCheckedList,false)
                    if largeAreaFound then
----                            print "Found second area through neighbor area and chokepoint"
                        if bTopLayer then
                            table.insert(possibleChoke.gateList, { neighborChoke.x, neighborChoke.y })--for final path check
                        end
                        returnValue = true
                    end
                end
            end
        end
    end
end

----        if returnValue == false:
----            print "no second area found through possibleChoke(%(x)d,%(y)d)" % \
----            {"x":possibleChoke.x,"y":possibleChoke.y}
    return returnValue
end

function findChokeNeighbors(possibleChoke,areaMap,chokeAreaList,possibleChokeList)
    for direction=1, 8 do
        xx,yy = plotMap.getXYFromDirection(possibleChoke.x,possibleChoke.y,direction)
        i = GetIndex(xx,yy)
        if i ~= -1 then
            if areaMap.areaMap[i] == -2 then
                for _, neighborChoke in ipairs(possibleChokeList) do
                    if neighborChoke.x == xx and neighborChoke.y == yy then
                        table.insert(possibleChoke.neighborChokeList, neighborChoke)
                    end
                end
            elseif areaMap.areaMap[i] > 0 then
                --make sure it's not in list already before adding it
                alreadyInList = false
                for _, area in ipairs(possibleChoke.neighborAreaList) do
                    if area.ID == areaMap.areaMap[i] then
                        alreadyInList = true
                    end
                end
                if alreadyInList == false then
                    --add area to neighbor list and also add this choke to areas neighbor list
                    for _, area in ipairs(chokeAreaList) do
                        if area.ID == areaMap.areaMap[i] then
                            table.insert(possibleChoke.neighborAreaList, area)
                            table.insert(area.neighborChokeList, possibleChoke)
                            if area.size > ChokePointAreaSize then
                                table.insert(possibleChoke.gateList, { xx, yy })       --gateList is for final path check
                            end
                        end
                    end
                end
            end
        end
    end
end

function isPossibleChokePoint(x,y)
    gc = CyGlobalContext()
    gameMap = CyMap()
    gamePlot = gameMap.plot(x,y)

    i = GetIndex(x,y)
    if gamePlot.isWater() or gamePlot.isImpassable() then
        return false
    end
    if gamePlot.getBonusType(TeamTypes.NO_TEAM) ~= GetInfoType("NO_BONUS") then
        return false
    end
    --First check cardinal directions
    direction = plotMap.W
    xx,yy = plotMap.getXYFromDirection(x,y,direction)
    passable = isPassableLand(xx,yy)
    oppDir = plotMap.getOppositeDirection(direction)
    xxx,yyy = plotMap.getXYFromDirection(x,y,oppDir)
    if passable == isPassableLand(xxx,yyy) then
        direction = plotMap.N
        xx,yy = plotMap.getXYFromDirection(x,y,direction)
        oppDir = plotMap.getOppositeDirection(direction)
        xxx,yyy = plotMap.getXYFromDirection(x,y,oppDir)
        if passable ~= isPassableLand(xx,yy) and passable ~= isPassableLand(xxx,yyy) then
--                print "choke at %(x)d,%(y)d is opposites" % {"x":x,"y":y}
            return true --Definately a possible choke
        end
    end

    --No choke yet, try diagonal chokes
    direction = plotMap.NW
    xx,yy = plotMap.getXYFromDirection(x,y,direction)
    if isPassableLand(xx,yy) then
        direction = plotMap.N
        xx,yy = plotMap.getXYFromDirection(x,y,direction)
        direction = plotMap.W
        xxx,yyy = plotMap.getXYFromDirection(x,y,direction)
        if isPassableLand(xx,yy) == false and isPassableLand(xxx,yyy) == false then
--                print "choke at %(x)d,%(y)d is NW diagonal" % {"x":x,"y":y}
            return true --choke
        end
    end

    direction = plotMap.NE
    xx,yy = plotMap.getXYFromDirection(x,y,direction)
    if isPassableLand(xx,yy) then
        direction = plotMap.N
        xx,yy = plotMap.getXYFromDirection(x,y,direction)
        direction = plotMap.E
        xxx,yyy = plotMap.getXYFromDirection(x,y,direction)
        if isPassableLand(xx,yy) == false and isPassableLand(xxx,yyy) == false then
--                print "choke at %(x)d,%(y)d is NE diagonal" % {"x":x,"y":y}
            return true --choke
        end
    end

    direction = plotMap.SW
    xx,yy = plotMap.getXYFromDirection(x,y,direction)
    if isPassableLand(xx,yy) then
        direction = plotMap.S
        xx,yy = plotMap.getXYFromDirection(x,y,direction)
        direction = plotMap.W
        xxx,yyy = plotMap.getXYFromDirection(x,y,direction)
        if isPassableLand(xx,yy) == false and isPassableLand(xxx,yyy) == false then
--                print "choke at %(x)d,%(y)d is SW diagonal" % {"x":x,"y":y}
            return true --choke
        end
    end

    direction = plotMap.SE
    xx,yy = plotMap.getXYFromDirection(x,y,direction)
    if isPassableLand(xx,yy) then
        direction = plotMap.S
        xx,yy = plotMap.getXYFromDirection(x,y,direction)
        direction = plotMap.E
        xxx,yyy = plotMap.getXYFromDirection(x,y,direction)
        if isPassableLand(xx,yy) == false and isPassableLand(xxx,yyy) == false then
--                print "choke at %(x)d,%(y)d is SE diagonal" % {"x":x,"y":y}
            return true -- choke
        end
    end
end

function isPassableLand(x,y)
    gc = CyGlobalContext()
    gameMap = CyMap()
    gamePlot = gameMap.plot(x,y)

    i = GetIndex(x,y)
    if i == -1 then
        return false
    end
    if gamePlot.isWater() or gamePlot.isImpassable() then
        return false
    end
    return true
end

function findChokePoint(region)
    gc = CyGlobalContext()
    gameMap = CyMap()

    for _, choke in ipairs(chokePointList) do
        for _, plot in ipairs(region.plotList) do
            if plot.x == choke.x and plot.y == choke.y then
                return gameMap.plot(plot.x,plot.y)
            end
        end
    end
end