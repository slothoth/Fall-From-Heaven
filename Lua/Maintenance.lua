-- Can we only trigger event when
-- any city is built
 --city builds a maintenance building, or is pillaged
 --civ changes in or out of maintenance policies?
-- gov plaza buiLt/destroyed, palace built/destroyed. hopefully recapital covers palace part. gov plaza unbuilt
-- CONSTANTS
local MaintenanceReductionBuildings = {BUILDING_QUEENS_BIBLIOTHEQUE=-40, SLTH_BUILDING_GOVERNORS_MANOR=-20,
                                 SLTH_BUILDING_BASILICA=-40, SLTH_BUILDING_HARBOR_LANUN=-10,
                                 SLTH_BUILDING_GAMBLING_HOUSE=10, BUILDING_BIG_BEN=-50,
                                 SLTH_BUILDING_TAVERN=10, SLTH_BUILDING_TAVERN_GRIGORI=10};
local MaintenanceReductionPolicies = {SLTH_POLICY_DESPOTISM={CityReduction=25}, SLTH_POLICY_GOD_KING={CityReduction=10},
                                SLTH_POLICY_CITY_STATES={CityReduction=-25, DistanceReduction=-80},
                                SLTH_POLICY_ARISTOCRACY={CityReduction=-40}};
local GovernCentres = {SLTH_BUILDING_SUMMER_PALACE='summer', BUILDING_ORSZAGHAZ='winter'};

-- todo, does maintenance reduce based on difficulty?

function MasterTax(playerId)
    local pPlayer = Players[playerId];
    if not pPlayer:IsMajor() then return; end;
    local global_dist_reduction, global_city_reduction = CalculatePolicyReduction(pPlayer); -- currently broke as struggling to iterate over SQL table
    local num_cities = 0;
    local glob_dist_tax = 0.0;
    local glob_num_tax = 0.0;
    -- num cities cost (0.6 + 0.033*(city pop - 1))*(number of cities)/2
    -- d = (ring number)*0.29. we can approximate rings as hex distance. so simple euclidean.
    -- distance D = (7 + pop)*d*0.29/8
    SlthLog('Player is: '.. playerId);
    for idx, city in pPlayer:GetCities():Members() do
        num_cities = num_cities + 1;
    end
    for idx, city in pPlayer:GetCities():Members() do
        local distance = city:GetProperty('distance');
        local mult_city = city:GetProperty('city_mult');
        local iCityPop = city:GetPopulation() or 1
        local distancePostSum = ((7 + iCityPop) * distance * 0.29) / 8
        local numCityPostSum = (0.6 + (0.033 * (iCityPop - 1))) * num_cities / 2
        local dist_tax_final = (distancePostSum * mult_city) / 100
        local num_tax_final = (numCityPostSum * mult_city) / 100
        glob_dist_tax = glob_dist_tax + dist_tax_final;
        glob_num_tax = glob_num_tax + num_tax_final;
        -- SlthLog('City Distance Tax cost:'.. dist_tax_final);
        -- SlthLog('City Num Tax cost:'.. num_tax_final);
    end
    local num_tax_final = glob_num_tax * global_city_reduction / 100;
    -- SlthLog('Global Num Cities Tax cost:'.. num_tax_final);
    pPlayer:SetProperty('city_num_maintenance', num_tax_final);
    local taxes = glob_dist_tax * global_dist_reduction / 100;
    pPlayer:SetProperty('city_distance_maintenance', taxes);
    -- SlthLog('Global Distance Cities Tax cost:'.. taxes);
    taxes = taxes + num_tax_final;
    -- SlthLog('Total tax cost:'.. -taxes);

    -- unit maintenance section
    local iDifficultySupport = pPlayer:GetProperty('FreeUnitSupport') or 12       -- we may alter this with the Military State one...
    local pUnits = pPlayer:GetUnits()
    local iUnitTotal = pUnits:GetCount()
    local iUnitMaintenance = 0
    local iPopSupport
    local iFreeSupport
    local iPlayerPop = 0
    if iUnitTotal > iDifficultySupport then                 -- be smarter and cache in future, using pop change callbacks.
        for _, pCity in pPlayer:GetCities():Members() do          -- but worried about drift and missing something, like
            local iCityPop = pCity:GetPopulation() or 0             -- pop change on city conquer
            iPlayerPop = iPlayerPop + iCityPop
        end
        iPopSupport = math.floor(iPlayerPop *0.25)
        iFreeSupport = iPopSupport + iDifficultySupport
        -- print('unit total/Support:', iUnitTotal, iFreeSupport)
        if iUnitTotal > iFreeSupport then
            local iDifficultyPaymentReducer = pPlayer:GetProperty('UnitSupportMult') or 0.5
            iUnitMaintenance = iUnitTotal - iFreeSupport
            iUnitMaintenance = math.floor(iUnitMaintenance * iDifficultyPaymentReducer)
        end
    end

    local iAwaySupportCost = getUnitCountForeign(playerId, pUnits)
    -- print('Player/Maintenance/Allowance:', playerId, -iUnitMaintenance, iFreeSupport);
    -- print('Pop Allowance/Multiplier/Away Support cost', iPopSupport, iDifficultyPaymentReducer, iAwaySupportCost)
    pPlayer:SetProperty('UnitMaintenance', iUnitMaintenance);
    pPlayer:SetProperty('TotalPopulation', iPlayerPop);
    pPlayer:SetProperty('AwayUnitSupport', iAwaySupportCost);
    pPlayer:SetProperty('UnitCount', iUnitTotal)
    taxes = taxes + iUnitMaintenance + iAwaySupportCost;
    local playerReligion= pPlayer:GetReligion();
    adjustSliders(playerId, pPlayer, playerReligion, taxes)
    pPlayer:GrantYield(2, -taxes);
    -- we also kill all faith accumulation, because the AI maybe using it, pesky
    local faithBalance	 = playerReligion:GetFaithBalance();
    pPlayer:GrantYield(5, -faithBalance);
