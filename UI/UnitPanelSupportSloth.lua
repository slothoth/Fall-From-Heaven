-- globals (used in callbacks where we cant overide as uses state from panel)
print('loading unitPanel Support!')
MANA_INDEX = GameInfo.Resources['RESOURCE_MANA'].Index
tManaNodeMapper = {
    [GameInfo.Improvements['IMPROVEMENT_MANA_AIR'].Hash]         = GameInfo.Resources['RESOURCE_MANA_AIR'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_BODY'].Hash]        = GameInfo.Resources['RESOURCE_MANA_BODY'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_CHAOS'].Hash]       = GameInfo.Resources['RESOURCE_MANA_CHAOS'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_DEATH'].Hash]       = GameInfo.Resources['RESOURCE_MANA_DEATH'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_EARTH'].Hash]       = GameInfo.Resources['RESOURCE_MANA_EARTH'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_ENCHANTMENT'].Hash] = GameInfo.Resources['RESOURCE_MANA_ENCHANTMENT'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_ENTROPY'].Hash]     = GameInfo.Resources['RESOURCE_MANA_ENTROPY'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_FIRE'].Hash]        = GameInfo.Resources['RESOURCE_MANA_FIRE'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_LAW'].Hash]         = GameInfo.Resources['RESOURCE_MANA_LAW'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_LIFE'].Hash]        = GameInfo.Resources['RESOURCE_MANA_LIFE'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_METAMAGIC'].Hash]   = GameInfo.Resources['RESOURCE_MANA_METAMAGIC'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_MIND'].Hash]        = GameInfo.Resources['RESOURCE_MANA_MIND'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_NATURE'].Hash]      = GameInfo.Resources['RESOURCE_MANA_NATURE'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_SHADOW'].Hash]      = GameInfo.Resources['RESOURCE_MANA_SHADOW'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_SPIRIT'].Hash]      = GameInfo.Resources['RESOURCE_MANA_SPIRIT'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_SUN'].Hash]         = GameInfo.Resources['RESOURCE_MANA_SUN'].Index,
    [GameInfo.Improvements['IMPROVEMENT_MANA_WATER'].Hash]       = GameInfo.Resources['RESOURCE_MANA_WATER'].Index
}

