local PYRE_ZOMBIE_INDEX =  GameInfo.Units['SLTH_UNIT_PYRE_ZOMBIE'].Index
local bSheaimPresent = false
local iExplosionDamage = 40

-- Diseased: Granted by Diseased. Permanent, removeable by Cure Disease. All units adjaceny -10% healing. Infirmary remove
-- Plagued: granted by Plagued, Plague Carrier, Athame. Permanent. Infirmary remove
-- Withered: Granted by Withered Touch, spells. 10% reduced strength, -20% reduced healing, -50% exp
-- Poisoned: Removed at full hp. Probably an ability reducing healing. Infirmary remove
-- Rusted: -10% strength. Done by Entropy promo, removed by Forge

-- events.  Combat, Enter City
--
function CombatApplyDebuffs(combatResult)
    print('in combat')
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

    print(iDefenderOwnerID)
    print(iDefenderUnitID)
    print(iAttackerOwnerID)
    print(iAttackerUnitID)

    local bDefHasDiseased = pDefUnitAbilities:HasAbility('DISEASED') or pDefUnitAbilities:HasAbility('DISEASED_INHERENT')
    local bDefHasPlagued = pDefUnitAbilities:HasAbility('PLAGUED')
    local bDefHasWitheredTouch = pDefUnitAbilities:HasAbility('WITHERED_TOUCH') or pDefUnitAbilities:HasAbility('EQUIPMENT_ABILITY_ATHAME')
    local bDefHasPoisonedBlade = pDefUnitAbilities:HasAbility('POISONED_BLADE')
    local bDefHasPlagueCarrier = pDefUnitAbilities:HasAbility('PLAGUE_CARRIER')

    local bAttHasDiseased = pAttackUnitAbilities:HasAbility('DISEASED') or pAttackUnitAbilities:HasAbility('DISEASED_INHERENT')
    local bAttHasPlagued = pAttackUnitAbilities:HasAbility('PLAGUED')
    local bAttHasWitheredTouch = pAttackUnitAbilities:HasAbility('WITHERED_TOUCH') or pAttackUnitAbilities:HasAbility('EQUIPMENT_ABILITY_ATHAME')
    local bAttHasPoisonedBlade = pAttackUnitAbilities:HasAbility('POISONED_BLADE')
    local bAttHasPlagueCarrier = pAttackUnitAbilities:HasAbility('PLAGUE_CARRIER')
    print('doing checks')

    if bDefHasDiseased then
        if not bAttHasDiseased then
            pAttackUnitAbilities:AddAbilityCount('DISEASED')
            print('add diseased to attacker')
        end
    else
        print('check if attacker has diseased')
        if bAttHasDiseased then
            pDefUnitAbilities:AddAbilityCount('DISEASED')
            print('add diseased to defender')
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
        local bAttHasPoisoned = pAttackUnitAbilities:HasAbility('POISONED')
        if not bAttHasPoisoned then
            pAttackUnitAbilities:AddAbilityCount('POISONED')
        end
    end
    if bAttHasPoisonedBlade then
        local bDefHasPoisoned = pDefUnitAbilities:HasAbility('POISONED')
        if not bDefHasPoisoned then
            pDefUnitAbilities:AddAbilityCount('POISONED')
        end
    end

    if bDefHasWitheredTouch then
        local bAttHasWithered = pAttackUnitAbilities:HasAbility('WITHERED')
        if not bAttHasWithered then
            pAttackUnitAbilities:AddAbilityCount('WITHERED')
        end
    end
    if bAttHasWitheredTouch then
        local bDefHasWithered = pDefUnitAbilities:HasAbility('WITHERED')
        if not bDefHasWithered then
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
        local tZombies = {}
        if pAttackerUnit:GetType() == PYRE_ZOMBIE_INDEX then
            local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
            table.insert(tZombies, tNeighborPlots)
        end

        if table.count(tZombies) == 0 then return end;

        for idx, tNeighborPlots in ipairs(tZombies) do
            for _, plot in ipairs(tNeighborPlots) do
                for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
                    if (pNearUnit ~= nil) then
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