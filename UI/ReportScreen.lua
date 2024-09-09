include("ReportScreen");


-- ===========================================================================
--	DEBUG
--	Toggle these for temporary debugging help.
-- ===========================================================================
local m_debugNumResourcesStrategic	:number = 0;			-- (0) number of extra strategics to show for screen testing.
local m_debugNumBonuses				:number = 0;			-- (0) number of extra bonuses to show for screen testing.
local m_debugNumResourcesLuxuries	:number = 0;			-- (0) number of extra luxuries to show for screen testing.
debug_print = False;

-- ===========================================================================
--	CONSTANTS
-- ===========================================================================

local RELOAD_CACHE_ID:string = "ReportScreen"; -- Must be unique (usually the same as the file name)

local DARKEN_CITY_INCOME_AREA_ADDITIONAL_Y		:number = 6;
local DATA_FIELD_SELECTION						:string = "Selection";
local SIZE_HEIGHT_BOTTOM_YIELDS					:number = 135;
local SIZE_HEIGHT_PADDING_BOTTOM_ADJUST			:number = 85;	-- (Total Y - (scroll area + THIS PADDING)) = bottom area
local INDENT_STRING								:string = "        ";
local GOSSIP_ENTRY_CONSTANT						:number = 62;
local GOSSIP_HEADER_SIZE						:number = 230;
local GOSSIP_FILTER_ALL							:string = "ALL";

local REPORT_PAGES	:table = {
	YIELDS		= 1,
	RESOURCES	= 2,
	CITY_STATUS = 3,
	GOSSIP		= 4
}

-- Mapping of unit type to cost.
local UnitCostMap:table = {};
do
	for row in GameInfo.Units() do
		UnitCostMap[row.UnitType] = row.Maintenance;
	end
end

-- ===========================================================================
--	VARIABLES
-- ===========================================================================

local m_simpleIM				:table = InstanceManager:new("SimpleInstance",			"Top",		Controls.Stack);				-- Non-Collapsable, simple
local m_tabIM					:table = InstanceManager:new("TabInstance",				"Button",	Controls.TabContainer);
local m_strategicResourcesIM	:table = InstanceManager:new("ResourceAmountInstance",	"Info",		Controls.StrategicResources);
local m_bonusResourcesIM		:table = InstanceManager:new("ResourceAmountInstance",	"Info",		Controls.BonusResources);
local m_luxuryResourcesIM		:table = InstanceManager:new("ResourceAmountInstance",	"Info",		Controls.LuxuryResources);
local m_groupIM					:table = InstanceManager:new("GroupInstance",			"Top",		Controls.Stack);				-- Collapsable

local m_kTabs:table = nil;
local m_CurrentReportTab:number = 1;

local m_kResourceData		:table = nil;
local m_kCityData			:table = nil;
local m_kCityTotalData		:table = nil;
local m_kUnitData			:table = nil;	-- TODO: Show units by promotion class
local m_kDealData			:table = nil;
local m_uiGroups			:table = nil;	-- Track the groups on-screen for collapse all action.

local m_isCollapsing		:boolean = true;

--Gossip filtering
local m_kGossipInstances:table = {};
local m_groupFilter:string = GOSSIP_FILTER_ALL;
local m_leaderFilter:number = -1;	-- (-1) Indicates Unfilitered by this criteria (PlayerID)
local m_kGossipLog:table = {};
local m_kGossipLogFiltered:table = {};
local m_kGossipFiltersToShow:table = {}; -- GroupType indexed table used to determine which gossip GroupType filters to show
local m_CountPerPage:number = 0;
local m_CurrentGossipPage:number = 0;
local m_MaxPages:number = 0;
local m_uiPaginationInstance:table = {};
local m_uiGossipFilterInstance:table = {};

local m_kGossipGroupTypes:table	= {};

