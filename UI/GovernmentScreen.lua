-- Copyright 2018, Firaxis Games

include("InstanceManager");
include("SupportFunctions");	-- Clamp
include("TabSupport");
include("Civ6Common");
include("PopupDialog");
include("ModalScreen_PlayerYieldsHelper");
include("GameCapabilities");
include("GovernmentScreen_Model");
    
-- ===========================================================================
--	CONSTANTS	/ DEFINES
-- ===========================================================================
-- Hard caps on how big the modal may grow. Past these, the columns scroll horizontally and
-- the per-column policy lists scroll vertically instead of the modal expanding further.
---@type number
local MODAL_MAX_W, MODAL_MAX_H = 1860, 900;
---@type boolean
local FFH_EXISTS = false -- (GameInfo.Leaders["LEADER_CAPRIA"] ~= nil);
---@type string
local TXT_GOV_ASSIGN_POLICIES = Locale.Lookup("LOC_GOVT_ASSIGN_ALL_POLICIES");
---@type string
local TXT_GOV_CONFIRM_POLICIES = Locale.Lookup("LOC_GOVT_CONFIRM_POLICIES");
---@type string
local TXT_GOV_POPUP_PROMPT_POLICIES_CLOSE = Locale.Lookup("LOC_GOVT_POPUP_PROMPT_POLICIES_CLOSE");
---@type string
local TXT_GOV_POPUP_PROMPT_POLICIES_CONFIRM = Locale.Lookup("LOC_GOVT_POPUP_PROMPT_POLICIES_CONFIRM");
-- Government-change dialogue strings, same keys the old (base-game) government panel used.
---@type string
local TXT_GOV_CONFIRM_GOVERNMENT = Locale.Lookup("LOC_GOVT_CONFIRM_GOVERNMENT");
---@type string
local TXT_GOV_POPUP_YES = Locale.Lookup("LOC_GOVT_PROMPT_YES");
---@type string
local TXT_GOV_POPUP_NO = Locale.Lookup("LOC_GOVT_PROMPT_NO");
---@type number
local COLOR_GOVT_UNSELECTED	= UI.GetColorValueFromHexLiteral(0xffe9dfc7); -- Background for unselected background (or forground text color on non-selected).
---@type number
local COLOR_GOVT_SELECTED	= UI.GetColorValueFromHexLiteral(0xff261407); -- Background for selected background (or forground text color on non-selected).

-- Width of the fixed government column. MUST match GovernmentColumn's Size in the XML and the
-- X offset of the Wood_CarvedBorder backing Grid: the policy scroller starts where it ends.
---@type number
local GOV_COLUMN_W = 368;
-- Height of the modal's blue title bar (from the ModalScreenWide chrome). Used to measure the
-- gap below the header when centring the policy columns vertically -- tune here if the chrome
-- style changes.
---@type number
local HEADER_BAR_H = 40;
-- Policy card sizes: resting, and grown-on-hover. The hover "pop" replaces the old flat blue
-- Hover box. The PolicyNameItem Root cell stays at the RESTING size, so growing a card overlaps
-- its neighbours instead of reflowing the list.
---@type number
local CARD_W, CARD_H = 140, 39;
---@type number
local CARD_HOVER_W, CARD_HOVER_H = 152, 43;
-- The Active/Highlight frame art is drawn slightly proud of the card; keep that margin when the
-- card grows so the frames stay aligned to it.
---@type number
local CARD_OVERLAY_PAD_W, CARD_OVERLAY_PAD_H = 8, 5;


-- ===========================================================================
--	VARIABLES
-- ===========================================================================
---@type boolean
local m_isLocalPlayerTurn = true;           -- Toggle these based on the game engine rules.
---@type number
local m_TopPanelConsideredHeight = 0;
---@type string
local m_governmentChangeType = "";		-- The government type proposed being changed to.
---@type string
local m_currentCivicType	= nil;
---@type number
local m_civicProgress = 0;
---@type number
local m_civicCost	= 0;
---@type boolean
g_isMyGovtTabDirty, g_isGovtTabDirty, g_isPoliciesTabDirty = false, false, false;

-- ===========================================================================
--	FUNCTIONS
-- ===========================================================================

function GetPolicyBGTexture(policyType)
    return policyType .. "_SCENE.dds"
end

function Close()
	if ContextPtr:IsHidden() then return; end
	if Controls.ConfirmPolicies:IsVisible() and Controls.ConfirmPolicies:IsEnabled() then
		-- Policies confirmation button is enabled (and showing); warn player changes are not saved!
		---@type table
		local popup = PopupDialogInGame:new( "WarnUnsavedChanges" );
		popup:ShowYesNoDialog( TXT_GOV_POPUP_PROMPT_POLICIES_CLOSE,
			function() Controls.ConfirmPolicies:SetDisabled(true); Close() end ); -- no-op on cancel
	else
		if not ContextPtr:IsHidden() then               -- Actual close
			UI.PlaySound("UI_Screen_Close");
		end
		UIManager:DequeuePopup(ContextPtr);
		m_governmentChangeType	= "";
		m_isPoliciesChanged		= false;
		LuaEvents.Government_CloseGovernment();
	end
end

function OnClose()
	Close();
end

function OnConfirmPolicies()
	if Controls.ConfirmPolicies:IsDisabled() then
		UI.PlaySound("Play_Mouse_Click_Negative");
		return;
	end

	function OnConfirmPolicies_Yes()
		UI.PlaySound("Confirm_Civic");

		---@type table
		local kPlayer = Players[Game.GetLocalPlayer()];
		---@type table
		local pPlayerCulture = kPlayer:GetCulture();

		-- Perform in two passes, with removals done first, otherwise "swapping"
		-- may fail between rows becaues the engine will think a policy is still
		-- active in its slot.

		---@type table
		local clearList = {};	-- table of slots to clear
		---@type table
		local addList = {};		-- table of policies to add, keyed by the slot index

		-- Build the lists
		for nSlotIndexPlusOne,tSlotData in pairs( m_ActivePoliciesBySlot ) do
			table.insert( clearList, nSlotIndexPlusOne-1 );
			if (m_kPolicyCatalogData[tSlotData.GC_PolicyType] ~= nil) then
				addList[nSlotIndexPlusOne-1] = m_kPolicyCatalogData[tSlotData.GC_PolicyType].PolicyHash;
			end
		end

		pPlayerCulture:RequestPolicyChanges(clearList, addList);

		-- NOTE: this button commits POLICIES ONLY. Government changes are committed immediately
		-- from OnGovernmentClicked (see the comment there), because the chosen government decides
		-- which policies are on offer and so cannot wait behind the same Confirm.

		m_isPoliciesChanged	= false;
		Controls.ConfirmPolicies:SetDisabled( true );
		Close();
	end

	if(ShouldConfirmChanges())then
		---@type table
		local popup = PopupDialogInGame:new( "ConfirmPolicies" );
		-- Policies only; the anarchy warning now lives on the government click (OnGovernmentClicked).
		popup:ShowYesNoDialog(TXT_GOV_POPUP_PROMPT_POLICIES_CONFIRM, OnConfirmPolicies_Yes);
	else
		OnConfirmPolicies_Yes();
	end
