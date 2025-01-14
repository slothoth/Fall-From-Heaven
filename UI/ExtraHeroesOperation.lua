
-- UnitOperation
-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------
g_selectedPlayerId = -1;
g_selectedUnitId = -1;

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

local tAltChoiceTables
tAltUpgradeChoices = {}
local tControlsAdded

local tUpgradeUnitValues = {}
local tUpgradeUnitCosts = {}

local tExperienceUpgrades = {['SLTH_UNIT_MAGE'] = 4, ['SLTH_UNIT_ARCHMAGE'] = 6, ['SLTH_UNIT_ILLUSIONIST'] = 4, ['SLTH_UNIT_WIZARD'] = 4,
                             ['SLTH_UNIT_EATER_OF_DREAMS'] = 6, ['SLTH_UNIT_IMMORTAL'] = 6, ['SLTH_UNIT_ANGEL_OF_DEATH'] = 4,
                             ['SLTH_UNIT_VALKYRIE'] = 4, ['SLTH_UNIT_HERALD'] = 4, ['SLTH_UNIT_REPENTANT_ANGEL'] = 3,
                             ['SLTH_UNIT_SERAPH'] = 4, ['SLTH_UNIT_OPHANIM'] = 4, ['SLTH_UNIT_VAMPIRE_LORD'] = 12, ['SLTH_UNIT_SATYR'] = 4
}

local tNationalUpgrades = {['SLTH_UNIT_PHALANX']= true, ['SLTH_UNIT_NULLSTONE_GOLEM']= true, ['SLTH_UNIT_STONESKIN_OGRE']= true,
                           ['SLTH_UNIT_BERSERKER'] = true, ['SLTH_UNIT_BRUJAH'] = true, ['SLTH_UNIT_CLOCKWORK_GOLEM'] = true, ['SLTH_UNIT_BALOR'] = true,
                           ['SLTH_UNIT_BEASTMASTER'] = true, ['SLTH_UNIT_MYCONID'] = true,
                           ['SLTH_UNIT_KNIGHT'] = true,  ['SLTH_UNIT_DEATH_KNIGHT'] = true, ['SLTH_UNIT_BISON_RIDER'] = true,  ['SLTH_UNIT_CENTAUR_LANCER'] = true, ['SLTH_UNIT_HORNGUARD'] = true,  ['SLTH_UNIT_WAR_TORTOISE'] = true,
                           ['SLTH_UNIT_ARCHMAGE'] = true,   ['SLTH_UNIT_EATER_OF_DREAMS'] = true,
                           ['SLTH_UNIT_LICH'] = true,
                           ['SLTH_UNIT_IMMORTAL'] = true, ['SLTH_UNIT_VAMPIRE_LORD'] = true, ['SLTH_UNIT_BONE_GOLEM'] = true, ['SLTH_UNIT_OGRE_WARCHIEF'] = true,
                           ['SLTH_UNIT_OPHANIM'] = true, ['SLTH_UNIT_REPENTANT_ANGEL'] = true, ['SLTH_UNIT_ANGEL_OF_DEATH'] = true, ['SLTH_UNIT_SERAPH'] = true, ['SLTH_UNIT_VALKYRIE'] = true, ['SLTH_UNIT_HERALD'] = true,
                           ['SLTH_UNIT_SHADOW'] = true, ['SLTH_UNIT_DWARVEN_SHADOW'] = true, ['SLTH_UNIT_COURTESAN'] = true,
                           ['SLTH_UNIT_SHADOWRIDER'] = true, ['SLTH_BEAST_OF_AGARES'] = true,
                           ['SLTH_UNIT_HIGH_PRIEST_OF_WINTER'] = true, ['SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH'] = true, ['SLTH_UNIT_HIGH_PRIEST_OF_LEAVES'] = true, ['SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL'] = true, ['SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS'] = true, ['SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN'] = true,  ['SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER'] = true,
                           ['SLTH_UNIT_MARKSMAN'] = true,
                           ['SLTH_UNIT_EIDOLON'] = true, ['SLTH_UNIT_PALADIN'] = true, ['SLTH_UNIT_DRUID'] = true, ['SLTH_UNIT_DWARVEN_DRUID'] = true, ['SLTH_UNIT_LUONNOTAR'] = true,
                           ['SLTH_UNIT_CROSSBOWMAN'] = true, ['SLTH_UNIT_FLURRY'] = true,
                           ['SLTH_UNIT_ROYAL_GUARD'] = true}

