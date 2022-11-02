vim.g.mapleader = ","

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local fish = "fish"
if vim.opt.shell:get():sub(- #fish) == fish then
  vim.opt.shell = "sh"
end

require 'plugins'

vim.cmd [[
  filetype plugin indent on
  syntax enable
]]

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%substitute/\s\+$//e]],
})

vim.api.nvim_create_augroup("Neovide", {})
vim.api.nvim_create_autocmd("UIEnter", {
  group = "Neovide",
  pattern = "*",
  callback = function()
    vim.g.neovide_transparency = 0.9
    vim.g.neovide_cursor_vfx_mode = "railgun"
    if vim.fn.has('macunix') == 1 then
      vim.opt.guifont = "Iosevka Term:h16"
    else
      vim.opt.guifont = "monospace:e-subpixelantialias:#h-slight"
    end
  end,
})


vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", {}),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_user_command('ReloadConfig', function()
  for name, _ in pairs(package.loaded) do
    if name:match('^cfg%.') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.cmd [[runtime! plugin/**/*.lua]]

  vim.notify("Configuration reloaded", vim.log.levels.INFO)
end, {})
vim.keymap.set('n', '<leader>sv', '<cmd>ReloadConfig<cr>')
