-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Changing colorscheme and font (all builtin)
config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13

-- I dont need no tab bar. I use tmux :-)
config.enable_tab_bar = false

return config
