return function ()
  vim.opt.background = 'dark'
  vim.opt.termguicolors = true

  if vim.fn.filereadable(vim.fn.expand('~/.vimrc_background')) then
    vim.g.base16colorspace = 256
    vim.cmd[[source ~/.vimrc_background]]
  else
    vim.cmd[[colorscheme base16-gruvbox-dark-hard]]
  end

  require'lualine'.setup{
    options = {
      icons_enabled = false,
      theme = 'gruvbox'
    }
  }

  if vim.fn.has('nvim-0.7') == 1 then
    vim.opt.laststatus = 3
    vim.cmd[[hi WinSeparator guibg=none]]
  end
end
