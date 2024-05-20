return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'hrsh7th/cmp-nvim-lsp'
    },
    opts = {
      servers = {
        clangd = {},
        gopls = {},
        pyright = {
          autostart = false,
        },
        ocamllsp = {},
        lua_ls = {
          on_init = function(client)
            local path = client.workspace_folders[1].name
            if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
              client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                  runtime = {
                    version = 'LuaJIT'
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      vim.env.VIMRUNTIME
                      -- "${3rd}/luv/library"
                      -- "${3rd}/busted/library",
                    }
                  }
                }
              })
            end
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end,
        }
      }
    },
    config = function(_, opts)
      local function on_attach(client, bufnr)
        local opts = { buffer = bufnr }
        local builtin = require 'telescope.builtin'
        local themes = require 'telescope.themes'

        vim.keymap.set('n', 'gD', function() builtin.lsp_type_definitions(themes.get_dropdown {}) end, opts)
        vim.keymap.set('n', 'gi', function() builtin.lsp_implementations(themes.get_dropdown {}) end, opts)
        vim.keymap.set('n', 'gr', function() builtin.lsp_references(themes.get_dropdown {}) end, opts)
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gS', function() builtin.lsp_workspace_symbols(themes.get_dropdown {}) end, opts)
        vim.keymap.set('n', 'gs', function() builtin.lsp_document_symbols(themes.get_dropdown {}) end, opts)

        vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<c-p>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        if client.server_capabilities.documentFormattingProvider then
          vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function() vim.lsp.buf.format { async = false } end,
          })
        end
        if client.server_capabilities.documentRangeFormattingProvider then
          vim.keymap.set('v', '<space>f', vim.lsp.buf.format, opts)
        end

        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
        end,
      })

      local capabilities = vim.tbl_deep_extend('force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require 'cmp_nvim_lsp'.default_capabilities(),
        opts.capabilites or {}
      )

      local lsp_config = require 'lspconfig'

      for server, server_opts in pairs(opts.servers) do
        if server_opts then
          lsp_config[server].setup(vim.tbl_deep_extend('force',
            {
              capabilities = vim.deepcopy(capabilities),
            },
            opts.servers[server] or {}
          ))
        end
      end
    end,
  }
}
