local sWorldSpellPropKey = 'WorldSpellReady'

function Sanctuary(iPlayer, tParameters)
	-- force out of borders ugh. Maybe there is an easy way to do this, since borders close push out exists.
    -- but dunno how to enforce it continously
	print('world spell not implemented')
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function Legends(iPlayer, tParameters)
	-- applies every city and every settlement +300 culture (map size: huge).
    local pPlayer = Players[iPlayer]
    local iCultureToAdd = 0
    for _, pCity in pPlayer:GetCities():Members() do
        -- todo also add plots in cities but dunno how
        iCultureToAdd = iCultureToAdd + 300
    end
    pPlayer:GetCulture():ChangeCurrentCulturalProgress(iCultureToAdd)
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function IntoTheMist(iPlayer, tParameters)
	-- When used, the spell gives the Hidden Promotion to all of the civilizations units.  I thought it did diplo stuff
    -- quite easy, just give ability like Camoflage
    local pPlayer = Players[iPlayer]
    pPlayer:AttachModifierByID('MODIFIER_INTO_THE_MIST')
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end


function RagingSeas(iPlayer, tParameters)
	-- Damages all non-Lanun units adjacent to a body of water, and has a chance to destroy non-Lanun improvements in the water, such as fishing boats.
	-- The damage will not cause players to declare war on you.
    -- iterate over all players and all units, check if plot is coastal
    -- also puts out smoke and flames?
    -- also destroys non lanun improvements by sea by chance
    for idx, pPlayer in ipairs(Players) do
        if idx ~= iPlayer then
            for _, pUnit in pPlayer:GetUnits():Members() do
                local iX = pUnit:GetX()
                local iY = pUnit:GetY()
                local pPlot = Map.GetPlot(iX, iY)
                if (pPlot:IsCoastalLand()) or (pPlot:IsWater()) then
                    pUnit:ChangeDamage(75);                         -- when we do elemental, this is cold damage
                    if pUnit:GetDamage() >= 100 then
                        UnitManager.Kill(pUnit, false);
                    end
                end
            end
        end
    end
    local tTable = Map.Plots()
    for i, iPlotIndex in ipairs(tTable) do
        local pPlot = Map.GetPlotByIndex(iPlotIndex)
        if (pPlot ~= nil) then
            local iImprovementOwner = pPlot:GetOwner()
            if iImprovementOwner ~= iPlayer then
                if (pPlot:IsWater() or (pPlot:IsCoastalLand())) then
                    local iPlotX, iPlotY = pPlot:GetX(), pPlot:GetY()
                    if pPlot:GetImprovementType() ~= -1 then                -- does this hold
                        ImprovementBuilder.SetImprovementType(pPlot, -1, iImprovementOwner)     -- todo do chance
                    end
                end
            end
        end
    end
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function Ardor(iPlayer, tParameters)
	-- resets the GreatPeopleCount. Makes no sense in civ vi context.
    -- RWORK: Maybe it grants like 80% refund on great people then 70 after getting one and so on down to 0?
	print('world spell not implemented')
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function WarCry(iPlayer, tParameters)
	-- Grants the Warcry ability to all units.
	-- Warcry promotions grants:
    --- Can attack multiple times per turn
    --- +1 Movement range
    --- +4 Strength
    --- +5% Chance of wearing off each turn
    local pPlayer = Players[iPlayer]
    local sPropbuff_propkey = ('BUFF_WARCRY_UNITS')
    local tSpecificBuffState = Game:GetProperty(sPropbuff_propkey) or {}
    for iUnitIndex, pUnit in pPlayer:GetUnits():Members() do
        local pUnitAbilities = pUnit:GetAbility()
        pUnitAbilities:AddAbilityCount('BUFF_WARCRY')
        local tUnitInfos = {iPlayer=iPlayer, iUnit=iUnitIndex, iCasterPlayer=iPlayer}       -- test iUnitIndex isnt just incremental index
        table.insert(tSpecificBuffState, tUnitInfos)
    end
    Game:SetProperty(sPropbuff_propkey, tSpecificBuffState)
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function WildHunt(iPlayer, tParameters)
	-- Grant a wolf for each combat unit you have. Wolf strength proportional to unit strength.
    local pPlayer = Players[iPlayer]
    for _, pUnit in pPlayer:GetUnits():Members() do
        local tNewUnits = BaseSummon(pUnit, iPlayer, iUNIT_WOLF)
        local iCombatStrength = pUnit:GetCombat()
        if iCombatStrength > 15 then
            local iExtraStrength = (iCombatStrength - 10) / 2
            local iMinorGrants = math.floor(iExtraStrength / 4)
            if iMinorGrants > 0 then
                for iUnitID, pWolfUnit in pairs(tNewUnits) do
                    local pUnitAbilities = pWolfUnit:GetAbility()
                    for var=1, iMinorGrants do
                        pUnitAbilities:AddAbilityCount('BUFF_EMPOWER')
                    end
                end
            end
        end
    end
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function Revelry(iPlayer, tParameters)            -- TODO
	-- Double length Golden age. Needs to check gamespeed for golden age speed. then fix golden age granting.
    local pPlayer = Players[iPlayer]
    local eGameSpeed = GameConfiguration.GetGameSpeedType()            -- this is actually a hash not a string return. But cant find the enum for it
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier
    local iGoldenAgeLength = math.floor(20 * iSpeedCostMultiplier)
    GoldenAgeGrant(pPlayer,iGoldenAgeLength)
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

