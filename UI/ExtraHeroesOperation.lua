
-- UnitOperation
-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------
g_selectedPlayerId = -1;
g_selectedUnitId = -1;

local m_markedPlots = {}  -- plotIndex
local m_markedPlotsMap = {}  -- key: plotIndex, value: BuildingIndex
m_wbInterfaceMode = false


local tMonitoredResources = {
    [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index] = { rtype='MANA', name='RESOURCE_MANA_DEATH'},
    [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index] = { rtype='MANA', name='RESOURCE_MANA_FIRE'},
    [GameInfo.Resources['RESOURCE_MANA_AIR'].Index] = { rtype='MANA', name='RESOURCE_MANA_AIR'},
    [GameInfo.Resources['RESOURCE_MANA_BODY'].Index] = { rtype='MANA', name='RESOURCE_MANA_BODY'},
    [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index] = { rtype='MANA', name='RESOURCE_MANA_CHAOS'},
    [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index] = { rtype='MANA', name='RESOURCE_MANA_EARTH'},
    [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index] = { rtype='MANA', name='RESOURCE_MANA_ENCHANTMENT'},
    [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index] = { rtype='MANA', name='RESOURCE_MANA_ENTROPY'},
    [GameInfo.Resources['RESOURCE_MANA_ICE'].Index] = { rtype='MANA', name='RESOURCE_MANA_ICE'},
    [GameInfo.Resources['RESOURCE_MANA_LAW'].Index] = { rtype='MANA', name='RESOURCE_MANA_LAW'},
    [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index] = { rtype='MANA', name='RESOURCE_MANA_LIFE'},
    [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index] = { rtype='MANA', name='RESOURCE_MANA_METAMAGIC'},
    [GameInfo.Resources['RESOURCE_MANA_MIND'].Index] = { rtype='MANA', name='RESOURCE_MANA_MIND'},
    [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index] = { rtype='MANA', name='RESOURCE_MANA_NATURE'},
    [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index] = { rtype='MANA', name='RESOURCE_MANA_SPIRIT'},
    [GameInfo.Resources['RESOURCE_MANA_WATER'].Index] = { rtype='MANA', name='RESOURCE_MANA_WATER'},
    [GameInfo.Resources['RESOURCE_MANA_SUN'].Index] = { rtype='MANA', name='RESOURCE_MANA_SUN'},
    [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index] = { rtype='MANA', name='RESOURCE_MANA_SHADOW'},
    [GameInfo.Resources['RESOURCE_BANANA'].Index] = { rtype='AFFINITY', name='RESOURCE_BANANA'}}
    -- [GameInfo.Resources['RESOURCE_COPPER'].Index] = { rtype='AFFINITY', name='RESOURCE_COPPER'},
    -- [GameInfo.Resources['RESOURCE_IRON'].Index] = { rtype='AFFINITY', name='RESOURCE_IRON'},
    -- [GameInfo.Resources['RESOURCE_MITHRIL'].Index] = { rtype='AFFINITY', name='RESOURCE_MITHRIL'},
    -- [GameInfo.Resources['RESOURCE_SHEUT_STONE'].Index] = { rtype='AFFINITY', name='RESOURCE_SHEUT_STONE'},
    -- [GameInfo.Resources['RESOURCE_NIGHTMARE'].Index] = { rtype='AFFINITY', name='RESOURCE_NIGHTMARE'}}

local tBinaryMap = {
    ['0']={['8']= 0, ['4']=0, ['2']=0, ['1']=0},
    ['1']={['8']=0, ['4']=0, ['2']=0, ['1']=1,},
    ['2']={['8']=0, ['4']=0, ['2']=1, ['1']=0,},
    ['3']={['8']=0, ['4']=0, ['2']=1, ['1']=1,},
    ['4']={['8']=0, ['4']=1, ['2']=0, ['1']=0,},
    ['5']={['8']=0, ['4']=1, ['2']=0, ['1']=1,},
    ['6']={['8']=0, ['4']=1, ['2']=1, ['1']=0,},
    ['7']={['8']=0, ['4']=1, ['2']=1, ['1']=1,},
    ['8']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['9']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['10']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['11']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['12']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['13']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['14']={['8']=1, ['4']=1, ['2']=1, ['1']=1,},
    ['15']={['8']=1, ['4']=1, ['2']=1, ['1']=1,}
}


