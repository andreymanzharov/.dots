if not vim.g.neovide then
  return
end

vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency = 0.9
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.opt.guifont = 'Iosevka Term'

local function set_scale_factor(scale)
  vim.g.neovide_scale_factor = scale
  vim.cmd.redraw { bang = true }
end
vim.keymap.set('n', '<d-0>', function() set_scale_factor(1) end)
vim.keymap.set('n', '<d-->', function() set_scale_factor(vim.g.neovide_scale_factor - .1) end)
vim.keymap.set('n', '<d-=>', function() set_scale_factor(vim.g.neovide_scale_factor + .1) end)
