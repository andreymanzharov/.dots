return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require 'catppuccin'.setup {
        no_italic = true,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'catppuccin',
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
