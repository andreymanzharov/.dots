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

  use {
    'chriskempson/base16-vim',
    config = function () require'cfg.colorschema'() end
  }

  use 'nvim-lualine/lualine.nvim'

  use {
    'tpope/vim-commentary',
    'tpope/vim-surround',
    'tpope/vim-fugitive'
  }

  use {
    'qpkorr/vim-bufkill',
    config = 'vim.g.BufKillOverrideCtrlCaret = true'
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    {
      'hrsh7th/nvim-cmp',
      config = function () require'cfg.completion'() end
    }
  }

  use {
    'neovim/nvim-lspconfig',
    config = function () require'cfg.lsp'() end
  }

  use {
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function () require'cfg.treesitter'() end
    },
    'nvim-treesitter/nvim-treesitter-textobjects'
  }

  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = function () require'cfg.telescope'() end
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      config = [[require'telescope'.load_extension'fzf']]
    }
  }

  use {'Vimjas/vim-python-pep8-indent', ft = 'python'}

  use {'rust-lang/rust.vim', ft = {'rust'}}

  use {'ziglang/zig.vim', ft = {'zig'}}

  use {'gabrielelana/vim-markdown', ft = {'markdown'}}
  use {'godlygeek/tabular', ft = {'markdown'}}

  use {'lervag/vimtex', ft = {'tex'}}

  use {
    'ekickx/clipboard-image.nvim',
    opt = true,
    cmd = {'PasteImg'},
    config = function () require'cfg.clipboard-image'() end
  }

  use {'dag/vim-fish'}

  if packer_bootstrap then
    require'packer'.sync()
  end
end)
