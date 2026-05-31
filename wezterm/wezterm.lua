local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Font
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
	{ family = "Symbols Nerd Font", scale = 0.85 }, -- scale icons down
})
config.font_size = 15

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.85
config.text_background_opacity = 1.0
config.macos_window_background_blur = 20
config.initial_cols = 150
config.initial_rows = 50
config.window_padding = {
	left = 0,
	right = 0,
	-- top = 0,
	bottom = 0,
}

-- Tab Bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.tab_bar_at_bottom = false

-- Colors
config.colors = {
	cursor_bg = "white",
	cursor_border = "white",
	foreground = "#CBE0F0",
	background = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },

	tab_bar = {
		background = "transparent", -- match "mantle" or dark blue-gray

		active_tab = {
			bg_color = "#5edcf8", -- blue (Catppuccin Macchiato: sapphire/blue)
			fg_color = "transparent", -- dark foreground for contrast
			intensity = "Bold",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		inactive_tab = {
			bg_color = "transparent",
			fg_color = "#b7bdf8", -- lavender text color
		},

		inactive_tab_hover = {
			bg_color = "#313244", -- hover color
			fg_color = "#cdd6f4",
			italic = true,
		},

		new_tab = {
			bg_color = "transparent",
			fg_color = "#b7bdf8",
		},

		new_tab_hover = {
			bg_color = "#313244",
			fg_color = "#b7bdf8",
			italic = true,
		},
	},
}

-- Background Image
-- config.window_background_image = os.getenv("HOME") .. "/.config/wezterm/assets/bg-blurred-darker.png"

-- Disable mouse in neovim
--config.disable_default_mouse_bindings = true --This disables scrolling, but I want normal mouse scrolling
config.bypass_mouse_reporting_modifiers = "SHIFT"
config.alternate_buffer_wheel_scroll_speed = 0

-- Enable kitty graphics
config.enable_kitty_graphics = true

-- Misc
config.max_fps = 120
config.prefer_egl = false
-- config.window_close_confirmation = "NeverPrompt"

-- Return the configurations
return config
