-- Copyright 2020, Firaxis Games
include("SupportFunctions");

local m_BarbarianTribePlotIndex : number;
local m_SelectedInciteTargetID	: number = -1;

local CANT_INCITE_DESCRIPTION_SIZE_Y	: number = 156;
local CAN_INCITE_DESCRIPTION_SIZE_Y		: number = 120;
local CANT_INCITE_DESCRIPTION_OFFSET_Y	: number = 110;
local CAN_INCITE_DESCRIPTION_OFFSET_Y	: number = 92;

-- ===========================================================================
function OnOpenTreatWithTribePopup(plotIndex : number)
	ContextPtr:SetHide(false);

	local iActivePlayer : number = Game.GetLocalPlayer();
	if (iActivePlayer == -1) then
		return;
	end
	local pActivePlayer = Players[iActivePlayer];

	m_BarbarianTribePlotIndex = plotIndex;
	local pTribePlot : table = Map.GetPlotByIndex(plotIndex);
	local iPlotX : number = pTribePlot:GetX();
	local iPlotY : number = pTribePlot:GetY();
	local pBarbarianManager : table = Game.GetBarbarianManager();
	local tribeIndex : number = pBarbarianManager:GetTribeIndexAtLocation(iPlotX, iPlotY);
	local barbType : number = pBarbarianManager:GetTribeNameType(tribeIndex);
	local pBarbTribe : table = GameInfo.BarbarianTribeNames[barbType];

	-- Header
	local strHeader : string = Locale.Lookup("LOC_TREAT_WITH_NAMED_CLAN", pBarbTribe.TribeDisplayName);
	Controls.HeaderLabel:SetText(strHeader);

	-- Subheader info
	local strInfo : string = ComposeTribeInfoString(tribeIndex) or "";
	Controls.SubheaderLabel:SetText(strInfo);

	-- Prioritize operations: only 3 can be relevant at the same time
	local bIsExclusionTest : boolean = false;
	local tParameters : table = {};
	tParameters[PlayerOperations.PARAM_PLOT_ONE] = m_BarbarianTribePlotIndex;


	-- Hire: show as long as the player has a city
	if (pActivePlayer:GetCities():GetCount() >= 1) then
		Controls.HireOption:SetHide(false);
		local bCanStartHire, tHireResults = UI.CanStartPlayerOperation(iActivePlayer, PlayerOperations.HIRE_CLAN, tParameters, bIsExclusionTest);
		Controls.TreatOptionButtonHire:SetDisabled(not bCanStartHire);
		local strGameplayText = FormatOperationGameplayText(tHireResults);
		Controls.TreatOptionHireDescription:SetText(strGameplayText);
	else
		Controls.HireOption:SetHide(true);
		Controls.TreatOptionButtonHire:SetDisabled(true);
	end

	-- Incite: always shown
	local bCanStartIncite, tInciteResults = UI.CanStartPlayerOperation(iActivePlayer, PlayerOperations.INCITE_CLAN, tParameters, bIsExclusionTest);
	Controls.TreatOptionButtonIncite:SetDisabled(not bCanStartIncite);
	local strGameplayText = FormatOperationGameplayText(tInciteResults);
	Controls.TreatOptionInciteDescription:SetText(strGameplayText);

	--Set up Incite target pulldown
	Controls.InciteTargetPulldown:ClearEntries();
	if (bCanStartIncite) then
		Controls.InciteOptionScroll:SetSizeY(CAN_INCITE_DESCRIPTION_SIZE_Y);
		Controls.InciteOptionGrid:SetOffsetY(CAN_INCITE_DESCRIPTION_OFFSET_Y);
		UpdateInciteTargetPulldown(tribeIndex);
	else
		Controls.InciteOptionScroll:SetSizeY(CANT_INCITE_DESCRIPTION_SIZE_Y);
		Controls.InciteOptionGrid:SetOffsetY(CANT_INCITE_DESCRIPTION_OFFSET_Y);
		Controls.InciteTargetPulldown:SetHide(true);
		Controls.InciteCostLabel:SetHide(true);
	end

	-- Bribe and Ransom: paired, show Ransom if able otherwise show Bribe
	local bShowRansom = UI.CanStartPlayerOperation(iActivePlayer, PlayerOperations.RANSOM_CLAN, tParameters, true);
	if (bShowRansom) then
		Controls.BribeOption:SetHide(true);
		Controls.RansomOption:SetHide(false);

		local bCanStartRansom, tRansomResults = UI.CanStartPlayerOperation(iActivePlayer, PlayerOperations.RANSOM_CLAN, tParameters, bIsExclusionTest);
		Controls.TreatOptionButtonRansom:SetDisabled(not bCanStartRansom);
		local strGameplayText = FormatOperationGameplayText(tRansomResults);
		Controls.TreatOptionRansomDescription:SetText(strGameplayText);
	else
		Controls.RansomOption:SetHide(true);
		Controls.TreatOptionButtonRansom:SetDisabled(true);
		Controls.BribeOption:SetHide(false);

		local bCanStartBribe, tBribeResults = UI.CanStartPlayerOperation(iActivePlayer, PlayerOperations.BRIBE_CLAN, tParameters, bIsExclusionTest);
		Controls.TreatOptionButtonBribe:SetDisabled(not bCanStartBribe);
		local strGameplayText = FormatOperationGameplayText(tBribeResults);
		Controls.TreatOptionBribeDescription:SetText(strGameplayText);
	end
