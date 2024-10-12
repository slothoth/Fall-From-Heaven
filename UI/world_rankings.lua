-- Copyright 2018, Firaxis Games
-- ===========================================================================
-- Includes
-- ===========================================================================
include("WorldRankings");

-- ===========================================================================
-- Constants
-- ===========================================================================
local PADDING_GENERIC_ITEM_BG = 25;
local SIZE_GENERIC_ITEM_MIN_Y = 54;
local DATA_FIELD_SELECTION = "Selection";
local PADDING_TAB_BUTTON_TEXT = 27;

local DATA_FIELD_HEADER_EXPANDED = "HeaderExpanded";
local DATA_FIELD_HEADER_HEIGHT = "HeaderHeight";
local OFFSET_ADVISOR_ICON_Y = 5;
local OFFSET_ADVISOR_TEXT_Y = 70;
local OFFSET_CONTRACT_BUTTON_Y = 63;
local PADDING_HEADER = 10;
local OFFSET_VIEW_CONTENTS = 130;
local SIZE_STACK_DEFAULT = 225;


local m_ScienceIM = InstanceManager:new("ScienceInstance", "ButtonBG", Controls.ScienceViewStack);
local m_ScienceTeamIM = InstanceManager:new("ScienceTeamInstance", "ButtonFrame", Controls.ScienceViewStack);
local m_ScienceHeaderIM = InstanceManager:new("ScienceHeaderInstance", "HeaderTop", Controls.ScienceViewHeader);

local SPACE_PORT_DISTRICT_INFO = GameInfo.Districts["DISTRICT_SPACEPORT"];
local EARTH_SATELLITE_EXP2_PROJECT_INFOS = {
	GameInfo.Projects["PROJECT_LAUNCH_EARTH_SATELLITE"]
};
local MOON_LANDING_EXP2_PROJECT_INFOS = {
	GameInfo.Projects["PROJECT_LAUNCH_MOON_LANDING"]
};
local MARS_COLONY_EXP2_PROJECT_INFOS = {
	GameInfo.Projects["PROJECT_LAUNCH_MARS_BASE"],
};
local EXOPLANET_EXP2_PROJECT_INFOS = {
	GameInfo.Projects["PROJECT_LAUNCH_EXOPLANET_EXPEDITION"],
};
local SCIENCE_PROJECTS_EXP2 = {
	EARTH_SATELLITE_EXP2_PROJECT_INFOS,
	MOON_LANDING_EXP2_PROJECT_INFOS,
	MARS_COLONY_EXP2_PROJECT_INFOS,
	EXOPLANET_EXP2_PROJECT_INFOS
};

local SCIENCE_ICON = "ICON_VICTORY_TECHNOLOGY";
local SCIENCE_TITLE = Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_VICTORY");
local SCIENCE_DETAILS = Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_DETAILS_EXP2");
local SCIENCE_REQUIREMENTS = {
	Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_REQUIREMENT_1"),
	Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_REQUIREMENT_2"),
	Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_REQUIREMENT_3"),
	Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_REQUIREMENT_4")
};

local TOWER_ALTERATION = { GameInfo.Buildings["BUILDING_MAHABODHI_TEMPLE"] };
local TOWER_DIVINATION = {GameInfo.Buildings["BUILDING_ORACLE"] };
local TOWER_ELEMENTS = {GameInfo.Buildings["BUILDING_PORCELAIN_TOWER"], };
local TOWER_NECROMANCY = {GameInfo.Buildings["BUILDING_LEANING_TOWER"], };
local TOWER_MASTERY = { GameInfo.Buildings["BUILDING_EIFFEL_TOWER"], };
local TOWERS = { TOWER_ALTERATION, TOWER_DIVINATION, TOWER_ELEMENTS, TOWER_NECROMANCY,
				 TOWER_MASTERY };

local m_TowerIM = InstanceManager:new("TowerInstance", "ButtonBG", Controls.TowerViewStack);				-- todo change in xml
local m_TowerTeamIM = InstanceManager:new("TowerTeamInstance", "ButtonFrame", Controls.TowerViewStack);
local m_TowerHeaderIM = InstanceManager:new("TowerHeaderInstance", "HeaderTop", Controls.TowerViewHeader);
local TOWER_REQUIREMENTS = {
	Locale.Lookup("test"),
	Locale.Lookup("two"),
	Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_REQUIREMENT_3"),
	Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_REQUIREMENT_4"),
	Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_REQUIREMENT_2")
};

-- ===========================================================================
-- Cached Functions
-- ===========================================================================
BASE_PopulateTabs = PopulateTabs;
BASE_AddTab = AddTab;
BASE_AddExtraTab = AddExtraTab;
BASE_OnTabClicked = OnTabClicked;
BASE_PopulateGenericInstance = PopulateGenericInstance;
BASE_PopulateGenericTeamInstance = PopulateGenericTeamInstance;
BASE_GetDefaultStackSize = GetDefaultStackSize;
BASE_GetCulturalVictoryAdditionalSummary = GetCulturalVictoryAdditionalSummary;

g_victoryData.VICTORY_DIPLOMATIC = {
	GetText = function(p) 
		local total = GlobalParameters.DIPLOMATIC_VICTORY_POINTS_REQUIRED;
		local current = 0;
		if (p:IsAlive()) then
			current = p:GetStats():GetDiplomaticVictoryPoints();
		end

		return Locale.Lookup("LOC_WORLD_RANKINGS_DIPLOMATIC_POINTS_TT", current, total);
	end,
	GetScore = function(p)
		local current = 0;
		if (p:IsAlive()) then
			current = p:GetStats():GetDiplomaticVictoryPoints();
		end

		return current;
	end,
	AdditionalSummary = function(p) return GetDiplomaticVictoryAdditionalSummary(p) end
};

g_victoryData.VICTORY_TOWER = {
	GetText = function(p)
		local total = GlobalParameters.DIPLOMATIC_VICTORY_POINTS_REQUIRED;
		local current = 0;
		if (p:IsAlive()) then
			current = p:GetStats():GetDiplomaticVictoryPoints();
		end

		return Locale.Lookup("LOC_WORLD_RANKINGS_DIPLOMATIC_POINTS_TT", current, total);
	end,
	GetScore = function(p)
		local current = 0;
		if (p:IsAlive()) then
			current = p:GetStats():GetDiplomaticVictoryPoints();
		end

		return current;
	end,
	AdditionalSummary = function(p) return GetDiplomaticVictoryAdditionalSummary(p) end
};

