include("InstanceManager")
include("ModalScreen_PlayerYieldsHelper")
include( "PopupDialog" );

ExposedMembers.Suk_RelationsOverview = {}
local g_ = ExposedMembers.Suk_RelationsOverview
-- ================================================================================================================================
--	INSTANCE MANAGER
--	Modified Instance Manager to allow for setable Contexts
-- ================================================================================================================================
Suk_InstanceManager = {}; for k,v in pairs(InstanceManager) do Suk_InstanceManager[k] = v end
--------------------------------------------------------------------------------------------------------
--	Constructor
--------------------------------------------------------------------------------------------------------
Suk_InstanceManager.Base_New = Suk_InstanceManager.new
Suk_InstanceManager.new =
function(self, instanceName, rootControlName, ParentControl, Context)
	local o = Suk_InstanceManager.Base_New(self, instanceName, rootControlName, ParentControl)
	o.m_Context = Context or ContextPtr

	return o
end
--------------------------------------------------------------------------------------------------------
-- Build new instances
--------------------------------------------------------------------------------------------------------
Suk_InstanceManager.BuildInstance = function(self)
	local controlTable = {}

	if(self.m_ParentControl == nil)
	then
		self.m_Context:BuildInstance(self.m_InstanceName, controlTable);
	else
		self.m_Context:BuildInstanceForControl(self.m_InstanceName, controlTable, self.m_ParentControl);
	end

	if(controlTable[self.m_RootControlName] == nil)
	then
		print("Instance Manager built with bad Root Control [" .. self.m_InstanceName .. "] [" .. self.m_RootControlName .. "]");
	end

	controlTable[self.m_RootControlName]:SetHide(true);
	controlTable.m_InstanceManager = self;
	table.insert(self.m_AvailableInstances, controlTable);
	self.m_iAvailableInstances = self.m_iAvailableInstances + 1;

	self.m_iCount = self.m_iCount + 1;
end
--------------------------------------------------------------------------------------------------------
-- Build new instances
--------------------------------------------------------------------------------------------------------
Suk_InstanceManager.DestroyInstances = function(self)

	self:ResetInstances();

	for i = 1, #self.m_AvailableInstances, 1
	do
		local iter = table.remove(self.m_AvailableInstances);
		if(self.m_ParentControl == nil)
		then
			self.m_Context:DestroyChild(iter);
		else
			self.m_ParentControl:DestroyChild(iter[self.m_RootControlName]);
		end
	end

	self.m_iAvailableInstances = 0;

end

-- ================================================================================================================================
--	ADD BUTTON
-- ================================================================================================================================
function RealizeBacking()
	-- The Launch Bar width should accomodate how many hooks are currently in the stack.
	g_.ButtonStack:CalculateSize();
	g_.LaunchBacking:SetSizeX(g_.ButtonStack:GetSizeX()+116);
	g_.LaunchBackingTile:SetSizeX(g_.ButtonStack:GetSizeX()-20);
	g_.LaunchBackingDropShadow:SetSizeX(g_.ButtonStack:GetSizeX());

	-- When we change size of the LaunchBar, we send this LuaEvent to the Diplomacy Ribbon, so that it can change scroll width to accommodate it
	LuaEvents.LaunchBar_Resize(g_.ButtonStack:GetSizeX());
end

function OnOpen()
	if (Game.GetLocalPlayer() == -1) then
		return
	end
	print('clicked')
	local popup = PopupDialogInGame:new( "UnitPanelPopup" );
	popup:ShowYesNoDialog( 'Cast your Onetime World Spell?', function() CastWorldSpell() end, OnNoCastWorldSpell);
	m_DeleteInProgress = true;
end

function OnNoCastWorldSpell()
    m_DeleteInProgress = false;
end

local tWorldSpellPrereqs = {
	['SLTH_CIVILIZATION_BANNOR'] = {PrereqType='Policy' , Prereq='POLICY_CRUSADE' },
	['SLTH_CIVILIZATION_MALAKIM'] = {PrereqType='Civic' , Prereq='CIVIC_PRIESTHOOD' },
	['SLTH_CIVILIZATION_LUCHUIRP'] = {PrereqType='Technology' , Prereq='TECH_MASONRY' },
	['SLTH_CIVILIZATION_LJOSALFAR'] = {PrereqType='Technology' , Prereq='TECH_WAY_OF_THE_FORESTS' },
	['SLTH_CIVILIZATION_KHAZAD'] = {PrereqType='Technology' , Prereq='TECH_MINING' },
	['SLTH_CIVILIZATION_LANUN'] = {PrereqType='Technology' , Prereq='TECH_OPTICS' },
	['SLTH_CIVILIZATION_AMURITES'] = {PrereqType='Technology' , Prereq='TECH_KNOWLEDGE_OF_THE_ETHER' },
	['SLTH_CIVILIZATION_BALSERAPHS'] = {PrereqType= 'Technology', Prereq='TECH_FESTIVALS' },
	['SLTH_CIVILIZATION_INFERNAL'] = {PrereqType= 'Technology', Prereq='TECH_MALEVOLENT_DESIGNS'}
}

-- feel doviello should have a prereq
-- feel illians should have a prereq


