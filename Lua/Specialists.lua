include('SpawnSupport')
-- When Policy slots change
-- check if Policy removed is Scholarship or Caste System
-- remove all dummy buildings associated with each
m_eScholarshipPolicy = GameInfo.Policies["SLTH_POLICY_SCHOLARSHIP"].Index;
m_eCasteSystemPolicy = GameInfo.Policies["SLTH_POLICY_CASTE_SYSTEM"].Index;

m_tScholarshipBuildings = {}
m_tScholarshipBuildings[1] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_SCHOLARSHIP_SUPER_SPECIALIST_FLAG"].Index
m_tScholarshipBuildings[2] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_SCHOLARSHIP_CAMPUS"].Index
m_tScholarshipBuildings[3] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_SCHOLARSHIP_THEATRE"].Index
m_tScholarshipBuildings[4] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_SCHOLARSHIP_HOLY_SITE"].Index
m_tScholarshipBuildings[5] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_SCHOLARSHIP_COMMERCE"].Index
m_tScholarshipBuildings[6] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_SCHOLARSHIP_IZ"].Index

m_tCasteSystemBuildings = {}
m_tCasteSystemBuildings[1] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_CASTE_SYSTEM_SUPER_SPECIALIST_FLAG"].Index
m_tCasteSystemBuildings[2] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_CASTE_SYSTEM_CAMPUS"].Index
m_tCasteSystemBuildings[3] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_CASTE_SYSTEM_THEATRE"].Index
m_tCasteSystemBuildings[4] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_CASTE_SYSTEM_HOLY_SITE"].Index
m_tCasteSystemBuildings[5] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_CASTE_SYSTEM_COMMERCE"].Index
m_tCasteSystemBuildings[6] = GameInfo.Buildings["SLTH_BUILDING_DUMMY_CASTE_SYSTEM_IZ"].Index

m_tStateReligionPolicies = {[GameInfo.Policies["SLTH_POLICY_STATE_RUNES"].Index]='RUNES_STATE_REL',
							[GameInfo.Policies["SLTH_POLICY_STATE_OCTOPUS"].Index]='OCTOPUS_STATE_REL',
							[GameInfo.Policies["SLTH_POLICY_STATE_ORDER"].Index]='ORDER_STATE_REL',
							[GameInfo.Policies["SLTH_POLICY_STATE_VEIL"].Index]='VEIL_STATE_REL',
							[GameInfo.Policies["SLTH_POLICY_STATE_LEAVES"].Index]='LEAVES_STATE_REL',
							[GameInfo.Policies["SLTH_POLICY_STATE_EMPYREAN"].Index]='EMPYREAN_STATE_REL',
							[GameInfo.Policies["SLTH_POLICY_STATE_ESUS"].Index]='ESUS_STATE_REL',
							[GameInfo.Policies["SLTH_POLICY_NO_STATE_RELIGION"].Index]='NO_STATE_REL'
}

-- Game-religion index -> the '<SHORT>_CITIES' capital-plot property that the
-- CAN_*_STATE_RELIGION_REQS requirement sets read (Core/Governments.sql). A player
-- may only adopt a state religion whose religion has followers somewhere in their
-- empire; that gate is these properties, kept live by RealizeReligionCityProperties.
-- The religion<->policy pairing matches tReligionMap in Gameplay.lua.
m_tReligionCityProps = {
	[GameInfo.Religions['RELIGION_PROTESTANTISM'].Index] = 'ORDER_CITIES',
	[GameInfo.Religions['RELIGION_JUDAISM'].Index]       = 'EMPYREAN_CITIES',
	[GameInfo.Religions['RELIGION_CONFUCIANISM'].Index]  = 'RUNES_CITIES',
	[GameInfo.Religions['RELIGION_CATHOLICISM'].Index]   = 'LEAVES_CITIES',
	[GameInfo.Religions['RELIGION_HINDUISM'].Index]      = 'OCTOPUS_CITIES',
	[GameInfo.Religions['RELIGION_ISLAM'].Index]         = 'ESUS_CITIES',
	[GameInfo.Religions['RELIGION_BUDDHISM'].Index]      = 'VEIL_CITIES',
}


-- The BAN_* modifier chains in Core/Governments.sql gate on capital-plot
-- properties (REQUIREMENT_PLOT_PROPERTY_MATCHES). Those properties are only
-- written by OnPolicyChanged below, so before a player's first religion-policy
-- change they do not exist and the requirements cannot resolve. Seed them to 0
-- when the capital is established -- the same BuildingConstructed/palace hook
-- Alignment.lua uses -- so every requirement has a defined value from turn one.
m_eBuildingPalace = GameInfo.Buildings['BUILDING_PALACE'].Index
m_sStateRelSeededKey = 'STATE_REL_PROPS_SEEDED'

function SeedStateReligionProperties(iPlayerID, iCityID, iBuildingID, iPlotID, isOriginalConstruction)
	if iBuildingID ~= m_eBuildingPalace then return; end
	local pPlayer = Players[iPlayerID]
	if not pPlayer then return; end
	-- Seed once per player. A later palace means the capital moved or was retaken,
	-- where the live values must survive (migrateCapitalProperties carries them).
	if pPlayer:GetProperty(m_sStateRelSeededKey) then return; end

	local pCapitalPlot = Map.GetPlotByIndex(iPlotID)
	for eStatePolicyIndex, sPropKey in pairs(m_tStateReligionPolicies) do
		setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, sPropKey, 0)
	end
	-- 'STATE_RELIGION' is deliberately left unset: nil means 'none chosen yet',
	-- which is what its readers (Armageddon.lua, DiplomacyActionViewInjector.lua) expect.
	pPlayer:SetProperty(m_sStateRelSeededKey, 1)
	print('seeded state religion plot properties for player', iPlayerID)