end

-- ===========================================================================
function UpdateInciteTargetPulldown(tribeIndex : number)

	local iActivePlayer : number = Game.GetLocalPlayer();
	if (iActivePlayer == -1) then
		return;
	end

	local pBarbarianManager : table = Game.GetBarbarianManager();
	local tInciteTargets : table = pBarbarianManager:GetTribeInciteTargets(tribeIndex, iActivePlayer);
	if (tInciteTargets ~= nil) then

		Controls.InciteTargetPulldown:GetButton():LocalizeAndSetToolTip("");
		Controls.InciteTargetPulldown:SetDisabled(false);
		Controls.InciteTargetPulldown:SetHide(false);

		local inciteSourceID : number = pBarbarianManager:GetTribeInciteSourcePlayer(tribeIndex);
		local inciteTargetID : number = pBarbarianManager:GetTribeInciteTargetPlayer(tribeIndex);

		for _,eTargetPlayer in ipairs(tInciteTargets) do
			local bSkip : boolean = false;
			-- If the active player was the last to incite this clan, exclude their last-chosen target
			if (eTargetPlayer == inciteTargetID) then
				if (iActivePlayer == inciteSourceID) then
					bSkip = true;
				end
			end

			if (not bSkip) then
				local uiIncitePulldownEntry : table = {};
				Controls.InciteTargetPulldown:BuildEntry("InstanceOne", uiIncitePulldownEntry);
			
				-- Other player name
				local pOtherPlayerConfig : table = PlayerConfigurations[eTargetPlayer];
				local strOtherPlayerCivName : string = Locale.Lookup(pOtherPlayerConfig:GetCivilizationShortDescription());
				local strOtherPlayerLeaderName : string = Locale.Lookup(pOtherPlayerConfig:GetLeaderName());
				-- Other player cost
				local iInciteCost : number = pBarbarianManager:GetTribeInciteCost(tribeIndex, iActivePlayer, otherPlayerID);
				if(strOtherPlayerCivName ~= strOtherPlayerLeaderName)then
					uiIncitePulldownEntry.Button:SetText(strOtherPlayerCivName .. " - " .. strOtherPlayerLeaderName);
				else
					--City states won't have a leader name (it will be the same as civ name)
					uiIncitePulldownEntry.Button:SetText(strOtherPlayerCivName);
				end
				
				uiIncitePulldownEntry.Button:RegisterCallback(Mouse.eLClick, function() SelectInciteTarget(eTargetPlayer, uiIncitePulldownEntry.Button:GetText(), iInciteCost) end);
			end
		end

		Controls.InciteTargetPulldown:CalculateInternals();
		if(m_SelectedInciteTargetID == -1)then
			Controls.TreatOptionButtonIncite:SetDisabled(true);
			Controls.InciteTargetPulldown:GetButton():LocalizeAndSetText("LOC_DIPLOMACY_DEAL_SELECT_TARGET");
			Controls.InciteCostLabel:SetHide(true);
		else
			Controls.InciteCostLabel:SetHide(false);
		end

	else
		Controls.InciteTargetPulldown:SetHide(true);
		Controls.InciteCostLabel:SetHide(true);
	end
