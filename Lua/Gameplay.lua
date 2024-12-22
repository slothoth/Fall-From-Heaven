local FreeXPUnits = { SLTH_UNIT_ADEPT = 1, SLTH_UNIT_IMP = 1, SLTH_UNIT_SHAMAN = 1, SLTH_UNIT_ARCHMAGE = 2, SLTH_UNIT_EATER_OF_DREAMS = 2,
                      SLTH_UNIT_CORLINDALE = 2, SLTH_UNIT_DISCIPLE_OF_ACHERON = 1, SLTH_UNIT_GAELAN = 1.5, SLTH_UNIT_GIBBON = 2,
                      SLTH_UNIT_GOVANNON = 2, SLTH_UNIT_HEMAH = 2, SLTH_UNIT_LICH = 2, SLTH_UNIT_ILLUSIONIST = 1.5, SLTH_UNIT_MAGE = 1.5,
                      SLTH_UNIT_WIZARD = 1.5, SLTH_UNIT_MOBIUS_WITCH = 1.5, SLTH_UNIT_MOKKA = 1.5, SLTH_UNIT_SON_OF_THE_INFERNO = 2}

local tMonitoredResources = {
    [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index] = { rtype='MANA', name='DEATH'},
    [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index] = { rtype='MANA', name='FIRE'},
    [GameInfo.Resources['RESOURCE_MANA_AIR'].Index] = { rtype='MANA', name='AIR'},
    [GameInfo.Resources['RESOURCE_MANA_BODY'].Index] = { rtype='MANA', name='BODY'},
    [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index] = { rtype='MANA', name='CHAOS'},
    [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index] = { rtype='MANA', name='EARTH'},
    [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index] = { rtype='MANA', name='ENCHANTMENT'},
    [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index] = { rtype='MANA', name='ENTROPY'},
    [GameInfo.Resources['RESOURCE_MANA_ICE'].Index] = { rtype='MANA', name='ICE'},
    [GameInfo.Resources['RESOURCE_MANA_LAW'].Index] = { rtype='MANA', name='LAW'},
    [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index] = { rtype='MANA', name='LIFE'},
    [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index] = { rtype='MANA', name='METAMAGIC'},
    [GameInfo.Resources['RESOURCE_MANA_MIND'].Index] = { rtype='MANA', name='MIND'},
    [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index] = { rtype='MANA', name='NATURE'},
    [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index] = { rtype='MANA', name='SPIRIT'},
    [GameInfo.Resources['RESOURCE_MANA_WATER'].Index] = { rtype='MANA', name='WATER'},
    [GameInfo.Resources['RESOURCE_MANA_SUN'].Index] = { rtype='MANA', name='SUN'},
    [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index] = { rtype='MANA', name='SHADOW'},
    [GameInfo.Resources['RESOURCE_BANANA'].Index] = { rtype='AFFINITY', name='BANANA'},
    [GameInfo.Resources['RESOURCE_COPPER'].Index] = { rtype='AFFINITY', name='COPPER'},
    [GameInfo.Resources['RESOURCE_IRON'].Index] = { rtype='AFFINITY', name='IRON'},
    [GameInfo.Resources['RESOURCE_MITHRIL'].Index] = { rtype='AFFINITY', name='MITHRIL'},
    [GameInfo.Resources['RESOURCE_SHEUT_STONE'].Index] = { rtype='AFFINITY', name='SHEUT_STONE'},
    [GameInfo.Resources['RESOURCE_NIGHTMARE'].Index] = { rtype='AFFINITY', name='NIGHTMARE'}}

local tImprovementsProgression = {
        [GameInfo.Improvements['IMPROVEMENT_COTTAGE'].Index]        = GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index,
        [GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index]         = GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index]        = GameInfo.Improvements['IMPROVEMENT_TOWN'].Index,
        [GameInfo.Improvements['IMPROVEMENT_TOWN'].Index]           = GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_PIRATE_COVE'].Index]    = GameInfo.Improvements['IMPROVEMENT_PIRATE_HARBOR'].Index,
        [GameInfo.Improvements['IMPROVEMENT_PIRATE_HARBOR'].Index]  = GameInfo.Improvements['IMPROVEMENT_FEITORIA'].Index}
    local tImprovementsRegression = {
        [GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index]         = GameInfo.Improvements['IMPROVEMENT_COTTAGE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index]        = GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index,
        [GameInfo.Improvements['IMPROVEMENT_TOWN'].Index]           = GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index]        = GameInfo.Improvements['IMPROVEMENT_TOWN'].Index,
        [GameInfo.Improvements['IMPROVEMENT_PIRATE_HARBOR'].Index]  = GameInfo.Improvements['IMPROVEMENT_PIRATE_COVE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_FEITORIA'].Index]       = GameInfo.Improvements['IMPROVEMENT_PIRATE_HARBOR'].Index}
    local tImprovementsCivProgression = {
        [GameInfo.Improvements['IMPROVEMENT_TOWN'].Index]           = GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index}


    local tManaNodeMapper = {
        [GameInfo.Improvements['IMPROVEMENT_MANA_AIR'].Index]         = GameInfo.Resources['RESOURCE_MANA_AIR'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_BODY'].Index]        = GameInfo.Resources['RESOURCE_MANA_BODY'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_CHAOS'].Index]       = GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_DEATH'].Index]       = GameInfo.Resources['RESOURCE_MANA_DEATH'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_EARTH'].Index]       = GameInfo.Resources['RESOURCE_MANA_EARTH'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_ENCHANTMENT'].Index] = GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_ENTROPY'].Index]     = GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_FIRE'].Index]        = GameInfo.Resources['RESOURCE_MANA_FIRE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_LAW'].Index]         = GameInfo.Resources['RESOURCE_MANA_LAW'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_LIFE'].Index]        = GameInfo.Resources['RESOURCE_MANA_LIFE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_METAMAGIC'].Index]   = GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_MIND'].Index]        = GameInfo.Resources['RESOURCE_MANA_MIND'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_NATURE'].Index]      = GameInfo.Resources['RESOURCE_MANA_NATURE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_SHADOW'].Index]      = GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_SPIRIT'].Index]      = GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_SUN'].Index]         = GameInfo.Resources['RESOURCE_MANA_SUN'].Index,
        [GameInfo.Improvements['IMPROVEMENT_MANA_WATER'].Index]       = GameInfo.Resources['RESOURCE_MANA_WATER'].Index
    }
local tBarbNW = {
	[GameInfo.Features['FEATURE_UBSUNUR_HOLLOW'].Index] = 1,
	[GameInfo.Features['FEATURE_GOBUSTAN'].Index] = 1,
	[GameInfo.Features['FEATURE_DELICATE_ARCH'].Index] = 1,
	[GameInfo.Features['FEATURE_YOSEMITE'].Index] = 1}

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

local tSuperSpecialistModifiers = {[GameInfo.Units['UNIT_GREAT_PROPHET'].Index]={
	'MODIFIER_SLTH_GREAT_PROPHET_ADD_PROD', 'MODIFIER_SLTH_GREAT_PROPHET_ADD_GOLD',
	'MODIFIER_SLTH_GREAT_PROPHET_ADD_PROD_BLESSED', 'MODIFIER_SLTH_GREAT_PROPHET_ADD_PROD_DIVINE',
	'MODIFIER_SLTH_GREAT_PROPHET_ADD_PROD_FINAL'},
	[GameInfo.Units['UNIT_GREAT_ENGINEER'].Index]={
	'MODIFIER_SLTH_GREAT_ENGINEER_ADD_SCIENCE', 'MODIFIER_SLTH_GREAT_ENGINEER_ADD_PRODUCTION',
	'MODIFIER_SLTH_GREAT_ENGINEER_ADD_PRODUCTION_SIDAR', 'MODIFIER_SLTH_GREAT_ENGINEER_ADD_PRODUCTION_GUILD_OF_HAMMERS'},
	[GameInfo.Units['UNIT_GREAT_SCIENTIST'].Index]={
		'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_PROD', 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE',
		'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE_SIDAR', 'MODIFIER_SLTH_GREAT_SCIENTIST_ADD_SCIENCE_GREAT_LIB'},
	[GameInfo.Units['UNIT_GREAT_ARTIST'].Index]={
		'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE', 'MODIFIER_SLTH_GREAT_ARTIST_ADD_GOLD',
		'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE_SIDAR', 'MODIFIER_SLTH_GREAT_ARTIST_ADD_CULTURE_THEATRE_OF_DREAMS'},
	[GameInfo.Units['UNIT_GREAT_MERCHANT'].Index]={
		'MODIFIER_SLTH_GREAT_MERCHANT_ADD_FOOD', 'MODIFIER_SLTH_GREAT_MERCHANT_ADD_GOLD',
		'MODIFIER_SLTH_GREAT_MERCHANT_ADD_GOLD_SIDAR'}
}

