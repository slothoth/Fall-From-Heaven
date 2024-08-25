-- 7 levels:
ranges = {{min = 0, max = 49, category = 1},        -- Empty (<50): -2 amenities
          { min = 50, max = 99, category = 2 },     -- Low (50 - 100): -1 amenities
          { min = 100, max = 149, category = 3 },   -- Normal (100 - 149): nothing
          { min = 150, max = 199, category = 4 },   -- Stocked (150 - 199): +1 Amenity
          { min = 200, max = 299, category = 5 },   -- Abundant (200 - 299): 10% prod, +2 Amenity
          { min = 300, max = 499, category = 6 },   -- Full (300 - 499): 25% prod, +2 Amenity
          { min = 501, max = 99999, category = 7 } } -- Overflowing (499+): 40% prod, +3 Amenity, +25% GPP

function RecalculateVaults(playerID)
    local pPlayer = Players[playerID]
    if not pPlayer:IsMajor() then return; end;
    -- local pPlayerConfig = PlayerConfigurations[playerID]
    -- local sCivName = pPlayerConfig:GetCivilizationTypeName()
    -- print(sCivName)
    --if sCivName == 'SLTH_CIVILIZATION_KHAZAD' then return end;
    local pPlayerCities = pPlayer:GetCities()
    if not pPlayerCities then return; end;
    local iCityCount = pPlayerCities:GetCount()
    local iCurrentGold = pPlayer:GetTreasury():GetGoldBalance()
    local fVaultGold =  iCurrentGold / iCityCount;
    local iVaultLevel = 2
    for _, range in ipairs(ranges) do
        if fVaultGold >= range.min and fVaultGold <= range.max then
            iVaultLevel =  range.category
        end
    end
    local pPlot = ''
    for idx, pCity in pPlayerCities:Members() do
        pPlot = pCity:GetPlot();
        pPlot:SetProperty('vault_level', iVaultLevel)
    end
end

-- GameEvents.PlayerTurnStarted.Add(RecalculateVaults);
local bKhazadPresent
local sCivType
for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
    if not bKhazadPresent then
		sCivType = PlayerConfigurations[v]:GetCivilizationTypeName()
        if sCivType == 'SLTH_CIVILIZATION_KHAZAD' then
            bKhazadPresent = true
            GameEvents.PlayerTurnStarted.Add(RecalculateVaults);
        end
	end
end

--function VaultGoldChange(playerID, yield , balance) end

--function VaultSettleChange() end

-- function VaultConquerChange(newPlayerID, oldPlayerID, newCityID, cityX, cityY) end

-- GameEvents.TreasuryChanged.Add(VaultGoldChange);
-- GameEvents.CityBuilt.Add(RecalculateCityCount);
-- GameEvents.CityConquered.Add(RecalcCities);
-- CityInitialized?