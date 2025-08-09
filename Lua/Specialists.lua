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
				local pCapitalCity = pCities:GetCapitalCity()
				if pCapitalCity then
					local pPlot = pCapitalCity:GetPlot()
					for eStatePolicyIndex, sPropKey in pairs(m_tStateReligionPolicies) do
						if eStatePolicyIndex == ePolicyIndex then
							pPlot:SetProperty(sPropKey, 1)
							print('changed state religion to ', sPropKey)
						else
							pPlot:SetProperty(sPropKey, 0)
						end
					end
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

GameEvents.PolicyChanged.Add(OnPolicyChanged);