local tSkipPromos = { [GameInfo.UnitPromotions['PROMOTION_IS_UNDEAD'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_CAN_GET_FEAR'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_IS_HERO_COMBATV'].Index] = 1,
				[GameInfo.UnitPromotions['PROMOTION_IS_DEMON'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ORDER_STATE'].Index] = 1,
				[GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WARFARE'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_HIDDEN_PATHS'].Index] = 1,
				[GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ANIMAL_HUSBANDRY'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ANIMAL_MASTERY'].Index] = 1,
				[GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_CORRUPTION_OF_SPIRIT'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ARETE'].Index] = 1,
				[GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WISE'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_WAY_OF_WICKED'].Index] = 1,
				[GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_MIL_STRATEGY'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_ARCANE_LORE'].Index] = 1,
				[GameInfo.UnitPromotions['PROMOTION_PLAYER_HAS_HORSEBACK_RIDING'].Index] = 1,
				[GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED'].Index] = 1,
				[GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED'].Index] = 1,
				[GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['ICE_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED'].Index] = 1,
				[GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED'].Index] = 1,
				[GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED'].Index] = 1,
				[GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED'].Index] = 1, [GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_2'].Index] = 1,
				[GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_2'].Index] = 1,
				[GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_2'].Index] = 1,
				[GameInfo.UnitPromotions['ICE_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_2'].Index] = 1,
				[GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_2'].Index] = 1,
				[GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_2'].Index] = 1,
				[GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_2'].Index] = 1, [GameInfo.UnitPromotions['DEATH_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['FIRE_SPHERE_ALLOWED_3'].Index] = 1,
				[GameInfo.UnitPromotions['AIR_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['BODY_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['CHAOS_SPHERE_ALLOWED_3'].Index] = 1,
				[GameInfo.UnitPromotions['EARTH_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['ENCHANTMENT_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['ENTROPY_SPHERE_ALLOWED_3'].Index] = 1,
				[GameInfo.UnitPromotions['ICE_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['LAW_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['LIFE_SPHERE_ALLOWED_3'].Index] = 1,
				[GameInfo.UnitPromotions['METAMAGIC_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['MIND_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['NATURE_SPHERE_ALLOWED_3'].Index] = 1,
				[GameInfo.UnitPromotions['SPIRIT_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['WATER_SPHERE_ALLOWED_3'].Index] = 1, [GameInfo.UnitPromotions['SUN_SPHERE_ALLOWED_3'].Index] = 1,
				[GameInfo.UnitPromotions['SHADOW_SPHERE_ALLOWED_3'].Index] = 1 }

local tManaNodeBuilder = {
	[GameInfo.Units['SLTH_UNIT_ADEPT'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_IMP'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_SHAMAN'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_ARCHMAGE'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_HEMAH'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_LICH'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_MAGE'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_MOBIUS_WITCH'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_EATER_OF_DREAMS'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_GOVANNON'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_ILLUSIONIST'].Index] = 1,
	[GameInfo.Units['SLTH_UNIT_WIZARD'].Index] = 1
}
local tGreatPeople = {[GameInfo.Units['UNIT_GREAT_PROPHET'].Index]=true,   [GameInfo.Units['UNIT_GREAT_ENGINEER'].Index]=true,
					  [GameInfo.Units['UNIT_GREAT_SCIENTIST'].Index]=true, [GameInfo.Units['UNIT_GREAT_ARTIST'].Index]=true,
					  [GameInfo.Units['UNIT_GREAT_MERCHANT'].Index]=true,  [GameInfo.Units['UNIT_GREAT_GENERAL'].Index]=true
}

local tDeserts = {[GameInfo.Terrains['TERRAIN_DESERT_HILLS'].Index]= true,
			[GameInfo.Terrains['TERRAIN_DESERT'].Index] = true}
local tFlames = {}
if GameInfo.Features['FEATURE_BURNING_FOREST'] then
	tFlames = {[GameInfo.Features['FEATURE_BURNING_FOREST'].Index]= true,
				[GameInfo.Features['FEATURE_BURNING_JUNGLE'].Index]= true}			-- once i implement flames feature  todo
end
local tScorch = {[GameInfo.Terrains['TERRAIN_SNOW'].Index]= true,
			[GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index] = true,
			[GameInfo.Terrains['TERRAIN_PLAINS'].Index]= true,
			[GameInfo.Terrains['TERRAIN_PLAINS_HILLS'].Index] = true}
local tForested = {[GameInfo.Features['FEATURE_FOREST'].Index]= true,
			[GameInfo.Features['FEATURE_JUNGLE'].Index]= true}
local tGrassland = {[GameInfo.Terrains['TERRAIN_GRASS'].Index]= true,
			[GameInfo.Terrains['TERRAIN_GRASS_HILLS'].Index]= true}
local tSanctify = {[GameInfo.Features['FEATURE_MARSH'].Index]= true}					--	once i implement graveyards, city ruins todo

local tEquipmentUnits = {}
local tEquipmentAbilities = {}
local tEquipmentToolTip = {}
for row in GameInfo.Equipment() do
	local iAbilityIndex = GameInfo.UnitAbilities[row.UnitAbilityType].Index
	local iUnitIndex = GameInfo.Units[row.UnitType].Index
	tEquipmentUnits[iUnitIndex] = iAbilityIndex
	tEquipmentAbilities[iAbilityIndex] = iUnitIndex
	tEquipmentToolTip[iUnitIndex] = row.PickUpText
end

local tExperienceUpgrades = {}
for row in GameInfo.PromotionGatedUpgrades() do
    tExperienceUpgrades[row.UnitType] = row.UnitLevel
end

local tNationalUpgrades = {}
for row in GameInfo.NationalUnits() do
    tNationalUpgrades[row.UnitType] = row.Amount
end

---------------- STATE ---------------------------
local tCachedViableActionPlots = {}
local tCachedViableActionUnits = {}
local CachedUnitOperation
local CachedUnitOperationCallback
--------------------------------------------------
local function AbilityChecker(pUnit, tAbilitiesToCheck, iAbilityChecksNeeded)
	local bCanStart
	local pAbilities = pUnit:GetAbility():GetAbilities()
	local iAbilityChecksPassed = 0
	if (pAbilities and table.count(pAbilities) > 0) then
		for _,ability in ipairs (pAbilities) do
			if not bCanStart then
				if tAbilitiesToCheck[ability] then
					iAbilityChecksPassed = iAbilityChecksPassed + 1
					bCanStart = iAbilityChecksPassed >= iAbilityChecksNeeded
				end
			end
		end
	end
	return bCanStart
end

function CustomOpCheck(CustomOperationInfo, pUnit, unitType, pUnitExp)
    local bCanStart, bHasRelevantPromotion, sReqPromo, reqAbility, reqUnitType, failedReq
    local sReqDomain =  CustomOperationInfo.DomainPrereq
    if sReqDomain then
        if GameInfo.Units[unitType].Domain == 'DOMAIN_LAND' then
            bCanStart = true;
        else
            failedReq = true
        end
    end

    sReqPromo = CustomOperationInfo.PromotionPrereq
    if sReqPromo and not failedReq then
        bHasRelevantPromotion = pUnitExp:HasPromotion(GameInfo.UnitPromotions[sReqPromo].Index)
        if bHasRelevantPromotion then
            bCanStart = bHasRelevantPromotion
        else
            failedReq = true
        end
    end
    reqUnitType = CustomOperationInfo.UnitPrereq
    if reqUnitType and not failedReq then
        if reqUnitType == unitType then
            bCanStart = true
        else
            failedReq = true
        end
    end
    reqAbility = CustomOperationInfo.AbilityPrereq			-- need to iterate over abilities here

    if reqAbility and not failedReq then
        local tAbilitiesToCheck = {[GameInfo.UnitAbilities[reqAbility].Index]=reqAbility}
        local iAbilityChecksNeeded = 1
        if CustomOperationInfo.AlternateAbilityPrereq then
            tAbilitiesToCheck[GameInfo.UnitAbilities[CustomOperationInfo.AlternateAbilityPrereq].Index]= AlternateAbilityPrereq
            iAbilityChecksNeeded = iAbilityChecksNeeded + 1
        end
        if CustomOperationInfo.AlsoAbilityPrereq then
            -- print('had additional prereq', CustomOperationInfo.AlsoAbilityPrereq)
            tAbilitiesToCheck[GameInfo.UnitAbilities[CustomOperationInfo.AlsoAbilityPrereq].Index]= CustomOperationInfo.AlsoAbilityPrereq
            iAbilityChecksNeeded = iAbilityChecksNeeded + 1
        end
        if CustomOperationInfo.AlsoTwoAbilityPrereq then
            -- print('had second additional prereq', CustomOperationInfo.AlsoTwoAbilityPrereq)
            tAbilitiesToCheck[GameInfo.UnitAbilities[CustomOperationInfo.AlsoTwoAbilityPrereq].Index]= CustomOperationInfo.AlsoTwoAbilityPrereq
            iAbilityChecksNeeded = iAbilityChecksNeeded + 1
        end
        -- print(CustomOperationInfo.OperationType, reqAbility, CustomOperationInfo.AlternateAbilityPrereq, CustomOperationInfo.AlsoAbilityPrereq, CustomOperationInfo.AlsoTwoAbilityPrereq )
        bCanStart = AbilityChecker(pUnit, tAbilitiesToCheck, iAbilityChecksNeeded)
    end
    if CustomOperationInfo.BuildingPrereq and not failedReq then
        local iOwner = pUnit:GetOwner()
        local pPlayer = Players[iOwner]
        local pPlayerCities = pPlayer:GetCities()
        local iPrereqBuilding = GameInfo.Buildings[CustomOperationInfo.BuildingPrereq].Index
        if pPlayerCities then
            for idx, pCity in pPlayerCities:Members() do
                if not bCanStart then
                    local pBuildings = pCity:GetBuildings()
                    if pBuildings:HasBuilding(iPrereqBuilding) then
                        bCanStart = true
                    end
                end
            end
        end
    end
	if CustomOperationInfo.TechPrereq and not failedReq then
		local pPlayer = Players[Game.GetLocalPlayer()]
		local techInfo = GameInfo.Technologies[CustomOperationInfo.TechPrereq]
		if techInfo then
			bCanStart = pPlayer:GetTechs():HasTech(techInfo.Index)
		else
			local civicInfo = GameInfo.Civics[CustomOperationInfo.TechPrereq]
			if civicInfo then
				bCanStart = pPlayer:GetCulture():HasCivic(civicInfo.Index)
			end
		end
	end
    return bCanStart
end

local function CheckAdjacentUnitIsEnemy(pUnit, iPlayer, CustomOpInfo)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local bEnemyUnitFound, iUnitID, iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit) then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer ~= iPlayer) then
					if Players[iPlayer]:GetDiplomacy():IsAtWarWith(iOwnerPlayer) then
						TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local tMagicBuffs = {[GameInfo.UnitAbilities['BUFF_ENCHANTED_BLADE'].Index] = true}								-- incomplete list
local tMagicDebuffs = {[GameInfo.UnitAbilities['BUFF_RUSTED'].Index] = true}

local function CheckAdjacentEnemyUnitsHasAbility(pUnit, iPlayer, CustomOpInfo)
	if CustomOpInfo == -1 then
		bMultipleChecks = true
	else
		local iAbilityToCheck = GameInfo.UnitAbilities[CustomOpInfo.SimpleText].Index
	end
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local bEnemyUnitHasAbility, pAbilities, iUnitID, iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit) then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer ~= iPlayer) then
					pAbilities = pNearUnit:GetAbility():GetAbilities()
					if (pAbilities and table.count(pAbilities) > 0) then
						for i,ability in ipairs (pAbilities) do
							if not bEnemyUnitHasAbility then
								if bMultipleChecks then
									bEnemyUnitHasAbility = tMagicBuffs[ability]
								else
									bEnemyUnitHasAbility = ability == iAbilityToCheck							-- GameInfo.UnitAbilities[ability]
								end
								if bEnemyUnitHasAbility then
									TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
								end
							end
						end
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return false
	else
		return true
	end
end

local function CheckAdjacentUnitsHasntAbility(pUnit, iPlayer, CustomOpInfo, bIsAlly)
	local abilityToCheckInfo = GameInfo.UnitAbilities[CustomOpInfo.SimpleText]
	if not abilityToCheckInfo then
		print('Error in checking adjacent units for Ability for use in CustomOP, couldnt find ability:', CustomOpInfo.SimpleText, CustomOpInfo.OperationType)
		return false;
	end
	local iAbilityToCheck = GameInfo.UnitAbilities[CustomOpInfo.SimpleText].Index
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local bEnemyUnitHasAbility, pAbilities, iUnitID, iPlotID, bCondition
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit) then
				local bUnitHasAbility = nil
				local iOwnerPlayer = pNearUnit:GetOwner();
				if bIsAlly then
					bCondition = iOwnerPlayer == iPlayer
				else
					bCondition = iOwnerPlayer ~= iPlayer
				end
				if bCondition then
					-- print('unit is at least eligible')
					pAbilities = pNearUnit:GetAbility():GetAbilities()
					if (pAbilities and table.count(pAbilities) > 0) then
						for i,ability in ipairs (pAbilities) do
							if not bUnitHasAbility then
								if ability == iAbilityToCheck then							-- GameInfo.UnitAbilities[ability]
									bUnitHasAbility = true
								end
							end
						end
						if not bUnitHasAbility then
							-- print('unit hasnt ability')
							TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
						end
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		-- print('some units were found without ability')
		return true
	else
		-- print('no units were found without ability')
		return false
	end
end

local function GPChecker(pPlayer, iBar)
	local iGpAmount = 0
	print('checking golden age people requirements')
	for _, pPlayerUnit in pPlayer:GetUnits():Members() do			-- gather great people
		if tGreatPeople[pPlayerUnit:GetType()] then
			print('found great person')
			iGpAmount = iGpAmount + 1
			if iGpAmount >= iBar then return true end
		end
	end
	return false
end

local function CheckAdjacentEnemyUnitsHasPromoClass(pUnit, iPlayer, CustomOpInfo)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
	local sPromoClass = CustomOpInfo.SimpleText
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local unitType, sUnitPromoClass
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit) then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer ~= iPlayer) then
					unitType = pNearUnit:GetUnitType();
					sUnitPromoClass = GameInfo.Units[unitType].PromotionClass
					if sPromoClass == sUnitPromoClass then
						return true
					end
				end
			end
		end
	end
	return false
end

local function CheckAdjacentAllyUnitTypeMatches(pUnit, iPlayer, CustomOpInfo)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
	local iUnitTypeRequired = GameInfo.Units[CustomOpInfo.SimpleText].Index
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local iUnitType, iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if pNearUnit then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
					iUnitType = pNearUnit:GetUnitType();
					if iUnitType == iUnitTypeRequired then
						TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local function CheckAdjacentOwnUnitHasAbility(pUnit, iPlayer, CustomOpInfo)
	local iAbilityToCheck = GameInfo.UnitAbilities[CustomOpInfo.SimpleText].Index
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local bAllyUnitHasAbility, pAbilities, iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit) then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
					pAbilities = pNearUnit:GetAbility():GetAbilities()
					if (pAbilities and table.count(pAbilities) > 0) then
						for i,ability in ipairs (pAbilities) do
							if not bAllyUnitHasAbility then
								bAllyUnitHasAbility = ability == iAbilityToCheck
								if bAllyUnitHasAbility then
									TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
								end
							end
						end
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local function CheckAdjacentAllyUnitIsntFullHealth(pUnit, iPlayer, CustomOpInfo)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local iDamage, iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if pNearUnit then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
					iDamage = pNearUnit:GetDamage();
					if iDamage > 0 then
						TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local function CheckAdjacentAllyUnitIsntFullHealthAndAbilityMatches(pUnit, iPlayer, CustomOpInfo)
	local iAbilityToCheck = GameInfo.UnitAbilities[CustomOpInfo.SimpleText].Index
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local bAllyUnitHasAbility, pAbilities, iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit) then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
					if pNearUnit:GetDamage() > 0 then
						pAbilities = pNearUnit:GetAbility():GetAbilities()
						if (pAbilities and table.count(pAbilities) > 0) then
							for i,ability in ipairs (pAbilities) do
								if not bAllyUnitHasAbility then
									bAllyUnitHasAbility = ability == iAbilityToCheck
									if bAllyUnitHasAbility then
										TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local function CheckAdjacentAllyUnitLevelMatches(pUnit, iPlayer, CustomOpInfo)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
	local iLevelMinimum = GameInfo.Units[CustomOpInfo.SimpleAmount].Index
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local iLevel, iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if pNearUnit then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
					iLevel = pNearUnit:GetExperience():GetLevel();
					if iLevel >= iLevelMinimum then
						TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local function CheckAdjacentAllyUnit(pUnit, iPlayer, CustomOpInfo)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if pNearUnit then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
					TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local function CheckAdjacentEnemyUnit(pUnit, iPlayer)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local iPlotID
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if pNearUnit then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer ~= iPlayer) then
					TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local function CheckAdjacentCity(pUnit, iPlayer, CustomOpInfo, iSameOwner, iBuildingPrereq)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local iPlotID, pCity, bGatingPassed
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		if plot:IsCity() then
			local iCityX =  plot:GetX()
    		local iCityY =  plot:GetY()
			pCity = CityManager.GetCityAt(iCityX, iCityY)
			local iOwnerPlayer = pCity:GetOwner();
			if iSameOwner == 1 then
				bGatingPassed = iOwnerPlayer == iPlayer
			elseif iSameOwner == 2 then
				bGatingPassed = true
			else
				bGatingPassed = iOwnerPlayer ~= iPlayer
			end
			if bGatingPassed then
				-- print('Adjacent city')
				if iBuildingPrereq then
					print('building check on ' .. tostring(iBuildingPrereq))
					local pBuildings = pCity:GetBuildings()
					if pBuildings:HasBuilding(iBuildingPrereq) then
						TrackPlot(plot, pCity, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
						return true
					end
				else
					TrackPlot(plot, pCity, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
					return true
				end
			end
		end
	end
	return false
end

local function CheckAdjacentAllyUnitTypeMatchesOrAbilityMatches(pUnit, iPlayer, CustomOpInfo)
	local iAbilityToCheck = GameInfo.UnitAbilities[CustomOpInfo.SimpleText].Index
	local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local bAllyUnitHasAbility, pAbilities, iPlotID, iUnitType
	tCachedViableActionUnits[CustomOpInfo.OperationType] = {}
	tCachedViableActionPlots[CustomOpInfo.OperationType] = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit) then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
					iUnitType = pNearUnit:GetUnitType();
					if GameInfo.Units[iUnitType].Domain == 'DOMAIN_IMMOBILE' then
						TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
					else
						pAbilities = pNearUnit:GetAbility():GetAbilities()
						if (pAbilities and table.count(pAbilities) > 0) then
							for i,ability in ipairs (pAbilities) do
								if not bAllyUnitHasAbility then
									bAllyUnitHasAbility = ability == iAbilityToCheck
									if bAllyUnitHasAbility then
										TrackPlot(plot, pNearUnit, tCachedViableActionUnits[CustomOpInfo.OperationType], tCachedViableActionPlots[CustomOpInfo.OperationType])
									end
								end
							end
						end
					end
				end
			end
		end
	end
	if table.count(tCachedViableActionPlots[CustomOpInfo.OperationType]) > 0 then
		return true
	else
		return false
	end
end

local function CheckAtWar(iPlayer)
	local pPlayer = Players[iPlayer];
    local pDiplo = pPlayer:GetDiplomacy()
    for iOtherPlayer, _ in ipairs(Players) do
        if pDiplo:IsAtWarWith(iOtherPlayer) then
			return true
        end
    end
	return false
end

local function GetNearbyEquipment(pUnit, iPlayer, CustomOpInfo)
	local iX =  pUnit:GetX()
    local iY =  pUnit:GetY()
    local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 1);
	local bAllyUnitHasAbility, pAbilities,iPlotID, iUnitType, iEquipmentUnit
	local tEquipmentFound = {}
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if pNearUnit and pNearUnit ~= pUnit then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer == iPlayer) then
					iUnitType = pNearUnit:GetUnitType();
					if tEquipmentUnits[iUnitType] then
						iEquipmentUnit = iUnitType
						tEquipmentFound[iEquipmentUnit] = tEquipmentToolTip[iUnitType]
						if not tCachedViableActionPlots[iEquipmentUnit] then
							tCachedViableActionUnits[iEquipmentUnit] = {}
							tCachedViableActionPlots[iEquipmentUnit] = {}
						end
						TrackPlot(plot, pNearUnit, tCachedViableActionUnits[iEquipmentUnit], tCachedViableActionPlots[iEquipmentUnit])
					else
						pAbilities = pNearUnit:GetAbility():GetAbilities()
						if (pAbilities and table.count(pAbilities) > 0) then
							for i,iAbilityIndex in ipairs (pAbilities) do
								if tEquipmentAbilities[iAbilityIndex] then
									iEquipmentUnit = tEquipmentAbilities[iAbilityIndex]
									tEquipmentFound[iEquipmentUnit] = tEquipmentToolTip[tEquipmentAbilities[iAbilityIndex]]
									if not tCachedViableActionPlots[iEquipmentUnit] then
										tCachedViableActionUnits[iEquipmentUnit] = {}
										tCachedViableActionPlots[iEquipmentUnit] = {}
									end
									TrackPlot(plot, pNearUnit, tCachedViableActionUnits[iEquipmentUnit], tCachedViableActionPlots[iEquipmentUnit])
								end
							end
						end
					end
				end
			end
		end
	end
	if iEquipmentUnit then						-- at least one equipment existed
		return true, tEquipmentFound
	else
		return false, nil
	end
end


local function CustomCheck(CustomOperationInfo, pUnit)					-- does the checks to let a possible allowed unit operation pressable in the current context
	local bCanStart, tIterations
	local tParameters = {}
	local iUnit = pUnit:GetID()
	local iOwner = pUnit:GetOwner()
	tParameters.UnitOperationType = CustomOperationInfo.OperationType;
	tParameters.iCastingUnit = iUnit;
	if CustomOperationInfo.ActivationPrereq == 'SingleSummon' then
		local iSummonID = pUnit:GetProperty(CustomOperationInfo.SimpleText)
		if iSummonID then
			local pSummonUnit = UnitManager.GetUnit(iOwner, iSummonID)
			bCanStart = not pSummonUnit
		else
			bCanStart = true
		end
	elseif CustomOperationInfo.ActivationPrereq == 'PlayerHeroDead' then
		local pPlayer = Players[iOwner]
		bCanStart = (pPlayer:GetProperty('HERO_DEAD') or 0) > 0
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentEnemyUnit' then
		bCanStart = CheckAdjacentUnitIsEnemy(pUnit, iOwner, CustomOperationInfo)
	elseif CustomOperationInfo.ActivationPrereq == 'DesertOrFlamesAdjacent' then
		local iPlotID = pUnit:GetPlotId()
		local pPlot = Map.GetPlotByIndex(iPlotID)
		local iFeature = pPlot:GetFeatureType()										-- need logic for aoe flames
		if iFeature then
			bCanStart = tFlames[iFeature]
			if not bCanStart then
				local iTerrain = pPlot:GetTerrainType()
				bCanStart = tDeserts[iTerrain]
			end
		end

	elseif CustomOperationInfo.ActivationPrereq == 'OnSnowOrPlains' then
		local iPlotID = pUnit:GetPlotId()
		local pPlot = Map.GetPlotByIndex(iPlotID)
		local iTerrain = pPlot:GetTerrainType()
		bCanStart = tScorch[iTerrain]
	elseif CustomOperationInfo.ActivationPrereq == 'OnLandNotWoodedGrass' then
		local iPlotID = pUnit:GetPlotId()
		local pPlot = Map.GetPlotByIndex(iPlotID)
		local iFeature = pPlot:GetFeatureType()
		if tForested[iFeature] then
			local iTerrain = pPlot:GetTerrainType()
			bCanStart = not tGrassland[iTerrain]
		end
	elseif CustomOperationInfo.ActivationPrereq == 'OnForestOrJungle' then
		local iPlotID = pUnit:GetPlotId()
		local pPlot = Map.GetPlotByIndex(iPlotID)
		local iFeature = pPlot:GetFeatureType()
		if iFeature then
			bCanStart = tForested[iFeature]
		end
	elseif CustomOperationInfo.ActivationPrereq == 'OnCityRuinsOrGraveyardOrHellTerrain' then
		local iPlotID = pUnit:GetPlotId()
		local pPlot = Map.GetPlotByIndex(iPlotID)
		local iFeature = pPlot:GetFeatureType()
		bCanStart = tSanctify[iFeature]
		if not bCanStart then
			bCanStart = pPlot:GetProperty('HellConversion') or 0 > 9
		end
	elseif CustomOperationInfo.ActivationPrereq == 'OnManaOrAdjacentUnitHasMagicDebuffOrBuff' then
		local iPlotID = pUnit:GetPlotId()
		local pPlot = Map.GetPlotByIndex(iPlotID)
		local ResourceInfo = GameInfo.Resources[pPlot:GetResourceType()]
		bCanStart = ResourceInfo and ResourceInfo.ResourceClassType == 'RESOURCECLASS_MANA'
		-- if not bCanStart then
 		--	bCanStart = CheckAdjacentOwnUnitsHasntAbility(pUnit, iOwner, -1)
		--	if not bCanStart then
 		--		bCanStart = CheckAdjacentEnemyUnitsHasAbility(pUnit, iOwner, -1)
		--	end
		-- end
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentEnemyEligibleAbility' then
		bCanStart = CheckAdjacentUnitsHasntAbility(pUnit, iOwner, CustomOperationInfo)
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentAllyEligibleAbility' then
		bCanStart = CheckAdjacentUnitsHasntAbility(pUnit, iOwner, CustomOperationInfo, true)
	elseif CustomOperationInfo.ActivationPrereq == 'HasntAbility' then
		local iAbilityToCheck
		local pAbilities = pUnit:GetAbility():GetAbilities()
		local pAbilityInfo = GameInfo.UnitAbilities[CustomOperationInfo.SimpleText]
		if pAbilityInfo then
			iAbilityToCheck = pAbilityInfo.Index
			print('checking if can grant ability to self:', CustomOperationInfo.SimpleText)
		elseif CustomOperationInfo.SecondText then
			pAbilityInfo = GameInfo.UnitAbilities[CustomOperationInfo.SecondText]
			if pAbilityInfo then
				iAbilityToCheck = pAbilityInfo.Index
				print('checking if can grant ability to self:', CustomOperationInfo.SecondText)
			end
		end
		local hasAbility
		print('do we have abilities', pAbilities)
		if (pAbilities and table.count(pAbilities) > 0 and iAbilityToCheck) then
			print('pre ability start, ensure false', hasAbility)
			for i,ability in ipairs (pAbilities) do
				if not hasAbility then
					print('checking if ability 1 == ability 2',ability,  iAbilityToCheck)
					hasAbility = ability == iAbilityToCheck
				end
			end
			print('do we have the ability', hasAbility)
			bCanStart = not hasAbility
		else
			bCanStart = true
		end
	elseif CustomOperationInfo.ActivationPrereq == 'OnCityPopTwoPlus' then
		local pCity = Cities.GetCityInPlot(pUnit:GetX(), pUnit:GetY())
		if pCity then
			bCanStart = pCity:GetPopulation() > 1
		end
	elseif CustomOperationInfo.ActivationPrereq == 'OnCityGeneric' then
		local pCity = Cities.GetCityInPlot(pUnit:GetX(), pUnit:GetY())
		if pCity then
			bCanStart = true
		end
	elseif CustomOperationInfo.ActivationPrereq == 'OnCityGrantBuilding' then
		local pCity = Cities.GetCityInPlot(pUnit:GetX(), pUnit:GetY())
		-- print(' City grant building')
		if pCity then
			bCanStart = not pCity:GetBuildings():HasBuilding(GameInfo.Buildings[CustomOperationInfo.SimpleText].Index)
		end
	elseif CustomOperationInfo.ActivationPrereq == 'OnCityGrantBuildingPrereqBuilding' then
		local pCity = Cities.GetCityInPlot(pUnit:GetX(), pUnit:GetY())
		if pCity then
			local pBuildings = pCity:GetBuildings()
			if pBuildings:HasBuilding(GameInfo.Buildings[CustomOperationInfo.SecondText].Index) then
				if not pBuildings:HasBuilding(GameInfo.Buildings[CustomOperationInfo.SimpleText].Index) then
					bCanStart = true
				end
			end
		end
	elseif CustomOperationInfo.ActivationPrereq == 'EnoughGreatPeople' then
		local pPlayer = Players[iOwner]
		local iBar = pPlayer:GetProperty('GreatPeopleGoldenRequirement') or 1
		bCanStart = GPChecker(pPlayer, iBar)
	elseif CustomOperationInfo.ActivationPrereq == 'OnHolyCity' then
		local pCity = Cities.GetCityInPlot(pUnit:GetX(), pUnit:GetY())
		if pCity then
			local pBuildings = pCity:GetBuildings()
			if not pBuildings:HasBuilding(GameInfo.Buildings[CustomOperationInfo.SimpleText].Index) then
				local bIsCorrectHolyCity = pCity:GetProperty(CustomOperationInfo.SecondText)
				bCanStart = bIsCorrectHolyCity and bIsCorrectHolyCity > 0
			end
		end
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentEnemyEligiblePromoClass' then
		bCanStart = CheckAdjacentEnemyUnitsHasPromoClass(pUnit, iOwner, CustomOperationInfo)
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentSingleAllyUnitMatches' then
		bCanStart = CheckAdjacentAllyUnitTypeMatches(pUnit, iOwner, CustomOperationInfo)
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentAllyUnitAbilityMatches' then									-- use for herald
		bCanStart = CheckAdjacentOwnUnitHasAbility(pUnit, iOwner, CustomOperationInfo)
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentSingleAllyIsDamaged' then
		bCanStart = CheckAdjacentAllyUnitIsntFullHealth(pUnit, iOwner, CustomOperationInfo)
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentSingleAllyIsDamagedAndGolem' then
		bCanStart = CheckAdjacentAllyUnitIsntFullHealthAndAbilityMatches(pUnit, iOwner, CustomOperationInfo)
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentSingleAllyIsLevelMinimum' then
		bCanStart = CheckAdjacentAllyUnitLevelMatches(pUnit, iOwner, CustomOperationInfo)
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentSingleAlly' then
		bCanStart = CheckAdjacentAllyUnit(pUnit, iOwner, CustomOperationInfo)			-- todo flesh golem exclusion seems complicated
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentSingleEnemy' then
		bCanStart = CheckAdjacentEnemyUnit(pUnit, iOwner)
	elseif CustomOperationInfo.ActivationPrereq == 'OnAdjacentOwnedCity' then
		bCanStart = CheckAdjacentCity(pUnit, iOwner, CustomOperationInfo, 1)
	elseif CustomOperationInfo.ActivationPrereq == 'OnAdjacentEnemyCity' then
		bCanStart = CheckAdjacentCity(pUnit, iOwner, CustomOperationInfo, false)
	elseif CustomOperationInfo.ActivationPrereq == 'OnAdjacentCity' then
		bCanStart = CheckAdjacentCity(pUnit, iOwner, CustomOperationInfo, 2)
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentSingleAllyHasEquipmentOrIsEquipment' then
		bCanStart, tIterations = GetNearbyEquipment(pUnit, iOwner, CustomOperationInfo)			-- todo
	elseif CustomOperationInfo.ActivationPrereq == 'UnitIsLevel' then
		bCanStart = pUnit:GetExperience():GetLevel() > 5
	elseif CustomOperationInfo.ActivationPrereq == 'AdjacentCityHasBuilding' then
		bCanStart = CheckAdjacentCity(pUnit, iOwner, CustomOperationInfo, 1, GameInfo.Buildings[CustomOperationInfo.BuildingPrereq].Index)
	elseif CustomOperationInfo.ActivationPrereq == 'IsDamaged' then
		bCanStart = pUnit:GetDamage() > 0
	elseif CustomOperationInfo.ActivationPrereq == 'AtWar' then
		bCanStart = CheckAtWar(iOwner)
	else
		print('Not covered:')
		print(CustomOperationInfo.ActivationPrereq)
		bCanStart = true
	end
	return bCanStart, tIterations
end


function hasCastCheck(CustomOperationInfo, pUnit, bCanStart)
    local iHasCast = 0					--  TODO REMOVE ON RELEASE free casting for testing pUnit:GetProperty('HasCast') or 0
    local tIterations
    if iHasCast == 0 then
        if CustomOperationInfo.ActivationPrereq then
            bCanStart, tIterations = CustomCheck(CustomOperationInfo, pUnit)
        else
            bCanStart = true
        end
    else
        bCanStart = false
    end
	return bCanStart, tIterations
end

-- end custom ops
function populatePromosSkip(unitExperience, kSubjectData)
    local promotionList  = unitExperience:GetPromotions();
	for i, promotion in ipairs(promotionList) do
		if not tSkipPromos[promotion] then
			local promotionDef = GameInfo.UnitPromotions[promotion];
			table.insert(kSubjectData.CurrentPromotions, {
				Name = promotionDef.Name,
				Desc = promotionDef.Description,
				Level = promotionDef.Level
				})
		end
	end
end

local iClanDisperseHash = GameInfo.UnitCommands['UNITCOMMAND_TREAT_WITH_CLAN_DISPERSE'].Hash
function DisperseCampPlotProp(actionHash, pSelectedUnit)
    if actionHash == iClanDisperseHash then		-- setting plot property on gameplay side so dont redo lair
        print('dispersing camp, setting property first')
        local iOwner = pSelectedUnit:GetOwner()
        local tParameters = {sPropKey='DisperseCamp', iPropValue=1, iPlotIndex=pSelectedUnit:GetPlotId(),
                             OnStart='SlthSetPlotProperty'}
        UI.RequestPlayerOperation(iOwner, PlayerOperations.EXECUTE_SCRIPT, tParameters);
    end
end

function hideManaImprovements(tBuildActions, data)
    if tManaNodeBuilder[data.UnitType] then
        tBuildActions = {}											-- reset buildactions
        for idx, pAction in ipairs(data.Actions["BUILD"]) do
            if pAction.Disabled and pAction.userTag == UnitOperationTypes.BUILD_IMPROVEMENT then
            else
                table.insert(tBuildActions, pAction)
            end
        end
    end
    return tBuildActions
end

function DovielloUpgradeForeignOverride(v,tResults, bDisabled, pUnit, toolTipString, upgradeCost, upgradeUnitInfo, tDovielloUpgradeParams)
	local bDovielloUpgrade
	if (v == 'Must be in friendly territory.') and (PlayerConfigurations[pUnit:GetOwner()]:GetCivilizationTypeName() == 'SLTH_CIVILIZATION_DOVIELLO') then
		if table.count(tResults[UnitOperationResults.FAILURE_REASONS]) == 1 then
			bDisabled = false
			print('enabling doviello upgrade')
			bDovielloUpgrade = true
			tDovielloUpgradeParams[pUnit:GetID()] = {cost=upgradeCost, upgradeUnitIndex=upgradeUnitInfo.Index}
		end
	else
		toolTipString = toolTipString .. "[NEWLINE]" .. "[COLOR:Red]" .. Locale.Lookup(v) .. "[ENDCOLOR]";
	end
	return bDisabled, bDovielloUpgrade, toolTipString, tDovielloUpgradeParams
end

function amendNationalPromoToolTip(toolTipString, bDisabledExperience, bDisabledNational)
	if bDisabledExperience then
		toolTipString = toolTipString .. "[NEWLINE]" .. "[COLOR:Red]" .. Locale.Lookup("LOC_UPGRADE_LEVEL_FAILED", iPrereqExperience) .. "[ENDCOLOR]";
	end
	if bDisabledNational then
		toolTipString = toolTipString .. "[NEWLINE]" .. "[COLOR:Red]" .. Locale.Lookup("LOC_UPGRADE_NATIONAL_FAILED", iPrereqNationalMax) .. "[ENDCOLOR]";
	end
	return toolTipString
end

function CustomUpgradeTest(toolTipString, upgradeUnitInfo, pUnit, bDisabled)
	local bDisabledExperience, bDisabledNational
	print(toolTipString)
	local iPrereqExperience = tExperienceUpgrades[upgradeUnitInfo.UnitType]						-- experience and national unit gating, human only sadly
	local iPrereqNationalMax = tNationalUpgrades[upgradeUnitInfo.UnitType]
	print('checking if have experience, is prereq/actual', iPrereqExperience, pUnit:GetExperience():GetLevel())
	if iPrereqExperience and pUnit:GetExperience():GetLevel() < iPrereqExperience then
		bDisabled = true
		bDisabledExperience = true
	end
	if iPrereqNationalMax then
		local pUnits = Players[Game.GetLocalPlayer()]:GetUnits()
		local iAmountOfThisUnit = 0
		for _, pOtherUnit in pUnits:Members() do
			if iAmountOfThisUnit < iPrereqNationalMax then
				if pOtherUnit:GetUnitType() == upgradeUnitInfo.Index then
					iAmountOfThisUnit = iAmountOfThisUnit + 1
				end
			end
		end
		if iAmountOfThisUnit >= iPrereqNationalMax then
			bDisabled = true
			bDisabledNational = true
		end
	end
	return bDisabled, bDisabledExperience, bDisabledNational
end

function summedCombatModifierStrings(modifierModifierText)
	local tModifierOutput = {}
	local tNumStrippedUniques = {}
	local sStrippedItem
	local sNewItem
	local iStrippedAmount
	for i, item in ipairs(modifierModifierText) do
		iStrippedAmount = item:match("%d+")
		if iStrippedAmount then
			sStrippedItem = item:gsub(iStrippedAmount, '{{PLACEHOLDER}}', 1)
			if tNumStrippedUniques[sStrippedItem] then
				tNumStrippedUniques[sStrippedItem] = tNumStrippedUniques[sStrippedItem] + iStrippedAmount
			else
				tNumStrippedUniques[sStrippedItem] = iStrippedAmount
			end
		else
			tNumStrippedUniques[item] = 1
		end
	end
	for item, amount in pairs(tNumStrippedUniques) do
		sNewItem = item:gsub('{{PLACEHOLDER}}', tostring(amount), 1)
		table.insert(tModifierOutput, sNewItem)
	end
	return tModifierOutput
end

function interfaceCustomOp(CustomOperation)
	local sOpType = CustomOperation.OperationType
	local sOpCallback = CustomOperation.Callback
	CachedUnitOperation = sOpType
	CachedUnitOperationCallback = sOpCallback
	UI.SetInterfaceMode(InterfaceModeTypes.SELECTION)
	UI.SetInterfaceMode(InterfaceModeTypes.WB_SELECT_PLOT)
	local m_wbInterfaceMode = true
	local tPlots = tCachedViableActionPlots[sOpType]
	UILens.SetLayerHexesColoredArea(SLTH_HEX_COLORING_MOVEMENT, Game.GetLocalPlayer(), tPlots, UI.GetColorValue("COLOR_GREEN"))
	UILens.ToggleLayerOn(SLTH_HEX_COLORING_MOVEMENT)
	return m_wbInterfaceMode
end

function noInterfaceCustomOp (CustomOperation, pSelectedUnit)
	local sOpType = CustomOperation.OperationType
	local sOpCallback = CustomOperation.Callback
	local iUnit = pSelectedUnit:GetID()
	local iOwner = pSelectedUnit:GetOwner()			-- isnt this always local player?
	local tParameters = {}
	tParameters.UnitOperationType = sOpType;
	tParameters.iCastingUnit = iUnit;
	tParameters.OnStart = sOpCallback;
	print(sOpType .. ', ' .. sOpCallback .. tostring(iUnit).. tostring(iOwner))
	UI.RequestPlayerOperation(iOwner, PlayerOperations.EXECUTE_SCRIPT, tParameters)
	UI.DeselectUnit(pSelectedUnit);
end

function dovielloCustomUpgrade(pSelectedUnit, tDovielloUpgradeParams)
	local tParameters = {}
	tParameters.OnStart = 'SlthOnConvertUnitType'
	local iUnit = pSelectedUnit:GetID()
	local iOwner = pSelectedUnit:GetOwner()
	tParameters.iUnitID = iUnit
	tParameters.iUpgradeUnitIndex = tDovielloUpgradeParams[iUnit]['upgradeUnitIndex']
	tParameters.iCost = tDovielloUpgradeParams[iUnit]['cost']
	print('doviello custom upgrade')
	UI.RequestPlayerOperation(iOwner, PlayerOperations.EXECUTE_SCRIPT, tParameters)
	UI.DeselectUnit(pSelectedUnit);
	UnitManager.RequestCommand( pSelectedUnit, UnitCommandTypes.DELETE )
end

function CustomSetTheSelectedButtonByInterfaceMode (interfaceModeString, isSelected, tSlthBuildActions)
	for idx, instanceButton in ipairs(tSlthBuildActions) do
		if instanceButton.UnitActionButton then
			local actionHash = instanceButton.UnitActionButton:GetTag();
			local unitOperation = GameInfo.UnitOperations[actionHash];
			if unitOperation then
				local interfaceMode = unitOperation.InterfaceMode;
				if interfaceMode == interfaceModeString then
					if unitOperation.OperationType == CachedUnitOperation then
						instanceButton.UnitActionButton:SetSelected(isSelected);
					end
				end
			end
		end
	end
	if not isSelected then
		return QuitWBInterfaceMode(true)
	end
end

local tExtraParams = {SlthOnTakeEquipment={equipment=true}}
function selectPlot(plotId)
	local tParameters = {}
	local iTargetID
	print('getting target id, using', CachedUnitOperation, plotId)
	iTargetID = tCachedViableActionUnits[CachedUnitOperation][plotId]
	print('did target ID exist', iTargetID)
	print('was using this cached', CachedUnitOperation)
	if iTargetID then
		local pUnit = UI.GetHeadSelectedUnit()
		local iOwner = pUnit:GetOwner()
		tParameters.iTargetID = iTargetID
		tParameters.OnStart = CachedUnitOperationCallback;
		tParameters.iCastingUnit = pUnit:GetID()
		print('cached callback', CachedUnitOperationCallback)
		if tExtraParams[CachedUnitOperationCallback] then
			print('extra params existed, did equipment exist', tExtraParams[CachedUnitOperationCallback]['equipment'])
			if tExtraParams[CachedUnitOperationCallback]['equipment'] then
				print('setting ability to grant either', CachedUnitOperation, tEquipmentUnits[CachedUnitOperation])
				tParameters.iAbilityToGrant = tEquipmentUnits[CachedUnitOperation]
			end
		end
		print('params were iTargetID/OnStart/iCastingUnit', iTargetID, CachedUnitOperationCallback, pUnit:GetID())
		UI.RequestPlayerOperation(iOwner, PlayerOperations.EXECUTE_SCRIPT, tParameters)
	end
end

function QuitWBInterfaceMode(ifChangeInterfaceMode)
	if ifChangeInterfaceMode then
		UI.SetInterfaceMode( InterfaceModeTypes.SELECTION )
	end
	UILens.ClearLayerHexes(SLTH_HEX_COLORING_MOVEMENT);
	UILens.ToggleLayerOff(SLTH_HEX_COLORING_MOVEMENT);
	return false
end

function TrackPlot(pPlot, pNearUnit, tCacheTargets, tCachePlots)
	local iPlotID = pPlot:GetIndex()
	tCacheTargets[iPlotID] = pNearUnit:GetID()
	table.insert(tCachePlots, iPlotID)
end

function getActionPlots(sKey)
	return tCachedViableActionPlots[sKey]
end

function setColorHex(colorHexLayer)
	SLTH_HEX_COLORING_MOVEMENT = colorHexLayer
end

function setCachedOperation(fn)
	CachedUnitOperation = fn
end

function setCachedOperationCallback(fn)
	CachedUnitOperationCallback = fn
end

print('Finished unitPanel Support!')
