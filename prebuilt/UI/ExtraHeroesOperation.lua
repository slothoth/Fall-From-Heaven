-- UnitOperation
-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------
local m_WarriorIndex = GameInfo.Units['SLTH_UNIT_EYE'].Index
local validTypes = {
    [m_WarriorIndex] = true
    --GetExperience.HasPromotions('CHANNELING_I')
    --
}


local manas = {
    [GameInfo.Resources["RESOURCE_MANA_AIR"].Index] = Controls.SettleButtonGridAir,
    [GameInfo.Resources["RESOURCE_MANA_BODY"].Index] = Controls.SettleButtonGridBody,
    [GameInfo.Resources["RESOURCE_MANA_CHAOS"].Index] = Controls.SettleButtonGridChaos,
    [GameInfo.Resources["RESOURCE_MANA_DEATH"].Index] = Controls.SettleButtonGridDeath,
    [GameInfo.Resources["RESOURCE_MANA_EARTH"].Index] = Controls.SettleButtonGridEarth,
    [GameInfo.Resources["RESOURCE_MANA_ENCHANTMENT"].Index] = Controls.SettleButtonGridEnchantment,
    [GameInfo.Resources["RESOURCE_MANA_ENTROPY"].Index] = Controls.SettleButtonGridEntropy,
    [GameInfo.Resources["RESOURCE_MANA_FIRE"].Index] = Controls.SettleButtonGridFire,
    [GameInfo.Resources["RESOURCE_MANA_LAW"].Index]= Controls.SettleButtonGrid,
    [GameInfo.Resources["RESOURCE_MANA_LIFE"].Index] = Controls.SettleButtonGridLife,
    [GameInfo.Resources["RESOURCE_MANA_METAMAGIC"].Index] = Controls.SettleButtonGridMetamagic,
    [GameInfo.Resources["RESOURCE_MANA_MIND"].Index] = Controls.SettleButtonGridMind,
    [GameInfo.Resources["RESOURCE_MANA_NATURE"].Index] = Controls.SettleButtonGridNature,
    [GameInfo.Resources["RESOURCE_MANA_SHADOW"].Index] = Controls.SettleButtonGridShadow,
    [GameInfo.Resources["RESOURCE_MANA_SPIRIT"].Index] = Controls.SettleButtonGridSpirit,
    [GameInfo.Resources["RESOURCE_MANA_WATER"].Index] = Controls.SettleButtonGridWater
}

chan_one = GameInfo.UnitAbilities["CHANNELING_ABILITY_PROMOTION_CHANNELING1"].Index


