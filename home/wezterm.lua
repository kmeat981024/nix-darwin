local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	-- Windows
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", -- disable title bar, enable resize
	default_cursor_style = "BlinkingBar",

	-- Appearance
	color_scheme = "Tokyo Night",
	font = wezterm.font("D2CodingLigature Nerd Font"),
	font_size = 16,
	background = {
		{
			source = { Color = "#282c35" },
			width = "100%",
			height = "100%",
			opacity = 0.95,
		},
	},
	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},
}

return config
