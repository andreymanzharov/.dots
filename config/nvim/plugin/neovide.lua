if not vim.g.neovide then
  return
end

vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency = 0.9
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.g.neovide_remember_window_size = false
vim.opt.guifont = 'Iosevka Term'

local function set_scale_factor(scale)
  vim.g.neovide_scale_factor = scale
  print('scale: ' .. scale)
end

local meta = require 'useful'.meta

vim.keymap.set('n', meta '0', function() set_scale_factor(1) end)
vim.keymap.set('n', meta '-', function() set_scale_factor(vim.g.neovide_scale_factor - .1) end)
vim.keymap.set('n', meta '=', function() set_scale_factor(vim.g.neovide_scale_factor + .1) end)
