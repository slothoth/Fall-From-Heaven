-- GovernmentScreen_Model.lua
-- The underlying model for the One Policy Slot Government Screen: policy & government data,
-- the per-slot row model, staging state, and all Controls-free queries/mutators.
--  GLOBAL so the display half can see it.

-- ===========================================================================
--	DEBUG
--	Toggle these for temporary debugging help.
-- ===========================================================================
---@type boolean
m_debugShowAllPolicies = false;		-- (false) When true all policy cards (despite player's progression) will be shown in the catalog

---@type boolean
m_debugOutputGovInfo = false;		-- (false) Output to console information about governments

---@type string
DATA_FIELD_CURRENT_FILTER = "_CURRENT_FILTER";

-- Built from GameInfo.GovernmentSlots
---@type table
ROW_SLOT_TYPES = {};		-- uiRow (1..N) -> slot type string, in GovernmentSlots order

---@type table
SLOT_TYPE_TO_ROW = {};	-- slot type string -> uiRow

---@type table
--  Built from GameInfo.GovernmentSlots
SLOT_ORDER_IN_CATALOG = {};

---@type string
EMPTY_POLICY_TYPE = "empty";					-- For a policy slot without a type

---@type table              -- will cut these soon
POLICY_REQUIRES = {
	["SLTH_POLICY_SACRIFICE_THE_WEAK"] = "SLTH_POLICY_STATE_VEIL",
	["SLTH_POLICY_GUARDIAN_OF_NATURE"] = "SLTH_POLICY_STATE_LEAVES",
	["SLTH_POLICY_ARETE"]              = "SLTH_POLICY_STATE_RUNES",
	["SLTH_POLICY_SOCIAL_ORDER"]       = "SLTH_POLICY_STATE_ORDER",
};

-- ===========================================================================
--	GLOBALS
-- ===========================================================================
g_kGovernments = {};
g_kGovernmentTierSorting = {};	-- GovernmentTiers.TierType -> Sorting (built in PopulateStaticData)
g_kCurrentGovernment = nil;
m_kUnlockedPolicies = nil;
m_kNewPoliciesThisTurn = nil;

---@type number
m_ePlayer	= -1;

---@type table
m_kAllPlayerData  = {};		-- Holds copy of player data for all local players

---@type table
m_kBonuses	= {}

---@type boolean
m_isPoliciesChanged= false;

---@type string
-- Government actually in effect, snapshotted on refresh.
m_CommittedGovernment = nil;

---@type table
m_kPolicyCatalogData	= {};

---@type table
m_kPolicyCatalogOrder  = {};		-- Track order of policies to display

---@type table
m_kFlavoredPolicyNames  = {};		-- Lists policies which have an alternative name for the local player's civilization

---@type table
m_kPolicyFilterCurrent	= nil;

---@type table
m_kUnlockedGovernments  = {};

---@type table
m_ActivePolicyRows = {};

---@type table
m_ActivePoliciesByType = {}; -- PolicyType string -> SlotData table

---@type table
m_ActivePoliciesBySlot = {}; -- (GC Slot Index + 1) -> SlotData table

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
--	Whether the player may switch government this turn.
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

	-- Cache which civic was unlocked this turn, so can determine whether to display new policy icons
	---@type string
	local civicCompletedThisTurn;
	if kPlayerCulture:CivicCompletedThisTurn() then
		-- Check for nil, it is possible that we do not have a valid civic completed!
		local civicInfo = GameInfo.Civics[kPlayerCulture:GetCivicCompletedThisTurn()];
		if civicInfo ~= nil then
			civicCompletedThisTurn = civicInfo.CivicType;
		end
	end

	-- Policies: populate unlocked (and not obsolete) ones for catalog
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
	for nRowIndex = 1, #ROW_SLOT_TYPES do
		m_ActivePolicyRows[nRowIndex] = { SlotArray={} };
	end

	---@type number
	local nPolicySlots = kPlayerCulture:GetNumPolicySlots();
	for i = 0, nPolicySlots-1, 1 do
		---@type number
		local iSlotType = kPlayerCulture:GetSlotType(i);
		---@type number
		local iPolicyID = kPlayerCulture:GetSlotPolicy(i);

		---@type string
		local strSlotType = GameInfo.GovernmentSlots[iSlotType].GovernmentSlotType
		-- Map the gamecore slot to its UI row via the type-> row table built from GovernmentSlots.
		---@type number
		local nRowIndex = SLOT_TYPE_TO_ROW[strSlotType];

		if ( nRowIndex == nil ) then
			UI.DataError("Government slot type '"..strSlotType.."' has no column (not in GovernmentSlots?)");
		else
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
	-- Default to math.huge so a policy whose slot type is not a current GovernmentSlot
	-- (e.g. a leftover base-game policy on a deleted slot) sorts last instead of erroring.
	---@type number
	local v1 = SLOT_ORDER_IN_CATALOG[a.SlotType] or math.huge;
	---@type number
	local v2 = SLOT_ORDER_IN_CATALOG[b.SlotType] or math.huge;
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

	-- Catalog sort order per slot type, straight from GovernmentSlots (data-driven, so any
	-- mod's slot types sort correctly instead of relying on a hardcoded list).
	SLOT_ORDER_IN_CATALOG = {};
	for slot in GameInfo.GovernmentSlots() do
		SLOT_ORDER_IN_CATALOG[slot.GovernmentSlotType] = slot.Index;
	end

	-- Create a table of policies to be hidden, including:
	--  generic policies replaced by a unique of the local player's civilization
	--  unique policies of civilizations other than the local player's
	---@type number
	local localPlayerID = Game.GetLocalPlayer();
	---@type table
	local pPlayerConfig = PlayerConfigurations[localPlayerID];
	---@type table
	local tListOfHiddenPolicies = {};
	for row in GameInfo.PolicyReplaces_JNR() do
		if row.CivilizationType == pPlayerConfig:GetCivilizationTypeName() then
			tListOfHiddenPolicies[row.ReplacesPolicyType] = 1;
		else
			tListOfHiddenPolicies[row.CivUniquePolicyType] = 1;
		end
	end

	-- Some policies get alternative names for certain civilizations.
	-- These can be toggled by the player, so we need to pass them to the main script and process them there.
	for row in GameInfo.Policies_AlternateNames_JNR() do
		if row.CivilizationType == pPlayerConfig:GetCivilizationTypeName() then
			m_kFlavoredPolicyNames[row.PolicyType] = row.Name;
		end
	end

	-- Fill in the complete catalog of policies. Civ-replaced policies are filtered out here, at
	-- the catalog level, so they never reach any consumer -- which is why GetCategoryPolicyList
	-- below only has to worry about the government filter and the "none" policies.
	for row in GameInfo.Policies() do
		if not tListOfHiddenPolicies[row.PolicyType] then
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
				SlotType	= slotType,
				PrereqCivic	= row.PrereqCivic,	-- what unlocks it; drives the unlock badges (may be nil)
				PrereqTech	= row.PrereqTech,	-- ditto, for the few gated on a tech instead
				UniqueID	= row.Index			-- the row this policy exists in, is guaranteed to be unique (as-is the house, but these are readable. ;) )
				};

			table.insert(m_kPolicyCatalogOrder, row.PolicyType);
		end
	end

	table.sort(m_kPolicyCatalogOrder, SortPolicies );

	-- Government-restricted policies (XP2 table; guarded because it does not exist without the
	-- expansion). A policy with no row here is unrestricted. Consumed by GetCategoryPolicyList.
	POLICY_GOVERNMENT_EXCLUSIVE = {};
	if GameInfo.Policy_GovernmentExclusives_XP2 ~= nil then
		for row in GameInfo.Policy_GovernmentExclusives_XP2() do
			if POLICY_GOVERNMENT_EXCLUSIVE[row.PolicyType] == nil then
				POLICY_GOVERNMENT_EXCLUSIVE[row.PolicyType] = {};
			end
			POLICY_GOVERNMENT_EXCLUSIVE[row.PolicyType][row.GovernmentType] = true;
		end
	end

	-- Fill in governments
	g_kGovernments = {};
    -- somehow this is still using my hardcoded stuff but works... troubling...
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
			Tier					= row.Tier,		-- GovernmentTiers.TierType (may be nil -> ungrouped, sorts to top)
			NumSlotMilitary			= slotMilitary,
			NumSlotEconomic			= slotEconomic,
			NumSlotDiplomatic		= slotDiplomatic,
			NumSlotSLTHCUL			= slotSLTHCUL,
			NumSlotSLTHREL		= slotSLTHREL
		}
	end

	-- GovernmentTiers has no single "tier number" we can read off a Government row, so map
	-- each TierType to its Sorting here and use that to order/segment the list.
	g_kGovernmentTierSorting = {};
	for tierRow in GameInfo.GovernmentTiers() do
		g_kGovernmentTierSorting[tierRow.TierType] = tierRow.Sorting;
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
--	WHICH POLICIES A CATEGORY COLUMN OFFERS
-- ===========================================================================

