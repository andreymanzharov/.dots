return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {
      style = 'moon',
      styles = {
        keywords = { italic = false }
      },
    },
    config = function(_, opts)
      require 'tokyonight'.setup(opts)

      vim.opt.background = 'dark'
      vim.opt.termguicolors = true

      vim.cmd.colorscheme 'tokyonight'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
      },
      sections = {
        lualine_c = { {
          'filename',
          path = 1,
        } }
      },
    },
  },
}
