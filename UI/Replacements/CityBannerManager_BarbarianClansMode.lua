-- Copyright 2020, Firaxis Games
-- edited by Slothoth as the bloody banner wont disappear on city founding
-- ===========================================================================
-- CACHE BASE FUNCTIONS
-- ===========================================================================
include("GameCapabilities");

local BASE_Initialize = Initialize;
local BASE_OnImprovementAddedToMap = OnImprovementAddedToMap;
local BASE_OnImprovementRemovedFromMap = OnImprovementRemovedFromMap;
local BASE_OnImprovementVisibilityChanged = OnImprovementVisibilityChanged;
local BASE_OnRefreshBannerPositions = OnRefreshBannerPositions;
local BASE_CBInitialize = CityBanner.Initialize
print('SLoth Civ banner manager for barb tribes loaded')

-- ===========================================================================
-- CONSTANTS
-- ===========================================================================
local BARBARIAN_CAMP_IMPROVEMENT_INDEX  = GameInfo.Improvements["IMPROVEMENT_BARBARIAN_CAMP"].Index;

local PLOT_HIDDEN						= 0;
local PLOT_REVEALED						= 1;

local YOFFSET_2DVIEW				 = 26;
local ZOFFSET_3DVIEW				 = 36;


-- ===========================================================================
-- LOCALS
-- ===========================================================================
local m_BarbarianTribeBanners  = {};
local m_BarbarianTribeBannerIM  = InstanceManager:new( "TribeBanner", "Anchor", Controls.CityBanners );

local m_iActivePlayer = Game.GetLocalPlayer();
local pConfig = PlayerConfigurations[m_iActivePlayer]
local m_sCivName = pConfig:GetCivilizationTypeName()
-- ===========================================================================
function CreateBarbarianTribeBanner(pPlot , pBarbTribe )
	local uiTribeBanner  = m_BarbarianTribeBannerIM:GetInstance();

	uiTribeBanner.TribeIcon:SetIcon("ICON_" .. pBarbTribe.TribeNameType);
	uiTribeBanner.TribeIcon:LocalizeAndSetToolTip(pBarbTribe.TribeDisplayName);
	local sTribeType = pBarbTribe.TribeType
	local iActivePlayer = Game.GetLocalPlayer();
	local pPlayerConfig = PlayerConfigurations[iActivePlayer]
	if not pPlayerConfig then return end;				-- just done for doing autoplay
    local sCivName = pPlayerConfig:GetCivilizationTypeName()
	if sCivName == 'SLTH_CIVILIZATION_CLAN_OF_EMBERS' then
		if sTribeType == 'TRIBE_CLAN_MELEE_OPEN' or sTribeType == 'TRIBE_CLAN_MELEE_FOREST' then				-- ruins or goblin fort
			uiTribeBanner.TribeBannerButton:RegisterCallback( Mouse.eLClick, function() OnTribeBannerButtonClicked(pPlot:GetIndex()); end );
		end
	end

	local backColor , _ = UI.GetPlayerColors( PlayerTypes.BARBARIAN );
	uiTribeBanner.Banner_Base:SetColor(backColor);

	if(iActivePlayer == -1) then
		-- No local player.
		return;
	end

	local tribeBannerEntry  = 
	{	
		Plot = pPlot;
		BarbarianTribe = pBarbTribe;
		BannerInstance = uiTribeBanner;
		X = pPlot:GetX();
		Y = pPlot:GetY();
		Index = pPlot:GetIndex();
	}

	table.insert(m_BarbarianTribeBanners, tribeBannerEntry)
	UpdateTribeBannerConversionBar(tribeBannerEntry);
	UpdateTribeBannerPositioning(pPlot, tribeBannerEntry.BannerInstance);

	local pLocalPlayerVis  = PlayersVisibility[iActivePlayer];
	local plotVisibility  = pLocalPlayerVis:GetState(pPlot:GetX(), pPlot:GetY());
	UpdateTribeBannerVisibility(tribeBannerEntry, plotVisibility);
end

