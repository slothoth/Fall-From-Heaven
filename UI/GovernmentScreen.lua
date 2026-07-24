-- Copyright 2018, Firaxis Games

include("InstanceManager");
include("SupportFunctions");	-- Clamp
include("TabSupport");
include("Civ6Common");
include("PopupDialog");
include("ModalScreen_PlayerYieldsHelper");
include("GameCapabilities");
include("GovernmentScreen_Model");
print('')

-- ===========================================================================
--	CONSTANTS	/ DEFINES
-- ===========================================================================

-- Toggle these based on the game engine rules.
---@type boolean
local m_isLocalPlayerTurn = true;

---@type table
local SCREEN_ENUMS = { MY_GOVERNMENT	= 1, GOVERNMENTS		= 2, POLICIES		= 3 }
local SIZE_MIN_SPEC_X = 1024;
-- Hard caps on how big the modal may grow. Past these, the columns scroll horizontally and
-- the per-column policy lists scroll vertically instead of the modal expanding further.
---@type number
local MODAL_MAX_W = 1860;
---@type number
local MODAL_MAX_H = 900;
---@type string
local TXT_GOV_ASSIGN_POLICIES = Locale.Lookup("LOC_GOVT_ASSIGN_ALL_POLICIES");
---@type string
local TXT_GOV_CONFIRM_POLICIES = Locale.Lookup("LOC_GOVT_CONFIRM_POLICIES");
---@type string
local TXT_GOV_POPUP_PROMPT_POLICIES_CLOSE = Locale.Lookup("LOC_GOVT_POPUP_PROMPT_POLICIES_CLOSE");
---@type string
local TXT_GOV_POPUP_PROMPT_POLICIES_CONFIRM = Locale.Lookup("LOC_GOVT_POPUP_PROMPT_POLICIES_CONFIRM");



---@type number
local COLOR_GOVT_UNSELECTED	= UI.GetColorValueFromHexLiteral(0xffe9dfc7); -- Background for unselected background (or forground text color on non-selected).
---@type number
local COLOR_GOVT_SELECTED	= UI.GetColorValueFromHexLiteral(0xff261407); -- Background for selected background (or forground text color on non-selected).

g_isMyGovtTabDirty = false;
g_isGovtTabDirty = false;
g_isPoliciesTabDirty = false;

-- ===========================================================================
--	VARIABLES
-- ===========================================================================

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


-- ===========================================================================
--	FUNCTIONS
-- ===========================================================================




-- ===========================================================================
-- Separated into its own function so we wan modify icons in DLC / Expansions
-- ===========================================================================
function GetPolicyBGTexture(policyType)
	-- return PICS_SLOT_TYPE_CARD_BGS[GameInfo.Policies[policyType].GovernmentSlotType];
    return 'GOVERNMENT_AUTOCRACY'
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
		m_isGovernmentChanged	= false;
		LuaEvents.Government_CloseGovernment();
	end
end

function OnClose()
	Close();
end

function OnCloseFromLaunchBar()
	Close();
end

-- ===========================================================================
--	UI Button Callback
--	Solidify the policies which are slotted.
-- ===========================================================================
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

		-- Commit a staged government change through the same button. RequestChangeGovernment
		-- may put the player into anarchy (which itself clears policy slots); the player was
		-- warned in the confirm prompt below.
		if m_isGovernmentChanged and m_StagedGovernment ~= nil
				and m_StagedGovernment ~= m_CommittedGovernment then
			---@type table
			local tGov = g_kGovernments[m_StagedGovernment];
			if tGov ~= nil then
				pPlayerCulture:RequestChangeGovernment( tGov.Hash );
			end
		end

		m_isPoliciesChanged	= false;
		m_isGovernmentChanged = false;
		Controls.ConfirmPolicies:SetDisabled( true );
		Close();
	end

	if(ShouldConfirmChanges())then
		---@type table
		local popup = PopupDialogInGame:new( "ConfirmPolicies" );
		---@type string
		local strPrompt = TXT_GOV_POPUP_PROMPT_POLICIES_CONFIRM;
		-- A staged government change that causes anarchy gets the explicit anarchy warning.
		if m_isGovernmentChanged and m_StagedGovernment ~= nil
				and m_StagedGovernment ~= m_CommittedGovernment then
			---@type number
			local eGovIndex = GameInfo.Governments[m_StagedGovernment].Index;
			---@type number
			local iAnarchyTurns = Players[m_ePlayer]:GetCulture():GetAnarchyTurns( eGovIndex );
			if iAnarchyTurns ~= nil and iAnarchyTurns > 0 then
				strPrompt = Locale.Lookup( "LOC_GOVT_CONFIRM_ANARCHY",
					g_kGovernments[m_StagedGovernment].Name, iAnarchyTurns );
			end
		end
		popup:ShowYesNoDialog(strPrompt, OnConfirmPolicies_Yes);
	else
		OnConfirmPolicies_Yes();
	end
