local tColdTerrain = {  [GameInfo.Terrains['TERRAIN_TUNDRA'].Index]       = true,
                        [GameInfo.Terrains['TERRAIN_TUNDRA_HILLS'].Index] = true,
                        [GameInfo.Terrains['TERRAIN_SNOW'].Index]         = true,
                        [GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index]   = true
}

-- nicked from Leugi Wildlife++
function ViableWildernessPlots(bOnlyTundraOrSnow)
    local tNewTable = {}
    local iCount = 1
    local bViablePlot
    local iW, iH = Map.GetGridSize();
    for x = 0, iW - 1 do
        for y = 0, iH - 1 do
            local i = y * iW + x;
            local pPlot = Map.GetPlotByIndex(i);
            if (pPlot ~= nil) then
                if (pPlot:IsAdjacentOwned() == false) and (pPlot:IsOwned() == false) and (pPlot:IsMountain() == false) and (pPlot:IsWater() == false) and (pPlot:IsNaturalWonder() == false) and (pPlot:IsImpassable() == false) and (pPlot:IsCity() == false) then
                    if bOnlyTundraOrSnow then
                        local iTerrainIndex = pPlot:GetTerrainType()
                        bViablePlot = tColdTerrain[iTerrainIndex]
                    else
                        bViablePlot = true
                    end
                    local bPlotHasUnit = false
                    local unitList = Units.GetUnitsInPlotLayerID(x, y, MapLayers.ANY)
                    if unitList ~= nil then
                        for _, pUnit in ipairs(unitList) do
                            local tUnitDetails = GameInfo.Units[pUnit:GetType()]
                            if tUnitDetails ~= nil then
                                if not pUnit:IsDead() and not pUnit:IsDelayedDeath() then
                                    bPlotHasUnit = true
                                    break
                                end
                            end
                        end
                    end
                    if (bPlotHasUnit == false) then
                        tNewTable[iCount] = pPlot
                        iCount = iCount + 1
                    end
                end
            end
        end
    end
    return tNewTable
end