local tAlignmentUnits = {
    ['SLTH_UNIT_EIDOLON'] = 'alignment_evil', ['SLTH_UNIT_PALADIN'] = 'alignment_good', ['SLTH_UNIT_DRUID'] = 'alignment_neutral', ['SLTH_UNIT_DWARVEN_DRUID'] = 'alignment_neutral',

}

local tPolicyUnits = {
['SLTH_UNIT_SHADOWRIDER'] = 'SLTH_POLICY_STATE_ESUS', ['SLTH_UNIT_SHADOW'] = 'SLTH_POLICY_STATE_ESUS', ['SLTH_UNIT_DWARVEN_SHADOW'] = 'SLTH_POLICY_STATE_ESUS', ['SLTH_UNIT_COURTESAN'] = 'SLTH_POLICY_STATE_ESUS',
['SLTH_UNIT_HIGH_PRIEST_OF_KILMORPH'] = 'SLTH_POLICY_STATE_RUNES', ['SLTH_UNIT_PRIEST_OF_KILMORPH'] = 'SLTH_POLICY_STATE_RUNES', ['SLTH_UNIT_PARAMANDER'] = 'SLTH_POLICY_STATE_RUNES',
['SLTH_UNIT_HIGH_PRIEST_OF_LEAVES'] = 'SLTH_POLICY_STATE_LEAVES', ['SLTH_UNIT_PRIEST_OF_LEAVES'] = 'SLTH_POLICY_STATE_LEAVES', ['SLTH_UNIT_SATYR'] = 'SLTH_POLICY_STATE_LEAVES',
['SLTH_UNIT_HIGH_PRIEST_OF_THE_VEIL'] = 'SLTH_POLICY_STATE_VEIL', ['SLTH_UNIT_PRIEST_OF_THE_VEIL'] = 'SLTH_POLICY_STATE_VEIL', ['SLTH_BEAST_OF_AGARES'] = 'SLTH_POLICY_STATE_VEIL',
['SLTH_UNIT_HIGH_PRIEST_OF_THE_OVERLORDS'] = 'SLTH_POLICY_STATE_OCTOPUS', ['SLTH_UNIT_PRIEST_OF_THE_OVERLORDS'] = 'SLTH_POLICY_STATE_OCTOPUS', ['SLTH_UNIT_STYGIAN_GUARD'] = 'SLTH_POLICY_STATE_OCTOPUS',
['SLTH_UNIT_HIGH_PRIEST_OF_THE_EMPYREAN'] = 'SLTH_POLICY_STATE_EMPYREAN', ['SLTH_UNIT_PRIEST_OF_THE_EMPYREAN'] = 'SLTH_POLICY_STATE_EMPYREAN', ['SLTH_UNIT_RATHA'] = 'SLTH_POLICY_STATE_EMPYREAN',
['SLTH_UNIT_HIGH_PRIEST_OF_THE_ORDER'] = 'SLTH_POLICY_STATE_ORDER', ['SLTH_UNIT_PRIEST_OF_THE_ORDER'] = 'SLTH_POLICY_STATE_ORDER', ['SLTH_UNIT_CRUSADER'] = 'SLTH_POLICY_STATE_ORDER',
['SLTH_UNIT_ROYAL_GUARD'] = 'SLTH_POLICY_ARISTOCRACY'
}
-- 'SON_OF_THE_INFERNO'


