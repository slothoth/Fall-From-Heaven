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

function SlthLog(sMessage)
    SLTH_DEBUG_ON = nil
    if SLTH_DEBUG_ON then
        print(sMessage)
    end
end

function onTurnStartGameplay(playerId)
    local pPlayer = Players[playerId];
    for i, unit in pPlayer:GetUnits():Members() do
        local iUnitIndex = unit:GetType();
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
    -- update altars. done so all luonnotars arent granted at once
    for idx, pCity in pPlayer:GetCities():Members() do
        local sLuonnotarDummyModifier = pCity:GetProperty('luonnotar_dummy')
        if sLuonnotarDummyModifier then
            print('player turn started: and city valid for next altar. attaching:')
            print(sLuonnotarDummyModifier)
            pCity:AttachModifierByID(sLuonnotarDummyModifier)
            print('player turn started: removed blocker')
            return
        end
    end
end

function checkDeals(playerId)
    pPlayer = Players[playerId]
    if not pPlayer:IsMajor() then return; end;
    tLivingMajorIds = PlayerManager.GetAliveMajorIDs();
    table.remove(tLivingMajorIds, playerId);
    local tResourceExportImport = {}
    local length_prev_deals = 0
    for _, otherPlayerId in ipairs(tLivingMajorIds) do
        local deals = DealManager.GetPlayerDeals(playerId,otherPlayerId) -- [1]:FindItemByID(2):()
        local previous_deals = pPlayer:GetProperty('deals_' .. otherPlayerId)
        if not previous_deals then
            previous_deals = {};
        else
            length_prev_deals = #previous_deals
        end
        if deals then
            if length_prev_deals ~= #deals then
                for idx, deal in ipairs(deals) do
                    if deal ~= previous_deals[idx] then
                        for dealItem in deal:Items() do
                            local resource_name = dealItem:GetValueTypeNameID();
                            if resource_name then
                                local resource_row = TrackedResources[resource_name]
                                if resource_row then
                                    if not dealItem:GetFromPlayerID() == playerId then
                                        local resourceChange = dealItem:GetAmount()
                                        SlthLog('hit');
                                        SlthLog(resource_name)
                                        local existing = 0;
                                        if tResourceExportImport[resource_row.ResourceType] then
                                            existing = tResourceExportImport[resource_row.ResourceType]
                                        end
                                        tResourceExportImport[resource_name] = existing + resourceChange
                                    end
                                end
                                SlthLog(resource_name);
                            end
                        end
                    end
                end
            end
            pPlayer:SetProperty('deals_' .. otherPlayerId, deals)
        end
    end
    SlthLog('finally:')
    SlthLog(#tResourceExportImport);
    for rsc_name, rsc_amount in pairs(tResourceExportImport) do
        SlthLog(rsc_name);
        SlthLog(rsc_amount);
        pPlayer:SetProperty(rsc_name, rsc_amount);
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
    print('Resource Index: ' .. tostring(resourceIndex))
    print('Mana Resource Index: ' .. tostring(MANA_INDEX))
	if resourceIndex == MANA_INDEX then
        local iResourceToChangeTo = tManaNodeMapper[improvementIndex]
        if iResourceToChangeTo then
            print('changing resource to ' .. tostring(iResourceToChangeTo))
            ResourceBuilder.SetResourceType(pPlot, iResourceToChangeTo, 1);
        end
    end
    print(improvementIndex)
    if improvementIndex then
        local tUnits = Map.GetUnitsAt(pPlot)
        for pUnit in tUnits:Units() do
            local iUnitIndex = pUnit:GetType()
            print(iUnitIndex)
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
                ImprovementBuilder.SetImprovementType(pPlot, iImprovementUpgradedIndex, playerId)
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
        for idx, pCity in pPlayer:GetCities():Members() do
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
        for idx, pCity in pPlayerCities:Members() do
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
end

function onStart()
    GameEvents.PlayerTurnStarted.Add(onTurnStartGameplay);
    -- GameEvents.PlayerTurnStarted.Add(checkDeals);

    Events.ImprovementChanged.Add(ImprovementsWorkOrPillageChange)
    Events.ImprovementAddedToMap.Add(InitCottage)
    GameEvents.PlayerTurnStarted.Add(IncrementCottages);

    -- Events.PlayerResourceChanged.Add(UpdateResource)                 -- NOT WORKING AND causing errors

    Events.CivicCompleted.Add(OnCivicGrantFirst)
    -- Events.ResearchCompleted.Add(OnTechnologyGrantFirst)
    Events.ImprovementRemovedFromMap.Add(RemovedBarbCamp)           -- doesnt work
    GameEvents.BuildingConstructed.Add(BuildingBuilt)
    Events.UnitGreatPersonActivated.Add(onGreatPersonActivated)
    InitializeClans()
    print('-----------------Gameplay loaded')
end

local function SetCapitalProperty(iPlayer: number, tParameters: table)
    local sPropKey = tParameters.sPropKey;
    local iPropValue = tParameters.iPropValue;
    local pPlayer = Players[iPlayer];
    local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
    local pCapitalPlot = pCapitalCity:GetPlot()
    pCapitalPlot:SetProperty(sPropKey, iPropValue)
end

GameEvents.SlthSetCapitalProperty.Add(SetCapitalProperty);

onStart()

