return {
  { 'rust-lang/rust.vim',        ft = 'rust' },
  {
    'ziglang/zig.vim',
    ft = 'zig',
    init = function()
      vim.g.zig_fmt_autosave = false
    end,
  },
  { 'lervag/vimtex',             ft = 'tex' },
  { 'dag/vim-fish',              ft = 'fish' },
  { 'gabrielelana/vim-markdown', ft = 'markdown' },
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    dependencies = {
      -- 'mfussenegger/nvim-dap',
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function()
      local jdtls = require 'jdtls'

      local settings = {
        java = {
          maven = {
            downloadSources = true
          },
          contentProvider = {
            preferred = 'fernflower'
          },
          completion = {
            favoriteStaticMembers = {
              'java.util.Objects.*'
            },
            importOrder = {
              '',
              'javax',
              'java',
              '#',
            }
          },
          configuration = {
            maven = {
              -- absolute path to Maven's settings.xml
              -- userSettings = ''
            },
          },
          format = {
            enabled = true
          },
          edit = {
            validateAllOpenBuffersOnChanges = true
          }
        }
      }

      local capabilities = vim.tbl_deep_extend('force',
        {
          workspace = {
            configuration = true
          },
          textDocument = {
            completion = {
              snippetSupport = false
            }
          }
        },
        vim.lsp.protocol.make_client_capabilities(),
        require 'cmp_nvim_lsp'.default_capabilities()
      )

      local bundles = {}

      local function memoize(fn)
        local t = {}
        return function(x)
          local y = t[x]
          if y == nil then
            y = fn(x); t[x] = y
          end
          return y
        end
      end

      local config_for_dir = memoize(function(root_dir)
        assert(vim.g.jdtls_workspaces_location, '`g:jdtls_workspaces_location` is required')
        -- if vim.g.jdtls_workspaces_location == nil then
        --   vim.notify('`g:jdtls_workspaces_location` not specified', vim.log.levels.ERROR)
        --   return
        -- end
        local workspace_dir = vim.g.jdtls_workspaces_location .. '/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

        local workspace_folders

        if vim.uv.fs_stat(root_dir .. '/.cc') then
          workspace_folders = {}
          for _, p in ipairs(vim.fn.glob(root_dir .. '/*/pom.xml', true, true)) do
            local folder = vim.fn.fnamemodify(p, ':h')
            table.insert(workspace_folders, vim.uri_from_fname(folder))
          end
        end

        return {
          cmd = {
            'jdtls',
            '--jvm-arg=-Xmx3g',
            '-data', workspace_dir,
          },
          root_dir = root_dir,
          settings = settings,
          capabilities = capabilities,
          init_options = {
            bundles = bundles,
            workspaceFolders = workspace_folders,
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
          },
        }
      end)

      local jdtls_group = vim.api.nvim_create_augroup("JDTLS", {})
      vim.api.nvim_create_autocmd("FileType", {
        group = jdtls_group,
        pattern = "java",
        callback = function()
          local root_dir = jdtls.setup.find_root({ '.cc' }) or vim.fn.getcwd()
          local config = config_for_dir(root_dir)
          if config then
            jdtls.start_or_attach(config, nil, nil)
          end
        end,
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        rust_analyzer = {},
        zls = {},
      }
    }
  },
}