local tSuperSpecialistGenericModifiers = {'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_HALL_OF_KINGS',
									'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_CASTE_SYSTEM',
									'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_CASTE_SYSTEM',
									'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_SCHOLARSHIP'}

local transientBuffKeys = {
        BUFF_HASTE = 0, BUFF_DANCE_OF_BLADES = 0, BUFF_CHARMED = 80, BUFF_SLOW = 70,
        BUFF_BLUR = 50, BUFF_SHADOWWALK = 75, BUFF_FAIR_WINDS = 95, BUFF_BURNING_BLOOD = 90,
        BUFF_FATIGUED = 50, BUFF_CROWN_OF_BRILLIANCE = 80, BUFF_MORALE = 90, BUFF_WARCRY = 95
    }

function SlthLog(sMessage)
    SLTH_DEBUG_ON = nil
    if SLTH_DEBUG_ON then
        print(sMessage)
    end
end

local tAllPromotions = {}
for row in GameInfo.UnitPromotions() do
    table.insert(tAllPromotions, row.Index)
end

local tAllAbilities = {}
for row in GameInfo.UnitAbilities() do
    table.insert(tAllAbilities, row.UnitAbilityType)
end

function InheritUnitAttributes(iPlayer, iUnit)
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit)
    local pUnitExp = pUnit:GetExperience()
    local pUnitAbilities = pUnit:GetAbility()
    local iUnitHealth = pUnit:GetDamage()
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    local tPromosToGrant = {}
    for _, iUnitPromotionIndex in ipairs(tAllPromotions) do
        if pUnitExp:HasPromotion(iUnitPromotionIndex) then
            table.insert(tPromosToGrant, iUnitPromotionIndex)            -- need to watch out for dummy promos being granted twice
        end
    end

    local tAbilitiesToGrant = {}
    for _, sUnitAbilityType in ipairs(tAllAbilities) do
        if pUnitAbilities:HasAbility(sUnitAbilityType) then
            table.insert(tAbilitiesToGrant, sUnitAbilityType)
        end
    end
    return iUnitHealth, iX, iY, tPromosToGrant, tAbilitiesToGrant
end

function GetFullUpgradePath(iPlayer, iUnitIndex)
    local bHasTech
    local bHasCivic
    local iUnitUpgradeIndex
    local iUpgradeCost
    local sUnit = GameInfo.Units[iUnitIndex].UnitType
    local sUnitUpgradeUnitType = GameInfo.UnitUpgradesAlt[sUnit].UpgradeUnit
    local sPrereqTech = GameInfo.Units[sUnitUpgradeUnitType].PrereqTech
    local sPrereqCivic = GameInfo.Units[sUnitUpgradeUnitType].PrereqCivic
    -- we should probably also look at other prereqs like strategic resources, or national units?
    local pPlayer = Players[iPlayer]
    print(sUnit)
    print(sUnitUpgradeUnitType)
    print(sPrereqTech)
    print(sPrereqCivic)
    if sPrereqTech then
        local iPrereqTech = GameInfo.Technologies[sPrereqTech].TechnologyType
        bHasTech = pPlayer:GetTechs():HasTech(iPrereqTech)
    else
        bHasTech = true
    end

    if sPrereqCivic then
        local iPrereqCivic = GameInfo.Civics[sPrereqCivic].CivicType
        bHasCivic = pPlayer:GetCulture():HasCivic(iPrereqCivic)
    else
        bHasCivic = true
    end

    if bHasTech and bHasCivic then
        iUnitUpgradeIndex = GameInfo.Units[sUnitUpgradeUnitType].Index
        local iUnitCost = GameInfo.Units[iUnitIndex].Cost
        local iUpgradeUnitCost = GameInfo.Units[sUnitUpgradeUnitType].Cost
        iUpgradeCost = (iUpgradeUnitCost - iUnitCost) *2
        print('Upgraded unit cost: ' .. tostring(iUpgradeUnitCost) .. ' - original unit cost: ' .. tostring(iUnitCost) .. ' times by two is '.. tostring(iUpgradeCost))
        -- iUnitUpgradeIndex = GetFullUpgradePath(iPlayer, iUnitUpgradeIndex)  -- recursive variant. but no cost summing
    end                                                                        -- also doesnt deal with alt/normal path
    print(iUnitUpgradeIndex)
    print(iUpgradeCost)
    return iUnitUpgradeIndex, iUpgradeCost                                                   -- mixing.
end

local function BaseSummon(pCasterUnit, iPlayer, iUnitIndex)
    local iX =  pCasterUnit:GetX()
    local iY =  pCasterUnit:GetY()
    local playerReal = Players[iPlayer];
    local playerUnits = playerReal:GetUnits();
    local pPlot = Map.GetPlot(iX, iY)
    local tBeforeSummonUnits = {}
    for _, pOnTileUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do
        if pOnTileUnit then
            tBeforeSummonUnits[pOnTileUnit:GetID()] = true
        end
    end
    playerUnits:Create(iUnitIndex, iX, iY);
    local tNewUnits = {}
    for _, pOnTileUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do
        if pOnTileUnit then
            local iUnitID = pOnTileUnit:GetID()
            if not tBeforeSummonUnits[iUnitID] then
                tNewUnits[iUnitID] = pOnTileUnit
            end
        end
    end
    for iUnitID, pNewUnit in pairs(tNewUnits) do
        print('set inherited abilities here')
    end
    return tNewUnits
end

function onTurnStartGameplay(playerId)
    local pPlayer = Players[playerId];
    for _, unit in pPlayer:GetUnits():Members() do              -- SECTION: do reset castable
        if unit:GetProperty('HasCast') then
            print('setting HasCast to 0')
            unit:SetProperty('HasCast', 0)
        end
        local iUnitIndex = unit:GetType();                      -- SECTION: passive experience gain
        local sUnitType = GameInfo.Units[iUnitIndex].UnitType
        if not sUnitType then return; end                       -- remove once table correct
        local fXP_gain = FreeXPUnits[sUnitType] or 0
        local pUnitAbilities = unit:GetAbility()
        if pUnitAbilities and pUnitAbilities:HasAbility('SLTH_ABILITY_POTENCY') then
            fXP_gain = fXP_gain + 1
        end
        if fXP_gain > 0 then
            if fXP_gain == math.floor(fXP_gain) then
                -- if integer, simple add xp
                unit:GetExperience():ChangeExperience(fXP_gain);
            else
                -- if float, use property to set state.
                local iXP_portion, fXP_portion = math.modf(fXP_gain);
                SlthLog('Decimal portion of xp gain is:')
                SlthLog(fXP_portion);
                local existing_xp_portion = unit:GetProperty('xp_portion');
                if not existing_xp_portion then
                    unit:SetProperty('xp_portion', fXP_portion);
                    SlthLog('No prior xp_portion');
                else
                    local new_xp_portion = existing_xp_portion + fXP_portion;
                    if new_xp_portion > 1 then
                        iXP_portion = iXP_portion + 1;
                        new_xp_portion = new_xp_portion - 1;
                    end
                    unit:SetProperty('xp_portion', new_xp_portion);
                    SlthLog('Old xp_portion: ' .. existing_xp_portion .. ' New xp_portion: ' .. new_xp_portion);
                end
                SlthLog('Adding ' .. iXP_portion .. ' to unit.')
                unit:GetExperience():ChangeExperience(iXP_portion);
            end
        end
    end
    -- SECTION: update altars. done so all luonnotars arent granted at once
    for _, pCity in pPlayer:GetCities():Members() do
        local sLuonnotarDummyModifier = pCity:GetProperty('luonnotar_dummy')
        if sLuonnotarDummyModifier then
            print('player turn started: and city valid for next altar. attaching:')
            print(sLuonnotarDummyModifier)
            pCity:AttachModifierByID(sLuonnotarDummyModifier)
            print('player turn started: removed blocker')
            return
        end
    end
    -- SECTION: transient buff cycling
    for sBuffAbility, percent_gate in pairs(transientBuffKeys) do
        local sPropbuff_propkey = sBuffAbility .. ('_UNITS')
        local tSpecificBuffState = Game:GetProperty(sPropbuff_propkey) or {}
        local tNewBuffState = {}
        for _, tUnitInfos in ipairs(tSpecificBuffState) do
            local iCasterPlayer = tUnitInfos['iCasterPlayer']
            if playerId == iCasterPlayer then
                local percent_roll = math.random(100)
                local iPlayer = tUnitInfos['iPlayer']
                local iUnit = tUnitInfos['iUnit']
                local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
                if pUnit then
                    if percent_roll > percent_gate then
                        local pAbility = pUnit:GetAbility()
                        if pAbility and pAbility:HasAbility(sBuffAbility) then
                            pAbility:RemoveAbilityCount(sBuffAbility)
                        end
                    else
                        table.insert(tNewBuffState, tUnitInfos)         -- only include in new state if unit exists,
                    end                                                 -- it has ability, and failed RNG
                end
            end
        end
    end
    -- local BUFF_HASTE_UNITS = {[0]= {iPlayer=0, iUnit=130, iCasterPlayer=0}}
    --BUFF_REGENERATION -- when full
    -- local afterCombat = {BUFF_BLESSED=true, BUFF_ENRAGED=true, BUFF_STONESKIN=true}