function myRefresh(iPlayerID, iUnitID, iOldID)
    local iBuilding
    local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
    local pPlayer = Players[iPlayerID]
    if pUnit:GetMovesRemaining() == 0 then
        FlushButtons()
        Controls.SettleButtonGridTakeEquipment:SetHide(true)
        return
    end
    if pUnit:GetFormationClass() == 0 then
        Controls.SettleButtonGridTakeEquipment:SetHide(false)
    else
        Controls.SettleButtonGridTakeEquipment:SetHide(true)
    end
    local iPlotX, iPlotY = pUnit:GetX(), pUnit:GetY()
    local iUnitIndex = pUnit:GetType()
    local pCity = Cities.GetCityInPlot(iPlotX, iPlotY)
    local tSpecificUnitControls = tUnitControls[iUnitIndex]
    if tSpecificUnitControls then
        for gridButton, tButton in pairs(tControlsAdded) do
            iBuilding = tSpecificUnitControls[gridButton]
            print(iBuilding)
            if iBuilding then
                if iBuilding == 'GOLDEN_AGE_LOGIC' then
                    goldenAgeHide(gridButton, iPlayerID, pPlayer, iUnitID, iUnitIndex)
                elseif pCity then
                    if iBuilding == 'SHOW_ON_CITY' then
                        gridButton:SetHide(false)
                    elseif pCity:GetBuildings():HasBuilding(iBuilding) then
                        gridButton:SetHide(true)
                    else
                        local iReligion = tReligiousWonders[iBuilding]
                        if iReligion then
                            local iX, iY = pCity:GetX(), pCity:GetY()
                            local pPlot = Map.GetPlot(iX, iY)
                            if pPlot:GetProperty(tostring(iReligion)..'_HOLY_CITY') or 0 > 0 then
                                gridButton:SetHide(false)
                            end
                        else
                            gridButton:SetHide(true)
                        end
                    end
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


-- nicked from QINMachuPichu

-- nicked from QINMachuPichu


function GetNearbyEquipment(iPlayerID, iPlotX, iPlotY)
	local markedPlots = {}
	local markedPlotsMap = {}
    local tAdjacentPlots = Map.GetAdjacentPlots(iPlotX, iPlotY)
    local tUnits
    for idx, pAdjPlot in ipairs(tAdjacentPlots) do          -- is this idx an index or plotID?
        tUnits = Units.GetUnitsInPlot(pAdjPlot)
        if tUnits then
            for _, pAdjUnit in ipairs(tUnits) do
                local iOwnerID = pAdjUnit:GetOwner()
                if iOwnerID == iPlayerID then
                    local iUnitType = pAdjUnit:GetType()
                    if tEquipmentUnits[iUnitType] then              -- is equipment
                        local iUnitID = pAdjUnit:GetID()
                        markedPlotsMap[pAdjPlot:GetIndex()] = iUnitID
                        table.insert(markedPlots, pAdjPlot:GetIndex())
                        break
                    end
                    local pAdjUnitAbilities = pAdjUnit:GetAbility():GetAbilities()
                    for _, iAbilityIndex in ipairs(pAdjUnitAbilities) do
                        if tEquipmentAbilities[iAbilityIndex] then                  -- has equipment
                            local iUnitID = pAdjUnit:GetID()
                            markedPlotsMap[pAdjPlot:GetIndex()] = iUnitID
                            table.insert(markedPlots, pAdjPlot:GetIndex())
                            break
                        end
                    end
                end
            end
        end
    end
    return markedPlots, markedPlotsMap
end



