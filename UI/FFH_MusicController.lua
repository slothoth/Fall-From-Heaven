-- =====================================================================================
-- FFH_MusicController.lua
-- Religion-dynamic map music + per-civ leader music for Fall from Heaven.
-- Runs in an InGame UI context (so UI.PlaySound + the diplo LuaEvents are available).
--
-- Wwise event-name contract (must match the events you built in the FFH_Music_Bank):
--   Map music  : Play_Music_FFH_<Set>   / Stop_Music_FFH_<Set>
--   Leader     : Play_Leader_Music_<CIV>/ Stop_Leader_Music_<CIV>   (CIV = code w/o CIVILIZATION_ prefix)
-- where <Set> is one of: Veil, Empy, Leaf, Octo, Orde, Rune, Coun, Generic
--
-- PREREQUISITE: native civ music must be suppressed (remove the Civilizations.artdef
-- Audio link in the mod art) so the engine doesn't play map music under our Lua music.
-- =====================================================================================

local DEBUG = true
local function dprint(...) if DEBUG then print("[FFH_Music]", ...) end end

-- FfH state religions are mapped onto civ6 policies
local RELIGION_TO_SET = {['SLTH_POLICY_STATE_ESUS']="Council", ['SLTH_POLICY_STATE_OCTOPUS']="Overlords",
                           ['SLTH_POLICY_STATE_EMPYREAN']="Empyrean", ['SLTH_POLICY_STATE_RUNES']="Runes",
                           ['SLTH_POLICY_STATE_ORDER']="Order", ['SLTH_POLICY_STATE_VEIL']="Veil",
                           ['SLTH_POLICY_STATE_LEAVES']="Leaves"}
local GENERIC_SET = "Generic"

local RELIGION_BY_INDEX = {}
for k, v in pairs(RELIGION_TO_SET) do
    RELIGION_BY_INDEX[GameInfo.Policies[k].Index] = v
end


-- ---- state ----
local m_currentMap = nil    -- map set currently playing (nil = nothing playing)
local m_suspended  = false  -- true while a diplo/leader screen owns the audio
local m_leader     = nil    -- CIV code of the leader theme currently playing

-- ---- helpers ----

-- Resolve the local player's dominant religion to a music-set tag.
local function DesiredSet()
    local pid = Game.GetLocalPlayer()
    if pid == nil or pid < 0 then return GENERIC_SET end
    local pPlayer = Players[pid]
    if not pPlayer then return GENERIC_SET end
    local pCulture = pPlayer:GetCulture()
    local set
    for iPolicyIndex, sReligionPlayListName in pairs(RELIGION_BY_INDEX) do
        if pCulture:IsPolicyActive(iPolicyIndex) then
            set = sReligionPlayListName
        end
    end
    if set then
        return set
    end
    return GENERIC_SET
end

-- "CIVILIZATION_BANNOR" -> "BANNOR"
local function CivCode(playerID)
    if not playerID or playerID < 0 then return nil end
    local cfg = PlayerConfigurations[playerID]
    local civ = cfg and cfg:GetCivilizationTypeName()
    if not civ then return nil end
    return (civ:gsub("^CIVILIZATION_", ""))
end

-- ---- map music ----

-- Idempotent: only changes the track when the desired set actually differs, so it is
-- safe to call from many events (turn begin, religion change, etc.).
local function PlayMapIfNeeded()
    if m_suspended then return end
    local want = DesiredSet()
    if want == m_currentMap then return end
    if m_currentMap then UI.PlaySound("Stop_Music_FFH_" .. m_currentMap) end
    UI.PlaySound("Play_Music_FFH_" .. want)
    dprint("map ->", want)
    m_currentMap = want
end

local function StopMap()
    if m_currentMap then
        UI.PlaySound("Stop_Music_FFH_" .. m_currentMap)
        m_currentMap = nil
    end
end

-- ---- leader / diplomacy screens ----

local function OnDiploOpen(otherPlayerID)
    m_suspended = true
    StopMap()                                   -- silence religion music while in diplo
end

local function OnDiploClose()
    m_suspended = false
    PlayMapIfNeeded()                           -- resume religion music
end

-- ---- hard stop (avoid music bleeding across game-end / menu) ----

local function StopAll()
    StopMap()
    if m_leader then UI.PlaySound("Stop_Leader_Music_" .. m_leader); m_leader = nil end
    m_suspended = false
    dprint("stop all")
end

-- ---- wiring ----

-- Guarded .Add so a missing event name can't break load.
local function SafeAdd(evt, fn)
    if evt and evt.Add then evt.Add(fn) end
end

local function Initialize()
    -- recompute map music on enter-game and whenever religion could have changed
    SafeAdd(Events.LoadScreenClose,               PlayMapIfNeeded)
    SafeAdd(Events.LocalPlayerTurnBegin,          PlayMapIfNeeded)   -- per-turn safety net
    SafeAdd(Events.LocalPlayerChanged,            PlayMapIfNeeded)   -- hotseat
    SafeAdd(Events.GovernmentPolicyChanged,       PlayMapIfNeeded)

    -- diplomacy screens -> leader theme
    SafeAdd(LuaEvents.DiplomacyRibbon_OpenDiplomacyActionView, OnDiploOpen)
    SafeAdd(LuaEvents.TopPanel_OpenDiplomacyActionView,        OnDiploOpen)
    SafeAdd(LuaEvents.DiplomacyActionView_ShowIngameUI,        OnDiploClose)

    -- stop everything on game end / leaving
    SafeAdd(Events.TeamVictory,        StopAll)
    SafeAdd(Events.PlayerDefeat,       StopAll)
    SafeAdd(Events.LeaveGameComplete,  StopAll)
    SafeAdd(Events.ExitToMainMenu,     StopAll)

    dprint("controller loaded")
end

Initialize()
print('loaded FFH Music Controller')
