include('SpawnSupport')

local tGameSpeedScalings = {GAMESPEED_ONLINE= 1,
                            GAMESPEED_QUICK= 2,
                            GAMESPEED_STANDARD= 3,
                            GAMESPEED_EPIC= 4,
                            GAMESPEED_MARATHON= 5
}

local tBarbNW = {
	[GameInfo.Features['FEATURE_UBSUNUR_HOLLOW'].Index] = 1,
	[GameInfo.Features['FEATURE_NWON_BRADELINES_WELL'].Index] = 1,
	[GameInfo.Features['FEATURE_DELICATE_ARCH'].Index] = 1,
	[GameInfo.Features['FEATURE_YOSEMITE'].Index] = 1}

local TRIBE_CLAN_SCORPION = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_OPEN'].Index
local TRIBE_CLAN_SKELETON = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_HILLS'].Index
local TRIBE_CLAN_LIZARDMEN = GameInfo.BarbarianTribes['TRIBE_CLAN_MELEE_FOREST'].Index

iFEATURE_FOREST = GameInfo.Features['FEATURE_FOREST'].Index
iSnowTerrain = GameInfo.Terrains['TERRAIN_SNOW'].Index
iSnowTerrainHills = GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index

iTREANT_INDEX = GameInfo.Units['SLTH_UNIT_TREANT'].Index

local iNotifType = NotificationTypes.USER_DEFINED_2;                -- TODO make barb one instead?

function addToTableOrMake(tbl, sText, entry)
    if not tbl[sText] then
        tbl[sText] = {}
    end
    table.insert(tbl[sText], entry)
    return tbl[sText]
end

tLairUnitIndices = {}
tLairUnits = {}
for row in GameInfo.LairUnits() do
    local unitInfo = GameInfo.Units[row.UnitType]
    local iUnitIndex = unitInfo.Index
    tLairUnitIndices[row.UnitType] = unitInfo
    tLairUnitIndices[iUnitIndex] = unitInfo
    if row.BigBadWaterLeader == 1 then
        tLairUnits['BigBadWaterLeader'] = addToTableOrMake(tLairUnits, 'BigBadWaterLeader',iUnitIndex)
    end
    if row.BigBadWaterHench == 1 then
        tLairUnits['BigBadWaterHench'] = addToTableOrMake(tLairUnits, 'BigBadWaterHench',iUnitIndex)
    end
    if row.BigBadFailedGraceWaterLeader == 1 then
        tLairUnits['BigBadFailedGraceWaterLeader'] = addToTableOrMake(tLairUnits, 'BigBadFailedGraceWaterLeader',iUnitIndex)
    end
    if row.BigBadFailedGraceWaterHench == 1 then
        tLairUnits['BigBadFailedGraceWaterHench'] = addToTableOrMake(tLairUnits, 'BigBadFailedGraceWaterHench',iUnitIndex)
    end
    if row.BigBadLeader == 1 then
        tLairUnits['BigBadLeader'] = addToTableOrMake(tLairUnits, 'BigBadLeader',iUnitIndex)
    end
    if row.BigBadHench == 1 then
        tLairUnits['BigBadHench'] = addToTableOrMake(tLairUnits, 'BigBadHench',iUnitIndex)
    end
    if row.BigBadFailedGraceLeader == 1 then
        tLairUnits['BigBadFailedGraceLeader'] = addToTableOrMake(tLairUnits, 'BigBadFailedGraceLeader',iUnitIndex)
    end
    if row.BigBadFailedGraceHench == 1 then
        tLairUnits['BigBadFailedGraceHench'] = addToTableOrMake(tLairUnits, 'BigBadFailedGraceHench',iUnitIndex)
    end
    if row.SnowHenchMan == 1 then
        tLairUnits['SnowHenchMan'] = addToTableOrMake(tLairUnits, 'SnowHenchMan',iUnitIndex)
    end
    if row.ArmaLeaders == 1 then
        tLairUnits['ArmaLeaders'] = addToTableOrMake(tLairUnits, 'ArmaLeaders',iUnitIndex)
    end
    if row.ArmaHench == 1 then
        tLairUnits['ArmaHench'] = addToTableOrMake(tLairUnits, 'ArmaHench',iUnitIndex)
    end
    if row.Barrow == 1 then
        tLairUnits['Barrow'] = addToTableOrMake(tLairUnits, 'Barrow',iUnitIndex)
    end
    if row.Ruins == 1 then
        tLairUnits['Ruins'] = addToTableOrMake(tLairUnits, 'Ruins',iUnitIndex)
    end
    if row.BarrowFailedGrace == 1 then
        tLairUnits['BarrowFailedGrace'] = addToTableOrMake(tLairUnits, 'BarrowFailedGrace',iUnitIndex)
    end
    if row.RuinsFailedGrace == 1 then
        tLairUnits['RuinsFailedGrace'] = addToTableOrMake(tLairUnits, 'RuinsFailedGrace',iUnitIndex)
    end
    if row.BigBadForestedFailedGraceLeader == 1 then
        tLairUnits['BigBadForestedFailedGraceLeader'] = addToTableOrMake(tLairUnits, 'BigBadForestedFailedGraceLeader',iUnitIndex)
    end
