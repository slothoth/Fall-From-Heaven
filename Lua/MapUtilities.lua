-------------------------
-- Civ 6 Map Utilities --
-------------------------  Currently unused
include "MapUtilities"

function CanPlaceGoodyAt(improvement, plot)

	local improvementID = improvement.RowId - 1;
	local NO_TEAM = -1;
	local NO_RESOURCE = -1;
	local NO_IMPROVEMENT = -1;

	if (plot:IsWater()) then
		return false;
	end

	if (not ImprovementBuilder.CanHaveImprovement(plot, improvementID, NO_TEAM)) then
		return false;
	end


	if (plot:GetImprovementType() ~= NO_IMPROVEMENT) then
		return false;
	end

	if (plot:GetResourceType() ~= NO_RESOURCE) then
		return false;
	end

	if (plot:IsImpassable()) then
		return false;
	end

	if (plot:IsMountain()) then
		return false;
	end

	-- Don't allow on tiny islands.
	-- local numTiles = plot:GetArea().GetPlotCount();
	-- if (numTiles < 3) then
		-- return false;
	-- end

	-- Check for being too close to another of this goody type.
	local uniqueRange = improvement.GoodyRange;
	local plotX = plot:GetX();
	local plotY = plot:GetY();
	for dx = -uniqueRange, uniqueRange - 1, 1 do
		for dy = -uniqueRange, uniqueRange - 1, 1 do
			local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, uniqueRange);
			if(otherPlot and otherPlot:GetImprovementType() == improvementID) then
				return false;
			end
		end
	end

	-- Check for being too close to a civ start.
	for dx = -3, 3 do
		for dy = -3, 3 do
			local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 4);
			if(otherPlot) then
				if otherPlot:IsStartingPlot() then -- Loop through all ever-alive major civs, check if their start plot matches "otherPlot"
					for player_num = 0, PlayerManager.GetWasEverAliveCount() - 1 do
						local player = Players[player_num];
						if player:WasEverAlive() then
							-- Need to compare otherPlot with this civ's start plot and return false if a match.
							local playerStartPlot = player:GetStartingPlot();
							if otherPlot == playerStartPlot then
								return false;
							end
						end
					end
				end
			end
		end
	end

	return true;
end

function AddGoodies(iW, iH)
	local NO_PLAYER = -1;
	print("-------------------------------");
	print("Map Generation - Adding Goodies");

	--If advanced setting wants no goodies, don't place any.
	local bNoGoodies = GameConfiguration.GetValue("GAME_NO_GOODY_HUTS");
	if (bNoGoodies == true) then
		print("** The game specified NO GOODY HUTS");
		return false;
	end

	-- Check XML for any and all Improvements flagged as "Goody" and distribute them.
	local iImprovements = 0;
	local iTiles = 0;
	for improvement in GameInfo.Improvements() do
		local improvementID = improvement.RowId - 1;
		if(improvement.Goody and not (improvement.TilesPerGoody == nil)) then
			for x = 0, iW - 1 do
				for y = 0, iH - 1 do
					local i = y * iW + x;
					local pPlot = Map.GetPlotByIndex(i);
					local bGoody = CanPlaceGoodyAt(improvement, pPlot);
					if (bGoody) then
						if (iImprovements == 0 or (improvement.TilesPerGoody < iTiles / iImprovements)) then
							local goody_dice = TerrainBuilder.GetRandomNumber(2, "Goody Hut - LUA Goody Hut");
							if(goody_dice ==  1) then
								ImprovementBuilder.SetImprovementType(pPlot, improvementID, NO_PLAYER);
								iImprovements = iImprovements + 1;
							end
						end
					end

					iTiles = iTiles + 1;
				end
			end
		end
	end
	print("-------------------------------");

    -- Sloth changes: now distribute barb camps. unused as just adding Goody columns to barb camp
    iImprovements = 0;
	iTiles = 0;
    improvement = GameInfo.Improvements['']
    local improvementID = improvement.RowId - 1;
    if(improvement.Goody and not (improvement.TilesPerGoody == nil)) then
        for x = 0, iW - 1 do
            for y = 0, iH - 1 do
                local i = y * iW + x;
                local pPlot = Map.GetPlotByIndex(i);
                local bGoody = CanPlaceGoodyAt(improvement, pPlot);
                if (bGoody) then
                    if (iImprovements == 0 or (improvement.TilesPerGoody < iTiles / iImprovements)) then
                        local goody_dice = TerrainBuilder.GetRandomNumber(2, "Goody Hut - LUA Goody Hut");
                        if(goody_dice ==  1) then
                            ImprovementBuilder.SetImprovementType(pPlot, improvementID, NO_PLAYER);
                            iImprovements = iImprovements + 1;
                        end
                    end
                end

                iTiles = iTiles + 1;
            end
        end
    end
end
