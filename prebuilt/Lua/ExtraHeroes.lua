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
	-- playerUnits:Create(unit_summoned, iX, iY);
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