-- UnitOperation
-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------
g_selectedPlayerId = -1;
g_selectedUnitId = -1;

chan_one = GameInfo.UnitAbilities["CHANNELING_ABILITY_PROMOTION_CHANNELING1"].Index


function myRefresh(iPlayerID, iUnitID, iOldID)
    local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
    local pPlayer = Players[iPlayerID]
    if pUnit:GetMovesRemaining() == 0 then
        FlushButtons()
        return
    end
    local iPlotX, iPlotY = pUnit:GetX(), pUnit:GetY()
    local iUnitIndex = pUnit:GetType()
    local pCity = Cities.GetCityInPlot(iPlotX, iPlotY)
    local tSpecificUnitControls = tUnitControls[iUnitIndex]
    if tSpecificUnitControls then
        for gridButton, tButton in pairs(tControlsAdded) do
            print(tSpecificUnitControls[gridButton])
            if tSpecificUnitControls[gridButton] then
                if tSpecificUnitControls[gridButton] == 'SHOW_ON_CITY' and pCity then
                    gridButton:SetHide(false)
                elseif tSpecificUnitControls[gridButton] == 'GOLDEN_AGE_LOGIC' then
                    goldenAgeHide(gridButton, iPlayerID, pPlayer, iUnitID, iUnitIndex)
                elseif pCity and pCity:GetBuildings():HasBuilding(tSpecificUnitControls[gridButton]) then
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

function onUnitSelectedMoved(playerID, unitID, x, y, locallyVisible ,stateChange)
    if playerID == g_selectedPlayerId and unitID == g_selectedUnitId then
        myRefresh(playerID, unitID);
    end
end

function onOperationMoveEnded(playerID, unitID, commandType, data1)
    if playerID == g_selectedPlayerId and unitID == g_selectedUnitId then
        myRefresh(playerID, unitID);
    end
end

function FlushButtons(pControl, bHide, sName)
    for gridButton, tButton in pairs(tControlsAdded) do
        gridButton:SetHide(true)
    end
end

function goldenAgeHide(gridButton, iPlayerID, pPlayer, iUnitID, iUnitIndex)
    print('attempting golden age hide')
    local iUniqueGreatPeopleRequirement = pPlayer:GetProperty('GreatPeopleGoldenRequirement') or 1
    local bRecalculateSacrificeList = false
    print(table.count(tGreatPeopleUnitIDs))
    print(iUniqueGreatPeopleRequirement)
    if table.count(tGreatPeopleUnitIDs) >= iUniqueGreatPeopleRequirement then            -- saves recalculating when golden possible
        print('check if all still alive and value in index')
        if tGreatPeopleUnitIDs[iUnitIndex] ~= iUnitID then
            bRecalculateSacrificeList = true
        end
        for iUnitType, iPreDefUnitID in pairs(tGreatPeopleUnitIDs) do             -- still need to check the unit exists
            if not UnitManager.GetUnit(iPlayerID, iPreDefUnitID) then
                bRecalculateSacrificeList = true
                break
            end
        end
    else
        bRecalculateSacrificeList = true
        print('build list')
        print(bRecalculateSacrificeList)
    end
    print(bRecalculateSacrificeList)
    if bRecalculateSacrificeList then
        print('building list')
        tGreatPeopleUnitTypes[iUnitIndex] = iUnitID
        for _, pPlayerUnit in pPlayer:GetUnits():Members() do			-- gather great people
            local unitType = pPlayerUnit:GetType()
            if tGreatPeopleUnitTypes[unitType] and table.count(tGreatPeopleUnitIDs) < iUniqueGreatPeopleRequirement and not tGreatPeopleUnitIDs[unitType] then
                tGreatPeopleUnitIDs[unitType] = pPlayerUnit:GetID()
                print('added great person')
            end
        end
    end
    print('-------------------------------------------')
    print(table.count(tGreatPeopleUnitIDs))
    print(iUniqueGreatPeopleRequirement)
    if table.count(tGreatPeopleUnitIDs) >= iUniqueGreatPeopleRequirement then
        gridButton:SetHide(false)
    else
        gridButton:SetHide(true)
    end
end

function OnGrantNoxNoctisClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_NOX_NOCTIS');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantDiesDeiClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_DIES_DEI');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantStigmataUnbornClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_STIGMATA_ON_THE_UNBORN');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantCodeJunilClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_CODE_OF_JUNIL');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantNecronomiconClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_THE_NECRONOMICON');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantTabletsBamburClicked()
    print('in grant tablets')
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_TABLETS_OF_BAMBUR');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantSongAutumnClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_SONG_OF_AUTUMN');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantAcademyClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantBuildingFunction(iPlayer, iUnit, iX, iY, 'SLTH_MODIFIER_GRANT_ACADEMY');
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantSuperSpecialistClicked()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
	ExposedMembers.ExtraHeroes.GrantSuperSpecialist(iPlayer, iUnit, iX, iY);
	UI.DeselectUnit(pUnit);
	return;
end

function OnGrantGoldenAgeClicked()
    local pUnit = UI.GetHeadSelectedUnit();
    local iPlayer = pUnit:GetOwner();
    local iUnit = pUnit:GetID();
	ExposedMembers.ExtraHeroes.GrantGoldenAge(iPlayer, tGreatPeopleUnitIDs);
    tGreatPeopleUnitIDs = {}                                -- flush out values
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

