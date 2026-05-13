local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	-- Windows
	automatically_reload_config = true,
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", -- disable title bar, enable resize
	default_cursor_style = "BlinkingBar",

	-- Appearance
	color_scheme = "Tokyo Night",
	font = wezterm.font("D2CodingLigature Nerd Font"),
	font_size = 18,
	background = {
		{
			source = { Color = "#282c35" },
			width = "100%",
			height = "100%",
			opacity = 0.95,
		},
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- Keymappings
	keys = {
		{
			key = "P",
			mods = "SUPER",
			action = wezterm.action.ActivateCommandPalette,
		},
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}

return config
