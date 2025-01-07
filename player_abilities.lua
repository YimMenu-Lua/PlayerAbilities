---@diagnostic disable: undefined-global, lowercase-global

local IsOnline = function()
  return
  network.is_session_started() and not
  script.is_active("maintransition")
end

---@param stat string
---@param value number
local IncrementStat = function(stat, value)
  local first = stats.get_int(stat)
  if value < 0 and first == 0 then
    return
  end
  if math.type(value) == 'integer' then
    stats.set_int(stat, (first + value))
  elseif math.type(value) == 'float' then
    stats.set_float(stat, (first + value))
  else
    return
  end
end

local PlayerAbilitiesTab = gui.get_tab("GUI_TAB_NETWORK"):add_tab("Player Abilities")
PlayerAbilitiesTab:add_imgui(function()
  if IsOnline() then
    local stamina  = stats.get_int("MPX_STAMINA")
    local shooting = stats.get_int("MPX_SHOOTING_ABILITY")
    local strength = stats.get_int("MPX_STRENGTH")
    local stealth  = stats.get_int("MPX_STEALTH_ABILITY")
    local flying   = stats.get_int("MPX_FLYING_ABILITY")
    local driving  = stats.get_int("MPX_WHEELIE_ABILITY")
    local swimming = stats.get_int("MPX_LUNG_CAPACITY")
    local unhinged = stats.get_float("MPX_PLAYER_MENTAL_STATE")
    ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 10, 20); ImGui.PushButtonRepeat(true)
    ImGui.Text("Stamina")
    if ImGui.Button(" - ##stam") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_STAM", -1)
      end)
    end
    ImGui.SameLine(); ImGui.ProgressBar((stamina / 100), 180, 30); ImGui.SameLine()
    if ImGui.Button(" + ##stam") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_STAM", 1)
      end)
    end

    ImGui.Text("Shooting")
    if ImGui.Button(" - ##shoot") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_SHO", -1)
      end)
    end
    ImGui.SameLine(); ImGui.ProgressBar((shooting / 100), 180, 30); ImGui.SameLine()
    if ImGui.Button(" + ##shoot") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_SHO", 1)
      end)
    end

    ImGui.Text("Strength")
    if ImGui.Button(" - ##strn") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_STRN", -1)
      end)
    end
    ImGui.SameLine(); ImGui.ProgressBar((strength / 100), 180, 30); ImGui.SameLine()
    if ImGui.Button(" + ##strn") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_STRN", 1)
      end)
    end

    ImGui.Text("Stealth")
    if ImGui.Button(" - ##stealth") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_STL", -1)
      end)
    end
    ImGui.SameLine(); ImGui.ProgressBar((stealth / 100), 180, 30); ImGui.SameLine()
    if ImGui.Button(" + ##stealth") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_STL", 1)
      end)
    end

    ImGui.Text("Flying")
    if ImGui.Button(" - ##flying") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_FLY", -1)
      end)
    end
    ImGui.SameLine(); ImGui.ProgressBar((flying / 100), 180, 30); ImGui.SameLine()
    if ImGui.Button(" + ##flying") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_FLY", 1)
      end)
    end

    ImGui.Text("Driving")
    if ImGui.Button(" - ##driving") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_DRIV", -1)
      end)
    end
    ImGui.SameLine(); ImGui.ProgressBar((driving / 100), 180, 30); ImGui.SameLine()
    if ImGui.Button(" + ##driving") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_DRIV", 1)
      end)
    end

    ImGui.Text("Lung Capacity")
    if ImGui.Button(" - ##swimming") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_LUNG", -1)
      end)
    end
    ImGui.SameLine(); ImGui.ProgressBar((swimming / 100), 180, 30); ImGui.SameLine()
    if ImGui.Button(" + ##swimming") then
      script.run_in_fiber(function()
        IncrementStat("MPX_SCRIPT_INCREASE_LUNG", 1)
      end)
    end

    ImGui.Text("Mental State")
    if ImGui.Button(" - ##mental") then
      script.run_in_fiber(function()
        IncrementStat("MPX_PLAYER_MENTAL_STATE", -1.0)
      end)
    end
    ImGui.SameLine(); ImGui.ProgressBar((unhinged / 100), 180, 30); ImGui.SameLine()
    if ImGui.Button(" + ##mental") then
      script.run_in_fiber(function()
        IncrementStat("MPX_PLAYER_MENTAL_STATE", 1.0)
      end)
    end

    ImGui.PopButtonRepeat(); ImGui.PopStyleVar()
  else
    ImGui.Text("\nUnavailable in Single Player.")
  end
end)