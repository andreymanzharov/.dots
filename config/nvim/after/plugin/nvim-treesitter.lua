if not vim.g.loaded_nvim_treesitter then
  return
end

vim.cmd[[highlight! default link TSKeywordOperator TSKeyword]]