-- helper functions
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
        Controls.SettleButtonGridTakeEquipment:ChangeParent(ctrl)
        -- Controls.SettleButtonTakeEquipment:RegisterCallback(Mouse.eLClick, OnGrantEquipmentClicked)
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
    tReligiousWonders = {
        [GameInfo.Buildings['SLTH_BUILDING_CODE_OF_JUNIL'].Index]=GameInfo.Religions["RELIGION_PROTESTANTISM"].Index,
        [GameInfo.Buildings['BUILDING_ANGKOR_WAT'].Index]=GameInfo.Religions["RELIGION_JUDAISM"].Index,
        [GameInfo.Buildings['SLTH_BUILDING_TABLETS_OF_BAMBUR'].Index]=GameInfo.Religions["RELIGION_CONFUCIANISM"].Index,
        [GameInfo.Buildings['SLTH_BUILDING_SONG_OF_AUTUMN'].Index]=GameInfo.Religions["RELIGION_CATHOLICISM"].Index,
        [GameInfo.Buildings['SLTH_BUILDING_THE_NECRONOMICON'].Index]=GameInfo.Religions["RELIGION_HINDUISM"].Index,
        [GameInfo.Buildings['SLTH_BUILDING_NOX_NOCTIS'].Index]=GameInfo.Religions["RELIGION_ISLAM"].Index,
        [GameInfo.Buildings['SLTH_BUILDING_STIGMATA_ON_THE_UNBORN'].Index]=GameInfo.Religions["RELIGION_BUDDHISM"].Index}

    tEquipmentUnits = {
	[GameInfo.Units['SLTH_EQUIPMENT_ATHAME'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_BLACK_MIRROR'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_CROWN_OF_COMMAND'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_DRAGONS_HORDE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_EMPTY_BIER'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_GELA'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_GODSLAYER'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_GOLDEN_HAMMER'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_HEALING_SALVE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_JADE_TORC'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_NETHER_BLADE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_ORTHUSS_AXE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_POTION_OF_RESTORATION'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_ROD_OF_WINDS'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_SCORCHED_STAFF'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_STAFF_OF_SOULS'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_TIMOR_MASK'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_TREASURE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TREASURE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_WAR'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index }

    tEquipmentAbilities = {
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_TREASURE_ABILITY'].Index] = 1,
	[GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index] = 1}

    tEquipmentNameAbilities = {
	['ATHAME'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index,
	['BLACK_MIRROR'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index,
	['CROWN_OF_AKHARIEN'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index,
	['CROWN_OF_COMMAND'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index,
	['DRAGONS_HORDE'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index,
	['EMPTY_BIER'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index,
	['GELA'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index,
	['GODSLAYER'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index,
	['GOLDEN_HAMMER'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index,
	['HEALING_SALVE'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index,
	['INFERNAL_GRIMOIRE'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index,
	['JADE_TORC'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index,
	['NETHER_BLADE'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index,
	['ORTHUSS_AXE'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index,
	['PIECES_OF_BARNAXUS'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index,
	['POTION_OF_INVISIBILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index,
	['POTION_OF_RESTORATION'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index,
	['ROD_OF_WINDS'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index,
	['SCORCHED_STAFF'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index,
	['STAFF_OF_SOULS'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index,
	['SYLIVENS_PERFECT_LYRE'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index,
	['TIMOR_MASK'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index,
	['TREASURE'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TREASURE_ABILITY'].Index,
	['WAR'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index}
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
end

-- Events.LoadGameViewStateDone.Add(Setup)
-- Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)

-- Events.UnitOperationsCleared.Add(onOperationMoveEnded)

-- LuaEvents.WorldInput_WBSelectPlot.Add(OnSelectPlot)

-- gameplay esque
function UpdateResourceAvailability(ownerPlayerID,resourceTypeID)
    local iResourceInfo = tMonitoredResources[resourceTypeID]
    if iResourceInfo then
        local pPlayer = Players[ownerPlayerID];
        local resources = pPlayer:GetResources()
        local iResourceCount = resources:GetResourceAmount(resourceTypeID);
        local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
        if not pCapitalCity then print('Trying to update resource but no capital!') return; end;            -- this triggers on hyborem :(. maybe just do settler for him  as discord says thats how it works
        local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
        local sPropKeyCount = iResourceInfo['name']
        local iPastResource = pCapitalPlot:GetProperty(sPropKeyCount) or 0
        print('previous: '  .. sPropKeyCount .. tostring(iPastResource))
        print('new Gameplay: '  .. sPropKeyCount .. tostring(iResourceCount))
        print('new UI: '  .. sPropKeyCount .. tostring(iResourceCount))
        if iResourceCount ~= iPastResource then
            local tParameters = {}
            tParameters.sPropKey = sPropKeyCount;
            tParameters.iPropValue = iResourceCount;
            tParameters.OnStart = "SlthSetCapitalProperty";
            UI.RequestPlayerOperation(ownerPlayerID, PlayerOperations.EXECUTE_SCRIPT, tParameters);
            local tBinariesToSet = tBinaryMap[tostring(iResourceCount)]
            local sPropKey =  sPropKeyCount .. '_BINARY_'
            local sFullPropKey
            for key, val in pairs(tBinariesToSet) do
                sFullPropKey = sPropKey .. key
                tParameters.sPropKey = sFullPropKey;
                tParameters.iPropValue = val;
                UI.RequestPlayerOperation(ownerPlayerID, PlayerOperations.EXECUTE_SCRIPT, tParameters);
                print('Setting ' .. sFullPropKey .. ' to ' .. tostring(val))
            end
            if iPastResource == 0 then
                tParameters.OnStart= 'SlthSetResourcePromotions'
                tParameters.ResourceID = resourceTypeID
                UI.RequestPlayerOperation(ownerPlayerID, PlayerOperations.EXECUTE_SCRIPT, tParameters);
            end
        end
    end
end

Events.PlayerResourceChanged.Add(UpdateResourceAvailability)
