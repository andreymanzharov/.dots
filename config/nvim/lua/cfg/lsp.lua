return function ()
  local opts = { noremap = true, silent = true }

  vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)

  local lsp = require'lspconfig'
  local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', [[<cmd>Telescope lsp_type_definitions theme=dropdown<cr>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', [[<cmd>Telescope lsp_implementations theme=dropdown<cr>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', [[<cmd>Telescope lsp_references theme=dropdown<cr>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', [[<cmd>Telescope lsp_code_actions theme=dropdown<cr>]], opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-]>', [[<cmd>lua vim.lsp.buf.definition()<cr>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-p>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    end
    if client.resolved_capabilities.document_range_formatting then
      vim.api.nvim_buf_set_keymap(bufnr, "v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

  local servers = { 'clangd', 'gopls', 'zls', 'pylsp', 'rust_analyzer' }
  for _, server in ipairs(servers) do
    lsp[server].setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  end
end
