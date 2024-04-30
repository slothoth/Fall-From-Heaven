-- UnitOperation
-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------
local m_WarriorIndex = GameInfo.Units['SLTH_UNIT_WARRIOR'].Index
local validTypes = {
    [m_WarriorIndex] = true
    --GetExperience.HasPromotions('CHANNELING_I')
    --
}

function OnUnitSelectionChanged(iPlayerID, iUnitID, iPlotX, iPlotY, iPlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
        local pAbility = pUnit.GetAbility()
        print(pAbility)
        if not pUnit.Index then
            Controls.SettleButtonGrid:SetHide(true)
            return
        end

        if pUnit:GetMovesRemaining() == 0 then
            Controls.SettleButtonGrid:SetHide(true);
            return;
        end

        local pPlot = Map.GetPlot(iPlotX, iPlotY)
        Controls.SettleButtonGrid:SetHide(pPlot:IsWater())
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
	ExposedMembers.ExtraHeroes.AndyLawFunction(iPlayer, iUnit, m_WarriorIndex, iX, iY);
    print(sUnitType)
    UI.AddWorldViewText(0, sUnitType, iX, iY);
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
    end
    Controls.SettleButton:RegisterCallback(Mouse.eLClick, OnSummonButtonClicked)
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
end

Events.LoadGameViewStateDone.Add(Setup)
Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)