end

-- ===========================================================================
function SelectInciteTarget(otherPlayerID : number, otherPlayerCivName : string, otherPlayerCost:number)
	m_SelectedInciteTargetID = otherPlayerID;
	Controls.InciteTargetPulldown:GetButton():LocalizeAndSetText(otherPlayerCivName);
	
	if (otherPlayerCost > 0) then
		Controls.InciteCostLabel:SetHide(false);
		local pLocalPlayer = Players[Game.GetLocalPlayer()];
		local strCost : string = Locale.Lookup("LOC_TREAT_WITH_TRIBE_INCITE_COST", otherPlayerCost);

		if (otherPlayerCost <= pLocalPlayer:GetTreasury():GetGoldBalance()) then
			Controls.InciteCostLabel:SetText(strCost);
			Controls.TreatOptionButtonIncite:SetDisabled(false);
		else
			Controls.InciteCostLabel:SetText("[COLOR:Red]" .. strCost .. "[ENDCOLOR]");
			Controls.TreatOptionButtonIncite:SetDisabled(true);
		end
	else
		Controls.InciteCostLabel:SetHide(true);
		Controls.TreatOptionButtonIncite:SetDisabled(true);
	end
end

-- ===========================================================================
function FormatOperationGameplayText(tResults:table)
	local strHelp : string = FormatOperationHelpString(tResults);
	local strFails : string = FormatFailureReasonsString(tResults);

	if (strHelp ~= "") then
		if (strFails ~= "") then
			return strHelp .. "[NEWLINE][NEWLINE]" .. strFails;
		else
			return strHelp;
		end
	else
		return strFails;
	end
end

-- ===========================================================================
function FormatOperationHelpString(tResults:table)
	if (tResults == nil or tResults[PlayerOperationResults.ADDITIONAL_DESCRIPTION] == nil) then
		return "";
	end

	local strResult = "";
	for i,v in ipairs(tResults[PlayerOperationResults.ADDITIONAL_DESCRIPTION]) do
		strResult = strResult .. Locale.Lookup(v);
	end

	return strResult;
end

-- ===========================================================================
function FormatFailureReasonsString(tResults:table)
	if (tResults == nil) then
		return "";
	end
	if (tResults[PlayerOperationResults.FAILURE_REASONS] == nil) then
		return "";
	end

	local strResult : string = "[COLOR:Red]";
	for i,v in ipairs(tResults[PlayerOperationResults.FAILURE_REASONS]) do
		strResult = strResult .. Locale.Lookup(v);
	end
	strResult = strResult .. "[ENDCOLOR]";

	return strResult;
end

-- ===========================================================================
function ComposeTribeInfoString(tribeIndex:number)
	
	local strInfos = {};
	local pBarbarianManager : table = Game.GetBarbarianManager();

	-- Clan type
	local eTribeType = pBarbarianManager:GetTribeType(tribeIndex);
	local pBarbTribe = GameInfo.BarbarianTribes[eTribeType];
	if (pBarbTribe ~= nil and pBarbTribe.Name ~= nil) then
		local strClanType : string = Locale.Lookup(pBarbTribe.Name);
		table.insert(strInfos, strClanType);
	end

	-- Conversion tip given only in chunky increments as a hint
	local iCurrentPoints : number = pBarbarianManager:GetTribeConversionPoints(tribeIndex);
	local iPointsToConvert : number = pBarbarianManager:GetTribeConversionPointsRequired(tribeIndex);
	local iPointsRemaining = iPointsToConvert - iCurrentPoints;

	if (iCurrentPoints >= 0) then
		local strConversionTip : string = "";
		if (iPointsRemaining >= 50) then
			strConversionTip = Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_TURNS", 50);
		elseif (iPointsRemaining >= 20) then
			strConversionTip = Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_TURNS", 20);
		elseif (iPointsRemaining >= 10) then
			strConversionTip = Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_TURNS", 10);
		else
			strConversionTip = Locale.Lookup("LOC_TRIBE_BANNER_CONVERSION_TIP_IMMINENT");
		end
		table.insert(strInfos, strConversionTip);
	else
		local strDisabledTip : string = pBarbarianManager:GetTribeConversionDisabledHelp(tribeIndex);
		if (strDisabledTip ~= nil and strDisabledTip ~= "") then
			table.insert(strInfos, strDisabledTip);
		end
	end

	return FormatTableAsString(strInfos, ".");