end

local tBarbMapper = {[TRIBE_CLAN_SKELETON]='Ruins', [TRIBE_CLAN_LIZARDMEN]= 'Barrow'}
local tBarbGraceMapper = {[TRIBE_CLAN_SKELETON]='BarrowFailedGrace', [TRIBE_CLAN_LIZARDMEN]= 'RuinsFailedGrace'}


local iGameSpeed
function setGameSpeed()
    local hash_GameSpeed = GameConfiguration.GetGameSpeedType()
    local name_GameSpeed = GameInfo.GameSpeeds[hash_GameSpeed].GameSpeedType
    iGameSpeed = tGameSpeedScalings[name_GameSpeed]
end
function getGameSpeed()
    if not iGameSpeed then
        setGameSpeed()
    end
    return iGameSpeed
end

local tUndeadUnits = {}
for row in GameInfo.UnitsNotAlive() do
    tUndeadUnits[row.UnitType] = row.Race
end

function lairRoll(pPlot, pUnit)
    pPlot:SetProperty('DisperseCamp', nil)
    local iFeatureType = pPlot:GetFeatureType()
    local bIsWater = pPlot:IsWater()
    local tribeIndex = pPlot:GetProperty('barbclantype') or 1             -- or logic, unsure why
    local iDiceRoll = math.random(100)
    local iThreshold
    local bGraceFailed
    local iGrace = 20 * getGameSpeed()
    local iUnitOwner = pUnit:GetOwner()                 -- assume causer is pUnit owner
    local iDifficultyHash = PlayerConfigurations[iUnitOwner]:GetHandicapTypeID()
    local iPlayerDifficulty = GameInfo.Difficulties[iDifficultyHash].Index
    -- print('difficulty and amount', GameInfo.Difficulties[iDifficultyHash].DifficultyType, iPlayerDifficulty)
    local iDiff =  7 - iPlayerDifficulty        -- converted from python gc.getNumHandicapInfos() + 1 - int(gc.getGame().getHandicapType())
    iGrace = iGrace * iDiff
    print('grace is..', iGrace)
    iGrace = math.random(iGrace) + iGrace
    bGraceFailed = iGrace < Game.GetCurrentGameTurn()     -- if grace fails, we can get baaaad outcomes
    if tBarbNW[iFeatureType] then
        if iDiceRoll < 54 then
            BigBadGroupSpawn(pPlot, pUnit, bGraceFailed, tribeIndex, iFeatureType, bIsWater)
        else
            doBigGood(pPlot, bGraceFailed, pUnit, bIsWater)
        end
        print('spawning tribe because natural wonder exists on plot, superlair')
        spawnTribeSafe(pPlot:GetIndex(), tribeIndex)
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
            print('spawning tribe, as failed destroy dice roll')
            spawnTribeSafe(pPlot:GetIndex(), tribeIndex)
        else
            print('not respawning barb camp')
        end
    end
end

-- small events
local function onLairTreasureVault(pUnit, pPlot, sEventInfo)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    pPlayer:GetTreasury():ChangeGoldBalance(1000)
end

local function onGrantResource(pUnit, pPlot, sEventInfo)
    local iResourceIndex = GameInfo.Resources[sEventInfo].Index
    WorldBuilder.MapManager():SetResourceType(pPlot, iResourceIndex, 1)
end