-- ===========================================================================
--	Populate with all data required for any/all report tabs.
-- ===========================================================================
function GetData()
	local kResources	:table = {};
	local kCityData		:table = {};
	local kCityTotalData:table = {
		Income	= {},
		Expenses= {},
		Net		= {},
		Treasury= {}
	};
	local kUnitData		:table = {};


	kCityTotalData.Income[YieldTypes.CULTURE]	= 0;
	kCityTotalData.Income[YieldTypes.FAITH]		= 0;
	kCityTotalData.Income[YieldTypes.FOOD]		= 0;
	kCityTotalData.Income[YieldTypes.GOLD]		= 0;
	kCityTotalData.Income[YieldTypes.PRODUCTION]= 0;
	kCityTotalData.Income[YieldTypes.SCIENCE]	= 0;
	kCityTotalData.Income["TOURISM"]			= 0;
	kCityTotalData.Expenses[YieldTypes.GOLD]	= 0;
	
	local playerID	:number = Game.GetLocalPlayer();
	if playerID == PlayerTypes.NONE then
		UI.DataError("Unable to get valid playerID for report screen.");
		return;
	end

	local player	:table  = Players[playerID];
	local pCulture	:table	= player:GetCulture();
	local pTreasury	:table	= player:GetTreasury();
	local pReligion	:table	= player:GetReligion();
	local pScience	:table	= player:GetTechs();
	local pResources:table	= player:GetResources();		

	local pCities = player:GetCities();
	for i, pCity in pCities:Members() do	
		local cityName	:string = pCity:GetName();
			
		-- Big calls, obtain city data and add report specific fields to it.
		local data		:table	= GetCityData( pCity );
		data.Resources			= GetCityResourceData( pCity );					-- Add more data (not in CitySupport)			
		data.WorkedTileYields	= GetWorkedTileYieldData( pCity, pCulture );	-- Add more data (not in CitySupport)
		data.Order= i;

		-- Add to totals.
		kCityTotalData.Income[YieldTypes.CULTURE]	= kCityTotalData.Income[YieldTypes.CULTURE] + data.CulturePerTurn;
		kCityTotalData.Income[YieldTypes.FAITH]		= kCityTotalData.Income[YieldTypes.FAITH] + data.FaithPerTurn;
		kCityTotalData.Income[YieldTypes.FOOD]		= kCityTotalData.Income[YieldTypes.FOOD] + data.FoodPerTurn;
		kCityTotalData.Income[YieldTypes.GOLD]		= kCityTotalData.Income[YieldTypes.GOLD] + data.GoldPerTurn;
		kCityTotalData.Income[YieldTypes.PRODUCTION]= kCityTotalData.Income[YieldTypes.PRODUCTION] + data.ProductionPerTurn;
		kCityTotalData.Income[YieldTypes.SCIENCE]	= kCityTotalData.Income[YieldTypes.SCIENCE] + data.SciencePerTurn;
		kCityTotalData.Income["TOURISM"]			= kCityTotalData.Income["TOURISM"] + data.WorkedTileYields["TOURISM"];
			
		table.insert(kCityData, data);

		-- Add outgoing route data
		data.OutgoingRoutes = pCity:GetTrade():GetOutgoingRoutes();
	
		-- Add resources
		if m_debugNumResourcesStrategic > 0 or m_debugNumResourcesLuxuries > 0 or m_debugNumBonuses > 0 then
			for debugRes=1,m_debugNumResourcesStrategic,1 do
				kResources[debugRes] = {
					CityList	= { CityName="Kangaroo", Amount=(10+debugRes) },
					Icon		= "[ICON_"..GameInfo.Resources[debugRes].ResourceType.."]",
					IsStrategic	= true,
					IsLuxury	= false,
					IsBonus		= false,
					Total		= 88
				};
			end
			for debugRes=1,m_debugNumResourcesLuxuries,1 do
				kResources[debugRes] = {
					CityList	= { CityName="Kangaroo", Amount=(10+debugRes) },
					Icon		= "[ICON_"..GameInfo.Resources[debugRes].ResourceType.."]",
					IsStrategic	= false,
					IsLuxury	= true,
					IsBonus		= false,
					Total		= 88
				};
			end
			for debugRes=1,m_debugNumBonuses,1 do
				kResources[debugRes] = {
					CityList	= { CityName="Kangaroo", Amount=(10+debugRes) },
					Icon		= "[ICON_"..GameInfo.Resources[debugRes].ResourceType.."]",
					IsStrategic	= false,
					IsLuxury	= false,
					IsBonus		= true,
					Total		= 88
				};
			end
		end

		for eResourceType,amount in pairs(data.Resources) do
			AddResourceData(kResources, eResourceType, cityName, "LOC_HUD_REPORTS_TRADE_OWNED", amount);
		end
	end

	local dist_maintenance = player:GetProperty('city_distance_maintenance');
	local num_maintenance = player:GetProperty('city_num_maintenance');
	if not dist_maintenance then dist_maintenance = 0; end
	if not num_maintenance then num_maintenance = 0; end

	kCityTotalData.Expenses[YieldTypes.GOLD] = pTreasury:GetTotalMaintenance();
	kCityTotalData.Expenses[YieldTypes.GOLD] = pTreasury:GetTotalMaintenance() + dist_maintenance + num_maintenance;

	-- NET = Income - Expense
	kCityTotalData.Net[YieldTypes.GOLD]			= kCityTotalData.Income[YieldTypes.GOLD] - kCityTotalData.Expenses[YieldTypes.GOLD];
	kCityTotalData.Net[YieldTypes.FAITH]		= kCityTotalData.Income[YieldTypes.FAITH];

	-- Treasury
	kCityTotalData.Treasury[YieldTypes.CULTURE]		= Round( pCulture:GetCultureYield(), 0 );
	kCityTotalData.Treasury[YieldTypes.FAITH]		= Round( pReligion:GetFaithBalance(), 0 );
	kCityTotalData.Treasury[YieldTypes.GOLD]		= Round( pTreasury:GetGoldBalance(), 0 );
	kCityTotalData.Treasury[YieldTypes.SCIENCE]		= Round( pScience:GetScienceYield(), 0 );
	kCityTotalData.Treasury["TOURISM"]				= Round( kCityTotalData.Income["TOURISM"], 0 );


	-- Units (TODO: Group units by promotion class and determine total maintenance cost)
	local MaintenanceDiscountPerUnit:number = pTreasury:GetMaintDiscountPerUnit();
	local pUnits :table = player:GetUnits(); 	
	for i, pUnit in pUnits:Members() do
		local pUnitInfo:table = GameInfo.Units[pUnit:GetUnitType()];
		local unitTypeKey = pUnitInfo.UnitType;
		local TotalMaintenanceAfterDiscount:number = 0;
		local unitMaintenance = 0;
		local unitName :string = Locale.Lookup(pUnitInfo.Name);
		local unitMilitaryFormation = pUnit:GetMilitaryFormation();
		unitTypeKey = unitTypeKey .. unitMilitaryFormation;
		if (pUnitInfo.Domain == "DOMAIN_SEA") then
			if (unitMilitaryFormation == MilitaryFormationTypes.CORPS_FORMATION) then
				unitName = unitName .. " " .. Locale.Lookup("LOC_HUD_UNIT_PANEL_FLEET_SUFFIX");
				unitMaintenance = UnitManager.GetUnitCorpsMaintenance(pUnitInfo.Hash);
			elseif (unitMilitaryFormation == MilitaryFormationTypes.ARMY_FORMATION) then
				unitName = unitName .. " " .. Locale.Lookup("LOC_HUD_UNIT_PANEL_ARMADA_SUFFIX");
				unitMaintenance = UnitManager.GetUnitArmyMaintenance(pUnitInfo.Hash);
			else
				unitMaintenance = UnitManager.GetUnitMaintenance(pUnitInfo.Hash);
			end
		else
			if (unitMilitaryFormation == MilitaryFormationTypes.CORPS_FORMATION) then
				unitName = unitName .. " " .. Locale.Lookup("LOC_HUD_UNIT_PANEL_CORPS_SUFFIX");
				unitMaintenance = UnitManager.GetUnitCorpsMaintenance(pUnitInfo.Hash);
			elseif (unitMilitaryFormation == MilitaryFormationTypes.ARMY_FORMATION) then
				unitName = unitName .. " " .. Locale.Lookup("LOC_HUD_UNIT_PANEL_ARMY_SUFFIX");
				unitMaintenance = UnitManager.GetUnitArmyMaintenance(pUnitInfo.Hash);
			else
				unitMaintenance = UnitManager.GetUnitMaintenance(pUnitInfo.Hash);
			end
		end

		if (unitMaintenance > 0) then
			TotalMaintenanceAfterDiscount = unitMaintenance - MaintenanceDiscountPerUnit; 
		end
		if TotalMaintenanceAfterDiscount > 0 then
			if kUnitData[unitTypeKey] == nil then
				local UnitEntry:table = {};
				UnitEntry.Name = unitName;
				UnitEntry.Count = 1;
				UnitEntry.Maintenance = TotalMaintenanceAfterDiscount;
				kUnitData[unitTypeKey]= UnitEntry;
			else
				kUnitData[unitTypeKey].Count = kUnitData[unitTypeKey].Count + 1;
				kUnitData[unitTypeKey].Maintenance = kUnitData[unitTypeKey].Maintenance + TotalMaintenanceAfterDiscount;
			end
		end
	end
	
	local kDealData	:table = {};
	local kPlayers	:table = PlayerManager.GetAliveMajors();
	for _, pOtherPlayer in ipairs(kPlayers) do
		local otherID:number = pOtherPlayer:GetID();
		local currentGameTurn = Game.GetCurrentGameTurn();
		if  otherID ~= playerID then			
			
			local pPlayerConfig	:table = PlayerConfigurations[otherID];
			local pDeals		:table = DealManager.GetPlayerDeals(playerID, otherID);
			
			if pDeals ~= nil then
				for i,pDeal in ipairs(pDeals) do
					-- Add outgoing gold deals
					local pOutgoingDeal :table	= pDeal:FindItemsByType(DealItemTypes.GOLD, DealItemSubTypes.NONE, playerID);
					if pOutgoingDeal ~= nil then
						for i,pDealItem in ipairs(pOutgoingDeal) do
							local duration		:number = pDealItem:GetDuration();
							local remainingTurns:number = duration - (currentGameTurn - pDealItem:GetEnactedTurn());
							if duration ~= 0 then
								local gold :number = pDealItem:GetAmount();
								table.insert( kDealData, {
									Type		= DealItemTypes.GOLD,
									Amount		= gold,
									Duration	= remainingTurns,
									IsOutgoing	= true,
									PlayerID	= otherID,
									Name		= Locale.Lookup( pPlayerConfig:GetCivilizationDescription() )
								});						
							end
						end
					end

					-- Add outgoing resource deals
					pOutgoingDeal = pDeal:FindItemsByType(DealItemTypes.RESOURCES, DealItemSubTypes.NONE, playerID);
					if pOutgoingDeal ~= nil then
						for i,pDealItem in ipairs(pOutgoingDeal) do
							local duration		:number = pDealItem:GetDuration();
							local remainingTurns:number = duration - (currentGameTurn - pDealItem:GetEnactedTurn());
							if duration ~= 0 then
								local amount		:number = pDealItem:GetAmount();
								local resourceType	:number = pDealItem:GetValueType();
								table.insert( kDealData, {
									Type			= DealItemTypes.RESOURCES,
									ResourceType	= resourceType,
									Amount			= amount,
									Duration		= remainingTurns,
									IsOutgoing		= true,
									PlayerID		= otherID,
									Name			= Locale.Lookup( pPlayerConfig:GetCivilizationDescription() )
								});
								
								local entryString:string = Locale.Lookup("LOC_HUD_REPORTS_ROW_DIPLOMATIC_DEALS") .. " (" .. Locale.Lookup(pPlayerConfig:GetPlayerName()) .. " " .. Locale.Lookup("LOC_REPORTS_NUMBER_OF_TURNS", remainingTurns) .. ")";
								AddResourceData(kResources, resourceType, entryString, "LOC_HUD_REPORTS_TRADE_EXPORTED", -1 * amount);				
							end
						end
					end
					
					-- Add incoming gold deals
					local pIncomingDeal :table = pDeal:FindItemsByType(DealItemTypes.GOLD, DealItemSubTypes.NONE, otherID);
					if pIncomingDeal ~= nil then
						for i,pDealItem in ipairs(pIncomingDeal) do
							local duration		:number = pDealItem:GetDuration();
							local remainingTurns:number = duration - (currentGameTurn - pDealItem:GetEnactedTurn());
							if duration ~= 0 then
								local gold :number = pDealItem:GetAmount()
								table.insert( kDealData, {
									Type		= DealItemTypes.GOLD;
									Amount		= gold,
									Duration	= remainingTurns,
									IsOutgoing	= false,
									PlayerID	= otherID,
									Name		= Locale.Lookup( pPlayerConfig:GetCivilizationDescription() )
								});						
							end
						end
					end

					-- Add incoming resource deals
					pIncomingDeal = pDeal:FindItemsByType(DealItemTypes.RESOURCES, DealItemSubTypes.NONE, otherID);
					if pIncomingDeal ~= nil then
						for i,pDealItem in ipairs(pIncomingDeal) do
							local duration		:number = pDealItem:GetDuration();
							if duration ~= 0 then
								local amount		:number = pDealItem:GetAmount();
								local resourceType	:number = pDealItem:GetValueType();
								local remainingTurns:number = duration - (currentGameTurn - pDealItem:GetEnactedTurn());
								table.insert( kDealData, {
									Type			= DealItemTypes.RESOURCES,
									ResourceType	= resourceType,
									Amount			= amount,
									Duration		= remainingTurns,
									IsOutgoing		= false,
									PlayerID		= otherID,
									Name			= Locale.Lookup( pPlayerConfig:GetCivilizationDescription() )
								});
								
								local entryString:string = Locale.Lookup("LOC_HUD_REPORTS_ROW_DIPLOMATIC_DEALS") .. " (" .. Locale.Lookup(pPlayerConfig:GetPlayerName()) .. " " .. Locale.Lookup("LOC_REPORTS_NUMBER_OF_TURNS", remainingTurns) .. ")";
								AddResourceData(kResources, resourceType, entryString, "LOC_HUD_REPORTS_TRADE_IMPORTED", amount);				
							end
						end
					end	
				end							
			end

		end
	end

	-- Add resources provided by city states
	for i, pMinorPlayer in ipairs(PlayerManager.GetAliveMinors()) do
		local pMinorPlayerInfluence:table = pMinorPlayer:GetInfluence();		
		if pMinorPlayerInfluence ~= nil then
			local suzerainID:number = pMinorPlayerInfluence:GetSuzerain();
			if suzerainID == playerID then
				for row in GameInfo.Resources() do
					local resourceAmount:number =  pMinorPlayer:GetResources():GetExportedResourceAmount(row.Index);
					if resourceAmount > 0 then
						local pMinorPlayerConfig:table = PlayerConfigurations[pMinorPlayer:GetID()];
						local entryString:string = Locale.Lookup("LOC_HUD_REPORTS_CITY_STATE") .. " (" .. Locale.Lookup(pMinorPlayerConfig:GetPlayerName()) .. ")";
						AddResourceData(kResources, row.Index, entryString, "LOC_CITY_STATES_SUZERAIN", resourceAmount);
					end
				end
			end
		end
	end

	kResources = AddMiscResourceData(pResources, kResources);

	return kCityData, kCityTotalData, kResources, kUnitData, kDealData;