end

function InitCityTax(playerID, cityID, x, y)
    local pPlayer = Players[playerID];
    local pCity = CityManager.GetCity(playerID, cityID);
    local pCapital = pPlayer:GetCities():GetCapitalCity();        -- later on, do check if gov plaza closer
    if pCapital then
        local cap_x = pCapital:GetX();
        local cap_y = pCapital:GetY();
        local distance = Map.GetPlotDistance(x, y, cap_x, cap_y) - 3;
        SlthLog('Distance from capital -3 on init: ' .. distance);
        pCity:SetProperty('distance', distance);
    else
        -- SlthLog('No Capital found! Was this first city?');
        pCity:SetProperty('distance', 0);
    end
    pCity:SetProperty('city_mult', 100);
    pCity:SetProperty('city_mult', 100);
end

function BuildingTaxReductionMade(playerID, cityID, buildingID, plotID, isOriginalConstruction)
    local buildingName = GameInfo.Buildings[buildingID];
    SlthLog(buildingName.BuildingType);
    local building_row = MaintenanceReductionBuildings[buildingName.BuildingType];
    if building_row then
        local pCity = CityManager.GetCity(playerID, cityID);
	    local tax_val = pCity:GetProperty('city_mult');
	    tax_val = tax_val + building_row;
	    SlthLog('New tax mult on this city: ' .. tax_val);
	    pCity:SetProperty('city_mult', tax_val);
    end
    local buildingGovern = GovernCentres[buildingName.BuildingType]
    if buildingGovern then
        local pPlayer = Players[playerID];
        local pCity = CityManager.GetCity(playerID, cityID);
        local location = {x=pCity:GetX(),y=pCity:GetY()}
        pPlayer:SetProperty(buildingGovern, location);
        local t_GovernorSeats = GetGovernanceDistances(pPlayer);
        for _, city in pPlayer:GetCities():Members() do
            CalculateGovernanceDistance(city, t_GovernorSeats);
            SlthLog('city iterate-------------');
        end
    end
end

function BuildingTaxPillageStateChange(playerID, cityID, buildingID, isPillaged)
    local buildingName = GameInfo.Buildings[buildingID];                                -- i suspec buildingID is wrong
    if not buildingName then print('MAINTENANCE BuildingTaxPillageStateChange fails, likely BuildingID is not BuildingType'); return; end
    local building_row = MaintenanceReductionBuildings[buildingName.BuildingType];     -- MaintenanceReductionBuildings[buildingName.BuildingType]
    if building_row then
        local pCity = CityManager.GetCity(playerID, cityID);
        local tax_val = pCity:GetProperty('city_mult');
    	if isPillaged then
	        tax_val = tax_val - building_row;
        else
	        tax_val = tax_val + building_row;
        end
        pCity:SetProperty('city_mult', tax_val);
    end
    local buildingGovern = GovernCentres[buildingName.BuildingType]
    if buildingGovern then
        local pPlayer = Players[playerID];
        local new_prop = nil;
        if not isPillaged then
	        new_prop = {x=pCity:GetX(), y=pCity:GetY()};
        end
        pPlayer:SetProperty(buildingGovern, new_prop);
        local tGovernSeats = GetGovernanceDistances(pPlayer);
        for _, city in pPlayer:GetCities():Members() do
            CalculateGovernanceDistance(city, tGovernSeats);
        end
    end