-- "None" policies: the explicit do-nothing option that used to sit at the top of a category
-- . They are hidden from the picker, we are using a table, maybe a SQL table later?
-- the pattern match below covers the "<CATEGORY>_00_DEFAULT" naming convention.
---@type table
 POLICY_NONE_TYPES = {}
-- 	["SLTH_POLICY_NO_STATE_RELIGION"] = true,
-- };

---@param strPolicyType string
---@return boolean
function IsNonePolicy( strPolicyType )
	if strPolicyType == nil then return false; end
	if POLICY_NONE_TYPES[strPolicyType] then return true; end
	return string.match( strPolicyType, "_00_DEFAULT$" ) ~= nil;
end

-- Normalise a slot's policy for display.
---@param strPolicyType string
---@return string
function DisplayPolicyType( strPolicyType )
	if strPolicyType == nil or IsNonePolicy( strPolicyType ) then return EMPTY_POLICY_TYPE; end
	return strPolicyType;
end

-- policyType -> { [governmentType] = true }, for policies restricted to particular governments.
-- Built by PopulateStaticData from Policy_GovernmentExclusives_XP2. A policy absent from this
-- table is unrestricted and offered under every government.
---@type table
POLICY_GOVERNMENT_EXCLUSIVE = {};

---@param strPolicyType string
---@param strGovType string
---@return boolean
function IsPolicyAllowedByGovernment( strPolicyType, strGovType )
	---@type table
	local kGovs = POLICY_GOVERNMENT_EXCLUSIVE[strPolicyType];
	if kGovs == nil then return true; end			-- not government-restricted
	if strGovType == nil then return false; end		-- restricted, and the player has no government
	return kGovs[strGovType] == true;
