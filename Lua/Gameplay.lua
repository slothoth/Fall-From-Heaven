local FreeXPUnits = { SLTH_UNIT_ADEPT = 1, SLTH_UNIT_IMP = 1, SLTH_UNIT_SHAMAN = 1, SLTH_UNIT_ARCHMAGE = 2, SLTH_UNIT_EATER_OF_DREAMS = 2,
                      SLTH_UNIT_CORLINDALE = 2, SLTH_UNIT_DISCIPLE_OF_ACHERON = 1, SLTH_UNIT_GAELAN = 1.5, SLTH_UNIT_GIBBON = 2,
                      SLTH_UNIT_GOVANNON = 2, SLTH_UNIT_HEMAH = 2, SLTH_UNIT_LICH = 2, SLTH_UNIT_ILLUSIONIST = 1.5, SLTH_UNIT_MAGE = 1.5,
                      SLTH_UNIT_WIZARD = 1.5, SLTH_UNIT_MOBIUS_WITCH = 1.5, SLTH_UNIT_MOKKA = 1.5, SLTH_UNIT_SON_OF_THE_INFERNO = 2}

TrackedResources = {}
for resourceType, resourceClass in pairs({RESOURCE_MANA_DEATH='MANA', RESOURCE_MANA_FIRE='MANA',
RESOURCE_MANA_AIR='MANA', RESOURCE_MANA_BODY='MANA', RESOURCE_MANA_CHAOS='MANA', RESOURCE_MANA_EARTH='MANA',
                                          RESOURCE_MANA_ENCHANTMENT='MANA', RESOURCE_MANA_ENTROPY='MANA',
                                          RESOURCE_MANA_ICE='MANA', RESOURCE_MANA_LAW='MANA',  RESOURCE_MANA_LIFE='MANA',
RESOURCE_MANA_METAMAGIC='MANA', RESOURCE_MANA_MIND='MANA',  RESOURCE_MANA_NATURE='MANA',  RESOURCE_MANA_SPIRIT='MANA',
RESOURCE_MANA_WATER='MANA',  RESOURCE_MANA_SUN='MANA',  RESOURCE_MANA_SHADOW='MANA'}) do
    local resource = GameInfo.Resources[resourceType]
    if resource then
        TrackedResources[resource.Name] = resource
    end
end

function SlthLog(sMessage)
    SLTH_DEBUG_ON = nil
    if SLTH_DEBUG_ON then
        print(sMessage)
    end
end

function GrantXP(playerId)
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
        print(ImprovementBuilder)
        print(ImprovementBuilder.SetImprovementType)
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
	if not resourceIndex == GameInfo.Resources['RESOURCE_MANA'].Index then return; end
    local iResourceToChangeTo = tManaNodeMapper[improvementIndex]
    print(iResourceToChangeTo)
    if not iResourceToChangeTo then return; end
    print('changing resource to ' .. tostring(iResourceToChangeTo))
    ResourceBuilder.SetResourceType(pPlot, iResourceToChangeTo, 1);
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

function UpdateResourceAvailability(ownerPlayerID,resourceTypeID)
    print(resourceUTypeID)
    local iResourceIndex = tMonitoredStrategic[resourceTypeID]
    if iResourceIndex then
        local pPlayer = Players[ownerPlayerID];
        local resources = pPlayer:GetResources()
        local iResourceCount = resources:GetResourceAmount(iResourceIndex);
        local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
        local pCapitalPlot = pCapitalCity:GetPlot()
        local sPropKey = 'has_resource_' + tostring(iResourceIndex)
        local iPastResource = pCapitalPlot:GetProperty(sPropKey)
        if iResourceCount ~= iPastResource then
            pCapitalPlot:SetProperty(sPropKey, iResourceCount)
        end
    end
end

function EventCollapse(x, y)
    local pPlot = Map.GetPlot(x, y)
    local tUnits = Map.GetUnitsAt(pPlot)
    for idx, pUnit in tUnits do
        pUnit:ChangeDamage(20)
        if pUnit:GetDamage() < 1 then           -- is it at 0 or at 100?
            UnitManager.Kill(pUnit)
        end
    end