end

function removePolicyDummyBuildings(iPlayerID,ePolicyIndex, tBuildingsToRemove)
	local pPlayer = Players[iPlayerID];
	local bPolicyActive = pPlayer:GetCulture():IsPolicyActive(ePolicyIndex);
	if not bPolicyActive then
		for idx, pCity in pPlayer:GetCities():Members() do
			for table_indx, iBuildingIndex in pairs(tBuildingsToRemove) do
				pCity:GetBuildings():RemoveBuilding(iBuildingIndex)
			end
		end
	end
end

function OnPolicyChanged(iPlayerID, ePolicyIndex, bEnacted)
	if (ePolicyIndex == m_eScholarshipPolicy) then
		removePolicyDummyBuildings(iPlayerID, ePolicyIndex, m_tScholarshipBuildings)
	end
	if (ePolicyIndex == m_eCasteSystemPolicy) then
		removePolicyDummyBuildings(iPlayerID, ePolicyIndex, m_tCasteSystemBuildings)
	end
	if (m_tStateReligionPolicies[ePolicyIndex]) then
		local pPlayer = Players[iPlayerID]
		if pPlayer then
			local pCities = pPlayer:GetCities()
			if pCities then
				local pCapitalPlot
				local pCapitalCity = pCities:GetCapitalCity()
				if pCapitalCity then
					pCapitalPlot = pCapitalCity:GetPlot()
				end
				-- Recompute every '<REL>_STATE_REL' from what is ACTUALLY active rather than
				-- from this one event's bEnacted flag. A single PolicyChanged fires per
				-- add/remove with no ordering guarantee, and the engine auto-removes a
				-- policy that becomes banned -- trusting the flag left the de-slotted
				-- religion's prop at 1 (so e.g. Sacrifice the Weak stayed unbanned after
				-- Ashen Veil was lost). IsPolicyActive is the current truth.
				local pCulture = pPlayer:GetCulture()
				local sActiveKey
				for eStatePolicyIndex, sPropKey in pairs(m_tStateReligionPolicies) do
					if pCulture:IsPolicyActive(eStatePolicyIndex) then
						setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, sPropKey, 1)
						sActiveKey = sPropKey
					else
						setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, sPropKey, 0)
					end
				end
				if sActiveKey then
					setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, 'STATE_RELIGION', sActiveKey)
					print('changed state religion to ', sActiveKey)
				else
					-- No state religion active: clear STATE_RELIGION back to 'none chosen'.
					pPlayer:SetProperty('STATE_RELIGION', nil)
					print('cleared state religion (none active)')
				end
			end
		end
	end
end

--function LostWonderSpecialist(newPlayerID , oldPlayerID , newCityID , cityX ,cityY)
	-- if city has Great Library
	-- if city has Guild of Hammers
	-- if city has Luonnotar (well you wrecked lol) (maybe we store it for reconquering?)
	-- if city has Hall of Kings
--end
--GameEvents.CityConquered.Add(LostWonderSpecialist);

-- Recompute the '<SHORT>_CITIES' capital-plot properties for a player: set to 1 if
-- ANY of their cities has at least one follower of that religion, else 0. These gate
-- which state religions the player may slot. Writes only on change to avoid churn.
function RealizeReligionCityProperties(iPlayerID)
	local pPlayer = Players[iPlayerID]
	if not pPlayer or not pPlayer:IsMajor() then return; end
	local pCities = pPlayer:GetCities()
	if not pCities then return; end
	local pCapitalCity = pCities:GetCapitalCity()
	if not pCapitalCity then return; end                  -- no capital yet; nothing to gate on
	local pCapitalPlot = pCapitalCity:GetPlot()

	-- Which tracked religions have >=1 follower anywhere in the empire.
	-- NB: GetReligionsInCity() is nil in this gameplay state (it's UI-context); the
	-- portable gameplay API is GetNumFollowers(religionIndex), so poll the 7 we track.
	local tHasFollowers = {}
	for _, pCity in pCities:Members() do
		local pCityReligion = pCity:GetReligion()
		for eReligion, sPropKey in pairs(m_tReligionCityProps) do
			if pCityReligion:GetNumFollowers(eReligion) > 0 then
				tHasFollowers[sPropKey] = true
			end
		end
	end

	for eReligion, sPropKey in pairs(m_tReligionCityProps) do
		local iCurrent = pCapitalPlot:GetProperty(sPropKey) or 0
		local iDesired = tHasFollowers[sPropKey] and 1 or 0
		if iCurrent ~= iDesired then
			setPlayerPropForRequirementsCapital(pPlayer, pCapitalPlot, sPropKey, iDesired)
		end
	end
end

-- Immediate: a city's follower counts changed. Self-heal: recompute every player's
-- flags at their turn start, covering city loss/transfer that fires no follower event.
Events.CityReligionFollowersChanged.Add( function(iPlayerID) RealizeReligionCityProperties(iPlayerID); end );
GameEvents.PlayerTurnStarted.Add( RealizeReligionCityProperties );

GameEvents.BuildingConstructed.Add(SeedStateReligionProperties);
GameEvents.PolicyChanged.Add(OnPolicyChanged);
