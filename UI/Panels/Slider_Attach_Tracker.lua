include("SliderSupport");

local m_CheatPanelState = 0;

function AttachPanelToWorldTracker()
	if (m_IsLoading) then
		return;
	end
	if (not m_IsAttached) then
		local worldTrackerPanel = ContextPtr:LookUpControl("/InGame/WorldTracker/PanelStack");
		if (worldTrackerPanel ~= nil) then
			Controls.CheatPanel:ChangeParent(worldTrackerPanel);
			worldTrackerPanel:AddChildAtIndex(Controls.CheatPanel, 1);
			worldTrackerPanel:CalculateSize();
			worldTrackerPanel:ReprocessAnchoring();
			m_IsAttached = true;
		end
	end
end

-- // ----------------------------------------------------------------------------------------------
-- // Attach Panel To WorldTracker
-- // ----------------------------------------------------------------------------------------------
function OnLoadGameViewStateDone()
	AttachPanelToWorldTracker();
end

-- // ----------------------------------------------------------------------------------------------
-- // Panel Control and Checkbox Attach
-- // ----------------------------------------------------------------------------------------------
function UpdateCheatPanel(hideCheatPanel)
	m_hideCheatPanel = hideCheatPanel; 
	Controls.CheatPanel:SetHide(m_hideCheatPanel);
	Controls.ToggleCheatPanel:SetCheck(not m_hideCheatPanel);
end
function InitDropdown()
	local parent = ContextPtr:LookUpControl("/InGame/WorldTracker/CivicsCheckButton",	Controls.PanelStack );
	if parent == nil then return end;
	Controls.CheatPanelStack:ChangeParent(parent);
	parent.ReprocessAnchoring();
	Events.LoadGameViewStateDone.Remove(InitDropdown);
end

-- ====================================================================================================
--	If the official Civ6 Expansion "Rise and Fall" (XP1) and "Gathering Storm" (XP2) is active.
-- ====================================================================================================
-- ====================================================================================================
local iPlayer = Game.GetLocalPlayer()
local pPlayer = Players[iPlayer]
local iCommerceGold = 10
local iCommerceScience = 0
function IncreaseCommerceGold()
	iCommerceGold = pPlayer:GetProperty('CommIntoGold') or 10				-- we cache these first as race condition
	iCommerceScience = pPlayer:GetProperty('CommIntoScience') or 0			--  between UI and gameplay from RequestOp
	local success = ChangeCommerceRatio(1)
	if success then
		UpdateCommerceFromProperty(Game.GetLocalPlayer(), 1)
	end
end

function DecreaseCommerceGold()
	iCommerceGold = pPlayer:GetProperty('CommIntoGold') or 10				-- as above
	iCommerceScience = pPlayer:GetProperty('CommIntoScience') or 0
	local success = ChangeCommerceRatio(-1)
	print('decrease commerceGold')
	if success then
		UpdateCommerceFromProperty(Game.GetLocalPlayer(), -1)
	end
end

function UpdateCommerceFromProperty(playerID, iChange)
	print('was iChange a number', type(iChange) == 'number')
	if type(iChange) == 'number' then
		iCommerceScience = tostring(10 * (iCommerceScience + (iChange*-1)))
		iCommerceGold = tostring(10 * (iCommerceGold + iChange))
		Controls.CommerceSciencePercent:SetText(iCommerceScience .. '%');
		Controls.CommerceGoldPercent:SetText(iCommerceGold .. '%');
	else
		if playerID == Game.GetLocalPlayer() then
			local iScience = tostring(10 * iCommerceScience)
			local iGold = tostring(10 * iCommerceGold)
			Controls.CommerceSciencePercent:SetText(iScience .. '%');
			Controls.CommerceGoldPercent:SetText(iGold .. '%');
		end
	end
end

local function InitializeControls()
	Controls.CommerceGold:RegisterCallback(Mouse.eLClick, IncreaseCommerceGold);
	Controls.CommerceGold:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over") end);
	Controls.CommerceScience:RegisterCallback(Mouse.eLClick, DecreaseCommerceGold);
	Controls.CommerceScience:RegisterCallback( Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over") end);
	Controls.ToggleCheatPanel:RegisterCheckHandler(function() UpdateCheatPanel(not m_hideCheatPanel); end);
	Controls.ToggleCheatPanel:SetCheck(true);
	UpdateCheatPanel(true);
	Events.PlayerTurnActivated.Add(UpdateCommerceFromProperty);
	iCommerceGold = pPlayer:GetProperty('CommIntoGold') or 10
	iCommerceScience = pPlayer:GetProperty('CommIntoScience') or 0
	UpdateCommerceFromProperty(iPlayer)
end

-- // ----------------------------------------------------------------------------------------------
-- // Init
-- // ----------------------------------------------------------------------------------------------
function Initialize()
	m_IsLoading = true;
		Events.LoadGameViewStateDone.Add(OnLoadGameViewStateDone);
		Events.LoadGameViewStateDone.Add(InitDropdown);
		InitializeControls();
		UpdateCheatPanel(false);
		Controls.CheatPanel:SetSizeY(50);
		Controls.BonusBacking1:SetHide(false);
		m_CheatPanelState = 1;
	m_IsLoading = false;
end
Initialize();