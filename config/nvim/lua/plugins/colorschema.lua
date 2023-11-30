return {
  {
    'RRethy/nvim-base16',
    priority = 1000,
    config = function()
      vim.opt.background = 'dark'
      vim.opt.termguicolors = true

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("LspSemanticHighlight", {}),
        callback = function()
          for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
          end
          vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'LineNr' })
        end,
      })

      require 'base16-colorscheme'.with_config {
        telescope = false,
      }

      if vim.env.BASE16_THEME and vim.g.colors_name ~= vim.env.BASE16_THEME then
        vim.cmd.colorscheme('base16-' .. vim.env.BASE16_THEME)
      else
        vim.cmd.colorscheme 'base16-default-dark'
      end
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
