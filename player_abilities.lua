---@diagnostic disable: undefined-global, lowercase-global

local IsOnline = function()
  return
  network.is_session_started() and not
  script.is_active("maintransition")
end

---@param stat string
---@param value number
local IncrementStat = function(stat, value)
  local stat_get, stat_set
  if math.type(value) == 'integer' then
    stat_get, stat_set = stats.get_int, stats.set_int
  elseif math.type(value) == 'float' then
    stat_get, stat_set = stats.get_float, stats.set_float
  end
  local first = stat_get(stat)
  if (value < 0 and first == 0) or (value > 100 and first == 100) then
    return
  end
  stat_set(stat, (first + value))
end

local pstats_t = {
  {str = "Stamina",       stat_1 = "MPX_STAMINA",             stat_2 = "MPX_SCRIPT_INCREASE_STAM", incr_val = 1,   f = stats.get_int},
  {str = "Shooting",      stat_1 = "MPX_SHOOTING_ABILITY",    stat_2 = "MPX_SCRIPT_INCREASE_SHO",  incr_val = 1,   f = stats.get_int},
  {str = "Strength",      stat_1 = "MPX_STRENGTH",            stat_2 = "MPX_SCRIPT_INCREASE_STRN", incr_val = 1,   f = stats.get_int},
  {str = "Stealth",       stat_1 = "MPX_STEALTH_ABILITY",     stat_2 = "MPX_SCRIPT_INCREASE_STL",  incr_val = 1,   f = stats.get_int},
  {str = "Flying",        stat_1 = "MPX_FLYING_ABILITY",      stat_2 = "MPX_SCRIPT_INCREASE_FLY",  incr_val = 1,   f = stats.get_int},
  {str = "Driving",       stat_1 = "MPX_WHEELIE_ABILITY",     stat_2 = "MPX_SCRIPT_INCREASE_DRIV", incr_val = 1,   f = stats.get_int},
  {str = "Lung Capacity", stat_1 = "MPX_LUNG_CAPACITY",       stat_2 = "MPX_SCRIPT_INCREASE_LUNG", incr_val = 1,   f = stats.get_int},
  {str = "Mental State",  stat_1 = "MPX_PLAYER_MENTAL_STATE", stat_2 = "MPX_PLAYER_MENTAL_STATE",  incr_val = 1.0, f = stats.get_float},
}

local PlayerAbilitiesTab = gui.get_tab("GUI_TAB_NETWORK"):add_tab("Player Abilities")
PlayerAbilitiesTab:add_imgui(function()
  if IsOnline() then
    ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 10, 20); ImGui.PushButtonRepeat(true)
    for k, v in ipairs(pstats_t) do
      ImGui.Text(v.str)
      ImGui.PushID(k)
      if ImGui.Button(" - ") then
        script.run_in_fiber(function()
          IncrementStat(v.stat_2, - v.incr_val)
        end)
      end
      ImGui.SameLine(); ImGui.ProgressBar((v.f(v.stat_1) / 100), 180, 30); ImGui.SameLine()
      if ImGui.Button(" + ") then
        script.run_in_fiber(function()
          IncrementStat(v.stat_2, v.incr_val)
        end)
      end
      ImGui.PopID()
    end
    ImGui.PopButtonRepeat(); ImGui.PopStyleVar()
  else
    ImGui.Text("\nUnavailable in Single Player.")
  end
end)