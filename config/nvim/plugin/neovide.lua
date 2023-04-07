if not vim.g.neovide then
  return
end

vim.g.neovide_transparency = 0.9
vim.g.neovide_cursor_vfx_mode = "railgun"
if vim.fn.has('macunix') == 1 then
  vim.opt.guifont = "Iosevka Term"
else
  vim.opt.guifont = "monospace:e-subpixelantialias:#h-slight"
end
