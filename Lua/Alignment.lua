local tLeaderAlignmentMap = {
    ['LEADER_ALEXIS']=0, ['LEADER_FLAUROS']=0, ['LEADER_KEELYN']=0, ['LEADER_PERPENTACH']=0,
    ['LEADER_HYBOREM']=0, ['LEADER_TEBRYN']=0, ['LEADER_OSGABELLA']=0, ['LEADER_JONAS']=0,
    ['LEADER_SHEELBA']=0, ['LEADER_CHARADON']=0, ['LEADER_MAHALA']=0,
    ['LEADER_AURIC']=0, ['LEADER_FAERYL']=0,

    ['LEADER_VALLEDIA']=1, ['LEADER_DAIN']=1, ['LEADER_DECIUS_BANNOR']=1,
    ['LEADER_DECIUS_MALAKIM']=1, ['LEADER_DECIUS_CALABIM']=1, ['LEADER_CASSIEL']=1,
    ['LEADER_TASUNKE']=1, ['LEADER_RHOANNA']=1, ['LEADER_FALAMAR']=1, ['LEADER_HANNAH']=1,
    ['LEADER_AMELANCHIER']=1, ['LEADER_ARENDEL']=1, ['LEADER_THESSA']=1, ['LEADER_ARTURUS']=1,
    ['LEADER_KANDROS']=1, ['LEADER_SANDALPHON']=1,

    ['LEADER_SABATHIEL']=2, ['LEADER_CAPRIA']=2, ['LEADER_ETHNE']=2, ['LEADER_EINION']=2,
    ['LEADER_CARDITH']=2, ['LEADER_VARN']=2, ['LEADER_BASIUM']=2,
    ['LEADER_GARRIM']=2, ['LEADER_BEERI']=2
}

local tReligionFromGood = {['SLTH_POLICY_STATE_ESUS']=1, ['SLTH_POLICY_STATE_OCTOPUS']=1}
local tReligionFromEvil = {['SLTH_POLICY_STATE_EMPYREAN']=1, ['SLTH_POLICY_STATE_RUNES']=1}
local tReligionForceAlignment = {['SLTH_POLICY_STATE_ORDER']=2, ['SLTH_POLICY_STATE_VEIL']=0}

local tReligionPolicies = {['SLTH_POLICY_STATE_ESUS']=true, ['SLTH_POLICY_STATE_OCTOPUS']=true,
                           ['SLTH_POLICY_STATE_EMPYREAN']=true, ['SLTH_POLICY_STATE_RUNES']=true,
                           ['SLTH_POLICY_STATE_ORDER']=true, ['SLTH_POLICY_STATE_VEIL']=true,
                           ['SLTH_POLICY_STATE_LEAVES']=true}

local tReligionNames = {[1]='SLTH_POLICY_STATE_ESUS', [2]='SLTH_POLICY_STATE_OCTOPUS',
                           [3]= 'SLTH_POLICY_STATE_EMPYREAN', [4]='SLTH_POLICY_STATE_RUNES',
                           [5]='SLTH_POLICY_STATE_ORDER', [6]='SLTH_POLICY_STATE_VEIL', [7] = 'SLTH_POLICY_STATE_LEAVES'}

local tReligionAlignment = {
    ['RELIGION_ISLAM']=0, ['RELIGION_HINDUISM']=0, ['RELIGION_BUDDHISM']=0,
    ['RELIGION_CATHOLICISM']=1,
    ['RELIGION_JUDAISM']=2, ['RELIGION_CONFUCIANISM']=2, ['RELIGION_PROTESTANTISM']=2
}
local tAlignmentPropKeys = {[0]='alignment_evil', [1]='alignment_neutral', [2]='alignment_good'}

local tReligionAbility = {
    ['RELIGION_ISLAM']='ABILITY_WORSHIPS_ESUS', ['RELIGION_HINDUISM']='ABILITY_WORSHIPS_OCTOPUS',
    ['RELIGION_BUDDHISM']='ABILITY_WORSHIPS_VEIL',
    ['RELIGION_CATHOLICISM']='ABILITY_WORSHIPS_LEAVES', ['RELIGION_JUDAISM']='ABILITY_WORSHIPS_EMPYREAN',
    ['RELIGION_CONFUCIANISM']='ABILITY_WORSHIPS_KILMORPH', ['RELIGION_PROTESTANTISM']='ABILITY_WORSHIPS_ORDER'
}
-- pPlayerUnits:SetBuildDisabled(m_ePlagueDoctorUnit, true);

