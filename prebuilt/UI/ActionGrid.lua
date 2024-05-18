-- Build panel options (if any)
	if DoesSubjectHaveBuildActions() then
		Controls.BuildActionsPanel:SetHide(false);
		-- Create columns (each able to hold x3 icons) and fill them top to bottom
        -- Update UnitAbilities text
		local unitAbilitiesList = data.Ability;
        -- Given list of allowed values
		-- Resource Alter: Dispel Magic
		-- Feature Alter: Blaze,
		-- Terrain Alter: Scorch, Sanctify, Vitalize, Spring
		-- Summon: Eye, Skeleton, Spectre, Wraith, Fireball, Air Elemental, Fire Elemental, Water Elemental, Flesh Golem,
		-- Pit Beast, Host of Einherjar, Resurrection, Djinn, Mistform, Aurealis, Ice Elemental
		-- Damage: Maelstrom, Wither, Destroy Undead, Snowfall
		-- Buff: Courage, Enchant_Weapons, Flaming Arrows, Fair Winds, Haste, Regeneration, Dance Of Blades, Mutation,
		-- Loyalty, Valor, Poisoned Blade, Blur, ShadowWalk, Courage, Enchant SpellStaff
		-- Debuff: Rust, Charm, Blinding Light, Slow
		-- Other: Wonder, Lichdom, Domination
		-- 	Not Spells:
		-- InCity: not , Wall of Stone, Inspiration, Hope
		-- Other: Trust, Stoneskin, Waterwalking
        local manaAbilities = { GameInfo.UnitAbilities["RESOURCE_MANA_AIR_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_BODY_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_CHAOS_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_DEATH_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_EARTH_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_ENCHANTMENT_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_ENTROPY_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_FIRE_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_LIFE_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_METAMAGIC_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_MIND_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_NATURE_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_SHADOW_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_SPIRIT_ABILITY_GRANT_SPELL"].Index,
                                GameInfo.UnitAbilities["RESOURCE_MANA_WATER_ABILITY_GRANT_SPELL"].Index }
        -- how to do chan tiers plus manatypes
        local chanTiers = {GameInfo.UnitAbilities["CHANNELING_ABILITY_PROMOTION_CHANNELING1"].Index,
        GameInfo.UnitAbilities["CHANNELING_ABILITY_PROMOTION_CHANNELING2"].Index,
        GameInfo.UnitAbilities["CHANNELING_ABILITY_PROMOTION_CHANNELING3"].Index}

        local allowedValues = manaAbilities + chanTiers
        -- Convert the allowed values list to a set for efficient lookup
        local allowedSet = {}
        for _, value in ipairs(allowedValues) do
            allowedSet[value] = true
        end

        local SpellPromos = {}
        for key, value in pairs(unitAbilitiesList) do
            if allowedSet[value] then
                table.insert(SpellPromos, value)
            end
        end

		local numBuildCommands = table.count(data.Ability["BUILD"]);
		for i=1,numBuildCommands,3 do
			local buildColumnInstance = m_buildActionsIM:GetInstance();
			for iRow=1,3,1 do
				if ( (i+iRow)-1 <= numBuildCommands ) then
					local slotName	= "Row"..tostring(iRow);
					local action	= data.Actions["BUILD"][(i+iRow)-1];
					local instance	= {};
					ContextPtr:BuildInstanceForControl( "BuildActionInstance", instance, buildColumnInstance[slotName]);

					BuildActionModHook(instance, action);

					instance.UnitActionIcon:SetTexture( IconManager:FindIconAtlas(action.IconId, 38) );

					instance.UnitActionButton:SetDisabled( action.Disabled );
					instance.UnitActionButton:SetAlpha( (action.Disabled and 0.4) or 1 );
					instance.UnitActionButton:SetToolTipString( action.helpString );
					instance.UnitActionButton:RegisterCallback( Mouse.eLClick, action.CallbackFunc );       --this is why we should port to actions
					instance.UnitActionButton:SetVoid1( action.CallbackVoid1 );                             -- callbacks are assigned by addActionToTable, we should do that form.
					instance.UnitActionButton:SetVoid2( action.CallbackVoid2 );                             -- callbacks will be our function, like AndyLawFunction

				end
			end
		end

		local BUILD_PANEL_ART_PADDING_X = 24;
		local BUILD_PANEL_ART_PADDING_Y = 20;
		Controls.BuildActionsStack:CalculateSize();
		local buildStackWidth = Controls.BuildActionsStack:GetSizeX();
		local buildStackHeight = Controls.BuildActionsStack:GetSizeY();
		Controls.BuildActionsPanel:SetSizeX( buildStackWidth + BUILD_PANEL_ART_PADDING_X);
        Controls.BuildActionsPanel:SetSizeY( buildStackHeight + BUILD_PANEL_ART_PADDING_Y);
        Controls.BuildActionsStack:SetOffsetY(0);

	else
		Controls.BuildActionsPanel:SetHide(true);
	end