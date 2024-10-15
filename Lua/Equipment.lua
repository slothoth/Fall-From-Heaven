tEquipmentAbilities = { [GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_ATHAME'].Index,
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
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_STAFF_OF_SOULS'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_TIMOR_MASK'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_TREASURE_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_TREASURE'].Index,
                        [GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index] = GameInfo.Units['SLTH_EQUIPMENT_WAR'].Index }

-- this seems maybe expensive, iterating over every equipment on any unit dying in combat?
function EquipmentUnitDied(killedPlayerID, killedUnitID, playerID, unitID)
    local pKilledUnit = UnitManager.GetUnit(killedPlayerID, killedUnitID)
    if not pKilledUnit then return end
    local pKilledUnitAbilities = pKilledUnit:GetAbility()
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    if not pUnit then return end
    local pAbilityUnit = pUnit:GetAbility()
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    for EquipAbility, EquipUnit in pairs(tEquipmentAbilities) do
        local bHasSpecEquip = pKilledUnitAbilities:HasAbility(EquipAbility)
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

Events.UnitKilledInCombat.Add(EquipmentUnitDied)