local tReligousCivicTrigger = {
[GameInfo.Civics['CIVIC_ORDERS_FROM_HEAVEN'].Index]=GameInfo.Religions["RELIGION_PROTESTANTISM"].Index,
[GameInfo.Civics['CIVIC_HONOR'].Index]=GameInfo.Religions["RELIGION_JUDAISM"].Index,
[GameInfo.Civics['CIVIC_WAY_OF_THE_EARTHMOTHER'].Index]=GameInfo.Religions["RELIGION_CONFUCIANISM"].Index,
[GameInfo.Civics['CIVIC_WAY_OF_THE_FORESTS'].Index]=GameInfo.Religions["RELIGION_CATHOLICISM"].Index,
[GameInfo.Civics['CIVIC_MESSAGE_FROM_THE_DEEP'].Index]=GameInfo.Religions["RELIGION_HINDUISM"].Index,
[GameInfo.Civics['CIVIC_DECEPTION'].Index]=GameInfo.Religions["RELIGION_ISLAM"].Index,
[GameInfo.Civics['CIVIC_CORRUPTION_OF_SPIRIT'].Index]=GameInfo.Religions["RELIGION_BUDDHISM"].Index}

local tReligions = {
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

local tInherentReligion = { [GameInfo.Units['SLTH_UNIT_DISCIPLE_EMPYREAN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_DISCIPLE_THE_ORDER'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_KILMORPH'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_OVERLORDS'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_ORDER'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_VEIL'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_LEAVES'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_EMPYREAN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_HIGH_PRIEST_OF_LEAVES'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_ARTHENDAIN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_BAMBUR'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_MITHRIL_GOLEM'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_PARAMANDER'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_DROWN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_HEMAH'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_SAVEROUS'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_STYGIAN_GUARD'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_CRUSADER'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_VALIN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_SPHENER'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_BEAST_OF_AGARES'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_DISEASED_CORPSE'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_ROSIER'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_MARDERO'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_FAWN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_SATYR'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_KITHRA'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_YVAIN'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_RATHA'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_RADIANT_GUARD'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_CHALID'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_SHADOW'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_SHADOWRIDER'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_NIGHTWATCH'].Index] = true,
                            [GameInfo.Units['SLTH_UNIT_GIBBON'].Index] = true
}

local tAnimalBeastSiege = {['PROMOTION_CLASS_BEAST']=1, ['PROMOTION_CLASS_ANIMAL']=1, ['PROMOTION_CLASS_SIEGE']=1}

local iINFERNAL_PACT_INDEX = GameInfo.Civics["CIVIC_INFERNAL_PACT"].Index
local iReligionVeil = GameInfo.Religions["RELIGION_BUDDHISM"].Index



function onReligionSwitch(playerID, policyID, wasEnacted)
    if not wasEnacted then return; end
    local sReligion = GameInfo.Policies[policyID].PolicyType
    if not tReligionPolicies[sReligion] then return; end
    local pPlayer = Players[playerID]
    local iCurrentAlignment = pPlayer:GetProperty('alignment')
    local iNewAlignment = tReligionForceAlignment[sReligion]
    if not iNewAlignment then
        if iCurrentAlignment == 2 then
            iNewAlignment = tReligionFromGood[sReligion]
        elseif iCurrentAlignment==0 then
            iNewAlignment = tReligionFromEvil[sReligion]
        end
    end
    local pPlot = pPlayer:GetCities():GetCapitalCity():GetPlot()
    if iNewAlignment then
        pPlayer:SetProperty('alignment', iNewAlignment)
        pPlot:SetProperty(tAlignmentPropKeys[iNewAlignment], 1)
        pPlot:SetProperty(tAlignmentPropKeys[iCurrentAlignment], 0)
        print('Setting alignment on capital plot to ' .. tostring(tAlignmentPropKeys[iNewAlignment]))
    end
    for idx, sReligionPropKey in ipairs(tReligionNames) do
        if sReligionPropKey == sReligion then
            pPlot:SetProperty(sReligionPropKey, 1)
        else
            pPlot:SetProperty(sReligionPropKey, 0)
        end
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

local tEquipmentAbilities = {
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_ATHAME'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_BLACK_MIRROR'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_CROWN_OF_COMMAND'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_DRAGONS_HORDE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_EMPTY_BIER'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_GELA'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_GODSLAYER'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_GOLDEN_HAMMER'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_HEALING_SALVE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_JADE_TORC'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_NETHER_BLADE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_ORTHUSS_AXE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_POTION_OF_RESTORATION'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_ROD_OF_WINDS'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_SCORCHED_STAFF'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_SPELL_STAFF'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_STAFF_OF_SOULS'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_TIMOR_MASK'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_TREASURE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_TREASURE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_WAR'].Index }

function alignmentDeath(killedPlayerID, killedUnitID, playerID, unitID)
    local iUnitToGrant
    local iPlotSpawnedLocation
    local iGrantPlayer
    local bIsEvil
    local bReincarnate = true
    local pUnitKiller
    local pPlayer = Players[killedPlayerID]
    local pUnit = pPlayer:GetUnits():FindID(killedUnitID);
    if not pUnit then return; end
    local pUnitAbilities = pUnit:GetAbility()
    -- or pUnit:GetExperience():HasPromotion() -- todo once we have magic do entropy and death promos.
    if pUnitAbilities:HasAbility('ALIGNMENT_EVIL') then
        iGrantPlayer = Game:GetProperty('Infernal')
        -- check player is alive
        local bIsAlive = PlayerManager.IsAlive(iGrantPlayer)              -- might disable to store manes if works
        if bIsAlive then
            bIsEvil = 1
        end
    elseif pUnitAbilities:HasAbility('ALIGNMENT_GOOD') then
        iUnitToGrant = GameInfo.Units['SLTH_UNIT_ANGEL'].Index
        iPlotSpawnedLocation = Game:GetProperty('MercurianGatePlot')
        iGrantPlayer = Game:GetProperty('Mercurian')
        print('prepping to grant angel')
    else
        bReincarnate = false
    end
    local pKillingPlayer = Players[playerID]
    if pKillingPlayer then
        pUnitKiller = pKillingPlayer:GetUnits():FindID(unitID);
    end
    if bReincarnate then
        if pUnitKiller:GetAbility():HasAbility('NETHER_BLADE') then
            print('killed by nether blade')                     -- this should also alter resurrection through property
            bReincarnate = false
        elseif tAnimalBeastSiege[GameInfo.Units[pUnit:GetType()].PromotionClass] then
            print('unit is beast or siege or animal')
            bReincarnate = false
        elseif GameInfo.UnitsNotAlive[pUnit:GetType()] then
            bReincarnate = false
        else
            -- passed checks for eligibility, now do pseudo random, deaths since success.
            local pGrantPlayer = Players[iGrantPlayer]
            if bIsEvil then
                print('attaching mod to mane')
                pGrantPlayer:AttachModifierByID('SLTH_GRANT_MANE')
            else
                local playerUnits = pGrantPlayer:GetUnits();
                local pPlot = Map.GetPlotByIndex(iPlotSpawnedLocation)
                local iX, iY = pPlot:GetX(), pPlot:GetY()
                playerUnits:Create(iUnitToGrant, iX, iY);
            end
        end
    end

    -- SECTION: Spirit guide granting experience
    if pUnitAbilities:HasAbility('BUFF_SPIRIT_GUIDE') then
        local pUnitExp = pUnit:GetExperience()
        local iCurrentExperience = pUnitExp:GetExperiencePoints()
        if  iCurrentExperience > 0 then
            local lUnits = {}
            for _, pLoopUnit in pPlayer:GetUnits():Members() do
                if pLoopUnit:GetFormationClass() == 'FORMATION_CLASS_LAND_COMBAT' then
                    table.insert(lUnits, pLoopUnit)
                end
            end
            local iCombatUnits = table.count(lUnits)
            if iCombatUnits > 0 then
                pUnit = lUnits[math.random(iCombatUnits)]
                local iXP_Grant = math.ceil(iCurrentExperience / 2)
                pUnitExp:ChangeExperience(iXP_Grant)
            end
        end
    end

    -- SECTION: Immortality
    if pUnitAbilities:HasAbility('SLTH_IMMORTAL') then
        print('UNIMPLEMENTED SAVE UNIT')                      -- move unit to capital, and remove ability
        -- local pCapital = pPlayer:GetCities():GetCapitalCity()
        -- UnitManager.PlaceUnit(pUnit, pCapital:GetX(), pCapital:GetY())
        -- or if that fails, use the clone function to save unit values, minus immortality promotion in capital
    end
    -- SECTION: Equipment dropping
    if pUnitKiller then
        local pAbilityUnit = pUnit:GetAbility()
        local iX = pUnit:GetX()
        local iY = pUnit:GetY()
        for EquipAbility, EquipUnit in pairs(tEquipmentAbilities) do
            local bHasSpecEquip = pUnitAbilities:HasAbility(EquipAbility)
            if bHasSpecEquip then
                local bAlreadyHasEquipment = pAbilityUnit:HasAbility(EquipAbility)
                if bAlreadyHasEquipment then
                    UnitManager.InitUnit(playerID, EquipUnit, iX, iY)
                else
                    pAbilityUnit:AddAbilityCount(EquipAbility) --- does this work?
                end
            end
        end
    end
end

function RespawnerSpawned(playerID, cityID, buildingID, plotID, isOriginalConstruction)
    if buildingID == GameInfo.Buildings['BUILDING_PALACE'].Index then
        local pPlayer = Players[playerID]
        local pConfig = PlayerConfigurations[playerID]
        if pConfig:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_INFERNAL' then
            Game:SetProperty('InfernalPlot', plotID)
            AdjustArmageddonCount(5)            -- Compact broken
        end
        local iAlignment = pPlayer:GetProperty('alignment') or 0                                -- set player alignment
        print('Player ' .. tostring(playerID) .. ' alignment on capital settle was ' .. tostring(iAlignment))

        local pPlot = Map.GetPlotByIndex(plotID)
        pPlot:SetProperty(tAlignmentPropKeys[iAlignment], 1)
        if tAlignmentPropKeys[iAlignment] then print('Setting alignment on capital plot ' .. tostring(tAlignmentPropKeys[iAlignment])); end

        if pConfig:GetCivilizationLevelTypeName() == 'CIVILIZATION_LEVEL_CITY_STATE' then
            print('city is city state level')
            local iGameTurn = Game.GetCurrentGameTurn()         -- five turns to settle a city state
            print('game turn is')
            print(iGameTurn)
            if iGameTurn > 3 then
                local pAllMajors = PlayerManager.GetAliveMajorIDs();            -- just hating on all civs
                local pDiplo = pPlayer:GetDiplomacy()
                for k, iterPlayerID in ipairs(pAllMajors) do
                    if (pPlayer:GetID() ~= iterPlayerID) then
                        pDiplo:SetHasMet(iterPlayerID);
                        pDiplo:DeclareWarOn(iterPlayerID, WarTypes.FORMAL_WAR, true);
                        pDiplo:NeverMakePeaceWith(iterPlayerID);
                        local pOtherPlayer = Players[iterPlayerID];
                        if(pOtherPlayer ~= nil) then
                            local pOtherDiplo = pOtherPlayer:GetDiplomacy();
                            if(pOtherDiplo ~= nil) then
                                pOtherDiplo:NeverMakePeaceWith(playerID);
                            end
                        end
                    end
                end
            end
        end
    elseif buildingID == GameInfo.Buildings['SLTH_BUILDING_MERCURIAN_GATE'].Index then
        local iBasiumPlayerID = Game:GetProperty('Mercurian')
        if playerID == iBasiumPlayerID or Game:GetProperty('mercurian_spawned') then return; end              -- city transfer rebuilds the wonder so stops recursive calls
        print('Mercurian Gate founded')
        Game:SetProperty('MercurianGatePlot', plotID)
        if iBasiumPlayerID then
            local pCity = CityManager.GetCity(playerID, cityID)
            if pCity then
                Game:SetProperty('mercurian_spawned', 1)
                CityManager.TransferCity(pCity, iBasiumPlayerID, CityTransferTypes.BY_GIFT)     -- enum CityTransferTypes.BY_GIFT
                GrantTechParity(iBasiumPlayerID, playerID)
                GrantCultureParity(iBasiumPlayerID, playerID)               -- also need to do diplo modifier or alliance.
                local pPlayer = Players[playerID]
                pPlayer:GetDiplomacy():SetPermanentAlliance(iBasiumPlayerID)
            end
        end
        AdjustArmageddonCount(5)            -- Compact broken
    end
end

function GrantReligionFromCivicCompleted(playerID, civicIndex, isCancelled)
    local iReligion = tReligousCivicTrigger[civicIndex]
    if iReligion then
        local sReligion = GameInfo.Religions[iReligion].ReligionType
        local bHolyCityEstablished = Game:GetProperty(sReligion..'_HOLY_CITY_EXISTS') or 0
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
            Game:SetProperty(sReligion ..'_HOLY_CITY_EXISTS', 1)
            local pPlot = pLeastReligionsCity:GetPlot()
            pPlot:SetProperty(sReligion ..'_HOLY_CITY', 1)
            pLeastReligionsCity:SetProperty(sReligion ..'_HOLY_CITY', 1)
            if iReligion == iReligionVeil then
                AdjustArmageddonCount(5)
            end
        end
    end
    if civicIndex == iINFERNAL_PACT_INDEX then
        local iInfernalPlayerId = Game:GetProperty('Infernal')
        local bInfernalSpawned = Game:GetProperty('infernal_spawned')
        if bInfernalSpawned then return end;
        -- find strongest city state. what if no cs
        local tpMinorCivs = PlayerManager.GetAliveMinors()
        local pCity
        local iCurrentCityPop
        local iBestCityPop = 0
        local pBestCity
        for idx, pPlayer in ipairs(tpMinorCivs) do
            pCity = pPlayer:GetCities():GetCapitalCity()
            if pCity then
                iCurrentCityPop = pCity:GetPopulation()
                if iCurrentCityPop > iBestCityPop then
                    pBestCity = pCity
                    iBestCityPop = pCity:GetPopulation()
                end
            end
        end
        if pBestCity then
            CityManager.TransferCity(pCity, iInfernalPlayerId, -1821839791)     -- enum CityTransferTypes.BY_GIFT
            GrantTechParity(iInfernalPlayerId, playerID)
            GrantCultureParity(iInfernalPlayerId, playerID)
        else
            print('no city state found. PANIC! place a city at a tribe clan a decent spot far away.')
            -- iter over plots,
            local iW, iH = Map.GetGridSize();
            local tCampTiles = {}
            local iIMPROVEMENT_BARB_CAMP = GameInfo.Improvements['IMPROVEMENT_BARBARIAN_CAMP'].Index
            for x = 0, iW - 1 do
                for y = 0, iH - 1 do
                    local i = y * iW + x;
                    local pPlot = Map.GetPlotByIndex(i);
                    local iPlotImprovement = pPlot:GetImprovementType()
                    if iPlotImprovement then
                        if iPlotImprovement == iIMPROVEMENT_BARB_CAMP then
                            tCampTiles[i] = pPlot
                        end
                    end
                end
            end
            print(table.count(tCampTiles))
            -- filter for the best camp
            --IsValidFoundLocation
            local aPlayers = PlayerManager.GetAlive();
            local more_than_four_plots = FindPlotsAtRange(tCampTiles, aPlayers, 4)
            local iInfernalPlot
            local iLeastWaterTiles = 20
            local iCurrentWaterTiles
            print(table.count(more_than_four_plots))
            if table.count(more_than_four_plots) > 0 then
                print('some 5+ plots exist')
                for idx, pPlot in pairs(more_than_four_plots) do
                    -- count coast within 3 tiles. choose smallest
                    iCurrentWaterTiles = countPlotWithinThreeCoast(pPlot)
                    if iCurrentWaterTiles < iLeastWaterTiles then
                        print('found better')
                        iInfernalPlot = pPlot
                        iLeastWaterTiles = iCurrentWaterTiles
                    end
                end
            end
            if not iInfernalPlot then
                local four_range_plots = FindPlotsAtRange(tCampTiles, aPlayers, 4, true)
                if table.count(four_range_plots) > 0 then
                    print('some 4 plots exist')
                    for idx, pPlot in pairs(four_range_plots) do
                        iCurrentWaterTiles = countPlotWithinThreeCoast(pPlot)
                        if iCurrentWaterTiles < iLeastWaterTiles then
                            iInfernalPlot = pPlot
                            iLeastWaterTiles = iCurrentWaterTiles
                        end
                    end
                end
            end
            if iInfernalPlot then
                local pInfernal = Players[iInfernalPlayerId]
                local iCityMakeX, iCityMakeY = iInfernalPlot:GetX(), iInfernalPlot:GetY()
                pInfernal:GetCities():Create(iCityMakeX, iCityMakeY)
                GrantTechParity(iInfernalPlayerId, playerID)
                GrantCultureParity(iInfernalPlayerId, playerID)
                Game:SetProperty('infernal_spawned', 1)
            else
                print('not yet implemented random city outside of camps')
            end
        end
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
    local iArmageddonCount = Game:GetProperty('ARMAGEDDON')
    if iArmageddonCount then
        Game:SetProperty('ARMAGEDDON', iArmageddonCount + iAmount)
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

function FindPlotsAtRange(tCampTiles, aPlayers, iUniqueRange, bIsEquals)
    local tPlotsAtRange = {}
    for iPlotID, pPlot in pairs(tCampTiles) do
        local iCampX = pPlot:GetX();
        local iCampY = pPlot:GetY();
        for loop, pPlayer in pairs(aPlayers) do
            local iPlayer = pPlayer:GetID();
            local pPlayerCities = pPlayer:GetCities();
            for i, pLoopCity in pPlayerCities:Members() do
                local iDistance = Map.GetPlotDistance(iCampX, iCampY, pLoopCity:GetX(), pLoopCity:GetY());
                print(iDistance)
                if bIsEquals then
                    if (iDistance == iUniqueRange) then
                        tPlotsAtRange[iPlotID] = pPlot
                    end
                else
                    if (iDistance > iUniqueRange) then
                        tPlotsAtRange[iPlotID] = pPlot
                    end
                end
            end
        end --]]
    end
    return tPlotsAtRange
end

function countPlotWithinThreeCoast(pPlot)
    local iWaterCount = 0
	local plotX = pPlot:GetX();
	local plotY = pPlot:GetY();
	for dx = -3, 3 - 1, 1 do
		for dy = -3, 3 - 1, 1 do
			local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 3);
			if(otherPlot and otherPlot:IsWater()) then
				iWaterCount = iWaterCount + 1
			end
		end
	end
    return iWaterCount
end
function onStart()
    for iPlayerID, pPlayer in pairs(PlayerManager.GetWasEverAliveMajors()) do
        local alignment = pPlayer:GetProperty('alignment')
        local sLeaderName = PlayerConfigurations[iPlayerID]:GetLeaderTypeName()
        if not alignment then
            local iLeaderAlignment =  tLeaderAlignmentMap[sLeaderName]
            if iLeaderAlignment then
                pPlayer:SetProperty('alignment', iLeaderAlignment)
                print('setting player alignment to ' .. tostring(iLeaderAlignment))
            else
                pPlayer:SetProperty('alignment', -1)                -- to catch errors, remove at production
            end
        end
        if sLeaderName == 'LEADER_HYBOREM' then
            Game:SetProperty('Infernal', iPlayerID)
        end
        if sLeaderName == 'LEADER_BASIUM' then
            Game:SetProperty('Mercurian', iPlayerID)
        end
    end
    if not Game:GetProperty('ARMAGEDDON') then          -- initalize armageddon
        Game:SetProperty('ARMAGEDDON',  0)
    end
end

Events.UnitKilledInCombat.Add(alignmentDeath)
GameEvents.BuildingConstructed.Add(RespawnerSpawned)
LuaEvents.NewGameInitialized.Add(onStart);
LuaEvents.NewGameInitialized.Add(InitiateReligions);
Events.CivicCompleted.Add(GrantReligionFromCivicCompleted)
GameEvents.PolicyChanged.Add(onReligionSwitch)