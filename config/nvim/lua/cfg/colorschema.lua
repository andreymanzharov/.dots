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

vim.cmd [[hi Normal guibg=none]]
vim.cmd [[hi NonText guibg=none]]
vim.cmd [[hi WinSeparator guibg=none]]