local iGOLDEN_HAMMER = GameInfo.Units['SLTH_EQUIPMENT_GOLDEN_HAMMER'].Index
function GiftsOfNantosuelta(iPlayer, tParameters)
	-- Grant a Golden Hammer equipment in each of your cities
    local pPlayer = Players[iPlayer]
    local playerUnits = pPlayer:GetUnits()
    for _, pCity in pPlayer:GetCities():Members() do
        local pPlot = pCity:GetPlot()
        local iX = pPlot:GetX()
        local iY = pPlot:GetY()
        playerUnits:Create(iGOLDEN_HAMMER, iX, iY);
    end
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function VeilOfNight(iPlayer, tParameters)
	-- Hidden nationality to all units
    -- this seems DLL bound
	print('world spell not implemented')
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function RiverOfBlood(iPlayer, tParameters)
	-- Increase all player city pops by 2, decrease all opponent by 2
    -- get all cities of each player not the caster
    -- if more than 2, reduce pop by 2. if 2, reduce pop by 1, otherwise ignore.
    for iPlayerID, pPlayer in ipairs(Players) do
        if (iPlayerID == iPlayer) then
            for _, pCity in pPlayer:GetCities():Members() do
                pCity:ChangePopulation(2)
            end
        elseif iPlayerID ~= 63 then
            for _, pCity in pPlayer:GetCities():Members() do
                local iCityPop = pCity:GetPopulation()
                local iReduction = 0
                if iCityPop == 2 then
                    iReduction = 1
                elseif iCityPop > 2 then
                    iReduction = 2
                end
            end
        end
    end
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function WorldBreak(iPlayer, tParameters)
	-- deal damage to all non-sheaim units equal to the armageddon count
    -- it also does a pillar of fire effect on cities, and smoke on forests?
    local iDamage = Game:GetProperty('ARMA')
    if iDamage > 100 then
        iDamage = 100
    end
    if iDamage > 0 then
        for iPlayerID, pPlayer in ipairs(Players) do
            if iPlayerID ~= iPlayer then
                for _, pUnit in pPlayer:GetUnits():Members() do
                    pUnit:ChangeDamage(iDamage)
                    if pUnit:GetDamage() >= 100 then
                        UnitManager.Kill(pUnit, false);
                    end
                end
            end
        end
    end
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

function Stasis(iPlayer, tParameters)
	-- prevent all players but the illians researching or producing anything for x turns
    -- that would be a -100% modifier on culture, science and production.
    -- do this by having a modifier on all player capitals, that needs a plotprop.
    local iNewStasis
    local iX, iY
    local eGameSpeed = GameConfiguration.GetGameSpeedType()            -- this is actually a hash not a string return. But cant find the enum for it
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier
    local iDelay = math.floor(20 * iSpeedCostMultiplier)
    local iCurrentStasis = Game:GetProperty('STASIS_COUNTDOWN')
    if iCurrentStasis then
        iNewStasis = iCurrentStasis + iDelay
    else
        iNewStasis = iDelay
    end
    Game:SetProperty('STASIS_COUNTDOWN', iNewStasis)
    for iPlayerID, pPlayer in ipairs(Players) do
        if true then
            local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
            if pCapitalCity then
                iX = pCapitalCity:GetX()
                iY = pCapitalCity:GetY()
                local pCapitalPlot = Map.GetPlot(iX, iY)
                pCapitalPlot:SetProperty('InStasis', 1)
            end
        end
    end
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
    local sDescription = 'Illians have cast Stasis. No Production, Science or Culture for ' .. tostring(iDelay) .. ' turns.'
    NotificationManager.SendNotification(iPlayer, NotificationTypes.USER_DEFINED_2, 'Stasis Cast', sDescription, iX, iY)
end

local tDivineRetribution = {DEMON=true, UNDEAD=true}
function DivineRetribution(iPlayer, tParameters)
	-- deal holy damage to demons and undead.
    for iPlayerID, pPlayer in ipairs(Players) do
        for _, pUnit in pPlayer:GetUnits():Members() do
            local iUnitIndex =  pUnit:GetType()
            local tUnitInfo = GameInfo.Units[iUnitIndex]
            if tUnitInfo then
                local sUnitType = tUnitInfo.UnitType
                local tRaceInfo = GameInfo.UnitsNotAlive[sUnitType]
                local sRace = tRaceInfo.Race
                if tDivineRetribution[sRace] then                          --
                    local iDamageDealt = math.random(50, 100)
                    pUnit:ChangeDamage(iDamageDealt)
                    if pUnit:GetDamage() >= 100 then
                        UnitManager.Kill(pUnit, false);
                    end
                end
            end
        end
    end
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

local iVEIL_RELIGION_INDEX = GameInfo.Religions["RELIGION_BUDDHISM"].Index
function HyboremsWhisper(iPlayer, tParameters)
	-- take over best veil city.
    local tVeilCities = {}
    for iPlayerID, pPlayer in ipairs(Players) do
        if iPlayerID ~= iPlayer then
            for _, pCity in pPlayer:GetCities():Members() do
                local pPlot = pCity:GetPlot();
                local iX = pPlot:GetX()
                local iY = pPlot:GetY()
                local pCityReligion = pCity:GetReligion()
                local iNumFollowers = pCityReligion:GetNumFollowers(iVEIL_RELIGION_INDEX)
                if iNumFollowers > 0 then
                    table.insert(tVeilCities, pCity)
                end
            end
        end
    end
    local iLargestVeilPop = 0
    local pVeilBiggestCity
    for _, pCity in ipairs(tVeilCities) do
        local iCityPop = pCity:GetPopulation()
        if iCityPop > iLargestVeilPop then
            iLargestVeilPop = iCityPop
            pVeilBiggestCity = pCity
        end
    end
    -- transfer city
    CityManager.TransferCity(pVeilBiggestCity, iPlayer, CityTransferTypes.BY_CULTURAL_IDENTITY)
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end