end

-- ===========================================================================
--	DISPLAY OPTIONS
--	Toggled from the screen's options panel, persisted per user (not per save,
--	and not per player) via UserConfiguration, which takes arbitrary string keys.
-- ===========================================================================

---@type string
OPTION_KEY_FLAVORED_NAMES = "GovScreenFlavoredNames";
---@type string
OPTION_KEY_UNLOCK_BADGES  = "GovScreenUnlockBadges";

---@type boolean
m_isShowFlavoredNames = true;
---@type boolean
m_isShowUnlockBadges  = true;

---@param strKey string
---@param isDefault boolean
---@return boolean
local function ReadBoolOption( strKey, isDefault )
	---@type any
	local value = UserConfiguration.GetValue( strKey );
	if value == nil then return isDefault; end
	return value ~= false and value ~= 0;
end

function LoadDisplayOptions()
	m_isShowFlavoredNames = ReadBoolOption( OPTION_KEY_FLAVORED_NAMES, true );
	m_isShowUnlockBadges  = ReadBoolOption( OPTION_KEY_UNLOCK_BADGES,  true );
end

---@param isOn boolean
function SetShowFlavoredNames( isOn )
	m_isShowFlavoredNames = isOn;
	UserConfiguration.SetValue( OPTION_KEY_FLAVORED_NAMES, isOn );
