local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local launch_menu = {}

if wezterm.target_triple:find("windows") then
	config.default_prog = { "powershell.exe", "-NoLogo" }
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
	table.insert(launch_menu, {
		label = "CMD",
		args = { "cmd.exe" },
	})
	config.launch_menu = launch_menu
end

config.enable_wayland = false -- wayland support is flaky currently (e.g. on ubuntu 26.04) -> XWayland (test in the future again though)

----- Appearance ----------------------------------------
-- This is where you actually apply your config choices.
config.font = wezterm.font("Iosevka Term Slab")
config.font_size = 14.0

-- config.window_decorations = "RESIZE" -- shows just enough so it still can be resized
config.window_decorations = "TITLE | RESIZE" -- normal window
-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE" -- hides the titlebar and puts minimize/maximize/close into the tab bar instead

-- config.window_background_opacity = 0.99
config.window_padding = {
	left = "3pt",
	right = "3pt",
	top = "3pt",
	bottom = "3pt",
}
local border_color = "#333333"
config.window_frame = {
	border_left_width = "1pt",
	border_right_width = "1pt",
	border_bottom_height = "0pt",
	border_top_height = "1pt",
	border_left_color = border_color,
	border_right_color = border_color,
	border_bottom_color = border_color,
	border_top_color = border_color,
}

-- config.window_close_confirmation = "NeverPrompt"
config.hide_mouse_cursor_when_typing = false
config.alternate_buffer_wheel_scroll_speed = 1
config.mouse_wheel_scrolls_tabs = false

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

----- Colors ------
config.color_scheme = "Gruvbox dark, medium (base16)"
-- config.color_scheme = "GruvboxDarkHard"
-- config.color_scheme = "Apprentice (Gogh)"
-- config.color_scheme = "MaterialDarker"

config.colors = {
	-- follows gruvbox somewhat
	tab_bar = {
		background = "#282828",
		active_tab = {
			bg_color = "#b88218",
			fg_color = "#282828",
		},
		inactive_tab = {
			bg_color = "#3c3836",
			fg_color = "#a89984",
		},
		inactive_tab_hover = {
			bg_color = "#504945",
			fg_color = "#ebdbb2",
		},
		new_tab = {
			bg_color = "#282828",
			fg_color = "#a89984",
		},
		new_tab_hover = {
			bg_color = "#504945",
			fg_color = "#ebdbb2",
		},
	},
}

---------------------------------------------------------
----- Keymaps -------------------------------------------
config.use_dead_keys = false -- i don't notice the effect, but it sounds important
config.leader = { key = "Space", mods = "SHIFT" }
config.keys = {
	{ key = "l", mods = "LEADER", action = wezterm.action.ShowLauncher },
	-- scrolling
	{ key = "u", mods = "ALT", action = act.ScrollByLine(-1) },
	{ key = "d", mods = "ALT", action = act.ScrollByLine(1) },
	{ key = "u", mods = "ALT|SHIFT", action = act.ScrollByLine(-5) },
	{ key = "d", mods = "ALT|SHIFT", action = act.ScrollByLine(5) },
	{
		key = "q",
		mods = "CTRL|SHIFT",
		action = wezterm.action.QuitApplication,
	},
	-- move debug overlay
	{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "d", mods = "LEADER", action = wezterm.action.ShowDebugOverlay },

	-- send modified arrow keys correctly to e.g. nvim
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.SendString("\x1b[1;6D") },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.SendString("\x1b[1;6C") },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.SendString("\x1b[1;6A") },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.SendString("\x1b[1;6B") },
	{ key = "LeftArrow", mods = "CTRL|ALT", action = wezterm.action.SendString("\x1b[1;7D") },
	{ key = "RightArrow", mods = "CTRL|ALT", action = wezterm.action.SendString("\x1b[1;7C") },
	{ key = "UpArrow", mods = "CTRL|ALT", action = wezterm.action.SendString("\x1b[1;7A") },
	{ key = "DownArrow", mods = "CTRL|ALT", action = wezterm.action.SendString("\x1b[1;7B") },
	{ key = "Backspace", mods = "CTRL", action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }) },
	{ key = "Delete", mods = "CTRL", action = wezterm.action.SendString("\x1b[3;5~") },

	-- Unbind Ctrl+Shift+K from clearing scrollback ( for neovim again :) )
	{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
}

-- Finally, return the configuration to wezterm:
return config