end

function CapitalCityRecalc(playerID, cityID)
    local pPlayer = Players[playerID];
    local tGovernSeats = GetGovernanceDistances(pPlayer);
    for _, city in pPlayer:GetCities():Members() do
        CalculateGovernanceDistance(city, tGovernSeats);
    end
end

function CalculatePolicyReduction(pPlayer)
    local dist_mult = 100;
    local city_mult = 100;
    local kCulture = pPlayer:GetCulture();
    for policyType, details in pairs(MaintenanceReductionPolicies) do
        local policy = GameInfo.Policies[policyType];
        if not policy then return 100, 100; end
        if kCulture:IsPolicyActive(policy.Index) then
            if details.CityReduction then
                city_mult = city_mult + details.CityReduction;
            end
            if details.DistanceReduction then
                dist_mult = dist_mult + details.DistanceReduction;
            end
        end
    end
    if dist_mult < 0 then dist_mult = 0; end
    if city_mult < 0 then city_mult = 0; end
    return dist_mult, city_mult
end

function CalculateGovernanceDistance(city, tGovernSeats_)
    local city_x = city:GetX();
    local city_y = city:GetY();
    local best_distance = 999;
    local closest_seat = '';
    for building_name, location in pairs(tGovernSeats_) do
        if location.empty then city:SetProperty('distance', best_distance); SlthLog('tGovernSeats_ was empty'); return; end     -- on first city settle
        local distance = Map.GetPlotDistance(city_x, city_y, location.x, location.y);
        if distance < best_distance then
            best_distance = distance;
            closest_seat = building_name;
        end
    end
    SlthLog('distance is '.. best_distance .. ' from ' .. closest_seat);
    city:SetProperty('distance', best_distance);
end

function GetGovernanceDistances(pPlayer)
    local pCapital = pPlayer:GetCities():GetCapitalCity();
    if not pCapital then local empty = {empty=True}; return {no_seat=empty}; end
    local cap_x = pCapital:GetX();
    local cap_y = pCapital:GetY();
    local tGovernSeats = {};
    table.insert(tGovernSeats, {x=cap_x, y=cap_y});
    for building, property_name in pairs(GovernCentres) do
        if pPlayer:GetProperty(property_name) then
             tGovernSeats[building] = pPlayer:GetProperty(property_name);
        end
    end
    return tGovernSeats
end

function SlthLog(sMessage)
    SLTH_DEBUG_ON = nil
    if SLTH_DEBUG_ON then
        print(sMessage)
    end
end


GameEvents.PlayerTurnStarted.Add(MasterTax);
GameEvents.CityBuilt.Add(InitCityTax);
GameEvents.BuildingConstructed.Add(BuildingTaxReductionMade);
GameEvents.BuildingPillageStateChanged.Add(BuildingTaxPillageStateChange);
GameEvents.CapitalCityChanged.Add(CapitalCityRecalc);

-- also do unitSupport here.
--[[
However, the free support in the unit cost section is dependent on the total size of your population (the sum of all of your city sizes) and the difficulty level. If we name the size of your population N and the difficulty level bonus D then the free support for units is [0.24 * N] + D. This difficulty level bonus is 5 at Deity, 6 at Immortal, 7 at Emperor, 8 at Monarch, 10 at Prince, 12 at Noble, 16 at Warlord, 22 at Chieftain and finally 28 at Settler level.
The vassalage civic provides you with an additional free unit support which is again dependent on your population size: [0.1 * N] + 5.
The free support in the military unit section is also dependent on the size of your population: [0.12 * N] + 2.
All of these numbers are rounded down.
The handicap cost is a percentage of the total unit cost (unit cost + military unit cost) which is dependent on the difficulty level. The percentage is 0 at Deity, 10 at Immortal, 20 at Emperor, 30 at Monarch, 40 at Prince, 50 at Noble, 60 at Warlord, 70 at Chieftain and finally 80 at Settler level. This number is rounded up.

An example:

10: Unit cost for 10 units (free support for 14)
15: Military unit cost for 15 units (free support for 3)
-13: handicap cost

These are the unit costs from an empire with a size 5, 3 and 2 city. So the total population size is 10. It is a game at Noble
difficulty level, so the difficulty level bonus is 12. In this game the vassalage civic that grants additional free support is not used.
 So the free support is 0.24 * 10 + 12 = 14 (rounded down).
In this game, the pacifism civic is used and we thus have to pay military unit costs. The free support is 0.12 * 10 + 2 = 3 (rounded down).
As this is a game at Noble difficulty level, the handicap costs are 50% of 25 = 13 (rounded up).
]]--