local function onGrantItem(pUnit, pPlot, sEventInfo)
    local sAbility = sEventInfo .. '_ABILITY'
    local pUnitAbilities = pUnit:GetAbility()
    if pUnitAbilities:CanHaveAbility(sAbility) then
        if pUnitAbilities:HasAbility(sAbility) then
            local iPlayer = pUnit:GetOwner()
            local pPlayer = Players[iPlayer]
            local playerUnits = pPlayer:GetUnits()
            local iX, iY = pUnit:GetX(), pUnit:GetY()
            local iUnitIndex = tLairUnitIndices[sEventInfo].Index
            playerUnits:Create(iUnitIndex, iX, iY); -- spawn the unit version
        else
            pUnitAbilities:AddAbilityCount(sAbility)
        end
    end
end

local function onSpawnBarb(pUnit, pPlot, sUnitType)
    local pBarbPlayer = Players[63]
    local barbUnits = pBarbPlayer:GetUnits();
    local tUnitInfo =  tLairUnitIndices[sUnitType]
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

local function onLairGrantGold(pUnit, pPlot, sEventInfo)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    pPlayer:GetTreasury():ChangeGoldBalance(200)                -- should scale this by speed possibly
end

local function OnLairGrantExperience(pUnit, pPlot, sEventInfo)
    local pUnitExp = pUnit:GetExperience()
    pUnitExp:ChangeExperience(30)
end

local function onLairGrantAbility(pUnit, pPlot, sEventInfo)
    local pUnitAbilities = pUnit:GetAbility()
    pUnitAbilities:AddAbilityCount(sEventInfo)
end

local function onGrantUnit(pUnit, pPlot, sUnitType)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    local iUnitIndex = tLairUnitIndices[sUnitType].Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    SimpleSummon(iX, iY, iPlayer, iUnitIndex)
end

local function onGrantGreatUnit(pUnit, pPlot, sUnitType)
    local iPlayer = pUnit:GetOwner()
    local pPlayer = Players[iPlayer]
    local iUnitIndex = tLairUnitIndices[sUnitType].Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    SimpleSummon(iX, iY, iPlayer, iUnitIndex)
end

local function onLairNothing(pUnit, pPlot, sEventInfo)
    print('roll failed')
end

local function onLairKill(pUnit, pPlot, sEventInfo)
    UnitManager.Kill(pUnit)
end

local function onLairCollapse(pUnit, pPlot, sEventInfo)
    local iDamageDealt = math.random(50, 90)
    pUnit:ChangeDamage(iDamageDealt)
    if pUnit:GetDamage() < 1 then
        UnitManager.Kill(pUnit)
    end
end

local function onSpawnBadScorpion(pUnit, pPlot, sEventInfo)
    local pBarbPlayer = Players[63]
    local barbUnits = pBarbPlayer:GetUnits();
    local tUnitInfo =  tLairUnitIndices['SLTH_UNIT_SCORPION'].Index
    local iUnitIndex = tUnitInfo.Index
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    local bSuccess = DisplaceUnits(pPlot, pUnit, iX, iY)
    if not bSuccess then return; end
    barbUnits:Create(iUnitIndex, iX, iY);
    barbUnits:Create(iUnitIndex, iX, iY);
    barbUnits:Create(iUnitIndex, iX, iY);
end

local function onLairGoldenAge(pUnit, pPlot, sEventInfo)
    local playerID = pUnit:GetOwner()
    GoldenAgeGrant(playerID,10)
end

local function onLairGrantDemonic(pUnit, pPlot, sEventInfo)
    local pUnitAbilities = pUnit:GetAbility()
    pUnitAbilities:AddAbilityCount('BUFF_CRAZED')
    pUnitAbilities:AddAbilityCount('BUFF_ENRAGED')
    pUnitAbilities:AddAbilityCount('DEMON_ABILITY_HELL_TERRAIN_STRENGTH')
end

local function onFarTreasure(pUnit, pPlot, sUnitType)
    local pBarbPlayer = Players[63]
    local tUnitInfo =  tLairUnitIndices[sUnitType]
    if not tUnitInfo then
        print('ERROR. No info for :' .. sUnitType)
        return;
    end
    local iUnitIndex = tUnitInfo.Index
    local tEligiblePlots = ViableWildernessPlots()
    local iNumEligiblePlots = table.count(tEligiblePlots)
    if iNumEligiblePlots > 0 then
        local iRandomEligiblePlotsPosition = Game.GetRandNum((iNumEligiblePlots + 1) - 1, 'RNG_barb_placement') + 1
        local spawnPlot = eligiblePlots[iRandomEligiblePlotsPosition]
        local iX, iY = spawnPlot:GetX(), spawnPlot:GetY()
        UnitManager.InitUnitValidAdjacentHex(63, iUnitIndex, iX, iY);
        local iPlotIndex = Map.GetPlot(iX, iY):GetIndex();
        local pCurPlayerVisibility = PlayersVisibility[pUnit:GetOwner()]
        pCurPlayerVisibility:ChangeVisibilityCount(iPlotIndex, 1);          -- grant vision for it
    end
