include('WorldSpellSupport')
local FreeXPUnits = { SLTH_UNIT_ADEPT = 1, SLTH_UNIT_IMP = 1, SLTH_UNIT_SHAMAN = 1, SLTH_UNIT_ARCHMAGE = 2, SLTH_UNIT_EATER_OF_DREAMS = 2,
                      SLTH_UNIT_CORLINDALE = 2, SLTH_UNIT_DISCIPLE_OF_ACHERON = 1, SLTH_UNIT_GAELAN = 1.5, SLTH_UNIT_GIBBON = 2,
                      SLTH_UNIT_GOVANNON = 2, SLTH_UNIT_HEMAH = 2, SLTH_UNIT_LICH = 2, SLTH_UNIT_ILLUSIONIST = 1.5, SLTH_UNIT_MAGE = 1.5,
                      SLTH_UNIT_WIZARD = 1.5, SLTH_UNIT_MOBIUS_WITCH = 1.5, SLTH_UNIT_MOKKA = 1.5, SLTH_UNIT_SON_OF_THE_INFERNO = 2}
local iNotifType = NotificationTypes.USER_DEFINED_2;
local iIMP_INDEX = GameInfo.Units['SLTH_UNIT_IMP'].Index
local tArcaneUnits = {
    [GameInfo.Units['SLTH_UNIT_ADEPT'].Index] = true, iIMP_INDEX = true, [GameInfo.Units['SLTH_UNIT_SHAMAN'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_ARCHMAGE'].Index] = true, [GameInfo.Units['SLTH_UNIT_EATER_OF_DREAMS'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_CORLINDALE'].Index] = true, [GameInfo.Units['SLTH_UNIT_DISCIPLE_OF_ACHERON'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_GAELAN'].Index] = true, [GameInfo.Units['SLTH_UNIT_GIBBON'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_GOVANNON'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_HEMAH'].Index] = true, [GameInfo.Units['SLTH_UNIT_LICH'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_ILLUSIONIST'].Index] = true, [GameInfo.Units['SLTH_UNIT_MAGE'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_WIZARD'].Index] = true, [GameInfo.Units['SLTH_UNIT_MOBIUS_WITCH'].Index] = true,
    [GameInfo.Units['SLTH_UNIT_MOKKA'].Index] = true, [GameInfo.Units['SLTH_UNIT_SON_OF_THE_INFERNO'].Index] = true
}
local iCOTTAGE_INDEX = GameInfo.Improvements['IMPROVEMENT_COTTAGE'].Index
local iHAMLET_INDEX = GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index
local iTOWN_INDEX = GameInfo.Improvements['IMPROVEMENT_TOWN'].Index
local iVILLAGE_INDEX = GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index
local iENCLAVE_INDEX = GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index
local iPIRATE_COVE_INDEX = GameInfo.Improvements['IMPROVEMENT_PIRATE_COVE'].Index
local iPIRATE_HARBOR_INDEX = GameInfo.Improvements['IMPROVEMENT_PIRATE_COVE'].Index
local iPIRATE_PORT_INDEX = GameInfo.Improvements['IMPROVEMENT_FEITORIA'].Index

local tImprovementsProgression = {
        [iCOTTAGE_INDEX]        = iHAMLET_INDEX,
        [iHAMLET_INDEX]         = iVILLAGE_INDEX,
        [iVILLAGE_INDEX]        = iTOWN_INDEX,
        [iTOWN_INDEX]           = iENCLAVE_INDEX,
        [iPIRATE_COVE_INDEX]    = iPIRATE_HARBOR_INDEX,
        [iPIRATE_HARBOR_INDEX]  = iPIRATE_PORT_INDEX}
local tImprovementsRegression = {
    [iHAMLET_INDEX]         = iCOTTAGE_INDEX,
    [iVILLAGE_INDEX]        = iHAMLET_INDEX,
    [iTOWN_INDEX]           = iVILLAGE_INDEX,
    [iENCLAVE_INDEX]        = iTOWN_INDEX,
    [iPIRATE_HARBOR_INDEX]  = iPIRATE_COVE_INDEX,
    [iPIRATE_PORT_INDEX]       = iPIRATE_HARBOR_INDEX}
local tImprovementsCivProgression = {
    [iTOWN_INDEX]           = iENCLAVE_INDEX}

local iMANA_AIR_INDEX = GameInfo.Resources['RESOURCE_MANA_AIR'].Index
local iMANA_BODY_INDEX = GameInfo.Resources['RESOURCE_MANA_BODY'].Index
local iMANA_CHAOS_INDEX = GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index
local iMANA_DEATH_INDEX = GameInfo.Resources['RESOURCE_MANA_DEATH'].Index
local iMANA_EARTH_INDEX = GameInfo.Resources['RESOURCE_MANA_EARTH'].Index
local iMANA_ENCHANTMENT_INDEX = GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index
local iMANA_ENTROPY_INDEX = GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index
local iMANA_FIRE_INDEX = GameInfo.Resources['RESOURCE_MANA_FIRE'].Index
local iMANA_LAW_INDEX = GameInfo.Resources['RESOURCE_MANA_LAW'].Index
local iMANA_LIFE_INDEX = GameInfo.Resources['RESOURCE_MANA_LIFE'].Index
local iMANA_METAMAGIC_INDEX = GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index
local iMANA_MIND_INDEX = GameInfo.Resources['RESOURCE_MANA_MIND'].Index
local iMANA_NATURE_INDEX = GameInfo.Resources['RESOURCE_MANA_NATURE'].Index
local iMANA_SHADOW_INDEX = GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index
local iMANA_SPIRIT_INDEX = GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index
local iMANA_SUN_INDEX = GameInfo.Resources['RESOURCE_MANA_SUN'].Index
local iMANA_WATER_INDEX = GameInfo.Resources['RESOURCE_MANA_WATER'].Index


local tManaNodeMapper = {
    [GameInfo.Improvements['IMPROVEMENT_MANA_AIR'].Index]         = iMANA_AIR_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_BODY'].Index]        = iMANA_BODY_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_CHAOS'].Index]       = iMANA_CHAOS_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_DEATH'].Index]       = iMANA_DEATH_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_EARTH'].Index]       = iMANA_EARTH_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_ENCHANTMENT'].Index] = iMANA_ENCHANTMENT_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_ENTROPY'].Index]     = iMANA_ENTROPY_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_FIRE'].Index]        = iMANA_FIRE_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_LAW'].Index]         = iMANA_LAW_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_LIFE'].Index]        = iMANA_LIFE_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_METAMAGIC'].Index]   = iMANA_METAMAGIC_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_MIND'].Index]        = iMANA_MIND_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_NATURE'].Index]      = iMANA_NATURE_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_SHADOW'].Index]      = iMANA_SHADOW_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_SPIRIT'].Index]      = iMANA_SPIRIT_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_SUN'].Index]         = iMANA_SUN_INDEX,
    [GameInfo.Improvements['IMPROVEMENT_MANA_WATER'].Index]       = iMANA_WATER_INDEX
}
local tBarbNW = {
	[GameInfo.Features['FEATURE_UBSUNUR_HOLLOW'].Index] = 1,
	[GameInfo.Features['FEATURE_GOBUSTAN'].Index] = 1,
	[GameInfo.Features['FEATURE_DELICATE_ARCH'].Index] = 1,
	[GameInfo.Features['FEATURE_YOSEMITE'].Index] = 1}

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

local tResourcePropKeys = { 'RESOURCE_MANA_AIR', 'RESOURCE_MANA_BODY', 'RESOURCE_MANA_CHAOS',
    'RESOURCE_MANA_DEATH', 'RESOURCE_MANA_EARTH', 'RESOURCE_MANA_ENCHANTMENT',
    'RESOURCE_MANA_ENTROPY', 'RESOURCE_MANA_FIRE', 'RESOURCE_MANA_LAW', 'RESOURCE_MANA_LIFE',
    'RESOURCE_MANA_METAMAGIC', 'RESOURCE_MANA_MIND', 'RESOURCE_MANA_NATURE',
    'RESOURCE_MANA_SHADOW', 'RESOURCE_MANA_SPIRIT', 'RESOURCE_MANA_SUN', 'RESOURCE_MANA_WATER'
    }

function SlthAppend(tFirst, tSecond)
    local tNewTable = tFirst
    for _, val in ipairs(tSecond) do
        table.insert(tNewTable, val)
    end
    return tNewTable
end

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

local function SimpleSummon(iX, iY, iPlayer, iUnitIndex)
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

local function BaseSummon(pCasterUnit, iPlayer, iUnitIndex)
    local iX =  pCasterUnit:GetX()
    local iY =  pCasterUnit:GetY()
    local tNewUnits = SimpleSummon(iX, iY, iPlayer, iUnitIndex)
    return tNewUnits
end

local iHALL_OF_MIRRORS_INDEX = GameInfo.Buildings['SLTH_BUILDING_HALL_OF_MIRRORS'].Index
local iPLANAR_GATE_INDEX = GameInfo.Buildings['SLTH_BUILDING_PLANAR_GATE'].Index
local tPlanarBuildingUnitMap = {    [GameInfo.Buildings['SLTH_BUILDING_PUBLIC_BATHS'].Index] = GameInfo.Units['SLTH_UNIT_SUCCUBUS'].Index,
                                    [GameInfo.Buildings['SLTH_BUILDING_CARNIVAL'].Index] = GameInfo.Units['SLTH_UNIT_CHAOS_MARAUDER'].Index,
                                    [GameInfo.Buildings['BUILDING_STUPA'].Index] = GameInfo.Units['SLTH_UNIT_TAR_DEMON'].Index,
                                    [GameInfo.Buildings['SLTH_BUILDING_GAMBLING_HOUSE'].Index] = GameInfo.Units['SLTH_UNIT_REVELERS'].Index,
                                    [GameInfo.Buildings['BUILDING_MAGE_GUILD'].Index] = GameInfo.Units['SLTH_UNIT_MOBIUS_WITCH'].Index
}
local iGOVERNORS_MANOR_INDEX = GameInfo.Buildings['SLTH_BUILDING_GOVERNORS_MANOR'].Index
local function SpawnAcheron()
    -- find city states
    -- choose first as reduces randomness, and location is already random. Might screw over ppl.
    local tMinorCivs = PlayerManager.GetAliveMinors()
    local pCity
    local pChosenCityState
    for _, pPlayer in ipairs(tMinorCivs) do
        if not pCity then
            pCity = pPlayer:GetCities():GetCapitalCity()
            pChosenCityState = pPlayer
        end
    end
    if pCity then
        local pPlot = pCity:GetPlot()
        local iX =  pPlot:GetX()
        local iY =  pPlot:GetY()
        local playerUnits = pChosenCityState:GetUnits();
        playerUnits:Create(GameInfo.Units['SLTH_UNIT_ACHERON'].Index, iX, iY);      -- spawn acheron for that city state
        pCity:AttachModifierByID('MODIFIER_GRANT_ACHERONS_LAIR')      -- then add a building that allows the disciples of the inferno
        pCity:AttachModifierByID('MODIFIER_GRANT_THE_DRAGONS_HORDE_BUILDING')
    else
        print('no barbarian cities for acheron to inhabit. Dragon spawn not used :(')
    end
end

local function SpawnOrthus()
    local tEligiblePlots = ViableWildernessPlots()
    local iNumEligiblePlots = table.Count(tEligiblePlots)
    if iNumEligiblePlots > 0 then
        local iRandomEligiblePlotsPosition = Game.GetRandNum((iNumEligiblePlots + 1) - 1, 'RNG_barb_placement') + 1
        local spawnPlot = tEligiblePlots[iRandomEligiblePlotsPosition]
        UnitManager.InitUnitValidAdjacentHex(63, GameInfo.Units['SLTH_UNIT_ORTHUS'].Index, spawnPlot:GetX(), spawnPlot:GetY());
    end
end

