-- UnitOperation
-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------
g_selectedPlayerId = -1;
g_selectedUnitId = -1;

chan_one = GameInfo.UnitAbilities["CHANNELING_ABILITY_PROMOTION_CHANNELING1"].Index

function myRefresh(iPlayerID, iUnitID, iOldID)
    local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
    if pUnit:GetMovesRemaining() == 0 then
        FlushButtons()
        return
    end
    local iPlotX, iPlotY = pUnit:GetX(), pUnit:GetY()
    local iUnitIndex = pUnit:GetType()
    local pCity = Cities.GetCityInPlot(iPlotX, iPlotY)
    local tSpecificUnitControls = tUnitControls[iUnitIndex]
    if tSpecificUnitControls then
        for gridButton, tButton in pairs(tSpecificUnitControls) do
            print(gridButton)
        end
    end
    if pCity and tSpecificUnitControls then
        for gridButton, tButton in pairs(tControlsAdded) do
            print(gridButton)
            print(tSpecificUnitControls[gridButton])
            if tSpecificUnitControls[gridButton] then
                if tSpecificUnitControls[gridButton] == 'no_info' then
                    gridButton:SetHide(false)
                elseif pCity:GetBuildings():HasBuilding(tSpecificUnitControls[gridButton]) then
                    gridButton:SetHide(true)
                else
                    gridButton:SetHide(false)
                end
            else
                gridButton:SetHide(true)
            end
        end
    else
        FlushButtons()
    end
end

function OnUnitSelectionChanged(iPlayerID, iUnitID, iPlotX, iPlotY, iPlotZ, bSelected, bEditable)
    if bSelected then
        -- local iOldID = g_selectedUnitId         -- for preserving some buttons? not used
        g_selectedPlayerId = iPlayerID;
        g_selectedUnitId = iUnitID;
        myRefresh(iPlayerID, iUnitID);
    end
end

function FlushButtons(pControl, bHide, sName)
    for gridButton, tButton in pairs(tControlsAdded) do
        gridButton:SetHide(true)
    end
end

function OnGrantNoxNoctisClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'NoxNoctis', iX, iY);
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_NOX_NOCTIS');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantDiesDeiClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'DIEsDei', iX, iY);
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_DIES_DEI');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantStigmataUnbornClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'StigmataUnborn', iX, iY);
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_STIGMATA_ON_THE_UNBORN');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantCodeJunilClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'CodeJunil', iX, iY);
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_CODE_OF_JUNIL');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantNecronomiconClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'Necronomicon', iX, iY);
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_THE_NECRONOMICON');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantTabletsBamburClicked()
    print('in grant tablets')
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'TabletsOfBambur', iX, iY);
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_TABLETS_OF_BAMBUR');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantSongAutumnClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'SongOfAutumn', iX, iY);
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_SONG_OF_AUTUMN');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantAcademyClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'Academy', iX, iY);
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_ACADEMY');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantSuperSpecialistClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    UI.AddWorldViewText(0, 'SuperSpecialist', iX, iY);
	ExposedMembers.ExtraHeroes.GrantSuperSpecialist(iPlayer, iUnit, iX, iY);
	UI.DeselectUnit(pUnit);
	return;
end

function UnitGatherInfo()
    local pUnit = UI.GetHeadSelectedUnit();
    local iX = pUnit:GetX();
    local iY = pUnit:GetY();
	local iUnit = pUnit:GetID();
	local iPlayer = pUnit:GetOwner();
    return pUnit, iX, iY, iUnit, iPlayer
end

