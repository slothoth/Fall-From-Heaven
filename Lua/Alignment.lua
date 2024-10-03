tLeaderAlignmentMap = {
    ['SLTH_LEADER_ALEXIS']=0, ['SLTH_LEADER_FLAUROS']=0, ['SLTH_LEADER_KEELYN']=0, ['SLTH_LEADER_PERPENTACH']=0,
    ['SLTH_LEADER_HYBOREM']=0, ['SLTH_LEADER_TEBRYN']=0, ['SLTH_LEADER_OS-GABELLA']=0, ['SLTH_LEADER_JONAS']=0,
    ['SLTH_LEADER_SHEELBA']=0, ['SLTH_LEADER_CHARADON']=0, ['SLTH_LEADER_MAHALA']=0,
    ['SLTH_LEADER_AURIC']=0, ['SLTH_LEADER_FAERYL']=0,

    ['SLTH_LEADER_VALLEDIA']=1, ['SLTH_LEADER_DAIN']=1, ['SLTH_LEADER_DECIUS_BANNOR']=1,
    ['SLTH_LEADER_DECIUS_MALAKIM']=1, ['SLTH_LEADER_DECIUS_CALABIM']=1, ['SLTH_LEADER_CASSIEL']=1,
    ['SLTH_LEADER_TASUNKE']=1, ['SLTH_LEADER_RHOANNA']=1, ['SLTH_LEADER_FALAMAR']=1, ['SLTH_LEADER_HANNAH']=1,
    ['SLTH_LEADER_AMELANCHIER']=1, ['SLTH_LEADER_ARENDEL']=1, ['SLTH_LEADER_THESSA']=1, ['SLTH_LEADER_ARTURUS']=1,
    ['SLTH_LEADER_KANDROS']=1, ['SLTH_LEADER_SANDALPHON']=1,

    ['SLTH_LEADER_SABATHIEL']=2, ['SLTH_LEADER_CAPRIA']=2, ['SLTH_LEADER_ETHNE']=2, ['SLTH_LEADER_EINION']=2,
    ['SLTH_LEADER_CARDITH']=2, ['SLTH_LEADER_VARN']=2, ['SLTH_LEADER_BASIUM']=2,
    ['SLTH_LEADER_GARRIM']=2, ['SLTH_LEADER_BEERI']=2
}

tReligionFromGood = {['RELIGION_ISLAM']=1, ['RELIGION_HINDUISM']=1}
tReligionFromEvil = {['RELIGION_JUDAISM']=1, ['RELIGION_CONFUCIANISM']=1}
tReligionForceAlignment = {['RELIGION_PROTESTANTISM']=2, ['RELIGION_BUDDHISM']=0}

tReligionAlignment = {
    ['RELIGION_ISLAM']=0, ['RELIGION_HINDUISM']=0, ['RELIGION_BUDDHISM']=0,
    ['RELIGION_CATHOLICISM']=1,
    ['RELIGION_JUDAISM']=2, ['RELIGION_CONFUCIANISM']=2, ['RELIGION_PROTESTANTISM']=2
}
tAlignmentPropKeys = {[0]='alignment_evil', [1]='alignment_neutral', [2]='alignment_good'}

-- pPlayerUnits:SetBuildDisabled(m_ePlagueDoctorUnit, true);

tReligousCivicTrigger = {
[GameInfo.Civics['CIVIC_ORDERS_FROM_HEAVEN'].Index]=GameInfo.Religions["RELIGION_PROTESTANTISM"].Index,
[GameInfo.Civics['CIVIC_HONOR'].Index]=GameInfo.Religions["RELIGION_JUDAISM"].Index,
[GameInfo.Civics['CIVIC_WAY_OF_THE_EARTHMOTHER'].Index]=GameInfo.Religions["RELIGION_CONFUCIANISM"].Index,
[GameInfo.Civics['CIVIC_WAY_OF_THE_FORESTS'].Index]=GameInfo.Religions["RELIGION_CATHOLICISM"].Index,
[GameInfo.Civics['CIVIC_MESSAGE_FROM_THE_DEEP'].Index]=GameInfo.Religions["RELIGION_HINDUISM"].Index,
[GameInfo.Civics['CIVIC_DECEPTION'].Index]=GameInfo.Religions["RELIGION_ISLAM"].Index,
[GameInfo.Civics['CIVIC_CORRUPTION_OF_SPIRIT'].Index]=GameInfo.Religions["RELIGION_BUDDHISM"].Index}