end

------------ Cottage / Pirate Cove improvement upgrading over turns  ---------

function ImprovementsWorkOrPillageChange(x, y, improvementIndex, improvementPlayerID, resourceIndex, isPillaged, isWorked)
    local iImprovementToDowngradeIndex = tImprovementsRegression[improvementIndex]
    local pPlot
    if iImprovementToDowngradeIndex and isPillaged > 0 then
        pPlot = Map.GetPlot(x, y)
        ImprovementBuilder.SetImprovementType(pPlot, iImprovementToDowngradeIndex, improvementPlayerID)
        return
    end
    if tImprovementsProgression[improvementIndex] then
         pPlot = Map.GetPlot(x, y)
         if tImprovementsCivProgression[improvementIndex] then
             if PlayerConfigurations[improvementPlayerID]:GetCivilizationTypeName() ~= 'SLTH_CIVILIZATION_KURIOTATES' then
                 pPlot:SetProperty('currently_worked', 0)
                 return
             end
         end
         local iImprovementWorkedState =  pPlot:GetProperty('currently_worked') or 0
         print( 'tile worked status was now: ' .. tostring(iImprovementWorkedState or "nil") )
         print( 'tile worked status is now: ' .. tostring(isWorked or "nil") )
         if isWorked and iImprovementWorkedState == 0 then
             pPlot:SetProperty('currently_worked', 1)
         elseif iImprovementWorkedState > 0 and not isWorked then
             pPlot:SetProperty('currently_worked', 0)
         end
     end
end

local tBarbClanUnitMapper = {
    [GameInfo.Units['SLTH_UNIT_ARCHER_SCORPION_CLAN'].Index] = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_OPEN'].Index,
    [GameInfo.Units['SLTH_UNIT_SKELETON'].Index] = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_HILLS'].Index,
    [GameInfo.Units['SLTH_UNIT_LIZARDMAN'].Index] = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_FOREST'].Index,
    [GameInfo.Units['SLTH_UNIT_LION'].Index] = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_OPEN'].Index,
    [GameInfo.Units['SLTH_UNIT_BEAR'].Index] = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_CHARIOT'].Index
}
local MANA_INDEX = GameInfo.Resources['RESOURCE_MANA'].Index
function InitCottage(x, y, improvementIndex, playerID)
    local iImprovementUpgradeIndex = tImprovementsProgression[improvementIndex]
    if iImprovementUpgradeIndex then
        local pPlayer = Players[playerID]
        local tImprovingImprovements = pPlayer:GetProperty('improvements_to_increment') or  {}
        if iImprovementUpgradeIndex == GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index then    -- enclave exception
            local civ = PlayerConfigurations[playerID]:GetCivilizationTypeName()
            if civ ~= 'SLTH_CIVILIZATION_KURIOTATES' then
                print('removing from list of incrementers')
                tImprovingImprovements[tostring(x) .. '_' .. tostring(y)] = nil
                pPlayer:SetProperty('improvements_to_increment', tImprovingImprovements)
                return
            end
        end
        local pPlot = Map.GetPlot(x, y)
        pPlot:SetProperty('worked_turns', 0)
        local iIsWorked = pPlot:GetWorkerCount()
        print('Is tile worked: '.. tostring(iIsWorked or "nil"))
        if iIsWorked > 0 then
            pPlot:SetProperty('currently_worked', 1)
        else
            pPlot:SetProperty('currently_worked', 0)
        end
        tImprovingImprovements[tostring(x) .. '_' .. tostring(y)] = {['x']=x, ['y']=y}
        pPlayer:SetProperty('improvements_to_increment', tImprovingImprovements)
    end
    local pPlot = Map.GetPlot(x,y);
    local resourceIndex = pPlot:GetResourceType()
    --print('Resource Index: ' .. tostring(resourceIndex))
    --print('Mana Resource Index: ' .. tostring(MANA_INDEX))
	if resourceIndex == MANA_INDEX then
        local iResourceToChangeTo = tManaNodeMapper[improvementIndex]
        if iResourceToChangeTo then
            print('changing resource to ' .. tostring(iResourceToChangeTo))
            ResourceBuilder.SetResourceType(pPlot, iResourceToChangeTo, 1);         -- error with getting raw mana, remove improvement and place again>
            -- ImprovementBuilder.SetImprovementType(pPlot, improvementIndex, playerId)
        end
    end
    if improvementIndex then                        -- also check its a barb camp? or has it not spawned yet
        local tUnits = Map.GetUnitsAt(pPlot)
        for pUnit in tUnits:Units() do
            local iUnitIndex = pUnit:GetType()
            local iClanIndex = tBarbClanUnitMapper[iUnitIndex]
            if iClanIndex then
                pPlot:SetProperty('barbclantype', iClanIndex)
            end
        end
    end

end

function IncrementCottages(playerId)
    local pPlayer = Players[playerId]
    local tImprovingImprovements = pPlayer:GetProperty('improvements_to_increment')     -- could we instead use pPlayer:GetImprovements:GetImprovementPlots()?
    if not tImprovingImprovements then return end
    for idx, plot_tuple in pairs(tImprovingImprovements) do
        print(idx)
        local iX, iY = plot_tuple['x'], plot_tuple['y']
        local pPlot = Map.GetPlot(iX, iY)
        local bIsWorked = pPlot:GetProperty('currently_worked')
        local bIsImprovementPillaged = pPlot:IsImprovementPillaged()
        if bIsWorked > 0 and not bIsImprovementPillaged then
            local iWorkedTurns = pPlot:GetProperty('worked_turns')
            if iWorkedTurns > 2 then
                local iImprovementIndex = pPlot:GetImprovementType()
                print( 'tile will upgrade to: ' .. tostring(iImprovementIndex or "nil") )
                local iImprovementUpgradedIndex = tImprovementsProgression[iImprovementIndex]
                if iImprovementUpgradedIndex then
                    ImprovementBuilder.SetImprovementType(pPlot, iImprovementUpgradedIndex, playerId)
                end
            else
                pPlot:SetProperty('worked_turns', iWorkedTurns+1)
                print( 'tile upgrade turns: ' .. tostring(1 - iWorkedTurns or "nil") )
            end
        end
    end
end

function EventCollapse(x, y)
    print('doing collapse')
    local pPlot = Map.GetPlot(x, y)
    local tUnits = Map.GetUnitsAt(pPlot)
    for pUnit in tUnits:Units() do
        print('remove health')
        pUnit:ChangeDamage(20)
        if pUnit:GetDamage() < 1 then           -- is it at 0 or at 100?
            UnitManager.Kill(pUnit)
        end
    end