end

-- ===========================================================================
--	LUA Event
--	Called to first open the page.          TODO: This doesnt make sense with a single government screen.
-- ===========================================================================
function OnOpenGovernmentScreenMyGovernment()
	RefreshAllData();
	-- Open governments screen by default if player has to select a government
	if not g_kCurrentGovernment then
		OnOpenGovernmentScreen( SCREEN_ENUMS.GOVERNMENTS );
	else
		OnOpenGovernmentScreen( SCREEN_ENUMS.MY_GOVERNMENT );
	end
end

-- ===========================================================================
--	LUA Event
--	Called to first open the page.
-- ===========================================================================
function OnOpenGovernmentScreenGovernments()
	RefreshAllData();
	OnOpenGovernmentScreen( SCREEN_ENUMS.GOVERNMENTS );
end

-- ===========================================================================
--	LUA Event
--	Called to first open the page.
-- ===========================================================================
function OnOpenGovernmentScreenPolicies()
	RefreshAllData();
	if not g_kCurrentGovernment then
		OnOpenGovernmentScreen( SCREEN_ENUMS.GOVERNMENTS );
	else
		OnOpenGovernmentScreen( SCREEN_ENUMS.POLICIES );
	end
end

-- ===========================================================================
--	LUA Event / DEPRECATED To be called directly (use an open that references the specific screen to see)
--	Called to first open the page.
-- ===========================================================================
---@param screenEnum number
function OnOpenGovernmentScreen( screenEnum )
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
		-- From Civ6_styles: FullScreenVignetteConsumer
		Controls.ScreenAnimIn:SetToBeginning();
		Controls.ScreenAnimIn:Play();
		RealizeAll();

		-- Queue the screen as a popup, but we want it to render at a desired location in the hierarchy, not on top of everything.
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
	-- From ModalScreen_PlayerYieldsHelper
	if not RefreshYields() then
		Controls.Vignette:SetSizeY(m_TopPanelConsideredHeight);
	end
	g_isMyGovtTabDirty = true;
	g_isGovtTabDirty = true;
	g_isPoliciesTabDirty = true;
end

-- ===========================================================================
--	Game Engine Event
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

-- ===========================================================================
--	Game Engine Event
-- ===========================================================================
---@param playerID number
function OnGovernmentPolicyChanged( playerID )
	if ContextPtr:IsVisible() and playerID == m_ePlayer then
		RefreshAllData();
	end
end

-- ===========================================================================
--	Game Engine Event
-- ===========================================================================
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

-- ===========================================================================
function OnCivicsUnlocked()
	if ContextPtr:IsHidden() then return; end		-- Autoplay!
	RefreshAllData();
end

-- ===========================================================================
--	Game Engine Event
-- ===========================================================================
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

-- ===========================================================================
--	Game Engine Event
-- ===========================================================================
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

-- ===========================================================================
function LateInitialize()
	m_TopPanelConsideredHeight = Controls.Vignette:GetSizeY() - TOP_PANEL_OFFSET;

	PopulateStaticData();			-- Obtain unchanging, static data from game core
	BuildCategoryColumns();			-- Build the 5 category columns from the shared instance

	m_ePlayer = Game.GetLocalPlayer();
end

-- ===========================================================================
--	UI Event
-- ===========================================================================
---@param isReload boolean
function OnInit( isReload )
	LateInitialize();
	if isReload then
		LuaEvents.GameDebug_GetValues( "GovernmentScreen" );
	end
end