g_victoryData.VICTORY_ALTAR = {
	GetText = function(p)
		local total = GlobalParameters.DIPLOMATIC_VICTORY_POINTS_REQUIRED;
		local current = 0;
		if (p:IsAlive()) then
			current = p:GetStats():GetDiplomaticVictoryPoints();
		end

		return Locale.Lookup("LOC_WORLD_RANKINGS_DIPLOMATIC_POINTS_TT", current, total);
	end,
	GetScore = function(p)
		local current = 0;
		if (p:IsAlive()) then
			current = p:GetStats():GetDiplomaticVictoryPoints();
		end

		return current;
	end,
	AdditionalSummary = function(p) return GetDiplomaticVictoryAdditionalSummary(p) end
};

-- ===========================================================================
-- Overrides
-- ===========================================================================
function OnTabClicked(tabInst, onClickCallback)
	return function()
		DeselectPreviousTab();
		DeselectExtraTabs();
		tabInst.Selection:SetHide(false);
		onClickCallback();
	end
end

function PopulateGenericTeamInstance(instance, teamData, victoryType)
	PopulateTeamInstanceShared(instance, teamData.TeamID);

	-- Add team members to player stack
	if instance.PlayerStackIM == nil then
		instance.PlayerStackIM = InstanceManager:new("GenericInstance", "ButtonBG", instance.PlayerInstanceStack);
	end

	instance.PlayerStackIM:ResetInstances();

	for i, playerData in ipairs(teamData.PlayerData) do
		PopulateGenericInstance(instance.PlayerStackIM:GetInstance(), playerData, victoryType, true);
	end

	local requirementSetID = Game.GetVictoryRequirements(teamData.TeamID, victoryType);
	if requirementSetID ~= nil and requirementSetID ~= -1 then

		local detailsText = "";
		local innerRequirements = GameEffects.GetRequirementSetInnerRequirements(requirementSetID);

		for _, requirementID in ipairs(innerRequirements) do

			if detailsText ~= "" then
				detailsText = detailsText .. "[NEWLINE]";
			end

			local requirementKey = GameEffects.GetRequirementTextKey(requirementID, "VictoryProgress");
			local requirementText = GameEffects.GetRequirementText(requirementID, requirementKey);

			if requirementText ~= nil then
				detailsText = detailsText .. requirementText;
				local civIconClass = CivilizationIcon:AttachInstance(instance.CivilizationIcon or instance);
				if playerData ~= nil then
					civIconClass:SetLeaderTooltip(playerData.PlayerID, requirementText);
				end
			else
				local requirementState = GameEffects.GetRequirementState(requirementID);
				local requirementDetails = GameEffects.GetRequirementDefinition(requirementID);
				if requirementState == "Met" or requirementState == "AlwaysMet" then
					detailsText = detailsText .. "[ICON_CheckmarkBlue] ";
				else
					detailsText = detailsText .. "[ICON_Bolt]";
				end
				detailsText = detailsText .. requirementDetails.ID;
			end
			instance.Details:SetText(detailsText);
		end
	else
		instance.Details:LocalizeAndSetText("LOC_OPTIONS_DISABLED");
	end

	local itemSize = instance.Details:GetSizeY() + PADDING_GENERIC_ITEM_BG;
	if itemSize < SIZE_GENERIC_ITEM_MIN_Y then
		itemSize = SIZE_GENERIC_ITEM_MIN_Y;
	end

	instance.ButtonFrame:SetSizeY(itemSize);
end

function PopulateGenericInstance(instance, playerData, victoryType, showTeamDetails )
	PopulatePlayerInstanceShared(instance, playerData.PlayerID);

	if showTeamDetails then
		local requirementSetID = Game.GetVictoryRequirements(Players[playerData.PlayerID]:GetTeam(), victoryType);
		if requirementSetID ~= nil and requirementSetID ~= -1 then

			local detailsText = "";
			local innerRequirements = GameEffects.GetRequirementSetInnerRequirements(requirementSetID);

			if innerRequirements ~= nil then
				for _, requirementID in ipairs(innerRequirements) do

					if detailsText ~= "" then
						detailsText = detailsText .. "[NEWLINE]";
					end

					local requirementKey = GameEffects.GetRequirementTextKey(requirementID, "VictoryProgress");
					local requirementText = GameEffects.GetRequirementText(requirementID, requirementKey);

					if requirementText ~= nil then
						detailsText = detailsText .. requirementText;
						local civIconClass = CivilizationIcon:AttachInstance(instance.CivilizationIcon or instance);
						civIconClass:SetLeaderTooltip(playerData.PlayerID, requirementText);
					else
						local requirementState = GameEffects.GetRequirementState(requirementID);
						local requirementDetails = GameEffects.GetRequirementDefinition(requirementID);
						if requirementState == "Met" or requirementState == "AlwaysMet" then
							detailsText = detailsText .. "[ICON_CheckmarkBlue] ";
						else
							detailsText = detailsText .. "[ICON_Bolt]";
						end
						detailsText = detailsText .. requirementDetails.ID;
					end
				end
			else
				detailsText = "";
			end
			instance.Details:SetText(detailsText);
		else
			instance.Details:LocalizeAndSetText("LOC_OPTIONS_DISABLED");
		end
	else
		instance.Details:SetText("");
	end

	local itemSize = instance.Details:GetSizeY() + PADDING_GENERIC_ITEM_BG;
	if itemSize < SIZE_GENERIC_ITEM_MIN_Y then
		itemSize = SIZE_GENERIC_ITEM_MIN_Y;
	end

	instance.ButtonBG:SetSizeY(itemSize);
end