end
local TRIBE_CLAN_SCORPION = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_OPEN'].Index
local TRIBE_CLAN_SKELETON = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_HILLS'].Index
local TRIBE_CLAN_LIZARDMEN = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_FOREST'].Index
local TRIBE_CLAN_BEAR = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_OPEN'].Index
local TRIBE_CLAN_LION = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_CHARIOT'].Index
-- local TRIBE_CLAN_NAT_WON = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_CHARIOT'].Index
local tTribeDeck = {[TRIBE_CLAN_SCORPION] = {[1]=EventCollapse}, [TRIBE_CLAN_SKELETON] = {[1]=EventCollapse},
              [TRIBE_CLAN_LIZARDMEN] = {[1]=EventCollapse}}

function RemovedBarbCamp(x, y, owningPlayerID)
    local pPlot = Map.GetPlot(x, y)
    local owner = pPlot:GetOwner()
    print('destroying')
    if owningPlayerID == 63 or owner == -1 then
        local feature = pPlot:GetFeatureType()
        local tribeIndex = pPlot:GetProperty('barbclantype') or 1
        if tBarbNW[feature] then
            local iPlotID = pPlot:GetIndex()
            Game.GetBarbarianManager():CreateTribeOfType(tribeIndex, iPlotID)
        end
        -- draw from deck of events
        print(tribeIndex)
        local tTribeEvents = tTribeDeck[tribeIndex]
        if tTribeEvents then
            local lengthTribeEvents = table.count(tTribeEvents)
            local dice_roll = math.random(1, lengthTribeEvents)
            local fEvent = tTribeEvents[dice_roll]
            fEvent(x, y)
        end
        -- do event. Sometimes we reinstantiate barb camp. maybe we can also removal of gold on disperse
    end
end