-- no vassalage afaik. Or pacifism. But rhere are some sources of free unit support.else



function getUnitCountForeign(playerId, pUnits)
    local iForeignTerritoryUnitCount = 0
    for _, pUnit in pUnits:Members() do
        local iX, iY = pUnit:GetX(), pUnit:GetY()
        local pPlot = Map.GetPlot(iX, iY)
        if pPlot then
            local iPlotOwner = pPlot:GetOwner()
            if iPlotOwner and iPlotOwner ~= playerId then
                iForeignTerritoryUnitCount = iForeignTerritoryUnitCount + 1
            end
        end
    end
    Players[playerId]:SetProperty('AwayUnitCount', iForeignTerritoryUnitCount)
    if iForeignTerritoryUnitCount > 4 then
        return math.floor((iForeignTerritoryUnitCount-4) * 0.5)
    else
        return 0
    end
end
local sCommerceScienceConversionKey = 'CommIntoScience'
local sCommerceGoldConversionKey = 'CommIntoGold'
local iCustomSlidersOffKey = 'CustomSlidersOff'
local sManualSlidersKey = 'manualSlidersSet'
function adjustSliders(playerId, pPlayer, pReligion, iExtraTax)
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    if pCapitalCity then
        local pPlot = pCapitalCity:GetPlot()
        local playerTreasury = pPlayer:GetTreasury()
        local goldYield = playerTreasury:GetGoldYield() - playerTreasury:GetTotalMaintenance() - iExtraTax;
        print('goldyield is treasuryYield - maintenance - extraTax', playerTreasury:GetGoldYield(), '-', playerTreasury:GetTotalMaintenance(), '-', iExtraTax, '=', goldYield)
        local goldBalance = math.floor(playerTreasury:GetGoldBalance());
        local iGoldRatio = pPlot:GetProperty(sCommerceGoldConversionKey) or 1
        local faithYield = pReligion:GetFaithYield();
        local iCurrentCommerceGold = faithYield * iGoldRatio /10
        local noCommerceGoldYield = goldYield - iCurrentCommerceGold
        print('For player:', playerId, 'Commerce', faithYield, 'GoldRatio', iGoldRatio, 'Gold From Commerce', iCurrentCommerceGold, 'Gold without Commerce', noCommerceGoldYield)
        local iNewGoldAmount
        print('is gold yield below 0',goldYield )
        print('Gold loss',-goldYield, '> ', goldBalance, ' and is 10 >', iGoldRatio)
        if goldYield < 0 and -goldYield > goldBalance and iGoldRatio < 10 then                  -- in the red, try adjust slider
            iNewGoldAmount = math.ceil((-noCommerceGoldYield * 10) / faithYield)
            print('We were in the red, changing sliders: commerce/GoldWithoutCommerce/NewGoldRatio', faithYield, noCommerceGoldYield, iNewGoldAmount)
        else
            -- positive gold. If the yield per turn is more than 10% gold ratio, adjust so
            -- instead get the minimum unit, 10% and adjust so its always 10% more than required.
            -- But first, ensure we arent manually managing sliders
            local bIsManualSliders = pPlayer:GetProperty(sManualSlidersKey) or 0
            if bIsManualSliders == 1 then
                iNewGoldAmount = iGoldRatio
                print('player had manually set sliders.')
            else
                print('we were ok gold wise, and no sliders set, see if we wanna adjust gold ratio', iGoldRatio)
                if iGoldRatio < 10 then                      -- if all science, dont bother
                    local iGoldPer10 = faithYield/10
                    -- given the noCommerceGoldYield, what number of iGoldPer10 need added to make it at least iGoldPer10 gold
                    -- iGoldPer10 = noCommerceGoldYield + n*iGoldPer10
                    print('10pct of our commerce is granting', iGoldPer10)
                    print('aim to get at least 10pct commerce in the black')
                    print('Without any commerce our gold yield is', noCommerceGoldYield)
                    print('how many instances of 10pct commerce grant us 10pct gold positive?')
                    print('assume', iGoldPer10, 'positive gold yield, then we subtract our gold yield from that')
                    print(iGoldPer10, '-', noCommerceGoldYield, '=', (iGoldPer10 - noCommerceGoldYield))
                    print('Thats the amount of gold we want to earn from our commerce.',  (iGoldPer10 - noCommerceGoldYield))
                    print('So how many instances of our 10pct commerce fit into that')
                    print((iGoldPer10 - noCommerceGoldYield),  '/', iGoldPer10, (iGoldPer10 - noCommerceGoldYield)/iGoldPer10)
                    iNewGoldAmount = math.ceil((iGoldPer10 - noCommerceGoldYield) / iGoldPer10)
                    print('then rounded up', iNewGoldAmount)
                else
                    iNewGoldAmount = iGoldRatio
                end
            end
        end
        print('Old/New commerce into gold ratio:',iGoldRatio, iNewGoldAmount)
        if iNewGoldAmount > 10 then iNewGoldAmount = 10 end                 -- oh dear, still in the red.
        if iNewGoldAmount < 0 then iNewGoldAmount = 0 end
        local iNewScienceAmount = 10 - iNewGoldAmount
        print('Post adjust Old/New commerce into gold ratio:',iGoldRatio, iNewGoldAmount)
        print('science ratio', iNewScienceAmount)
        if iNewGoldAmount ~= iGoldRatio then
            pPlayer:SetProperty(sCommerceGoldConversionKey, iNewGoldAmount)
            pPlot:SetProperty(sCommerceGoldConversionKey, iNewGoldAmount)

            pPlayer:SetProperty(sCommerceScienceConversionKey, iNewScienceAmount)
            pPlot:SetProperty(sCommerceScienceConversionKey, iNewScienceAmount)
            print('updating commerce conversion to Science/Gold', iNewScienceAmount, iNewGoldAmount)
        end
    end
