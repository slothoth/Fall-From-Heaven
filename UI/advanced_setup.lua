include("AdvancedSetup");

function OnStartButton()
	-- Is WorldBuilder active?
	if (GameConfiguration.IsWorldBuilderEditor()) then
        if (m_WorldBuilderImport) then
            MapConfiguration.SetScript("WBImport.lua");
			local loadGameMenu = ContextPtr:LookUpControl( "/FrontEnd/MainMenu/LoadGameMenu" );
			UIManager:QueuePopup(loadGameMenu, PopupPriority.Current);
		else
			UI.SetWorldRenderView( WorldRenderView.VIEW_2D );
			UI.PlaySound("Set_View_2D");
			Events.SetGameEntryMethod("Create A Game - WorldBuilder");
			Network.HostGame(ServerType.SERVER_TYPE_NONE);
		end
    else
        local showCityStatesWarning = ShouldShowCityStatesWarning();
        local showLeaderPoolWarning = ShouldShowLeaderPoolWarning();
		if showCityStatesWarning then
			ShowCityStateWarning(showLeaderPoolWarning);
        elseif showLeaderPoolWarning then
            ShowLeaderPoolWarning();
        else
			-- g_GameParameters.Parameters[pid]
			-- local kParameter = g_GameParameters.Parameters and g_GameParameters.Parameters[pid] or nil;
            -- g_GameParameters:SetParameterValue(kParameter, value);
			-- Network.BroadcastGameConfig();
            HostGame();
		end
	end
end

function OnSetParameterValue(pid: string, value: number)
	if(g_GameParameters) then
		local kParameter: table = g_GameParameters.Parameters and g_GameParameters.Parameters[pid] or nil;
		if(kParameter and kParameter.Value ~= nil) then
			print(pid)
			print(kParameter.Value)
			print(value)
            g_GameParameters:SetParameterValue(kParameter, value);
			Network.BroadcastGameConfig();
		end
	end
end