end

local function SLTH_Todo(pUnit, pPlot, sEventInfo)
    print('placeholder')
end

local tLairEvents = {onLairKill= onLairKill, onLairCollapse= onLairCollapse, onLairGrantAbility = onLairGrantAbility, SLTH_Todo = SLTH_Todo,
               onSpawnBarb = onSpawnBarb, onGrantUnit = onGrantUnit, onGrantGreatUnit = onGrantGreatUnit,
               onGrantItem = onGrantItem, onGrantResource = onGrantResource, onLairNothing = onLairNothing,
               onLairGrantGold = onLairGrantGold, OnLairGrantExperience = OnLairGrantExperience,
               onLairTreasureVault = onLairTreasureVault, onSpawnBadScorpion = onSpawnBadScorpion,
               onLairGoldenAge=onLairGoldenAge, onLairGrantDemonic=onLairGrantDemonic, onFarTreasure=onFarTreasure}
local tLairs = {}
for row in GameInfo.Lairs() do
    row.CallbackString = row.Callback
    row.Callback = tLairEvents[row.Callback]
    if not row.Callback then
        print('couldnt find lair callback!', row.CallbackString)
    end
    tLairs[row.LairType] = row
    local unitInfo = GameInfo.Units[row.SimpleText]
    if unitInfo then
        tLairUnitIndices[unitInfo.UnitType] = unitInfo
        tLairUnitIndices[unitInfo.Index] = unitInfo
    end
end


function BigBadGroupSpawn(pPlot, pUnit, bGraceFailed, iBarbClanType, iFeatureType, bIsWater)
    local leaderTable, henchTable, iPlayer
    local iChosenLeaderIndex, iChosenLeader, iChosenHenchIndex, iChosenHench
    local playerUnits = Players[63]:GetUnits();
    local iX = pPlot:GetX()
    local iY = pPlot:GetY()
    if bIsWater then
        if bGraceFailed then
            leaderTable = tLairUnits['tBigBadFailedGraceWaterLeader']
            henchTable = tLairUnits['tBigBadFailedGraceWaterHench']
        else
            leaderTable = tLairUnits['tBigBadWaterLeader']
            henchTable = tLairUnits['tBigBadWaterHench']
        end
    else
        if bGraceFailed then
            leaderTable = tLairUnits['tBigBadFailedGraceLeader']
            if iFeatureType == g_Feature_FOREST then                             -- maybe should include ancient forest too
                table.insert(leaderTable, iTREANT_INDEX)
            end
            henchTable = tLairUnits['tBigBadFailedGraceHench']
            print('failed grace leaders and henchman')
        else
            print('didnt fail grace, leaders and henchman')
            leaderTable = tLairUnits['tBigBadLeader']
            henchTable = tLairUnits['tBigBadHench']
            local iTerrain = pPlot:GetTerrainType()
            if (iTerrain == iSnowTerrain) or (iTerrain == iSnowTerrainHills) then
                henchTable = SlthAppend(henchTable, tLairUnits['tSnowHenchMan'])
            end
            local sBarbMap = tBarbMapper[iBarbClanType]
            local tExtras = tLairUnits[sBarbMap]
            if tExtras then
                henchTable = SlthAppend(henchTable, tExtras)
                if bGraceFailed then
                    sBarbMap = tBarbGraceMapper[iBarbClanType]
                    tExtras = tLairUnits[sBarbMap]
                    if tExtras then
                        henchTable = SlthAppend(henchTable, tExtras)
                    end
                end
            end
            if Game:GetProperty('ARMAGEDDON') > 40 then
                leaderTable = SlthAppend(leaderTable,tLairUnits['tArmaLeaders'])
                henchTable = SlthAppend(henchTable,tLairUnits['tArmaHench'])
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
    local sTitle = 'LOC_NOTIFICATION_LAIR_BIGBAD_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_BIGBAD_DESCRIPTION'
    if pUnit then
        iPlayer = pUnit:GetOwner()
    else
        iPlayer = pPlot:GetOwner()
    end
    if iPlayer then
        NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    end
    -- seems like promo list gives a random promo from the list to the leader, TODO
