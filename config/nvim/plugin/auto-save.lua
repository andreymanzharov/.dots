vim.api.nvim_create_autocmd("FocusLost", {
  group = vim.api.nvim_create_augroup("AutoSave", {}),
  pattern = "*",
  callback = function()
    vim.cmd [[silent! wall]]
  end,
})