function onTurnStartGameplay(playerId)
    local pPlayer = Players[playerId];
    local iArcaneLacuna = Game:GetProperty('ARCANE_LACUNA_COUNTDOWN') or 0
    local bAllowSpells
    if iArcaneLacuna > 0 then
        local iArcaneLacunaCaster = Game:GetProperty('ARCANE_LACUNA_CASTER') or -1
        if playerId == 63 then          -- barbs are always existing, so once per global turn
            Game:SetProperty('ARCANE_LACUNA_COUNTDOWN', iArcaneLacuna - 1)
        elseif playerId == iArcaneLacunaCaster then
            bAllowSpells = true
        end
    else
        bAllowSpells = true
    end
    -- SECTION: count down Timer effects like Stasis and Arcane Lacuna worldspell
    local iStasisDelay = Game:GetProperty('STASIS_COUNTDOWN')
    if iStasisDelay then
        if iStasisDelay > 1 then
            Game:SetProperty('STASIS_COUNTDOWN', iStasisDelay - 1)
        elseif iStasisDelay == 1 then
            Game:SetProperty('STASIS_COUNTDOWN', iStasisDelay - 1)              -- turn off stasis
            for iPlayerID, pStasisPlayer in ipairs(Players) do
                local pCapitalCity = pStasisPlayer:GetCities():GetCapitalCity()
                if pCapitalCity then
                    local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
                    local iCurrentStasis = pCapitalPlot:GetProperty('InStasis')
                    if iCurrentStasis then
                        pCapitalPlot:SetProperty('InStasis', 0)
                    end
                end
            end
        end
    end
    for _, unit in pPlayer:GetUnits():Members() do              -- SECTION: do reset castable
        if unit:GetProperty('HasCast') and bAllowSpells then
            print('setting HasCast to 0')
            unit:SetProperty('HasCast', 0)
        end
        local iUnitIndex = unit:GetType();                      -- SECTION: passive experience gain
        local sUnitType = GameInfo.Units[iUnitIndex].UnitType
        if sUnitType then                       -- remove once table correct
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
    -- BUFF_REGENERATION -- when full
    -- local afterCombat = {BUFF_BLESSED=true, BUFF_ENRAGED=true, BUFF_STONESKIN=true}

    -- SECTION: BarbarianSpawnEvents
    if playerId == 63 then              -- barbarian proxy
        local iCurrentTurn = Game.GetCurrentGameTurn()
        if iCurrentTurn == 100 then
            SpawnAcheron()
        else
            SpawnOrthus()
        end
    end

    -- SECTION: Cottage/Pirate Port improvement upgrading.
    local tImprovingImprovements = pPlayer:GetProperty('improvements_to_increment')
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

    -- SECTION: Hall of Mirror. Currently restricted to Balseraphs
    if PlayerConfigurations[playerId]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_BALSERAPHS' then
        for _, pCity in pPlayer:GetCities():Members() do
            if pCity:GetBuildings():HasBuilding(iHALL_OF_MIRRORS_INDEX) then
                local iX =  pCity:GetX()
                local iY =  pCity:GetY()
                local pUnitClone
                local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
                for _, plot in ipairs(tNeighborPlots) do
                    if not pUnitClone then
                        for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
                            if (pNearUnit) and (not pUnitClone) then
                                local iOwnerPlayer = pNearUnit:GetOwner();
                                if (iOwnerPlayer ~= playerId) then
                                    if Players[playerId]:GetDiplomacy():IsAtWarWith(iOwnerPlayer) then
                                        pUnitClone = pNearUnit
                                    end
                                end
                            end
                        end
                    end
                end
                if pUnitClone then
                    local iUnitIndex = pUnitClone:GetType()
                    local tNewUnits = SimpleSummon(iX, iY, playerId, iUnitIndex)
                    for iUnitSummonID, pNewUnit in pairs(tNewUnits) do
                        pNewUnit:SetProperty('LifespanRemaining', 1)                -- set duration
                    end
                end
            end
        end
    end
    -- SECTION: Planar Gate spawning
    if PlayerConfigurations[playerId]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_SHEAIM' then
        local iArmageddonCount =  Game.GetProperty('ARMAGEDDON') or 0
        local iChance = 6
        local iNumUnitsSpawnable = 1
        if iArmageddonCount > 50 then
            iChance = iChance + 3
            iNumUnitsSpawnable = iNumUnitsSpawnable + 1
            if iArmageddonCount > 74 then
                iChance = iChance + 3
                iNumUnitsSpawnable = iNumUnitsSpawnable + 1
                if iArmageddonCount > 99 then
                    iChance = iChance + 3
                    iNumUnitsSpawnable = iNumUnitsSpawnable + 1
                end
            end
        end
        for _, pCity in pPlayer:GetCities():Members() do
            local pBuildings = pCity:GetBuildings()
            if pBuildings:HasBuilding(iPLANAR_GATE_INDEX) then
                -- do dice roll to see if succeeds
                local iRoll = math.random(100)
                if iRoll <= iChance then
                    local tUnitsPossible = {}
                    for iBuildingIndex, iUnitIndex in pairs(tPlanarBuildingUnitMap) do
                        if pBuildings:HasBuilding(iBuildingIndex) then
                            table.insert(tUnitsPossible, iUnitIndex)
                        end
                    end
                    if #tUnitsPossible > 0 then
                        for _=1, iNumUnitsSpawnable do
                            local iUnitSelectedIndex = tUnitsPossible[math.random(#tUnitsPossible)]
                            local iX =  pCity:GetX()
                            local iY =  pCity:GetY()
                            SimpleSummon(iX, iY, playerId, iUnitSelectedIndex)
                        end
                    end
                end
            end
        end
    end
    -- SECTION: Governor Manor Amenity PlotProperty BinaryMagic state management
    if PlayerConfigurations[playerId]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_CALABIM' then
        for _, pCity in pPlayer:GetCities():Members() do
            if pCity:GetBuildings():HasBuilding(iGOVERNORS_MANOR_INDEX) then
                -- local iNeededAmenities = pCity:GetGrowth():GetAmenitiesNeeded()                  -- ui only function :(
                local iNeededAmenities = math.floor(pCity:GetPopulation() / 2)
                local pPlot =  pCity:GetPlot()
                local tPlotPropertyChanges = tBinaryMap[tostring(iNeededAmenities)]
                for idx, bin_val in pairs(tPlotPropertyChanges) do
                    pPlot:SetProperty('CITY_AMENITIES_REQUIRED_'.. idx, bin_val)
                end
            end
        end
    end
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

local TRIBE_CLAN_SCORPION = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_OPEN'].Index
local TRIBE_CLAN_SKELETON = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_HILLS'].Index
local TRIBE_CLAN_LIZARDMEN = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_FOREST'].Index
local TRIBE_CLAN_BEAR = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_OPEN'].Index
local TRIBE_CLAN_LION = GameInfo.BarbarianTribes['TRIBE_CLAN_CAVALRY_CHARIOT'].Index

local tBarbClanUnitMapper = {
    [GameInfo.Units['SLTH_UNIT_ARCHER_SCORPION_CLAN'].Index] = TRIBE_CLAN_SCORPION,
    [GameInfo.Units['SLTH_UNIT_SKELETON'].Index] = TRIBE_CLAN_SKELETON,
    [GameInfo.Units['SLTH_UNIT_LIZARDMAN'].Index] = TRIBE_CLAN_LIZARDMEN,
    [GameInfo.Units['SLTH_UNIT_LION'].Index] = TRIBE_CLAN_BEAR,
    [GameInfo.Units['SLTH_UNIT_BEAR'].Index] = TRIBE_CLAN_LION
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

--------------- Barbarian Lair Events -----------------------

function getValidDisplacementPlot(pUnit, iX, iY)
    local chosenPlot
    local chosenPlotWater
    for dx = -1, 1 - 1, 1 do
		for dy = -1, 1 - 1, 1 do
            if not chosenPlot then
                local otherPlot = Map.GetPlotXYWithRangeCheck(iX, iY, dx, dy, 1);
                if otherPlot then
                    local iPlotID = otherPlot:GetIndex()
                    local tPlots = UnitManager.GetMoveToPath( pUnit, iPlotID )
                    print(tPlots)
                    if (table.count(tPlots) > 1) then            -- broken
                        if otherPlot:IsWater() then
                            chosenPlotWater = otherPlot
                        else
                            chosenPlot = otherPlot
                        end
                    end
                end
            end
		end
	end
    if chosenPlot then
        return chosenPlot
    else
        if chosenPlotWater then
            return chosenPlotWater
        else
            return -1
        end
    end
end

function DisplaceUnits(pPlot, pUnit, iX, iY)
    local chosenPlot = getValidDisplacementPlot(pUnit, iX, iY)
    if chosenPlot == -1 then
        print("ERROR, PANIC! no adjacent tile suitable to place units. Not spawning barbarians as safety measure.")
        return nil
    end
    local iNewX = chosenPlot:GetX()
    local iNewY = chosenPlot:GetY()
    local tUnitsInPlot = Units.GetUnitsInPlot(pPlot)
    for _, pTileUnit in ipairs(tUnitsInPlot) do
        UnitManager.PlaceUnit(pTileUnit, iNewX, iNewY)              -- displace to new tiles
    end
    return true
end

local iUNIT_AZER = GameInfo.Units['SLTH_UNIT_AZER'].Index
local iUNIT_AIRELEM = GameInfo.Units['SLTH_UNIT_AIR_ELEMENTAL'].Index
local iUNIT_WATER_ELEM = GameInfo.Units['SLTH_UNIT_WATER_ELEMENTAL'].Index
local iUNIT_KRAKEN = GameInfo.Units['SLTH_UNIT_KRAKEN'].Index
local iUNIT_SEA_SERPENT = GameInfo.Units['SLTH_UNIT_SEA_SERPENT'].Index
local iUNIT_STYGIAN_GUARD = GameInfo.Units['SLTH_UNIT_STYGIAN_GUARD'].Index
local iUNIT_PIRATE = GameInfo.Units['SLTH_UNIT_PIRATE'].Index
local iUNIT_GRIFFON = GameInfo.Units['SLTH_UNIT_GRIFFON'].Index
local iUNIT_DROWN = GameInfo.Units['SLTH_UNIT_DROWN'].Index

local iUNIT_ASSASSIN = GameInfo.Units['SLTH_UNIT_ASSASSIN'].Index
local iUNIT_OGRE = GameInfo.Units['SLTH_UNIT_OGRE'].Index
local iUNIT_GIANT_SPIDER = GameInfo.Units['SLTH_UNIT_GIANT_SPIDER'].Index
local iUNIT_HILL_GIANT = GameInfo.Units['SLTH_UNIT_HILL_GIANT'].Index
local iUNIT_SPECTRE = GameInfo.Units['SLTH_UNIT_SPECTRE'].Index
local iUNIT_SCORPION = GameInfo.Units['SLTH_UNIT_SCORPION'].Index
local iUNIT_AXEMAN = GameInfo.Units['SLTH_UNIT_SWORDSMAN'].Index
local iUNIT_WOLF = GameInfo.Units['SLTH_UNIT_WOLF'].Index
local iUNIT_WOLF_RIDER = GameInfo.Units['SLTH_UNIT_WOLF_RIDER'].Index
local iUNIT_CHAOS_MARAUDER = GameInfo.Units['SLTH_UNIT_CHAOS_MARAUDER'].Index
local iUNIT_MISTFORM = GameInfo.Units['SLTH_UNIT_MISTFORM'].Index
local iUNIT_LION = GameInfo.Units['SLTH_UNIT_LION'].Index
local iUNIT_TIGER = GameInfo.Units['SLTH_UNIT_TIGER'].Index
local iUNIT_BABY_SPIDER = GameInfo.Units['SLTH_UNIT_BABY_SPIDER'].Index
local iUNIT_FAWN = GameInfo.Units['SLTH_UNIT_FAWN'].Index
local iTREANT_INDEX = GameInfo.Units['SLTH_UNIT_TREANT'].Index
local tBigBadWaterLeader = { iUNIT_AZER, iUNIT_SEA_SERPENT, iUNIT_STYGIAN_GUARD, iUNIT_PIRATE}
local tBigBadFailedGraceWaterLeader = { iUNIT_AZER,       iUNIT_SEA_SERPENT, iUNIT_STYGIAN_GUARD, iUNIT_PIRATE,
                                        iUNIT_WATER_ELEM, iUNIT_KRAKEN,      iUNIT_AIRELEM }

local tBigBadWaterHench = { iUNIT_AZER, iUNIT_GRIFFON }
local tBigBadFailedGraceWaterHench = { iUNIT_AZER, iUNIT_GRIFFON, iUNIT_DROWN }

local tBigBadLeader = {iUNIT_ASSASSIN, iUNIT_OGRE, iUNIT_GIANT_SPIDER, iUNIT_HILL_GIANT, iUNIT_SPECTRE, iUNIT_SCORPION}

local tBigBadHench = {iUNIT_AZER, iUNIT_GRIFFON, iUNIT_AXEMAN, iUNIT_WOLF, iUNIT_CHAOS_MARAUDER, iUNIT_WOLF_RIDER,
                      iUNIT_MISTFORM, iUNIT_LION, iUNIT_TIGER, iUNIT_BABY_SPIDER, iUNIT_FAWN, iUNIT_SCORPION
}

local tBigBadFailedGraceLeader = {iUNIT_ASSASSIN, iUNIT_OGRE, iUNIT_GIANT_SPIDER, iUNIT_HILL_GIANT, iUNIT_SPECTRE,
                                  iUNIT_SCORPION, iUNIT_AIRELEM, GameInfo.Units['SLTH_UNIT_EARTH_ELEMENTAL'].Index,
                                  GameInfo.Units['SLTH_UNIT_FIRE_ELEMENTAL'].Index,
                                  GameInfo.Units['SLTH_UNIT_GARGOYLE'].Index, GameInfo.Units['SLTH_UNIT_VAMPIRE'].Index,
                                  GameInfo.Units['SLTH_UNIT_MYCONID'].Index, GameInfo.Units['SLTH_UNIT_EIDOLON'].Index,
                                  GameInfo.Units['SLTH_UNIT_LICH'].Index, GameInfo.Units['SLTH_UNIT_OGRE_WARCHIEF'].Index,
                                  GameInfo.Units['SLTH_UNIT_SATYR'].Index, GameInfo.Units['SLTH_UNIT_WEREWOLF'].Index }

local tBigBadFailedGraceHench = {iUNIT_AZER, iUNIT_GRIFFON, iUNIT_AXEMAN, iUNIT_WOLF, iUNIT_CHAOS_MARAUDER, iUNIT_WOLF_RIDER,
                                 iUNIT_MISTFORM, iUNIT_LION, iUNIT_TIGER, iUNIT_BABY_SPIDER, iUNIT_FAWN, iUNIT_SCORPION,
                                 GameInfo.Units['SLTH_UNIT_OGRE'].Index
}

local tSnowHenchMan = { GameInfo.Units['SLTH_UNIT_FROSTLING_ARCHER'].Index,
                        GameInfo.Units['SLTH_UNIT_FROSTLING_WOLF_RIDER'].Index,
                        GameInfo.Units['SLTH_UNIT_POLAR_BEAR'].Index }

local tArmaLeaders = { GameInfo.Units['SLTH_UNIT_PIT_BEAST'].Index, GameInfo.Units['SLTH_UNIT_DEATH_KNIGHT'].Index,
                           GameInfo.Units['SLTH_UNIT_BALOR'].Index}
local tArmaHench = { iIMP_INDEX, GameInfo.Units['SLTH_UNIT_HELLHOUND'].Index }
local tBarbClanExtraUnits = {
    [TRIBE_CLAN_SKELETON]= {'SLTH_UNIT_SKELETON', 'SLTH_UNIT_PYRE_ZOMBIE'},
    [TRIBE_CLAN_LIZARDMEN]= {'SLTH_UNIT_LIZARDMAN', 'SLTH_UNIT_GORILLA'},

}

local tBarbClanExtraGraceUnits = {
    [TRIBE_CLAN_SKELETON]= {'SLTH_UNIT_WRAITH'},
    [TRIBE_CLAN_LIZARDMEN]= {'SLTH_UNIT_MANTICORE'},
}

local iFEATURE_FOREST = GameInfo.Features['FEATURE_FOREST'].Index
local iSnowTerrain = GameInfo.Terrains['TERRAIN_SNOW'].Index
local iSnowTerrainHills = GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index

function BigBadGroupSpawn(pPlot, pUnit, bGraceFailed, iBarbClanType, iFeatureType, bIsWater)
    local leaderTable, henchTable
    local iChosenLeaderIndex, iChosenLeader, iChosenHenchIndex, iChosenHench
    local playerUnits = Players[63]:GetUnits();
    local iX = pPlot:GetX()
    local iY = pPlot:GetY()
    if bIsWater then
        if bGraceFailed then
            leaderTable = tBigBadFailedGraceWaterLeader
            henchTable = tBigBadFailedGraceWaterHench
        else
            leaderTable = tBigBadWaterLeader
            henchTable = tBigBadWaterHench
        end
    else
        if bGraceFailed then
            leaderTable = tBigBadFailedGraceLeader
            if iFeatureType == iFEATURE_FOREST then                             -- maybe should include ancient forest too
                table.insert(leaderTable, iTREANT_INDEX)
            end
            henchTable = tBigBadFailedGraceHench
        else
            leaderTable = tBigBadLeader
            henchTable = tBigBadHench
            local iTerrain = pPlot:GetTerrainType()
            if (iTerrain == iSnowTerrain) or (iTerrain == iSnowTerrainHills) then
                henchTable = SlthAppend(henchTable, tSnowHenchMan)
            end
            local tExtras = tBarbClanExtraUnits[iBarbClanType]
            if tExtras then
                henchTable = SlthAppend(henchTable, tExtras)
                if bGraceFailed then
                    tExtras = tBarbClanExtraGraceUnits[iBarbClanType]
                    if tExtras then
                        henchTable = SlthAppend(henchTable, tExtras)
                    end
                end
            end
            if Game:GetProperty('ARMAGEDDON') > 40 then
                leaderTable = SlthAppend(leaderTable,tArmaLeaders)
                henchTable = SlthAppend(henchTable,tArmaHench)
            end
        end
    end
    print('doing Lair Event BigBad')
    local bSuccess = DisplaceUnits(pPlot, pUnit, iX, iY)
    if not bSuccess then return; end
    if leaderTable then
        iChosenLeaderIndex = math.random(#leaderTable)
        iChosenLeader = leaderTable[iChosenLeaderIndex]
        playerUnits:Create(iChosenLeader, iX, iY);
    end

    if henchTable then
        iChosenHenchIndex = math.random(#henchTable)
        iChosenHench = henchTable[iChosenHenchIndex]
        for _=1, 5 do
            playerUnits:Create(iChosenHench, iX, iY);
        end
    end
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iPlayer = pUnit:GetOwner()
    NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    -- seems like promo list gives a random promo from the list to the leader, TODO
end

local tLairExtraInfos = {['DISEASED'] = 'DISEASED', ['PLAGUED'] = 'PLAGUED', ['POISONED']= 'POISONED',
                         ['WITHERED'] = 'WITHERED', ['BUFF_RUSTED'] = 'RUSTED', ['MUTATED'] = 'BUFF_MUTATED',
                         ['SPIRIT_GUIDE'] = 'BUFF_SPIRIT_GUIDE', ['ENCHANTED_BLADE']='BUFF_ENCHANTED_BLADE',
                         ['SPELLSTAFF'] = 'SLTH_EQUIPMENT_SPELL_STAFF', ['POISONED_BLADE'] = 'ABILITY_POISONED_BLADE',
                         ['FLAMING_ARROWS']='ABILITY_FLAMING_ARROWS', ['SHIELD_OF_FAITH']='BUFF_SHIELD_OF_FAITH',
                         ['MITHRIL_WEAPONS'] = 'ABILITY_MITHRIL_WEAPONS', ['IRON_WEAPONS']= 'ABILITY_IRON_WEAPONS',
                         ['BRONZE_WEAPONS']= 'ABILITY_BRONZE_WEAPONS',

                         ['SPAWN_DROWN']= 'SLTH_UNIT_DROWN', ['SPAWN_SEA_SERPENT']='SLTH_UNIT_SEA_SERPENT',
                         ['SPAWN_SPIDER']= 'SLTH_UNIT_GIANT_SPIDER', ['SPAWN_SPECTRE']='SLTH_UNIT_SPECTRE',
                         ['SPAWN_SKELETON'] = 'SLTH_UNIT_SKELETON', ['SPAWN_LIZARDMAN']= 'SLTH_UNIT_LIZARDMAN',
                         ['SPAWN_FROSTLING']='TODO', ['SPAWN_SCORPION']= 'SLTH_UNIT_SCORPION',

                         ['PRISONER_DISCIPLE_ASHEN'] = 'SLTH_UNIT_DISCIPLE_THE_ASHEN_VEIL',
                         ['PRISONER_DISCIPLE_EMPYREAN'] = 'SLTH_UNIT_DISCIPLE_EMPYREAN',
                         ['SUPPLIES'] = 'SLTH_UNIT_SUPPLIES',
                         ['PRISONER_DISCIPLE_LEAVES'] = 'SLTH_UNIT_DISCIPLE_FELLOWSHIP_OF_LEAVES',
                         ['PRISONER_DISCIPLE_OVERLORDS'] = 'SLTH_UNIT_DISCIPLE_OCTOPUS_OVERLORDS',
                         ['PRISONER_DISCIPLE_RUNES'] = 'SLTH_UNIT_DISCIPLE_RUNES_OF_KILMORPH',
                         ['PRISONER_DISCIPLE_ORDER'] = 'SLTH_UNIT_DISCIPLE_THE_ORDER',
                         ['PRISONER_SEA_SERPENT'] = 'SLTH_UNIT_SEA_SERPENT',
                         ['PRISONER_ADVENTURER'] = 'UNIT_GREAT_WRITER', ['PRISONER_ARTIST'] = 'UNIT_GREAT_ARTIST',
                         ['PRISONER_COMMANDER'] = 'UNIT_GREAT_GENERAL', ['PRISONER_ENGINEER'] = 'UNIT_GREAT_ENGINEER',
                         ['PRISONER_MERCHANT'] = 'UNIT_GREAT_MERCHANT', ['PRISONER_PROPHET'] = 'UNIT_GREAT_PROPHET',
                         ['PRISONER_SCIENTIST'] = 'UNIT_GREAT_SCIENTIST',

                         ['PRISONER_ANGEL'] = 'SLTH_UNIT_ANGEL', ['PRISONER_MONK'] = 'SLTH_UNIT_MONK',
                         ['PRISONER_ASSASSIN'] = 'SLTH_UNIT_ASSASSIN', ['PRISONER_CHAMPION'] = 'SLTH_UNIT_CHAMPION',
                         ['PRISONER_MAGE'] = 'SLTH_UNIT_MAGE',

                         ['ITEM_JADE_TORC'] = 'SLTH_EQUIPMENT_JADE_TORC',
                         ['ITEM_HEALING_SALVE']='SLTH_EQUIPMENT_HEALING_SALVE',
                         ['ITEM_ROD_OF_WINDS'] = 'SLTH_EQUIPMENT_ROD_OF_WINDS',
                         ['ITEM_TIMOR_MASK'] = 'SLTH_EQUIPMENT_TIMOR_MASK', ['TREASURE'] = 'SLTH_EQUIPMENT_TREASURE',

                         ['BONUS_CLAM'] = 'RESOURCE_CLAM', ['BONUS_CRAB'] = 'RESOURCE_CRAB',
                         ['BONUS_FISH'] = 'RESOURCE_FISH', ['BONUS_COPPER'] = 'RESOURCE_COPPER',
                         ['BONUS_GEMS'] = 'RESOURCE_GEMS', ['BONUS_GOLD'] ='RESOURCE_GOLD',
                         ['BONUS_IRON'] = 'RESOURCE_IRON'}

function onLairTreasureVault(pUnit, pPlot, sEventInfo)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    pPlayer:GetTreasury():ChangeGoldBalance(1000)
end

function onGrantResource(pUnit, pPlot, sEventInfo)
    local iResourceIndex = GameInfo.Resources[sEventInfo].Index
    WorldBuilder.MapManager():SetResourceType(pPlot, iResourceIndex, 1)
end

function onGrantItem(pUnit, pPlot, sEventInfo)
    local sAbility = sEventInfo .. '_ABILITY'
    local pUnitAbilities = pUnit:GetAbility()
    if pUnitAbilities:CanHaveAbility(sAbility) then
        if pUnitAbilities:HasAbility(sAbility) then
            local iPlayer = pUnit:GetOwner()
            local pPlayer = Players[iPlayer]
            local playerUnits = pPlayer:GetUnits()
            local iX, iY = pUnit:GetX(), pUnit:GetY()
            local iUnitIndex = GameInfo.Units[sEventInfo].Index
            playerUnits:Create(iUnitIndex, iX, iY); -- spawn the unit version
        else
            pUnitAbilities:AddAbilityCount(sAbility)
        end
    end
end

function onSpawnBarb(pUnit, pPlot, sUnitType)
    local pBarbPlayer = Players[63]
    local barbUnits = pBarbPlayer:GetUnits();
    local tUnitInfo =  GameInfo.Units[sUnitType]
    if not tUnitInfo then
        print('ERROR. No info for :' .. sUnitType)
        return;
    end
    local iUnitIndex = tUnitInfo.Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    local bSuccess = DisplaceUnits(pPlot, pUnit, iX, iY)
    if not bSuccess then return; end
    barbUnits:Create(iUnitIndex, iX, iY);
end

function onLairGrantGold(pUnit, pPlot, sEventInfo)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    pPlayer:GetTreasury():ChangeGoldBalance(200)                -- should scale this by speed possibly
end

function OnLairGrantExperience(pUnit, pPlot, sEventInfo)
    local pUnitExp = pUnit:GetExperience()
    pUnitExp:ChangeExperience(30)
end

function onLairGrantAbility(pUnit, pPlot, sEventInfo)
    local pUnitAbilities = pUnit:GetAbility()
    pUnitAbilities:AddAbilityCount(sEventInfo)
end

function onGrantUnit(pUnit, pPlot, sUnitType)
    print('After event unit is')
    print(pUnit)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    local playerUnits = pPlayer:GetUnits();
    local iUnitIndex = GameInfo.Units[sUnitType].Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    playerUnits:Create(iUnitIndex, iX, iY);
end

function onGrantGreatUnit(pUnit, pPlot, sUnitType)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    local playerUnits = pPlayer:GetUnits();
    local iUnitIndex = GameInfo.Units[sUnitType].Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    playerUnits:Create(iUnitIndex, iX, iY);
end

function onLairNothing(pUnit, pPlot, sEventInfo)
    print('roll failed')
end

function onLairKill(pUnit, pPlot, sEventInfo)
    UnitManager.Kill(pUnit)
end

function onLairCollapse(pUnit, pPlot, sEventInfo)
    local iDamageDealt = math.random(50, 90)
    pUnit:ChangeDamage(iDamageDealt)
    if pUnit:GetDamage() < 1 then           -- is it at 0 or at 100?
        UnitManager.Kill(pUnit)
    end
end

function onSpawnBadScorpion(pUnit, pPlot, sEventInfo)
    print('do nothing')
end
function EventCollapse(x, y)
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
function SLTH_Todo(pUnit, pPlot, sEventInfo)
    print('placeholder')
end


local tLairEvents = {['DEATH'] = onLairKill, ['COLLAPSE']= onLairCollapse,
                     ['DISEASED'] = onLairGrantAbility, ['PLAGUED'] = onLairGrantAbility,
                     ['POISONED'] = onLairGrantAbility, ['WITHERED'] = onLairGrantAbility,
                     ['RUSTED'] = onLairGrantAbility, ['SPIRIT_GUIDE'] = onLairGrantAbility,
                     ['ENCHANTED_BLADE'] = onLairGrantAbility, ['POISONED_BLADE'] = onLairGrantAbility,
                     ['FLAMING_ARROWS'] = onLairGrantAbility, ['SHIELD_OF_FAITH'] = onLairGrantAbility,
                     ['MITHRIL_WEAPONS'] = onLairGrantAbility, ['IRON_WEAPONS'] = onLairGrantAbility,
                     ['BRONZE_WEAPONS'] = onLairGrantAbility,
                     ['CRAZED'] = SLTH_Todo, ['DEMONIC_POSSESSION'] = SLTH_Todo, ['ENRAGED'] = SLTH_Todo,
                     ['MUTATED'] = SLTH_Todo, ['CAGE'] = SLTH_Todo,

                     ['SPAWN_DROWN'] = onSpawnBarb, ['SPAWN_SEA_SERPENT'] = onSpawnBarb, ['SPAWN_SPIDER']= onSpawnBarb,
                     ['SPAWN_SPECTRE'] = onSpawnBarb, ['SPAWN_SCORPION_BAD'] = onSpawnBadScorpion,
                     ['SPAWN_SKELETON'] = onSpawnBarb, ['SPAWN_LIZARDMAN'] = onSpawnBarb, ['SPAWN_FROSTLING'] = onSpawnBarb,
                     ['SPAWN_SCORPION'] = onSpawnBarb,

                     ['SUPPLIES'] = onGrantUnit, ['PRISONER_DISCIPLE_ASHEN'] = onGrantUnit,
                     ['PRISONER_DISCIPLE_EMPYREAN'] = onGrantUnit, ['PRISONER_DISCIPLE_LEAVES'] = onGrantUnit,
                     ['PRISONER_DISCIPLE_OVERLORDS'] = onGrantUnit, ['PRISONER_DISCIPLE_RUNES'] = onGrantUnit,
                     ['PRISONER_DISCIPLE_ORDER'] = onGrantUnit, ['PRISONER_SEA_SERPENT'] = onGrantUnit,
                     ['PRISONER_ADVENTURER'] = onGrantUnit, ['PRISONER_ARTIST'] = onGrantGreatUnit,
                     ['PRISONER_COMMANDER'] = onGrantGreatUnit, ['PRISONER_ENGINEER'] = onGrantGreatUnit,
                     ['PRISONER_MERCHANT'] = onGrantGreatUnit, ['PRISONER_PROPHET'] = onGrantGreatUnit,
                     ['PRISONER_SCIENTIST'] = onGrantGreatUnit,
                     ['ITEM_HEALING_SALVE'] = onGrantItem, ['ITEM_JADE_TORC'] = onGrantItem,
                     ['ITEM_ROD_OF_WINDS'] = onGrantItem, ['ITEM_TIMOR_MASK'] = onGrantItem,  ['SPELLSTAFF'] = onGrantItem,
                     ['PRISONER_ANGEL'] = onGrantUnit, ['PRISONER_MONK'] = onGrantUnit,
                     ['PRISONER_ASSASSIN'] = onGrantUnit, ['PRISONER_CHAMPION'] = onGrantUnit,
                     ['PRISONER_MAGE'] = onGrantUnit,
                     ['BONUS_CLAM'] = onGrantResource, ['BONUS_CRAB'] = onGrantResource,
                     ['BONUS_FISH'] = onGrantResource, ['BONUS_COPPER'] = onGrantResource, ['BONUS_GEMS'] = onGrantResource,
                     ['BONUS_GOLD'] = onGrantResource, ['BONUS_IRON'] = onGrantResource,
                     ['NOTHING'] = onLairNothing, ['HIGH_GOLD'] = onLairGrantGold,
                     ['TREASURE'] = onGrantUnit, ['EXPERIENCE'] = OnLairGrantExperience,
                     ['DEPTHS'] = SLTH_Todo, ['DWARF_VS_LIZARDMEN'] = SLTH_Todo, ['PORTAL'] = SLTH_Todo,
                     ['TREASURE_VAULT'] = onLairTreasureVault, ['GOLDEN_AGE'] = SLTH_Todo, ['TECH'] = SLTH_Todo}

local tLairDestroyChance = {['DEATH'] = 0, ['COLLAPSE']= 100,
                            ['CRAZED'] = 80, ['DEMONIC_POSSESSION'] = 80, ['ENRAGED'] = 80, ['MUTATED'] = 50,
                            ['DISEASED'] = 80, ['PLAGUED'] = 80, ['POISONED'] = 80, ['WITHERED'] = 80,
                            ['RUSTED'] = 80, ['SPIRIT_GUIDE'] = 80,
                            ['ENCHANTED_BLADE'] = 100, ['POISONED_BLADE'] = 100, ['FLAMING_ARROWS'] = 100,
                            ['SHIELD_OF_FAITH'] = 100,
                            ['MITHRIL_WEAPONS'] = 100, ['IRON_WEAPONS'] = 100, ['BRONZE_WEAPONS'] = 100, ['CAGE'] = 0,

                            ['SPAWN_DROWN'] = 50, ['SPAWN_SEA_SERPENT'] = 50, ['SPAWN_SPIDER'] = 50,
                            ['SPAWN_SPECTRE'] = 50, ['SPAWN_SCORPION_BAD'] = 50,
                            ['SPAWN_SKELETON'] = 50, ['SPAWN_LIZARDMAN'] = 50, ['SPAWN_FROSTLING'] = 50,
                            ['SPAWN_SCORPION'] = 50,

                            ['SUPPLIES'] = 100, ['PRISONER_DISCIPLE_ASHEN'] = 100,
                            ['PRISONER_DISCIPLE_EMPYREAN'] = 100, ['PRISONER_DISCIPLE_LEAVES'] = 100,
                            ['PRISONER_DISCIPLE_OVERLORDS'] = 100, ['PRISONER_DISCIPLE_RUNES'] = 100,
                            ['PRISONER_DISCIPLE_ORDER'] = 100, ['PRISONER_SEA_SERPENT'] = 100,
                            ['PRISONER_ADVENTURER'] = 100, ['PRISONER_ARTIST'] = 100, ['PRISONER_COMMANDER'] = 100,
                            ['PRISONER_ENGINEER'] = 100, ['PRISONER_MERCHANT'] = 100, ['PRISONER_PROPHET'] = 100,
                            ['PRISONER_SCIENTIST'] = 100,
                            ['ITEM_HEALING_SALVE'] = 100, ['ITEM_JADE_TORC'] = 100,
                            ['ITEM_ROD_OF_WINDS'] = 100, ['ITEM_TIMOR_MASK'] = 100,  ['SPELLSTAFF'] = 100,
                            ['PRISONER_ANGEL'] = 100, ['PRISONER_MONK'] = 100,
                            ['PRISONER_ASSASSIN'] = 100, ['PRISONER_CHAMPION'] = 100, ['PRISONER_MAGE'] = 100,
                            ['DEPTHS'] = 0, ['DWARF_VS_LIZARDMEN'] = 100,
                            ['PORTAL'] = 0, ['BONUS_CLAM'] = 100, ['BONUS_CRAB'] = 100,
                            ['BONUS_FISH'] = 100, ['BONUS_COPPER'] = 100, ['BONUS_GEMS'] = 100,
                            ['BONUS_GOLD'] = 100, ['BONUS_IRON'] = 100,
                            ['NOTHING'] = 100, ['HIGH_GOLD'] = 90, ['TREASURE'] = 80,
                            ['EXPERIENCE'] = 100, ['TREASURE_VAULT'] = 100, ['GOLDEN_AGE'] = 100, ['TECH'] = 100}

function doBad(pPlot, iBarbClanType, pUnit, bIsWater)
    local tPossible = {'COLLAPSE'}
    local pUnitExp = pUnit:GetExperience()
    if pUnitExp:GetExperienceForNextLevel() == 15 then
        table.insert(tPossible, 'DEATH')
    end
    local iUnitIndex = pUnit:GetType()
    local sUnitName = GameInfo.Units[iUnitIndex].UnitType
    if GameInfo.UnitsNotAlive[sUnitName] then
        tPossible = SlthAppend(tPossible, {'CRAZED', 'DEMONIC_POSSESSION', 'DISEASED', 'ENRAGED',
                                           'PLAGUED', 'POISONED', 'WITHERED'})
    end
    local sPromoClass = GameInfo.Units[iUnitIndex].PromotionClass
    if sPromoClass == 'PROMOTION_CLASS_MELEE' then
        table.insert(tPossible, 'RUSTED')
    end
    if bIsWater then
        tPossible = SlthAppend(tPossible, {'SPAWN_DROWN', 'SPAWN_SEA_SERPENT'})
    else
        tPossible = SlthAppend(tPossible, {'SPAWN_SPIDER', 'SPAWN_SPECTRE'})
    end
    if iBarbClanType == TRIBE_CLAN_SCORPION then
        tPossible = tPossible + {'SPAWN_SCORPION_BAD', 'SPAWN_SCORPION_BAD', 'SPAWN_SCORPION_BAD'}
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local fEvent = tLairEvents[sEvent]
    local sUnitType = tLairExtraInfos[sEvent]
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    local iPlayer = pUnit:GetOwner()
    NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    local iThreshold = tLairDestroyChance[sEvent]
    return iThreshold
end

function testLairs(pUnit, pPlot)
    for sEvent, fEvent in pairs(tLairEvents) do
        local sUnitType = tLairExtraInfos[sEvent]
        fEvent(pUnit, pPlot, sUnitType)
    end
end

function doNeutral(pPlot, iBarbClanType, pUnit, bIsWater)
    local tPossible = {'NOTHING'}
    if not bIsWater then
        tPossible = SlthAppend(tPossible, {'SPAWN_SKELETON', 'SPAWN_LIZARDMAN', 'SPAWN_SPIDER', 'PORTAL', 'DEPTHS', 'DWARF_VS_LIZARDMEN', 'CAGE'})
        local iTerrain = pPlot:GetTerrainType()
        if (iTerrain == iSnowTerrain) or (iTerrain == iSnowTerrainHills) then
            table.insert(tPossible, 'SPAWN_FROSTLING')
        end
        if iBarbClanType == TRIBE_CLAN_SKELETON then
            tPossible =  SlthAppend(tPossible, {'SPAWN_SKELETON', 'SPAWN_SKELETON'})
        elseif iBarbClanType == TRIBE_CLAN_LIZARDMEN then
            tPossible =  SlthAppend(tPossible, {'SPAWN_LIZARDMAN', 'SPAWN_LIZARDMAN'})
        elseif iBarbClanType == TRIBE_CLAN_SCORPION then
            tPossible =  SlthAppend(tPossible, {'SPAWN_SCORPION', 'SPAWN_SCORPION', 'SPAWN_SCORPION'})
        end
    else
        table.insert(tPossible, 'SPAWN_DROWN')
    end
    local iUnitIndex = pUnit:GetType()
    local sUnitName = GameInfo.Units[iUnitIndex].UnitType
    if GameInfo.UnitsNotAlive[sUnitName] then
        if not pUnitAbilities:HasAbility('BUFF_MUTATED') then           -- todo add buff mutated.
            table.insert(tPossible, 'MUTATED')
        end
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local fEvent = tLairEvents[sEvent]
    local sUnitType = tLairExtraInfos[sEvent]
    fEvent(pUnit, pPlot, sUnitType)
    local iThreshold = tLairDestroyChance[sEvent]
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    local iPlayer = pUnit:GetOwner()
    NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    return iThreshold
end

local iCIVIC_MYSTICISM = GameInfo.Civics['CIVIC_MYSTICISM'].Index

function doGood(pPlot, pUnit, bIsWater)
    local tPossible =  {'HIGH_GOLD', 'TREASURE', 'EXPERIENCE'}
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    local iUnitIndex = pUnit:GetType()
    local pUnitAbilities = pUnit:GetAbility()
    local tUnitInfos = GameInfo.Units[iUnitIndex]
    local sUnitName = tUnitInfos.UnitType
    local sUnitPromoClass = tUnitInfos.PromotionClass
    if GameInfo.UnitsNotAlive[sUnitName] then
        if not pUnitAbilities:HasAbility('BUFF_SPIRIT_GUIDE') then          -- todo implement
            table.insert(tPossible, 'SPIRIT_GUIDE')
        end
    end
    if not bIsWater then
        tPossible = SlthAppend(tPossible, {'ITEM_HEALING_SALVE', 'SUPPLIES'})
        local pCulture = pPlayer:GetCulture()
        if pCulture:HasCivic(iCIVIC_MYSTICISM) then
            tPossible = SlthAppend(tPossible, {'PRISONER_DISCIPLE_ASHEN', 'PRISONER_DISCIPLE_EMPYREAN',
                                               'PRISONER_DISCIPLE_LEAVES', 'PRISONER_DISCIPLE_OVERLORDS',
                                               'PRISONER_DISCIPLE_RUNES', 'PRISONER_DISCIPLE_ORDER'})
        end
    end
    if sUnitPromoClass == 'PROMOTION_CLASS_MELEE' then
        if not pUnitAbilities:HasAbility('BUFF_ENCHANTED_BLADE') then
            table.insert(tPossible, 'ENCHANTED_BLADE')
        end
    elseif sUnitPromoClass == 'PROMOTION_CLASS_ADEPT' then
        if not pUnitAbilities:HasAbility('SLTH_EQUIPMENT_SPELL_STAFF_ABILITY') then
            table.insert(tPossible, 'SPELLSTAFF')
        end
    elseif sUnitPromoClass == 'PROMOTION_CLASS_RECON' then
        if not pUnitAbilities:HasAbility('ABILITY_POISONED_BLADE') then
            table.insert(tPossible, 'POISONED_BLADE')
        end
    elseif sUnitPromoClass == 'PROMOTION_CLASS_RANGED' then
        if not pUnitAbilities:HasAbility('ABILITY_FLAMING_ARROWS') then
            table.insert(tPossible, 'FLAMING_ARROWS')
        end
    elseif sUnitPromoClass == 'PROMOTION_CLASS_DISCIPLE' then
        if not pUnitAbilities:HasAbility('BUFF_SHIELD_OF_FAITH') then
            table.insert(tPossible, 'SHIELD_OF_FAITH')
        end
    end
    if pUnitAbilities:CanHaveAbility('ABILITY_BRONZE_WEAPONS') then
        if pUnitAbilities:HasAbility('ABILITY_BRONZE_WEAPONS') then
            local pTechs = pPlayer:GetTechs()
            if pUnitAbilities:HasAbility('ABILITY_IRON_WEAPONS') then
                if not pUnitAbilities:HasAbility('ABILITY_MITHRIL_WEAPONS') then
                    if pUnitAbilities:CanHaveAbility('ABILITY_MITHRIL_WEAPONS') and pTechs:HasTech('TECH_IRON_WORKING') then
                        table.insert(tPossible, 'MITHRIL_WEAPONS')
                    end
                end
            elseif pUnitAbilities:CanHaveAbility('ABILITY_IRON_WEAPONS') and pTechs:HasTech('TECH_BRONZE_WORKING') then
                table.insert(tPossible, 'IRON_WEAPONS')
            end
        else
            table.insert(tPossible, 'BRONZE_WEAPONS')
        end
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local fEvent = tLairEvents[sEvent]
    local sUnitType = tLairExtraInfos[sEvent]
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    local iThreshold = tLairDestroyChance[sEvent]
    return iThreshold
end

function doBigGood(pPlot, bGraceFailed, pUnit, bIsWater)
    local tPossible = {'TREASURE_VAULT', 'GOLDEN_AGE'}
    if false then         -- was pPlayer.canReceiveGoody(pPlot, gc.getInfoTypeForString('GOODY_GRAVE_TECH'), caster) ???
        table.insert(tPossible, 'TECH')
    end
    if bIsWater then
        table.insert(tPossible, 'PRISONER_SEA_SERPENT')
        if bNoBonusResource then
            tPossible = SlthAppend(tPossible, {'BONUS_CLAM', 'BONUS_CRAB', 'BONUS_FISH'})
        end
    else
        tPossible = SlthAppend(tPossible, {'ITEM_JADE_TORC', 'ITEM_ROD_OF_WINDS', 'ITEM_TIMOR_MASK',
                                           'PRISONER_ADVENTURER', 'PRISONER_ARTIST', 'PRISONER_COMMANDER', 'PRISONER_ENGINEER',
                                           'PRISONER_MERCHANT', 'PRISONER_PROPHET', 'PRISONER_SCIENTIST'})
        local iPlayer = pUnit:GetOwner()
        local pPlayer = Players[iPlayer]
        local pTechs = pPlayer:GetTechs()
        if pTechs:HasTech('TECH_MINING') then
            tPossible = SlthAppend(tPossible, {'BONUS_COPPER', 'BONUS_GEMS', 'BONUS_GOLD'})
            if pTechs:HasTech('TECH_SMELTING') then
                table.insert(tPossible, 'BONUS_IRON')
            end
        end
    end

    if bGraceFailed then
        tPossible = SlthAppend(tPossible, {'PRISONER_ANGEL', 'PRISONER_MONK', 'PRISONER_ASSASSIN', 'PRISONER_CHAMPION',
                                           'PRISONER_MAGE'})
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local fEvent = tLairEvents[sEvent]
    local sUnitType = tLairExtraInfos[sEvent]
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    local iPlayer = pUnit:GetOwner()
    NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
end
-- local TRIBE_CLAN_NAT_WON = GameInfo.BarbarianTribes[TRIBE_CLAN_CAVALRY_CHARIOT'].Index

function RemovedBarbCamp(x, y, owningPlayerID)
    local pPlot = Map.GetPlot(x, y)
    print(x)
    print(y)
    local owner = pPlot:GetOwner()
    print('destroying')     -- need to change something to allow barb camps to not be removed on owning territory.
    if owningPlayerID == 63 or owner == -1 then
        local iFeatureType = pPlot:GetFeatureType()
        local bIsWater = pPlot:IsWater()
        local tribeIndex = pPlot:GetProperty('barbclantype') or 1
        local iDiceRoll = math.random(100)
        local iThreshold
        local bGraceFailed
        local pUnit
        for _, pOnTileUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do
            if (pOnTileUnit) and (not pUnit) then
                pUnit = pOnTileUnit
            end
        end
        local uhh = GameConfiguration.GetGameSpeedType()         -- TODO convert hash to number.
        print(uhh)
        local iGameSpeed = 3
        local iGrace = 20 * (iGameSpeed + 1)
        local iPlayerDifficulty = 3
		local iDiff =  4 - iPlayerDifficulty        -- converted from python gc.getNumHandicapInfos() + 1 - int(gc.getGame().getHandicapType())
        iGrace = iGrace * iDiff                     -- just using 4 as difference difficulty
        print(iGrace)
		iGrace = math.random(iGrace) + iGrace
        bGraceFailed = iGrace > Game.GetCurrentGameTurn()
        if tBarbNW[iFeatureType] then
            if iDiceRoll < 54 then
                BigBadGroupSpawn(pPlot, pUnit, bGraceFailed, tribeIndex, iFeatureType, bIsWater)
            else
                doBigGood(pPlot, bGraceFailed, pUnit, bIsWater)
            end
        else
            if iDiceRoll < 14 then
                BigBadGroupSpawn(pPlot, pUnit, bGraceFailed, tribeIndex, iFeatureType, bIsWater)
                iThreshold = 0
            elseif iDiceRoll < 44 then
                iThreshold = doBad(pPlot, tribeIndex, pUnit, bIsWater)
            elseif iDiceRoll < 74 then
                iThreshold = doNeutral(pPlot, tribeIndex, pUnit, bIsWater)
            elseif iDiceRoll < 94 then
                iThreshold = doGood(pPlot, pUnit, bIsWater)
            else
                doBigGood(pPlot, bGraceFailed, pUnit, bIsWater)
                iThreshold = 100
            end
            local iDestroyLairDiceRoll = math.random(100)
            if iDestroyLairDiceRoll <= iThreshold then
                local iPlotID = pPlot:GetIndex()
                Game.GetBarbarianManager():CreateTribeOfType(tribeIndex, iPlotID)       -- recreate camp
            end
        end
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
        local pPlot = Map.GetPlotByIndex(plotID)
        local iAltarLevel = pPlot:GetProperty('altar_level')
        if not iAltarLevel then
            pPlot:SetProperty('altar_level', 0)
        end
        local iCivicForNext = tLuonnotarInfo['civic']
        if iCivicForNext then
            -- check if has culture
            local pPlayer = Players[playerID]
            if not pPlayer then return; end
            local pCulture = pPlayer:GetCulture()
            if not pCulture then return; end
            local pCity = CityManager.GetCity(pPlayer, cityID)
            if not pCulture:HasCivic(iCivicForNext) then
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
local iCivicMilTraining = GameInfo.Civics['CIVIC_MILITARY_TRAINING'].Index
local iCivicDrama = GameInfo.Civics['CIVIC_DRAMA_POETRY'].Index
local iGreatGeneral = GameInfo.Units['UNIT_GREAT_GENERAL'].Index
local iGreatArtist = GameInfo.Units['UNIT_GREAT_ARTIST'].Index
local tCivicsGreatPeople = {[iCivicMilTraining] = iGreatGeneral, [iCivicDrama] = iGreatArtist}

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
    -- do check for first to civic?
    if civicIndex == iCivicMilTraining then
        local bMilTrainingDiscovered = Game:GetProperty('MIL_TRAINING_DISCOVERED')
        if not bMilTrainingDiscovered then
            local pCapital = pPlayer:GetCities():GetCapitalCity()
            local iUnitType = tCivicsGreatPeople[civicIndex]
            Game.GetGreatPeople():CreatePerson(playerID, iUnitType, pCapital:GetX(), pCapital:GetY())
            Game:SetProperty('MIL_TRAINING_DISCOVERED', 1)
        end
    end

    if civicIndex == iCivicMilTraining then
        local bDramaDiscovered =  Game:GetProperty('DRAMA_DISCOVERED')
        if not bDramaDiscovered then
            local pCapital = pPlayer:GetCities():GetCapitalCity()
            local iUnitType = tCivicsGreatPeople[civicIndex]
            Game.GetGreatPeople():CreatePerson(playerID, iUnitType, pCapital:GetX(), pCapital:GetY())
            Game:SetProperty('DRAMA_DISCOVERED', 1)
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

-- Gives 2 to 5 new random promotions to the unit from any promotions with bMutation flag set in Civ4PromotionsInfo.xml
-- that are possible (equal chance of each):
-- 'AMPHIBIOUS', 'BLITZ', 'CANNABILIZE', 'COLD_RESISTANCE', 'COMBAT1', 'FIRE_RESISTANCE', 'HEROIC_DEFENSE', 'HEROIC_STRENGTH',
-- 'LIGHTNING_RESISTANCE', 'POISON_RESISTANCE', 'MOBILITY1', 'SENTRY',
-- 'DISEASED', 'BUFF_EMPOWER', 'ABILITY_HEAVY', 'ABILITY_IMMUNE_TO_DISEASE', 'ABILITY_LIGHT', 'BUFF_REGENERATION', 'BUFF_STONESKIN',
-- 'ABILITY_STRONG', 'ABILITY_WEAK', 'VULNERABLE_TO_FIRE', 'WITHERED'

-- VULN_fire will not work as it requires tags
local iABILITY_MUTATED = GameInfo.UnitAbilities['BUFF_MUTATED'].Index
local iAMPH_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_MELEE'].Index
local iBLITZ_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_BLITZ_MELEE'].Index
local iCANNIBALIZE_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_MELEE'].Index
local iCOLD_RES_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_MELEE'].Index
local iFIRE_RES_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_MELEE'].Index
local iLIGHTNING_RES_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_MELEE'].Index
local iPOISON_RES_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_MELEE'].Index
local iMOBILITY_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_MELEE'].Index
local iSENTRY_MELEE_INDEX = GameInfo.UnitPromotions['PROMOTION_SENTRY_MELEE'].Index

local tMutationPromotionsMelee = {
    ['AMPHIBIOUS'] = iAMPH_MELEE_INDEX,
    ['BLITZ'] = iBLITZ_MELEE_INDEX,
    ['CANNABILIZE'] = iCANNIBALIZE_MELEE_INDEX,
    ['COLD_RESISTANCE'] = iCOLD_RES_MELEE_INDEX,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_MELEE'].Index,
    ['FIRE_RESISTANCE'] = iFIRE_RES_MELEE_INDEX,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_MELEE'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_MELEE'].Index,
    ['LIGHTNING_RESISTANCE'] = iLIGHTNING_RES_MELEE_INDEX,
    ['POISON_RESISTANCE'] = iPOISON_RES_MELEE_INDEX,
    ['MOBILITY1'] = iMOBILITY_MELEE_INDEX,
    ['SENTRY'] = iSENTRY_MELEE_INDEX
}

local tMutationPromotionsRecon = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_RECON'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_RECON'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_RECON'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_RECON'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_RECON'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_RECON'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_RECON'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_RECON'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_RECON'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_RECON'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_RECON'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_RECON'].Index
}

local tMutationPromotionsRanged = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_RANGED'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_RANGED'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_RANGED'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_RANGED'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_RANGED'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_RANGED'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_RANGED'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_RANGED'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_RANGED'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_RANGED'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_RANGED'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_RANGED'].Index
}

local tMutationPromotionsLightCav = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_LIGHT_CAVALRY'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_LIGHT_CAVALRY'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_LIGHT_CAVALRY'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_LIGHT_CAVALRY'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_LIGHT_CAVALRY'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_LIGHT_CAVALRY'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_LIGHT_CAVALRY'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_LIGHT_CAVALRY'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_LIGHT_CAVALRY'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_LIGHT_CAVALRY'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_LIGHT_CAVALRY'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_LIGHT_CAVALRY'].Index
}

