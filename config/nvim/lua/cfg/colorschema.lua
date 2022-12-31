vim.opt.background = 'dark'
vim.opt.termguicolors = true

if vim.fn.filereadable(vim.fn.expand('~/.vimrc_background')) then
  vim.g.base16colorspace = 256
  vim.cmd [[source ~/.vimrc_background]]
else
  vim.cmd [[colorscheme base16-gruvbox-dark-hard]]
end

require 'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox'
  }
}

vim.cmd.highlight { 'Normal', 'guibg=none' }
vim.cmd.highlight { 'NormalFloat', 'guibg=none' }
vim.cmd.highlight { 'WinSeparator', 'guibg=none' }

vim.cmd.highlight { 'DiffFile', 'guibg=none' }
vim.cmd.highlight { 'DiffNewFile', 'guibg=none' }
vim.cmd.highlight { 'DiffLine', 'guibg=none' }
vim.cmd.highlight { 'DiffAdded', 'guibg=none' }
vim.cmd.highlight { 'DiffRemoved', 'guibg=none' }