-- ===========================================================================
--	Culture victory update
-- ===========================================================================
function GetCulturalVictoryAdditionalSummary(pPlayer)
	if (g_LocalPlayer == nil) then
		return "";
	end

	local iPlayerID = pPlayer:GetID();
	local pLocalPlayerCulture = g_LocalPlayer:GetCulture();
	local pOtherPlayerCulture = pPlayer:GetCulture();
	if (pLocalPlayerCulture == nil or pOtherPlayerCulture == nil) then
		return "";
	end

	local tSummaryStrings = {};

	-- Base game additional summary, if any
	local baseDetails = BASE_GetCulturalVictoryAdditionalSummary(pPlayer);
	if (baseDetails ~= nil and baseDetails ~= "") then
		table.insert(tSummaryStrings, baseDetails);
	end

	-- Cultural Dominance summaries

	-- This is us, show the quantity of civs we dominate or that dominate us
	if (iPlayerID == g_LocalPlayerID) then
		local iNumWeDominate = 0;
		local iNumDominateUs = 0;
		for _, iLoopID in ipairs(PlayerManager.GetAliveMajorIDs()) do
			if (iLoopID ~= g_LocalPlayerID) then
				if (pLocalPlayerCulture:IsDominantOver(iLoopID)) then
					iNumWeDominate = iNumWeDominate + 1;
				else
					local pLoopPlayerCulture = Players[iLoopID]:GetCulture();
					if (pLoopPlayerCulture ~= nil and pLoopPlayerCulture:IsDominantOver(g_LocalPlayerID)) then
						iNumDominateUs = iNumDominateUs + 1;
					end
				end
			end
		end

		if iNumWeDominate > 0 then
			table.insert(tSummaryStrings, Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_CULTURE_NUM_WE_DOMINATE", iNumWeDominate));
		end
		if iNumDominateUs > 0 then
			table.insert(tSummaryStrings, Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_CULTURE_NUM_DOMINATE_US", iNumDominateUs));
		end
	else
		-- Are we/they culturally dominant
		if (pLocalPlayerCulture:IsDominantOver(iPlayerID)) then
			table.insert(tSummaryStrings, Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_CULTURE_WE_ARE_DOMINANT"));
		elseif (pOtherPlayerCulture:IsDominantOver(g_LocalPlayerID)) then
			table.insert(tSummaryStrings, Locale.Lookup("LOC_WORLD_RANKINGS_OVERVIEW_CULTURE_THEY_ARE_DOMINANT"));
		end
	end

	return FormatTableAsNewLineString(tSummaryStrings);
end

-- ===========================================================================
--	Called when Science tab is selected (or when screen re-opens if selected)
-- ===========================================================================
function ViewScience()
	ResetState(ViewScience);
	Controls.ScienceView:SetHide(false);

	ChangeActiveHeader("VICTORY_TECHNOLOGY", m_ScienceHeaderIM, Controls.ScienceViewHeader);
	PopulateGenericHeader(RealizeScienceStackSize, SCIENCE_TITLE, "", SCIENCE_DETAILS, SCIENCE_ICON);

	local totalCost = 0;
	local currentProgress = 0;
	local progressText = "";
	local progressResults = { 0, 0, 0, 0 }; -- initialize with 3 elements
	local finishedProjects = { {}, {}, {}, {} };

	local bHasSpaceport = false;
	if (g_LocalPlayer ~= nil) then
		for _,district in g_LocalPlayer:GetDistricts():Members() do
			if (district ~= nil and district:IsComplete() and district:GetType() == SPACE_PORT_DISTRICT_INFO.Index) then
				bHasSpaceport = true;
				break;
			end
		end

		local pPlayerStats = g_LocalPlayer:GetStats();
		local pPlayerCities = g_LocalPlayer:GetCities();
		for _, city in pPlayerCities:Members() do
			local pBuildQueue = city:GetBuildQueue();
			-- 1st milestone - satellite launch
			totalCost = 0;
			currentProgress = 0;
			for i, projectInfo in ipairs(EARTH_SATELLITE_EXP2_PROJECT_INFOS) do
				local projectCost = pBuildQueue:GetProjectCost(projectInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumProjectsAdvanced(projectInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetProjectProgress(projectInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[1][i] = projectProgress == projectCost;
			end
			progressResults[1] = currentProgress / totalCost;

			-- 2nd milestone - moon landing
			totalCost = 0;
			currentProgress = 0;
			for i, projectInfo in ipairs(MOON_LANDING_EXP2_PROJECT_INFOS) do
				local projectCost = pBuildQueue:GetProjectCost(projectInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumProjectsAdvanced(projectInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetProjectProgress(projectInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[2][i] = projectProgress == projectCost;
			end
			progressResults[2] = currentProgress / totalCost;

			-- 3rd milestone - mars landing
			totalCost = 0;
			currentProgress = 0;
			for i, projectInfo in ipairs(MARS_COLONY_EXP2_PROJECT_INFOS) do
				local projectCost = pBuildQueue:GetProjectCost(projectInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumProjectsAdvanced(projectInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetProjectProgress(projectInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[3][i] = projectProgress == projectCost;
			end
			progressResults[3] = currentProgress / totalCost;

			-- 4th milestone - exoplanet expeditiion
			totalCost = 0;
			currentProgress = 0;
			for i, projectInfo in ipairs(EXOPLANET_EXP2_PROJECT_INFOS) do
				local projectCost = pBuildQueue:GetProjectCost(projectInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumProjectsAdvanced(projectInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetProjectProgress(projectInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[4][i] = projectProgress == projectCost;
			end
			progressResults[4] = currentProgress / totalCost;
		end
	end

	local nextStep = "";
	for i, result in ipairs(progressResults) do
		if(result < 1) then
			progressText = progressText .. "[ICON_Bolt]";
			if(nextStep == "") then
				nextStep = GetNextStepForScienceProject(g_LocalPlayer, SCIENCE_PROJECTS_EXP2[i], bHasSpaceport, finishedProjects[i]);
			end
		else
			progressText = progressText .. "[ICON_CheckmarkBlue] ";
		end
		progressText = progressText .. SCIENCE_REQUIREMENTS[i] .. "[NEWLINE]";
	end

	-- Final milestone - Earning Victory Points (Light Years)
	local totalLightYears = g_LocalPlayer:GetStats():GetScienceVictoryPointsTotalNeeded();
	local lightYears = g_LocalPlayer:GetStats():GetScienceVictoryPoints();
	if (lightYears < totalLightYears) then
		progressText = progressText .. "[ICON_Bolt]";
	else
		progressText = progressText .. "[ICON_CheckmarkBlue]";
	end
	progressText = progressText .. Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_REQUIREMENT_FINAL", totalLightYears);

	g_activeheader.AdvisorTextCentered:SetText(progressText);
    if (nextStep ~= "") then
        g_activeheader.AdvisorTextNextStep:SetText(Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NEXT_STEP", nextStep));
	else
		-- If the user One More Turns, this keeps rolling in the DLL and makes us look goofy.
		if lightYears > totalLightYears then
			lightYears = totalLightYears;
		end

        g_activeheader.AdvisorTextNextStep:SetText(Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_HAS_MOVED", lightYears, totalLightYears));
    end

	m_ScienceIM:ResetInstances();
	m_ScienceTeamIM:ResetInstances();

	for teamID, team in pairs(Teams) do
		if teamID >= 0 then
			if #team > 1 then
				PopulateScienceTeamInstance(m_ScienceTeamIM:GetInstance(), teamID);
			else
				local pPlayer = Players[team[1]];
				if (pPlayer:IsAlive() == true and pPlayer:IsMajor() == true) then
					PopulateScienceInstance(m_ScienceIM:GetInstance(), pPlayer);
				end
			end
		end
	end

	RealizeScienceStackSize();
end

function GetNextStepForScienceProject(pPlayer, projectInfos, bHasSpaceport, finishedProjects)

	if(not bHasSpaceport) then
		return Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NEXT_STEP_BUILD", Locale.Lookup(SPACE_PORT_DISTRICT_INFO.Name));
	end

	local playerTech = pPlayer:GetTechs();
	local numProjectInfos = table.count(projectInfos);
	for i, projectInfo in ipairs(projectInfos) do

		if(projectInfo.PrereqTech ~= nil) then
			local tech = GameInfo.Technologies[projectInfo.PrereqTech];
			if(not playerTech:HasTech(tech.Index)) then
				return Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NEXT_STEP_RESEARCH", Locale.Lookup(tech.Name));
			end
		end

		if(not finishedProjects[i]) then
			return Locale.Lookup(projectInfo.Name);
		end
	end
	return "";
end


function PopulateScienceInstance(instance, pPlayer)
	local playerID = pPlayer:GetID();
	PopulatePlayerInstanceShared(instance, playerID);

	-- Progress Data to be returned from function
	local progressData = nil;

	local bHasSpaceport = false;
	for _,district in pPlayer:GetDistricts():Members() do
		if (district ~= nil and district:IsComplete() and district:GetType() == SPACE_PORT_DISTRICT_INFO.Index) then
			bHasSpaceport = true;
			break;
		end
	end

	local pPlayerStats = pPlayer:GetStats();
	local pPlayerCities = pPlayer:GetCities();
	local projectTotals = { 0, 0, 0, 0 };
	local projectProgresses = { 0, 0, 0, 0 };
	local finishedProjects = { {}, {}, {}, {} };
	for _, city in pPlayerCities:Members() do
		local pBuildQueue = city:GetBuildQueue();

		-- 1st milestone - satelite launch
		for i, projectInfo in ipairs(EARTH_SATELLITE_EXP2_PROJECT_INFOS) do
			local projectCost = pBuildQueue:GetProjectCost(projectInfo.Index);
			local projectProgress = projectCost;
			if pPlayerStats:GetNumProjectsAdvanced(projectInfo.Index) == 0 then
				projectProgress = pBuildQueue:GetProjectProgress(projectInfo.Index);
			end
			finishedProjects[1][i] = false;
			if projectProgress ~= 0 then
				projectTotals[1] = projectTotals[1] + projectCost;
				projectProgresses[1] = projectProgresses[1] + projectProgress;
				finishedProjects[1][i] = projectProgress == projectCost;
			end
		end

		-- 2nd milestone - moon landing
		for i, projectInfo in ipairs(MOON_LANDING_EXP2_PROJECT_INFOS) do
			local projectCost = pBuildQueue:GetProjectCost(projectInfo.Index);
			local projectProgress = projectCost;
			if pPlayerStats:GetNumProjectsAdvanced(projectInfo.Index) == 0 then
				projectProgress = pBuildQueue:GetProjectProgress(projectInfo.Index);
			end
			finishedProjects[2][i] = false;
			if projectProgress ~= 0 then
				projectTotals[2] = projectTotals[2] + projectCost;
				projectProgresses[2] = projectProgresses[2] + projectProgress;
				finishedProjects[2][i] = projectProgress == projectCost;
			end
		end

		-- 3rd milestone - mars landing
		for i, projectInfo in ipairs(MARS_COLONY_EXP2_PROJECT_INFOS) do
			local projectCost = pBuildQueue:GetProjectCost(projectInfo.Index);
			local projectProgress = projectCost;
			if pPlayerStats:GetNumProjectsAdvanced(projectInfo.Index) == 0 then
				projectProgress = pBuildQueue:GetProjectProgress(projectInfo.Index);
			end
			finishedProjects[3][i] = false;
			projectTotals[3] = projectTotals[3] + projectCost;
			if projectProgress ~= 0 then
				projectProgresses[3] = projectProgresses[3] + projectProgress;
				finishedProjects[3][i] = projectProgress == projectCost;
			end
		end

		-- 4th milestone - exoplanet expedition
		for i, projectInfo in ipairs(EXOPLANET_EXP2_PROJECT_INFOS) do
			local projectCost = pBuildQueue:GetProjectCost(projectInfo.Index);
			local projectProgress = projectCost;
			if pPlayerStats:GetNumProjectsAdvanced(projectInfo.Index) == 0 then
				projectProgress = pBuildQueue:GetProjectProgress(projectInfo.Index);
			end
			finishedProjects[4][i] = false;
			projectTotals[4] = projectTotals[4] + projectCost;
			if projectProgress ~= 0 then
				projectProgresses[4] = projectProgresses[4] + projectProgress;
				finishedProjects[4][i] = projectProgress == projectCost;
			end
		end
	end

	-- Save data to be returned
	progressData = {};
	progressData.playerID = playerID;
	progressData.projectTotals = projectTotals;
	progressData.projectProgresses = projectProgresses;
	progressData.bHasSpaceport = bHasSpaceport;
	progressData.finishedProjects = finishedProjects;

	PopulateScienceProgressMeters(instance, progressData);

	return progressData;
end

function GetTooltipForScienceProject(pPlayer, projectInfos, bHasSpaceport, finishedProjects)

	local result = "";

	-- Only show spaceport for first tooltip
	if bHasSpaceport ~= nil then
		if(bHasSpaceport) then
			result = result .. "[ICON_CheckmarkBlue]";
		else
			result = result .. "[ICON_Bolt]";
		end
		result = result .. Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NEXT_STEP_BUILD", Locale.Lookup(SPACE_PORT_DISTRICT_INFO.Name)) .. "[NEWLINE]";
	end

	local playerTech = pPlayer:GetTechs();
	local numProjectInfos = table.count(projectInfos);
	for i, projectInfo in ipairs(projectInfos) do

		if(projectInfo.PrereqTech ~= nil) then
			local tech = GameInfo.Technologies[projectInfo.PrereqTech];
			if(playerTech:HasTech(tech.Index)) then
				result = result .. "[ICON_CheckmarkBlue]";
			else
				result = result .. "[ICON_Bolt]";
			end
			result = result .. Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NEXT_STEP_RESEARCH", Locale.Lookup(tech.Name)) .. "[NEWLINE]";
		end

		if(finishedProjects[i]) then
			result = result .. "[ICON_CheckmarkBlue]";
		else
			result = result .. "[ICON_Bolt]";
		end
		result = result .. Locale.Lookup(projectInfo.Name);
		if(i < numProjectInfos) then result = result .. "[NEWLINE]"; end
	end

	return result;
end

function PopulateScienceProgressMeters(instance, progressData)
	local pPlayer = Players[progressData.playerID];

	for i = 1, 4 do
		instance["ObjHidden_" .. i]:SetHide(true);
		instance["ObjFill_" .. i]:SetHide(progressData.projectProgresses[i] == 0);
		instance["ObjBar_" .. i]:SetPercent(progressData.projectProgresses[i] / progressData.projectTotals[i]);
		instance["ObjToggle_ON_" .. i]:SetHide(progressData.projectTotals[i] == 0 or progressData.projectProgresses[i] ~= progressData.projectTotals[i]);
	end

    instance["ObjHidden_5"]:SetHide(true);
    -- if bar 4 is at 100%, light up bar 5
    if ((progressData.projectProgresses[4] >= progressData.projectTotals[4]) and (progressData.projectTotals[4] ~= 0)) then
		local lightYears = pPlayer:GetStats():GetScienceVictoryPoints();
		local lightYearsPerTurn = pPlayer:GetStats():GetScienceVictoryPointsPerTurn();
		local totalLightYears = g_LocalPlayer:GetStats():GetScienceVictoryPointsTotalNeeded();

		instance["ObjFill_5"]:SetHide(false);
        instance["ObjToggle_ON_5"]:SetHide(lightYears == 0 or lightYears < lightYearsPerTurn);
        -- my test save returns a larger value for light years than for years needed, so guard against drawing errors
        if lightYears > totalLightYears then
            lightYears = totalLightYears;
        end
        instance["ObjBar_5"]:SetPercent(lightYears/totalLightYears);
		instance.ObjBG_5:SetToolTipString(Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_IS_MOVING", lightYearsPerTurn));
    else
        instance["ObjFill_5"]:SetHide(true);
        instance["ObjToggle_ON_5"]:SetHide(true);
        instance["ObjBar_5"]:SetPercent(0);
		instance.ObjBG_5:SetToolTipString(Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NO_LAUNCH"));
    end

	instance.ObjBG_1:SetToolTipString(GetTooltipForScienceProject(pPlayer, EARTH_SATELLITE_EXP2_PROJECT_INFOS, progressData.bHasSpaceport, progressData.finishedProjects[1]));
	instance.ObjBG_2:SetToolTipString(GetTooltipForScienceProject(pPlayer, MOON_LANDING_EXP2_PROJECT_INFOS, nil, progressData.finishedProjects[2]));
	instance.ObjBG_3:SetToolTipString(GetTooltipForScienceProject(pPlayer, MARS_COLONY_EXP2_PROJECT_INFOS, nil, progressData.finishedProjects[3]));
	instance.ObjBG_4:SetToolTipString(GetTooltipForScienceProject(pPlayer, EXOPLANET_EXP2_PROJECT_INFOS, nil, progressData.finishedProjects[4]));
end

-- ===========================================================================
--	Called once during Init
-- ===========================================================================
function PopulateTabs()

	-- Clean up previous data
	m_ExtraTabs = {};
	m_TotalTabSize = 0;
	m_MaxExtraTabSize = 0;
	g_ExtraTabsIM:ResetInstances();
	g_TabSupportIM:ResetInstances();
	
	-- Deselect previously selected tab
	if g_TabSupport then
		g_TabSupport.SelectTab(nil);
		DeselectPreviousTab();
		DeselectExtraTabs();
	end

	-- Create TabSupport object
	g_TabSupport = CreateTabs(Controls.TabContainer, 42, 44, UI.GetColorValueFromHexLiteral(0xFF331D05));

	local defaultTab = AddTab(TAB_OVERALL, ViewOverall);

	-- Add default victory types in a pre-determined order
	if(GameConfiguration.IsAnyMultiplayer() or Game.IsVictoryEnabled("VICTORY_SCORE")) then
		BASE_AddTab(TAB_SCORE, ViewScore);
	end
	if(Game.IsVictoryEnabled("VICTORY_TECHNOLOGY")) then
		AddTab(TAB_SCIENCE, ViewScience);
	end
	if(Game.IsVictoryEnabled("VICTORY_CULTURE")) then
		g_CultureInst = AddTab(TAB_CULTURE, ViewCulture);
	end
	if(Game.IsVictoryEnabled("VICTORY_CONQUEST")) then
		AddTab(TAB_DOMINATION, ViewDomination);
	end
	if(Game.IsVictoryEnabled("VICTORY_RELIGIOUS")) then
		AddTab(TAB_RELIGION, ViewReligion);
	end

	-- Add custom (modded) victory types
	for row in GameInfo.Victories() do
   	local victoryType = row.VictoryType;
		if IsCustomVictoryType(victoryType) and Game.IsVictoryEnabled(victoryType) then
			if (victoryType == "VICTORY_DIPLOMATIC") then
				AddTab(Locale.Lookup("LOC_TOOLTIP_DIPLOMACY_CONGRESS_BUTTON"), function() ViewDiplomatic(victoryType); end);
			elseif (victoryType == "VICTORY_TOWER_OF_MASTERY") then
				AddTab(Locale.Lookup("LOC_TOOLTIP_DIPLOMACY_CONGRESS_BUTTON"), function() ViewTowerMastery(victoryType); end);
			elseif (victoryType == "VICTORY_ALTAR_OF_LUONNOTAR") then
				AddTab(Locale.Lookup("LOC_TOOLTIP_DIPLOMACY_CONGRESS_BUTTON"), function() ViewDiplomatic(victoryType); end);
			else
				AddTab(Locale.Lookup(row.Name), function() ViewGeneric(victoryType); end);
			end
		end
	end

	if m_TotalTabSize > (Controls.TabContainer:GetSizeX()*2) then
		Controls.ExpandExtraTabs:SetHide(false);
		for _, tabInst in pairs(m_ExtraTabs) do
			tabInst.Button:SetSizeX(m_MaxExtraTabSize);
		end
	else
		Controls.ExpandExtraTabs:SetHide(true);
	end

	Controls.ExpandExtraTabs:SetHide(true);

	g_TabSupport.SelectTab(defaultTab);
	g_TabSupport.CenterAlignTabs(0, 450, 32);
end

function AddTab(label, onClickCallback)

	local tabInst = g_TabSupportIM:GetInstance();
	tabInst.Button[DATA_FIELD_SELECTION] = tabInst.Selection;

	tabInst.Button:SetText(label);
	local textControl = tabInst.Button:GetTextControl();
	textControl:SetHide(false);

	local textSize = textControl:GetSizeX();
	tabInst.Button:SetSizeX(textSize + PADDING_TAB_BUTTON_TEXT);
	tabInst.Button:RegisterCallback(Mouse.eMouseEnter,	function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	tabInst.Selection:SetSizeX(textSize + PADDING_TAB_BUTTON_TEXT + 4);

	m_TotalTabSize = m_TotalTabSize + tabInst.Button:GetSizeX();
	if m_TotalTabSize > (Controls.TabContainer:GetSizeX() * 2) then
		g_TabSupportIM:ReleaseInstance(tabInst);
		AddExtraTab(label, onClickCallback);
	else
		g_TabSupport.AddTab(tabInst.Button, OnTabClicked(tabInst, onClickCallback));
	end

	return tabInst.Button;
end

function AddExtraTab(label, onClickCallback)
	local extraTabInst = g_ExtraTabsIM:GetInstance();

	extraTabInst.Button:SetText(label);
	extraTabInst.Button:RegisterCallback(Mouse.eLClick, OnExtraTabClicked(extraTabInst, onClickCallback));

	local textControl = extraTabInst.Button:GetTextControl();
	local textSize = textControl:GetSizeX();
	extraTabInst.Button:SetSizeX(textSize + PADDING_TAB_BUTTON_TEXT);
	extraTabInst.Button:RegisterCallback(Mouse.eMouseEnter,	function() UI.PlaySound("Main_Menu_Mouse_Over"); end);

	local tabSize = extraTabInst.Button:GetSizeX();
	if tabSize > m_MaxExtraTabSize then
		m_MaxExtraTabSize = tabSize;
	end

	table.insert(m_ExtraTabs, extraTabInst);
end

function ViewDiplomatic(victoryType)
	ResetState(function() ViewDiplomatic(victoryType); end);
	Controls.GenericView:SetHide(false);

	ChangeActiveHeader("GENERIC", m_GenericHeaderIM, Controls.GenericViewHeader);

	local victoryInfo = GameInfo.Victories[victoryType];
    if victoryInfo.Icon ~= nil then
        PopulateGenericHeader(RealizeGenericStackSize, victoryInfo.Name, nil, victoryInfo.Description, victoryInfo.Icon);
    else
        PopulateGenericHeader(RealizeGenericStackSize, victoryInfo.Name, nil, victoryInfo.Description, ICON_GENERIC);
    end

	local genericData = GatherGenericData();

	g_GenericIM:ResetInstances();
	g_GenericTeamIM:ResetInstances();

	local ourData = {};

	for i, teamData in ipairs(genericData) do
		local ourTeamData = { teamData, score };

		ourTeamData.teamData = teamData;
		local progress = Game.GetVictoryProgressForTeam(victoryType, teamData.TeamID);
		if progress == nil then
			progress = 0;
		end
		ourTeamData.score = progress;

		table.insert(ourData, ourTeamData);
	end

	table.sort(ourData, function(a, b)
		return a.score > b.score;
	end);

	for i, theData in ipairs(ourData) do
		if #theData.teamData.PlayerData > 1 then
			PopulateGenericTeamInstance(g_GenericTeamIM:GetInstance(), theData.teamData, victoryType);
		else
			local uiGenericInstance = g_GenericIM:GetInstance();
			local pPlayer = Players[theData.teamData.PlayerData[1].PlayerID];
			if pPlayer ~= nil then
				local pStats = pPlayer:GetStats();
				if pStats == nil then
					UI.DataError("Stats not found for PlayerID:" .. theData.teamData.PlayerData[1].PlayerID .. "! WorldRankings XP2");
					return;
				end
				uiGenericInstance.ButtonBG:SetToolTipString(pStats:GetDiplomaticVictoryPointsTooltip());
			end
			PopulateGenericInstance(uiGenericInstance, theData.teamData.PlayerData[1], victoryType, true);
		end
	end

	RealizeGenericStackSize();
end

function GetDiplomaticVictoryAdditionalSummary(pPlayer)
	-- Add or override in expansions
	return "";
end

function GetDefaultStackSize()
    return 265;
end

-- modded

function ViewTowerMastery(victoryType)
	ResetState(function() ViewTowerMastery(victoryType); end);
	Controls.TowerView:SetHide(false);

	ChangeActiveHeader("VICTORY_TECHNOLOGY", m_TowerHeaderIM, Controls.TowerViewHeader);
	PopulateGenericHeader(RealizeTowerStackSize, 'LOC_TOWER_OF_MASTERY_VICTORY', "", 'Gather Mana Sources to allow building powerful Tower National Wonders. Once you have all 4 Towers, build the Tower Of Mastery to become unbound from the rules of magic, shaping reality to your whim, winning the game.', SCIENCE_ICON);

	local totalCost = 0;
	local currentProgress = 0;
	local progressText = "";
	local progressResults = { 0, 0, 0, 0, 0 }; -- initialize with 3 elements
	local finishedProjects = { {}, {}, {}, {}, {} };

	if (g_LocalPlayer ~= nil) then
		local pPlayerStats = g_LocalPlayer:GetStats();
		local pPlayerCities = g_LocalPlayer:GetCities();
		for _, city in pPlayerCities:Members() do
			local pBuildQueue = city:GetBuildQueue();
			-- 1st milestone - satellite launch
			totalCost = 0;
			currentProgress = 0;
			for i, buildingInfo in ipairs(TOWER_ALTERATION) do
				local projectCost = pBuildQueue:GetBuildingCost(buildingInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumBuildingsOfType(buildingInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetBuildingProgress(buildingInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[1][i] = projectProgress == projectCost;
			end
			progressResults[1] = currentProgress / totalCost;

			-- 2nd milestone - moon landing
			totalCost = 0;
			currentProgress = 0;
			for i, buildingInfo in ipairs(TOWER_DIVINATION) do
				local projectCost = pBuildQueue:GetBuildingCost(buildingInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumBuildingsOfType(buildingInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetBuildingProgress(buildingInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[2][i] = projectProgress == projectCost;
			end
			progressResults[2] = currentProgress / totalCost;

			-- 3rd milestone - mars landing
			totalCost = 0;
			currentProgress = 0;
			for i, buildingInfo in ipairs(TOWER_ELEMENTS) do
				local projectCost = pBuildQueue:GetBuildingCost(buildingInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumBuildingsOfType(buildingInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetBuildingProgress(buildingInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[3][i] = projectProgress == projectCost;
			end
			progressResults[3] = currentProgress / totalCost;

			totalCost = 0;
			currentProgress = 0;
			for i, buildingInfo in ipairs(TOWER_NECROMANCY) do
				local projectCost = pBuildQueue:GetBuildingCost(buildingInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumBuildingsOfType(buildingInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetBuildingProgress(buildingInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[4][i] = projectProgress == projectCost;
			end
			progressResults[4] = currentProgress / totalCost;

			-- 4th milestone - exoplanet expeditiion
			totalCost = 0;
			currentProgress = 0;
			for i, buildingInfo in ipairs(TOWER_MASTERY) do
				local projectCost = pBuildQueue:GetBuildingCost(buildingInfo.Index);
				local projectProgress = projectCost;
				if pPlayerStats:GetNumBuildingsOfType(buildingInfo.Index) == 0 then
					projectProgress = pBuildQueue:GetBuildingProgress(buildingInfo.Index);
				end
				totalCost = totalCost + projectCost;
				currentProgress = currentProgress + projectProgress;
				finishedProjects[5][i] = projectProgress == projectCost;
			end
			progressResults[5] = currentProgress / totalCost;
		end
	end
	local nextStep = "";
	for i, result in ipairs(progressResults) do
		if(result < 1) then
			progressText = progressText .. "[ICON_Bolt]";
			if(nextStep == "") then
				nextStep = GetNextStepForTowerBuildings(g_LocalPlayer, TOWERS[i], finishedProjects[i]);
			end
		else
			progressText = progressText .. "[ICON_CheckmarkBlue] ";
		end
		progressText = progressText .. TOWER_REQUIREMENTS[i] .. "[NEWLINE]";
	end

	m_TowerIM:ResetInstances();
	m_TowerTeamIM:ResetInstances();

	for teamID, team in pairs(Teams) do
		if teamID >= 0 then
			if #team > 1 then
				PopulateTowerTeamInstance(m_TowerTeamIM:GetInstance(), teamID);
			else
				local pPlayer = Players[team[1]];
				if (pPlayer:IsAlive() == true and pPlayer:IsMajor() == true) then
					PopulateTowerInstance(m_TowerIM:GetInstance(), pPlayer);
				end
			end
		end
	end

	RealizeTowerStackSize();
end

function GetNextStepForTowerBuildings(pPlayer, projectInfos, finishedProjects)

	-- if(not bHasSpaceport) then 		-- TODO use this if needs more mana
	--	return Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NEXT_STEP_BUILD", Locale.Lookup(SPACE_PORT_DISTRICT_INFO.Name));
	-- end

	local playerTech = pPlayer:GetTechs();
	local numProjectInfos = table.count(projectInfos);
	for i, projectInfo in ipairs(projectInfos) do

		if(projectInfo.PrereqTech ~= nil) then
			local tech = GameInfo.Technologies[projectInfo.PrereqTech];
			if(not playerTech:HasTech(tech.Index)) then
				return Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NEXT_STEP_RESEARCH", Locale.Lookup(tech.Name));
			end
		end

		if(not finishedProjects[i]) then
			return Locale.Lookup(projectInfo.Name);
		end
	end
	return "";
end

function PopulateTowerTeamInstance(instance, teamID)

	PopulateTeamInstanceShared(instance, teamID);

	-- Add team members to player stack
	if instance.PlayerStackIM == nil then
		instance.PlayerStackIM = InstanceManager:new("TowerInstance", "ButtonBG", instance.TowerPlayerInstanceStack);
	end

	instance.PlayerStackIM:ResetInstances();

	local teamProgressData = {};
	for i, playerID in ipairs(Teams[teamID]) do
		if IsAliveAndMajor(playerID) then
			local pPlayer = Players[playerID];
			local progressData = PopulateTowerInstance(instance.PlayerStackIM:GetInstance(), pPlayer);
			if progressData then
				table.insert(teamProgressData, progressData);
			end
		end
	end

	-- Sort team progress data
	table.sort(teamProgressData, function(a, b)
		-- Compare stage 1 progress
		local aScore = a.projectProgresses[1] / a.projectTotals[1];
		local bScore = b.projectProgresses[1] / b.projectTotals[1];
		if aScore == bScore then
			-- Compare stage 2 progress
			aScore = a.projectProgresses[2] / a.projectTotals[2];
			bScore = b.projectProgresses[2] / b.projectTotals[2];
			if aScore == bScore then
				-- Compare stage 3 progress
				aScore = a.projectProgresses[3] / a.projectTotals[3];
				bScore = b.projectProgresses[3] / b.projectTotals[3];
				if aScore == bScore then
					return a.playerID < b.playerID;
				end
			end
		end
		return aScore > bScore;
	end);

	-- Populate the team progress with the progress of the furthest player
	if teamProgressData and #teamProgressData > 0 then
		PopulateTowerProgressMeters(instance, teamProgressData[1]);
	end
end

function PopulateTowerInstance(instance, pPlayer)
	local playerID = pPlayer:GetID();
	PopulatePlayerInstanceShared(instance, playerID);

	-- Progress Data to be returned from function
	local progressData = nil;

	local pPlayerStats = pPlayer:GetStats();
	local pPlayerCities = pPlayer:GetCities();
	local projectTotals = { 0, 0, 0, 0, 0 };
	local projectProgresses = { 0, 0, 0, 0, 0 };
	local finishedProjects = { {}, {}, {}, {}, {} };
	for _, city in pPlayerCities:Members() do
		local pBuildQueue = city:GetBuildQueue();

		-- 1st milestone - satelite launch
		for i, projectInfo in ipairs(TOWER_ALTERATION) do
			local projectCost = pBuildQueue:GetBuildingCost(projectInfo.Index);
			local projectProgress = projectCost;
			if pPlayerStats:GetNumBuildingsOfType(projectInfo.Index) == 0 then
				projectProgress = pBuildQueue:GetBuildingProgress(projectInfo.Index);
			end
			finishedProjects[1][i] = false;
			if projectProgress ~= 0 then
				projectTotals[1] = projectTotals[1] + projectCost;
				projectProgresses[1] = projectProgresses[1] + projectProgress;
				finishedProjects[1][i] = projectProgress == projectCost;
			end
		end

		-- 2nd milestone - moon landing
		for i, projectInfo in ipairs(TOWER_DIVINATION) do
			local projectCost = pBuildQueue:GetBuildingCost(projectInfo.Index);
			local projectProgress = projectCost;
			if pPlayerStats:GetNumBuildingsOfType(projectInfo.Index) == 0 then
				projectProgress = pBuildQueue:GetBuildingProgress(projectInfo.Index);
			end
			finishedProjects[2][i] = false;
			if projectProgress ~= 0 then
				projectTotals[2] = projectTotals[2] + projectCost;
				projectProgresses[2] = projectProgresses[2] + projectProgress;
				finishedProjects[2][i] = projectProgress == projectCost;
			end
		end

		-- 3rd milestone - mars landing
		for i, projectInfo in ipairs(TOWER_ELEMENTS) do
			local projectCost = pBuildQueue:GetBuildingCost(projectInfo.Index);
			local projectProgress = projectCost;
			if pPlayerStats:GetNumBuildingsOfType(projectInfo.Index) == 0 then
				projectProgress = pBuildQueue:GetBuildingProgress(projectInfo.Index);
			end
			finishedProjects[3][i] = false;
			projectTotals[3] = projectTotals[3] + projectCost;
			if projectProgress ~= 0 then
				projectProgresses[3] = projectProgresses[3] + projectProgress;
				finishedProjects[3][i] = projectProgress == projectCost;
			end
		end

		-- 4th milestone - exoplanet expedition
		for i, projectInfo in ipairs(TOWER_NECROMANCY) do
			local projectCost = pBuildQueue:GetBuildingCost(projectInfo.Index);
			local projectProgress = projectCost;
			if pPlayerStats:GetNumBuildingsOfType(projectInfo.Index) == 0 then
				projectProgress = pBuildQueue:GetBuildingProgress(projectInfo.Index);
			end
			finishedProjects[4][i] = false;
			projectTotals[4] = projectTotals[4] + projectCost;
			if projectProgress ~= 0 then
				projectProgresses[4] = projectProgresses[4] + projectProgress;
				finishedProjects[4][i] = projectProgress == projectCost;
			end
		end
	end

	-- Save data to be returned
	progressData = {};
	progressData.playerID = playerID;
	progressData.projectTotals = projectTotals;
	progressData.projectProgresses = projectProgresses;
	progressData.bHasSpaceport = true;
	progressData.finishedProjects = finishedProjects;

	PopulateTowerProgressMeters(instance, progressData);

	return progressData;
end

function PopulateTowerProgressMeters(instance, progressData)
	local pPlayer = Players[progressData.playerID];

	for i = 1, 5 do
		instance["ObjHidden_" .. i]:SetHide(true);
		instance["ObjFill_" .. i]:SetHide(progressData.projectProgresses[i] == 0);
		instance["ObjBar_" .. i]:SetPercent(progressData.projectProgresses[i] / progressData.projectTotals[i]);
		instance["ObjToggle_ON_" .. i]:SetHide(progressData.projectTotals[i] == 0 or progressData.projectProgresses[i] ~= progressData.projectTotals[i]);
	end
	instance.ObjBG_1:SetToolTipString(GetTooltipForTowerProject(pPlayer, TOWER_ALTERATION, progressData.finishedProjects[1]));
	instance.ObjBG_2:SetToolTipString(GetTooltipForTowerProject(pPlayer, TOWER_DIVINATION, progressData.finishedProjects[2]));
	instance.ObjBG_3:SetToolTipString(GetTooltipForTowerProject(pPlayer, TOWER_ELEMENTS,  progressData.finishedProjects[3]));
	instance.ObjBG_4:SetToolTipString(GetTooltipForTowerProject(pPlayer, TOWER_NECROMANCY,  progressData.finishedProjects[4]));
end

function GetTooltipForTowerProject(pPlayer, projectInfos, finishedProjects)

	local result = "";

	local playerTech = pPlayer:GetTechs();
	local numProjectInfos = table.count(projectInfos);
	for i, projectInfo in ipairs(projectInfos) do

		if(projectInfo.PrereqTech ~= nil) then
			local tech = GameInfo.Technologies[projectInfo.PrereqTech];
			if(playerTech:HasTech(tech.Index)) then
				result = result .. "[ICON_CheckmarkBlue]";
			else
				result = result .. "[ICON_Bolt]";
			end
			result = result .. Locale.Lookup("LOC_WORLD_RANKINGS_SCIENCE_NEXT_STEP_RESEARCH", Locale.Lookup(tech.Name)) .. "[NEWLINE]";
		end

		if(finishedProjects[i]) then
			result = result .. "[ICON_CheckmarkBlue]";
		else
			result = result .. "[ICON_Bolt]";
		end
		result = result .. Locale.Lookup(projectInfo.Name);
		if(i < numProjectInfos) then result = result .. "[NEWLINE]"; end
	end

	return result;
end

function RealizeTowerStackSize()
	local _, screenY = UIManager:GetScreenSizeVal();

	if(g_activeheader[DATA_FIELD_HEADER_EXPANDED]) then
		local headerHeight = g_activeheader[DATA_FIELD_HEADER_HEIGHT];
		headerHeight = headerHeight + g_activeheader.AdvisorTextCentered:GetSizeY() + g_activeheader.AdvisorTextNextStep:GetSizeY() + (PADDING_HEADER * 2);
		g_activeheader.AdvisorIcon:SetOffsetY(OFFSET_ADVISOR_ICON_Y + headerHeight);
		g_activeheader.HeaderFrame:SetSizeY(OFFSET_ADVISOR_TEXT_Y + headerHeight);
		g_activeheader.ContractHeaderButton:SetOffsetY(OFFSET_CONTRACT_BUTTON_Y + headerHeight);
		Controls.TowerViewContents:SetOffsetY(OFFSET_VIEW_CONTENTS + headerHeight + PADDING_HEADER);
		Controls.TowerViewScrollbar:SetSizeY(screenY - (SIZE_STACK_DEFAULT + (headerHeight + PADDING_HEADER)));
		g_activeheader.AdvisorTextCentered:SetHide(false);
		g_activeheader.AdvisorTextNextStep:SetHide(false);
	else
		Controls.TowerViewContents:SetOffsetY(OFFSET_VIEW_CONTENTS);
		Controls.TowerViewScrollbar:SetSizeY(screenY - SIZE_STACK_DEFAULT);
		g_activeheader.AdvisorTextCentered:SetHide(true);
		g_activeheader.AdvisorTextNextStep:SetHide(true);
	end

	RealizeStackAndScrollbar(Controls.TowerViewStack, Controls.TowerViewScrollbar, true);

	--local textSize:number = Controls.ScienceDetailsButton:GetTextControl():GetSizeX();
	--Controls.ScienceDetailsButton:SetSizeX(textSize + PADDING_SCORE_DETAILS_BUTTON_WIDTH);
end



function ResetState(newView)
	g_activeheader = nil;
	m_ActiveViewUpdate = newView;
	Controls.OverallView:SetHide(true);
	Controls.ScoreView:SetHide(true);
	Controls.ScienceView:SetHide(true);
	Controls.CultureView:SetHide(true);
	Controls.DominationView:SetHide(true);
	Controls.ReligionView:SetHide(true);
	Controls.GenericView:SetHide(true);
	Controls.TowerView:SetHide(true);

	-- Reset tourism lens unless we're now view the Culture tab
	if newView ~= ViewCulture then
		ResetTourismLens();
	end

	DeactivateReligionLens();
end

-- ===========================================================================
-- Constructor
-- ===========================================================================
function Initialize()
	ToggleExtraTabs(); -- Start with extra tabs opened so DiplomaticVictory tab is visible by default
end
Initialize();
print('load in new world ranking---------------------------------------------------')