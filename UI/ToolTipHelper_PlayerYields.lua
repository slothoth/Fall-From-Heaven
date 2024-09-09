include("ToolTipHelper_PlayerYields")
-- ===========================================================================
-- Shared code to get the tool tip for the local player's gold.
--
-- May want to merge this with ToolTipHelper, though it that file is quite large
-- and the files that currently need the yields tool tip don't require all that
-- extra baggge.
-- ===========================================================================

-- ===========================================================================
function GetExtendedGoldTooltip()
	local szReturnValue = "";

	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID ~= -1) then
		local playerTreasury:table	= Players[localPlayerID]:GetTreasury();
		local dist_maintenance = Players[localPlayerID]:GetProperty('city_distance_maintenance');
		local num_maintenance = Players[localPlayerID]:GetProperty('city_num_maintenance');
		if not dist_maintenance then dist_maintenance = 0; end
		if not num_maintenance then num_maintenance = 0; end
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_NET", playerTreasury:GetGoldYield() - playerTreasury:GetTotalMaintenance() - dist_maintenance - num_maintenance);
		szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_GROSS", playerTreasury:GetGoldYield());
		szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS", playerTreasury:GetTotalMaintenance());
		szReturnValue = szReturnValue .. "[NEWLINE]  ";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_BUILDINGS", playerTreasury:GetBuildingMaintenance());
		szReturnValue = szReturnValue .. "[NEWLINE]  ";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_DISTRICTS", playerTreasury:GetDistrictMaintenance());
		szReturnValue = szReturnValue .. "[NEWLINE]  ";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_UNITS", playerTreasury:GetUnitMaintenance());
		szReturnValue = szReturnValue .. "[NEWLINE]  ";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_WMDS", playerTreasury:GetWMDMaintenance());
		szReturnValue = szReturnValue .. "[NEWLINE]  ";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_CITY_MAINTENANCE", dist_maintenance);
		szReturnValue = szReturnValue .. "[NEWLINE]  ";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_CITY_DISTANCE_MAINTENANCE", num_maintenance);
		szReturnValue = szReturnValue .. "[NEWLINE]  ";
		local inferredSiphonFundsAmount = playerTreasury:GetTotalMaintenance() - playerTreasury:GetBuildingMaintenance() - playerTreasury:GetDistrictMaintenance() - playerTreasury:GetUnitMaintenance() - playerTreasury:GetWMDMaintenance();
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD_TOOLTIP_COSTS_HOSTILE_SPIES", inferredSiphonFundsAmount);
	end
	return szReturnValue;
end

-- ===========================================================================
function GetGoldTooltip()
	local szReturnValue = "";

	local localPlayerID = Game.GetLocalPlayer();
	if (localPlayerID ~= -1) then
		local playerTreasury:table	= Players[localPlayerID]:GetTreasury();

		local income_tt_details = playerTreasury:GetGoldYieldToolTip();
		local expense_tt_details = playerTreasury:GetTotalMaintenanceToolTip();

		local dist_maintenance = Players[localPlayerID]:GetProperty('city_distance_maintenance');
		local num_maintenance = Players[localPlayerID]:GetProperty('city_num_maintenance');
		if not dist_maintenance then dist_maintenance = 0; end
		if not num_maintenance then num_maintenance = 0; end

		szReturnValue = Locale.Lookup("LOC_TOP_PANEL_GOLD_YIELD");
		szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_INCOME", playerTreasury:GetGoldYield());
		if(#income_tt_details > 0) then
			szReturnValue = szReturnValue .. "[NEWLINE]" .. income_tt_details;
		end

		szReturnValue = szReturnValue .. "[NEWLINE][NEWLINE]";
		szReturnValue = szReturnValue .. Locale.Lookup("LOC_TOP_PANEL_GOLD_EXPENSE", -playerTreasury:GetTotalMaintenance() - dist_maintenance - num_maintenance);
		if(#expense_tt_details > 0) then
			szReturnValue = szReturnValue .. "[NEWLINE]" .. expense_tt_details;
		end
	end
	return szReturnValue;
end
