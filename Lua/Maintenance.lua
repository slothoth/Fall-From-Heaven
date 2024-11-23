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

function MasterTax(playerId)
    local pPlayer = Players[playerId];
    if not pPlayer:IsMajor() then return; end;
    local global_dist_reduction, global_city_reduction = CalculatePolicyReduction(pPlayer); -- currently broke as struggling to iterate over SQL table
    local num_cities = 0;
    local glob_dist_tax = 0.0;
    local glob_num_tax = 0.0;
    SlthLog('Player is: '.. playerId);
    for idx, city in pPlayer:GetCities():Members() do
        num_cities = num_cities + 1;
    end
    for idx, city in pPlayer:GetCities():Members() do
        local dist_tax = city:GetProperty('distance');
        local mult_city = city:GetProperty('city_mult');
        local dist_tax_final = (dist_tax * mult_city) / 100 / 2;
        local num_tax_final = (num_cities * mult_city) / 100    / 2;
        glob_dist_tax = glob_dist_tax + dist_tax_final;
        glob_num_tax = glob_num_tax + num_tax_final;
        SlthLog('City Distance Tax cost:'.. dist_tax_final);
        SlthLog('City Num Tax cost:'.. num_tax_final);
    end
    local num_tax_final = glob_num_tax * global_city_reduction / 100;
    SlthLog('Global Num Cities Tax cost:'.. num_tax_final);
    pPlayer:SetProperty('city_num_maintenance', num_tax_final);
    local taxes = glob_dist_tax * global_dist_reduction / 100;
    pPlayer:SetProperty('city_distance_maintenance', taxes);
    SlthLog('Global Distance Cities Tax cost:'.. taxes);
    taxes = taxes + num_tax_final;
    SlthLog('Total tax cost:'.. -taxes);
    pPlayer:GrantYield(2, -taxes);          -- 2 is hopefully gold attempt to index a number value?
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