end

-- ===========================================================================
function OnBribe()
	local parameters : table = {};
	parameters[PlayerOperations.PARAM_PLOT_ONE] = m_BarbarianTribePlotIndex;
	UI.RequestPlayerOperation( Game.GetLocalPlayer(), PlayerOperations.BRIBE_CLAN, parameters);
	ClosePopup();
end

-- ===========================================================================
function OnHire()
	local parameters : table = {};
	parameters[PlayerOperations.PARAM_PLOT_ONE] = m_BarbarianTribePlotIndex;
	UI.RequestPlayerOperation( Game.GetLocalPlayer(), PlayerOperations.HIRE_CLAN, parameters);
	ClosePopup();
end

-- ===========================================================================
function OnRansom()
	local parameters : table = {};
	parameters[PlayerOperations.PARAM_PLOT_ONE] = m_BarbarianTribePlotIndex;
	UI.RequestPlayerOperation( Game.GetLocalPlayer(), PlayerOperations.RANSOM_CLAN, parameters);
	ClosePopup();
end

-- ===========================================================================
function OnIncite()
	local parameters : table = {};
	parameters[PlayerOperations.PARAM_OTHER_PLAYER] = m_SelectedInciteTargetID;
	parameters[PlayerOperations.PARAM_PLOT_ONE] = m_BarbarianTribePlotIndex;
	UI.RequestPlayerOperation( Game.GetLocalPlayer(), PlayerOperations.INCITE_CLAN, parameters);
	ClosePopup();
end

-- ===========================================================================
function ClosePopup()
	m_SelectedInciteTargetID = -1;
	ContextPtr:SetHide(true);
end

-- ===========================================================================
function OnClose()
	ClosePopup();
end

-- ===========================================================================
function OnLocalPlayerTurnEnd ()
	ClosePopup();
end

-- ===========================================================================
function OnInputHandler( pInputStruct:table )
	local uiMsg :number = pInputStruct:GetMessageType();
	if uiMsg == KeyEvents.KeyUp and pInputStruct:GetKey() == Keys.VK_ESCAPE then
		ClosePopup();
		return true;
	end
	return false;
end

-- ===========================================================================
function Initialize()	
	ContextPtr:SetInputHandler( OnInputHandler, true );

	Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose);
	Controls.CloseButton:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	Controls.TreatOptionButtonBribe:RegisterCallback(Mouse.eLClick, OnBribe);
	Controls.TreatOptionButtonBribe:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	Controls.TreatOptionButtonHire:RegisterCallback(Mouse.eLClick, OnHire);
	Controls.TreatOptionButtonHire:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	Controls.TreatOptionButtonRansom:RegisterCallback(Mouse.eLClick, OnRansom);
	Controls.TreatOptionButtonRansom:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	Controls.TreatOptionButtonIncite:RegisterCallback(Mouse.eLClick, OnIncite);
	Controls.TreatOptionButtonIncite:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	-- LUA Events
	LuaEvents.CityBannerManager_OpenTreatWithTribePopup.Add(OnOpenTreatWithTribePopup);

	-- Game Events
	Events.LocalPlayerTurnEnd.Add( OnLocalPlayerTurnEnd );
end
Initialize();