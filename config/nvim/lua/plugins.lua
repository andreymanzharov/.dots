local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.isdirectory(install_path) == 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd[[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

return require'packer'.startup(function ()

  use 'wbthomason/packer.nvim'

  use 'chriskempson/base16-vim'

  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'

  use {
    'qpkorr/vim-bufkill',
    config = 'vim.g.BufKillOverrideCtrlCaret = true'
  }

  use 'neovim/nvim-lspconfig'

  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'rust-lang/rust.vim',
    ft = {'rust'}
  }

  use {'gabrielelana/vim-markdown', ft = {'markdown'}}
  use {'godlygeek/tabular', ft = {'markdown'}}

  use {
    'ziglang/zig.vim',
    ft = {'zig'}
  }

  use 'lervag/vimtex'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  use {
    'Vimjas/vim-python-pep8-indent',
    ft = 'python'
  }

  use 'ekickx/clipboard-image.nvim'

  if packer_bootstrap then
    require'packer'.sync()
  end
end)