local tMutationPromotionsSiege = {
    ['AMPHIBIOUS'] = iAMPH_MELEE_INDEX,
    ['BLITZ'] = iBLITZ_MELEE_INDEX,
    ['CANNABILIZE'] = iCANNIBALIZE_MELEE_INDEX,
    ['COLD_RESISTANCE'] = iCOLD_RES_MELEE_INDEX,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_SIEGE'].Index,
    ['FIRE_RESISTANCE'] = iFIRE_RES_MELEE_INDEX,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_SIEGE'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_SIEGE'].Index,
    ['LIGHTNING_RESISTANCE'] = iLIGHTNING_RES_MELEE_INDEX,
    ['POISON_RESISTANCE'] = iPOISON_RES_MELEE_INDEX,
    ['MOBILITY1'] = iMOBILITY_MELEE_INDEX,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_SIEGE'].Index
}

local tMutationPromotionsAnimal = {
    ['AMPHIBIOUS']= iAMPH_MELEE_INDEX,
    ['BLITZ'] = iBLITZ_MELEE_INDEX,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_ANIMAL'].Index,
    ['COLD_RESISTANCE'] = iCOLD_RES_MELEE_INDEX,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_ANIMAL'].Index,
    ['FIRE_RESISTANCE'] = iFIRE_RES_MELEE_INDEX,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_ANIMAL'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_ANIMAL'].Index,
    ['LIGHTNING_RESISTANCE'] = iLIGHTNING_RES_MELEE_INDEX,
    ['POISON_RESISTANCE'] = iPOISON_RES_MELEE_INDEX,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_ANIMAL'].Index,
    ['SENTRY'] = iSENTRY_MELEE_INDEX           -- lost
}