end

---@param isOn boolean
function SetShowUnlockBadges( isOn )
	m_isShowUnlockBadges = isOn;
	UserConfiguration.SetValue( OPTION_KEY_UNLOCK_BADGES, isOn );
end

-- ===========================================================================
--	UNLOCK BADGES
--	Small icons shown beside a still-locked policy saying what will unlock it.
-- ===========================================================================

-- Badges come in two groups, rendered on opposite sides of the policy card. Left is civic research lock
--  Right is every other condition: being a particular civilization, being at war,
--                     having another policy equipped, having a certain government
--
-- A badge is { Icon = <atlas icon name>, Texture = <direct .dds>, Tooltip = <LOC key or text> }.
-- in future maybe this would be in gameInfo
---@type table
POLICY_EXTRA_UNLOCK_BADGES = {
	-- Crusade: Bannor-only, and only while at war.
	["SLTH_POLICY_CRUSADE"] = {
		{ Icon = "ICON_SLTH_CIVILIZATION_BANNOR", Tooltip = "LOC_UNLOCK_CRUSADE" }
	},
    ["SLTH_POLICY_SLAVERY"] = {
		{ Icon = "ICON_BARBARIAN_CLAN_SKELETON_2", Tooltip = "LOC_UNLOCK_EVIL" },
	},
};
for row in GameInfo.PolicyGatedPolicies() do
    print('for row', row.PolicyType, row.UnlockedPolicyType, row.Icon, row.ToolTip)
    POLICY_EXTRA_UNLOCK_BADGES[row.UnlockedPolicyType] = {
        { Icon = row.Icon, Tooltip = row.ToolTip}
    }
end


-- One badge descriptor from a game type, or nil when the type is absent.
---@param strPrefixType string
---@param kInfoTable table
---@return table
local function MakeTypeBadge( strPrefixType, kInfoTable )
	if strPrefixType == nil then return nil; end
	---@type table
    local tRow = kInfoTable[strPrefixType];
    print('trying to make new badge', strPrefixType, tRow.Name)
    local tooltip = (tRow ~= nil) and tRow.Name or strPrefixType
	return { Icon = "ICON_" .. strPrefixType, Tooltip = Locale.Lookup('LOC_GENERIC_UNLOCK_BY_CIVIC', Locale.Lookup(tooltip)) };
end

-- What unlocks this policy, split into the two side groups:
--   { Primary = { badge, ... }, Secondary = { badge, ... } }
-- Either list may be empty.
---@param strPolicyType string
---@return table

---@param strPolicyType string
---@return boolean
function ArePolicyPrereqsResearched( strPolicyType )
	---@type table
	local tPolicy = m_kPolicyCatalogData[strPolicyType];
	if tPolicy == nil then return true; end
	if m_ePlayer == -1 then return false; end
	---@type table
	local pPlayer = Players[m_ePlayer];

	if tPolicy.PrereqCivic ~= nil then
		---@type table
		local tCivic = GameInfo.Civics[tPolicy.PrereqCivic];
		if tCivic ~= nil and not pPlayer:GetCulture():HasCivic( tCivic.Index ) then
			return false;
		end
	end
	if tPolicy.PrereqTech ~= nil then
		---@type table
		local tTech = GameInfo.Technologies[tPolicy.PrereqTech];
		if tTech ~= nil and not pPlayer:GetTechs():HasTech( tTech.Index ) then
			return false;
		end
	end
	return true;
