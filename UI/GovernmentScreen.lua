-- Copyright 2018, Firaxis Games

include("InstanceManager");
include("SupportFunctions");	-- Clamp
include("TabSupport");
include("Civ6Common");
include("PopupDialog");
include("ModalScreen_PlayerYieldsHelper");
include("GameCapabilities");
print('')
-- ===========================================================================
--	DEBUG
--	Toggle these for temporary debugging help.
-- ===========================================================================
---@type boolean
local m_debugShowAllPolicies = false;		-- (false) When true all policy cards (despite player's progression) will be shown in the catalog
---@type boolean
local m_debugOutputGovInfo = false;		-- (false) Output to console information about governments

-- ===========================================================================
--	CONSTANTS	/ DEFINES
-- ===========================================================================

-- Toggle these based on the game engine rules.
---@type boolean
local m_isLocalPlayerTurn = true;

---@type string
local DATA_FIELD_CURRENT_FILTER = "_CURRENT_FILTER";

---@type table
local ROW_INDEX = {
	MILITARY = 1,
	ECONOMIC = 2,
	DIPLOMAT = 3, -- yes this is to make the names line up. also required for matching with gamecore.
	SLTHCUL = 4,
	SLTHREL = 5,
};
---@type table
local ROW_SLOT_TYPES = {};
	ROW_SLOT_TYPES[ROW_INDEX.MILITARY]	= "SLOT_MILITARY";
	ROW_SLOT_TYPES[ROW_INDEX.ECONOMIC]	= "SLOT_ECONOMIC";
	ROW_SLOT_TYPES[ROW_INDEX.DIPLOMAT]	= "SLOT_DIPLOMATIC";
	ROW_SLOT_TYPES[ROW_INDEX.SLTHCUL]	= "SLOT_SLTHCUL";
	ROW_SLOT_TYPES[ROW_INDEX.SLTHREL]	= "SLOT_SLTHREL";
---@type table
local SLOT_ORDER_IN_CATALOG = {
	SLOT_MILITARY		= 1,
	SLOT_ECONOMIC		= 2,
	SLOT_DIPLOMATIC		= 3,
	SLOT_GREAT_PERSON	= 4,
	SLOT_SLTHCUL		= 5,
	SLOT_SLTHREL		= 6,
};

---@type string
local EMPTY_POLICY_TYPE = "empty";					-- For a policy slot without a type
---@type string
local PIC_CARD_TYPE_DIPLOMACY = "Governments_DiplomacyCard";
---@type string
local PIC_CARD_TYPE_ECONOMIC = "Governments_EconomicCard";
---@type string
local PIC_CARD_TYPE_MILITARY = "Governments_MilitaryCard";
---@type string
local PIC_CARD_TYPE_SLTHCUL = "Governments_WildcardCard";
---@type string
local PIC_CARD_TYPE_SLTHREL = "Governments_DarkCard";
local PICS_SLOT_TYPE_CARD_BGS  = {
	SLOT_MILITARY		= PIC_CARD_TYPE_MILITARY,
	SLOT_ECONOMIC		= PIC_CARD_TYPE_ECONOMIC,
	SLOT_DIPLOMATIC		= PIC_CARD_TYPE_DIPLOMACY,
	SLOT_SLTHCUL		= PIC_CARD_TYPE_SLTHCUL,
	SLOT_GREAT_PERSON	= PIC_CARD_TYPE_SLTHCUL, -- Great person is also utilized as a wild card.
	SLOT_SLTHREL		= PIC_CARD_TYPE_SLTHREL,		-- same as diplo
};

---@type table
local IMG_POLICYCARD_BY_ROWIDX = {};
	IMG_POLICYCARD_BY_ROWIDX[ROW_INDEX.MILITARY] = PIC_CARD_TYPE_MILITARY;
	IMG_POLICYCARD_BY_ROWIDX[ROW_INDEX.ECONOMIC] = PIC_CARD_TYPE_ECONOMIC;
	IMG_POLICYCARD_BY_ROWIDX[ROW_INDEX.DIPLOMAT] = PIC_CARD_TYPE_DIPLOMACY;
	IMG_POLICYCARD_BY_ROWIDX[ROW_INDEX.SLTHCUL] = PIC_CARD_TYPE_SLTHCUL;
	IMG_POLICYCARD_BY_ROWIDX[ROW_INDEX.SLTHREL] = PIC_CARD_TYPE_DIPLOMACY;
---@type table
local SCREEN_ENUMS = {
		MY_GOVERNMENT	= 1,
		GOVERNMENTS		= 2,
		POLICIES		= 3
}
local SIZE_MIN_SPEC_X = 1024;
---@type string
local TXT_GOV_ASSIGN_POLICIES = Locale.Lookup("LOC_GOVT_ASSIGN_ALL_POLICIES");
---@type string
local TXT_GOV_CONFIRM_POLICIES = Locale.Lookup("LOC_GOVT_CONFIRM_POLICIES");
---@type string
local TXT_GOV_POPUP_PROMPT_POLICIES_CLOSE = Locale.Lookup("LOC_GOVT_POPUP_PROMPT_POLICIES_CLOSE");
---@type string
local TXT_GOV_POPUP_PROMPT_POLICIES_CONFIRM = Locale.Lookup("LOC_GOVT_POPUP_PROMPT_POLICIES_CONFIRM");

-- Cross-category policy prerequisites (UI-side gate). A dependent policy may only be
-- staged while its required policy is BOTH committed (active in gamecore now) AND still
-- staged in its slot. This mirrors the gameplay bans in Core/Governments.sql, which are
-- capital-plot-property based and therefore lag a turn: the engine will not grant a
-- dependent in the same RequestPolicyChanges batch that first slots its prerequisite,
-- and it auto-drops a dependent once the prerequisite is removed. Enforcing it here stops
-- the player staging a change the engine would silently reject. See [[civ6-state-religion-bans]].
-- (Single level only -- religion -> economic; nothing depends on the economic policies.)
---@type table
local POLICY_REQUIRES = {
	["SLTH_POLICY_SACRIFICE_THE_WEAK"] = "SLTH_POLICY_STATE_VEIL",
	["SLTH_POLICY_GUARDIAN_OF_NATURE"] = "SLTH_POLICY_STATE_LEAVES",
	["SLTH_POLICY_ARETE"]              = "SLTH_POLICY_STATE_RUNES",
	["SLTH_POLICY_SOCIAL_ORDER"]       = "SLTH_POLICY_STATE_ORDER",
};

---@type number
local COLOR_GOVT_UNSELECTED	= UI.GetColorValueFromHexLiteral(0xffe9dfc7); -- Background for unselected background (or forground text color on non-selected).
---@type number
local COLOR_GOVT_SELECTED	= UI.GetColorValueFromHexLiteral(0xff261407); -- Background for selected background (or forground text color on non-selected).
---@type number
local COLOR_GOVT_LOCKED		= UI.GetColorValueFromHexLiteral(0xffAAAAAA)

-- ===========================================================================
--	GLOBALS
-- ===========================================================================
g_kGovernments = {};
g_kCurrentGovernment = nil;
g_isMyGovtTabDirty = false;
g_isGovtTabDirty = false;
g_isPoliciesTabDirty = false;
m_kUnlockedPolicies = nil;
m_kNewPoliciesThisTurn = nil;

-- ===========================================================================
--	VARIABLES
-- ===========================================================================

---@type number
local m_TopPanelConsideredHeight = 0;
---@type table
local m_policyCardIM = InstanceManager:new("PolicyCard",					"Content",	Controls.PolicyCatalog);
m_policyCardTypeIM = {}
m_policyCardTypeIM['SLOT_MILITARY'] = InstanceManager:new("PolicyCard",					"Content",	Controls.PolicyCatalogLabor);
m_policyCardTypeIM['SLOT_ECONOMIC'] = InstanceManager:new("PolicyCard",					"Content",	Controls.PolicyCatalogEconomy);
m_policyCardTypeIM['SLOT_DIPLOMATIC'] = InstanceManager:new("PolicyCard",					"Content",	Controls.PolicyCatalogGovernment);
m_policyCardTypeIM['SLOT_SLTHCUL'] = InstanceManager:new("PolicyCard",					"Content",	Controls.PolicyCatalogCultural);
m_policyCardTypeIM['SLOT_SLTHREL'] = InstanceManager:new("PolicyCard",					"Content",	Controls.PolicyCatalogReligion);

---@type number
local m_ePlayer	= -1;
---@type table
local m_kAllPlayerData  = {};		-- Holds copy of player data for all local players
---@type table
local m_kBonuses	= {}
---@type string
local m_governmentChangeType = "";		-- The government type proposed being changed to.
---@type boolean
local m_isPoliciesChanged= false;
---@type string
local m_CommittedGovernment = nil;		-- Government actually in effect, snapshotted on refresh.
---@type string
local m_StagedGovernment = nil;			-- Government the player has staged (defaults to committed).
---@type boolean
local m_isGovernmentChanged = false;	-- A different government is staged, awaiting Confirm.
---@type table
local m_kPolicyCatalogData	= {};
---@type table
local m_kPolicyCatalogOrder  = {};		-- Track order of policies to display
---@type table
local m_kPolicyFilterCurrent	= nil;
---@type table
local m_kUnlockedGovernments  = {};
---@type string
local m_currentCivicType	= nil;
---@type number
local m_civicProgress = 0;
---@type number
local m_civicCost	= 0;

-- An array of arrays of tables. Contains one entry for each member of ROW_INDEX.
-- m_ActivePolicyRows[ROW_INDEX.MILITARY] is an array of all the slots for the Military row.
-- Each slot is a "SlotData" table containing UI_RowIndex, GC_SlotIndex, and GC_PolicyType.
-- UI_RowIndex is a value from ROW_INDEX matching the row this slot is in. This should not change.
-- GC_SlotIndex is the corresponding GameCore slot index for this slot. This should not change.
-- GC_PolicyType is the string type of the policy card currently in the slot. It is EMPTY_POLICY_TYPE by default.
---@type table
local m_ActivePolicyRows = {};
---@type table
local m_ActivePoliciesByType = {}; -- PolicyType string -> SlotData table
---@type table
local m_ActivePoliciesBySlot = {}; -- (GC Slot Index + 1) -> SlotData table

-- ===========================================================================
--	FUNCTIONS
-- ===========================================================================

---@param nSlotIndex number
function RemoveActivePolicyAtSlotIndex( nSlotIndex )
	---@type table
	local tSlotData = m_ActivePoliciesBySlot[nSlotIndex+1];
	assert( tSlotData );
	m_ActivePoliciesByType[tSlotData.GC_PolicyType] = nil;
	tSlotData.GC_PolicyType = EMPTY_POLICY_TYPE;
	m_isPoliciesChanged = true;
end
---@param nSlotIndex number
---@param strPolicyType string
function SetActivePolicyAtSlotIndex( nSlotIndex, strPolicyType )
	---@type table
	local tSlotData = m_ActivePoliciesBySlot[nSlotIndex+1];
	assert( tSlotData );
	m_ActivePoliciesByType[strPolicyType] = tSlotData;
	m_ActivePoliciesByType[tSlotData.GC_PolicyType] = nil;
	tSlotData.GC_PolicyType = strPolicyType;
	m_isPoliciesChanged = true;
end

-- ===========================================================================
--	Whether or not a player can swap policies around for the current government
--	RETURNS:	true/false
-- ===========================================================================
function IsAbleToChangePolicies()
	if m_ePlayer == -1 then
		return false;
	end
	---@type table
	local kPlayer = Players[m_ePlayer];
	---@type table
	local kPlayerCulture = kPlayer:GetCulture();
	if (kPlayerCulture:CivicCompletedThisTurn() or kPlayerCulture:GetNumPolicySlotsOpen() > 0) and Game.IsAllowStrategicCommands(m_ePlayer) and kPlayerCulture:PolicyChangeMade() == false then
		return true;
	end
	return false;
end

-- ===========================================================================
--	Whether the player may switch government this turn. Mirrors the base-game rule:
--	you may change on the turn you have no government yet, or the turn you complete a
--	civic; and only once per turn.
-- ===========================================================================
function IsAbleToChangeGovernment()
	if m_ePlayer == -1 then
		return false;
	end
	---@type table
	local kPlayerCulture = Players[m_ePlayer]:GetCulture();
	if kPlayerCulture:CanChangeGovernmentAtAll()
			and not kPlayerCulture:GovernmentChangeMade()
			and Game.IsAllowStrategicCommands(m_ePlayer)
			and (g_kCurrentGovernment == nil or kPlayerCulture:CivicCompletedThisTurn()) then
		return true;
	end
	return false;
end

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
--	RETURNS: true if policy is available to the player at this time.
-- ===========================================================================
---@param kPlayerCulture table
---@param policyHash number
function IsPolicyAvailable( kPlayerCulture, policyHash )
	---@type boolean
	local isPolicyUnlocked = kPlayerCulture:IsPolicyUnlocked( policyHash )
	---@type boolean
	local isRelevant = not kPlayerCulture:IsPolicyObsolete( policyHash );

	return isPolicyUnlocked and isRelevant;
end

-- ===========================================================================
--	Update the member data for the active, local player.
-- ===========================================================================
---@param ePlayer number
function PopulateLivePlayerData( ePlayer )

	if ePlayer == -1 then
		return;
	end

	---@type table
	local kPlayer = Players[ePlayer];
	---@type table
	local kPlayerCulture = kPlayer:GetCulture();

	-- Restore data from prior turn (likely only necessary in hot-seat)
	if m_kAllPlayerData[ ePlayer ] ~= nil then
		---@type table
		local playerData = m_kAllPlayerData[ ePlayer ];
		m_kPolicyFilterCurrent = playerData[DATA_FIELD_CURRENT_FILTER];
	end

	---@type number
	local governmentRowId = kPlayerCulture:GetCurrentGovernment();
	if governmentRowId ~= -1 then
		g_kCurrentGovernment = g_kGovernments[ GameInfo.Governments[governmentRowId].GovernmentType ];
	else
		g_kCurrentGovernment = nil;
	end

	-- Cache which civic was unlocked this turn, so we can determine whether to display new policy icons
	---@type string
	local civicCompletedThisTurn;
	if kPlayerCulture:CivicCompletedThisTurn() then
		-- Check for nil, it is possible that we do not have a valid civic completed!
		local civicInfo = GameInfo.Civics[kPlayerCulture:GetCivicCompletedThisTurn()];
		if civicInfo ~= nil then
			civicCompletedThisTurn = civicInfo.CivicType;
		end
	end

	-- Policies: populate unlocked (and not obsolete) ones for the catalog
	m_kUnlockedPolicies = {};
	m_kNewPoliciesThisTurn = {};
	for row in GameInfo.Policies() do
		---@type boolean
		local isPolicyAvailable = IsPolicyAvailable(kPlayerCulture, row.Hash);
		---@type string
		local policyType = row.PolicyType;
		m_kUnlockedPolicies[policyType] = isPolicyAvailable or m_debugShowAllPolicies;
		m_kNewPoliciesThisTurn[policyType] = civicCompletedThisTurn and civicCompletedThisTurn == row.PrereqCivic;
	end

	m_ActivePoliciesByType = {};
	m_ActivePoliciesBySlot = {};
	m_ActivePolicyRows[ROW_INDEX.MILITARY] = { SlotArray={} };
	m_ActivePolicyRows[ROW_INDEX.ECONOMIC] = { SlotArray={} };
	m_ActivePolicyRows[ROW_INDEX.DIPLOMAT] = { SlotArray={} };
	m_ActivePolicyRows[ROW_INDEX.SLTHCUL] = { SlotArray={} };
	m_ActivePolicyRows[ROW_INDEX.SLTHREL] = { SlotArray={} };

	---@type number
	local nPolicySlots = kPlayerCulture:GetNumPolicySlots();
	for i = 0, nPolicySlots-1, 1 do
		---@type number
		local iSlotType = kPlayerCulture:GetSlotType(i);
		---@type number
		local iPolicyID = kPlayerCulture:GetSlotPolicy(i);

		---@type string
		local strSlotType = GameInfo.GovernmentSlots[iSlotType].GovernmentSlotType
		-- strSlotType is of the form SLOT_##NAME##, and we want only the first 8 chars of ##NAME##
		---@type string
		local strRowKey = string.sub( strSlotType, 6, 13 );
		---@type number
		local nRowIndex = ROW_INDEX[strRowKey];

		if ( nRowIndex == nil ) then
				assert( false );
			UI.DataError("On initialization; slot type '"..strSlotType.."' requires key '"..strRowKey.."'");
		end

		---@type table
		local tSlotData = {
			-- Static members
			UI_RowIndex		= nRowIndex,
			GC_SlotIndex	= i,

			-- Dynamic members
			GC_PolicyType	= EMPTY_POLICY_TYPE
		};

		if ( iPolicyID ~= -1 ) then
			tSlotData.GC_PolicyType = GameInfo.Policies[iPolicyID].PolicyType;
			m_ActivePoliciesByType[tSlotData.GC_PolicyType] = tSlotData;
		end

		table.insert( m_ActivePolicyRows[nRowIndex].SlotArray, tSlotData );
		m_ActivePoliciesBySlot[i+1] = tSlotData;
	end

	m_kBonuses = {};
	for governmentType, government in pairs(g_kGovernments) do
		---@type string
		local bonusName = (government.Index ~= -1) and GameInfo.Governments[government.Index].BonusType or "NO_GOVERNMENTBONUS";
		---@type number
		local iBonusIndex = -1;
		if bonusName ~= "NO_GOVERNMENTBONUS" then
			iBonusIndex = GameInfo.GovernmentBonusNames[bonusName].Index;
		end
		if government.BonusFlatAmountPreview >= 0 then
			m_kBonuses[governmentType] = {
				BonusPercent			= government.BonusFlatAmountPreview
			}
		end
	end

	-- Unlocked governments
	m_kUnlockedGovernments = {};
	for governmentType,government in pairs(g_kGovernments) do
		if kPlayerCulture:IsGovernmentUnlocked(government.Hash) then
			m_kUnlockedGovernments[governmentType] = true;
		end
	end

	-- DEBUG:
	if m_debugOutputGovInfo then
		DebugOutput();
	end

end

-- ===========================================================================
--	Debug output to console
-- ===========================================================================
function DebugOutput()
	if m_debugOutputGovInfo then
		print("                    Government Index Hash");
		print("------------------------------ ----- ----------");
		for governmentType, government in pairs(g_kGovernments) do
			print( string.format("%30s %-5d %-10s",
				governmentType,
				government.Index,
				government.Hash
			));
		end
	end
end

-- ===========================================================================
--	Save the current data of a player (values that are UI specific that
--	can't be queried and (re-)populated from the game engine when this
--	player's next turn starts.
--	Mostly (only?) valid for local multiplayer hotseat.
-- ===========================================================================
---@param ePlayer number
function SaveLivePlayerData( ePlayer )
	---@type table
	local playerData = {};
	playerData[DATA_FIELD_CURRENT_FILTER] = m_kPolicyFilterCurrent;
	m_kAllPlayerData[ ePlayer ] = playerData;
end

-- ===========================================================================
--	Sort function used on policy catalog
-- ===========================================================================
---@param typeA string
---@param typeB string
function SortPolicies( typeA, typeB )
	---@type table
	local a = m_kPolicyCatalogData[typeA];
	---@type table
	local b = m_kPolicyCatalogData[typeB];
	---@type number
	local v1 = SLOT_ORDER_IN_CATALOG[a.SlotType];
	---@type number
	local v2 = SLOT_ORDER_IN_CATALOG[b.SlotType];
	if v1 == v2 then
		return typeA < typeB;
	end
	return v1 < v2;
end

-- ===========================================================================
--	Fill the catalog with the static (unchanging) policy data used by
--	all players when viewing the screen.
-- ===========================================================================
function PopulateStaticData()

	-- Fill in the complete catalog of policies.
	for row in GameInfo.Policies() do
		---@type table
		local policyTypeRow	= GameInfo.Types[row.PolicyType];
		---@type string
		local policyName = Locale.Lookup(row.Name);
		---@type number
		local policyTypeHash = policyTypeRow.Hash;
		---@type string
		local slotType = row.GovernmentSlotType;
		---@type string
		local description = Locale.Lookup(row.Description);
		--local draftCost			:number = kPlayerCulture:GetEnactPolicyCost(policyTypeHash);	--Move to live data

		m_kPolicyCatalogData[row.PolicyType] = {
			Description = description,
			Name		= policyName,
			PolicyHash	= policyTypeHash,
			SlotType	= slotType,			-- SLOT_MILITARY, SLOT_ECONOMIC, SLOT_DIPLOMATIC, SLOT_SLTHCUL, (SLOT_GREAT_PERSON)
			UniqueID	= row.Index			-- the row this policy exists in, is guaranteed to be unique (as-is the house, but these are readable. ;) )
			};

		table.insert(m_kPolicyCatalogOrder, row.PolicyType);
	end

	table.sort(m_kPolicyCatalogOrder, SortPolicies );

	-- Fill in governments
	g_kGovernments = {};
	for row in GameInfo.Governments() do
		---@type number
		local slotMilitary = 0;
		---@type number
		local slotEconomic = 0;
		---@type number
		local slotDiplomatic = 0;
		---@type number
		local slotSLTHCUL = 0;
		---@type number
		local slotSLTHREL = 0;

		for entry in GameInfo.Government_SlotCounts() do
			if row.GovernmentType == entry.GovernmentType then
				local slotType = entry.GovernmentSlotType;
				for i = 1, entry.NumSlots, 1 do
					if		slotType == "SLOT_MILITARY" then									slotMilitary	= slotMilitary + 1;
					elseif	slotType == "SLOT_ECONOMIC" then									slotEconomic	= slotEconomic + 1;
					elseif	slotType == "SLOT_DIPLOMATIC" then									slotDiplomatic	= slotDiplomatic + 1;
					elseif	slotType == "SLOT_SLTHCUL" or slotType=="SLOT_GREAT_PERSON" then	slotSLTHCUL	= slotSLTHCUL + 1;
					elseif	slotType == "SLOT_SLTHREL" then									slotSLTHREL	= slotSLTHREL + 1;
					end
				end
			end
		end

		g_kGovernments[row.GovernmentType] = {
			BonusAccumulatedText	= row.AccumulatedBonusShortDesc,
			BonusAccumulatedTooltip	= row.AccumulatedBonusDesc,
			BonusFlatAmountPreview	= GetGovernmentFlatBonusPreview(row.BonusType),
			BonusInherentText		= row.InherentBonusDesc,
			StatsText				= GetGovernmentStatsText(row.GovernmentType),
			StatsTooltip			= GetGovernmentStatsTooltip(row.GovernmentType),
			BonusType				= row.BonusType,
			Hash					= GameInfo.Types[row.GovernmentType].Hash,
			Index					= row.Index,
			Name					= row.Name,
			NumSlotMilitary			= slotMilitary,
			NumSlotEconomic			= slotEconomic,
			NumSlotDiplomatic		= slotDiplomatic,
			NumSlotSLTHCUL			= slotSLTHCUL,
			NumSlotSLTHREL		= slotSLTHREL
		}
	end
end

-- ===========================================================================
--	Preview a government's flat bonus independently of any particular player.
--  Because this looks at a government that may not be active, use a hacky
--  database lookup instead of asking the game what the active bonus amount is.
--  This is expensive and silly, so do it once on initialization and store it.
-- ===========================================================================
---@param governmentBonusType string
function GetGovernmentFlatBonusPreview(governmentBonusType)
	if (governmentBonusType == nil or governmentBonusType == "") then
		return 0;
	end
	---@type string
	local governmentType = nil;
	for row in GameInfo.Governments() do
		if (row.BonusType == governmentBonusType) then
			governmentType = row.GovernmentType;
			break;
		end
	end
	if (governmentType == nil) then
		return 0;
	end
	---@type string
	local flatBonusModifierId = nil;
	for row in GameInfo.GovernmentModifiers() do
		if (row.GovernmentType == governmentType) then
			---@type string
			local modifierId = row.ModifierId;
			---@type table
			local modifierArgs = {};
			for argRow in GameInfo.ModifierArguments() do
				if (argRow.ModifierId == modifierId) then
					table.insert(modifierArgs, argRow);
				end
			end
			---@type string
			local bonusType = nil;
			---@type number
			local amount = nil;
			for i,modifierArg in ipairs(modifierArgs) do
				if (modifierArg.Name == "BonusType") then
					bonusType = modifierArg.Value;
				elseif (modifierArg.Name == "Amount") then
					amount = tonumber(modifierArg.Value) or modifierArg.Value;
				end
			end
			if (bonusType ~= nil and bonusType == governmentBonusType and amount ~= nil) then
				return amount;
			end
		end
	end
	return 0;
end

-- ===========================================================================
---@param governmentType string
function GetGovernmentStatsText(governmentType)
	---@type string
	local text = "";
	---@type table
	local governmentInfo = GameInfo.Governments[governmentType];
	if (governmentInfo ~= nil) then
		text = "[ICON_Envoy]" .. governmentInfo.InfluenceTokensPerThreshold;
	end
	return text;
end

-- ===========================================================================
---@param governmentType string
function GetGovernmentStatsTooltip(governmentType)
	---@type string
	local text = "";
	---@type table
	local governmentInfo = GameInfo.Governments[governmentType];
	if (governmentInfo ~= nil) then
		text = Locale.Lookup("LOC_GOVT_INFLUENCE_POINTS_TOWARDS_ENVOYS", governmentInfo.InfluencePointsPerTurn, governmentInfo.InfluencePointsThreshold, governmentInfo.InfluenceTokensPerThreshold);
	end
	return text;
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

-- Maps each policy category (ROW_INDEX) to its column control IDs in the new XML.
---@type table
local CATEGORY_CONTROLS = {};
CATEGORY_CONTROLS[ROW_INDEX.MILITARY] = { title="MilitaryTitle",   scroller="MilitaryListScroller",   stack="MilitaryPolicyStack",   desc="MilitaryDesc",   descTitle="MilitaryDescTitle",   descImage="MilitaryDescImage",   descCard="MilitaryDescCard",   titleKey="LOC_SLOT_MILITARY_NAME" };
CATEGORY_CONTROLS[ROW_INDEX.ECONOMIC] = { title="EconomicTitle",   scroller="EconomicListScroller",   stack="EconomicPolicyStack",   desc="EconomicDesc",   descTitle="EconomicDescTitle",   descImage="EconomicDescImage",   descCard="EconomicDescCard",   titleKey="LOC_SLOT_ECONOMIC_NAME" };
CATEGORY_CONTROLS[ROW_INDEX.DIPLOMAT] = { title="DiplomaticTitle", scroller="DiplomaticListScroller", stack="DiplomaticPolicyStack", desc="DiplomaticDesc", descTitle="DiplomaticDescTitle", descImage="DiplomaticDescImage",   descCard="DiplomaticDescCard", titleKey="LOC_SLOT_DIPLOMATIC_NAME" };
CATEGORY_CONTROLS[ROW_INDEX.SLTHCUL]  = { title="SLTHCULTitle",    scroller="SLTHCULListScroller",    stack="SLTHCULPolicyStack",    desc="SLTHCULDesc",    descTitle="SLTHCULDescTitle",    descImage="SLTHCULDescImage",   descCard="SLTHCULDescCard",    titleKey="LOC_SLOT_SLTHCUL_NAME" };
CATEGORY_CONTROLS[ROW_INDEX.SLTHREL]  = { title="SLTHRELTitle",    scroller="SLTHRELListScroller",    stack="SLTHRELPolicyStack",    desc="SLTHRELDesc",    descTitle="SLTHRELDescTitle",    descImage="SLTHRELDescImage",   descCard="SLTHRELDescCard",    titleKey="LOC_SLOT_SLTHREL_NAME" };

-- Return the single slot for a category (FFH grants one slot per category), or nil.
---@param nRowIndex number
-- The policy actually slotted in gamecore as of the last populate, per category.
-- Snapshotted BEFORE any staging edit, so the "currently active" highlight keeps
-- showing what is really in effect while the player stages a different pick.
local m_CommittedPolicyByRow = {};

function SnapshotCommittedPolicies()
	m_CommittedPolicyByRow = {};
	for nRowIndex = 1, 5 do
		---@type table
		local tSlot = GetCategorySlot(nRowIndex);
		m_CommittedPolicyByRow[nRowIndex] = tSlot and tSlot.GC_PolicyType or EMPTY_POLICY_TYPE;
	end
end

function GetCategorySlot( nRowIndex )
	---@type table
	local tRow = m_ActivePolicyRows[nRowIndex];
	if tRow == nil then return nil; end
	return tRow.SlotArray[1];
end

-- Is strPolicyType the committed (really-in-effect) policy of any category right now?
---@param strPolicyType string
function IsPolicyTypeCommitted( strPolicyType )
	for nRow = 1, 5 do
		if m_CommittedPolicyByRow[nRow] == strPolicyType then return true; end
	end
	return false;
end

-- Is strPolicyType currently staged (selected) in any category slot?
---@param strPolicyType string
function IsPolicyTypeStaged( strPolicyType )
	for nRow = 1, 5 do
		local tSlot = GetCategorySlot(nRow);
		if tSlot and tSlot.GC_PolicyType == strPolicyType then return true; end
	end
	return false;
end

-- A policy's prerequisite (if any) must be active now AND kept staged. Returns
-- true (met) for policies with no prerequisite.
---@param strPolicyType string
function IsPolicyPrereqMet( strPolicyType )
	local strReq = POLICY_REQUIRES[strPolicyType];
	if strReq == nil then return true; end
	return IsPolicyTypeCommitted(strReq) and IsPolicyTypeStaged(strReq);
end

-- Resolve any staged policy whose prerequisite is no longer satisfied, so the player
-- cannot confirm a change the engine would immediately undo. Rather than emptying the
-- slot, restore the policy the player had equipped on open (m_CommittedPolicyByRow) when
-- that is itself still valid -- so breaking a dependency reverts to your prior choice
-- instead of leaving you unselected. Only fall back to empty when the committed policy
-- would also be invalid (e.g. it WAS the dependent). One pass suffices while dependencies
-- are single-level (see POLICY_REQUIRES).
function EnforcePolicyDependencies()
	for nRow = 1, 5 do
		local tSlot = GetCategorySlot(nRow);
		if tSlot and tSlot.GC_PolicyType ~= EMPTY_POLICY_TYPE
				and not IsPolicyPrereqMet(tSlot.GC_PolicyType) then
			local strCommitted = m_CommittedPolicyByRow[nRow];
			if strCommitted and strCommitted ~= EMPTY_POLICY_TYPE
					and strCommitted ~= tSlot.GC_PolicyType
					and IsPolicyPrereqMet(strCommitted) then
				SetActivePolicyAtSlotIndex( tSlot.GC_SlotIndex, strCommitted );
			else
				RemoveActivePolicyAtSlotIndex( tSlot.GC_SlotIndex );
			end
		end
	end
end

-- Show the description for the category's currently-staged policy (or blank).
-- Fill a category's description card (title / image / text) for a given policy.
-- Uses the base slot-type card art for now; swap to per-policy art later.
---@param cc table
---@param strPolicyType string
function RealizeDescriptionCard( cc, strPolicyType )
	---@type table
	local tPolicy = m_kPolicyCatalogData[strPolicyType];
	Controls[cc.descTitle]:SetText( tPolicy.Name );
	Controls[cc.descImage]:SetTexture( GetPolicyBGTexture(strPolicyType) );
	Controls[cc.descImage]:SetHide( false );
	Controls[cc.desc]:SetText( tPolicy.Description );
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
	Controls[cc.descCard]:SetTexture( isProposed
		and "Governments_BackingSelected" or "Governments_Backing" );
	---@type number
	local uiTextColor = isProposed and COLOR_GOVT_SELECTED or COLOR_GOVT_UNSELECTED;
	Controls[cc.descTitle]:SetColor( uiTextColor, 0 );
	Controls[cc.desc]:SetColor( uiTextColor );
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
		Controls[cc.descTitle]:SetText( "Unselected Policy" );
		Controls[cc.descImage]:SetTexture( GetPolicyBGTexture(strSelected) );
		Controls[cc.descImage]:SetHide( false );
		Controls[cc.desc]:SetText( "" );
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
	local uiStack = Controls[cc.stack];
	uiStack:DestroyAllChildren();

	Controls[cc.title]:SetText( Locale.ToUpper(cc.titleKey) );

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
	Controls[cc.scroller]:CalculateSize();
	RealizeCategoryDescription( nRowIndex );
end

-- Governments list (display-only for now; current government highlighted).
-- Snapshot the government actually in effect (before any staging), and reset the staged
-- selection to it. Mirrors SnapshotCommittedPolicies; called from RefreshAllData.
function SnapshotCommittedGovernment()
	m_CommittedGovernment = nil;
	if g_kCurrentGovernment ~= nil then
		for strGovType, tGov in pairs(g_kGovernments) do
			if tGov.Index == g_kCurrentGovernment.Index then
				m_CommittedGovernment = strGovType;
				break;
			end
		end
	end
	m_StagedGovernment = m_CommittedGovernment;
	m_isGovernmentChanged = false;
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

	---@type table
	local kOrder = {};
	for strGovType,_ in pairs(g_kGovernments) do
		table.insert( kOrder, strGovType );
	end
	table.sort( kOrder, function(a,b) return g_kGovernments[a].Index < g_kGovernments[b].Index; end );

	---@type boolean
	local canChange = IsAbleToChangeGovernment();

	for _,strGovType in ipairs(kOrder) do
		---@type table
		local tGov = g_kGovernments[strGovType];
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

		---@type boolean
		local isStaged = (strGovType == m_StagedGovernment);
		inst.Highlight:SetHide( not isStaged );
		-- Active marker: the government in effect now, hidden when it IS the staged pick.
		inst.Active:SetHide( not (strGovType == m_CommittedGovernment and not isStaged) );
		inst.Hover:SetHide( true );

		inst.Button:RegisterCallback( Mouse.eMouseEnter, function() inst.Hover:SetHide(false); end );
		inst.Button:RegisterCallback( Mouse.eMouseExit,  function() inst.Hover:SetHide(true); end );

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

-- Rebuild the whole screen from the staged model.
function RealizeAll()
	RealizeGovernmentsList();
	for nRowIndex = 1, 5 do
		RealizeCategoryList( nRowIndex );
	end
	RealizeConfirmButton();
	Controls.MainColumns:CalculateSize();	-- re-center the column stack after (re)building
end