-- ===========================================================================
function UpdateTribeBannerConversionBar(barbarianTribeEntry )
	local pBarbarianManager  = Game.GetBarbarianManager();
	local tribeIndex  = pBarbarianManager:GetTribeIndexAtLocation(barbarianTribeEntry.Plot:GetX(),barbarianTribeEntry.Plot:GetY());
	local iCurrentPoints  = pBarbarianManager:GetTribeConversionPoints(tribeIndex);

	-- If pts negative, tribe is unable to convert: hide bar
	if (iCurrentPoints < 0) then
		barbarianTribeEntry.BannerInstance.ConversionBar:SetHide(true);
		barbarianTribeEntry.BannerInstance.ConversionBar:SetToolTipString("");
		barbarianTribeEntry.BannerInstance.ConversionBarBG:SetToolTipString(Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_DISABLED"));
		return;
	else
		barbarianTribeEntry.BannerInstance.ConversionBar:SetHide(false);
		barbarianTribeEntry.BannerInstance.ConversionBarBG:SetToolTipString("");
	end

	if(not barbarianTribeEntry.BannerInstance.ConversionBar:IsHidden())then
		local conversionPercent  = pBarbarianManager:GetTribeConversionPercent(tribeIndex);
		if(conversionPercent > 100)then conversionPercent = 100; end
		barbarianTribeEntry.BannerInstance.ConversionBar:SetPercent(conversionPercent/100);

		-- Conversion tip given only in chunky increments as a hint
		local iPointsToConvert  = pBarbarianManager:GetTribeConversionPointsRequired(tribeIndex);
		local iPointsRemaining = iPointsToConvert - iCurrentPoints;

		local strConversionTip  = "";
		if (iPointsRemaining >= 50) then
			strConversionTip = Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_TURNS", 50);
		elseif (iPointsRemaining >= 20) then
			strConversionTip = Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_TURNS", 20);
		elseif (iPointsRemaining >= 10) then
			strConversionTip = Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_TURNS", 10);
		else
			strConversionTip = Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_IMMINENT");
		end
		barbarianTribeEntry.BannerInstance.ConversionBar:SetToolTipString(strConversionTip);
	end
end

-- ===========================================================================
function UpdateTribeBannerPositioning(pPlot , uiBannerInstance )
	local yOffset  = 0;	--offset for 2D strategic view
	local zOffset  = 0;	--offset for 3D world view
	
	if (UI.GetWorldRenderView() == WorldRenderView.VIEW_2D) then
		yOffset = YOFFSET_2DVIEW;
	else
		zOffset = ZOFFSET_3DVIEW;
	end
	
	local worldX;
	local worldY;
	local worldZ;

	worldX, worldY, worldZ = UI.GridToWorld( pPlot:GetX(), pPlot:GetY() );
	uiBannerInstance.Anchor:SetWorldPositionVal( worldX, worldY+yOffset, worldZ + zOffset );
end

local iGamePlayer = Game.GetLocalPlayer()

-- ===========================================================================
local tClanTribes = {TRIBE_CLAN_MELEE_OPEN=true, TRIBE_CLAN_MELEE_FOREST=true}
function UpdateTribeBannerVisibility(tribeBannerEntry , eVisibility )
	--Banner can be interacted with as long as plot is not hidden
	if(eVisibility == PLOT_HIDDEN)then
		tribeBannerEntry.BannerInstance.Anchor:SetHide(true);
		tribeBannerEntry.BannerInstance.TribeBannerButton:LocalizeAndSetToolTip("");
		tribeBannerEntry.BannerInstance.TribeBannerButton:SetDisabled(true);
	else
		tribeBannerEntry.BannerInstance.Anchor:SetHide(false);
		tribeBannerEntry.BannerInstance.TribeBannerButton:SetDisabled(false);
	end
	if m_sCivName == 'SLTH_CIVILIZATION_CLAN_OF_EMBERS' and tClanTribes[tribeBannerEntry.BarbarianTribe.TribeType] then
		tribeBannerEntry.BannerInstance.TribeBannerButton:LocalizeAndSetToolTip("LOC_TRIBE_BANNER_TREAT_WITH_TRIBE_TT", tribeBannerEntry.BarbarianTribe.TribeDisplayName);
	else
		tribeBannerEntry.BannerInstance.TribeBannerButton:LocalizeAndSetToolTip("LOC_SLTH_TRIBE_BANNER_NAME", tribeBannerEntry.BarbarianTribe.TribeDisplayName);
	end
end

-- ===========================================================================
function OnTribeBannerButtonClicked(plotIndex )
	LuaEvents.CityBannerManager_OpenTreatWithTribePopup(plotIndex);
end

-- ===========================================================================
function OnRefreshBannerPositions()
	BASE_OnRefreshBannerPositions()
	for k, v in ipairs(m_BarbarianTribeBanners) do
		UpdateTribeBannerPositioning(v.Plot, v.BannerInstance);
	end
end

-- ===========================================================================
function OnImprovementAddedToMap(locX , locY , eImprovementType , eOwner )
	BASE_OnImprovementAddedToMap(locX, locY, eImprovementType, eOwner);

	if(eImprovementType ~= BARBARIAN_CAMP_IMPROVEMENT_INDEX)then return; end

	local pBarbarianManager  = Game.GetBarbarianManager();

	local tribeIndex  = pBarbarianManager:GetTribeIndexAtLocation(locX,locY);
	if (tribeIndex >= 0) then
		local barbType  = pBarbarianManager:GetTribeNameType(tribeIndex);
		local pBarbTribe  = GameInfo.BarbarianTribeNames[barbType];
		if(pBarbTribe ~= nil)then
			local pPlot  = Map.GetPlot(locX, locY);
			CreateBarbarianTribeBanner(pPlot, pBarbTribe);
		end
	end
end

-- ===========================================================================
local iIMPROVEMENT_BARB_CAMP = GameInfo.Improvements['IMPROVEMENT_BARBARIAN_CAMP'].Index
function OnImprovementRemovedFromMap( locX , locY , eOwner  )
	BASE_OnImprovementRemovedFromMap(locX, locY, eOwner);
	if(eOwner == PlayerTypes.BARBARIAN)then
		local pPlot = Map.GetPlot(locX, locY);
		for k,v in ipairs(m_BarbarianTribeBanners) do
			if(pPlot == v.Plot)then
				m_BarbarianTribeBannerIM:ReleaseInstance(v.BannerInstance);
				table.remove(m_BarbarianTribeBanners, k);
			end
		end
	end
end

-- ===========================================================================
function OnImprovementVisibilityChanged( locX , locY , eImprovementType , eVisibility  )
	if ( eImprovementType == BARBARIAN_CAMP_IMPROVEMENT_INDEX ) then
		local pPlot  = Map.GetPlot(locX, locY);
		for k, v in ipairs(m_BarbarianTribeBanners) do
			if(v.Plot == pPlot)then
				UpdateTribeBannerVisibility(v, eVisibility);
				return;
			end
		end
	end
	BASE_OnImprovementVisibilityChanged(locX, locY, eImprovementType, eVisibility);
end

-- ===========================================================================
function OnBarbarianClanConversionEnabled(tribeIndex , locX , locY )
	local pPlot  = Map.GetPlot(locX, locY);
	for k, v in ipairs(m_BarbarianTribeBanners)do
		if(v.Plot == pPlot)then
			v.BannerInstance.ConversionBar:SetHide(false);
		end
	end
end

-- ===========================================================================
function OnBarbarianClanConversionDisabled(tribeIndex , locX , locY )
	local pPlot  = Map.GetPlot(locX, locY);
	for k, v in ipairs(m_BarbarianTribeBanners)do
		if(v.Plot == pPlot)then
			v.BannerInstance.ConversionBar:SetHide(true);
		end
	end
end

-- ===========================================================================
function OnPlayerOperationComplete(playerID , operation )
	--Update encampment banners to show new conversion progress
	if(operation == PlayerOperations.BRIBE_CLAN or operation == PlayerOperations.INCITE_CLAN or operation == PlayerOperations.HIRE_CLAN or operation == PlayerOperations.RANSOM_CLAN)then
		for k,v in ipairs(m_BarbarianTribeBanners) do
			UpdateTribeBannerConversionBar(v);
		end
	end
end

-- ===========================================================================
function OnUnitCommandStarted(playerID , unitID , hCommand , iData1)
	--Update encampment banners to show new conversion progress
	if (hCommand == UnitCommandTypes.RAID_CLAN) then
		for k,v in ipairs(m_BarbarianTribeBanners) do
			UpdateTribeBannerConversionBar(v);
		end
	end
end

-- ===========================================================================
function CityBanner:Initialize( playerID, cityID , districtID , bannerType , bannerStyle )
	-- Colors are normally assigned during game loading/startup and cached.
	-- Adding a new city during gameplay requires invalidating and rebuilding that cache.
	-- This was also a problem with WorldBuilder Advanced Mode so these exposures already existed.
	UI.RefreshColorSet();
	UI.RebuildColorDB();

	local borderOverlay = UILens.GetOverlay("CultureBorders");
	if borderOverlay ~= nil then
		local backColor , frontColor  = UI.GetPlayerColors(playerID);
		borderOverlay:SetBorderColors(playerID, backColor, frontColor);
	end

	BASE_CBInitialize(self, playerID, cityID, districtID, bannerType, bannerStyle);
end

-- ===========================================================================
function OnLocalPlayerTurnBegin()
	for k,v in ipairs(m_BarbarianTribeBanners) do
		UpdateTribeBannerConversionBar(v);
	end
end

-- ===========================================================================
function OnPlayerChangeClosed()
	local pLocalPlayerVis  = PlayersVisibility[Game.GetLocalPlayer()];
	if(pLocalPlayerVis ~= nil)then
		for k, barbarianTribeEntry in ipairs(m_BarbarianTribeBanners) do
			local plotVisibility  = pLocalPlayerVis:GetState(barbarianTribeEntry.Plot:GetX(), barbarianTribeEntry.Plot:GetY())
			UpdateTribeBannerVisibility(barbarianTribeEntry, plotVisibility);
		end
	end
end

function InfernalCheck(playerID)
	local playerConfig = PlayerConfigurations[playerID]
	local civName = playerConfig:GetCivilizationTypeName()
	if civName == 'SLTH_CIVILIZATION_INFERNAL' then
		local isOffMap
		for i, j in Players[playerID]:GetUnits():Members() do
			isOffMap = j:GetX() == -9999
		end
		if isOffMap then
			return false
		end
	end
	return true
end

function PermaBribeBarbarianTrait(playerID)
	local iBribeCost
	local iBribeDuration = 20
	local iCurrentTurn = Game.GetCurrentGameTurn()
	local iBribeTurn = iBribeDuration and math.floor(((iCurrentTurn - 1) / iBribeDuration)) == ((iCurrentTurn - 1) / iBribeDuration)			-- even division
	if iCurrentTurn == 1 or iBribeTurn then
		local tGrantGoldParameters = {iYieldIndex=2, iYieldAmount=10, OnStart='SlthOnGrantYield'}
		if HasTrait("SLTH_TRAIT_BARBARIAN", playerID) and InfernalCheck(playerID) then					-- in future we want to gate this behind not being ahead in tech
			for k,barbarianTribeEntry in ipairs(m_BarbarianTribeBanners) do
				local sTribe = barbarianTribeEntry.BarbarianTribe.TribeType
				if barbarianTribeEntry.Index and (sTribe == 'TRIBE_CLAN_MELEE_OPEN' or sTribe == 'TRIBE_CLAN_MELEE_FOREST') then
					local tParameters = {[PlayerOperations.PARAM_PLOT_ONE] = barbarianTribeEntry.Index}
					local bCanStartBribe, tBribeResults = UI.CanStartPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.BRIBE_CLAN, tParameters, false)
					if not bCanStartBribe and tBribeResults and tBribeResults[PlayerOperationResults.FAILURE_REASONS] and tBribeResults[PlayerOperationResults.FAILURE_REASONS][1] == 'Not enough [ICON_Gold] Gold.' then
						if not iBribeCost then
							local v = tBribeResults[PlayerOperationResults.ADDITIONAL_DESCRIPTION][1]
							print('description check for player', playerID , v)
							local regexed = v:match("Spend%s+(.-)%s+%[ICON")
							local comma_subbed = regexed:gsub(",", "")
							iBribeCost = tonumber(comma_subbed)
							print('end increase is', iBribeCost)
							tGrantGoldParameters.iYieldAmount = iBribeCost
						end
						UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, tGrantGoldParameters)
						UI.RequestPlayerOperation(playerID, PlayerOperations.BRIBE_CLAN, tParameters);
					end
				end
			end
		end
	end
end

-- ===========================================================================
function Initialize()
	BASE_Initialize();

	Events.BarbarianClanConversionEnabled.Add(OnBarbarianClanConversionEnabled);
	Events.BarbarianClanConversionDisabled.Add(OnBarbarianClanConversionDisabled);

	Events.PlayerOperationComplete.Add(OnPlayerOperationComplete);
	Events.UnitCommandStarted.Add(OnUnitCommandStarted);
	Events.LocalPlayerTurnBegin.Add(OnLocalPlayerTurnBegin);

	LuaEvents.PlayerChange_Close.Add(OnPlayerChangeClosed);

	-- new
	Events.PlayerTurnActivated.Add(PermaBribeBarbarianTrait);
end