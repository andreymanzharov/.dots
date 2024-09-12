return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      { 'nvim-telescope/telescope-fzy-native.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' }
    },
    keys = {
      '<c-n>',
      '<c-e>',
      '<leader>ts',
      '<leader>h',
      '<leader>lg',
      '<leader><leader>',
      '<leader>gl',
      '<leader>gb',
      '<leader>ev',
    },
    config = function()
      local telescope = require 'telescope'
      local themes = require 'telescope.themes'

      telescope.setup {
        defaults = {
          path_display = { "filename_first" },
          mappings = {
            i = {
              ['<c-j>'] = 'move_selection_next',
              ['<c-k>'] = 'move_selection_previous'
            }
          },
          winblend = 15,
        },
        extensions = {
          ['ui-select'] = themes.get_dropdown {}
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<c-d>'] = 'delete_buffer',
              },
              n = {
                ['<c-d>'] = 'delete_buffer',
              }
            }
          },
          git_branches = {
            mappings = {
              i = {
                ['<c-d>'] = 'git_delete_branch'
              },
              n = {
                ['<c-d>'] = 'git_delete_branch'
              }
            }
          }
        }
      }

      telescope.load_extension 'fzy_native'
      telescope.load_extension 'ui-select'

      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<c-n>', builtin.find_files)
      vim.keymap.set('n', '<c-e>', builtin.buffers)
      vim.keymap.set('n', '<leader>ts', builtin.treesitter)
      vim.keymap.set('n', '<leader>h', builtin.help_tags)
      vim.keymap.set('n', '<leader>lg', builtin.live_grep)
      vim.keymap.set('n', '<leader><leader>', builtin.git_files)
      vim.keymap.set('n', '<leader>gl', builtin.git_commits)
      vim.keymap.set('n', '<leader>gb', builtin.git_branches)

      local function config_files()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end

      vim.keymap.set('n', '<leader>ev', config_files)
    end
  }
}