function Setup()
    local path = '/InGame/UnitPanel/StandardActionsStack'
    local ctrl = ContextPtr:LookUpControl(path)
    tControlsAdded = {
                   [Controls.SettleButtonGridGrantAcademy] = { [Controls.SettleButtonGrantAcademy] = OnGrantAcademyClicked },
                   [Controls.SettleButtonGridGrantSuperSpecialist] = { [Controls.SettleButtonGrantSuperSpecialist] = OnGrantSuperSpecialistClicked },
                   [Controls.SettleButtonGridGrantNoxNoctis] = { [Controls.SettleButtonGrantNoxNoctis] = OnGrantNoxNoctisClicked },
                   [Controls.SettleButtonGridGrantDiesDei] = { [Controls.SettleButtonGrantDiesDei] = OnGrantDiesDeiClicked },
                   [Controls.SettleButtonGridGrantStigmataUnborn] = { [Controls.SettleButtonGrantStigmataUnborn] = OnGrantStigmataUnbornClicked },
                   [Controls.SettleButtonGridGrantCodeJunil] = { [Controls.SettleButtonGrantCodeJunil] = OnGrantCodeJunilClicked },
                   [Controls.SettleButtonGridGrantSongAutumn] = { [Controls.SettleButtonGrantSongAutumn] = OnGrantSongAutumnClicked },
                   [Controls.SettleButtonGridGrantTabletsBambur] = { [Controls.SettleButtonGrantTabletsBambur] = OnGrantTabletsBamburClicked },
                   [Controls.SettleButtonGridGrantNecronomicon] = { [Controls.SettleButtonGrantNecronomicon] = OnGrantNecronomiconClicked }}
    if ctrl ~= nil then
        for gridButton, tButton in pairs(tControlsAdded) do
            gridButton:ChangeParent(ctrl)
        end
            -- gridButton:SetHide(true)
    end
    for gridButton, tButton in pairs(tControlsAdded) do
        for button, callbackFunc in pairs(tButton) do
            button:RegisterCallback(Mouse.eLClick, callbackFunc)
        end
        -- gridButton:SetHide(true)
    end

    -- can expand this for Dancing Bear etc. but not elf cage etc as that is ability bound.
    tUnitControls = { [GameInfo.Units['UNIT_GREAT_PROPHET'].Index] = { [Controls.SettleButtonGridGrantNoxNoctis] = GameInfo.Buildings['SLTH_BUILDING_NOX_NOCTIS'].Index, [Controls.SettleButtonGridGrantDiesDei] = GameInfo.Buildings['SLTH_BUILDING_DIES_DIEI'].Index,
                                                                       [Controls.SettleButtonGridGrantStigmataUnborn] = GameInfo.Buildings['SLTH_BUILDING_STIGMATA_ON_THE_UNBORN'], [Controls.SettleButtonGridGrantCodeJunil] = GameInfo.Buildings['SLTH_BUILDING_CODE_OF_JUNIL'].Index,
                                                                       [Controls.SettleButtonGridGrantNecronomicon] = GameInfo.Buildings['SLTH_BUILDING_THE_NECRONOMICON'].Index, [Controls.SettleButtonGridGrantTabletsBambur] = GameInfo.Buildings['SLTH_BUILDING_TABLETS_OF_BAMBUR'].Index,
                                                                       [Controls.SettleButtonGridGrantSongAutumn] = GameInfo.Buildings['SLTH_BUILDING_SONG_OF_AUTUMN'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'no_info' },
                      [GameInfo.Units['UNIT_GREAT_ENGINEER'].Index] = { [Controls.SettleButtonGridGrantTabletsBambur] = GameInfo.Buildings['SLTH_BUILDING_TABLETS_OF_BAMBUR'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'no_info' },
                      [GameInfo.Units['UNIT_GREAT_SCIENTIST'].Index] = { [Controls.SettleButtonGridGrantStigmataUnborn] = GameInfo.Buildings['SLTH_BUILDING_STIGMATA_ON_THE_UNBORN'].Index, [Controls.SettleButtonGridGrantDiesDei] = GameInfo.Buildings['SLTH_BUILDING_DIES_DIEI'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'no_info' },

                      [GameInfo.Units['UNIT_GREAT_ARTIST'].Index] = { [Controls.SettleButtonGridGrantSongAutumn] = GameInfo.Buildings['SLTH_BUILDING_SONG_OF_AUTUMN'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'no_info' },
                      [GameInfo.Units['UNIT_GREAT_MERCHANT'].Index] = { [Controls.SettleButtonGridGrantNoxNoctis] = GameInfo.Buildings['SLTH_BUILDING_NOX_NOCTIS'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'no_info' }
    }

    tCurrentButtons = {}
    --]]
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
end

Events.LoadGameViewStateDone.Add(Setup)
Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)


