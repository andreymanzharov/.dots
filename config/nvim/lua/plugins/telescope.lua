return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      {
        'nvim-telescope/telescope-fzy-native.nvim',
        config = function() require 'telescope'.load_extension 'fzy_native' end,
      }
    },
    keys = {
      { '<c-n>',            function() require 'telescope.builtin'.find_files() end },
      { '<c-e>',            function() require 'telescope.builtin'.buffers() end },
      { '<leader>ts',       function() require 'telescope.builtin'.treesitter() end },
      { '<leader>h',        function() require 'telescope.builtin'.help_tags() end },
      { '<leader>lg',       function() require 'telescope.builtin'.live_grep() end },
      { '<leader><leader>', function() require 'telescope.builtin'.git_files() end },
      { '<leader>gl',       function() require 'telescope.builtin'.git_commits() end },

      {
        '<leader>ev',
        function()
          require 'telescope.builtin'.find_files(require 'telescope.themes'.get_dropdown {
            cwd = vim.fn.stdpath 'config'
          })
        end
      },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<c-j>'] = 'move_selection_next',
            ['<c-k>'] = 'move_selection_previous'
          }
        },
        winblend = 15,
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
  }
}