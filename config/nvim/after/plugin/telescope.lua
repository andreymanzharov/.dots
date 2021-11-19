if not vim.g.loaded_telescope then
  return
end

require'telescope'.setup{
  defaults = {
    mappings = {
      i = {
        ['<c-j>'] = 'move_selection_next',
        ['<c-k>'] = 'move_selection_previous'
      }
    }
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
require'telescope'.load_extension'fzf'

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<c-n>', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-e>', '<cmd>Telescope buffers<cr>', opts)

if vim.g.loaded_nvim_treesitter then
  vim.api.nvim_set_keymap('n', '<space><f12>', '<cmd>Telescope treesitter<cr>', opts)
end

local config = vim.fn.stdpath('config')
vim.api.nvim_set_keymap('n', '<leader>ev', '<cmd>Telescope find_files cwd='..config..'<cr>', opts)
