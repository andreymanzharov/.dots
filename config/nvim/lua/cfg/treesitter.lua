require 'nvim-treesitter.configs'.setup {
  ensure_installed = { 'c', 'cpp', 'go', 'java', 'lua', 'python', 'rust', 'vim', 'zig' },
  highlight = {
    enable = true,
    disable = { 'zig' },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner'
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>L'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>H'] = '@parameter.inner',
      }
    },
    move = {
      enable = true,
      goto_next_start = {
        [']]'] = '@function.outer',
      },
      goto_previous_start = {
        ['[['] = '@function.outer',
      },
    },
  }
}

vim.cmd [[highlight! default link TSKeywordOperator TSKeyword]]