local tMutationPromotionsBeast = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_BEAST'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_BEAST'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_BEAST'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_BEAST'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_BEAST'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_BEAST'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_BEAST'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_BEAST'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_BEAST'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_BEAST'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_BEAST'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_BEAST'].Index
}

local tMutationPromotionsAdept = {
    ['AMPHIBIOUS']= iAMPH_MELEE_INDEX,
    ['BLITZ'] = iBLITZ_MELEE_INDEX,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_ADEPT'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_ADEPT'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_ADEPT'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_ADEPT'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_ADEPT'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_ADEPT'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_ADEPT'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_ADEPT'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_ADEPT'].Index,
    ['SENTRY'] = iSENTRY_MELEE_INDEX
}

local tMutationPromotionsDisciple = {
    ['AMPHIBIOUS']= GameInfo.UnitPromotions['PROMOTION_AMPHIBIOUS_DISCIPLE'].Index,
    ['BLITZ'] = GameInfo.UnitPromotions['PROMOTION_BLITZ_DISCIPLE'].Index,
    ['CANNABILIZE'] = GameInfo.UnitPromotions['PROMOTION_CANNIBALIZE_DISCIPLE'].Index,
    ['COLD_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_COLD_RESISTANCE_DISCIPLE'].Index,
    ['COMBAT1'] = GameInfo.UnitPromotions['PROMOTION_COMBAT1_DISCIPLE'].Index,
    ['FIRE_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_FIRE_RESISTANCE_DISCIPLE'].Index,
    ['HEROIC_DEFENSE'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_DEFENSE_DISCIPLE'].Index,
    ['HEROIC_STRENGTH'] = GameInfo.UnitPromotions['PROMOTION_HEROIC_STRENGTH_DISCIPLE'].Index,
    ['LIGHTNING_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_LIGHTNING_RESISTANCE_DISCIPLE'].Index,
    ['POISON_RESISTANCE'] = GameInfo.UnitPromotions['PROMOTION_POISON_RESISTANCE_DISCIPLE'].Index,
    ['MOBILITY1'] = GameInfo.UnitPromotions['PROMOTION_MOBILITY1_DISCIPLE'].Index,
    ['SENTRY'] = GameInfo.UnitPromotions['PROMOTION_SENTRY_DISCIPLE'].Index
}
local tMutationPromoTables = {['PROMOTION_CLASS_MELEE']=tMutationPromotionsMelee,
                              ['PROMOTION_CLASS_RECON']=tMutationPromotionsRecon,
                              ['PROMOTION_CLASS_RANGED']=tMutationPromotionsRanged,
                              ['PROMOTION_CLASS_LIGHT_CAVALRY']=tMutationPromotionsLightCav,
                              ['PROMOTION_CLASS_SIEGE']=tMutationPromotionsSiege,
                              ['PROMOTION_CLASS_ANIMAL']=tMutationPromotionsAnimal,
                              ['PROMOTION_CLASS_BEAST']=tMutationPromotionsBeast,
                              ['PROMOTION_CLASS_ADEPT']=tMutationPromotionsAdept,
                              ['PROMOTION_CLASS_DISCIPLE']=tMutationPromotionsDisciple
}

-- DIDNT bother with PROMOTION_CLASS_NAVAL_MELEE as shouldnt mutate. Should i do this as a SQL table, where each row is a promoclass?
-- wait no as i have to use a . accessor, like rowInfo.SENTRY and that cant be a variable

local tMutationAbilitiesAndPromotions = {
'AMPHIBIOUS', 'BLITZ', 'CANNABILIZE', 'COLD_RESISTANCE', 'COMBAT1', 'FIRE_RESISTANCE', 'HEROIC_DEFENSE', 'HEROIC_STRENGTH',
'LIGHTNING_RESISTANCE', 'POISON_RESISTANCE', 'MOBILITY1', 'SENTRY',
'DISEASED', 'BUFF_EMPOWER', 'ABILITY_HEAVY', 'ABILITY_IMMUNE_TO_DISEASE', 'ABILITY_LIGHT', 'BUFF_REGENERATION', 'BUFF_STONESKIN',
'ABILITY_STRONG', 'ABILITY_WEAK', 'ABILITY_VULNERABLE_TO_FIRE', 'WITHERED'}
local tAbilityMutations = { ['DISEASED'] = true, ['BUFF_EMPOWER'] = true, ['ABILITY_HEAVY'] = true, ['ABILITY_IMMUNE_TO_DISEASE'] = true,
                            ['ABILITY_LIGHT'] = true, ['BUFF_REGENERATION'] = true, ['BUFF_STONESKIN'] = true, ['ABILITY_STRONG'] = true,
                            ['ABILITY_WEAK'] = true, ['ABILITY_VULNERABLE_TO_FIRE'] = true, ['WITHERED'] = true
}
local tFive = {2, 3, 4, 5}
function onAbilityGained(playerID, unitID, unitAbilityIndex)
    print(unitAbilityIndex)
    if unitAbilityIndex == iABILITY_MUTATED then
        local pUnit = UnitManager.GetUnit(playerID, unitID)
        local pUnitExp = pUnit:GetExperience()
        local pUnitAbilities = pUnit:GetAbility()
        local iUnitIndex = pUnit:GetType()
        local tUnitInfos = GameInfo.Units[iUnitIndex]
        local sUnitPromoClass = tUnitInfos.PromotionClass
        local tClassPromos = tMutationPromoTables[sUnitPromoClass]
        local iNumMutations = tFive[math.random(table.count(tFive))]
        local tMutationSelection = tMutationAbilitiesAndPromotions
        local iMutationSuccesses = 0
        for var=1, 10 do
            if iMutationSuccesses <= iNumMutations then
                local iMutationIndex = math.random(table.count(tMutationSelection))
                local sMutationGrant = tMutationSelection[iMutationIndex]
                table.remove(tMutationSelection, iMutationIndex)
                if tAbilityMutations[sMutationGrant] then
                    if not pUnitAbilities:HasAbility(sMutationGrant) then
                        pUnitAbilities:AddAbilityCount(sMutationGrant)
                        iMutationSuccesses = iMutationSuccesses + 1
                    end
                else
                    local iPromoGrant = tClassPromos[sMutationGrant]
                    if not pUnitExp:HasPromotion(iPromoGrant) then
                        pUnitExp:SetPromotion(iPromoGrant)
                        iMutationSuccesses = iMutationSuccesses + 1
                    end
                end
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
    for _, pUnit in Players[63]:GetUnits():Members() do
        UnitManager.Kill(pUnit);
    end
end

-- Hook in events
function onStart()
    GameEvents.PlayerTurnStarted.Add(onTurnStartGameplay);
    Events.ImprovementChanged.Add(ImprovementsWorkOrPillageChange)
    Events.ImprovementAddedToMap.Add(InitCottage)
    GameEvents.PlayerTurnStarted.Add(IncrementCottages);

    Events.CivicCompleted.Add(OnCivicGrantFirst)
    -- Events.ResearchCompleted.Add(OnTechnologyGrantFirst)
    Events.ImprovementRemovedFromMap.Add(RemovedBarbCamp)
    GameEvents.BuildingConstructed.Add(BuildingBuilt)
    Events.UnitGreatPersonActivated.Add(onGreatPersonActivated)
    Events.UnitAbilityGained.Add(onAbilityGained)

    -- UnitOperation Works
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

    -- initialize clans
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
                                    iNewTerrain = iSnowTerrainHills
                                    if iCurrentTerrain ~= iNewTerrain then
                                        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                                    end
                                elseif pPlot:IsMountain() then
                                    iNewTerrain = GameInfo.Terrains['TERRAIN_SNOW_MOUNTAIN'].Index
                                    if iCurrentTerrain ~= iNewTerrain then
                                        TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
                                    end
                                else
                                    iNewTerrain = iSnowTerrain
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
    local eGameSpeed = GameConfiguration.GetGameSpeedType()            -- this is actually a hash not a string return. But cant find the enum for it
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier
    local iGoldenAgeLength = math.floor(20 * iSpeedCostMultiplier)
    GoldenAgeGrant(pPlayer, iGoldenAgeLength)                                                             -- should scale by speed
    pPlayer:SetProperty('GreatPeopleGoldenRequirement', iUniqueGreatPeopleRequirement + 1)
end

local function GoldenAgeGrant(pPlayer, iGoldenDuration)
    for _, pCity in pPlayer:GetCities():Members() do
        local pPlot = pCity:GetPlot();
        if pPlot then
            pPlot:SetProperty('InGoldenAge', 1);		-- but =function expected instead of nil?
        end
    end
    pPlayer:SetProperty('GoldenAgeDuration', (pPlayer:GetProperty('GoldenAgeDuration') or 0) + iGoldenDuration)
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
    local iHealth, iX, iY, tPromos, tAbilities = InheritUnitAttributes(iPlayer, iUnitID)
    local tNewUnits = BaseSummon(pUnit, iPlayer, iUnitToSummon)
    ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
    for iUnitSummonID, pNewUnit in pairs(tNewUnits) do
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

local function ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
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
    ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
    pUnit:SetDamage(0)
    -- do UnitManager delete on UI side
end

local sWorldSpellPropKey = 'WorldSpellReady'

local iDEMAGOG_INDEX = GameInfo.Units['SLTH_UNIT_DEMAGOG'].Index
local function Rally(iPlayer, tParameters)
	-- denagog in every city, degrade each town to village and get demagog
	-- requires crusade
    -- iterate over each of player city
    local pPlayer = Players[iPlayer]
    local pPlayerImprovements = pPlayer:GetImprovements();
    local playerUnits = pPlayer:GetUnits();
    if pPlayerImprovements then
        local tImprovementLocations = pPlayerImprovements:GetImprovementPlots();
        for _, plotID in ipairs(tImprovementLocations) do
            local pPlot = Map.GetPlotByIndex(plotID);
            if pPlot then
                local eImprovement = pPlot:GetImprovementType();
                if (eImprovement == iTOWN_INDEX) then
                    -- make demagog unit
                    -- displace enemy units if on tile?
                    local iX = pPlot:GetX()
                    local iY = pPlot:GetY()
                    for _, pNearUnit in ipairs(Units.GetUnitsInPlot(pPlot)) do
                        if (pNearUnit) then
                            local iOwnerPlayer = pNearUnit:GetOwner();
                            if (iOwnerPlayer ~= iPlayer) then
                                DisplaceUnits(pPlot, pNearUnit, iX, iY)
                            end
                        end
                    end
                    playerUnits:Create(iDEMAGOG_INDEX, iX, iY);
                    ImprovementBuilder.SetImprovementType(pPlot, iVILLAGE_INDEX, iPlayer)
                end
            end
        end
    end
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end
local iESUS_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_ESUS'].Index
local iOCTOPUS_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_OCTOPUS'].Index
local iEMPYREAN_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_EMPYREAN'].Index
local iRUNES_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_RUNES'].Index
local iORDER_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_ORDER'].Index
local iVEIL_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_VEIL'].Index
local iLEAVES_INDEX = GameInfo.Policies['SLTH_POLICY_STATE_LEAVES'].Index
local iNO_STATE_RELIGION_INDEX = GameInfo.Policies['SLTH_POLICY_NO_STATE_RELIGION'].Index

local iVEIL_RELIGION_INDEX = GameInfo.Religions["RELIGION_BUDDHISM"].Index
local tReligionPolicies = {iESUS_INDEX, iOCTOPUS_INDEX, iEMPYREAN_INDEX, iRUNES_INDEX, iORDER_INDEX,
                           iVEIL_INDEX, iLEAVES_INDEX, iNO_STATE_RELIGION_INDEX}

local tReligionMap = {[iESUS_INDEX]=GameInfo.Religions["RELIGION_ISLAM"].Index,
                      [iOCTOPUS_INDEX]=GameInfo.Religions["RELIGION_HINDUISM"].Index,
                      [iEMPYREAN_INDEX]=GameInfo.Religions["RELIGION_JUDAISM"].Index,
                      [iRUNES_INDEX]=GameInfo.Religions["RELIGION_CONFUCIANISM"].Index,
                      [iORDER_INDEX]=GameInfo.Religions["RELIGION_PROTESTANTISM"].Index,
                      [iVEIL_INDEX]=iVEIL_RELIGION_INDEX,
                      [iLEAVES_INDEX]=GameInfo.Religions["RELIGION_CATHOLICISM"].Index
}
local tReligionPriests = {[iESUS_INDEX]=GameInfo.Units['SLTH_UNIT_NIGHTWATCH'].Index,
                          [iOCTOPUS_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_OVERLORDS'].Index,
                          [iEMPYREAN_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_EMPYREAN'].Index,
                          [iRUNES_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_KILMORPH'].Index,
                          [iORDER_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_ORDER'].Index,
                          [iVEIL_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_THE_VEIL'].Index,
                          [iLEAVES_INDEX]=GameInfo.Units['SLTH_UNIT_PRIEST_OF_LEAVES'].Index
}
local function ReligiousFervor(iPlayer, tParameters)
    -- Grants one priest of the state religion per city, with experience equal
    -- to the number of cities in the Malakim civilization with the state religion.
    local pPlayer = Players[iPlayer]
    local pCulture = pPlayer:GetCulture()
    local playerUnits = pPlayer:GetUnits()
    local iStateReligion
    for idx, iPolicyIndex in ipairs(tReligionPolicies) do
        if not iStateReligion then
            if pCulture:IsPolicyActive(iPolicyIndex) then
                iStateReligion = iPolicyIndex
            end
        end
    end
    if iStateReligion == iNO_STATE_RELIGION_INDEX then return; end;
    local iReligionToCheck = tReligionMap[iStateReligion]
    local iPriestGrantIndex = tReligionPriests[iStateReligion]
    local iStateReligionCities = 0
    local tReligions = Game.GetReligion():GetReligions()
    local cachedUnits = pPlayer:GetUnits():Members()
    for _, pCity in pPlayer:GetCities():Members() do
        local pPlot = pCity:GetPlot();
        local iX = pPlot:GetX()
        local iY = pPlot:GetY()
        playerUnits:Create(iPriestGrantIndex, iX, iY);
        local pCityReligion = pCity:GetReligion()
        for _, tReligion in pairs(tReligions) do
            local iReligion = tReligion.Religion
            if iReligion == iReligionToCheck then
                local iNumFollowers = pCityReligion:GetNumFollowers(iReligion)
                if iNumFollowers > 0 then
                    iStateReligionCities = iStateReligionCities + 1
                end
            end
        end
    end
    for id, pUnit in pPlayer:GetUnits():Members() do
        if (not cachedUnits[id]) then
            local pUnitExp = pUnit:GetExperience()
            pUnitExp:ChangeExperience(iStateReligionCities * 2)
        end
    end
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end


local iFEATURE_ANCIENT_FOREST = GameInfo.Features['FEATURE_FOREST_ANCIENT'].Index
local function MarchOfTheTrees(iPlayer, tParameters)
	-- All forests and ancient forests in your cultural borders will turn into new forests, and create a Treant on the tile,
    -- provided it is not occupied by an enemy.
	-- After 5 turns, all the Treants will disappear. (N.B. does treant death advance forest growth?

    -- get all forest, ancient forest in civ
    -- reduce to new forest, or forest
    -- spawn treants, give treants duration 5.

    -- waiting for new forest/growth mechanics
    local pPlayer = Players[iPlayer]
    local playerUnits = pPlayer:GetUnits()
    local cachedUnits = playerUnits:Members()
    for _, pCity in pPlayer:GetCities():Members() do
        local tOwnedPlots = pCity:GetOwnedPlots()
        for _, pPlot in ipairs(tOwnedPlots) do
            local iFeatureType = pPlot:GetFeatureType()
            if iFeatureType == iFEATURE_FOREST then
                TerrainBuilder.SetFeatureType(pPlot, -1)                -- does this work
                playerUnits:Create(iTREANT_INDEX, pPlot:GetX(), pPlot:GetY());
            elseif iFeatureType == iFEATURE_ANCIENT_FOREST then
                TerrainBuilder.SetFeatureType(pPlot, iFEATURE_FOREST)
                playerUnits:Create(iTREANT_INDEX, pPlot:GetX(), pPlot:GetY());
            end
        end
    end
    local tNewUnits
    for id, pUnit in pPlayer:GetUnits():Members() do
        if (not cachedUnits[id]) then
             pUnit:SetProperty('LifespanRemaining', 5)
        end
    end
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

local iMINE_INDEX = GameInfo.Improvements['IMPROVEMENT_MINE'].Index
local function MotherLode(iPlayer, tParameters)
	-- he Mother Lode spell provides your empire with 25 gold for each mine in your cultural borders.
	-- For each flatlands square you own (Grassland, Plains, Desert, Tundra, Ice), there is a 10% chance of it turning into a hill. This includes Flood Plains.
    local pPlayer = Players[iPlayer]
    local pPlayerImprovements = pPlayer:GetImprovements();
    local iMineCount = 0

    if pPlayerImprovements then
        local tImprovementLocations = pPlayerImprovements:GetImprovementPlots();
        for _, plotID in ipairs(tImprovementLocations) do
            local pPlot = Map.GetPlotByIndex(plotID);
            if pPlot then
                local eImprovement = pPlot:GetImprovementType();
                if (eImprovement == iMINE_INDEX) then
                    iMineCount = iMineCount + 1
                end
            end
        end
    end
    if iMineCount > 0 then
        pPlayer:GetTreasury():ChangeGoldBalance(iMineCount * 25)
    end
    local tFlatlands = {
                        [GameInfo.Terrains['TERRAIN_GRASS'].Index] = GameInfo.Terrains['TERRAIN_GRASS_HILLS'].Index,
                        [GameInfo.Terrains['TERRAIN_PLAINS'].Index] = GameInfo.Terrains['TERRAIN_PLAINS_HILLS'].Index,
                        [GameInfo.Terrains['TERRAIN_DESERT'].Index] = GameInfo.Terrains['TERRAIN_DESERT_HILLS'].Index,
                        [GameInfo.Terrains['TERRAIN_TUNDRA'].Index] = GameInfo.Terrains['TERRAIN_TUNDRA_HILLS'].Index,
                        [iSnowTerrain] = iSnowTerrainHills
    }
    -- section, converting flatlands to mountains
    local iThreshold = 90
    for _, pCity in pPlayer:GetCities():Members() do
        local tOwnedPlots = pCity:GetOwnedPlots()
        for _, pPlot in ipairs(tOwnedPlots) do
            local iCurrentTerrain = pPlot:GetTerrainType()
            local iNewTerrain = tFlatlands[iCurrentTerrain]
            if (iNewTerrain) and (math.random(100) > iThreshold) then           -- many rolls
                TerrainBuilder.SetTerrainType(pPlot, iNewTerrain)
            end
        end
    end
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end


local function ArcaneLacuna(iPlayer, tParameters)
	-- . Prevents all spells from being cast, spell casters, priests, demons, or even your world spell can't be used. Not including Amurites?
    -- count mana in empire
    local pPlayer = Players[iPlayer]
    local iExpToGrant = 0
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    if pCapitalCity then
        local pCapitalPlot = Map.GetPlot(pCapitalCity:GetX(), pCapitalCity:GetY())
        for sResourceName, iPromoIndex in pairs(tResourcePropKeys) do
            local iResource = pCapitalPlot:GetProperty(sResourceName) or 0;
            iExpToGrant = iExpToGrant + iResource
        end
    end
    for _, pUnit in pPlayer:GetUnits():Members() do
        local iUnitIndex = pUnit:GetType()
        if tArcaneUnits[iUnitIndex] then
            pUnit:GetExperience():ChangeExperience(iExpToGrant);
        end
    end
    -- give xp to each adept unit
    -- get delay amount based on speed
    local eGameSpeed = GameConfiguration.GetGameSpeedType()            -- this is actually a hash not a string return. But cant find the enum for it
    local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier
    local iDelay = 20 * iSpeedCostMultiplier
    Game:SetProperty('ARCANE_LACUNA_COUNTDOWN', iDelay)
    Game:SetProperty('ARCANE_LACUNA_CASTER', iPlayer)
    -- go through all spell units, set their castable to 0
    for iPlayerIndex, pOtherPlayer in ipairs(Players) do
        if iPlayerIndex ~= iPlayer then
            for _, pUnit in pOtherPlayer:GetUnits():Members() do
                if pUnit:GetProperty('HasCast') then
                    pUnit:SetProperty('HasCast', 1)
                end
            end
        end
    end
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end


local function ForTheHorde(iPlayer, tParameters)                -- TODO
	-- Convert half of the barbarians in the game to your control
    -- get barbarian units total
    -- get half that integer, iterate up to that point converting the units?
    -- converting is awkward, dll examples have been done with gifting.
    local pBarbPlayer = Players[63]
    local pBarbUnits = pBarbPlayer:GetUnits()
    local iBarbCount = pBarbUnits:GetCount()
    local iBarbsToConvert = math.ceil(iBarbCount / 2)
    local iIterCount = 0
    for iUnitID, pUnit in pBarbUnits:Members() do
        if iIterCount < iBarbsToConvert then
            if pUnit then
                local iUnitIndex = pUnit:GetType()
                local iHealth, iX, iY, tPromos, tAbilities = InheritUnitAttributes(iPlayer, iUnitID)
                pUnit:ChangeDamage(100);
                if pUnit:GetDamage() >= 100 then
                    UnitManager.Kill(pUnit, false);
                end
                local tNewUnits = SimpleSummon(iX, iY, iPlayer, iUnitIndex)
                ApplyAttributes(tNewUnits, tPromos, tAbilities, iHealth)
            end
            iIterCount = iIterCount + 1
        end
    end
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty(sWorldSpellPropKey, 0)
end

local tAllowSphereOne = {
    [iMANA_AIR_INDEX]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED'].Index,
    [iMANA_BODY_INDEX]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED'].Index,
    [iMANA_CHAOS_INDEX]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED'].Index,
    [iMANA_DEATH_INDEX]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED'].Index,
    [iMANA_EARTH_INDEX]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED'].Index,
    [iMANA_ENCHANTMENT_INDEX]        =    GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED'].Index,
    [iMANA_ENTROPY_INDEX]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED'].Index,
    [iMANA_FIRE_INDEX]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED'].Index,
    [iMANA_LAW_INDEX]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED'].Index,
    [iMANA_LIFE_INDEX]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED'].Index,
    [iMANA_METAMAGIC_INDEX]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED'].Index,
    [iMANA_MIND_INDEX]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED'].Index,
    [iMANA_NATURE_INDEX]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED'].Index,
    [iMANA_SHADOW_INDEX]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED'].Index,
    [iMANA_SPIRIT_INDEX]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED'].Index,
    [iMANA_SUN_INDEX]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED'].Index,
    [iMANA_WATER_INDEX]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED'].Index
}
local tAllowSphereTwo = {
    [iMANA_AIR_INDEX]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_2'].Index,
    [iMANA_BODY_INDEX]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_2'].Index,
    [iMANA_CHAOS_INDEX]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_2'].Index,
    [iMANA_DEATH_INDEX]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index,
    [iMANA_EARTH_INDEX]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_2'].Index,
    [iMANA_ENCHANTMENT_INDEX]=    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index,
    [iMANA_ENTROPY_INDEX]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_2'].Index,
    [iMANA_FIRE_INDEX]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_2'].Index,
    [iMANA_LAW_INDEX]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_2'].Index,
    [iMANA_LIFE_INDEX]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_2'].Index,
    [iMANA_METAMAGIC_INDEX]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_2'].Index,
    [iMANA_MIND_INDEX]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_2'].Index,
    [iMANA_NATURE_INDEX]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_2'].Index,
    [iMANA_SHADOW_INDEX]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_2'].Index,
    [iMANA_SPIRIT_INDEX]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_2'].Index,
    [iMANA_SUN_INDEX]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_2'].Index,
    [iMANA_WATER_INDEX]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_2'].Index
}

local tAllowSphereThree = {
    [iMANA_AIR_INDEX]        =    GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_3'].Index,
    [iMANA_BODY_INDEX]        =    GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_3'].Index,
    [iMANA_CHAOS_INDEX]        =    GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_3'].Index,
    [iMANA_DEATH_INDEX]        =    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index,
    [iMANA_EARTH_INDEX]        =    GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_3'].Index,
    [iMANA_ENCHANTMENT_INDEX]=    GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index,
    [iMANA_ENTROPY_INDEX]        =    GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_3'].Index,
    [iMANA_FIRE_INDEX]        =    GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_3'].Index,
    [iMANA_LAW_INDEX]        =    GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_3'].Index,
    [iMANA_LIFE_INDEX]        =    GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_3'].Index,
    [iMANA_METAMAGIC_INDEX]        =    GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_3'].Index,
    [iMANA_MIND_INDEX]        =    GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_3'].Index,
    [iMANA_NATURE_INDEX]        =    GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_3'].Index,
    [iMANA_SHADOW_INDEX]        =    GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_3'].Index,
    [iMANA_SPIRIT_INDEX]        =    GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_3'].Index,
    [iMANA_SUN_INDEX]        =    GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_3'].Index,
    [iMANA_WATER_INDEX]        =    GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_3'].Index
}
local function UpdateResourcePromotion(iPlayer, tParameters)
    local iResource = tParameters.ResourceID
    local pPlayer = Players[iPlayer]
    local iChanOneGrant = tAllowSphereOne[iResource]
    local iChanTwoGrant = tAllowSphereTwo[iResource]
    local iChanThreeGrant = tAllowSphereTwo[iResource]
    for _, unit in pPlayer:GetUnits():Members() do
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

-- world spells
GameEvents.SlthOnRally.Add(Rally);
GameEvents.SlthOnReligiousFervor.Add(ReligiousFervor);
GameEvents.SlthOnSanctuary.Add(Sanctuary);
GameEvents.SlthOnLegends.Add(Legends);
GameEvents.SlthOnMarchOfTheTrees.Add(MarchOfTheTrees);
GameEvents.SlthOnMotherLode.Add(MotherLode);
GameEvents.SlthOnIntoTheMist.Add(IntoTheMist);
GameEvents.SlthOnRagingSeas.Add(RagingSeas);
GameEvents.SlthOnArdor.Add(Ardor);
GameEvents.SlthOnWarCry.Add(WarCry);
GameEvents.SlthOnArcaneLacuna.Add(ArcaneLacuna);
GameEvents.SlthOnWildHunt.Add(WildHunt);
GameEvents.SlthOnRevelry.Add(Revelry);
GameEvents.SlthOnGiftsOfNantosuelta.Add(GiftsOfNantosuelta);
GameEvents.SlthOnForTheHorde.Add(ForTheHorde);
GameEvents.SlthOnVeilOfNight.Add(VeilOfNight);
GameEvents.SlthOnRiverOfBlood.Add(RiverOfBlood);
GameEvents.SlthOnWorldBreak.Add(WorldBreak);
GameEvents.SlthOnStasis.Add(Stasis);
GameEvents.SlthOnDivineRetribution.Add(DivineRetribution);
GameEvents.SlthOnHyboremsWhisper.Add(HyboremsWhisper);

onStart()
