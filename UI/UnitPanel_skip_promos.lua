-- ===========================================================================
--	Unit Panel Screen 
-- ===========================================================================
include( "UnitPanel" );

tSkipPromos = { [GameInfo.UnitPromotions['PROMOTION_IS_UNDEAD'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_CAN_GET_FEAR'].Index] = 1, [GameInfo.UnitPromotions['PROMOTION_IS_HERO_COMBATV'].Index] = 1,
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

-- ===========================================================================
--	CONSTANTS
-- ===========================================================================
local ANIMATION_SPEED				:number = 2;
local SECONDARY_ACTIONS_ART_PADDING	:number = -4;
local MAX_BEFORE_TRUNC_STAT_NAME	:number = 170;
local MIN_UNIT_PANEL_WIDTH			:number = 340;
local BUILD_ACTIONS_OFFSET			:number = 162;

-- ===========================================================================
--	GLOBALS
--	Likely to be overriden in MODs
-- ===========================================================================
g_isOkayToProcess = true;	-- Global processing of unit commands/improvements
g_targetData = {};
g_selectedPlayerId = -1;
g_UnitId		   = -1;


-- ===========================================================================
--	MEMBERS / VARIABLES
-- ===========================================================================

hstructure DisabledByTutorial
	kLockedHashes	: table;		-- Action hashes that the tutorial says shouldn't be enabled.	
end


local m_standardActionsIM		:table	= InstanceManager:new( "UnitActionInstance",			"UnitActionButton",		Controls.StandardActionsStack );
local m_secondaryActionsIM		:table	= InstanceManager:new( "UnitActionInstance",			"UnitActionButton",		Controls.SecondaryActionsStack );
local m_groupArtIM				:table	= InstanceManager:new( "GroupArtInstance",				"Top",					Controls.PrimaryArtStack );
local m_buildActionsIM			:table	= InstanceManager:new( "BuildActionsColumnInstance",	"Top",					Controls.BuildActionsStack );
local m_earnedPromotionIM		:table	= InstanceManager:new( "EarnedPromotionInstance",		"Top",					Controls.EarnedPromotionsStack);
local m_PromotionListInstanceMgr:table	= InstanceManager:new( "PromotionSelectionInstance",	"PromotionSelection",	Controls.PromotionList );
local m_subjectModifierIM		:table	= InstanceManager:new( "ModifierInstance",	"ModifierContainer",	Controls.SubjectModifierStack );
local m_targetModifierIM		:table	= InstanceManager:new( "ModifierInstance",	"ModifierContainer",	Controls.TargetModifierStack );	
local m_interceptorModifierIM	:table	= InstanceManager:new( "ModifierInstance",	"ModifierContainer",	Controls.InterceptorModifierStack );
local m_antiAirModifierIM		:table	= InstanceManager:new( "ModifierInstance",	"ModifierContainer",	Controls.AntiAirModifierStack );

local m_subjectStatStackIM		:table	= InstanceManager:new( "StatInstance",			"StatGrid",		Controls.SubjectStatStack );
local m_targetStatStackIM		:table	= InstanceManager:new( "TargetStatInstance",	"StatGrid",		Controls.TargetStatStack );

local m_combatResults			:table = nil;
local m_currentIconGroup		:table = nil;				--	Tracks the current icon group as they are built.
local m_primaryColor			:number = UI.GetColorValueFromHexLiteral(0xdeadbeef);
local m_secondaryColor			:number = UI.GetColorValueFromHexLiteral(0xbaadf00d);
local m_numIconsInCurrentIconGroup :number = 0;
local m_kHotkeyActions			:table = {};
local m_kHotkeyCV1				:table = {};
local m_kHotkeyCV2				:table = {};
local m_kSoundCV1               :table = {};
local m_kTutorialDisabled		:table = {};	-- key = Unit Type, value = lockedHashes
local m_kTutorialAllDisabled	:table = {};	-- hashes of actions disabled for all units

local m_DeleteInProgress		:boolean = false;
local m_showPromotionBanner		:boolean = false;

local m_attackerUnit = nil;
local m_locX = nil;
local m_locY = nil;

local INVALID_PLOT_ID	:number = -1;
local m_plotId			:number = INVALID_PLOT_ID;

local m_airAttackTargetPlots	:table = nil;
local m_subjectData				:table;

-- Defines the number of modifiers displayed per page in the combat preview
local m_maxModifiersPerPage		:number = 5;

-- Defines the minimum unit panel size and resize padding used when resizing unit panel to fit action buttons
local m_resizeUnitPanelPadding	:number = 18;

local pSpyInfo = GameInfo.Units["UNIT_SPY"];

local m_AttackHotkeyId			= Input.GetActionId("Attack");
local m_DeleteHotkeyId			= Input.GetActionId("DeleteUnit");

local m_MovementRange 			: number = UILens.CreateLensLayerHash("Movement_Range");
local m_MovementZoneOfControl	: number = UILens.CreateLensLayerHash("Movement_Zone_Of_Control");
local m_HexColoringWaterAvail   : number = UILens.CreateLensLayerHash("Hex_Coloring_Water_Availablity");
local m_HexColoringGreatPeople  : number = UILens.CreateLensLayerHash("Hex_Coloring_Great_People");

-- ===========================================================================
--	FUNCTIONS
-- ===========================================================================



-- ===========================================================================
--	Read in the data for displaying contents in the unit panel.
--	ARGS: unit, A unit object from the game.
--	RETURNS: A table of stats for the given unit type.
-- ===========================================================================
function ReadUnitData( unit:table )

	local pUnitDef:table = GameInfo.Units[unit:GetUnitType()];
	local unitExperience = unit:GetExperience();
	local unitAbility = unit:GetAbility();
	local potentialDamage :number = 0;

	local kSubjectData :table = InitSubjectData();
	local iconName, iconNamePrefixOnly, iconNameEraOnly, fallbackIconName = GetUnitPortraitIconNames( unit );

	kSubjectData.Name						= unit:GetName();
	kSubjectData.UnitTypeName				= pUnitDef.Name;
	kSubjectData.IconName					= iconName;
	kSubjectData.PrefixOnlyIconName			= iconNamePrefixOnly;
	kSubjectData.EraOnlyIconName			= iconNameEraOnly;
	kSubjectData.FallbackIconName			= fallbackIconName;
	kSubjectData.Moves						= unit:GetMovesRemaining();
	kSubjectData.MovementMoves				= unit:GetMovementMovesRemaining();
	kSubjectData.InFormation				= unit:GetFormationUnitCount() > 1;
	kSubjectData.FormationMoves				= unit:GetFormationMovesRemaining();
	kSubjectData.FormationMaxMoves			= unit:GetFormationMaxMoves();
	kSubjectData.MaxMoves					= unit:GetMaxMoves();
	kSubjectData.Combat						= unit:GetCombat();
	kSubjectData.Damage						= unit:GetDamage();
	kSubjectData.MaxDamage					= unit:GetMaxDamage();
	kSubjectData.PotentialDamage			= potentialDamage;
	kSubjectData.RangedCombat				= unit:GetRangedCombat();
	kSubjectData.BombardCombat				= unit:GetBombardCombat();
	kSubjectData.AntiAirCombat				= unit:GetAntiAirCombat();
	kSubjectData.Range						= unit:GetRange();
	kSubjectData.Owner						= unit:GetOwner();
	kSubjectData.BuildCharges				= unit:GetBuildCharges();
	kSubjectData.DisasterCharges			= unit:GetDisasterCharges();
	kSubjectData.SpreadCharges				= unit:GetSpreadCharges();
	kSubjectData.HealCharges				= unit:GetReligiousHealCharges();
	kSubjectData.ActionCharges				= unit:GetActionCharges();
	kSubjectData.ReligiousStrength			= unit:GetReligiousStrength();
	kSubjectData.HasMovedIntoZOC			= unit:HasMovedIntoZOC();
	kSubjectData.MilitaryFormation			= unit:GetMilitaryFormation();
	kSubjectData.UnitType					= unit:GetUnitType();
	kSubjectData.UnitID						= unit:GetID();
	kSubjectData.UnitExperience				= unitExperience:GetExperiencePoints();
	kSubjectData.MaxExperience				= unitExperience:GetExperienceForNextLevel();
	kSubjectData.UnitLevel					= unitExperience:GetLevel();
	kSubjectData.CurrentPromotions			= {};
	kSubjectData.Actions					= GetUnitActionsTable( unit );
	kSubjectData.Ability					= unitAbility:GetAbilities();
	-- Property-based values
	kSubjectData.Lifespan					= unit:GetProperty(UnitPropertyKeys.LifespanRemaining);
	
	-- Great person data
	-- Must be done before filtering unit stats because they look for some of the promotion information.
	local unitGreatPerson = unit:GetGreatPerson();
	if unitGreatPerson then
		local individual = unitGreatPerson:GetIndividual();
		local greatPersonInfo = GameInfo.GreatPersonIndividuals[individual];
		local gpClass = GameInfo.GreatPersonClasses[unitGreatPerson:GetClass()];
		if unitGreatPerson:HasPassiveEffect() then
			kSubjectData.GreatPersonPassiveText = unitGreatPerson:GetPassiveEffectText();
			kSubjectData.GreatPersonPassiveName = unitGreatPerson:GetPassiveNameText();
		end
		kSubjectData.GreatPersonActionCharges = unitGreatPerson:GetActionCharges();
	end

	local promotionList :table = unitExperience:GetPromotions();
	local i=0;
	for i, promotion in ipairs(promotionList) do
		if not tSkipPromos[promotion] then
			local promotionDef = GameInfo.UnitPromotions[promotion];
			table.insert(kSubjectData.CurrentPromotions, {
				Name = promotionDef.Name,
				Desc = promotionDef.Description,
				Level = promotionDef.Level
				})
			--print(promotionDef.Name)
		end
	end

	kSubjectData = ReadCustomUnitStats( unit, kSubjectData );
	kSubjectData.StatData = FilterUnitStatsFromUnitData( kSubjectData );	

	return kSubjectData;
end