end

function GetPolicyUnlockBadges( strPolicyType )
	---@type table
	local kResult = { Primary = {}, Secondary = {} };

	---@type table
	local tPolicy = m_kPolicyCatalogData[strPolicyType];
	if tPolicy == nil then return kResult; end

	-- Primary: what to research.
	---@type table
	local tCivic = MakeTypeBadge( tPolicy.PrereqCivic, GameInfo.Civics );
	if tCivic ~= nil then table.insert( kResult.Primary, tCivic ); end
	---@type table
	local tTech = MakeTypeBadge( tPolicy.PrereqTech, GameInfo.Technologies );
	if tTech ~= nil then table.insert( kResult.Primary, tTech ); end

	-- Secondary: everything else.
	---@type table
	local kExtra = POLICY_EXTRA_UNLOCK_BADGES[strPolicyType];
	if kExtra ~= nil then
		for _,tBadge in ipairs(kExtra) do table.insert( kResult.Secondary, tBadge ); end
	else
		---@type string
		local strRequired = POLICY_REQUIRES[strPolicyType];
		if strRequired ~= nil then
			---@type table
			local tRequired = m_kPolicyCatalogData[strRequired];
			table.insert( kResult.Secondary, {
				Icon    = "ICON_" .. strRequired,
				Tooltip = (tRequired ~= nil) and tRequired.Name or strRequired,
			} );
		end
	end

	return kResult;
end

-- The name to show for a policy: the local civilization's alternate name when it has one
-- (Policies_AlternateNames_JNR -> m_kFlavoredPolicyNames), otherwise the catalog name.
-- Alternate names arrive as raw LOC keys; catalog names are already looked up.
---@param strPolicyType string
---@return string
function GetPolicyDisplayName( strPolicyType )
	if m_isShowFlavoredNames and m_kFlavoredPolicyNames[strPolicyType] ~= nil then
		return Locale.Lookup( m_kFlavoredPolicyNames[strPolicyType] );
	end
	---@type table
	local tPolicy = m_kPolicyCatalogData[strPolicyType];
	return tPolicy and tPolicy.Name or strPolicyType;
end

-- The ordered list of policy types a category column offers right now. Decides a columns content, used by
-- RealizeCategoryList, MeasureMaxDescTextH
-- no civilization filter here on purpose as PopulateStaticData resolves civ-unique
-- policies against the generics they replace (PolicyReplaces_JNR) before the catalog is built, so
-- anything reaching m_kPolicyCatalogOrder is already correct for the local player's civ.
---@param nRowIndex number
---@return table
function GetCategoryPolicyList( nRowIndex )
	---@type string
	local strSlotType = ROW_SLOT_TYPES[nRowIndex];
	---@type string
	local strGovType = m_CommittedGovernment;
	---@type table
	local kList = {};
	for _,strPolicyType in ipairs(m_kPolicyCatalogOrder) do
		---@type table
		local tPolicy = m_kPolicyCatalogData[strPolicyType];
		if tPolicy.SlotType == strSlotType
				and not IsNonePolicy( strPolicyType )
				and IsPolicyAllowedByGovernment( strPolicyType, strGovType ) then
			table.insert( kList, strPolicyType );
		end
	end
	return kList;
end

-- Return the single slot for a category, or nil.
---@param nRowIndex number
m_CommittedPolicyByRow = {};

function SnapshotCommittedPolicies()
	m_CommittedPolicyByRow = {};
	for nRowIndex = 1, #ROW_SLOT_TYPES do
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
-- that is itself still valid. so breaking a dependency reverts to your prior choice
-- instead of leaving you unselected. Only fall back to empty when the committed policy
-- would also be invalid.
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

-- Resolve the government actually in effect to its GovernmentType, for the list highlight and
-- for the per-government policy filter (GetCategoryPolicyList). Mirrors SnapshotCommittedPolicies;
-- called from RefreshAllData.
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
end