local tWorldSpells = {
	SLTH_CIVILIZATION_BANNOR= 'SlthOnRally',
	SLTH_CIVILIZATION_MALAKIM= 'SlthOnReligiousFervor',
	SLTH_CIVILIZATION_ELOHIM='SlthOnSanctuary',
	SLTH_CIVILIZATION_LUCHUIRP='SlthOnGiftsOfNantosuelta',
	SLTH_CIVILIZATION_KURIOTATES='SlthOnLegends',
	SLTH_CIVILIZATION_LJOSALFAR='SlthOnMarchOfTheTrees',
	SLTH_CIVILIZATION_KHAZAD='SlthOnMotherLode',
	SLTH_CIVILIZATION_SIDAR='SlthOnIntoTheMist',
	SLTH_CIVILIZATION_LANUN='SlthOnRagingSeas',
	SLTH_CIVILIZATION_GRIGORI='SlthOnArdor',
	SLTH_CIVILIZATION_HIPPUS='SlthOnWarCry',
	SLTH_CIVILIZATION_AMURITES='SlthOnArcaneLacuna',
	SLTH_CIVILIZATION_DOVIELLO='SlthOnWildHunt',
	SLTH_CIVILIZATION_BALSERAPHS='SlthOnRevelry',
	SLTH_CIVILIZATION_CLAN_OF_EMBERS='SlthOnForTheHorde',
	SLTH_CIVILIZATION_SVARTALFAR='SlthOnVeilOfNight',
	SLTH_CIVILIZATION_CALABIM='SlthOnRiverOfBlood',
	SLTH_CIVILIZATION_SHEAIM='SlthOnWorldBreak',
	SLTH_CIVILIZATION_ILLIANS='SlthOnStasis',
	SLTH_CIVILIZATION_MERCURIANS='SlthOnDivineRetribution',
	SLTH_CIVILIZATION_INFERNAL='SlthOnHyboremsWhisper'
}

function CastWorldSpell()
    m_DeleteInProgress = false;
	local iPlayer = Game.GetLocalPlayer()
	local pPlayerConfig = PlayerConfigurations[iPlayer]
    local sCivName = pPlayerConfig:GetCivilizationTypeName()
	print(sCivName)
	local sEventFunction = tWorldSpells[sCivName]
	local tParameters = {}
	tParameters.OnStart = sEventFunction
	UI.RequestPlayerOperation(iPlayer, PlayerOperations.EXECUTE_SCRIPT, tParameters);
	-- oh dear, the requestPlayerOperation sets the property after we have reran OnLoaded. Multithreaded!!!
	OnShutdown()
	OnLoaded()
end

function OnLoaded()
	g_.LaunchBar					= 	ContextPtr:LookUpControl("/InGame/LaunchBar")
	g_.ButtonStack					= 	ContextPtr:LookUpControl("/InGame/LaunchBar/ButtonStack")
	g_.LaunchBacking				= 	ContextPtr:LookUpControl("/InGame/LaunchBar/LaunchBacking")
	g_.LaunchBackingDropShadow		= 	ContextPtr:LookUpControl("/InGame/LaunchBar/LaunchBarDropShadow")
	g_.LaunchBackingTile			= 	ContextPtr:LookUpControl("/InGame/LaunchBar/LaunchBackingTile")

	pLaunchBarItemIM				= 	Suk_InstanceManager:new("LaunchBarItem", "LaunchItemButton", g_.ButtonStack, g_.LaunchBar)
	pLaunchBarPinIM					= 	Suk_InstanceManager:new("LaunchBarPinInstance", "Pin", g_.ButtonStack, g_.LaunchBar)

	g_.tButton						=	pLaunchBarItemIM:GetInstance()
										pLaunchBarPinIM:GetInstance()

	----------------------------------------
	g_.tButton.LaunchItemButton:SetTexture("LaunchBar_Hook_GreatWorksButton")
	g_.tButton.LaunchItemButton:SetToolTipString(Locale.Lookup("LOC_SUK_GLOBAL_RELATIONS_SCREEN"))
	g_.tButton.LaunchItemIcon:SetTexture(0, 0, "LaunchBar_Hook_TechTree")
	g_.tButton.LaunchItemButton:RegisterCallback(Mouse.eLClick, OnOpen)
	----------------------------------------

	-- this needs changed as doesnt refresh state.
	local pPlayer = Players[Game.GetLocalPlayer()]
	if pPlayer then
		local HasCastWorldSpell = pPlayer:GetProperty('WorldSpellReady') or 0
		if HasCastWorldSpell > 0 then
			g_.tButton.LaunchItemButton:SetDisabled(true)
		end
	end

	RealizeBacking()
end

function OnInit(bIsReload)
	Events.LoadScreenClose.Add(OnInit)
	if not ContextPtr:LookUpControl("/InGame/LaunchBar") then return end

	-- Create the Button
	OnLoaded()

	-- Set Vignette size
	m_TopPanelConsideredHeight = Controls.Vignette:GetSizeY() - TOP_PANEL_OFFSET;
	Controls.Vignette:SetSizeY(m_TopPanelConsideredHeight)
end

------------------------------------------------------------------------------
--	OnShutdown
------------------------------------------------------------------------------
function OnShutdown()
	pLaunchBarItemIM:DestroyInstances()
	pLaunchBarPinIM:DestroyInstances()

	Events.LoadScreenClose.Remove(OnInit)
end

function OnInputHandler(pInputStruct)
	local uiMsg = pInputStruct:GetMessageType()
	if (uiMsg == KeyEvents.KeyUp) then return KeyHandler( pInputStruct:GetKey() ) end
	return false
end

function Initialize()
	ContextPtr:SetInitHandler(OnInit)
	ContextPtr:SetShutdown(OnShutdown)
	ContextPtr:SetInputHandler(OnInputHandler, true)
	ContextPtr:SetHide(true)
end
Initialize()