function myRefresh(iPlayerID, iUnitID, iOldID)
    local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
    local pPlayer = Players[iPlayerID]
    if pUnit:GetMovesRemaining() == 0 then
        FlushButtons()
        return
    end
    local iUnitIndex = pUnit:GetType()
    local bCanUpgrade = true
    local tAltUpgrades = tAltUpgradeChoices[iUnitIndex]
    local iPlot = pUnit:GetPlotId()
    local pPlot = Map.GetPlotByIndex(iPlot)
    local iPlotOwner = pPlot:GetOwner()
    local bUpgradableTerritory = iPlotOwner == iPlayerID            -- misses on allies, city states suzerains
    if PlayerConfigurations[iPlayerID]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_DOVIELLO' then
        bUpgradableTerritory = true                 -- also hides upgrade options, instead grey them out?
    end
    if tAltUpgrades then
        -- print('Unit does have alt upgrades')
        local rscOriginalUnitInfo = GameInfo.Units[iUnitIndex]
        local iCurrentGold = pPlayer:GetTreasury():GetGoldBalance()
        for idx, tButtonInfo in pairs(tControlsAdded) do
            local gridButton = tButtonInfo['grid']
            local iconButton = tButtonInfo['icon']
            local tUpgradeInfo = tAltUpgrades[idx]
            -- print('on index ' .. tostring(idx))
            if tUpgradeInfo then
                -- print('Unit has upgrade info on index ' .. tostring(idx))
                local iUnitUpgradeIndex = tUpgradeInfo['index']
                local rscUnitInfo = GameInfo.Units[iUnitUpgradeIndex]
                local sPrereqTech = rscUnitInfo.PrereqTech
                local sPrereqCivic = rscUnitInfo.PrereqCivic
                if sPrereqTech then
                    -- print('checking has tech ' .. tostring(sPrereqTech))
                    local iPrereqTech = GameInfo.Technologies[sPrereqTech].Index
                    bCanUpgrade = pPlayer:GetTechs():HasTech(iPrereqTech)
                end

                if sPrereqCivic then
                    -- print('checking has civic ' .. tostring(sPrereqCivic))
                    local iPrereqCivic = GameInfo.Civics[sPrereqCivic].Index
                    bCanUpgrade = pPlayer:GetCulture():HasCivic(iPrereqCivic)
                end

                local sPrereqPolicy = tPolicyUnits[rscUnitInfo.UnitType]
                if sPrereqPolicy then
                    bCanUpgrade = pPlayer:GetCulture():IsPolicyActive(sPrereqPolicy)
                end

                local sPrereqAlignmentPropKey = tAlignmentUnits[rscUnitInfo.UnitType]
                if sPrereqAlignmentPropKey then
                    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
                    if pCapitalCity then
                        local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
                        bCanUpgrade = (pCapitalPlot:GetProperty(sPrereqAlignmentPropKey) or 0) > 0
                    else
                        bCanUpgrade = false
                    end
                end

                local iPrereqExperience = tExperienceUpgrades[rscUnitInfo.UnitType]
                if iPrereqExperience then
                    bCanUpgrade = pUnit:GetExperience():GetLevel() >= iPrereqExperience
                end

                -- local iPrereqNationalMax = tNationalUpgrades[rscUnitInfo.UnitType]
                -- if iPrereqNationalMax then
                -- check
                --    print('')
                -- end

                if bCanUpgrade then
                    -- print('Unit can upgrade, showing button')
                    gridButton:SetHide(false)
                    local name = Locale.Lookup('LOC_' .. tUpgradeInfo['name'] .. '_NAME')
                    local iUpgradeUnitCost = rscUnitInfo.Cost
                    local iOriginalUnitCost = rscOriginalUnitInfo.Cost
                    local iUpgradeCost = (iUpgradeUnitCost - iOriginalUnitCost) * 2
                    local sUpgradeInfo = 'Upgrade to ' .. name .. ': ' .. tostring(iUpgradeCost) .. '[ICON_GOLD] Gold'
                    if iCurrentGold < iUpgradeCost then
                        gridButton:SetDisabled(true)
                        gridButton:SetAlpha(0.4)
                        gridButton:SetToolTipString(sUpgradeInfo .. '[NEWLINE][COLOR:Red]Not enough Gold in Treasury.[ENDCOLOR]')
                    elseif not bUpgradableTerritory then
                        gridButton:SetDisabled(true)
                        gridButton:SetAlpha(0.4)
                        gridButton:SetToolTipString(sUpgradeInfo .. '[NEWLINE][COLOR:Red]Not in Friendly Territory.[ENDCOLOR]')
                    else
                        gridButton:SetDisabled(false)
                        gridButton:SetAlpha(1)
                        gridButton:SetToolTipString(sUpgradeInfo)
                        tButtonInfo['button']:RegisterCallback(Mouse.eLClick, tButtonInfo['callback'])
                    end
                    -- print('setting up upgrade value on table index ' .. tostring(idx) .. ' to unit index ' .. tostring(iUnitUpgradeIndex))
                    tUpgradeUnitValues[idx] = iUnitUpgradeIndex
                    tUpgradeUnitCosts[idx] = iUpgradeCost
                    local textureOffsetX, textureOffsetY, textureSheet = IconManager:FindIconAtlas('ICON_' .. tUpgradeInfo['name'],38);
                    if textureSheet then
                        iconButton:SetTexture(textureOffsetX, textureOffsetY, textureSheet);
                    end
                else
                    gridButton:SetHide(true)
                end
            else
                gridButton:SetHide(true)
            end
        end
    else
        FlushButtons()
    end
    -- map each upgradetable available to a button
    -- change what is on the button text, the unit to upgrade to, and the cost
    -- change some variables for the cost of each upgrade, to use when pressed
