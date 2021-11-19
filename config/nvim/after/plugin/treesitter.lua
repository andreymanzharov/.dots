if not vim.g.loaded_nvim_treesitter then
  return
end

require'nvim-treesitter.configs'.setup{
  ensure_installed = { 'c', 'cpp', 'go', 'java', 'lua', 'python', 'rust', 'vim' },
  highlight = {
    enable = true
  }
}

vim.cmd[[highlight! default link TSKeywordOperator TSKeyword]]