-- ===========================================================================
--	UI EVENT
-- ===========================================================================
function OnShutdown()
	-- Clear Lua Events
	LuaEvents.LaunchBar_CloseGovernmentPanel.Remove( OnCloseFromLaunchBar );
	LuaEvents.GameDebug_Return.Remove( OnGameDebugReturn );
	LuaEvents.NotificationPanel_GovernmentOpenGovernments.Remove( OnOpenGovernmentScreenGovernments );
	LuaEvents.NotificationPanel_GovernmentOpenPolicies.Remove( OnOpenGovernmentScreenPolicies );
	LuaEvents.LaunchBar_GovernmentOpenMyGovernment.Remove( OnOpenGovernmentScreenMyGovernment );
	LuaEvents.LaunchBar_GovernmentOpenGovernments.Remove( OnOpenGovernmentScreenGovernments );
	LuaEvents.TechCivicCompletedPopup_GovernmentOpenGovernments.Remove( OnOpenGovernmentScreenGovernments );
	LuaEvents.TechCivicCompletedPopup_GovernmentOpenPolicies.Remove( OnOpenGovernmentScreenPolicies );
	LuaEvents.Advisor_GovernmentOpenPolicies.Remove( OnOpenGovernmentScreenPolicies );

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
	LuaEvents.LaunchBar_CloseGovernmentPanel.Add( OnCloseFromLaunchBar );
	LuaEvents.GameDebug_Return.Add( OnGameDebugReturn );
	LuaEvents.NotificationPanel_GovernmentOpenGovernments.Add( OnOpenGovernmentScreenGovernments );
	LuaEvents.NotificationPanel_GovernmentOpenPolicies.Add( OnOpenGovernmentScreenPolicies );
	LuaEvents.LaunchBar_GovernmentOpenMyGovernment.Add( OnOpenGovernmentScreenMyGovernment );
	LuaEvents.LaunchBar_GovernmentOpenGovernments.Add( OnOpenGovernmentScreenGovernments );
	LuaEvents.TechCivicCompletedPopup_GovernmentOpenGovernments.Add( OnOpenGovernmentScreenGovernments );
	LuaEvents.TechCivicCompletedPopup_GovernmentOpenPolicies.Add( OnOpenGovernmentScreenPolicies );
	LuaEvents.Advisor_GovernmentOpenPolicies.Add( OnOpenGovernmentScreenPolicies );
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
	[0] = { PolicyTexture="Governments_EconomicCard_Compact.dds",   Watermark="Governments_WatermarkEconomic", WatermarkOffsetY=265, WatermarkSizeX=185, WatermarkSizeY=62 },
	[1] = { PolicyTexture="Governments_MilitaryCard_Compact.dds",   Watermark="Governments_WatermarkMilitary", WatermarkOffsetY=275, WatermarkSizeX=185, WatermarkSizeY=62 },
	[2] = { PolicyTexture="Governments_DiplomaticCard_Compact.dds", Watermark="Governments_WatermarkDiplo",    WatermarkOffsetY=255, WatermarkSizeX=185, WatermarkSizeY=82 },
	[3] = { PolicyTexture="Governments_GreatPersonCard_Compact.dds", Watermark="Governments_WatermarkDiplo",    WatermarkOffsetY=255, WatermarkSizeX=185, WatermarkSizeY=82 },
    [4] = { PolicyTexture="Governments_LaborCard_Compact.dds",      Watermark="Governments_WatermarkWildcard", WatermarkOffsetY=250, WatermarkSizeX=185, WatermarkSizeY=81 },
	[5] = { PolicyTexture="Governments_ReligiousCard_Compact.dds",  Watermark="Governments_WatermarkWildcard", WatermarkOffsetY=275, WatermarkSizeX=185, WatermarkSizeY=62 },
	[6] = { PolicyTexture="Governments_AdminCard_Compact.dds",  Watermark="Governments_WatermarkWildcard", WatermarkOffsetY=275, WatermarkSizeX=185, WatermarkSizeY=62 },
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
		inst.Watermark:SetTexture( def.Watermark );
		inst.Watermark:SetSizeVal( def.WatermarkSizeX, def.WatermarkSizeY );
		inst.Watermark:SetOffsetVal( 0, def.WatermarkOffsetY );
		inst.titleKey = slot.Name;				-- slot's own display name (a LOC key)
		inst.PolicyTexture = def.PolicyTexture;	-- consumed by RealizeCategoryList
		CATEGORY_CONTROLS[nRowIndex] = inst;
		end
	end

	-- Width the modal to fit the generated columns (government + N categories), capped at
	-- MODAL_MAX_W. Past the cap the ColumnsScroller keeps its capped width and the columns
	-- scroll horizontally. 50 = frame margin (~25px each side). Measure the stack rather than
	-- recomputing by hand.
	Controls.MainColumns:CalculateSize();
	---@type number
	local MARGIN_X = 50;
	---@type number
	local innerW = math.min( Controls.MainColumns:GetSizeX(), MODAL_MAX_W - MARGIN_X );
	Controls.ColumnsScroller:SetSizeX( innerW );
	Controls.MainContainer:SetSizeX( innerW + MARGIN_X );
end








