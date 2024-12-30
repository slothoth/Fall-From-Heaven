local PYRE_ZOMBIE_INDEX =  GameInfo.Units['SLTH_UNIT_PYRE_ZOMBIE'].Index
local bSheaimPresent
local iExplosionDamage = 40

-- Diseased: Granted by Diseased. Permanent, removeable by Cure Disease. All units adjaceny -10% healing. Infirmary remove
-- Plagued: granted by Plagued, Plague Carrier, Athame. Permanent. Infirmary remove
-- Withered: Granted by Withered Touch, spells. 10% reduced strength, -20% reduced healing, -50% exp
-- Poisoned: Removed at full hp. Probably an ability reducing healing. Infirmary remove
-- Rusted: -10% strength. Done by Entropy promo, removed by Forge

-- events.  Combat, Enter City
--
function CombatApplyDebuffs(combatResult)
    local defender = combatResult[CombatResultParameters.DEFENDER]
    local pDefenderID =  defender[CombatResultParameters.ID]
    local iDefenderTypeID = pDefenderID.type            -- check its a unit
    if iDefenderTypeID ~= 1 then return end

    local attacker = combatResult[CombatResultParameters.ATTACKER]
    local pAttackerID =  attacker[CombatResultParameters.ID]
    local iAttackerTypeID = pAttackerID.type            -- check its a unit
    if iAttackerTypeID ~= 1 then return end

    local iDefenderOwnerID = pDefenderID.player
    local iDefenderUnitID = pDefenderID.id


    local pDefenderUnit = UnitManager.GetUnit(iDefenderOwnerID, iDefenderUnitID);
    if not pDefenderUnit then return end
    local pDefUnitAbilities = pDefenderUnit:GetAbility()

    local iAttackerOwnerID = pAttackerID.player
    local iAttackerUnitID = pAttackerID.id
    local pAttackerUnit = UnitManager.GetUnit(iAttackerOwnerID, iAttackerUnitID);
    if not pAttackerUnit then return end
    local pAttackUnitAbilities = pAttackerUnit:GetAbility()

    local bDefHasDiseased = pDefUnitAbilities:HasAbility('DISEASED') or pDefUnitAbilities:HasAbility('DISEASED_INHERENT')
    local bDefDiseaseImmune = pDefUnitAbilities:HasAbility('ABILITY_IMMUNE_TO_DISEASE')
    local bDefHasPlagued = pDefUnitAbilities:HasAbility('PLAGUED')
    local bDefHasWitheredTouch = pDefUnitAbilities:HasAbility('WITHERED_TOUCH') or pDefUnitAbilities:HasAbility('SLTH_EQUIPMENT_ATHAME_ABILITY')
    local bDefHasPoisonedBlade = pDefUnitAbilities:HasAbility('ABILITY_POISONED_BLADE')
    local bDefHasPlagueCarrier = pDefUnitAbilities:HasAbility('PLAGUE_CARRIER')

    local bAttHasDiseased = pAttackUnitAbilities:HasAbility('DISEASED') or pAttackUnitAbilities:HasAbility('DISEASED_INHERENT')
    local bAttDiseaseImmune = pAttackUnitAbilities:HasAbility('ABILITY_IMMUNE_TO_DISEASE')
    local bAttHasPlagued = pAttackUnitAbilities:HasAbility('PLAGUED')
    local bAttHasWitheredTouch = pAttackUnitAbilities:HasAbility('WITHERED_TOUCH') or pAttackUnitAbilities:HasAbility('SLTH_EQUIPMENT_ATHAME_ABILITY')
    local bAttHasPoisonedBlade = pAttackUnitAbilities:HasAbility('ABILITY_POISONED_BLADE')
    local bAttHasPlagueCarrier = pAttackUnitAbilities:HasAbility('PLAGUE_CARRIER')
    if bDefHasDiseased then
        if not bAttHasDiseased and (not bAttDiseaseImmune) then
            pAttackUnitAbilities:AddAbilityCount('DISEASED')
        end
    else
        if bAttHasDiseased and (not bDefDiseaseImmune) then
            pDefUnitAbilities:AddAbilityCount('DISEASED')
        end
    end

    if bDefHasPlagued then
        if not bAttHasPlagued then
            pAttackUnitAbilities:AddAbilityCount('PLAGUED')
        end
    else
        if bAttHasPlagued then
            pDefUnitAbilities:AddAbilityCount('PLAGUED')
        end
    end

    if bDefHasPoisonedBlade then
        if not pAttackUnitAbilities:HasAbility('POISONED') then
            pAttackUnitAbilities:AddAbilityCount('POISONED')
        end
    end
    if bAttHasPoisonedBlade then
        if not pDefUnitAbilities:HasAbility('POISONED') then
            pDefUnitAbilities:AddAbilityCount('POISONED')
        end
    end

    if bDefHasWitheredTouch then
        if not pAttackUnitAbilities:HasAbility('WITHERED') then
            pAttackUnitAbilities:AddAbilityCount('WITHERED')
        end
    end
    if bAttHasWitheredTouch then
        if not pDefUnitAbilities:HasAbility('WITHERED') then
            pDefUnitAbilities:AddAbilityCount('WITHERED')
        end
    end

    if bDefHasPlagueCarrier then
        if not bAttHasPlagued then
            pAttackUnitAbilities:AddAbilityCount('PLAGUED')
        end
    end
    if bAttHasPlagueCarrier then
        if not bDefHasPlagued then
            pDefUnitAbilities:AddAbilityCount('PLAGUED')
        end
    end

    if bSheaimPresent then
        if pAttackerUnit:GetType() == PYRE_ZOMBIE_INDEX then
            local tNeighbors = Map.GetNeighborPlots(pAttackerUnit:GetX(), pAttackerUnit:GetY(), 1);
            for idx, tNeighborPlots in ipairs(tNeighbors) do
                for _, plot in ipairs(tNeighborPlots) do
                    for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
                        if pNearUnit then
                            if GameInfo.Units[pNearUnit:GetType()].Combat ~= 0 then
                                pNearUnit:ChangeDamage(iExplosionDamage);
                                if pNearUnit:GetDamage() >= 100 then
                                    UnitManager.Kill(pNearUnit, false);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function onStart()
    local sCivType
    for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
        if not bSheaimPresent then
            sCivType = PlayerConfigurations[v]:GetCivilizationTypeName()
            if sCivType == 'SLTH_CIVILIZATION_SHEAIM' then
                bSheaimPresent = true
            end
        end
    end
end

Events.Combat.Add(CombatApplyDebuffs)
LuaEvents.NewGameInitialized.Add(onStart);

print('------------------------------------')
print('initiating combat module')