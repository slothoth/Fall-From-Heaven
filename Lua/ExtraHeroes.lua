-- ExtraHeroes
-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------
tSuperSpecialistModifiers = {[GameInfo.Units['UNIT_GREAT_PROPHET'].Index]={
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
tSuperSpecialistGenericModifiers = {'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_HALL_OF_KINGS',
									'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_CASTE_SYSTEM',
									'MODIFIER_SLTH_GREAT_PERSON_ADD_CULTURE_CASTE_SYSTEM',
									'MODIFIER_SLTH_GREAT_PERSON_ADD_SCIENCE_SCHOLARSHIP'}

function AndyLawFunction(iAndyPlayer, iUnit, unit_summoned, iX, iY)
	local pUnit = UnitManager.GetUnit(iAndyPlayer, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	playerUnits:Create(unit_summoned, iX, iY);
end

function AoeDamageFunction(iCaster, iUnit, iDamage, iX, iY)
	local pUnit = UnitManager.GetUnit(iCaster, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	UnitManager.FinishMoves(pUnit);
	local tNeighborPlots = Map.GetNeighborPlots(iX, iY, 2);
	for _, plot in ipairs(tNeighborPlots) do
		for loop, pNearUnit in ipairs(Units.GetUnitsInPlot(plot)) do
			if (pNearUnit ~= nil) then
				local iOwnerPlayer = pNearUnit:GetOwner();
				if (iOwnerPlayer ~= iCaster) then
					if Players[iCaster]:GetDiplomacy():IsAtWarWith(iOwnerPlayer) then
						if (GameInfo.Units[pNearUnit:GetType()].Combat ~= 0 and GameInfo.Units[pNearUnit:GetType()].Domain ~= "DOMAIN_AIR") then
							pNearUnit:ChangeDamage(iDamage);
							if pNearUnit:GetDamage() >= 100 then
								UnitManager.Kill(pNearUnit, false);
							end
						end
					end
				end
			end
		end
	end
end

function ApplyDebuffAoeFunction(iCaster, iUnit, iX, iY)
	local pUnit = UnitManager.GetUnit(iCaster, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	-- playerUnits:Create(unit_summoned, iX, iY);
end

function ApplyBuffAoeFunction(iCaster, iUnit, iX, iY)
	local pUnit = UnitManager.GetUnit(iCaster, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	-- playerUnits:Create(unit_summoned, iX, iY);
end

function ChangeTerrainFunction(iCaster, iUnit, iX, iY)
	local pUnit = UnitManager.GetUnit(iCaster, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	-- playerUnits:Create(unit_summoned, iX, iY);
end

function PickUpItemFunction(iCaster, iUnit, iX, iY)
	local pUnit = UnitManager.GetUnit(iCaster, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	-- playerUnits:Create(unit_summoned, iX, iY);
end

function DropItemFunction(iCaster, iUnit, iX, iY)
	local pUnit = UnitManager.GetUnit(iCaster, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	-- playerUnits:Create(unit_summoned, iX, iY);
end

function TakeItemFunction(iCaster, iUnit, iX, iY)
	local pUnit = UnitManager.GetUnit(iCaster, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	-- playerUnits:Create(unit_summoned, iX, iY);
end

function SummonFunction(iAndyPlayer, iUnit, unit_summoned, iX, iY)
	local pUnit = UnitManager.GetUnit(iAndyPlayer, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	playerUnits:Create(unit_summoned, iX, iY);
end

function GrantBuildingFunction(iAndyPlayer, iUnit, iX, iY, sModifierGrant)
	local pUnit = UnitManager.GetUnit(iAndyPlayer, iUnit);
	local pCity = Cities.GetCityInPlot(iX, iY)
	pCity:AttachModifierByID(sModifierGrant);
	UnitManager.Kill(pUnit);
end

function GrantSuperSpecialist(iAndyPlayer, iUnit, iX, iY)
	local pUnit = UnitManager.GetUnit(iAndyPlayer, iUnit);
	local iUnitType = pUnit:GetType();
	local pCity = Cities.GetCityInPlot(iX, iY)
	for idx, sModifier in ipairs(tSuperSpecialistModifiers[iUnitType]) do
		pCity:AttachModifierByID(sModifier)
	end
	for idx, sModifier in ipairs(tSuperSpecialistGenericModifiers) do
		pCity:AttachModifierByID(sModifier)
	end
	UnitManager.Kill(pUnit);
end

function GrantGoldenAge(iPlayer, t_iUnits)
	local pPlayer = Players[iPlayer]
	local iUniqueGreatPeopleRequirement = pPlayer:GetProperty('GreatPeopleGoldenRequirement') or 1
	for iUnitType, iUnitID in pairs(t_iUnits) do
		local pUnit = UnitManager.GetUnit(iPlayer, iUnitID);
		UnitManager.Kill(pUnit);
	end
	for idx, pCity in pPlayer:GetCities():Members() do
		local pPlot = pCity:GetPlot();
		print(pPlot)						-- plot exists
        pPlot:SetProperty('InGoldenAge', 1);		-- but =function expected instea of nil?
	end
	pPlayer:SetProperty('GoldenAgeDuration', (pPlayer:GetProperty('GoldenAgeDuration') or 0) + 10)
	pPlayer:SetProperty('GreatPeopleGoldenRequirement', iUniqueGreatPeopleRequirement + 1)
end

function FlushGoldenAge(pPlayer)
	local pPlot
	for idx, pCity in pPlayer:GetCities():Members() do
		pPlot = pCity:GetPlot();
        pPlot:SetProperty('InGoldenAge', 0);
	end
end

function TimerSystem(playerID)
	local iTurnsLeft
	local iNewTurnsLeft
	local pPlayer = Players[playerID]
	for sMechanicName, entry in pairs(tTimers) do
		iTurnsLeft = pPlayer:GetProperty(entry.sProperty)
		if iTurnsLeft then
			iNewTurnsLeft = iTurnsLeft - 1
			if iNewTurnsLeft < 1 then
				iNewTurnsLeft = nil
				entry.callback(pPlayer)
			end
			pPlayer:SetProperty(entry.sProperty, iNewTurnsLeft)
		end
		if iNewTurnsLeft < 1 then
			entry.callback(pPlayer)
		else
			tTimers[sMechanicName] = iNewTurnsLeft
		end
	end
end

function Initialize()
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
	ExposedMembers.ExtraHeroes.AndyLawFunction = AndyLawFunction;
	ExposedMembers.ExtraHeroes.GrantBuildingFunction = GrantBuildingFunction;
	ExposedMembers.ExtraHeroes.GrantSuperSpecialist = GrantSuperSpecialist;
	ExposedMembers.ExtraHeroes.GrantGoldenAge = GrantGoldenAge
	tTimers = {GoldenAges = { sProperty = 'GoldenAgeDuration', callback = FlushGoldenAge}}
end

Initialize();
GameEvents.PlayerTurnDeactivated.Add(TimerSystem);