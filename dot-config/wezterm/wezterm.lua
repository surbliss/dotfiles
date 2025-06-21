local wezterm = require "wezterm"
local config = wezterm.config_builder()
local mux = wezterm.mux
local act = wezterm.action

config.use_fancy_tab_bar = false
config.color_scheme = "Catppuccin Mocha"
config.harfbuzz_features = { "ss01" } -- Script italics
config.font = wezterm.font_with_fallback {
  "0xProto Nerd Font",
  "0xProto Nerd Font Propo",
  "0xProto Nerd Font Mono",
  "0xProto", -- different than the nerd font versions...
  "Symbols Nerd Font",
  "Symbols Nerd Font Mono",
  "Noto Color Emoji",
  "Noto Sans", -- Some eu-symbols missing in 0xProto
  "Font Awesome 6 Brands", -- NOTE: Breaks EU-symbols like ½ and ¤, so put at bottom
  "Font Awesome 6 Free",
}
-- NOTE: Precisely 80 characters:
-- 45678901234567890123456789012345678901234567890123456789012345678901234567890
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false

-- Try to reduce battery usage
config.front_end = "WebGpu"
config.animation_fps = 1
config.cursor_blink_rate = 0

----------------------------------------------------------------------
-- Keymaps
----------------------------------------------------------------------
-- Helper function for making mappings less verbose.
-- NOTE: These bindings are probably only good when using homerowmods
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 2000 }
config.disable_default_key_bindings = true
local WEZMOD = "CTRL|SUPER"
local function wezmap(key, mod, action)
  if mod == nil then
    mod = ""
  else
    mod = mod .. "|"
  end
  return { key = key, mods = mod .. WEZMOD, action = action }
end
-- Leadermap
local function lmap(key, action)
  return { key = key, mods = "LEADER", action = action }
end
-- NOTE: Wezterm "gobbles" these keymaps, so no need to worry they do something
-- differnt additionally in application.