end


function OnUnitSelectionChanged(iPlayerID, iUnitID, iPlotX, iPlotY, iPlotZ, bSelected, bEditable)
    if bSelected then
        -- local iOldID = g_selectedUnitId         -- for preserving some buttons? not used
        g_selectedPlayerId = iPlayerID;
        g_selectedUnitId = iUnitID;
        myRefresh(iPlayerID, iUnitID);
    end
end

function onUnitSelectedMoved(playerID, unitID, x, y, locallyVisible ,stateChange)       -- currently unhooked
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
    for idx, tButtonInfo in pairs(tControlsAdded) do
        tButtonInfo['grid']:SetHide(true)
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


function OnBespokeUpgradeTwo()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    local tParameters = {}
    tParameters.OnStart= 'SlthOnConvertUnitType'
    tParameters.iUnitID = iUnit
    tParameters.iUpgradeUnitIndex = tUpgradeUnitValues[1]
    tParameters.iCost = tUpgradeUnitCosts[1]
    print('requesting upgrade to unit ' .. GameInfo.Units[tUpgradeUnitValues[1]].UnitType)
	UI.DeselectUnit(pUnit);
    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tParameters);
    UnitManager.RequestCommand( pUnit, UnitCommandTypes.DELETE )
	return;
end

function OnBespokeUpgradeThree()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    local tParameters = {}
    tParameters.OnStart= 'SlthOnConvertUnitType'
    tParameters.iUnitID = iUnit
    tParameters.iUpgradeUnitIndex = tUpgradeUnitValues[2]
    tParameters.iCost = tUpgradeUnitCosts[2]
    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tParameters);
	UI.DeselectUnit(pUnit);
    UnitManager.RequestCommand( pUnit, UnitCommandTypes.DELETE )
	return;
end

function OnBespokeUpgradeFour()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    local tParameters = {}
    tParameters.OnStart= 'SlthOnConvertUnitType'
    tParameters.iUnitID = iUnit
    tParameters.iUpgradeUnitIndex = tUpgradeUnitValues[3]
    tParameters.iCost = tUpgradeUnitCosts[3]
    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tParameters);
	UI.DeselectUnit(pUnit);
    UnitManager.RequestCommand( pUnit, UnitCommandTypes.DELETE )
	return;
end

function OnBespokeUpgradeFive()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    local tParameters = {}
    tParameters.OnStart = 'SlthOnConvertUnitType'
    tParameters.iUnitID = iUnit
    tParameters.iUpgradeUnitIndex = tUpgradeUnitValues[4]
    tParameters.iCost = tUpgradeUnitCosts[4]
    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tParameters);
	UI.DeselectUnit(pUnit);
    UnitManager.RequestCommand( pUnit, UnitCommandTypes.DELETE )
	return;
end

