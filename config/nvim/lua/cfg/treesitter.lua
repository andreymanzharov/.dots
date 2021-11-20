local function configure_treesitter()
  require'nvim-treesitter.configs'.setup{
    ensure_installed = { 'c', 'cpp', 'go', 'java', 'lua', 'python', 'rust', 'vim' },
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    }
  }

  vim.cmd[[highlight! default link TSKeywordOperator TSKeyword]]
end

return {
  config = configure_treesitter
}
