require'telescope'.setup{
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

local opts = { noremap = true }
local builtin = require'telescope.builtin'
local themes = require'telescope.themes'

vim.keymap.set('n', '<c-n>', function () builtin.find_files(themes.get_dropdown{}) end)
vim.keymap.set('n', '<c-e>', function () builtin.buffers(themes.get_dropdown{}) end)

vim.keymap.set('n', '<leader>ts', function () builtin.treesitter(themes.get_dropdown{}) end)

vim.keymap.set('n', '<leader>h', function () builtin.help_tags(themes.get_dropdown{}) end)
vim.keymap.set('n', '<leader>lg', function () builtin.live_grep(themes.get_dropdown{}) end)

vim.keymap.set('n', '<leader><leader>', function () builtin.git_files(themes.get_dropdown{}) end)
vim.keymap.set('n', '<leader>gl', function () builtin.git_commits(themes.get_dropdown{}) end)

local config = vim.fn.stdpath('config')
vim.keymap.set('n', '<leader>ev', function ()
  builtin.find_files(themes.get_dropdown{
    cwd = config
  })
end)