end

function ViewYieldsPage()	

	m_CurrentReportTab = REPORT_PAGES.YIELDS;
	ResetTabForNewPageContent();

	local instance:table = nil;
	instance = NewCollapsibleGroupInstance();
	instance.RowHeaderButton:SetText( Locale.Lookup("LOC_HUD_REPORTS_ROW_CITY_INCOME") );
	
	local pHeaderInstance:table = {}
	ContextPtr:BuildInstanceForControl( "CityIncomeHeaderInstance", pHeaderInstance, instance.ContentStack ) ;	

	local goldCityTotal		:number = 0;
	local faithCityTotal	:number = 0;
	local scienceCityTotal	:number = 0;
	local cultureCityTotal	:number = 0;
	local tourismCityTotal	:number = 0;
	

	-- ========== City Income ==========

	function CreatLineItemInstance(cityInstance:table, name:string, production:number, gold:number, food:number, science:number, culture:number, faith:number)
		local lineInstance:table = {};
		ContextPtr:BuildInstanceForControl("CityIncomeLineItemInstance", lineInstance, cityInstance.LineItemStack );
		TruncateStringWithTooltipClean(lineInstance.LineItemName, 160, name);
		lineInstance.Production:SetText( toPlusMinusNoneString(production));
		lineInstance.Food:SetText( toPlusMinusNoneString(food));
		lineInstance.Gold:SetText( toPlusMinusNoneString(gold));
		lineInstance.Faith:SetText( toPlusMinusNoneString(faith));
		lineInstance.Science:SetText( toPlusMinusNoneString(science));
		lineInstance.Culture:SetText( toPlusMinusNoneString(culture));

		return lineInstance;
	end

	for i,kCityData in ipairs(m_kCityData) do
		local cityName :string = kCityData.CityName;
		local pCityInstance:table = {};
		ContextPtr:BuildInstanceForControl( "CityIncomeInstance", pCityInstance, instance.ContentStack ) ;
		pCityInstance.LineItemStack:DestroyAllChildren();
		TruncateStringWithTooltip(pCityInstance.CityName, 230, Locale.Lookup(kCityData.CityName)); 

		--Great works
		local greatWorks:table = GetGreatWorksForCity(kCityData.City);

		-- Current Production
		local kCurrentProduction:table = kCityData.ProductionQueue[1];
		pCityInstance.CurrentProduction:SetHide( kCurrentProduction == nil );
		if kCurrentProduction ~= nil then
			local tooltip:string = Locale.Lookup(kCurrentProduction.Name);
			if kCurrentProduction.Description ~= nil then
				tooltip = tooltip .. "[NEWLINE]" .. Locale.Lookup(kCurrentProduction.Description);
			end
			pCityInstance.CurrentProduction:SetToolTipString( tooltip )

			if kCurrentProduction.Icon then
				pCityInstance.CityBannerBackground:SetHide( false );
				pCityInstance.CurrentProduction:SetIcon( kCurrentProduction.Icon );
				pCityInstance.CityProductionMeter:SetPercent( kCurrentProduction.PercentComplete );
				pCityInstance.CityProductionNextTurn:SetPercent( kCurrentProduction.PercentCompleteNextTurn );			
				pCityInstance.ProductionBorder:SetHide( kCurrentProduction.Type == ProductionType.DISTRICT );
			else
				pCityInstance.CityBannerBackground:SetHide( true );
			end
		end

		pCityInstance.Production:SetText( toPlusMinusString(kCityData.ProductionPerTurn) );
		pCityInstance.Food:SetText( toPlusMinusString(kCityData.FoodPerTurn) );
		pCityInstance.Gold:SetText( toPlusMinusString(kCityData.GoldPerTurn) );
		pCityInstance.Faith:SetText( toPlusMinusString(kCityData.FaithPerTurn) );
		pCityInstance.Science:SetText( toPlusMinusString(kCityData.SciencePerTurn) );
		pCityInstance.Culture:SetText( toPlusMinusString(kCityData.CulturePerTurn) );
		pCityInstance.Tourism:SetText( toPlusMinusString(kCityData.WorkedTileYields["TOURISM"]) );

		-- Add to all cities totals
		goldCityTotal	= goldCityTotal + kCityData.GoldPerTurn;
		faithCityTotal	= faithCityTotal + kCityData.FaithPerTurn;
		scienceCityTotal= scienceCityTotal + kCityData.SciencePerTurn;
		cultureCityTotal= cultureCityTotal + kCityData.CulturePerTurn;
		tourismCityTotal= tourismCityTotal + kCityData.WorkedTileYields["TOURISM"];

		for i,kDistrict in ipairs(kCityData.BuildingsAndDistricts) do			
			--District line item
			local districtInstance = CreatLineItemInstance(	pCityInstance, 
															kDistrict.Name,
															kDistrict.Production,
															kDistrict.Gold,
															kDistrict.Food,
															kDistrict.Science,
															kDistrict.Culture,
															kDistrict.Faith);
			districtInstance.DistrictIcon:SetHide(false);
			districtInstance.DistrictIcon:SetIcon(kDistrict.Icon);

			function HasValidAdjacencyBonus(adjacencyTable:table)
				for _, yield in pairs(adjacencyTable) do
					if yield ~= 0 then
						return true;
					end
				end
				return false;
			end

			--Adjacency
			if HasValidAdjacencyBonus(kDistrict.AdjacencyBonus) then
				CreatLineItemInstance(	pCityInstance,
										INDENT_STRING .. Locale.Lookup("LOC_HUD_REPORTS_ADJACENCY_BONUS"),
										kDistrict.AdjacencyBonus.Production,
										kDistrict.AdjacencyBonus.Gold,
										kDistrict.AdjacencyBonus.Food,
										kDistrict.AdjacencyBonus.Science,
										kDistrict.AdjacencyBonus.Culture,
										kDistrict.AdjacencyBonus.Faith);
			end

			
			for i,kBuilding in ipairs(kDistrict.Buildings) do
				CreatLineItemInstance(	pCityInstance,
										INDENT_STRING ..  kBuilding.Name,
										kBuilding.ProductionPerTurn,
										kBuilding.GoldPerTurn,
										kBuilding.FoodPerTurn,
										kBuilding.SciencePerTurn,
										kBuilding.CulturePerTurn,
										kBuilding.FaithPerTurn);

				--Add great works
				if greatWorks[kBuilding.Type] ~= nil then
					--Add our line items!
					for _, kGreatWork in ipairs(greatWorks[kBuilding.Type]) do
						local pLineItemInstance = CreatLineItemInstance(	pCityInstance, INDENT_STRING .. INDENT_STRING ..  Locale.Lookup(kGreatWork.Name), 0, 0, 0,	0, 0, 0);
						for _, yield in ipairs(kGreatWork.YieldChanges) do
							if (yield.YieldType == "YIELD_FOOD") then
								pLineItemInstance.Food:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_PRODUCTION") then
								pLineItemInstance.Production:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_GOLD") then
								pLineItemInstance.Gold:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_SCIENCE") then
								pLineItemInstance.Science:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_CULTURE") then
								pLineItemInstance.Culture:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_FAITH") then
								pLineItemInstance.Faith:SetText( toPlusMinusNoneString(yield.YieldChange) );
							end
						end
					end
				end

			end
		end

		-- Display wonder yields
		if kCityData.Wonders then
			for _, wonder in ipairs(kCityData.Wonders) do
				if wonder.Yields[1] ~= nil or greatWorks[wonder.Type] ~= nil then
				-- Assign yields to the line item
					local pLineItemInstance:table = CreatLineItemInstance(pCityInstance, wonder.Name, 0, 0, 0, 0, 0, 0);
					for _, yield in ipairs(wonder.Yields) do
						if (yield.YieldType == "YIELD_FOOD") then
							pLineItemInstance.Food:SetText( toPlusMinusNoneString(yield.YieldChange) );
						elseif (yield.YieldType == "YIELD_PRODUCTION") then
							pLineItemInstance.Production:SetText( toPlusMinusNoneString(yield.YieldChange) );
						elseif (yield.YieldType == "YIELD_GOLD") then
							pLineItemInstance.Gold:SetText( toPlusMinusNoneString(yield.YieldChange) );
						elseif (yield.YieldType == "YIELD_SCIENCE") then
							pLineItemInstance.Science:SetText( toPlusMinusNoneString(yield.YieldChange) );
						elseif (yield.YieldType == "YIELD_CULTURE") then
							pLineItemInstance.Culture:SetText( toPlusMinusNoneString(yield.YieldChange) );
						elseif (yield.YieldType == "YIELD_FAITH") then
							pLineItemInstance.Faith:SetText( toPlusMinusNoneString(yield.YieldChange) );
						end
					end
				end

				--Add great works
				if greatWorks[wonder.Type] ~= nil then
					--Add our line items!
					for _, kGreatWork in ipairs(greatWorks[wonder.Type]) do
						local pLineItemInstance = CreatLineItemInstance(	pCityInstance, INDENT_STRING ..  Locale.Lookup(kGreatWork.Name), 0, 0, 0,	0, 0, 0);
						for _, yield in ipairs(kGreatWork.YieldChanges) do
							if (yield.YieldType == "YIELD_FOOD") then
								pLineItemInstance.Food:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_PRODUCTION") then
								pLineItemInstance.Production:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_GOLD") then
								pLineItemInstance.Gold:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_SCIENCE") then
								pLineItemInstance.Science:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_CULTURE") then
								pLineItemInstance.Culture:SetText( toPlusMinusNoneString(yield.YieldChange) );
							elseif (yield.YieldType == "YIELD_FAITH") then
								pLineItemInstance.Faith:SetText( toPlusMinusNoneString(yield.YieldChange) );
							end
						end
					end
				end
			end
		end

		-- Display route yields
		if kCityData.OutgoingRoutes then
			for i,route in ipairs(kCityData.OutgoingRoutes) do
				if route ~= nil then
					if route.OriginYields then
						-- Find destination city
						local pDestPlayer:table = Players[route.DestinationCityPlayer];
						local pDestPlayerCities:table = pDestPlayer:GetCities();
						local pDestCity:table = pDestPlayerCities:FindID(route.DestinationCityID);

						--Assign yields to the line item
						local pLineItemInstance:table = CreatLineItemInstance(pCityInstance, Locale.Lookup("LOC_HUD_REPORTS_TRADE_WITH", Locale.Lookup(pDestCity:GetName())), 0, 0, 0, 0, 0, 0);
						for j,yield in ipairs(route.OriginYields) do
							local yieldInfo = GameInfo.Yields[yield.YieldIndex];
							if yieldInfo then
								if (yieldInfo.YieldType == "YIELD_FOOD") then
									pLineItemInstance.Food:SetText( toPlusMinusNoneString(yield.Amount) );
								elseif (yieldInfo.YieldType == "YIELD_PRODUCTION") then
									pLineItemInstance.Production:SetText( toPlusMinusNoneString(yield.Amount) );
								elseif (yieldInfo.YieldType == "YIELD_GOLD") then
									pLineItemInstance.Gold:SetText( toPlusMinusNoneString(yield.Amount) );
								elseif (yieldInfo.YieldType == "YIELD_SCIENCE") then
									pLineItemInstance.Science:SetText( toPlusMinusNoneString(yield.Amount) );
								elseif (yieldInfo.YieldType == "YIELD_CULTURE") then
									pLineItemInstance.Culture:SetText( toPlusMinusNoneString(yield.Amount) );
								elseif (yieldInfo.YieldType == "YIELD_FAITH") then
									pLineItemInstance.Faith:SetText( toPlusMinusNoneString(yield.Amount) );
								end
							end
						end
					end
				end
			end
		end

		--Worked Tiles
		CreatLineItemInstance(	pCityInstance,
								Locale.Lookup("LOC_HUD_REPORTS_WORKED_TILES"),
								kCityData.WorkedTileYields["YIELD_PRODUCTION"],
								kCityData.WorkedTileYields["YIELD_GOLD"],
								kCityData.WorkedTileYields["YIELD_FOOD"],
								kCityData.WorkedTileYields["YIELD_SCIENCE"],
								kCityData.WorkedTileYields["YIELD_CULTURE"],
								kCityData.WorkedTileYields["YIELD_FAITH"]);

		if kCityData.City:GetGrowth() ~= nil then
			if kCityData.City:GetGrowth():GetHappiness() ~= 4 then	-- 4 is "content" happiness status; there is no amenities yield then
				local iYieldPercent = (Round(1 + (kCityData.HappinessNonFoodYieldModifier/100), 2)*.1);
				CreatLineItemInstance(	pCityInstance,
										Locale.Lookup("LOC_HUD_REPORTS_HEADER_AMENITIES"),
										kCityData.WorkedTileYields["YIELD_PRODUCTION"] * iYieldPercent,
										kCityData.WorkedTileYields["YIELD_GOLD"] * iYieldPercent,
										0,
										kCityData.WorkedTileYields["YIELD_SCIENCE"] * iYieldPercent,
										kCityData.WorkedTileYields["YIELD_CULTURE"] * iYieldPercent,
										kCityData.WorkedTileYields["YIELD_FAITH"] * iYieldPercent);
			end
		end

		local populationToCultureScale:number = GameInfo.GlobalParameters["CULTURE_PERCENTAGE_YIELD_PER_POP"].Value / 100;
		CreatLineItemInstance(	pCityInstance,
								Locale.Lookup("LOC_HUD_CITY_POPULATION"),
								0,
								0,
								0,
								0,
								kCityData["Population"] * populationToCultureScale, 
								0);

		pCityInstance.LineItemStack:CalculateSize();
		pCityInstance.Darken:SetSizeY( pCityInstance.LineItemStack:GetSizeY() + DARKEN_CITY_INCOME_AREA_ADDITIONAL_Y );
	end

	local pFooterInstance:table = {};
	ContextPtr:BuildInstanceForControl("CityIncomeFooterInstance", pFooterInstance, instance.ContentStack  );
	pFooterInstance.Gold:SetText( "[Icon_GOLD]"..toPlusMinusString(goldCityTotal) );
	pFooterInstance.Faith:SetText( "[Icon_FAITH]"..toPlusMinusString(faithCityTotal) );
	pFooterInstance.Science:SetText( "[Icon_SCIENCE]"..toPlusMinusString(scienceCityTotal) );
	pFooterInstance.Culture:SetText( "[Icon_CULTURE]"..toPlusMinusString(cultureCityTotal) );
	pFooterInstance.Tourism:SetText( "[Icon_TOURISM]"..toPlusMinusString(tourismCityTotal) );

	SetGroupCollapsePadding(instance, pFooterInstance.Top:GetSizeY() );
	RealizeGroup( instance );


	-- ========== Building Expenses ==========

	instance = NewCollapsibleGroupInstance();
	instance.RowHeaderButton:SetText( Locale.Lookup("LOC_HUD_REPORTS_ROW_BUILDING_EXPENSES") );

	local pHeader:table = {};
	ContextPtr:BuildInstanceForControl( "BuildingExpensesHeaderInstance", pHeader, instance.ContentStack ) ;

	local iTotalBuildingMaintenance :number = 0;

	local num_cities = #m_kCityData;
	if debug_print then print(num_cities); end

	local dist_maintenance = Players[Game.GetLocalPlayer()]:GetProperty('city_distance_maintenance');
	local num_maintenance = Players[Game.GetLocalPlayer()]:GetProperty('city_num_maintenance');
	if debug_print then print(dist_maintenance); end
	if debug_print then print(num_maintenance); end
	if not dist_maintenance then dist_maintenance = 0; end
	if not num_maintenance then num_maintenance = 0; end

	for i,kCityData in ipairs(m_kCityData) do
		local dist_mult = kCityData.City:GetProperty('distance_mult');
		local num_mult = kCityData.City:GetProperty('city_mult');
		local distance = kCityData.City:GetProperty('distance');
		if not dist_mult then dist_mult = 100; end;
		if not num_mult then num_mult = 100; end;
		if not distance then distance = 0; end;
		if debug_print then print(dist_mult); end
		if debug_print then print(num_mult); end
		if debug_print then print(distance); end
		if debug_print then print('city_tax:'); end
		local city_tax = ((distance * dist_mult) + (num_cities * num_mult)) / 100;
		if debug_print then print(city_tax); end
		local cityName :string = kCityData.CityName;
		for _,kBuilding in ipairs(kCityData.Buildings) do
			if (kBuilding.Maintenance > 0 and kBuilding.isPillaged == false) then
				local pBuildingInstance:table = {};		
				ContextPtr:BuildInstanceForControl( "BuildingExpensesEntryInstance", pBuildingInstance, instance.ContentStack ) ;		
				TruncateStringWithTooltip(pBuildingInstance.CityName, 224, Locale.Lookup(cityName)); 
				pBuildingInstance.BuildingName:SetText( Locale.Lookup(kBuilding.Name) );
				pBuildingInstance.Gold:SetText( "-"..tostring(kBuilding.Maintenance));
				iTotalBuildingMaintenance = iTotalBuildingMaintenance - kBuilding.Maintenance;
			end
		end
		for _,kDistrict in ipairs(kCityData.BuildingsAndDistricts) do
			if (kDistrict.Maintenance > 0 and kDistrict.isPillaged == false and kDistrict.isBuilt == true) then
				local pDistrictInstance:table = {};		
				ContextPtr:BuildInstanceForControl( "BuildingExpensesEntryInstance", pDistrictInstance, instance.ContentStack ) ;		
				TruncateStringWithTooltip(pDistrictInstance.CityName, 224, Locale.Lookup(cityName)); 
				pDistrictInstance.BuildingName:SetText( Locale.Lookup(kDistrict.Name) );
				pDistrictInstance.Gold:SetText( "-"..tostring(kDistrict.Maintenance));
				iTotalBuildingMaintenance = iTotalBuildingMaintenance - kDistrict.Maintenance;
			end
			if (kDistrict.Type == 'DISTRICT_CITY_CENTER' and kDistrict.isPillaged == false and kDistrict.isBuilt == true) then
				local pDistrictInstance:table = {};
				ContextPtr:BuildInstanceForControl( "BuildingExpensesEntryInstance", pDistrictInstance, instance.ContentStack ) ;
				TruncateStringWithTooltip(pDistrictInstance.CityName, 224, Locale.Lookup(cityName));
				pDistrictInstance.BuildingName:SetText( Locale.Lookup(kDistrict.Name) );
				pDistrictInstance.Gold:SetText( "-"..tostring(city_tax));
				iTotalBuildingMaintenance = iTotalBuildingMaintenance - city_tax;
			end
		end
	end
	local pBuildingFooterInstance:table = {};		
	ContextPtr:BuildInstanceForControl( "GoldFooterInstance", pBuildingFooterInstance, instance.ContentStack ) ;		
	pBuildingFooterInstance.Gold:SetText("[ICON_Gold]"..tostring(iTotalBuildingMaintenance) );

	SetGroupCollapsePadding(instance, pBuildingFooterInstance.Top:GetSizeY() );
	RealizeGroup( instance );

	-- ========== Unit Expenses ==========

	if GameCapabilities.HasCapability("CAPABILITY_REPORTS_UNIT_EXPENSES") then 
		instance = NewCollapsibleGroupInstance();
		instance.RowHeaderButton:SetText( Locale.Lookup("LOC_HUD_REPORTS_ROW_UNIT_EXPENSES") );

		-- Header
		local pHeader:table = {};
		ContextPtr:BuildInstanceForControl( "UnitExpensesHeaderInstance", pHeader, instance.ContentStack ) ;

		-- Units
		local iTotalUnitMaintenance:number = 0;
		for UnitType,kUnitData in pairs(m_kUnitData) do
			local pUnitInstance:table = {};
			ContextPtr:BuildInstanceForControl( "UnitExpensesEntryInstance", pUnitInstance, instance.ContentStack );
			pUnitInstance.UnitName:SetText(Locale.Lookup( kUnitData.Name ));
			pUnitInstance.UnitCount:SetText(kUnitData.Count);
			pUnitInstance.Gold:SetText("-" .. kUnitData.Maintenance);
			iTotalUnitMaintenance = iTotalUnitMaintenance + kUnitData.Maintenance;
		end

		-- Footer
		local pUnitFooterInstance:table = {};		
		ContextPtr:BuildInstanceForControl( "GoldFooterInstance", pUnitFooterInstance, instance.ContentStack ) ;		
		pUnitFooterInstance.Gold:SetText("[ICON_Gold]-"..tostring(iTotalUnitMaintenance) );

		SetGroupCollapsePadding(instance, pUnitFooterInstance.Top:GetSizeY() );
		RealizeGroup( instance );
	end

	-- ========== Diplomatic Deals Expenses ==========
	
	if GameCapabilities.HasCapability("CAPABILITY_REPORTS_DIPLOMATIC_DEALS") then 
		instance = NewCollapsibleGroupInstance();	
		instance.RowHeaderButton:SetText( Locale.Lookup("LOC_HUD_REPORTS_ROW_DIPLOMATIC_DEALS") );

		local pHeader:table = {};
		ContextPtr:BuildInstanceForControl( "DealHeaderInstance", pHeader, instance.ContentStack ) ;

		local iTotalDealGold :number = 0;
		for i,kDeal in ipairs(m_kDealData) do
			if kDeal.Type == DealItemTypes.GOLD then
				local pDealInstance:table = {};		
				ContextPtr:BuildInstanceForControl( "DealEntryInstance", pDealInstance, instance.ContentStack ) ;		

				pDealInstance.Civilization:SetText( kDeal.Name );
				pDealInstance.Duration:SetText( kDeal.Duration );
				if kDeal.IsOutgoing then
					pDealInstance.Gold:SetText( "-"..tostring(kDeal.Amount) );
					iTotalDealGold = iTotalDealGold - kDeal.Amount;
				else
					pDealInstance.Gold:SetText( "+"..tostring(kDeal.Amount) );
					iTotalDealGold = iTotalDealGold + kDeal.Amount;
				end
			end
		end
		local pDealFooterInstance:table = {};		
		ContextPtr:BuildInstanceForControl( "GoldFooterInstance", pDealFooterInstance, instance.ContentStack ) ;		
		pDealFooterInstance.Gold:SetText("[ICON_Gold]"..tostring(iTotalDealGold) );

		SetGroupCollapsePadding(instance, pDealFooterInstance.Top:GetSizeY() );
		RealizeGroup( instance );
	end


	-- ========== TOTALS ==========

	Controls.Stack:CalculateSize();
	Controls.Scroll:CalculateSize();

	-- Totals at the bottom [Definitive values]
	local localPlayer = Players[Game.GetLocalPlayer()];
	--Gold
	local playerTreasury:table	= localPlayer:GetTreasury();
	Controls.GoldIncome:SetText( toPlusMinusNoneString( playerTreasury:GetGoldYield() ));
	Controls.GoldExpense:SetText( toPlusMinusNoneString( -playerTreasury:GetTotalMaintenance() -  dist_maintenance - num_maintenance));	-- Flip that value!
	Controls.GoldNet:SetText( toPlusMinusNoneString( playerTreasury:GetGoldYield() - playerTreasury:GetTotalMaintenance() - dist_maintenance - num_maintenance));
	Controls.GoldBalance:SetText( m_kCityTotalData.Treasury[YieldTypes.GOLD] );

	
	--Faith
	local playerReligion:table	= localPlayer:GetReligion();
	Controls.FaithIncome:SetText( toPlusMinusNoneString(playerReligion:GetFaithYield()));
	Controls.FaithNet:SetText( toPlusMinusNoneString(playerReligion:GetFaithYield()));
	Controls.FaithBalance:SetText( m_kCityTotalData.Treasury[YieldTypes.FAITH] );

	--Science
	local playerTechnology:table	= localPlayer:GetTechs();
	Controls.ScienceIncome:SetText( toPlusMinusNoneString(playerTechnology:GetScienceYield()));
	Controls.ScienceBalance:SetText( m_kCityTotalData.Treasury[YieldTypes.SCIENCE] );
	
	--Culture
	local playerCulture:table	= localPlayer:GetCulture();
	Controls.CultureIncome:SetText(toPlusMinusNoneString(playerCulture:GetCultureYield()));
	Controls.CultureBalance:SetText(m_kCityTotalData.Treasury[YieldTypes.CULTURE] );
	
	--Tourism. We don't talk about this one much.
	Controls.TourismIncome:SetText( toPlusMinusNoneString( m_kCityTotalData.Income["TOURISM"] ));	
	Controls.TourismBalance:SetText( m_kCityTotalData.Treasury["TOURISM"] );
	
	Controls.CollapseAll:SetHide(false);
	Controls.BottomYieldTotals:SetHide( false );
	Controls.BottomYieldTotals:SetSizeY( SIZE_HEIGHT_BOTTOM_YIELDS );
	Controls.BottomResourceTotals:SetHide( true );
	Controls.Scroll:SetSizeY( Controls.Main:GetSizeY() - (Controls.BottomYieldTotals:GetSizeY() + SIZE_HEIGHT_PADDING_BOTTOM_ADJUST ) );	
end
