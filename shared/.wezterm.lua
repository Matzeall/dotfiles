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

----- Appearance ----------------------------------------
-- This is where you actually apply your config choices.
config.font = wezterm.font("IosevkaTermSlab NFM")
config.font_size = 12.0

config.window_decorations = "RESIZE" -- shows just enough so it still can be resized
-- config.window_background_opacity = 0.99
config.window_padding = {
	left = "3pt",
	right = "3pt",
	top = "3pt",
	bottom = "3pt",
}
local border_color = "#333333"
config.window_frame = {
	border_left_width = "0.2cell",
	border_right_width = "0.2cell",
	border_bottom_height = "0.10cell",
	border_top_height = "0.10cell",
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
config.keys = {}

-- Finally, return the configuration to wezterm:
return config
