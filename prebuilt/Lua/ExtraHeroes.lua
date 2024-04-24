-- ExtraHeroes
-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------

function AndyLawFunction(iAndyPlayer, iUnit, unit_summoned, iX, iY)
	local pUnit = UnitManager.GetUnit(iAndyPlayer, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	playerUnits:Create(unit_summoned, iX, iY);
end

function AoeDamageFunction(iCaster, iUnit, iX, iY)
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
							pNearUnit:ChangeDamage(20);
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

function Initialize()
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
	ExposedMembers.ExtraHeroes.AndyLawFunction = AndyLawFunction;
end

Initialize();