function OnUnitSelectionChanged(iPlayerID, iUnitID, iPlotX, iPlotY, iPlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
        local pAbility = pUnit:GetAbility()
        print(pAbility)
        if not pUnit.Index then
            Controls.SettleButtonGrid:SetHide(true)
        local ability_list = pUnit:GetAbility():GetAbilities()
        print(ability_list)
        print(table.concat(ability_list, ' '))
        for _, ability_index in pairs(ability_list) do
            if ability_index == chan_one then
                bAmateurspells = true
            else
                bAmateurspells = false
            end
        end
        if bAmateurspells then
            for mana_index, spell_grid in pairs(manas) do
                if Players[iPlayerID]:GetResources():HasResource(mana_index) then
                    print('Player has mana')
                    print(mana_index)
                    spell_grid:SetHide(false)
                else
                    print('Player doesnt have mana, hiding spell')
                    print(mana_index)
                    spell_grid:SetHide(true)
                end
                -- spell_grid:SetHide(false)
            end
        else
            for _, spell_grid in pairs(manas) do
                spell_grid:SetHide(true);
                 -- spell_grid:SetHide(false)
            end
            return
        end


        if pUnit:GetMovesRemaining() == 0 then
            for _, spell_grid in pairs(manas) do
                spell_grid:SetHide(true);
            end
            return
        end
        local pPlot = Map.GetPlot(iPlotX, iPlotY)
        if pPlot:IsWater() then
            for _, spell_grid in pairs(manas) do
                spell_grid:SetHide(true);
            end
        end
        return
    end
end


function OnSummonButtonClicked()
    local pUnit = UI.GetHeadSelectedUnit();
    local iX = pUnit:GetX();
    local iY = pUnit:GetY();
	local iUnit = pUnit:GetID();
	local iPlayer = pUnit:GetOwner();
	ExposedMembers.ExtraHeroes.AndyLawFunction(iPlayer, iUnit, m_WarriorIndex, iX, iY);
    local sUnitType = pUnit.GetUnitType()
	UI.PlaySound("EH_AndyLawActive");
	UI.DeselectUnit(pUnit);
	return;
end


function OnDamageButtonClicked()
    local pUnit = UI.GetHeadSelectedUnit();
    local iX = pUnit:GetX();
    local iY = pUnit:GetY();
	local iUnit = pUnit:GetID();
	local iPlayer = pUnit:GetOwner();
    local sUnitType = pUnit.GetUnitType()
	ExposedMembers.ExtraHeroes.AoeDamageFunction(iPlayer, iUnit, m_WarriorIndex, iX, iY);
    print(sUnitType)
    UI.AddWorldViewText(0, 'mycustom', iX, iY);
	UI.PlaySound("EH_AndyLawActive");
	UI.DeselectUnit(pUnit);
	return;
end


function OnAndyLawButtonClicked()
    local pUnit = UI.GetHeadSelectedUnit();
    local iX = pUnit:GetX();
    local iY = pUnit:GetY();
	local iUnit = pUnit:GetID();
	local iPlayer = pUnit:GetOwner();
    local sUnitType = pUnit.GetUnitType()
	ExposedMembers.ExtraHeroes.AndyLawFunction(iPlayer, iUnit, m_WarriorIndex, iX, iY);
    print(sUnitType)
    UI.AddWorldViewText(0, sUnitType, iX, iY);
	UI.PlaySound("EH_AndyLawActive");
	UI.DeselectUnit(pUnit);
	return;
end


function Setup()
    local path = '/InGame/UnitPanel/StandardActionsStack'
    local ctrl = ContextPtr:LookUpControl(path)
    if ctrl ~= nil then
        Controls.SettleButtonGrid:ChangeParent(ctrl)
        Controls.SettleButtonGridAir:ChangeParent(ctrl)
        Controls.SettleButtonGridBody:ChangeParent(ctrl)
        Controls.SettleButtonGridChaos:ChangeParent(ctrl)
        Controls.SettleButtonGridDeath:ChangeParent(ctrl)
        Controls.SettleButtonGridEarth:ChangeParent(ctrl)
        Controls.SettleButtonGridEnchantment:ChangeParent(ctrl)
        Controls.SettleButtonGridEntropy:ChangeParent(ctrl)
        Controls.SettleButtonGridFire:ChangeParent(ctrl)
        Controls.SettleButtonGridLife:ChangeParent(ctrl)
        Controls.SettleButtonGridMetamagic:ChangeParent(ctrl)
        Controls.SettleButtonGridMind:ChangeParent(ctrl)
        Controls.SettleButtonGridNature:ChangeParent(ctrl)
        Controls.SettleButtonGridShadow:ChangeParent(ctrl)
        Controls.SettleButtonGridSpirit:ChangeParent(ctrl)
        Controls.SettleButtonGridWate:ChangeParent(ctrl)
    end
    Controls.SettleButton:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonAir:RegisterCallback(Mouse.eLClick, OnAndyLawButtonClicked)
    Controls.SettleButtonBody:RegisterCallback(Mouse.eLClick, OnDamageButtonClicked)
    Controls.SettleButtonChaos:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonDeath:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonEarth:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonEnchantment:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonEntropy:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonFire:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonLife:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonMetamagic:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonMind:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonNature:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonShadow:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonSpirit:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
    Controls.SettleButtonWater:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
end

Events.LoadGameViewStateDone.Add(Setup)
Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)