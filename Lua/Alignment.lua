tLeaderAlignmentMap = {
    ['SLTH_LEADER_ALEXIS']=0, ['SLTH_LEADER_FLAUROS']=0, ['SLTH_LEADER_KEELYN']=0, ['SLTH_LEADER_PERPENTACH']=0,
    ['SLTH_LEADER_HYBOREM']=0, ['SLTH_LEADER_TEBRYN']=0, ['SLTH_LEADER_OS-GABELLA']=0, ['SLTH_LEADER_JONAS']=0,
    ['SLTH_LEADER_SHEELBA']=0, ['SLTH_LEADER_CHARADON']=0, ['SLTH_LEADER_MAHALA']=0,
    ['SLTH_LEADER_AURIC']=0, ['SLTH_LEADER_FAERYL']=0,

    ['SLTH_LEADER_VALLEDIA']=1, ['SLTH_LEADER_DAIN']=1, ['SLTH_LEADER_DECIUS']=1, ['SLTH_LEADER_CASSIEL']=1,
    ['SLTH_LEADER_TASUNKE']=1, ['SLTH_LEADER_RHOANNA']=1, ['SLTH_LEADER_FALAMAR']=1, ['SLTH_LEADER_HANNAH']=1,
    ['SLTH_LEADER_AMELANCHIER']=1, ['SLTH_LEADER_ARENDEL']=1, ['SLTH_LEADER_THESSA']=1, ['SLTH_LEADER_ARTURUS']=1,
    ['SLTH_LEADER_KANDROS']=1, ['SLTH_LEADER_SANDALPHON']=1,

    ['SLTH_LEADER_SABATHIEL']=2, ['SLTH_LEADER_CAPRIA']=2, ['SLTH_LEADER_ETHNE']=2, ['SLTH_LEADER_EINION']=2,
    ['SLTH_LEADER_CARDITH']=2, ['SLTH_LEADER_VARN']=2, ['SLTH_LEADER_BASIUM']=2,
    ['SLTH_LEADER_GARRIM']=2, ['SLTH_LEADER_BEERI']=2
}

tReligionFromGood = {['SLTH_ESUS']=1, ['SLTH_OVERLORDS']=1}
tReligionFromEvil = {['SLTH_EMPYREAN']=1, ['SLTH_KILMORPH']=1}
tReligionForceAlignment = {['SLTH_THE_ORDER']=2, ['SLTH_VEIL']=0}

tReligionAlignment = {
    ['SLTH_ESUS']=0, ['SLTH_OVERLORDS']=0, ['SLTH_VEIL']=0,
    ['SLTH_LEAVES']=1,
    ['SLTH_EMPYREAN']=2, ['SLTH_KILMORPH']=2, ['SLTH_THE_ORDER']=2
}

tAnimalBeastSiege = {['PROMOTION_CLASS_BEAST']=1, ['PROMOTION_CLASS_ANIMAL']=1, ['PROMOTION_CLASS_SIEGE']=1}

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
    local pUnitAbilities = pUnit:GetAbility()
    local isEvil = pUnitAbilities:HasAbility('ALIGNMENT_EVIL') -- or pUnit:GetExperience():HasPromotion() -- once we have magic do entropy and death promos.
    if isEvil then
        iUnitToGrant = GameInfo.Units['SLTH_UNIT_MANES'].Index
        iPlotSpawnedLocation = Game:GetProperty('InfernalPlot')
        iGrantPlayer = Game:GetProperty('Infernal', playerID)
    elseif pUnitAbilities:HasAbility('ALIGNMENT_GOOD') then
        iUnitToGrant = GameInfo.Units['SLTH_UNIT_ANGEL'].Index
        iPlotSpawnedLocation = Game:GetProperty('MercurianGatePlot')
        iGrantPlayer = Game:GetProperty('Mercurian')
    else
        return
    end
    if not iPlotSpawnedLocation then return end
    local pKillingPlayer = Players[playerID]
    local pUnitKiller = pKillingPlayer:GetUnits():FindID(unitID);
    local sUnitName = pUnit:GetUnitType()
    if tAnimalBeastSiege[GameInfo.Units[sUnitName].PromotionClass] or pUnitKiller:GetAbility():HasAbility('NETHER_BLADE') then
        return
    end
    local bIsNotAlive = pUnitAbilities:HasAbility('ABILITY_ANGEL') or pUnitAbilities:HasAbility('ABILITY_DEMON') or pUnitAbilities:HasAbility('ABILITY_UNDEAD')
    if bIsNotAlive then
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
    if buildingID == GameInfo.Buildings['BUILDING_PALACE'] then
        local pPlayer = Players[playerID]
        if PlayerConfigurations[pPlayer]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_INFERNAL' then
            Game:SetProperty('InfernalPlot', plotID)
            Game:SetProperty('Infernal', playerID)
        end
    elseif buildingID == GameInfo.Buildings['SLTH_BUILDING_MERCURIAN_GATE'] then
        Game:SetProperty('MercurianGatePlot', plotID)
        Game:SetProperty('Mercurian', playerID)
    end
end

function onStart()
    for iPlayerID, pPlayer in Players do
        local alignment = pPlayer:GetProperty('alignment')
        if not alignment then
            local sLeaderName = PlayerConfigurations[pPlayer]:GetLeaderTypeName()
            local iLeaderAlignment =  tLeaderAlignmentMap[sLeaderName]
            if iLeaderAlignment then
                pPlayer:SetProperty('alignment', iLeaderAlignment)
            else
                pPlayer:SetProperty('alignment', -1)                -- to catch errors, remove at production
            end
        end
    end
end


onStart()

Events.UnitKilledInCombat.Add(alignmentDeath)
GameEvents.BuildingConstructed.Add(RespawnerSpawned)
