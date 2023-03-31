local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font {
  family = 'Iosevka Nerd Font',
  weight = 'Medium',
  harfbuzz_features = { 'dlig', 'ss12' }, --
}
config.color_scheme = 'Gruvbox dark, pale (base16)'

config.enable_tab_bar = false

return config
