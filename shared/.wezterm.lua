-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

----- Appearance ----------------------------------------
-- This is where you actually apply your config choices.
config.font = wezterm.font("IosevkaTermSlab NFM")
config.font_size = 16.0

config.window_decorations = "RESIZE" -- shows just enough so it still can be resized
-- config.window_background_opacity = 0.99
config.window_padding = {
	left = "4pt",
	right = "4pt",
	top = "4pt",
	bottom = "4pt",
}

config.tab_bar_at_bottom = true

----- Colors ------
config.color_scheme = "Gruvbox dark, medium (base16)"
-- config.color_scheme = "GruvboxDarkHard"
-- config.color_scheme = "Apprentice (Gogh)"
-- config.color_scheme = "MaterialDarker"

---------------------------------------------------------
----- Keymaps -------------------------------------------
config.leader = { key = "Space", mods = "SHIFT" }
config.keys = {}

-- Finally, return the configuration to wezterm:
return config