tReligions = {
    [GameInfo.Religions["RELIGION_PROTESTANTISM"].Index] = {
        [1] = GameInfo.Beliefs["BELIEF_RELIGIOUS_IDOLS"].Hash,
        [2] = GameInfo.Beliefs["BELIEF_LAY_MINISTRY"].Hash },
    [GameInfo.Religions["RELIGION_JUDAISM"].Index] = {
        [1] = GameInfo.Beliefs["BELIEF_GOD_OF_THE_OPEN_SKY"].Hash,
        [2] = GameInfo.Beliefs["BELIEF_PAPAL_PRIMACY"].Hash },
    [GameInfo.Religions["RELIGION_CONFUCIANISM"].Index] = {
        [1] = GameInfo.Beliefs["BELIEF_STONE_CIRCLES"].Hash,
        [2] = GameInfo.Beliefs["BELIEF_PILGRIMAGE"].Hash },
    [GameInfo.Religions["RELIGION_CATHOLICISM"].Index] = {
        [1] = GameInfo.Beliefs["BELIEF_DESERT_FOLKLORE"].Hash,
        [2] = GameInfo.Beliefs["BELIEF_STEWARDSHIP"].Hash },
    [GameInfo.Religions["RELIGION_HINDUISM"].Index] = {
        [1] = GameInfo.Beliefs["BELIEF_DANCE_OF_THE_AURORA"].Hash,
        [2] = GameInfo.Beliefs["BELIEF_TITHE"].Hash },
    [GameInfo.Religions["RELIGION_ISLAM"].Index] = {
        [1] = GameInfo.Beliefs["BELIEF_GOD_OF_THE_SEA"].Hash,
        [2] = GameInfo.Beliefs["BELIEF_WORLD_CHURCH"].Hash },
    [GameInfo.Religions["RELIGION_BUDDHISM"].Index] = {
        [1] = GameInfo.Beliefs["BELIEF_INITIATION_RITES"].Hash,
        [2] = GameInfo.Beliefs["BELIEF_CROSS_CULTURAL_DIALOGUE"].Hash } }

tAnimalBeastSiege = {['PROMOTION_CLASS_BEAST']=1, ['PROMOTION_CLASS_ANIMAL']=1, ['PROMOTION_CLASS_SIEGE']=1}

iINFERNAL_PACT_INDEX = GameInfo.Civics["CIVIC_INFERNAL_PACT"].Index
local iReligionVeil = GameInfo.Religions["RELIGION_BUDDHISM"].Index


function onReligionSwitch(sReligion)                -- TODO not attached to anything currently
    -- get pPlayer somehow
    local iCurrentAlignment = pPlayer:GetProperty('alignment')
    local iNewAlignment = tReligionForceAlignment[sReligion]
    if not iNewAlignment then
        if iCurrentAlignment == 2 then
            iNewAlignment = tReligionFromGood[sReligion]
        elseif iCurrentAlignment==0 then
            iNewAlignment = tReligionFromGood[sReligion]
        end
    end
    if iNewAlignment then
        pPlayer:SetProperty('alignment', iNewAlignment)
        local pPlot = pPlayer:GetCities():GetCapitalCity():GetPlot()
        pPlot:SetProperty(tAlignmentPropKeys[iNewAlignment], 1)
        pPlot:SetProperty(tAlignmentPropKeys[iCurrentAlignment], 0)
    end
end

-- give ability based on percent change on city religions, ugh thats definitely lua
-- forced religion: religious units, their specific summons, associated like Drown, associated with religious building
-- eg asylum and lunatic.
-- kept on upgrading
-- needs to be living/not angel or demon. Also ban beasts and animals
-- also good/neutral cities grant angels/demons urgh
-- Manes also possible if  they 'have knowledge of the evil arcane principles of Death or Entropy' from wiki
-- so those spheres, just always?
-- apparently spawning uses Pseudo-random distribution
-- Pseudo-random number generation is involved in determining if the unit will return
-- as is the number of players in the game and the XP of the unit.
-- is agnostic neutral?
-- do we need to assign alignment if unit is non-living?