end


function doBad(pPlot, iBarbClanType, pUnit, bIsWater)
    local tPossible = {'COLLAPSE'}
    if pUnit then
        local pUnitExp = pUnit:GetExperience()
        if pUnitExp:GetExperienceForNextLevel() == 15 then
            table.insert(tPossible, 'DEATH')
        end
        local iUnitIndex = pUnit:GetType()
        local exploringUnitInfo = GameInfo.Units[iUnitIndex]
        local sUnitName = exploringUnitInfo.UnitType
        if not tUndeadUnits[sUnitName] then
            tPossible = SlthAppend(tPossible, {'CRAZED', 'DEMONIC_POSSESSION', 'DISEASED', 'ENRAGED',
                                               'PLAGUED', 'POISONED', 'WITHERED'})
        end
        local sPromoClass = exploringUnitInfo.PromotionClass
        if sPromoClass == 'PROMOTION_CLASS_MELEE' then
            table.insert(tPossible, 'RUSTED')
        end
    end
    if bIsWater then
        tPossible = SlthAppend(tPossible, {'SPAWN_DROWN', 'SPAWN_SEA_SERPENT'})
    else
        tPossible = SlthAppend(tPossible, {'SPAWN_SPIDER', 'SPAWN_SPECTRE'})
    end
    if iBarbClanType == TRIBE_CLAN_SCORPION then
        tPossible = SlthAppend(tPossible, {'SPAWN_SCORPION_BAD', 'SPAWN_SCORPION_BAD', 'SPAWN_SCORPION_BAD'})
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local lairInfo = tLairs[sEvent]
    local fEvent = lairInfo.Callback
    local sUnitType = lairInfo.SimpleText
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pUnit:GetX(), pUnit:GetY()
    local iPlayer = pUnit:GetOwner()
    NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    return lairInfo.LairDestroyChance
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
    if pUnit then
        local iUnitIndex = pUnit:GetType()
        local exploringUnitInfo = GameInfo.Units[iUnitIndex]
        local sUnitName = exploringUnitInfo.UnitType
        if not tUndeadUnits[sUnitName] then
            if not pUnit:GetAbility():HasAbility('BUFF_MUTATED') then           -- todo add buff mutated.
                table.insert(tPossible, 'MUTATED')
            end
        end
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local lairInfo = tLairs[sEvent]
    local fEvent = lairInfo.Callback
    local sUnitType = lairInfo.SimpleText
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pPlot:GetX(), pPlot:GetY()
    if pUnit then
        local iPlayer = pUnit:GetOwner()
        NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    end
    return lairInfo.LairDestroyChance
end

local iCIVIC_MYSTICISM = GameInfo.Civics['CIVIC_MYSTICISM'].Index