end

-- ===========================================================================
--	LUA Event
--	Called to first open the page.
-- ===========================================================================
function OnOpenGovernmentScreenRefresh()
	RefreshAllData();
    OnOpenGovernmentScreen();
end

function OnOpenGovernmentScreen()
	if m_ePlayer ~= -1 then

		UI.PlaySound("UI_Screen_Open");
		-- Cache the civics data
		local localPlayer					= Players[Game.GetLocalPlayer()];
		local playerCivics					= localPlayer:GetCulture();
		---@type number
		local currentCivicID	= playerCivics:GetProgressingCivic();
		if(currentCivicID >= 0) then
			m_currentCivicType = GameInfo.Civics[currentCivicID].CivicType;
			m_civicProgress	= playerCivics:GetCulturalProgress(currentCivicID);
			m_civicCost		= playerCivics:GetCultureCost(currentCivicID);
		else
			m_currentCivicType = nil;
		end
		Controls.ScreenAnimIn:SetToBeginning();
		Controls.ScreenAnimIn:Play();
		RealizeAll();

		local kParameters = {};
		kParameters.RenderAtCurrentParent = true;
		kParameters.InputAtCurrentParent = true;
		kParameters.AlwaysVisibleInQueue = true;
		UIManager:QueuePopup(ContextPtr, PopupPriority.Low, kParameters);
		LuaEvents.Government_OpenGovernment();
	end
end

-- ===========================================================================
--
-- ===========================================================================
function RefreshAllData()
	PopulateLivePlayerData( m_ePlayer );
	SnapshotCommittedPolicies();	-- committed state, before any staging
	SnapshotCommittedGovernment();
	RealizeAll();
	if not RefreshYields() then
		Controls.Vignette:SetSizeY(m_TopPanelConsideredHeight);
	end
	g_isMyGovtTabDirty = true;
	g_isGovtTabDirty = true;
	g_isPoliciesTabDirty = true;
end

-- ===========================================================================
--	Game Engine Events
-- ===========================================================================
---@param playerID number
function OnGovernmentChanged( playerID )
	if playerID == m_ePlayer and m_ePlayer ~= -1 then
		RefreshAllData();
		if g_kCurrentGovernment == nil and ContextPtr:IsVisible() then
			Close();
		end
	end
end

---@param playerID number
function OnGovernmentPolicyChanged( playerID )
	if ContextPtr:IsVisible() and playerID == m_ePlayer then
		RefreshAllData();
	end
end

function OnLocalPlayerTurnBegin()
	m_isLocalPlayerTurn = true;
	---@type number
	local ePlayer = Game.GetLocalPlayer();
	if ePlayer ~= m_ePlayer and m_ePlayer ~= -1 then
		SaveLivePlayerData( m_ePlayer );
	end

	m_ePlayer = ePlayer;
	if m_ePlayer ~= -1 then
		RefreshAllData();
	end
end

function OnLocalPlayerTurnEnd()
	m_isLocalPlayerTurn = false;
	if(GameConfiguration.IsHotseat()) then
		Close();
	end
end

function OnCivicsUnlocked()
	if ContextPtr:IsHidden() then return; end		-- Autoplay!
	RefreshAllData();
end

function OnPhaseBegin()
	---@type number
	local ePlayer = Game.GetLocalPlayer();
	if ePlayer ~= m_ePlayer and m_ePlayer ~= -1 then
		SaveLivePlayerData( m_ePlayer );
	end

	m_ePlayer = ePlayer;
	if m_ePlayer ~= -1 then
		RefreshAllData();
	end
end

---@param type number
---@param tag string
---@param iData1 number
---@param iData2 number
---@param strData1 string
function OnUpdateUI( type, tag, iData1, iData2, strData1)
	if type == SystemUpdateUI.ScreenResize then
		if ContextPtr:IsVisible() then RealizeAll(); end
	end
end

-- ===========================================================================
-- FOR OVERRIDE in scenarios/mods where we don't need the confirm policy change dialogue
-- ===========================================================================
function ShouldConfirmChanges()
	return true;
end

function LateInitialize()
	m_TopPanelConsideredHeight = Controls.Vignette:GetSizeY() - TOP_PANEL_OFFSET;
	PopulateStaticData();			-- Obtain unchanging, static data from game core
	BuildCategoryColumns();			-- Build the 5 category columns from the shared instance
	if FFH_EXISTS then
		ApplyFFHNoGovernmentLayout();	-- drop the Governments column, relocate Confirm
	end
	m_ePlayer = Game.GetLocalPlayer();
end

-- ===========================================================================
--	UI Events
-- ===========================================================================
---@param isReload boolean
function OnInit( isReload )
	LateInitialize();
	if isReload then
		LuaEvents.GameDebug_GetValues( "GovernmentScreen" );
	end
end

function OnShutdown()
	-- Clear Lua Events
	LuaEvents.LaunchBar_CloseGovernmentPanel.Remove( OnClose );
	LuaEvents.GameDebug_Return.Remove( OnGameDebugReturn );
	LuaEvents.NotificationPanel_GovernmentOpenGovernments.Remove( OnOpenGovernmentScreenRefresh );
	LuaEvents.NotificationPanel_GovernmentOpenPolicies.Remove( OnOpenGovernmentScreenRefresh );
	LuaEvents.LaunchBar_GovernmentOpenGovernments.Remove( OnOpenGovernmentScreenRefresh );
	LuaEvents.LaunchBar_GovernmentOpenMyGovernment.Remove( OnOpenGovernmentScreenRefresh );
	LuaEvents.TechCivicCompletedPopup_GovernmentOpenGovernments.Remove( OnOpenGovernmentScreenRefresh );
	LuaEvents.TechCivicCompletedPopup_GovernmentOpenPolicies.Remove( OnOpenGovernmentScreenRefresh );
	LuaEvents.Advisor_GovernmentOpenPolicies.Remove( OnOpenGovernmentScreenRefresh );