--Plan:
-- On unit spawn, if unit is non-living or beast or animal, return
-- if not then we do a check of the owned city to see its religions and religious buildings.
-- use that to decide unit religion if any, and then use that religion to decide alignment
-- if the unit was summoned, we will do inheritance from owner to be implemented. Although again non-living and beast applies

-- on unit death, check if unit is eligible, alive, not beast or animal or siege, has good alignment

-- potential issues: checking city might need to account for spawning on Encampment.

function alignmentDeath(killedPlayerID, killedUnitID, playerID, unitID)
    local iUnitToGrant
    local iPlotSpawnedLocation
    local iGrantPlayer
    local pPlayer = Players[killedPlayerID]
    local pUnit = pPlayer:GetUnits():FindID(killedUnitID);
    if not pUnit then return; end
    local pUnitAbilities = pUnit:GetAbility()
    -- or pUnit:GetExperience():HasPromotion() -- once we have magic do entropy and death promos.
    if pUnitAbilities:HasAbility('ALIGNMENT_EVIL') then
        iUnitToGrant = GameInfo.Units['SLTH_UNIT_MANES'].Index
        iPlotSpawnedLocation = Game:GetProperty('InfernalPlot')
        iGrantPlayer = Game:GetProperty('Infernal', playerID)
    elseif pUnitAbilities:HasAbility('ALIGNMENT_GOOD') then
        iUnitToGrant = GameInfo.Units['SLTH_UNIT_ANGEL'].Index
        iPlotSpawnedLocation = Game:GetProperty('MercurianGatePlot')
        iGrantPlayer = Game:GetProperty('Mercurian')
        print('prepping to grant angel')
    else
        print('unit doesnt have an alignment')
        return
    end
    if not iPlotSpawnedLocation then print('no spawn location, not spawning'); return; end
    local pKillingPlayer = Players[playerID]
    local pUnitKiller = pKillingPlayer:GetUnits():FindID(unitID);
    local sUnitName = pUnit:GetType()
    if tAnimalBeastSiege[GameInfo.Units[sUnitName].PromotionClass] or pUnitKiller:GetAbility():HasAbility('NETHER_BLADE') then
        print('unit is beast or siege or animal or killed by nether blade')
        return
    end
    local bIsNotAlive = pUnitAbilities:HasAbility('ABILITY_ANGEL') or pUnitAbilities:HasAbility('ABILITY_DEMON') or pUnitAbilities:HasAbility('ABILITY_UNDEAD')
    if bIsNotAlive then
        print('Unit isnt alive, dont grant')
        return
    end
    -- passed checks for eligibility, now do pseudo random, deaths since success.
    local pGrantPlayer = Players[iGrantPlayer]
    local playerUnits = pGrantPlayer:GetUnits();
    local pPlot = Map.GetPlotByIndex(iPlotSpawnedLocation)
    local iX, iY = pPlot:GetX(), pPlot:GetY()
	playerUnits:Create(iUnitToGrant, iX, iY);
end

function RespawnerSpawned(playerID, cityID, buildingID, plotID, isOriginalConstruction)
    if buildingID == GameInfo.Buildings['BUILDING_PALACE'].Index then
        local pPlayer = Players[playerID]
        if PlayerConfigurations[playerID]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_INFERNAL' then
            Game:SetProperty('InfernalPlot', plotID)
            AdjustArmageddonCount(5)            -- Compact broken
        end
        local iAlignment = pPlayer:GetProperty('alignment') or 0
        local pPlot = Map.GetPlotByIndex(plotID)
        pPlot:SetProperty(tAlignmentPropKeys[iAlignment], 1)
    elseif buildingID == GameInfo.Buildings['SLTH_BUILDING_MERCURIAN_GATE'].Index then
        local iBasiumPlayerID = Game:GetProperty('Mercurian')
        if playerID == iBasiumPlayerID then return end              -- city transfer rebuilds the wonder so stops recursive calls
        print('Mercurian Gate founded')
        Game:SetProperty('MercurianGatePlot', plotID)
        if iBasiumPlayerID then
            local pCity = CityManager.GetCity(playerID, cityID)
            if pCity then
                CityManager.TransferCity(pCity, iBasiumPlayerID, -1821839791)     -- enum CityTransferTypes.BY_GIFT
                GrantTechParity(iBasiumPlayerID, playerID)
                GrantCultureParity(iBasiumPlayerID, playerID)               -- also need to do diplo modifier or alliance.
            end
        end
        AdjustArmageddonCount(5)            -- Compact broken
    end
