
local iPlayer = Game.GetLocalPlayer()
local pPlayer = Players[iPlayer]
local sCommerceScienceConversionKey = 'CommIntoScience'
local sCommerceGoldConversionKey = 'CommIntoGold'
local sManualSlidersKey = 'manualSlidersSet'
-- base it on gold, for now. Later we can manage all 3 with culture too, but for now, science depends on gold.
-- also needs a flag to stop auto adjustment, except for debt
function ChangeCommerceRatio(iChange)              -- accepts 1 or -1.
    print('changing gold into commerce ratio by', iChange)
    -- know player, get capital city, then change plot using request Op
    local iCurrentGoldRatio = pPlayer:GetProperty(sCommerceGoldConversionKey) or 10
    print('current gold ratio is treated as', iCurrentGoldRatio, 'but gotten value was ', pPlayer:GetProperty(sCommerceGoldConversionKey))

    print('current science ratio is', pPlayer:GetProperty(sCommerceScienceConversionKey))
    local iNewGoldRatio = iCurrentGoldRatio + iChange
    if iNewGoldRatio > 10 or iNewGoldRatio < 0 then
        print('cannot increment or decrement to this commerce ratio', iNewGoldRatio)
        return
    end
    local iNewScienceRatio = 10 - iNewGoldRatio
	local tGoldPlotParameters = {OnStart='SlthSetCapitalProperty', sPropKey=sCommerceGoldConversionKey, iPropValue=iNewGoldRatio}
	local tGoldPlayerParameters = {OnStart='SlthSetPlayerProperty', sPropKey=sCommerceGoldConversionKey, iPropValue=iNewGoldRatio}

    local tSciencePlotParameters = {OnStart='SlthSetCapitalProperty', sPropKey=sCommerceScienceConversionKey, iPropValue=iNewScienceRatio}
	local tSciencePlayerParameters = {OnStart='SlthSetPlayerProperty', sPropKey=sCommerceScienceConversionKey, iPropValue=iNewScienceRatio}

    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tGoldPlotParameters);
    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tGoldPlayerParameters);

    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tSciencePlotParameters);
    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tSciencePlayerParameters);

    local bIsManualSliders = pPlayer:GetProperty(sManualSlidersKey) or 0
    if bIsManualSliders == 0 then
        UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, {OnStart='SlthSetPlayerProperty',
                                                                             sPropKey=sManualSlidersKey,
                                                                             iPropValue=1});
    end
    return true
end