end

tTribeDeck = {TRIBE_CLAN_SCORPION = 1, TRIBE_CLAN_SKELETON = {[1]=EventCollapse},
              TRIBE_CLAN_LIZARDMEN = {[1]=EventCollapse}}
function RemovedBarbCamp(x, y, owningPlayerID)
    print('Owning playerID is ' .. tostring(owningPlayerID))
    -- hopefully this is unneeded
    local pPlot = Map.GetPlot(x, y)
    local owner = pPlot:GetOwner()
    print('Plot owner is ' .. tostring(owner))
    if not owningPlayerID then
        -- draw from deck of events
        local pBarbarianManager  = Game.GetBarbarianManager();
	    local tribeIndex = pBarbarianManager:GetTribeIndexAtLocation(x, y);
        local tribeType = pBarbarianManager:GetTribeType(tribeIndex)
        local tTribeEvents = tTribeDeck['tribeType']            --TRIBE_CLAN_SKELETON
        local lengthTribeEvents = table.count(tTribeEvents)
        local dice_roll = math.random(1, lengthTribeEvents)
        local fEvent = tTribeEvents[dice_roll]
        fEvent(x, y)
        -- do event. Sometimes we reinstantiate barb camp
    end
end

-- Great general on Mil Strategy
-- Great Bard on Drama
-- there are others im pretty sure
-- function OnTechnologyGrantFirst()  end

-- function OnCivicGrantFirst() end

function onStart()
    tImprovementsProgression = {
        [GameInfo.Improvements['IMPROVEMENT_COTTAGE'].Index]        = GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index,
        [GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index]         = GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index]        = GameInfo.Improvements['IMPROVEMENT_TOWN'].Index,
        [GameInfo.Improvements['IMPROVEMENT_TOWN'].Index]           = GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_PIRATE_COVE'].Index]    = GameInfo.Improvements['IMPROVEMENT_PIRATE_HARBOR'].Index,
        [GameInfo.Improvements['IMPROVEMENT_PIRATE_HARBOR'].Index]  = GameInfo.Improvements['IMPROVEMENT_FEITORIA'].Index}
    tImprovementsRegression = {
        [GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index]         = GameInfo.Improvements['IMPROVEMENT_COTTAGE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index]        = GameInfo.Improvements['IMPROVEMENT_HAMLET'].Index,
        [GameInfo.Improvements['IMPROVEMENT_TOWN'].Index]           = GameInfo.Improvements['IMPROVEMENT_VILLAGE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index]        = GameInfo.Improvements['IMPROVEMENT_TOWN'].Index,
        [GameInfo.Improvements['IMPROVEMENT_PIRATE_HARBOR'].Index]  = GameInfo.Improvements['IMPROVEMENT_PIRATE_COVE'].Index,
        [GameInfo.Improvements['IMPROVEMENT_FEITORIA'].Index]       = GameInfo.Improvements['IMPROVEMENT_PIRATE_HARBOR'].Index}
    tImprovementsCivProgression = {
        [GameInfo.Improvements['IMPROVEMENT_TOWN'].Index]           = GameInfo.Improvements['IMPROVEMENT_ENCLAVE'].Index}


    tManaNodeMapper = {
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
    GameEvents.PlayerTurnStarted.Add(GrantXP);
    -- GameEvents.PlayerTurnStarted.Add(checkDeals);

    Events.ImprovementChanged.Add(ImprovementsWorkOrPillageChange)
    Events.ImprovementAddedToMap.Add(InitCottage)
    GameEvents.PlayerTurnStarted.Add(IncrementCottages);

    Events.PlayerResourceChanged.Add(UpdateResource)

    -- Events.CivicCompleted.Add(OnCivicGrantFirst)
    -- Events.ResearchCompleted.Add(OnTechnologyGrantFirst)
    Events.ImprovementRemovedFromMap.Add(RemovedBarbCamp)           -- doesnt work
end

onStart()