end

function GrantReligion(playerID, unitID)
    -- deal with Encampment district issues
    -- if somehow not in a city, its a summon, implement that later (or dont even)?
    local pPlayer = Players[playerID]
    local pUnit =  pPlayer:GetUnits():FindID(unitID)
    local iX, iY = pUnit:GetLocation()
    local pPlot = Map.GetPlot(iX, iY)
    local pCity = Cities.GetPlotPurchaseCity(pPlot:GetIndex())
    if pCity then
        local tiReligions = City:GetReligion():GetReligionsInCity()
        if tiReligions then
            local pUnitAbilities = pUnit:GetAbility()
            local CHANCE_OF_GRANT_RELIGION = 15
            for idx, val in ipairs(tiReligions) do                  --TODO needs testing to see what this table contains
                local iAttempt = math.random(0, 99)
                if iAttempt > CHANCE_OF_GRANT_RELIGION then
                    local iAlignment = tReligionAlignment[val]
                    if iAlignment then
                        if iAlignment == 0 then
                            pUnitAbilities:AddAbilityCount('ALIGNMENT_EVIL')   -- does this function even work.
                        elseif iAlignment == 1 then
                            pUnitAbilities:AddAbilityCount('ALIGNMENT_GOOD')
                        end
                        break
                    end
                end
            end
        end
    end
end

function GrantReligionFromCivicCompleted(playerID, civicIndex, isCancelled)
    local iReligion = tReligousCivicTrigger[civicIndex]
    if iReligion then
        local bHolyCityEstablished = Game:GetProperty(tostring(iReligion)..'_HOLY_CITY_EXISTS') or 0
        local pPlayer = Players[playerID]
        local pPlayerCities = pPlayer:GetCities()
        local tCityReligionFollowers
        local pLeastReligionsCity
        local iCityPop
        local iLeastFollowersCityCount = 2
        for idx, pCity in pPlayerCities:Members() do
            iCityPop = pCity:GetPopulation()
            print(iCityPop)
            local iFollowers = 0
            for i in GameInfo.Religions() do
                iFollowers = iFollowers + pCity:GetReligion():GetNumFollowers(i.Index)
                print(iFollowers)
            end
            if iFollowers == 0 then
                tCityReligionFollowers = 0
            else
                tCityReligionFollowers = iFollowers / iCityPop
            end
            if tCityReligionFollowers == 0 then
                pLeastReligionsCity = pCity
                break
            end
            if tCityReligionFollowers < iLeastFollowersCityCount then
                iLeastFollowersCityCount = tCityReligionFollowers
                pLeastReligionsCity = pCity
            end
        end
        pLeastReligionsCity:GetReligion():AddReligiousPressure(playerID, iReligion, 1000)
        if bHolyCityEstablished < 1 then
            Game:SetProperty(tostring(iReligion)..'_HOLY_CITY_EXISTS', 1)
            local pPlot = pLeastReligionsCity:GetPlot()
            pPlot:SetProperty(tostring(iReligion)..'_HOLY_CITY', 1)
            if iReligion == iReligionVeil then
                AdjustArmageddonCount(5)
            end
        end
    end
    if civicIndex == iINFERNAL_PACT_INDEX then
        local iInfernalPlayerId = Game:GetProperty('Infernal')
        -- transfer city here. Grant all techs of previous civ? Make good city location?
        GrantTechParity(iInfernalPlayerId, playerID)
        GrantCultureParity(iInfernalPlayerId, playerID)
    end
end