function SlthLog(sMessage)
    SLTH_DEBUG_ON = True
    if SLTH_DEBUG_ON then
        print(sMessage)
    end
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
                   [Controls.SettleButtonGridGrantNecronomicon] = { [Controls.SettleButtonGrantNecronomicon] = OnGrantNecronomiconClicked },
                   [Controls.SettleButtonGridGrantGoldenAge] = { [Controls.SettleButtonGrantGoldenAge] = OnGrantGoldenAgeClicked }}
    if ctrl ~= nil then
        for gridButton, tButton in pairs(tControlsAdded) do
            gridButton:ChangeParent(ctrl)
        end
    end
    for gridButton, tButton in pairs(tControlsAdded) do
        for button, callbackFunc in pairs(tButton) do
            button:RegisterCallback(Mouse.eLClick, callbackFunc)
        end
    end

    -- can expand this for Dancing Bear etc. but not elf cage etc as that is ability bound.
    tUnitControls = { [GameInfo.Units['UNIT_GREAT_PROPHET'].Index] = { [Controls.SettleButtonGridGrantNoxNoctis] = GameInfo.Buildings['SLTH_BUILDING_NOX_NOCTIS'].Index, [Controls.SettleButtonGridGrantDiesDei] = GameInfo.Buildings['BUILDING_ANGKOR_WAT'].Index,
                                                                       [Controls.SettleButtonGridGrantStigmataUnborn] = GameInfo.Buildings['SLTH_BUILDING_STIGMATA_ON_THE_UNBORN'], [Controls.SettleButtonGridGrantCodeJunil] = GameInfo.Buildings['SLTH_BUILDING_CODE_OF_JUNIL'].Index,
                                                                       [Controls.SettleButtonGridGrantNecronomicon] = GameInfo.Buildings['SLTH_BUILDING_THE_NECRONOMICON'].Index, [Controls.SettleButtonGridGrantTabletsBambur] = GameInfo.Buildings['SLTH_BUILDING_TABLETS_OF_BAMBUR'].Index,
                                                                       [Controls.SettleButtonGridGrantSongAutumn] = GameInfo.Buildings['SLTH_BUILDING_SONG_OF_AUTUMN'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'SHOW_ON_CITY', [Controls.SettleButtonGridGrantGoldenAge] = 'GOLDEN_AGE_LOGIC' },
                      [GameInfo.Units['UNIT_GREAT_ENGINEER'].Index] = { [Controls.SettleButtonGridGrantTabletsBambur] = GameInfo.Buildings['SLTH_BUILDING_TABLETS_OF_BAMBUR'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'SHOW_ON_CITY', [Controls.SettleButtonGridGrantGoldenAge] = 'GOLDEN_AGE_LOGIC' },
                      [GameInfo.Units['UNIT_GREAT_SCIENTIST'].Index] = { [Controls.SettleButtonGridGrantStigmataUnborn] = GameInfo.Buildings['SLTH_BUILDING_STIGMATA_ON_THE_UNBORN'].Index, [Controls.SettleButtonGridGrantDiesDei] = GameInfo.Buildings['BUILDING_ANGKOR_WAT'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'SHOW_ON_CITY', [Controls.SettleButtonGridGrantGoldenAge] = 'GOLDEN_AGE_LOGIC' },

                      [GameInfo.Units['UNIT_GREAT_ARTIST'].Index] = { [Controls.SettleButtonGridGrantSongAutumn] = GameInfo.Buildings['SLTH_BUILDING_SONG_OF_AUTUMN'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'SHOW_ON_CITY', [Controls.SettleButtonGridGrantGoldenAge] = 'GOLDEN_AGE_LOGIC' },
                      [GameInfo.Units['UNIT_GREAT_MERCHANT'].Index] = { [Controls.SettleButtonGridGrantNoxNoctis] = GameInfo.Buildings['SLTH_BUILDING_NOX_NOCTIS'].Index, [Controls.SettleButtonGridGrantSuperSpecialist] = 'SHOW_ON_CITY', [Controls.SettleButtonGridGrantGoldenAge] = 'GOLDEN_AGE_LOGIC' },
                      [GameInfo.Units['UNIT_GREAT_GENERAL'].Index] = { [Controls.SettleButtonGridGrantCodeJunil] = GameInfo.Buildings['SLTH_BUILDING_CODE_OF_JUNIL'].Index, [Controls.SettleButtonGridGrantGoldenAge] = 'GOLDEN_AGE_LOGIC' },
    }
    -- Golden Age checks
    tGoldenAgeUnitIDs = {GameInfo.Units['UNIT_GREAT_PROPHET'].Index, GameInfo.Units['UNIT_GREAT_ENGINEER'].Index,
                         GameInfo.Units['UNIT_GREAT_SCIENTIST'].Index, GameInfo.Units['UNIT_GREAT_ARTIST'].Index,
                         GameInfo.Units['UNIT_GREAT_MERCHANT'].Index, GameInfo.Units['UNIT_GREAT_GENERAL'].Index}
    tGreatPeopleUnitIDs = {}
    tGreatPeopleUnitTypes = {}
    for _ , key in ipairs(tGoldenAgeUnitIDs) do
        tGreatPeopleUnitTypes[key] = -1
    end

    tCurrentButtons = {}
    --]]
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
end

Events.LoadGameViewStateDone.Add(Setup)
Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)

Events.UnitOperationsCleared.Add(onOperationMoveEnded)