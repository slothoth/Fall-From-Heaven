local tAlignmentPropKeys = {[0]='LOC_EVIL_ALIGNMENT_NAME', [1]='LOC_NEUTRAL_ALIGNMENT_NAME', [2]='LOC_GOOD_ALIGNMENT_NAME'}

local setButtonCallbacks
function OnLoaded()
    print('is this loaded??')
    if ExposedMembers.SlthInstances then
        if ExposedMembers.SlthInstances['IntelOverviewGovernmentInstance'] and ExposedMembers.SlthInstances['PlayerPanel'] then
            print('found intel overview Gov, injecting, new')
            local ms_IntelOverviewGovernmentIM = ExposedMembers.SlthInstances['IntelOverviewGovernmentInstance']
            local overviewGovernmentInst = ms_IntelOverviewGovernmentIM:GetAllocatedInstance(1)
            local ms_PlayerPanelIM = ExposedMembers.SlthInstances['PlayerPanel']
            local playerPanel = ms_PlayerPanelIM:GetAllocatedInstance(1)
            if playerPanel then
                print('had player panel')
                print(playerPanel.PlayerNameText)
                local sLeaderName = playerPanel.PlayerNameText:GetText()
                print('sLeaderName', sLeaderName)
                local sLeaderType = 'LEADER_' .. sLeaderName
                local pFoundPlayer
                local sEndText = ''
                for iPlayer, pPlayer in ipairs(Players) do
                    if not pFoundPlayer and pPlayer:IsMajor() and pPlayer:IsAlive() then		-- priority first
                        local pConfig = PlayerConfigurations[iPlayer]
                        if pConfig and pConfig:GetLeaderTypeName() == sLeaderType then
                            pFoundPlayer = pPlayer
                        end
                    end
                end
                if pFoundPlayer then
                    local iAlignment = pFoundPlayer:GetProperty('alignment')
                    print('found alignment', iAlignment)
                    if iAlignment and tAlignmentPropKeys[iAlignment] then
                        sEndText = sEndText ..Locale.Lookup(tAlignmentPropKeys[iAlignment]);
                        print('found alignment localised', Locale.Lookup(tAlignmentPropKeys[iAlignment]))
                    end

                    local sStateReligion = pFoundPlayer:GetProperty('STATE_RELIGION')
                    if sStateReligion then
                        sStateReligion = 'LOC_' .. sStateReligion .. '_NAME'
                        print('found state religion', sStateReligion)
                        local sLocalStateReligion =  Locale.Lookup(sStateReligion)
                        if #sLocalStateReligion > 1 then
                            sEndText = sEndText .. ': ' .. sLocalStateReligion;
                        end
                        print('found state religion localised', sLocalStateReligion)
                    end
                end
                if sEndText ~= '' then
                    overviewGovernmentInst.GovernmentText:SetText(sEndText);
                    print('injected text', sEndText)
                end
            end
        end
    end
    if ExposedMembers.SlthInstances['DiplomacyRibbonLeader'] and ExposedMembers.SlthInstances['DiplomacyRibbonVert'] and not setButtonCallbacks then
        print('attempting ribbon stuff')
        local ms_DiplomacyRibbonLeaderIM = ExposedMembers.SlthInstances['DiplomacyRibbonLeader']
        local ms_DiplomacyRibbonIM = ExposedMembers.SlthInstances['DiplomacyRibbonVert']
        local ms_DiplomacyRibbon = ms_DiplomacyRibbonIM:GetAllocatedInstance(1)
        --
        -- LeaderIcon:GetInstance(ms_DiplomacyRibbonLeaderIM, ms_DiplomacyRibbonIM.Leaders);
        -- local instanceIcon = ms_DiplomacyRibbonLeaderIM:GetInstance(ms_DiplomacyRibbon.Leaders);

        -- local instanceIcon = ms_DiplomacyRibbonLeaderIM:GetAllocatedInstance(1);

	    -- local v2 =  LeaderIcon:AttachInstance(instance);
        --

        -- local ms_DiplomacyRibbon = ms_DiplomacyRibbonIM:GetInstance(Controls.DiplomacyRibbonContainer);

        -- LeaderIcon:GetInstance(ms_LeaderIconIM, ms_DiplomacyRibbon.Leaders);
        -- local msIconLeaderInstance = ms_LeaderIconIM:GetAllocatedInstance(1)                                                         -- likely plural
        --[[
        for i, pPlayer in ipairs(Players) do
            local instanceIcon = ms_DiplomacyRibbonLeaderIM:GetAllocatedInstance(i+1);
            if instanceIcon then
                print('setting callback icon', i+1)
                instanceIcon:RegisterCallback(Mouse.eLClick, OnLoaded);
            end
        end
        ]]
        setButtonCallbacks = true
    end
end



function OnInit(bIsReload)
    LuaEvents.CityBannerManager_TalkToLeader.Add(OnInit);
	LuaEvents.DiploPopup_TalkToLeader.Add(OnInit);
	LuaEvents.DiplomacyRibbon_OpenDiplomacyActionView.Add(OnInit);
	LuaEvents.TopPanel_OpenDiplomacyActionView.Add(OnInit);
    -- LuaEvents.DiplomacyActionView_OpenLite.Add(OnInit);
	if not ContextPtr:LookUpControl("/InGame/Diplomacy/DiplomacyActionView/PlayerContainer") then return end
	OnLoaded()
end

function OnShutdown()
	LuaEvents.CityBannerManager_TalkToLeader.Remove(OnInit);
	LuaEvents.DiploPopup_TalkToLeader.Remove(OnInit);
	LuaEvents.DiplomacyRibbon_OpenDiplomacyActionView.Remove(OnInit);
	LuaEvents.TopPanel_OpenDiplomacyActionView.Remove(OnInit);
    -- LuaEvents.DiplomacyActionView_OpenLite.Remove(OnInit);
end

function Initialize()
	ContextPtr:SetInitHandler(OnInit)
	ContextPtr:SetShutdown(OnShutdown)
	ContextPtr:SetHide(true)
end
Initialize()