function doGood(pPlot, pUnit, bIsWater)
    local tPossible =  {'HIGH_GOLD', 'TREASURE', 'EXPERIENCE'}
    local pPlayer, iPlayer
    if pUnit then
        iPlayer = pUnit:GetOwner()
        pPlayer = Players[iPlayer]
        local iUnitIndex = pUnit:GetType()
        local tUnitInfos = GameInfo.Units[iUnitIndex]
        local sUnitName = tUnitInfos.UnitType
        local pUnitAbilities = pUnit:GetAbility()
        -- local sUnitName = tUnitInfos.UnitType
        local sUnitPromoClass = tUnitInfos.PromotionClass
        if not tUndeadUnits[sUnitName] then
            if not pUnitAbilities:HasAbility('BUFF_SPIRIT_GUIDE') then          -- todo implement
                table.insert(tPossible, 'SPIRIT_GUIDE')
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
    end
    if not bIsWater then
        tPossible = SlthAppend(tPossible, {'ITEM_HEALING_SALVE', 'SUPPLIES'})
        if not pUnit then
            if pPlot then
                iPlayer = pPlot:GetOwner()
                pPlayer = Players[iPlayer]
            end
        end
        local pCulture = pPlayer:GetCulture()
        if pCulture and pCulture:HasCivic(iCIVIC_MYSTICISM) then
            tPossible = SlthAppend(tPossible, {'PRISONER_DISCIPLE_ASHEN', 'PRISONER_DISCIPLE_EMPYREAN',
                                               'PRISONER_DISCIPLE_LEAVES', 'PRISONER_DISCIPLE_OVERLORDS',
                                               'PRISONER_DISCIPLE_RUNES', 'PRISONER_DISCIPLE_ORDER'})
        end
    end
    local iChoice = math.random(#tPossible)
    local sEvent = tPossible[iChoice]
    print('Chosen Lair event: ' .. sEvent)
    local lairInfo = tLairs[sEvent]
    local fEvent = lairInfo.Callback
    local sUnitType = lairInfo.SimpleText
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pPlot:GetX(), pPlot:GetY()
    if pPlayer then
        NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    end
    return lairInfo.LairDestroyChance
end

function doBigGood(pPlot, bGraceFailed, pUnit, bIsWater)
    local iPlayer, pPlayer
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

        if pUnit then
            iPlayer = pUnit:GetOwner()
            pPlayer = Players[iPlayer]
        else
            iPlayer = pPlot:GetOwner()
            pPlayer = Players[iPlayer]
        end
        if pPlayer then
            local pTechs = pPlayer:GetTechs()
            if pTechs:HasTech('TECH_MINING') then
                tPossible = SlthAppend(tPossible, {'BONUS_COPPER', 'BONUS_GEMS', 'BONUS_GOLD'})
                if pTechs:HasTech('TECH_SMELTING') then
                    table.insert(tPossible, 'BONUS_IRON')
                end
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
    local lairInfo = tLairs[sEvent]
    local fEvent = lairInfo.Callback
    local sUnitType = lairInfo.SimpleText
    fEvent(pUnit, pPlot, sUnitType)
    local sTitle = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_NAME'
    local sDescription = 'LOC_NOTIFICATION_LAIR_' .. sEvent .. '_DESCRIPTION'
    local iX, iY = pPlot:GetX(), pPlot:GetY()
    if iPlayer then
        NotificationManager.SendNotification(iPlayer, iNotifType, sTitle, sDescription, iX, iY)
    end
end                                 -- NO return threshold?

function spawnTribeSafe(iPlotID, tribeIndex)
    Game:SetProperty('BarbFree_' .. iPlotID, 1)
    Game.GetBarbarianManager():CreateTribeOfType(tribeIndex, iPlotID)       -- recreate camp
    Game:SetProperty('BarbFree_' .. iPlotID, nil)
end

function testLairs(pUnit, pPlot)                        -- just for activating in console as debug
    for sEvent, lairInfo in pairs(tLairs) do
        local fEvent = lairInfo.Callback
        local sUnitType = lairInfo.SimpleText
        print('testing event', sEvent, sUnitType)
        fEvent(pUnit, pPlot, sUnitType)
    end
end
local pActualUnit, pActualPlot
function testLairsRepeat(pUnit, pPlot)                        -- just for activating in console as debug
    print('trying to test lairs')
    if not pActualUnit or pActualPlot then
        for _, unit in Players[0]:GetUnits():Members() do
            if not pActualUnit then
                local iUnitType = unit:GetType()
                print('unit type was', iUnitType)
                if iUnitType == GameInfo.Units['UNIT_WARRIOR'].Index then
                    pActualUnit = unit
                    pActualPlot = Map.GetPlot(unit:GetX(), unit:GetY())
                end
            end
        end
    end
    if not pActualUnit then
        pActualUnit = pUnit
        pActualPlot = pPlot
    end
    if not tLairTests then
        tLairTests = {}
        for sEvent, lairInfo in pairs(tLairs) do
            table.insert(tLairTests, lairInfo)
        end
        iLairTestIndex = 1
    end
    print('test lair index',tLairTests, iLairTestIndex, tLairTests[iLairTestIndex])
    if tLairTests[iLairTestIndex] then
        local lairInfo = tLairTests[iLairTestIndex]
        local sUnitType = lairInfo.SimpleText
        local ifunc_Event = lairInfo.Callback
        print('testing function',lairInfo.LairType, lairInfo.CallbackString)
        ifunc_Event(pActualUnit, pActualPlot, sUnitType)
        iLairTestIndex = iLairTestIndex + 1
    end
end