return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require 'rose-pine'.setup {
        italic = false,
        transparency = true,
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_c = { {
          'filename',
          path = 1,
        } }
      },
    },
  },
}
