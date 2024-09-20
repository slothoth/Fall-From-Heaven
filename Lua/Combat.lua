I_DISEASE_INDEX = GameInfo.UnitAbilities('DISEASED').Index
I_PLAGUE_INDEX = GameInfo.UnitAbilities('PLAGUED').Index
I_WITHERED_TOUCH_INDEX = GameInfo.UnitAbilities('WITHERED_TOUCH').Index
I_ATHAME_ABILITY_INDEX = GameInfo.UnitAbilities('EQUIPMENT_ABILITY_ATHAME').Index
I_WITHERED_INDEX = GameInfo.UnitAbilities('WITHERED').Index
I_POISONED_BLADE_INDEX = GameInfo.UnitAbilities('POISONED_BLADE').Index
I_POISONED_INDEX = GameInfo.UnitAbilities('POISONED').Index
I_PLAGUE_CARRIER_INDEX = GameInfo.UnitAbilities('PLAGUE_CARRIER').Index
PYRE_ZOMBIE_INDEX =  GameInfo.Units('SLTH_UNIT_PYRE_ZOMBIE').Index
bSheaimPresent = false
iExplosionDamage = 40

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
    print(iDefenderTypeID)
    if iDefenderTypeID ~= 'UNIT' then return end

    local attacker = combatResult[CombatResultParameters.DEFENDER]
    local pAttackerID =  attacker[CombatResultParameters.ID]
    local iAttackerTypeID = pAttackerID.type            -- check its a unit
    if iAttackerTypeID ~= 'UNIT' then return end

    local iDefenderOwnerID = pDefenderID.player
    local iDefenderUnitID = pDefenderID.id
    local pDefenderUnit = UnitManager.GetUnit(iDefenderOwnerID, iDefenderUnitID);
    local pDefUnitAbilities = pDefenderUnit:GetAbility()

    local iAttackerOwnerID = pAttackerID.player
    local iAttackerUnitID = pAttackerID.id
    local pAttackerUnit = UnitManager.GetUnit(iAttackerOwnerID, iAttackerUnitID);
    local pAttackUnitAbilities = pAttackerUnit:GetAbility()

    local bDefHasDiseased = pDefUnitAbilities:HasAbility(I_DISEASE_INDEX)
    local bDefHasPlagued = pDefUnitAbilities:HasAbility(I_PLAGUE_INDEX)
    local bDefHasWitheredTouch = pDefUnitAbilities:HasAbility(I_WITHERED_TOUCH_INDEX) or pDefUnitAbilities:HasAbility(I_ATHAME_ABILITY_INDEX)
    local bDefHasPoisonedBlade = pDefUnitAbilities:HasAbility(I_POISONED_BLADE_INDEX)
    local bDefHasPlagueCarrier = pDefUnitAbilities:HasAbility(I_PLAGUE_CARRIER_INDEX)

    local bAttHasDiseased = pAttackUnitAbilities:HasAbility(I_DISEASE_INDEX)
    local bAttHasPlagued = pAttackUnitAbilities:HasAbility(I_PLAGUE_INDEX)
    local bAttHasWitheredTouch = pAttackUnitAbilities:HasAbility(I_WITHERED_TOUCH_INDEX) or pAttackUnitAbilities:HasAbility(I_ATHAME_ABILITY_INDEX)
    local bAttHasPoisonedBlade = pAttackUnitAbilities:HasAbility(I_POISONED_BLADE_INDEX)
    local bAttHasPlagueCarrier = pAttackUnitAbilities:HasAbility(I_PLAGUE_CARRIER_INDEX)

    if bDefHasDiseased then
        if not bAttHasDiseased then
            pAttackUnitAbilities:AddAbilityCount(I_DISEASE_INDEX)
        end
    else
        if bAttHasDiseased then
            pDefUnitAbilities:AddAbilityCount(I_DISEASE_INDEX)
        end
    end

    if bDefHasPlagued then
        if not bAttHasPlagued then
            pAttackUnitAbilities:AddAbilityCount(I_PLAGUE_INDEX)
        end
    else
        if bAttHasPlagued then
            pDefUnitAbilities:AddAbilityCount(I_PLAGUE_INDEX)
        end
    end

    if bDefHasPoisonedBlade then
        local bAttHasPoisoned = pAttackUnitAbilities:HasAbility(I_POISONED_INDEX)
        if not bAttHasPoisoned then
            pAttackUnitAbilities:AddAbilityCount(I_POISONED_INDEX)
        end
    end
    if bAttHasPoisonedBlade then
        local bDefHasPoisoned = pDefUnitAbilities:HasAbility(I_POISONED_INDEX)
        if not bDefHasPoisoned then
            pDefUnitAbilities:AddAbilityCount(I_POISONED_INDEX)
        end
    end

    if bDefHasWitheredTouch then
        local bAttHasWithered = pAttackUnitAbilities:HasAbility(I_WITHERED_INDEX)
        if not bAttHasWithered then
            pAttackUnitAbilities:AddAbilityCount(I_WITHERED_INDEX)
        end
    end
    if bAttHasWitheredTouch then
        local bDefHasWithered = pDefUnitAbilities:HasAbility(I_WITHERED_INDEX)
        if not bDefHasWithered then
            pDefUnitAbilities:AddAbilityCount(I_WITHERED_INDEX)
        end
    end

    if bDefHasPlagueCarrier then
        if not bAttHasPlagued then
            pAttackUnitAbilities:AddAbilityCount(I_PLAGUE_INDEX)
        end
    end
    if bAttHasPlagueCarrier then
        if not bDefHasPlagued then
            pDefUnitAbilities:AddAbilityCount(I_PLAGUE_INDEX)
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

Events.Combat.Add(CombatApplyDebuffs)
LuaEvents.NewGameInitialized.Add(onStart);