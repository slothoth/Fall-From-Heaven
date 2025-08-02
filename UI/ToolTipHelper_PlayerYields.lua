function GetExtendedGoldTooltip()
	local szReturnValue = "";

	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID ~= -1) then
		local playerTreasury	= Players[localPlayerID]:GetTreasury();
		local dist_maintenance = Players[localPlayerID]:GetProperty('city_distance_maintenance') or 0
		local num_maintenance = Players[localPlayerID]:GetProperty('city_num_maintenance') or 0
		local unit_maintenance = localPlayer:GetProperty('UnitMaintenance') or 0;
		local unit_away_support =  localPlayer:GetProperty('AwayUnitSupport') or 0;
		local populationSupportReduction =  localPlayer:GetProperty('AwayUnitSupport') or 0;
		local iDifficultySupport = pPlayer:GetProperty('FreeUnitSupport') or 12
		local iDifficultyPaymentReducer = pPlayer:GetProperty('UnitSupportMult') or 0.5
		-- Expense: Units -12. (Unit count = 30 Pop= 24. 24/4 = 6. Handicap = 12. 30 - 6 - 12 = 12
		--			Away Units: -3.5 (11 -4 free, /2)
		local tCosts = {
						LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS = playerTreasury:GetTotalMaintenance(),
						LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_BUILDINGS = playerTreasury:GetBuildingMaintenance(),
						LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_DISTRICTS = playerTreasury:GetDistrictMaintenance(),
						LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_UNITS = playerTreasury:GetUnitMaintenance(),
						LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_WMDS = playerTreasury:GetWMDMaintenance(),
						LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_CITY_MAINTENANCE = dist_maintenance,
						LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_CITY_DISTANCE_MAINTENANCE = num_maintenance
		}
		local netGold = playerTreasury:GetGoldYield() - playerTreasury:GetTotalMaintenance() - dist_maintenance - num_maintenance - unit_maintenance - unit_away_support
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_NET", netGold);
		szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_GROSS", playerTreasury:GetGoldYield());
		szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
		for loc, val in pairs(tCosts) do
			if val ~= 0 then
				szReturnValue = szReturnValue .. "[NEWLINE]  " .. Locale.Lookup(loc, val)
			end
		end
		-- local inferredSiphonFundsAmount = playerTreasury:GetTotalMaintenance() - playerTreasury:GetBuildingMaintenance() - playerTreasury:GetDistrictMaintenance() - playerTreasury:GetUnitMaintenance() - playerTreasury:GetWMDMaintenance();
		-- szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_HOSTILE_SPIES", inferredSiphonFundsAmount);
	end
	return szReturnValue;
end

-- ===========================================================================
function GetGoldTooltip()
	local szReturnValue = "";
	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID ~= -1) then
		local localPlayer = Players[localPlayerID]
		local playerTreasury	= localPlayer:GetTreasury();

		local dist_maintenance = localPlayer:GetProperty('city_distance_maintenance') or 0
		local num_maintenance = localPlayer:GetProperty('city_num_maintenance') or 0
		local unit_maintenance = localPlayer:GetProperty('UnitMaintenance') or 0;
		local unit_away_support =  localPlayer:GetProperty('AwayUnitSupport') or 0;
		local iUnitCount =  localPlayer:GetProperty('UnitCount') or 0;
		local iAwayUnitCount =  localPlayer:GetProperty('AwayUnitCount') or 0;
		local unAdjustedAwaySupport = unit_away_support * 2
		local iTotalPop =  localPlayer:GetProperty('TotalPopulation') or 1;
		local iPopSupport = math.floor(iTotalPop *0.25)
		local iDifficultySupport = localPlayer:GetProperty('FreeUnitSupport') or 12
		local iDifficultyPaymentReducer = localPlayer:GetProperty('UnitSupportMult') or 0.5
		local unMultSupport = unit_maintenance / iDifficultyPaymentReducer
		-- Expense: Units -12. (Unit count = 30 Pop= 24. 24/4 = 6. Handicap = 12. 30 - 6 - 12 = 12
		--			Away Units: -3.5 (11 -4 free, /2)
		local tCosts = {
			LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS = playerTreasury:GetTotalMaintenance(),
			LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_BUILDINGS = playerTreasury:GetBuildingMaintenance(),
			LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_DISTRICTS = playerTreasury:GetDistrictMaintenance(),
			LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_UNITS = playerTreasury:GetUnitMaintenance(),
			LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_WMDS = playerTreasury:GetWMDMaintenance(),
			LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_CITY_MAINTENANCE = -dist_maintenance,
			LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_CITY_DISTANCE_MAINTENANCE = -num_maintenance,
		}
		local netGold = playerTreasury:GetGoldYield() - playerTreasury:GetTotalMaintenance() - dist_maintenance - num_maintenance - unit_maintenance - unit_away_support
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_NET", netGold);
		szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_GROSS", playerTreasury:GetGoldYield());
		local bSomeAdditionalCostsExist
		for loc, val in pairs(tCosts) do
			if val ~= 0 then
				if not bSomeAdditionalCostsExist then
					szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
					bSomeAdditionalCostsExist = true
				end
				szReturnValue = szReturnValue .. "[NEWLINE]" .. Locale.Lookup(loc, val)
			end
		end
		-- complex
		if unit_maintenance > 0 then
			szReturnValue = szReturnValue .. "[NEWLINE]" .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_UNIT_SUPPORT", unit_maintenance, iUnitCount, iTotalPop, iPopSupport, iDifficultySupport, iDifficultyPaymentReducer, unMultSupport);
		end
		if unit_away_support > 0 then
			szReturnValue = szReturnValue .. "[NEWLINE]" .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_UNIT_AWAY_SUPPORT", unit_away_support, iAwayUnitCount, unAdjustedAwaySupport);
		end
	end
	return szReturnValue;
end

function GetScienceTooltip()
	local szReturnValue = "";

	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID ~= -1) then
		local playerTechnology		:table	= Players[localPlayerID]:GetTechs();
		local currentScienceYield	:number = playerTechnology:GetScienceYield();

		szReturnValue = Locale.Lookup("LOC_TOP_PANEL_SCIENCE_YIELD");
		local science_tt_details = playerTechnology:GetScienceYieldToolTip();
		if(#science_tt_details > 0) then
			szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]" .. science_tt_details;
		end
	end
	return szReturnValue;
end

-- ===========================================================================
function GetCultureTooltip()
	local szReturnValue = "";

	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID ~= -1) then
		local playerCulture			:table	= Players[localPlayerID]:GetCulture();
		local currentCultureYield	:number = playerCulture:GetCultureYield();

		szReturnValue = Locale.Lookup("LOC_TOP_PANEL_CULTURE_YIELD");
		local culture_tt_details = playerCulture:GetCultureYieldToolTip();
		if(#culture_tt_details > 0) then
			szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]" .. culture_tt_details;
		end
	end
	return szReturnValue;
end

-- ===========================================================================
function GetFaithTooltip()
	local szReturnValue = "";

	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID ~= -1) then
		local playerReligion		:table	= Players[localPlayerID]:GetReligion();
		local faithYield			:number = playerReligion:GetFaithYield();
		local faithBalance			:number = playerReligion:GetFaithBalance();

		szReturnValue = Locale.Lookup("LOC_TOP_PANEL_FAITH_YIELD");
		local faith_tt_details = playerReligion:GetFaithYieldToolTip();
		if(#faith_tt_details > 0) then
			szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]" .. faith_tt_details;
		end
	end
	return szReturnValue;
end

