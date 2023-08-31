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

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("LspSemanticHighlight", {}),
        callback = function()
          for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
          end
        end,
      })

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
