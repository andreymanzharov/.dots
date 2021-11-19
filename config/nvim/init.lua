vim.g.mapleader = ","

require'plugins'

vim.cmd[[
  filetype plugin indent on
  syntax enable
]]

vim.cmd[[autocmd BufWritePre * :%s/\s\+$//e]]

vim.cmd[[
autocmd UIEnter *
      \ let g:neovide_cursor_vfx_mode = "pixiedust" |
      \ set guifont=Iosevka\ Term:h12 |
      \
]]
