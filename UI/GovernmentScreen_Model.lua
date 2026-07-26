-- GovernmentScreen_Model.lua
-- The underlying model for the FFH government/policies screen: policy & government data,
-- the per-slot row model, staging state, and all Controls-free queries/mutators. Included by
-- GovernmentScreen.lua (the display/controller half) via include("GovernmentScreen_Model"),
-- so it runs in the SAME Lua state -- everything here is GLOBAL so the display half can see it.

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

---@type table
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
-- Government actually in effect, snapshotted on refresh. There is no staged counterpart:
-- picking a government commits it immediately (OnGovernmentClicked), because the government
-- decides which policies are on offer and so cannot sit buffered behind Confirm.
m_CommittedGovernment = nil;

---@type table
m_kPolicyCatalogData	= {};

---@type table
m_kPolicyCatalogOrder  = {};		-- Track order of policies to display

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

	-- Civilization-restricted policies. Same deal, but the table is authored by this mod rather
	-- than the expansion, so it is looked up by name and skipped entirely when absent.
	POLICY_CIV_EXCLUSIVE = {};
	---@type table
	local kCivExclusives = GameInfo[POLICY_CIV_EXCLUSIVE_TABLE];
	if kCivExclusives ~= nil then
		for row in kCivExclusives() do
			if POLICY_CIV_EXCLUSIVE[row.PolicyType] == nil then
				POLICY_CIV_EXCLUSIVE[row.PolicyType] = {};
			end
			POLICY_CIV_EXCLUSIVE[row.PolicyType][row.CivilizationType] = true;
		end
	end

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
-- (e.g. the no-state-religion pick). They are hidden from the picker -- an empty slot already
-- reads as "none" through the description card's Unselected state -- while staying in the
-- database so the engine still has something valid to put in a slot. List any further ones
-- here; the pattern match below covers the "<CATEGORY>_00_DEFAULT" naming convention.
---@type table
POLICY_NONE_TYPES = {
	["SLTH_POLICY_NO_STATE_RELIGION"] = true,
};

---@param strPolicyType string
---@return boolean
function IsNonePolicy( strPolicyType )
	if strPolicyType == nil then return false; end
	if POLICY_NONE_TYPES[strPolicyType] then return true; end
	return string.match( strPolicyType, "_00_DEFAULT$" ) ~= nil;
end

-- Normalise a slot's policy for display. A "none" policy IS the empty selection, so it must read
-- as one: it is hidden from the list, and showing its name on the description card would point at
-- a row the player cannot see.
---@param strPolicyType string
---@return string
function DisplayPolicyType( strPolicyType )
	if strPolicyType == nil or IsNonePolicy( strPolicyType ) then return EMPTY_POLICY_TYPE; end
	return strPolicyType;
end

-- policyType -> { [governmentType] = true }, for policies restricted to particular governments.
-- Built by PopulateStaticData from Policy_GovernmentExclusives_XP2. A policy ABSENT from this
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

-- Civilization-restricted policies, same shape and same semantics as the government table above:
-- policyType -> { [civilizationType] = true }, and a policy with no row is unrestricted.
--
-- The SQL table is authored separately. Only its NAME and the two column names are assumed here,
-- so if you call them something else, change POLICY_CIV_EXCLUSIVE_TABLE / the two field reads in
-- PopulateStaticData and nothing else has to move. The lookup is guarded, so until the table
-- exists every policy simply counts as unrestricted and the screen behaves as it does today.
---@type string
POLICY_CIV_EXCLUSIVE_TABLE = "Policy_CivilizationExclusives";

---@type table
POLICY_CIV_EXCLUSIVE = {};

---@param strPolicyType string
---@param strCivType string
---@return boolean
function IsPolicyAllowedByCivilization( strPolicyType, strCivType )
	---@type table
	local kCivs = POLICY_CIV_EXCLUSIVE[strPolicyType];
	if kCivs == nil then return true; end			-- not civ-restricted
	if strCivType == nil then return false; end		-- restricted, and we cannot tell who this is
	return kCivs[strCivType] == true;
end

-- The local player's civilization ("CIVILIZATION_ROME"), or nil before a player is known.
---@return string
function GetPlayerCivilizationType()
	if m_ePlayer == -1 then return nil; end
	---@type table
	local pConfig = PlayerConfigurations[m_ePlayer];
	if pConfig == nil then return nil; end
	return pConfig:GetCivilizationTypeName();
end

-- The ordered list of policy types a category column offers right now.
--
-- THIS IS THE SINGLE PLACE that decides a column's contents: RealizeCategoryList and
-- MeasureMaxDescTextH both go through it, so any further filtering (civilization-specific
-- variants, capping the column at a fixed number of rows, ...) only has to be added here and
-- the display half picks it up for free.
---@param nRowIndex number
---@return table
function GetCategoryPolicyList( nRowIndex )
	---@type string
	local strSlotType = ROW_SLOT_TYPES[nRowIndex];
	-- Filter against the government actually in effect: government changes commit immediately,
	-- so there is never a staged-but-uncommitted government to consider here.
	---@type string
	local strGovType = m_CommittedGovernment;
	---@type string
	local strCivType = GetPlayerCivilizationType();
	---@type table
	local kList = {};
	for _,strPolicyType in ipairs(m_kPolicyCatalogOrder) do
		---@type table
		local tPolicy = m_kPolicyCatalogData[strPolicyType];
		if tPolicy.SlotType == strSlotType
				and not IsNonePolicy( strPolicyType )
				and IsPolicyAllowedByGovernment( strPolicyType, strGovType )
				and IsPolicyAllowedByCivilization( strPolicyType, strCivType ) then
			table.insert( kList, strPolicyType );
		end
	end
	return kList;
end

-- Return the single slot for a category (FFH grants one slot per category), or nil.
---@param nRowIndex number
-- The policy actually slotted in gamecore as of the last populate, per category.
-- Snapshotted BEFORE any staging edit, so the "currently active" highlight keeps
-- showing what is really in effect while the player stages a different pick.
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
-- that is itself still valid -- so breaking a dependency reverts to your prior choice
-- instead of leaving you unselected. Only fall back to empty when the committed policy
-- would also be invalid (e.g. it WAS the dependent).
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