function GrantTechParity(iPlayerGrantedTechs, iPlayerTechGranter)
    local pPlayerGrantedTechs = Players[iPlayerGrantedTechs]
    local pPlayerTechGranter = Players[iPlayerTechGranter]
    if not pPlayerGrantedTechs then return end
    if not pPlayerTechGranter then return end
    local pTechsGrantedTechs = pPlayerGrantedTechs:GetTechs()
    local pTechsTechGranter = pPlayerTechGranter:GetTechs()
    for techRow in GameInfo.Technologies() do
        local iTechIndex = techRow.Index
        if pTechsTechGranter:HasTech(iTechIndex) then
            print(techRow.Index)
            pTechsGrantedTechs:SetTech(iTechIndex, true)
        end
    end
end

function GrantCultureParity(iPlayerGrantedCivics, iPlayerCivicGranter)
    local pPlayerGrantedCivics = Players[iPlayerGrantedCivics]
    local pPlayerCivicGranter = Players[iPlayerCivicGranter]
    if not pPlayerGrantedCivics then return end
    if not pPlayerCivicGranter then return end
    local pCivicsGrantedCivics = pPlayerGrantedCivics:GetCulture()
    local pCivicsCivicGranter = pPlayerCivicGranter:GetCulture()
    for civicRow in GameInfo.Civics() do
        local iCivicIndex = civicRow.Index
        print(civicRow.Index)
        if pCivicsCivicGranter:HasCivic(iCivicIndex) then
            print(civicRow.Index)
            pCivicsGrantedCivics:SetCivic(iCivicIndex, true)
        end
    end
end

function AdjustArmageddonCount(iAmount)
    local iArmageddonCount = Game.GetProperty('ARMAGEDDON')
    if iArmageddonCount then
        Game.SetProperty('ARMAGEDDON', iArmageddonCount + iAmount)
    else
        print('Armageddon count not initilizaed!')
    end
end

function InitiateReligions()
    local aPlayers = PlayerManager.GetAliveMinors();            -- will minors work? if so need 7 in game
    local pGameReligion = Game.GetReligion();
    local iMinorPlayer = 1
    for sReligion, tReligion in pairs(tReligions) do
        local pMinorPlayer = aPlayers[iMinorPlayer]
        local pReligion = pMinorPlayer:GetReligion();

        pGameReligion:FoundPantheonHash(iMinorPlayer,  tReligion[1]);
        pGameReligion:FoundReligion(iMinorPlayer,  sReligion);
        pGameReligion:AddBeliefHash(iMinorPlayer,  tReligion[2]);
        pReligion:SetHolyCity(pMinorPlayer:GetCities():GetCapitalCity());
        pReligion:ChangeNumBeliefsEarned(1);
        iMinorPlayer = iMinorPlayer + 1
    end
end
function onStart()
    for iPlayerID, pPlayer in pairs(PlayerManager.GetWasEverAliveMajors()) do
        local alignment = pPlayer:GetProperty('alignment')
        local sLeaderName = PlayerConfigurations[iPlayerID]:GetLeaderTypeName()
        if not alignment then
            local iLeaderAlignment =  tLeaderAlignmentMap[sLeaderName]
            if iLeaderAlignment then
                pPlayer:SetProperty('alignment', iLeaderAlignment)
            else
                pPlayer:SetProperty('alignment', -1)                -- to catch errors, remove at production
            end
        end
        if sLeaderName == 'SLTH_LEADER_HYBOREM' then
            Game:SetProperty('Infernal', iPlayerID)
        end
        if sLeaderName == 'SLTH_LEADER_BASIUM' then
            Game:SetProperty('Mercurian', iPlayerID)
        end
    end
    if not Game.GetProperty('ARMAGEDDON') then          -- initalize armageddon
        Game.SetProperty('ARMAGEDDON',  0)
    end
end

Events.UnitKilledInCombat.Add(alignmentDeath)
GameEvents.BuildingConstructed.Add(RespawnerSpawned)
Events.UnitAddedToMap.Add(GrantReligion)                         -- test UnitAbilityGained
LuaEvents.NewGameInitialized.Add(onStart);
LuaEvents.NewGameInitialized.Add(InitiateReligions);
Events.CivicCompleted.Add(GrantReligionFromCivicCompleted)