function OnBespokeUpgradeSix()
    local pUnit, iX, iY ,iUnit, iPlayer = UnitGatherInfo()
    local tParameters = {}
    tParameters.OnStart = 'SlthOnConvertUnitType'
    tParameters.iUnitID = iUnit
    tParameters.iUpgradeUnitIndex = tUpgradeUnitValues[5]
    tParameters.iCost = tUpgradeUnitCosts[5]
    UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tParameters);
	UI.DeselectUnit(pUnit);
    UnitManager.RequestCommand( pUnit, UnitCommandTypes.DELETE )
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
                   [1] = {['grid'] = Controls.SettleButtonGridUnitUpgradesAltTwo,   ['button'] = Controls.SettleButtonUnitUpgradesAltTwo,   ['callback'] = OnBespokeUpgradeTwo, ['icon'] = Controls.SettleButtonIconUnitUpgradesAltTwo},
                   [2] = {['grid'] = Controls.SettleButtonGridUnitUpgradesAltThree, ['button'] = Controls.SettleButtonUnitUpgradesAltThree, ['callback'] = OnBespokeUpgradeThree, ['icon'] = Controls.SettleButtonIconUnitUpgradesAltThree },
                   [3] = {['grid'] = Controls.SettleButtonGridUnitUpgradesAltFour,  ['button'] = Controls.SettleButtonUnitUpgradesAltFour,  ['callback'] = OnBespokeUpgradeFour, ['icon'] = Controls.SettleButtonIconUnitUpgradesAltFour },
                   [4] = {['grid'] = Controls.SettleButtonGridUnitUpgradesAltFive,  ['button'] = Controls.SettleButtonUnitUpgradesAltFive,  ['callback'] = OnBespokeUpgradeFive, ['icon'] = Controls.SettleButtonIconUnitUpgradesAltFive },
                   [5] = {['grid'] = Controls.SettleButtonGridUnitUpgradesAltSix,  ['button'] = Controls.SettleButtonUnitUpgradesAltSix,  ['callback'] = OnBespokeUpgradeSix, ['icon'] = Controls.SettleButtonIconUnitUpgradesAltSix }
    }

    if ctrl ~= nil then
        for idx, tButtonInfo in pairs(tControlsAdded) do
            local gridButton = tButtonInfo['grid']
            gridButton:ChangeParent(ctrl)
        end
    end

    tAltChoiceTables = {[1]=GameInfo.UnitUpgradesAlt, [2]=GameInfo.UnitUpgradesAltTwo, [3]=GameInfo.UnitUpgradesAltThree,
                        [4]=GameInfo.UnitUpgradesAltFour, [5]=GameInfo.UnitUpgradesAltFive}


    tAltUpgradeChoices = {}

    for row in GameInfo.Units() do
        tAltUpgradeChoices[row.Index] = {}
        local bHasAltUpgrade
        for idx, upgradeTable in ipairs(tAltChoiceTables) do
            local tRowUpgradeInfo = upgradeTable[row.UnitType]
            if tRowUpgradeInfo then
                local sUpgradeUnit = tRowUpgradeInfo.UpgradeUnit
                local upgradeUnitIndex = GameInfo.Units[sUpgradeUnit].Index
                local tUpgradeInfos = {['name']= sUpgradeUnit, ['index']= upgradeUnitIndex}
                -- print('adding entry ' .. tostring(row.Index) .. ' with upgrade ' .. sUpgradeUnit .. ' and index ' .. tostring(upgradeUnitIndex))
                table.insert(tAltUpgradeChoices[row.Index], tUpgradeInfos)
                bHasAltUpgrade = true
            end
        end
        if not bHasAltUpgrade then                         -- remove entry if empty
            tAltUpgradeChoices[row.UnitType] = nil
        end
    end

	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
end

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
        -- print('previous: '  .. sPropKeyCount .. tostring(iPastResource))
        -- print('new Gameplay: '  .. sPropKeyCount .. tostring(iResourceCount))
        -- print('new UI: '  .. sPropKeyCount .. tostring(iResourceCount))
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
                -- print('Setting ' .. sFullPropKey .. ' to ' .. tostring(val))
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

Events.LoadGameViewStateDone.Add(Setup)
Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)
Events.UnitOperationsCleared.Add(onOperationMoveEnded)


