return function ()
  require'nvim-treesitter.configs'.setup{
    ensure_installed = { 'c', 'cpp', 'go', 'java', 'lua', 'python', 'rust', 'vim', 'zig' },
    highlight = {
      enable = true
    },
    indent = {
      enable = true
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
      }
    }
  }

  vim.cmd[[highlight! default link TSKeywordOperator TSKeyword]]
end
