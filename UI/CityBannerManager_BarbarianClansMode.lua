-- Copyright 2020, Firaxis Games
-- edited by Slothoth as the bloody banner wont disappear on city founding
-- ===========================================================================
-- CACHE BASE FUNCTIONS
-- ===========================================================================
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


-- ===========================================================================
function CreateBarbarianTribeBanner(pPlot , pBarbTribe )
	local uiTribeBanner  = m_BarbarianTribeBannerIM:GetInstance();

	uiTribeBanner.TribeIcon:SetIcon("ICON_" .. pBarbTribe.TribeNameType);
	uiTribeBanner.TribeIcon:LocalizeAndSetToolTip(pBarbTribe.TribeDisplayName);
	local sTribeType = pBarbTribe.TribeType
	local iActivePlayer = Game.GetLocalPlayer();
	local pPlayerConfig = PlayerConfigurations[iActivePlayer]
    local sCivName = pPlayerConfig:GetCivilizationTypeName()
	if sCivName == 'SLTH_CIVILIZATION_CLAN_OF_EMBERS' then
		if sTribeType == 'TRIBE_CLAN_MELEE_OPEN' or sTribeType == 'TRIBE_CLAN_MELEE_FOREST' then
			uiTribeBanner.TribeBannerButton:RegisterCallback( Mouse.eLClick, function() OnTribeBannerButtonClicked(pPlot:GetIndex()); end );
		end
	end

	local backColor , _ = UI.GetPlayerColors( PlayerTypes.BARBARIAN );
	uiTribeBanner.Banner_Base:SetColor(backColor);

	local iActivePlayer  = Game.GetLocalPlayer();
	if(iActivePlayer == -1) then
		-- No local player.
		return;
	end

	local tribeBannerEntry  = 
	{	
		Plot = pPlot;
		BarbarianTribe = pBarbTribe;
		BannerInstance = uiTribeBanner;
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

-- ===========================================================================
function UpdateTribeBannerVisibility(tribeBannerEntry , eVisibility )
	--Banner can be interacted with as long as plot is not hidden
	if(eVisibility == PLOT_HIDDEN)then
		tribeBannerEntry.BannerInstance.Anchor:SetHide(true);
		tribeBannerEntry.BannerInstance.TribeBannerButton:LocalizeAndSetToolTip("");
		tribeBannerEntry.BannerInstance.TribeBannerButton:SetDisabled(true);
	else
		tribeBannerEntry.BannerInstance.Anchor:SetHide(false);
		tribeBannerEntry.BannerInstance.TribeBannerButton:LocalizeAndSetToolTip("LOC_TRIBE_BANNER_TREAT_WITH_TRIBE_TT", tribeBannerEntry.BarbarianTribe.TribeDisplayName);
		tribeBannerEntry.BannerInstance.TribeBannerButton:SetDisabled(false);
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
			-- ExposedMembers.ExtraHeroes.SetPlotProperty(locX, locY, 'barbclantype', tribeIndex);
			CreateBarbarianTribeBanner(pPlot, pBarbTribe);
		end
	end
end

-- ===========================================================================
function OnImprovementRemovedFromMap( locX , locY , eOwner  )
	if(eOwner == -1)then
		local pPlot  = Map.GetPlot(locX, locY);
		for k,v in ipairs(m_BarbarianTribeBanners) do
			if(pPlot == v.Plot)then
				print('releasing barb banner instance')
				m_BarbarianTribeBannerIM:ReleaseInstance(v.BannerInstance);
				table.remove(m_BarbarianTribeBanners, k);
				return;
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

-- ===========================================================================
function Initialize()
	BASE_Initialize();

	Events.BarbarianClanConversionEnabled.Add(OnBarbarianClanConversionEnabled);
	Events.BarbarianClanConversionDisabled.Add(OnBarbarianClanConversionDisabled);

	Events.PlayerOperationComplete.Add(OnPlayerOperationComplete);
	Events.UnitCommandStarted.Add(OnUnitCommandStarted);
	Events.LocalPlayerTurnBegin.Add(OnLocalPlayerTurnBegin);

	LuaEvents.PlayerChange_Close.Add(OnPlayerChangeClosed);
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
end