config.keys = {
  wezmap("h", nil, act.ActivateTabRelativeNoWrap(-1)),
  wezmap("h", "SHIFT", act.MoveTabRelative(-1)),
  wezmap("l", nil, act.ActivateTabRelativeNoWrap(1)),
  wezmap("l", "SHIFT", act.MoveTabRelative(1)),
  wezmap("t", nil, act.SpawnTab "CurrentPaneDomain"),
  wezmap("w", nil, act.CloseCurrentTab { confirm = true }),
  -- Small status-window-split for running proccesses with potential errors
  wezmap("s", nil, act.SplitPane { direction = "Down", size = { Cells = 8 } }),
  wezmap("x", nil, act.CloseCurrentPane { confirm = true }),
  -- wezmap("t", act.ShowTabNavigator, "SHIFT"),
  wezmap("1", nil, act.ActivateTab(0)),
  wezmap("2", nil, act.ActivateTab(1)),
  wezmap("3", nil, act.ActivateTab(2)),
  wezmap("4", nil, act.ActivateTab(3)),
  wezmap("5", nil, act.ActivateTab(4)),
  wezmap("6", nil, act.ActivateTab(5)),
  wezmap("7", nil, act.ActivateTab(6)),
  wezmap("8", nil, act.ActivateTab(7)),
  wezmap("9", nil, act.ActivateTab(8)),
  wezmap("d", "SHIFT", act.ShowDebugOverlay),
  {
    key = "s",
    mods = "ALT",
    action = act.SplitPane { direction = "Down", size = { Cells = 6 } },
  },
  {
    key = "v",
    mods = "CTRL",
    action = act.PasteFrom "Clipboard",
  },
  {
    key = "v",
    mods = "SHIFT|CTRL",
    action = act.PasteFrom "Clipboard",
  },
  {
    key = "c",
    mods = "SHIFT|CTRL",
    action = act.CopyTo "Clipboard",
  },
  { key = "Enter", mods = "SHIFT|SUPER", action = act.SpawnWindow },
  { key = "Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
  wezmap("y", nil, act.ActivateCopyMode),
  -- wezmap("-", act.SplitVertical),
  -- No need to be able to split horizontally
  -- { key = "|", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  -- {
  --   key = "z",
  --   mods = "ALT",
  --   action = wezterm.action.TogglePaneZoomState,
  -- },
  wezmap("k", nil, act.ActivatePaneDirection "Up"),
  wezmap("k", "SHIFT", act.AdjustPaneSize { "Up", 1 }),
  wezmap(
    "j",
    nil,
    act.Multiple { act.ActivatePaneDirection "Down", act.TogglePaneZoomState }
  ),

  wezmap("j", "SHIFT", act.AdjustPaneSize { "Down", 1 }),
  wezmap("+", nil, act.IncreaseFontSize),
  wezmap("-", nil, act.DecreaseFontSize),
  wezmap("_", "SHIFT", act.DecreaseFontSize),
  wezmap("0", nil, act.ResetFontSize),
  wezmap(
    "\\",
    nil,
    act.Multiple {
      act.ResetFontSize,
      act.IncreaseFontSize,
      act.IncreaseFontSize,
      act.IncreaseFontSize,
      act.IncreaseFontSize,
      act.IncreaseFontSize,
    }
  ),
  wezmap(
    "r",
    nil,
    act.PromptInputLine {
      description = "Enter a new name for tab",
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
    }
  ),

  {
    key = "Enter",
    mods = "CTRL",
    -- Escape code to trigger zsh autocomplete-enter
    action = act.SendString "\x1b[13;5u",
  },
  wezmap("Tab", nil, act.ShowLauncher),
  -- {
  --   key = "s",
  --   mods = "CTRL",
  --   -- Escape code to trigger zsh autocomplete-enter
  --   action = act.SendString "<C-o>w",
  -- },
}

-- -- Workspaces
-- wezterm.on("gui-startup", function(cmd)
--   -- allow `wezterm start -- something` to affect what we spawn
--   -- in our initial window
--   local args = {}
--   if cmd then args = cmd.args end
--
--   -- Set a workspace for coding on a current project
--   -- Top pane is for the editor, bottom pane is for the build tool
--   local project_dir = wezterm.home_dir .. "/Documents/1-projekter"
--   local vtdir = project_dir .. "/vtdat"r .. "/su"
--   local tab, build_pane, window = mux.spawn_window({ workspace = "default" })
--
--   local tab, build_pane, window = mux.spawn_window({
--     workspace = "vtdat",
--     cwd = vtdir,
--     args = args,
--   })
--   local editor_pane = build_pane:split({
--     direction = "Top",
--     size = 0.9,
--     cwd = vtdir,
--   })
--
--   local tab, build_pane, window = mux.spawn_window({
--     workspace = "su",
--     cwd = sudir .. "/exam/Breakout/Breakout",
--     args = args,
--   })
--   local tab, build_pane, window = mux.spawn_window({
--     workspace = "su",
--     cwd = sudir .. "/exam/Breakout/DIKUArcade/DIKUArcade",
--     args = args,
--   })
--   window:spawn_tab({
--     cwd = sudir .. "/exam/Breakout/Breakout/",
--     args = args,
--   })
--   window:spawn_tab({
--     cwd = sudir .. "/exam/Breakout/Breakout/",
--     args = args,
--   })
--
--   local tab, build_pane, window = mux.spawn_window({
--     workspace = "config",
--     cwd = wezterm.home_dir .. "/dotfiles/dot-config",
--     args = args,
--   })
--
--   local tab, build_pane, window = mux.spawn_window({
--     workspace = "nixos",
--     cwd = "/etc/nixos",
--     args = args,
--   })
--
--   -- may as well kick off a build in that pane
--   -- build_pane:send_text("cargo build\n")
--
--   -- A workspace for interacting with a local machine that
--   -- runs some docker containers for home automation
--   -- local tab, pane, window = mux.spawn_window({
--   --   workspace = "automation",
--   --   args = { "ssh", "vault" },
--   -- })
--   -- -- We want to startup in the coding workspace
--   mux.set_active_workspace("default")
-- end)

config.launch_menu = {
  {
    label = "ips",
    args = { "cd ~/Documents/1-projekter/ips" },
    -- args = { "ls" },
  },
}
config.skip_close_confirmation_for_processes_named = {
  "bash",
  "sh",
  "zsh",
  "fish",
  "tmux",
  "nu",
  "cmd.exe",
  "pwsh.exe",
  "powershell.exe",
  "typst", -- NOTE: Assuming typst runs fast enough, that forcefully closing it wont cause problems...
}

return config
-- vim: cc=120 sw=2:
