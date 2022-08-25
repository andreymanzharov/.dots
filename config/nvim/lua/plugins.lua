local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if vim.fn.isdirectory(install_path) == 0 then
  packer_bootstrap = vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path }
end

vim.api.nvim_create_augroup("Packer", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "Packer",
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile"
});

return require 'packer'.startup(function()

  use 'wbthomason/packer.nvim'

  use {
    'chriskempson/base16-vim',
    config = [[require'cfg.colorschema']]
  }

  use 'nvim-lualine/lualine.nvim'

  use {
    'tpope/vim-commentary',
    'tpope/vim-surround',
    'tpope/vim-fugitive'
  }

  use {
    'L3MON4D3/LuaSnip',
    config = [[require'cfg.snippets']]
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-emoji',
    'saadparwaiz1/cmp_luasnip',
    {
      'hrsh7th/nvim-cmp',
      config = [[require'cfg.completion']]
    }
  }

  use {
    'neovim/nvim-lspconfig',
    config = [[require'cfg.lsp']]
  }

  use {
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = [[require'cfg.treesitter']]
    },
    'nvim-treesitter/nvim-treesitter-textobjects'
  }

  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = [[require'cfg.telescope']]
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      config = [[require'telescope'.load_extension'fzf']]
    }
  }

  use { 'Vimjas/vim-python-pep8-indent', ft = 'python' }

  use { 'rust-lang/rust.vim', ft = { 'rust' } }

  use { 'ziglang/zig.vim', ft = { 'zig' } }

  use { 'gabrielelana/vim-markdown', ft = { 'markdown' } }
  use { 'godlygeek/tabular', ft = { 'markdown' } }

  use { 'lervag/vimtex', ft = { 'tex' } }

  use {
    'ekickx/clipboard-image.nvim',
    opt = true,
    cmd = { 'PasteImg' },
    config = [[require'cfg.clipboard-image']]
  }

  use { 'dag/vim-fish', ft = { 'fish' } }

  use { 'udalov/kotlin-vim', ft = { 'kotlin' } }

  if packer_bootstrap then
    require 'packer'.sync()
  end
end)