local tLuonnotar = {
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR'].Index]= {civic=GameInfo.Civics['CIVIC_MYSTICISM'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_ANOINTED'].Index]= {civic=GameInfo.Civics['CIVIC_POLITICAL_PHILOSOPHY'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_BLESSED'].Index]= {civic=GameInfo.Civics['CIVIC_PRIESTHOOD'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_CONSECRATED'].Index]= {civic=GameInfo.Civics['CIVIC_FANATICISM'].Index},
    [GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_DIVINE'].Index]= {civic=GameInfo.Civics['CIVIC_RIGHTEOUSNESS'].Index}}

local iLunnotarBlocker = GameInfo.Buildings['BUILDING_BLOCK_ALTAR'].Index
local iAltarBase = GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR'].Index

local tLuonnotarCivics = {
    [GameInfo.Civics['CIVIC_MYSTICISM'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR'].Index,
    [GameInfo.Civics['CIVIC_POLITICAL_PHILOSOPHY'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_ANOINTED'].Index,
    [GameInfo.Civics['CIVIC_PRIESTHOOD'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_BLESSED'].Index,
    [GameInfo.Civics['CIVIC_FANATICISM'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_CONSECRATED'].Index,
    [GameInfo.Civics['CIVIC_RIGHTEOUSNESS'].Index]= GameInfo.Buildings['SLTH_BUILDING_ALTAR_OF_THE_LUONNOTAR_DIVINE'].Index
}

function BuildingBuilt(playerID, cityID, buildingID, plotID, isOriginalConstruction)
    local tLuonnotarInfo = tLuonnotar[buildingID]
    if tLuonnotarInfo then
        print('altar recognised')
        local pPlot = Map.GetPlotByIndex(plotID)
        local iAltarLevel = pPlot:GetProperty('altar_level')
        if not iAltarLevel then
            pPlot:SetProperty('altar_level', 0)
        end
        local iCivicForNext = tLuonnotarInfo['civic']
        print('civic check')
        if iCivicForNext then
            print('civic check exist')
            -- check if has culture
            local pPlayer = Players[playerID]
            if not pPlayer then return; end
            local pCulture = pPlayer:GetCulture()
            if not pCulture then return; end
            local pCity = CityManager.GetCity(pPlayer, cityID)
            if not pCulture:HasCivic(iCivicForNext) then
                print('player doesnt have civic, blocking Great Prophet activation.')
                pCity:AttachModifierByID('MODIFIER_FREE_SLTH_BUILDING_NO_ALTAR_ALWAYS')
            end
        end
    end
end

-- on base Luonnotar building built, an altar level property is set.

-- the luonnotar index is used to find in a table the dummyprereq building for next tier, and the civic it requires
-- if the player has the civic, a property A is set on the city so that next turn, it grants the building. This is so one GP activation doesnt grant them all
-- otherwise, the city has a modifier attached to spawn the dummy that blocks gp activation on the city. CHANGE TO LUA ACTIVATION

-- to deal with the player getting the civic after constructing the building, we attach an event triggering on the
-- the unlocking civics being completed. It iterates over all cities, finds the city with Altar, and removes the blocker

-- we also increment the plotProperty altar_level on activating the GreatProphet. this plotProp is used as a requirement
-- for the modifiers granting altars.

-- on player turn start, i.e. the next turn, iterate over player cities, and if the city has the property A, use it
-- as a modifierID to attach a Modifier onto the city, granting the next dummyprereq.


-- Great general on Mil Strategy
-- Great Bard on Drama
-- there are others im pretty sure
-- function OnTechnologyGrantFirst()  end
local tCivicsGreatPeople = {[GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index] = 'GREAT_GENERAL',
                      [GameInfo.Civics['CIVIC_DRAMA_POETRY'].Index] = 'GREAT_ARTIST'}

function OnCivicGrantFirst(playerID, civicIndex, isCancelled)
    local pPlayer = Players[playerID]
    local iCurrentLuonnotar = tLuonnotarCivics[civicIndex]
    if iCurrentLuonnotar then
        print('unlocking altar after civic unlock')
        for _, pCity in pPlayer:GetCities():Members() do
            if pCity:GetBuildings():HasBuilding(iCurrentLuonnotar) then
                pCity:GetBuildings():RemoveBuilding(iLunnotarBlocker)           -- dont think i need to add back dummy_prereq
                return
            end
        end
    end
end

local iGreatProphetIndex = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_PROPHET'].Index
function onGreatPersonActivated(unitOwner, unitID, greatPersonClassID, greatPersonIndividualID)
    print('Great person activated!')
    print(greatPersonClassID)
    if greatPersonClassID == iGreatProphetIndex then
        print('Great person recognised as prophet')
        local pPlayerCities = Players[unitOwner]:GetCities()
        for _, pCity in pPlayerCities:Members() do
            if pCity:GetBuildings():HasBuilding(iAltarBase) then
                local pPlot = pCity:GetPlot();
                local iAltarLevel = pPlot:GetProperty('altar_level')
                if iAltarLevel then
                    pPlot:SetProperty('altar_level', iAltarLevel + 1)
                    print('plot prop update GP suceeded')
                end
                return
            end
        end
    end
end

function InitializeClans()
    if not Game.GetProperty('NW_Clans_Set') then
        local iW, iH = Map.GetGridSize()
        for x = 0, iW - 1 do
            for y = 0, iH - 1 do
                local i = y * iW + x;
                local pPlot = Map.GetPlotByIndex(i);
                local feature = pPlot:GetFeatureType()
                if tBarbNW[feature] then
                    print(feature)
                    Game.GetBarbarianManager():CreateTribeOfType(1, i)
                end
            end
        end
        Game.SetProperty('NW_Clans_Set', 1)
    end
    -- iterate over units
    for _, pUnit in Players[63]:GetUnits():Members() do              -- SECTION: do reset castable
        UnitManager.Kill(pUnit);
    end
end

function onStart()
    GameEvents.PlayerTurnStarted.Add(onTurnStartGameplay);

    Events.ImprovementChanged.Add(ImprovementsWorkOrPillageChange)
    Events.ImprovementAddedToMap.Add(InitCottage)
    GameEvents.PlayerTurnStarted.Add(IncrementCottages);

    Events.CivicCompleted.Add(OnCivicGrantFirst)
    -- Events.ResearchCompleted.Add(OnTechnologyGrantFirst)
    Events.ImprovementRemovedFromMap.Add(RemovedBarbCamp)           -- doesnt work
    GameEvents.BuildingConstructed.Add(BuildingBuilt)
    Events.UnitGreatPersonActivated.Add(onGreatPersonActivated)
    InitializeClans()
    print('-----------------Gameplay loaded')
end

local function SetCapitalProperty(iPlayer, tParameters)
    local sPropKey = tParameters.sPropKey;
    local iPropValue = tParameters.iPropValue;
    local pPlayer = Players[iPlayer];
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    local pCapitalPlot = pCapitalCity:GetPlot()
    pCapitalPlot:SetProperty(sPropKey, iPropValue)
end

local function SetPlayerProperty(iPlayer, tParameters)
    local sPropKey = tParameters.sPropKey;
    local iPropValue = tParameters.iPropValue;
    local pPlayer = Players[iPlayer];
    pPlayer:SetProperty(sPropKey, iPropValue)
    print('set '.. sPropKey .. 'to ' .. iPropValue)
end

local function OnSummon(iPlayer, tParameters)
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local iUnitToSummon = GameInfo.Units[OperationInfo.SimpleText].Index
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local pUnitExp = pUnit:GetExperience()
    local pUnitAbility = pUnit:GetAbility()
    local tNewUnits = BaseSummon(pUnit, iPlayer, iUnitToSummon)
    for iUnitID, pNewUnit in pairs(tNewUnits) do
        print(OperationInfo.SimpleText)
        pUnit:SetProperty(OperationInfo.SimpleText, iUnitID)                -- used to link summoner and summoned
        pNewUnit:SetProperty('owner', tParameters.iCastingUnit)             -- used to link summoner and summoned
        if pNewUnit:GetProperty('LifespanRemaining') == 1 then
            if pUnitAbility:HasAbility('SLTH_ABILITY_SUMMONER') then
                pNewUnit:SetProperty('LifespanRemaining', 2)                -- set duration
            else
                pNewUnit:SetProperty('LifespanRemaining', 1)
            end
        end
        InheritSummon(pNewUnit, pUnitExp, pUnitAbility)
    end
    pUnit:SetProperty('HasCast', 1)
end

local tPromoCombat = {
[GameInfo.UnitPromotions['PROMOTION_COMBAT1_ADEPT'].Index] = 1,
[GameInfo.UnitPromotions['PROMOTION_COMBAT2_ADEPT'].Index] = 1,
[GameInfo.UnitPromotions['PROMOTION_COMBAT3_ADEPT'].Index] = 1,
[GameInfo.UnitPromotions['PROMOTION_COMBAT4_ADEPT'].Index] = 1,
[GameInfo.UnitPromotions['PROMOTION_COMBAT5_ADEPT'].Index] = 1,
}

local SUMMONER_PROMOTION_IDX = GameInfo.UnitPromotions['PROMOTION_SUMMONER_ADEPT'].Index

function InheritSummon(pSummonedUnit, pSummonerUnitExp, pSummonerUnitAbility)
    local pSummonUnitAbility = pSummonedUnit:GetAbility()
    if pSummonerUnitAbility:HasAbility('SLTH_ABILITY_SUMMONER') or pSummonerUnitExp:HasPromotion(SUMMONER_PROMOTION_IDX) then
        pSummonUnitAbility:AddAbilityCount('ABILITY_SUMMONER_INHERITED_STRENGTH')
        -- also work out a way to add an additional turn of duration
        local lifespan = pSummonedUnit:GetProperty('LIFESPAN') or 1
        pSummonedUnit:SetProperty('LIFESPAN', lifespan + 1)
    end

    for iPromoCombatIndex, _ in pairs(tPromoCombat) do
        if pSummonerUnitExp:HasPromotion(iPromoCombatIndex) then
            pSummonUnitAbility:AddAbilityCount('ABILITY_SUMMONER_INHERITED_STRENGTH')
        end
    end
end

local function OnSummonPermanent(iPlayer, tParameters)
    print('in summon permanent')
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local iUnitToSummon = GameInfo.Units[OperationInfo.SimpleText].Index
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iCheckExistingUnit = pUnit:GetProperty(OperationInfo.SimpleText)
    local pUnitExp = pUnit:GetExperience()
    local pUnitAbility = pUnit:GetAbility()
    print(iCheckExistingUnit)
    if iCheckExistingUnit then
        local pUnitPrecursor = UnitManager.GetUnit(iPlayer, iCheckExistingUnit);
        if pUnitPrecursor then return end
    end
    local tNewUnits = BaseSummon(pUnit, iPlayer, iUnitToSummon)
    for iUnitID, pNewUnit in pairs(tNewUnits) do
        print('set inherited abilities here')
        print(OperationInfo.SimpleText)
        pUnit:SetProperty(OperationInfo.SimpleText, iUnitID)                -- used to link summoner and summoned. todo breaks on twinspell
        pNewUnit:SetProperty('owner', tParameters.iCastingUnit)             -- used to link summoner and summoned
        InheritSummon(pNewUnit, pUnitExp, pUnitAbility)
    end
    pUnit:SetProperty('HasCast', 1)
end

local function OnGrantBuffSelf(iPlayer, tParameters)
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local pAbilityUnit = pUnit:GetAbility()
    if not pAbilityUnit:HasAbility(OperationInfo.SimpleText) then
        pAbilityUnit:AddAbilityCount(OperationInfo.SimpleText)
        if transientBuffKeys[OperationInfo.SimpleText] then
            local sPropbuff_propkey = OperationInfo.SimpleText .. ('_UNITS')
            local tSpecificBuffState = Game:GetProperty(sPropbuff_propkey) or {}
            local tUnitInfos = {iPlayer=iPlayer, iUnit=tParameters.iCastingUnit, iCasterPlayer=iPlayer}
            table.insert(tSpecificBuffState, tUnitInfos)
            Game:SetProperty(sPropbuff_propkey, tSpecificBuffState)
        end
    end
    pUnit:SetProperty('HasCast', 1)
end

local function OnGrantBuffAoe(iPlayer, tParameters)
    local pAbilityUnit
    local tSpecificBuffState
    local sPropbuff_propkey
    local bBuffPropKeyChange
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
    if transientBuffKeys[OperationInfo.SimpleText] then
        sPropbuff_propkey = OperationInfo.SimpleText .. ('_UNITS')
        tSpecificBuffState = Game:GetProperty(sPropbuff_propkey) or {}
    end
	for _, plot in ipairs(tNeighborPlots) do
		for _, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if pNearUnit then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
                    pAbilityUnit = pNearUnit:GetAbility()
                    if not pAbilityUnit:HasAbility(OperationInfo.SimpleText) then
                        pAbilityUnit:AddAbilityCount(OperationInfo.SimpleText)
                        if transientBuffKeys[OperationInfo.SimpleText] then
                            local iUnit = pNearUnit:GetID()
                            local tUnitInfos = {iPlayer=iPlayer, iUnit=iUnit, iCasterPlayer=iPlayer}
                            table.insert(tSpecificBuffState, tUnitInfos)
                            bBuffPropKeyChange = true
                        end
                    end
				end
			end
		end
	end
    pUnit:SetProperty('HasCast', 1)
    if bBuffPropKeyChange then
        Game:SetProperty(sPropbuff_propkey, tSpecificBuffState)
    end
end

local function OnGrantDebuffAoe(iPlayer, tParameters)
    local pAbilityUnit
    local tSpecificBuffState
    local sPropbuff_propkey
    local bBuffPropKeyChange
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	for _, plot in ipairs(tNeighborPlots) do
		for _, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if pNearUnit then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer ~= iPlayer) then
                    pAbilityUnit = pNearUnit:GetAbility()
                    if not pAbilityUnit:HasAbility(OperationInfo.SimpleText) then
                        pAbilityUnit:AddAbilityCount(OperationInfo.SimpleText)
                        if transientBuffKeys[OperationInfo.SimpleText] then
                            local iUnit = pNearUnit:GetID()
                            local tUnitInfos = {iPlayer=iOwnerPlayer, iUnit=iUnit, iCasterPlayer=iPlayer}
                            table.insert(tSpecificBuffState, tUnitInfos)
                            bBuffPropKeyChange = true
                        end
                    end
				end
			end
		end
	end
    pUnit:SetProperty('HasCast', 1)
    if bBuffPropKeyChange then
        Game:SetProperty(sPropbuff_propkey, tSpecificBuffState)
    end
end

local function OnSpellChangeTerrain(iPlayer, tParameters)
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local pPlot = Map.GetPlot(iX, iY)
    local iCurrentTerrain = pPlot:GetTerrainType()
    local TerrainTransformInfo = GameInfo.TerrainTransforms[iCurrentTerrain]
    local sSpellType = OperationInfo.SimpleText
    local attempt = TerrainTransformInfo[sSpellType]
    print(attempt)
    local iNewTerrain = TerrainTransformInfo.sSpellType
    if iNewTerrain then
        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
    end
    pUnit:SetProperty('HasCast', 1)
end

local function OnSpellAoeDamage(iPlayer, tParameters)
    local pAbilityUnit
    local tagInfo
    local iNewTerrain
    local sUnitOperationType = tParameters.UnitOperationType;
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
    local iDamage = OperationInfo.SecondAmount
	for _, plot in ipairs(tNeighborPlots) do
		for _, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit) then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer ~= iPlayer) then
					if Players[iPlayer]:GetDiplomacy():IsAtWarWith(iOwnerPlayer) then
                        tagInfo = true
                        local UnitTypeInfo = GameInfo.Units[pNearUnit:GetType()]
                        if OperationInfo.SimpleText == 'IS_UNDEAD' then
                            tagInfo = GameInfo.TypeTags[{UnitTypeInfo.UnitType, 'IS_UNDEAD'}]
                        end
						if (UnitTypeInfo.Combat ~= 0 and UnitTypeInfo.Domain ~= "DOMAIN_AIR") and tagInfo then
							pNearUnit:ChangeDamage(iDamage);
							if pNearUnit:GetDamage() >= 100 then
								UnitManager.Kill(pNearUnit, false);
                            else
                                if OperationInfo.SimpleText == 'WITHERED' then
                                    pAbilityUnit = pNearUnit:GetAbility()
                                    if not pAbilityUnit:HasAbility(OperationInfo.SimpleText) then
                                        pAbilityUnit:AddAbilityCount(OperationInfo.SimpleText)
                                    end
                                end
							end
                            if OperationInfo.SimpleText == 'TERRAIN_SNOW' then
                                local pPlot = Map.GetPlot(iX, iY)
                                local iCurrentTerrain = pPlot:GetTerrainType()
                                if pPlot:IsHills() then
                                    iNewTerrain = GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index
                                    if  iCurrentTerrain ~= iNewTerrain then
                                        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                                    end
                                elseif pPlot:IsMountain() then
                                    iNewTerrain = GameInfo.Terrains['TERRAIN_SNOW_MOUNTAIN'].Index
                                    if iCurrentTerrain ~= iNewTerrain then
                                        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                                    end
                                else
                                    iNewTerrain = GameInfo.Terrains['TERRAIN_SNOW'].Index
                                    if iCurrentTerrain ~= iNewTerrain then
                                        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                                    end
                                end
                            end
						end
					end
				end
			end
		end
	end
    pUnit:SetProperty('HasCast', 1)
end

local function GrantGoldenAge(iPlayer, tParameters)
	local pPlayer = Players[iPlayer]
	local iUniqueGreatPeopleRequirement = pPlayer:GetProperty('GreatPeopleGoldenRequirement') or 1
    local t_iUnits = {}
    t_iUnits[1] = tParameters.iCastingUnit                      -- set to just the owner for now
	for iUnitType, iUnitID in pairs(t_iUnits) do
		local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
		UnitManager.Kill(pUnit);
	end
	for _, pCity in pPlayer:GetCities():Members() do
		local pPlot = pCity:GetPlot();
		print(pPlot)						-- plot exists
        pPlot:SetProperty('InGoldenAge', 1);		-- but =function expected instea of nil?
	end
	pPlayer:SetProperty('GoldenAgeDuration', (pPlayer:GetProperty('GoldenAgeDuration') or 0) + 10)
	pPlayer:SetProperty('GreatPeopleGoldenRequirement', iUniqueGreatPeopleRequirement + 1)
end

local tBuildingGrantModiferMap = {
    ['SLTH_BUILDING_CODE_OF_JUNIL'] = 'SLTH_MODIFIER_GRANT_CODE_OF_JUNIL',
    ['BUILDING_ANGKOR_WAT'] = 'SLTH_MODIFIER_GRANT_DIES_DEI',
    ['SLTH_BUILDING_TABLETS_OF_BAMBUR'] = 'SLTH_MODIFIER_GRANT_TABLETS_OF_BAMBUR',
    ['SLTH_BUILDING_SONG_OF_AUTUMN'] = 'SLTH_MODIFIER_GRANT_SONG_OF_AUTUMN',
    ['SLTH_BUILDING_THE_NECRONOMICON'] = 'SLTH_MODIFIER_GRANT_THE_NECRONOMICON',
    ['SLTH_BUILDING_NOX_NOCTIS'] = 'SLTH_MODIFIER_GRANT_NOX_NOCTIS',
    ['SLTH_BUILDING_STIGMATA_ON_THE_UNBORN'] = 'SLTH_MODIFIER_GRANT_STIGMATA_ON_THE_UNBORN'
}

local function GrantBuildingFunction(iPlayer, tParameters)
    local iUnit = tParameters.iCastingUnit
    local sUnitOperationType =  tParameters.UnitOperationType
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local sModifierGrant = tBuildingGrantModiferMap[OperationInfo.SimpleText]
    if not sModifierGrant then print('building didnt have a modifier grant mapping, returning..'); return; end
    print(sModifierGrant)
	local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
	local pCity = Cities.GetCityInPlot(iX, iY)
	pCity:AttachModifierByID(sModifierGrant);
	UnitManager.Kill(pUnit);
end

local function GrantSuperSpecialist(iPlayer, tParameters)
    local iUnit = tParameters.iCastingUnit
	local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
	local iUnitType = pUnit:GetType();
	local pCity = Cities.GetCityInPlot(iX, iY)
	for _, sModifier in ipairs(tSuperSpecialistModifiers[iUnitType]) do
		pCity:AttachModifierByID(sModifier)									-- maybe do binary magic and plotProp
	end
	for _, sModifier in ipairs(tSuperSpecialistGenericModifiers) do
		pCity:AttachModifierByID(sModifier)
	end
	UnitManager.Kill(pUnit);
end

local function ConsumeAlly(iPlayer, tParameters)
    print('consuming ally')
    local iUnit = tParameters.iCastingUnit
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
    local iConsumeUnitID = tParameters.iTargetID
    local sUnitOperationType =  tParameters.UnitOperationType
    if sUnitOperationType == 'UNITOPERATION_CONSUME_BLOODPET' then
        local pConsumeUnit = UnitManager.GetUnit(iPlayer, iConsumeUnitID);
        local iUnitType = pConsumeUnit:GetType();
        if iUnitType == GameInfo.Units['UNIT_WARRIOR'].Index then
            UnitManager.RestoreMovement(pUnit)
            UnitManager.RestoreUnitAttacks(pUnit)
            UnitManager.Kill(pConsumeUnit);
        end
    elseif sUnitOperationType == 'UNITOPERATION_ABSORB_UNIT' then
        print('placeholder, flesh golem grafts seem painful.')
    else
        print('no behaviour defined for this UnitOp on ConsumeAlly: ' .. sUnitOperationType)
    end
end

local tEquipmentOps = {
['SLTH_EQUIPMENT_ATHAME_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index,
['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index,
['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index,
['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index,
['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index,
['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index,
['SLTH_EQUIPMENT_GELA_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index,
['SLTH_EQUIPMENT_GODSLAYER_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index,
['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index,
['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index,
['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index,
['SLTH_EQUIPMENT_JADE_TORC_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index,
['SLTH_EQUIPMENT_MOKKA_CAULDRON_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_MOKKA_CAULDRON_ABILITY'].Index,
['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index,
['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index,
['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index,
['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index,
['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index,
['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index,
['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index,
['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index,
['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index,
['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index,
['SLTH_EQUIPMENT_WAR_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index,
['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'].Index}

local function UnitCityInteract(iPlayer, tParameters)
    local iUnit = tParameters.iCastingUnit
    local sUnitOperationType =  tParameters.UnitOperationType
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local sOperationAbility = OperationInfo.AbilityPrereq
    if sUnitOperationType == 'UNITOPERATION_LOKI_DISRUPT_CITY' then
        print('Causes unhappiness. Decreases city Culture. Converts citys without culture.')
    elseif sUnitOperationType == 'UNITOPERATION_LOKI_ENTERTAIN_CITY' then
        print('placeholder, grant gold to casting unit and amenity to city casted in for a turn. ideally will stay as long as loki is nearby, its the Inspiration problem')
    elseif sUnitOperationType == 'UNITOPERATION_DROWN_WARRIOR' then
        print('placeholder, kill warrior, replace with Drown. No carry over of state?')
    elseif sUnitOperationType == 'UNITOPERATION_SACRIFICE_ALTAR' then
        print('placeholder, kill unit, grant player science.')
    elseif sUnitOperationType == 'UNITOPERATION_ARENA_FIGHT' then
        print('placeholder, grant transient amenities, either unit experience or unit dies. no idea on calculation chance.')
    elseif sOperationAbility and tEquipmentOps[sOperationAbility] then
        local pUnit = UnitManager.GetUnit(iPlayer, iUnit);
        local iX =  pUnit:GetX()
        local iY =  pUnit:GetY()
        local pCity = Cities.GetCityInPlot(iX, iY)
        pCity:AttachModifierByID(OperationInfo.SimpleText);
        local pUnitAbilityManager = pUnit:GetAbility()
        pUnitAbilityManager:RemoveAbilityCount(tEquipmentOps[sOperationAbility]);
    else
        print('no behaviour defined for this UnitOp on UnitCityInteract: ' .. sUnitOperationType)
    end
end

local function ConvertSelfUnit(iPlayer, tParameters)
    local sUnitOperationType =  tParameters.UnitOperationType
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local iUnitToSummon = GameInfo.Units[OperationInfo.SimpleText].Index
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    BaseSummon(pUnit, iPlayer, iUnitToSummon)
    UnitManager.Kill(pUnit);
end

local tEquipmentUnits = {
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
	[GameInfo.Units['SLTH_EQUIPMENT_SPELL_STAFF'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_TIMOR_MASK'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_TREASURE'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TREASURE_ABILITY'].Index,
	[GameInfo.Units['SLTH_EQUIPMENT_WAR'].Index] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index }

local tEquipmentAbilities = {
	[1] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ATHAME_ABILITY'].Index,
	[2] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_BLACK_MIRROR_ABILITY'].Index,
	[3] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_AKHARIEN_ABILITY'].Index,
	[4] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_CROWN_OF_COMMAND_ABILITY'].Index,
	[5] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_DRAGONS_HORDE_ABILITY'].Index,
	[6] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_EMPTY_BIER_ABILITY'].Index,
	[7] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GELA_ABILITY'].Index,
	[8] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GODSLAYER_ABILITY'].Index,
	[9] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_GOLDEN_HAMMER_ABILITY'].Index,
	[10] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_HEALING_SALVE_ABILITY'].Index,
	[11] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_INFERNAL_GRIMOIRE_ABILITY'].Index,
	[12] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_JADE_TORC_ABILITY'].Index,
	[13] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_NETHER_BLADE_ABILITY'].Index,
	[14] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ORTHUSS_AXE_ABILITY'].Index,
	[15] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_PIECES_OF_BARNAXUS_ABILITY'].Index,
	[16] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_INVISIBILITY_ABILITY'].Index,
	[17] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_POTION_OF_RESTORATION_ABILITY'].Index,
	[18] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_ROD_OF_WINDS_ABILITY'].Index,
	[19] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SCORCHED_STAFF_ABILITY'].Index,
	[20] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_STAFF_OF_SOULS_ABILITY'].Index,
	[21] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SYLIVENS_PERFECT_LYRE_ABILITY'].Index,
	[22] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_TIMOR_MASK_ABILITY'].Index,
	[23] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_WAR_ABILITY'].Index,
	[24] = GameInfo.UnitAbilities['SLTH_EQUIPMENT_SPELL_STAFF_ABILITY'].Index}

local function ConsumeEquipment(iPlayer, tParameters)
	local hasEquipment
	local iEquipmentAbilityToGrant
	local iUnitID = tParameters.iCastingUnit
    local consumeUnitID = tParameters.iTargetID
	local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
	local pUnitAbilityManager = pUnit:GetAbility()
	local pConsumeUnit = UnitManager.GetUnit(iPlayer, consumeUnitID);			-- assumes consume unit is owned by same
	local iConsumeUnitType = pConsumeUnit:GetType()
	local equipAbility = tEquipmentUnits[iConsumeUnitType]
	if equipAbility then
		if not pUnitAbilityManager:HasAbility(equipAbility) then
			pUnit:GetAbility():AddAbilityCount(equipAbility)
			UnitManager.Kill(pConsumeUnit);
		else
			print('not granted as unit already has ability')
		end
	else
		local pConsumeUnitAbilityManager = pConsumeUnit:GetAbility()
		for _, equipAbilityAb in ipairs(tEquipmentAbilities) do
			hasEquipment = pConsumeUnitAbilityManager:HasAbility(equipAbilityAb)
			if hasEquipment then
				iEquipmentAbilityToGrant = equipAbilityAb
				break
			end
		end
		if iEquipmentAbilityToGrant then
			if not pUnitAbilityManager:HasAbility(iEquipmentAbilityToGrant) then
				pUnitAbilityManager:AddAbilityCount(iEquipmentAbilityToGrant)
				print('Added ability to unit')
				pConsumeUnitAbilityManager:RemoveAbilityCount(iEquipmentAbilityToGrant);
				print('removed ability from consumer')
			else
				print('dont get ability as already have it')
			end
		else
			print('ERROR: somehow sent command to consume equipment that wasnt configured or had ')
		end
	end
end

local function SummonClone( iPlayer, tParameters)
    local iUnitID = tParameters.iCastingUnit
	local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local iUnitToSummon = pUnit:GetType()
    local tNewUnits = BaseSummon(pUnit, iPlayer, iUnitToSummon)
    for iUnitSummonID, pNewUnit in pairs(tNewUnits) do
        print('set inherited abilities here')
        pNewUnit:SetProperty('LifespanRemaining', 1)                -- set duration
    end
end

local function BreakStaff( iPlayer, tParameters)
    local iUnitID = tParameters.iCastingUnit
	local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local pUnitAbilityManager = pUnit:GetAbility()
    pUnitAbilityManager:RemoveAbilityCount('SLTH_EQUIPMENT_SPELL_STAFF_ABILITY');
    pUnit:SetProperty('HasCast', 0)
end

local function RefreshCastTakePop( iPlayer, tParameters)
    local iUnitID = tParameters.iCastingUnit
	local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
	local pCity = Cities.GetCityInPlot(iX, iY)
    pCity:ChangePopulation(-1)
    pUnit:SetProperty('HasCast', 0)
end

local function GainExperienceTakePop( iPlayer, tParameters)
    local iUnitID = tParameters.iCastingUnit
	local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
	local pCity = Cities.GetCityInPlot(iX, iY)
    local pUnitExp = pUnit:GetExperience()
    pUnitExp:ChangeExperience(10)
    pCity:ChangePopulation(-1)
end

local function SpreadEsus( iPlayer, tParameters)
    local targetCityID = tParameters.iTargetID
	local pCity = CityManager.GetCity(iPlayer, targetCityID);
    local pCityReligion = pCity:GetReligion()
    local iReligion = GameInfo.Religions["RELIGION_ISLAM"].Index
    pCityReligion:AddReligiousPressure(0, iReligion,300, iPlayer)
end

local function TeleportUnitToSummon( iPlayer, tParameters)
    local sUnitOperationType =  tParameters.UnitOperationType
    local OperationInfo = GameInfo.CustomOperations[sUnitOperationType]
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local iUnitLink = pUnit:GetProperty(OperationInfo.SimpleText)
    local pUnitLink = UnitManager.GetUnit(iPlayer, iUnitLink)
    local iX =  pUnitLink:GetX()
    local iY =  pUnitLink:GetY()
    if pUnitLink then
        UnitManager.PlaceUnit(pUnit, iX, iY)
        UnitManager.Kill(pUnitLink)
    end
end

local function TeleportUnitToCapital( iPlayer, tParameters)
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local pPlayer = Players[iPlayer];
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    if pCapitalCity then
        local iX =  pCapitalCity:GetX()
        local iY =  pCapitalCity:GetY()
        UnitManager.PlaceUnit(pUnit, iX, iY)
    end
end
local function ForcePeace( iPlayer, tParameters)
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    local pPlayer = Players[iPlayer];
    local pDiplo = pPlayer:GetDiplomacy()
    for iOtherPlayer, _ in ipairs(Players) do
        if pDiplo:IsAtWarWith(iOtherPlayer) then
            pDiplo:MakePeaceWith(iOtherPlayer)
        end
    end
    local iArmageddonCount = Game.GetProperty('ARMAGEDDON')
    if iArmageddonCount then
        local iNewArmageddonCount = math.floor(iArmageddonCount / 2)
        Game.SetProperty('ARMAGEDDON', iNewArmageddonCount)
    end
    UnitManager.Kill(pUnit)
end

local function HealSelf( iPlayer, tParameters)
    local pUnit = UnitManager.GetUnit(iPlayer, tParameters.iCastingUnit);
    Game.SetProperty('SIRONA_CAST', 1)                      -- todo setup gating
    local iCurrentHealth = pUnit:GetDamage() * -1
    pUnit:ChangeDamage(iCurrentHealth);
end

local function HealTileUnits( iPlayer, tParameters)
    local iUnitToHealID = tParameters.iTargetID
    local pUnitToHeal = UnitManager.GetUnit(iPlayer, iUnitToHealID);
    local iCurrentHealth = pUnitToHeal:GetDamage() * -1
    pUnitToHeal:ChangeDamage(iCurrentHealth);
end

local function ConvertUnitType( iPlayer, tParameters)
    local iUnitID = tParameters.iUnitID
    local iNewUnitIndex = tParameters.iUpgradeUnitIndex
    local iUpgradeCost = tParameters.iCost
    local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
    local pPlayer = Players[iPlayer]
    pPlayer:GetTreasury():ChangeGoldBalance(-iUpgradeCost)
    local iHealth, iX, iY, tPromos, tAbilities = InheritUnitAttributes(iPlayer, iUnitID)
    local tNewUnits = BaseSummon(pUnit, iPlayer, iNewUnitIndex)
    for _, pNewUnit in pairs(tNewUnits) do
        pNewUnit:SetDamage(iHealth)
        local pUnitExp = pNewUnit:GetExperience()
        local pUnitAbilities = pNewUnit:GetAbility()
        for _, iUnitPromotionIndex in ipairs(tPromos) do
            if not pUnitExp:HasPromotion(iUnitPromotionIndex) then
                pUnitExp:SetPromotion(iUnitPromotionIndex)
            end
        end
        for _, sAbility in ipairs(tAbilities) do
            if not pUnitAbilities:HasAbility(sAbility) then
                pUnitAbilities:AddAbilityCount(sAbility)
            end
        end
    end
    pUnit:SetDamage(0)
    -- do UnitManager delete on UI side
end




local tAllowSphereOne = {
        [GameInfo.Resources['RESOURCE_MANA_AIR'].Index]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_BODY'].Index]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index]        =    GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_LAW'].Index]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_MIND'].Index]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SUN'].Index]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED'].Index,
        [GameInfo.Resources['RESOURCE_MANA_WATER'].Index]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED'].Index
    }
local tAllowSphereTwo = {
        [GameInfo.Resources['RESOURCE_MANA_AIR'].Index]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_BODY'].Index]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index]=    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_LAW'].Index]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_MIND'].Index]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SUN'].Index]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_2'].Index,
        [GameInfo.Resources['RESOURCE_MANA_WATER'].Index]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_2'].Index
    }

local tAllowSphereThree = {
        [GameInfo.Resources['RESOURCE_MANA_AIR'].Index]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_BODY'].Index]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_DEATH'].Index]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_EARTH'].Index]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index]=    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_FIRE'].Index]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_LAW'].Index]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_LIFE'].Index]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_MIND'].Index]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_NATURE'].Index]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_SUN'].Index]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_3'].Index,
        [GameInfo.Resources['RESOURCE_MANA_WATER'].Index]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_3'].Index
    }
local function UpdateResourcePromotion(iPlayer, tParameters)
    local iResource = tParameters.ResourceID
    local pPlayer = Players[iPlayer]
    local iChanOneGrant = tAllowSphereOne[iResource]
    local iChanTwoGrant = tAllowSphereTwo[iResource]
    local iChanThreeGrant = tAllowSphereTwo[iResource]
    for _, unit in pPlayer:GetUnits():Members() do
        local iUnitIndex = unit:GetType();
        local pUnitAbilities = unit:GetAbility()
        local pUnitExp = unit:GetExperience()
        if pUnitAbilities:HasAbility('ABILITY_CHANNELING1') then
            pUnitExp:SetPromotion(iChanOneGrant)
            print('allow tier 1 of type' .. tostring(iChantGrant))
        end
        if pUnitAbilities:HasAbility('ABILITY_CHANNELING2') then
            pUnitExp:SetPromotion(iChanTwoGrant)
            print('allow tier 2 of type' .. tostring(iChanTwoGrant))
        end
        if pUnitAbilities:HasAbility('ABILITY_CHANNELING3') then
            pUnitExp:SetPromotion(iChanThreeGrant)
            print('allow tier 3 of type' .. tostring(iChanThreeGrant))
        end
    -- iterate over player units, grant prereq promo
    end
end
local function OnBespokeSpell(iPlayer, tParameters)
    print('bespoke spell not implemented')
end

GameEvents.SlthSetCapitalProperty.Add(SetCapitalProperty);
GameEvents.SlthSetPlayerProperty.Add(SetPlayerProperty);

GameEvents.SlthSetResourcePromotions.Add(UpdateResourcePromotion);

GameEvents.SlthOnSummon.Add(OnSummon);
GameEvents.SlthOnSummonPerm.Add(OnSummonPermanent);
GameEvents.SlthOnGrantBuffSelf.Add(OnGrantBuffSelf);
GameEvents.SlthOnGrantBuffAoEAlly.Add(OnGrantBuffAoe);
GameEvents.SlthOnGrantAbilityAoeEnemy.Add(OnGrantDebuffAoe);
GameEvents.SlthOnChangeTerrain.Add(OnSpellChangeTerrain);
GameEvents.SlthOnAoeDamage.Add(OnSpellAoeDamage);
GameEvents.SlthOnBespokeSpell.Add(OnBespokeSpell);

GameEvents.SlthOnGrantGoldenAge.Add(GrantGoldenAge);
GameEvents.SlthOnGrantBuilding.Add(GrantBuildingFunction);
GameEvents.SlthOnGrantSuperSpecialist.Add(GrantSuperSpecialist);
GameEvents.SlthOnConsumeAlly.Add(ConsumeAlly);
GameEvents.SlthOnUnitCityInteract.Add(UnitCityInteract);
GameEvents.SlthOnConvertSelf.Add(ConvertSelfUnit);
GameEvents.SlthOnTakeEquipment.Add(ConsumeEquipment);
GameEvents.SlthOnCastMirror.Add(SummonClone)
GameEvents.SlthOnBreakStaff.Add(BreakStaff)
GameEvents.SlthDreamsConsume.Add(RefreshCastTakePop)
GameEvents.SlthVampireConsumePop.Add(GainExperienceTakePop)
GameEvents.SlthOnSpreadEsus.Add(SpreadEsus)
GameEvents.SlthOnTeleportToSummon.Add(TeleportUnitToSummon)
GameEvents.SlthOnTeleportToCapital.Add(TeleportUnitToCapital)
GameEvents.SlthOnForcePeace.Add(ForcePeace)
GameEvents.SlthOnHealSelf.Add(HealSelf)
GameEvents.SlthOnHealTargeted.Add(HealTileUnits)
GameEvents.SlthOnConvertUnitType.Add(ConvertUnitType)



onStart()




