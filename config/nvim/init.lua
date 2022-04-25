vim.g.mapleader = ","

local fish = "fish"
if vim.opt.shell:get():sub(-#fish) == fish then
  vim.opt.shell = "sh"
end

require'plugins'

vim.cmd[[
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
  callback = function ()
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.opt.guifont = "monospace"
  end,
})

vim.api.nvim_create_augroup("YankHighlight", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "YankHighlight",
  pattern = "*",
  callback = function () vim.highlight.on_yank() end,
})