end

-- ===========================================================================
--	LUA Event
--	Set cached values back after a hotload.
-- ===========================================================================
---@param context string
---@param contextTable table
function OnGameDebugReturn( context, contextTable )
	if context == "GovernmentScreen" and contextTable then
		---@type number
		local eOpenTabAtInit = contextTable["eOpenTabAtInit"];
		if eOpenTabAtInit ~= nil and OnOpenGovernmentScreen ~= nil then
			OnOpenGovernmentScreen(eOpenTabAtInit);
		end
	end
end

-- ===========================================================================
--	Input
--	UI Event Handler
-- ===========================================================================
---@param pInputStruct table
function OnInputHandler( pInputStruct )
	if ( pInputStruct:GetMessageType() == KeyEvents.KeyUp ) then
		---@type number
		local key = pInputStruct:GetKey();
		if ( key == Keys.VK_ESCAPE ) then
			Close();
			return true;
		elseif ( key == Keys.VK_RETURN ) then
			-- Don't let enter propagate or it will hit action panel which will raise a screen (potentially this one again) tied to the action.
			if IsAbleToChangePolicies() and m_isPoliciesChanged then
				OnConfirmPolicies();
			end
			return true;
		end
	end
	return false;
end

-- ===========================================================================
--	CTOR
-- ===========================================================================
function Initialize()

	-- Static controls:
	ContextPtr:SetInitHandler( OnInit );
	ContextPtr:SetInputHandler( OnInputHandler, true );
	ContextPtr:SetShutdown( OnShutdown );

	Controls.ConfirmPolicies:RegisterCallback(		Mouse.eLClick,	OnConfirmPolicies);
	Controls.ConfirmPolicies:RegisterCallback(		Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	-- Hide these after going invisible to prevent input

	Controls.ModalScreenTitle:SetText(Locale.ToUpper("LOC_GOVT_GOVERNMENT"));
	Controls.ModalScreenClose:RegisterCallback(Mouse.eLClick, OnClose);
	Controls.ModalBG:SetHide(true);

	-- Gamecore	EVENTS
	Events.CivicsUnlocked.Add( OnCivicsUnlocked );
	Events.GovernmentChanged.Add( OnGovernmentChanged );
	Events.GovernmentPolicyChanged.Add( OnGovernmentPolicyChanged );
	Events.GovernmentPolicyObsoleted.Add( OnGovernmentPolicyChanged );
	Events.PhaseBegin.Add(OnPhaseBegin);
	Events.LocalPlayerTurnBegin.Add( OnLocalPlayerTurnBegin );
	Events.LocalPlayerTurnEnd.Add( OnLocalPlayerTurnEnd );
	Events.SystemUpdateUI.Add( OnUpdateUI );

	-- Lua Events
	LuaEvents.LaunchBar_CloseGovernmentPanel.Add( OnClose );
	LuaEvents.GameDebug_Return.Add( OnGameDebugReturn );
	LuaEvents.NotificationPanel_GovernmentOpenGovernments.Add( OnOpenGovernmentScreenRefresh );
	LuaEvents.NotificationPanel_GovernmentOpenPolicies.Add( OnOpenGovernmentScreenRefresh );
	LuaEvents.LaunchBar_GovernmentOpenGovernments.Add( OnOpenGovernmentScreenRefresh );
	LuaEvents.LaunchBar_GovernmentOpenMyGovernment.Add( OnOpenGovernmentScreenRefresh );	-- normal launchbar click
	LuaEvents.TechCivicCompletedPopup_GovernmentOpenGovernments.Add( OnOpenGovernmentScreenRefresh );
	LuaEvents.TechCivicCompletedPopup_GovernmentOpenPolicies.Add( OnOpenGovernmentScreenRefresh );
	LuaEvents.Advisor_GovernmentOpenPolicies.Add( OnOpenGovernmentScreenRefresh );
end
if HasCapability("CAPABILITY_GOVERNMENTS_VIEW") then
	Initialize();
end

-- ===========================================================================
-- ===========================================================================
--	FFH OVERHAUL: single-policy-per-category picker presentation.
--	Reuses the existing staging model (m_ActivePolicyRows / m_ActivePoliciesBySlot,
--	SetActivePolicyAtSlotIndex / RemoveActivePolicyAtSlotIndex, m_isPoliciesChanged)
--	and commit path (OnConfirmPolicies -> RequestPolicyChanges). Only presentation
--	changes: per category a title + a listbox of policy names + a description panel.
-- ===========================================================================
-- ===========================================================================

-- Generic column "styles", indexed 0..4 (NOT tied to a slot type). Each government slot
-- picks a style by its GameInfo index; anything past the last defined style falls back to
-- style 0. Only what differs between columns lives here: the policy-row texture and the
-- faint watermark (art + its size/offset). The title comes from the slot's own Name.
---@type table
local CATEGORY_DEF = {
	[0] = { PolicyTexture="Governments_AdminCard_Compact.dds",			Watermark="Governments_WatermarkWildcard", WatermarkOffsetY=275, WatermarkSizeX=185, WatermarkSizeY=62 },
	[1] = { PolicyTexture="Governments_LaborCard_Compact.dds",			Watermark="Governments_WatermarkEconomic", WatermarkOffsetY=250, WatermarkSizeX=185, WatermarkSizeY=81 },
	[2] = { PolicyTexture="Governments_EconomicCard_Compact.dds",		Watermark="Governments_WatermarkEconomic", WatermarkOffsetY=265, WatermarkSizeX=185, WatermarkSizeY=62 },
	[3] = { PolicyTexture="Governments_DiplomaticCard_Compact.dds",		Watermark="Governments_WatermarkDiplo",    WatermarkOffsetY=255, WatermarkSizeX=185, WatermarkSizeY=82 },
	[4] = { PolicyTexture="Governments_ReligiousCard_Compact.dds",		Watermark="Governments_WatermarkMilitary", WatermarkOffsetY=275, WatermarkSizeX=185, WatermarkSizeY=62 },
	[5] = { PolicyTexture="Governments_MilitaryCard_Compact.dds",		Watermark="Governments_WatermarkMilitary", WatermarkOffsetY=275, WatermarkSizeX=185, WatermarkSizeY=62 },
	[6] = { PolicyTexture="Governments_GreatPersonCard_Compact.dds",	Watermark="Governments_WatermarkDiplo",    WatermarkOffsetY=255, WatermarkSizeX=185, WatermarkSizeY=82 },
};

-- Built columns, uiRow -> the instance table (its controls, plus titleKey/PolicyTexture).
-- Populated by BuildCategoryColumns.
---@type table
local CATEGORY_CONTROLS = {};

-- Build one category column per GameInfo.GovernmentSlots row, into MainColumns (after the
-- government column authored in XML). This is the single source of the row model: it fills
-- ROW_SLOT_TYPES / SLOT_TYPE_TO_ROW as it goes. Each slot picks a style from CATEGORY_DEF by
-- its .Index (default style 0 when the index exceeds the defined styles). Called once from
-- LateInitialize. To add/remove/reorder columns, change the GovernmentSlots table in SQL.
function BuildCategoryColumns()
	if #ROW_SLOT_TYPES > 0 then return; end		-- already built (guard re-init)

	-- Which slot types actually have at least one policy in the catalog. Slot types with no
	-- policies get no column (nothing would ever populate them). Runs after PopulateStaticData.
	---@type table
	local slotHasPolicy = {};
	for _, tPolicy in pairs(m_kPolicyCatalogData) do
		slotHasPolicy[tPolicy.SlotType] = true;
	end

	for slot in GameInfo.GovernmentSlots() do
		if slotHasPolicy[slot.GovernmentSlotType] then
		---@type number
		local nRowIndex = #ROW_SLOT_TYPES + 1;
		ROW_SLOT_TYPES[nRowIndex] = slot.GovernmentSlotType;
		SLOT_TYPE_TO_ROW[slot.GovernmentSlotType] = nRowIndex;

		---@type table
		local def = CATEGORY_DEF[slot.Index] or CATEGORY_DEF[0];
		---@type table
		local inst = {};
		ContextPtr:BuildInstanceForControl( "PolicyCategoryColumn", inst, Controls.MainColumns );
--		inst.Watermark:SetTexture( def.Watermark );
--		inst.Watermark:SetSizeVal( def.WatermarkSizeX, def.WatermarkSizeY );
--		inst.Watermark:SetOffsetVal( 0, def.WatermarkOffsetY );
		inst.titleKey = slot.Name;				-- slot's own display name (a LOC key)
		inst.PolicyTexture = def.PolicyTexture;	-- consumed by RealizeCategoryList
		CATEGORY_CONTROLS[nRowIndex] = inst;
		end
	end
    FitModalWidth()
end

-- Left inset of the policy area: the fixed government column's width, or 0 when that column is
-- hidden (FFH_EXISTS) and the policies get the whole modal.
---@return number
function GetPolicyAreaLeft()
	return Controls.GovernmentColumn:IsHidden() and 0 or GOV_COLUMN_W;
end

-- Width the modal to fit the fixed government column PLUS the generated policy columns, capped
-- at MODAL_MAX_W. Past the cap the ColumnsScroller keeps its capped width and the columns scroll
-- horizontally inside it. 50 = frame margin (~25px each side). Measure the stack rather than
-- recomputing by hand.
function FitModalWidth()
	Controls.MainColumns:CalculateSize();
	---@type number
	local MARGIN_X = 50;
	---@type number
	local nLeft = GetPolicyAreaLeft();
	-- The scroller spans only the area right of the government column, so the cap has to leave
	-- room for that column as well as the frame margin.
	---@type number
	local policyW = math.min( Controls.MainColumns:GetSizeX(), MODAL_MAX_W - MARGIN_X - nLeft );
	Controls.ColumnsScroller:SetOffsetX( nLeft );
	Controls.ColumnsScroller:SetSizeX( policyW );
	Controls.MainContainer:SetSizeX( nLeft + policyW + MARGIN_X );
end

-- FFH has no governments beyond chiefdom, shows only the policy categories. The Confirm
-- button is authored inside GovernmentColumn and also commits policy changes, so reparent it onto
-- the modal itself first -- it keeps its C,B anchor, so it settles into the modal's bottom-centre
-- margin -- then hide the whole column. Without the reparent the button would vanish with the
-- column and players would have no way to commit. Runs once, right after the columns are built.
function ApplyFFHNoGovernmentLayout()
	Controls.ConfirmPolicies:ChangeParent( Controls.MainContainer );
	Controls.ConfirmPolicies:SetOffsetVal( 0, 8 );		-- nudge up off the very bottom edge; tune to taste
	Controls.GovernmentColumn:SetHide( true );
	FitModalWidth();									-- reclaim the freed column width
end








-- Show the description for the category's currently-staged policy (or blank).
-- Fill a category's description card (title / image / text) for a given policy.
-- Uses the base slot-type card art for now; swap to per-policy art later.
---@param cc table
---@param strPolicyType string

function RealizeDescriptionCard( cc, strPolicyType )
	---@type table
	local tPolicy = m_kPolicyCatalogData[strPolicyType];
	-- GetPolicyDisplayName so a civ-renamed policy's card title matches its row in the list.
	cc.DescTitle:SetText( Locale.ToUpper( GetPolicyDisplayName(strPolicyType) ) );
	cc.DescImage:SetTexture( GetPolicyBGTexture(strPolicyType) );
	cc.DescImage:SetHide( false );
	cc.Desc:SetText( tPolicy.Description );
end

---@param nRowIndex number
-- Style the description card for a category.
--   isProposed = this category has a staged, uncommitted change -> "selected" art.
-- Both textures are 352x145, so the Grid's existing slice params stay valid. The glyph
-- colour must invert with the art: selected (light) backing needs the dark text and the
-- unselected (dark) backing the light text. Label:SetColor(c, layer): layer 0 is the main
-- glyph (Color0); layer 1 is the glow (Color1), left as authored.
---@param cc table
---@param isProposed boolean

function SetDescCardState( cc, isProposed, isHover )
	if not isHover then
		cc.DescCard:SetTexture( isProposed
			and "Governments_BackingSelected_Card.dds" or "Governments_Backing_Card.dds" );
		cc.DescBonusBacking:SetColorByName( isProposed
			and "GovBonusSelected" or "GovBonusDark" );
	else
		cc.DescCard:SetTexture( isProposed
			and "Governments_BackingSelected_Card.dds" or "Governments_BackingHover_Card.dds" );
		cc.DescBonusBacking:SetColorByName( isProposed
			and "GovBonusSelected" or "ScienceDark" );
	end
	---@type number
	local uiTextColor = isProposed and COLOR_GOVT_SELECTED or COLOR_GOVT_UNSELECTED;
	cc.DescTitle:SetColor( uiTextColor, 0 );
	cc.Desc:SetColor( uiTextColor );
end

function RealizeCategoryDescription( nRowIndex )
	---@type table
	local cc = CATEGORY_CONTROLS[nRowIndex];
	---@type table
	local tSlot = GetCategorySlot(nRowIndex);
	---@type string
	local strSelected = DisplayPolicyType( tSlot and tSlot.GC_PolicyType );
	---@type string
	local strCommitted = DisplayPolicyType( m_CommittedPolicyByRow[nRowIndex] );
	SetDescCardState( cc, strSelected ~= strCommitted, false );
	if strSelected ~= EMPTY_POLICY_TYPE and m_kPolicyCatalogData[strSelected] ~= nil then
		RealizeDescriptionCard( cc, strSelected );
	else
		-- Empty slot (nothing staged, e.g. bumped off a policy by a prerequisite change).
		-- Show a clear "Unselected Policy" state but keep the card image as a populated card
		-- would (GetPolicyBGTexture is the same call the filled branch uses), not blanked.
		cc.DescTitle:SetText( Locale.ToUpper("LOC_POLICY_JNR_UNSELECTED") );
		cc.DescImage:SetTexture( GetPolicyBGTexture(strSelected) );
		cc.DescImage:SetHide( false );
		cc.Desc:SetText( "" );
	end
end

-- Click a policy in a category listbox: toggle/stage it in the category's slot.
---@param nRowIndex number
---@param strPolicyType string
function OnPolicyItemClicked( nRowIndex, strPolicyType )
	if not IsAbleToChangePolicies() then return; end
	---@type table
	local tSlot = GetCategorySlot(nRowIndex);
	if tSlot == nil then return; end
	-- Re-clicking the already-selected policy is a no-op. It used to CLEAR the slot, which
	-- read as a bug on open: there the selection IS the committed policy, so the very first
	-- click emptied the slot and blanked the description card.
	if tSlot.GC_PolicyType == strPolicyType then return; end
	-- Guard: prerequisite-locked policies register no click callback, but stay defensive.
	if not IsPolicyPrereqMet( strPolicyType ) then return; end
	SetActivePolicyAtSlotIndex( tSlot.GC_SlotIndex, strPolicyType );
	-- Staging this may invalidate a dependent in another column (e.g. changing the state
	-- religion drops Sacrifice the Weak), so resolve dependencies then rebuild every list.
	EnforcePolicyDependencies();
	UI.PlaySound("Play_UI_Click");
	RealizeAll();
end

-- Hover feedback for a policy card: grow the card itself rather than tinting it with an overlay
-- box. The PolicyNameItem Root cell keeps the RESTING size, so a grown card pops out over its
-- neighbours instead of pushing the rest of the list around. The Active/Highlight frame art is
-- drawn slightly proud of the card, so it has to grow by the same amount to stay registered.
---@param inst table
---@param isHover boolean
function SetPolicyCardSize( inst, isHover )
	---@type number
	local w = isHover and CARD_HOVER_W or CARD_W;
	---@type number
	local h = isHover and CARD_HOVER_H or CARD_H;
	-- Do NOT resize inst.Button. Its texture is an unsliced Grid and will not scale with the
	-- control, so resizing it just shifted the art about; and a hit area that grows under the
	-- cursor causes hover flicker. The enlarged card is the CardArt Image laid over the button
	-- (it scales properly, and being larger it fully hides the un-scaled button art).
	inst.CardArt:SetSizeVal( w, h );
	inst.CardArt:SetHide( not isHover );
	inst.Active:SetSizeVal( w + CARD_OVERLAY_PAD_W, h + CARD_OVERLAY_PAD_H );
	inst.Highlight:SetSizeVal( w + CARD_OVERLAY_PAD_W, h + CARD_OVERLAY_PAD_H );
end

-- Build one category's listbox of eligible policy names.
---@param nRowIndex number
function RealizeCategoryList( nRowIndex )
	---@type table
	local cc = CATEGORY_CONTROLS[nRowIndex];
	---@type table
	local uiStack = cc.PolicyStack;
	uiStack:DestroyAllChildren();

    print('setting title', cc.titleKey)
    print('setting loc title', Locale.ToUpper(cc.titleKey))
	cc.Title:SetText( Locale.ToUpper(cc.titleKey) );

	---@type table
	local tSlot = GetCategorySlot(nRowIndex);
	---@type string
	local strSelected = DisplayPolicyType( tSlot and tSlot.GC_PolicyType );
	---@type string
	local strCommitted = DisplayPolicyType( m_CommittedPolicyByRow[nRowIndex] );
	---@type boolean
	local canEdit = (tSlot ~= nil) and IsAbleToChangePolicies();

	for _,strPolicyType in ipairs( GetCategoryPolicyList(nRowIndex) ) do
		---@type table
		local tPolicy = m_kPolicyCatalogData[strPolicyType];
		do
			-- Locked policies are listed too (so the player can see what is coming) but are
			-- dimmed and non-selectable: the engine would reject slotting an unlocked policy.
			---@type boolean
			local isUnlocked = m_kUnlockedPolicies[strPolicyType] == true;
			-- Cross-category prerequisite (e.g. Sacrifice the Weak needs the Ashen Veil state
			-- religion committed). Unmet -> dim + non-selectable, same as not-yet-unlocked.
			---@type boolean
			local isPrereqMet = IsPolicyPrereqMet( strPolicyType );
			---@type boolean
			local isSelectable = isUnlocked and isPrereqMet;
			---@type table
			local inst = {};
			ContextPtr:BuildInstanceForControl( "PolicyNameItem", inst, uiStack );
			-- GetPolicyDisplayName, not tPolicy.Name: some civilizations rename a policy without
			-- otherwise changing it (Policies_AlternateNames_JNR).
			---@type string
			local strPolicyName = GetPolicyDisplayName( strPolicyType );
			inst.Name:SetText( strPolicyName );
            -- CardArt is the hover-scaled copy of the card, so it must carry the same texture.
            if isUnlocked then
                inst.Button:SetTexture(cc.PolicyTexture)
                inst.CardArt:SetTexture(cc.PolicyTexture)
            else
                inst.Button:SetTexture("Governments_LockedCard_Compact.dds");
                inst.CardArt:SetTexture("Governments_LockedCard_Compact.dds");
            end
			if not isPrereqMet then
				---@type table
				local tReq = m_kPolicyCatalogData[ POLICY_REQUIRES[strPolicyType] ];
				-- Names in the catalog are already Locale.Lookup'd; build a plain note so we
				-- don't depend on a LOC key. All current prereqs are state religions.
				inst.Name:SetToolTipString( Locale.Lookup('LOC_POLICY_LOCKED_REASON', strPolicyName, (tReq and tReq.Name or "?")));
			else
				inst.Name:SetToolTipString( strPolicyName );
			end
			inst.Name:SetAlpha( isSelectable and 1.0 or 0.45 );
			---@type boolean
			local isSelected = (strPolicyType == strSelected);
			local isCommitted = (strPolicyType == strCommitted);
			inst.Highlight:SetHide( not (isSelected and not isCommitted) );
			-- Active marker: the committed policy, hidden when is the staged selection.
			inst.Active:SetHide( not isCommitted);
			SetPolicyCardSize( inst, false );

			-- Hover grows the card (see SetPolicyCardSize) and previews the description;
			-- leaving restores both.
			inst.Button:RegisterCallback( Mouse.eMouseEnter, function()
				SetPolicyCardSize( inst, true );
                -- hovers keep unselected art, except if hovering the staged policy
				SetDescCardState( cc, strPolicyType == strSelected and strSelected ~= strCommitted, true );
				RealizeDescriptionCard( cc, strPolicyType );
			end);
			inst.Button:RegisterCallback( Mouse.eMouseExit, function()
				SetPolicyCardSize( inst, false );
				RealizeCategoryDescription( nRowIndex );
			end);

			if canEdit and isSelectable then
				inst.Button:RegisterCallback( Mouse.eLClick, function()
					OnPolicyItemClicked( nRowIndex, strPolicyType );
				end);
			else
				inst.Button:SetDisabled(true);
			end
		end
	end

	uiStack:CalculateSize();
	cc.ListScroller:CalculateSize();
	RealizeCategoryDescription( nRowIndex );
end


-- Click a government row. Governments are deliberately NOT buffered behind the Confirm button:
-- the government determines which policies are available, so it has to take effect BEFORE the
-- player picks policies. Clicking one therefore commits immediately, behind the same confirmation
-- dialogue the old government panel used (anarchy warning included).
---@param strGovType string
function OnGovernmentClicked( strGovType )
	if not IsAbleToChangeGovernment() then return; end
	if m_kUnlockedGovernments[strGovType] ~= true then return; end	-- can't pick a locked govt
	if strGovType == m_CommittedGovernment then return; end			-- re-click is a no-op

	---@type table
	local kPlayerCulture = Players[m_ePlayer]:GetCulture();
	---@type number
	local eGovernmentType = GameInfo.Governments[strGovType].Index;
	---@type number
	local iAnarchyTurns = kPlayerCulture:GetAnarchyTurns( eGovernmentType );

	---@type table
	local popup = PopupDialogInGame:new( "ConfirmGovtChange" );
	if iAnarchyTurns ~= nil and iAnarchyTurns > 0 and eGovernmentType ~= -1 then
		popup:AddText( Locale.Lookup( "LOC_GOVT_CONFIRM_ANARCHY",
			g_kGovernments[strGovType].Name, iAnarchyTurns ) );
		popup:AddConfirmButton( TXT_GOV_POPUP_YES,
			function() OnAcceptGovernmentChange( strGovType, true ); end );
	else
		popup:AddText( TXT_GOV_CONFIRM_GOVERNMENT );
		popup:AddConfirmButton( TXT_GOV_POPUP_YES,
			function() OnAcceptGovernmentChange( strGovType, false ); end );
	end
	popup:AddCancelButton( TXT_GOV_POPUP_NO, function() end );		-- nothing staged, nothing to undo
	popup:Open();

	UI.PlaySound("UI_Policies_Click_Government");
end

-- Commit the government change the player just confirmed.
--   isAnarchy = the switch drops the player into anarchy, which clears every policy slot, so the
--   screen has nothing meaningful left to show and closes (matching the old panel). Otherwise the
--   GovernmentChanged event refreshes the policy columns in place against the new government --
--   which is the entire point of committing immediately instead of buffering.
---@param strGovType string
---@param isAnarchy boolean
function OnAcceptGovernmentChange( strGovType, isAnarchy )
	UI.PlaySound("UI_Policies_Change_Government");
	---@type table
	local pPlayerCulture = Players[m_ePlayer]:GetCulture();
	if pPlayerCulture:RequestChangeGovernment( g_kGovernments[strGovType].Hash ) then
		if isAnarchy then
			g_kCurrentGovernment = nil;
			Close();
			return;
		end
		g_kCurrentGovernment = g_kGovernments[strGovType];
	end
	RefreshAllData();
end

-- Governments listbox: one selectable row per government. Active = in effect now,
-- Highlight = staged pick, Hover = mouse-over. Rows are only clickable when the player
-- may actually switch this turn (IsAbleToChangeGovernment).
function RealizeGovernmentsList()
	if FFH_EXISTS then return; end		-- no Governments column
	Controls.GovernmentListStack:DestroyAllChildren();

	---@param strGovType string
	local function TierSort( strGovType )
		---@type string
		local strTier = g_kGovernments[strGovType].Tier;
		if strTier == nil then return -math.huge; end
		return g_kGovernmentTierSorting[strTier] or -math.huge;
	end

	---@type table
	local kOrder = {};
	for strGovType,_ in pairs(g_kGovernments) do
		table.insert( kOrder, strGovType );
	end
	table.sort( kOrder, function(a,b)
		---@type number
		local sa, sb = TierSort(a), TierSort(b);
		if sa ~= sb then return sa < sb; end
		return g_kGovernments[a].Index < g_kGovernments[b].Index;
	end );

	---@type boolean
	local canChange = IsAbleToChangeGovernment();

	-- Track the tier of gov in so we can drop a divider at each new tier. Null-tier governments first with no divider.
	---@type string
	local strLastTier = nil;
	---@type number
	local nTierOrdinal = 0;

	for _,strGovType in ipairs(kOrder) do
		---@type table
		local tGov = g_kGovernments[strGovType];

		-- Segment header: entering a new tier group.
		if tGov.Tier ~= nil and tGov.Tier ~= strLastTier then
			nTierOrdinal = nTierOrdinal + 1;
			---@type table
			local divider = {};
			ContextPtr:BuildInstanceForControl( "GovernmentTierDivider", divider, Controls.GovernmentListStack );
			divider.TierLabel:SetText( Locale.ToRomanNumeral(nTierOrdinal) );
		end
		strLastTier = tGov.Tier;

		---@type table
		local inst = {};
		ContextPtr:BuildInstanceForControl( "GovernmentNameItem", inst, Controls.GovernmentListStack );
		inst.Name:SetText( Locale.ToUpper(tGov.Name) );
		inst.Name:SetToolTipString( tGov.StatsTooltip or tGov.Name );
		-- Locked governments are listed but dimmed and non-selectable: the engine would
		-- reject switching to one the player has not unlocked (m_kUnlockedGovernments).
		---@type boolean
		local isUnlocked = m_kUnlockedGovernments[strGovType] == true;
		inst.Name:SetAlpha( isUnlocked and 1.0 or 0.45 );

		-- Selection is shown by the card art itself (like the policy description card): the
		-- government actually in effect uses Governments_BackingSelected, all others Backing.
		-- There is no "staged" government any more -- clicking one commits it -- so this tracks
		-- the committed government directly. No hover/highlight overlays.
		---@type boolean
		local isStaged = (strGovType == m_CommittedGovernment);
        if isUnlocked then
            if isStaged then
                inst.Name:SetColor( COLOR_GOVT_SELECTED, 0 );
                inst.Button:SetTexture("Governments_BackingSelected_Card.dds" or "Governments_Backing_Card.dds" );
            else
                inst.Name:SetColor( COLOR_GOVT_UNSELECTED, 0 );
                inst.Button:SetTexture("Governments_Backing_Card.dds" );
            end
        else
            inst.Name:SetColor( COLOR_GOVT_UNSELECTED, 0 );
            inst.Button:SetTexture("Governments_BackingDisabled_Card.dds" );
        end
		if canChange and isUnlocked then
			inst.Button:RegisterCallback( Mouse.eLClick, function()
				OnGovernmentClicked( strGovType );
			end);
		else
			inst.Button:SetDisabled( true );
		end
	end

	Controls.GovernmentListStack:CalculateSize();
	Controls.GovernmentListScroller:CalculateSize();
end

-- Confirm button: POLICIES only. Government changes bypass it entirely (they commit straight from
-- OnGovernmentClicked), so it is shown and enabled purely on the policy staging state.
function RealizeConfirmButton()
	---@type boolean
	local canEdit = IsAbleToChangePolicies();
	Controls.ConfirmPolicies:SetHide( not canEdit );
	if not canEdit then return; end
	Controls.ConfirmPolicies:SetDisabled( not m_isPoliciesChanged );
	Controls.ConfirmPolicies:SetText( m_isPoliciesChanged and TXT_GOV_CONFIRM_POLICIES or TXT_GOV_ASSIGN_POLICIES );
end

-- Grow every category column's listbox to fit the tallest policy list (uniform height, so
-- the description cards stay aligned), then grow the modal to match.
-- LIST_MIN_H keeps it from shrinking below default.
-- Measure the tallest wrapped description among a column's policies, using the column's own
-- Desc label so WrapWidth/font match exactly. Result is cached on cc.MaxDescTextH.
-- Walks the SAME filtered list the column displays (GetCategoryPolicyList), so hidden policies
-- cannot inflate the card height.
---@param cc table
---@param nRowIndex number
function MeasureMaxDescTextH( cc, nRowIndex )
	---@type number
	local maxH = 0;
	for _,strPolicyType in ipairs( GetCategoryPolicyList(nRowIndex) ) do
		cc.Desc:SetText( m_kPolicyCatalogData[strPolicyType].Description );
		---@type number
		local h = cc.Desc:GetSizeY();
		if h > maxH then maxH = h; end
	end
	return maxH;