-- Show the description for the category's currently-staged policy (or blank).
-- Fill a category's description card (title / image / text) for a given policy.
-- Uses the base slot-type card art for now; swap to per-policy art later.
---@param cc table
---@param strPolicyType string
function RealizeDescriptionCard( cc, strPolicyType )
	---@type table
	local tPolicy = m_kPolicyCatalogData[strPolicyType];
	cc.DescTitle:SetText( tPolicy.Name );
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
function SetDescCardState( cc, isProposed )
	cc.DescCard:SetTexture( isProposed
		and "Governments_BackingSelected" or "Governments_Backing" );
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
	local strSelected = tSlot and tSlot.GC_PolicyType or EMPTY_POLICY_TYPE;
	---@type string
	local strCommitted = m_CommittedPolicyByRow[nRowIndex] or EMPTY_POLICY_TYPE;
	SetDescCardState( cc, strSelected ~= strCommitted );
	if strSelected ~= EMPTY_POLICY_TYPE and m_kPolicyCatalogData[strSelected] ~= nil then
		RealizeDescriptionCard( cc, strSelected );
	else
		-- Empty slot (nothing staged, e.g. bumped off a policy by a prerequisite change).
		-- Show a clear "Unselected Policy" state but keep the card image as a populated card
		-- would (GetPolicyBGTexture is the same call the filled branch uses), not blanked.
		cc.DescTitle:SetText( "Unselected Policy" );
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
	local strSelected = tSlot and tSlot.GC_PolicyType or EMPTY_POLICY_TYPE;
	---@type string
	local strCommitted = m_CommittedPolicyByRow[nRowIndex] or EMPTY_POLICY_TYPE;
	---@type string
	local strSlotType = ROW_SLOT_TYPES[nRowIndex];
	---@type boolean
	local canEdit = (tSlot ~= nil) and IsAbleToChangePolicies();

	for _,strPolicyType in ipairs(m_kPolicyCatalogOrder) do
		---@type table
		local tPolicy = m_kPolicyCatalogData[strPolicyType];
		if tPolicy.SlotType == strSlotType then
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
			inst.Name:SetText( tPolicy.Name );
            if isUnlocked then
                inst.Button:SetTexture(cc.PolicyTexture)
            else
                inst.Button:SetTexture("Governments_LockedCard_Compact.dds");
            end
			if not isPrereqMet then
				---@type table
				local tReq = m_kPolicyCatalogData[ POLICY_REQUIRES[strPolicyType] ];
				-- Names in the catalog are already Locale.Lookup'd; build a plain note so we
				-- don't depend on a LOC key. All current prereqs are state religions.
				inst.Name:SetToolTipString( tPolicy.Name .. "[NEWLINE][COLOR_RED]"
					.. "Requires: " .. (tReq and tReq.Name or "?") .. "[ENDCOLOR]" );
			else
				inst.Name:SetToolTipString( tPolicy.Name );
			end
			inst.Name:SetAlpha( isSelectable and 1.0 or 0.45 );
			---@type boolean
			local isSelected = (strPolicyType == strSelected);
			inst.Highlight:SetHide( not isSelected );
			-- Active marker: the committed policy, hidden when it IS the staged selection.
			inst.Active:SetHide( not (strPolicyType == strCommitted and not isSelected) );
			inst.Hover:SetHide( true );

			-- Hover previews the description; leaving reverts to the staged selection.
			inst.Button:RegisterCallback( Mouse.eMouseEnter, function()
				inst.Hover:SetHide(false);
				-- A hover is a preview, not a proposal -> unselected art. EXCEPT when hovering
				-- the staged policy itself: there the card keeps its true state, so it does not
				-- flip back to "unselected" as you mouse over your own pending choice.
				SetDescCardState( cc, strPolicyType == strSelected and strSelected ~= strCommitted );
				RealizeDescriptionCard( cc, strPolicyType );
			end);
			inst.Button:RegisterCallback( Mouse.eMouseExit, function()
				inst.Hover:SetHide(true);
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


-- Click a government row: stage it (commit happens via the shared Confirm button).
---@param strGovType string
function OnGovernmentClicked( strGovType )
	if not IsAbleToChangeGovernment() then return; end
	if m_kUnlockedGovernments[strGovType] ~= true then return; end	-- can't stage a locked govt
	if m_StagedGovernment == strGovType then return; end	-- re-click is a no-op
	m_StagedGovernment = strGovType;
	m_isGovernmentChanged = (strGovType ~= m_CommittedGovernment);
	UI.PlaySound("UI_Policies_Click_Government");
	RealizeGovernmentsList();
	RealizeConfirmButton();
end

-- Governments listbox: one selectable row per government. Active = in effect now,
-- Highlight = staged pick, Hover = mouse-over. Rows are only clickable when the player
-- may actually switch this turn (IsAbleToChangeGovernment).
function RealizeGovernmentsList()
	Controls.GovernmentListStack:DestroyAllChildren();

	-- Sort key for a government's tier: nil tier -> top (-inf); otherwise the tier's
	-- Sorting from GovernmentTiers. Governments in the same tier stay contiguous, then
	-- tie-break by row Index so the segmentation below is clean.
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

	-- Track the tier we are in so we can drop a divider at each new (non-nil) tier. Null-tier
	-- governments sit at the very top with no divider.
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

		-- Selection is shown by the card art itself (like the policy description card):
		-- the staged government uses Governments_BackingSelected, all others Backing.
		-- No hover/highlight overlays.
		---@type boolean
		local isStaged = (strGovType == m_StagedGovernment);
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

-- Confirm button: visible when the player may change policies OR government, enabled only
-- when either is actually staged. One button commits both (see OnConfirmPolicies_Yes).
function RealizeConfirmButton()
	---@type boolean
	local canEdit = IsAbleToChangePolicies() or IsAbleToChangeGovernment();
	Controls.ConfirmPolicies:SetHide( not canEdit );
	if not canEdit then return; end
	---@type boolean
	local hasChanges = m_isPoliciesChanged or m_isGovernmentChanged;
	Controls.ConfirmPolicies:SetDisabled( not hasChanges );
	Controls.ConfirmPolicies:SetText( hasChanges and TXT_GOV_CONFIRM_POLICIES or TXT_GOV_ASSIGN_POLICIES );
end

-- Grow every category column's listbox to fit the tallest policy list (uniform height, so
-- the description cards stay aligned), then grow the modal to match. Call AFTER all lists are
-- realized so their stacks have measured. Geometry constants mirror the PolicyCategoryColumn
-- instance: listbox starts at y=54, has 22px of frame below it; the desc card follows 8px
-- under the slot. LIST_MIN_H keeps it from shrinking below the authored default.
function ApplyUniformColumnHeights()
	---@type number
	local HEADER_H, SLOT_BOTTOM_PAD, DESC_GAP, DESC_CARD_H = 54, 22, 8, 300;
	---@type number
	local POINTER_FROM_SLOT_BOTTOM, MODAL_MARGIN_Y, LIST_MIN_H = 28, 56, 280;

	---@type number
	local maxListH = LIST_MIN_H;
	for nRowIndex = 1, #ROW_SLOT_TYPES do
		---@type number
		local h = CATEGORY_CONTROLS[nRowIndex].PolicyStack:GetSizeY();
		if h > maxListH then maxListH = h; end
	end

	-- Cap the listbox height so the modal never grows past MODAL_MAX_H; past the cap the
	-- per-column lists scroll (ScrollPanel AutoScrollBar) instead. The cap is whatever list
	-- height leaves the rest of the column (header/footer/gap/desc card) + margin within the max.
	---@type number
	local listH_cap = MODAL_MAX_H - MODAL_MARGIN_Y - DESC_GAP - DESC_CARD_H - HEADER_H - SLOT_BOTTOM_PAD;
	maxListH = math.min( maxListH, math.max( listH_cap, LIST_MIN_H ) );

	---@type number
	local slotH = HEADER_H + maxListH + SLOT_BOTTOM_PAD;
	---@type number
	local rootH = slotH + DESC_GAP + DESC_CARD_H;

	for nRowIndex = 1, #ROW_SLOT_TYPES do
		---@type table
		local cc = CATEGORY_CONTROLS[nRowIndex];
		cc.ListScroller:SetSizeY( maxListH );
		cc.ListScroller:CalculateSize();		-- reclamp the scrollbar to the new viewport
		cc.Slot:SetSizeY( slotH );
		cc.Pointer:SetOffsetY( slotH - POINTER_FROM_SLOT_BOTTOM );
		cc.DescCard:SetOffsetY( slotH + DESC_GAP );
		cc.Root:SetSizeY( rootH );
	end

	-- Keep the government column (and its bottom-anchored Confirm button) the same height.
	Controls.GovernmentColumn:SetSizeY( rootH );

	-- Grow the modal to the tallest column (MainColumns:GetSizeY() is the max child height),
	-- capped via maxListH above. The scroll panel wrapping the columns matches that height.
	Controls.MainColumns:CalculateSize();
	---@type number
	local contentH = Controls.MainColumns:GetSizeY();
	Controls.ColumnsScroller:SetSizeY( contentH );
	Controls.MainContainer:SetSizeY( contentH + MODAL_MARGIN_Y );
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
