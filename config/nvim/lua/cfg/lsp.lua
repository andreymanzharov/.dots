return function ()
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

  local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    local builtin = require'telescope.builtin'
    local themes = require'telescope.themes'

    vim.keymap.set('n', 'gD', function () builtin.lsp_type_definitions(themes.get_dropdown{}) end, opts)
    vim.keymap.set('n', 'gi', function () builtin.lsp_implementations(themes.get_dropdown{}) end, opts)
    vim.keymap.set('n', 'gr', function () builtin.lsp_references(themes.get_dropdown{}) end, opts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gS', function () builtin.lsp_workspace_symbols(themes.get_dropdown{}) end, opts)
    vim.keymap.set('n', 'gs', function () builtin.lsp_document_symbols(themes.get_dropdown{}) end, opts)

    vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<c-p>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, opts)
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function () vim.lsp.buf.formatting_sync() end,
      })
    end
    if client.server_capabilities.documentRangeFormattingProvider then
      vim.keymap.set('v', '<space>f', vim.lsp.buf.range_formatting, opts)
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

  local lsp_config = require'lspconfig'
  local servers = { 'clangd', 'gopls', 'zls', 'pylsp', 'rust_analyzer' }
  for _, server in ipairs(servers) do
    lsp_config[server].setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  end
end