end

function ApplyUniformColumnHeights()
	---@type number
	local HEADER_H, SLOT_BOTTOM_PAD, DESC_GAP = 54, 22, 8;
	---@type number
	local SLOT_TOP = 40;
	---@type number
	local POINTER_FROM_SLOT_BOTTOM, LIST_MIN_H = 28, 280;
	-- Equal padding above and below the policy columns: the gap under the blue header bar and the
	-- gap above the modal's bottom edge. Both the modal height and the scroller offset derive from
	-- it, so this single number controls the vertical framing.
	---@type number
	local CONTENT_PAD_Y = 24;
	-- DescCard = a fixed top region (title + image + the offset down to the Desc label at
	-- y=DESC_TEXT_OFFSET) plus the wrapped description text plus a bottom pad.
	---@type number
	local DESC_TEXT_OFFSET, DESC_BOTTOM_PAD = 150, 16;

	-- Desc-card height needed = fixed floor, grown to fit the longest description in any column.
	---@type number
	local descCardH = DESC_TEXT_OFFSET + DESC_BOTTOM_PAD;
	---@type boolean
	local measured = false;
	for nRowIndex = 1, #ROW_SLOT_TYPES do
		---@type table
		local cc = CATEGORY_CONTROLS[nRowIndex];
		-- Re-measure when the government changes: the column's policy list is filtered by
		-- government (GetCategoryPolicyList), so a cached height from another government can be
		-- for a different set of descriptions entirely.
		if cc.MaxDescTextH == nil or cc.MaxDescGovType ~= m_CommittedGovernment then
			cc.MaxDescTextH = MeasureMaxDescTextH( cc, nRowIndex );
			cc.MaxDescGovType = m_CommittedGovernment;
			measured = true;
		end
		descCardH = math.max( descCardH, DESC_TEXT_OFFSET + cc.MaxDescTextH + DESC_BOTTOM_PAD );
	end
	if measured then	-- measuring messes content of visible Desc labels, so refresh
		for nRowIndex = 1, #ROW_SLOT_TYPES do RealizeCategoryDescription( nRowIndex ); end
	end

	---@type number
	local maxListH = LIST_MIN_H;
	for nRowIndex = 1, #ROW_SLOT_TYPES do
		---@type number
		local h = CATEGORY_CONTROLS[nRowIndex].PolicyStack:GetSizeY();
		if h > maxListH then maxListH = h; end
	end

	-- The ceiling for the whole modal. MODAL_MAX_H is a design cap, not a promise that the display
	-- can show it (1366x768 is still common), and the modal is centred, so anything taller than the
	-- screen would hang off both ends. Vignette is the full-screen consumer, so its height is the
	-- screen height.
	---@type number
	local nMaxModalH = math.min( MODAL_MAX_H, Controls.Vignette:GetSizeY() );

	-- Cap the listbox height so the whole column (header + list + gap + desc card) AND the padding
	-- above and below it fit inside nMaxModalH; past the cap the per-column lists scroll
	-- (ScrollPanel AutoScrollBar) instead. descCardH is subtracted so a taller description
	-- automatically shrinks the list rather than pushing the card out of the modal.
	---@type number
	local listH_cap = nMaxModalH - HEADER_BAR_H - (2 * CONTENT_PAD_Y)
		- HEADER_H - SLOT_BOTTOM_PAD - DESC_GAP - descCardH;
	maxListH = math.min( maxListH, math.max( listH_cap, LIST_MIN_H ) );

	---@type number
	local slotH = HEADER_H + maxListH + SLOT_BOTTOM_PAD;
	---@type number
	local rootH = SLOT_TOP + slotH + DESC_GAP + descCardH;

	for nRowIndex = 1, #ROW_SLOT_TYPES do
		---@type table
		local cc = CATEGORY_CONTROLS[nRowIndex];
		cc.ListScroller:SetSizeY( maxListH );
		cc.ListScroller:CalculateSize();		-- reclamp the scrollbar to the new viewport
