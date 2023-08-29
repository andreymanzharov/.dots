vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("LspSemanticHighlight", {}),
  callback = function(args)
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end,
})