end


-- settler 24, 70. chief 18, 80, Warlord, 12, 90.Noble, 8 ,100. Prince, 6, 105.Monarch,4, 110. Emp,3 115. Imm, 2,120. Dei 1,125
-- but article said , 28, 22, 16, 12, 10, 8, 7, 6, 5
local iSettlerDiffIndex = GameInfo.Difficulties['DIFFICULTY_SETTLER'].Index
local iChiefDiffIndex = GameInfo.Difficulties['DIFFICULTY_CHIEFTAIN'].Index
local iWarlordDiffIndex = GameInfo.Difficulties['DIFFICULTY_WARLORD'].Index
local iPrinceDiffIndex = GameInfo.Difficulties['DIFFICULTY_PRINCE'].Index
local iKingDiffIndex = GameInfo.Difficulties['DIFFICULTY_KING'].Index
local iEmperorDiffIndex = GameInfo.Difficulties['DIFFICULTY_EMPEROR'].Index
local iImmortalDiffIndex = GameInfo.Difficulties['DIFFICULTY_IMMORTAL'].Index
local iDeityDiffIndex = GameInfo.Difficulties['DIFFICULTY_DEITY'].Index
tDifficultySupportMapper = {
    [iSettlerDiffIndex] =       28,
    [iChiefDiffIndex] =         22,
    [iWarlordDiffIndex] =       16,
    [iPrinceDiffIndex] =        12,
    [iKingDiffIndex] =          10,
    [iEmperorDiffIndex] =       8,
    [iImmortalDiffIndex] =      7,
    [iDeityDiffIndex] =         6
}           --  dei = 5

tDifficultyMaintenanceReducerMapper = {
    [iSettlerDiffIndex] =       0.2,
    [iChiefDiffIndex] =         0.3,
    [iWarlordDiffIndex] =       0.4,
    [iPrinceDiffIndex] =        0.5,
    [iKingDiffIndex] =          0.6,
    [iEmperorDiffIndex] =       0.7,
    [iImmortalDiffIndex] =      0.8,
    [iDeityDiffIndex] =         0.9
}

for _, iPlayer in ipairs(PlayerManager.GetAliveMajorIDs()) do
    local iDifficultyHash = PlayerConfigurations[iPlayer]:GetHandicapTypeID()
    local iPlayerDifficulty = GameInfo.Difficulties[iDifficultyHash].Index
    local iDifficultySupport = tDifficultySupportMapper[iPlayerDifficulty]
    local iDifficultySupportMult = tDifficultyMaintenanceReducerMapper[iPlayerDifficulty]
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty('FreeUnitSupport', iDifficultySupport)
    pPlayer:SetProperty('UnitSupportMult', iDifficultySupportMult)
end