--		cc.Slot:SetSizeY( slotH );
--		cc.Pointer:SetOffsetY( slotH - POINTER_FROM_SLOT_BOTTOM );
--		cc.DescCard:SetOffsetY( SLOT_TOP + slotH + DESC_GAP );
--		cc.DescCard:SetSizeY( descCardH );		-- fit the card to the description (no clip/overlap)
		cc.Root:SetSizeY( rootH );
	end

	-- Grow the modal to the column content. It is NOT a fixed 768 any more: rootH is driven by the
	-- longest description, and nothing previously bounded it to the container, so tall cards simply
	-- overflowed the bottom edge.
	--
	-- A column's Root carries SLOT_TOP of empty space above its blue Slot art, so the VISIBLE
	-- content runs from (nTop + SLOT_TOP) down to (nTop + rootH) -- that is (rootH - SLOT_TOP) tall:
	--     nModalH = HEADER_BAR_H + CONTENT_PAD_Y + (rootH - SLOT_TOP) + CONTENT_PAD_Y
	-- listH_cap above guarantees this lands within MODAL_MAX_H except in the degenerate case where
	-- LIST_MIN_H forces the list taller than the cap allows, hence the min().
	---@type number
	local nModalH = math.min( nMaxModalH,
		HEADER_BAR_H + (2 * CONTENT_PAD_Y) + rootH - SLOT_TOP );
	Controls.MainContainer:SetSizeY( nModalH );

	-- Vertical framing: balance the gap under the header bar against the gap above the bottom edge.
	--     gapTop    = (nTop + SLOT_TOP) - HEADER_BAR_H
	--     gapBottom = nModalH - (nTop + rootH)
	-- Setting those equal and solving gives the expression below, which resolves to exactly
	-- CONTENT_PAD_Y whenever nModalH was not clamped. The floor is (HEADER_BAR_H - SLOT_TOP), not
	-- HEADER_BAR_H: it is the VISIBLE top (nTop + SLOT_TOP) that must clear the header bar, and
	-- clamping nTop itself to HEADER_BAR_H would override the balanced value and push the columns
	-- down by a whole SLOT_TOP.
	---@type number
	local nTop = math.max( 0, HEADER_BAR_H - SLOT_TOP,
		math.floor( (nModalH - rootH + HEADER_BAR_H - SLOT_TOP) / 2 ) );
	Controls.ColumnsScroller:SetOffsetY( nTop );
	Controls.ColumnsScroller:SetSizeY( math.max( nModalH - nTop, rootH ) );

	-- Government column: bottom-align the list and the Confirm button so the TOP of the column
	-- stays free for options. Done here rather than in RealizeGovernmentsList because the
	-- alignment depends on rootH, which is only known once every policy column is measured.
	if not Controls.GovernmentColumn:IsHidden() then
		---@type number
		local CONFIRM_H, CONFIRM_GAP, LIST_PAD = 41, 8, 8;
		-- Match the policy columns' bottom gap, so the Confirm button and the bottom of the
		-- government list line up with the bottom of the description cards.
		---@type number
		local nGapBottom = math.max( 0, nModalH - (nTop + rootH) );
		Controls.ConfirmPolicies:SetOffsetY( nGapBottom );
		Controls.GovernmentSlot:SetOffsetY( nGapBottom + CONFIRM_H + CONFIRM_GAP );
		-- Grow the list box UPWARD off the button to fit its content, never past the header bar.
		---@type number
		local nMaxListH = (nTop + rootH) - HEADER_BAR_H - CONFIRM_H - CONFIRM_GAP;
		---@type number
		local nListH = math.min( Controls.GovernmentListStack:GetSizeY() + LIST_PAD, nMaxListH );
		Controls.GovernmentSlot:SetSizeY( math.max( nListH, 0 ) );
		Controls.GovernmentListScroller:CalculateSize();		-- reclamp to the new viewport
	end

	Controls.MainColumns:CalculateSize();
end

-- Rebuild the whole screen from the staged model.
function RealizeAll()
	RealizeGovernmentsList();
	for nRowIndex = 1, #ROW_SLOT_TYPES do
		RealizeCategoryList( nRowIndex );
	end
	RealizeConfirmButton();
	ApplyUniformColumnHeights();			-- fit columns to the tallest list + grow the modal
	Controls.MainColumns:CalculateSize();	-- re-center the column stack after (re)building
end
