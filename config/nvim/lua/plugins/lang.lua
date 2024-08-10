return {
  { 'rust-lang/rust.vim',        ft = 'rust' },
  {
    'ziglang/zig.vim',
    init = function()
      vim.g.zig_fmt_autosave = false
    end,
    ft = 'zig',
  },
  { 'lervag/vimtex',             ft = 'tex' },
  { 'dag/vim-fish',              ft = 'fish' },
  { 'gabrielelana/vim-markdown', ft = 'markdown' },
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    dependencies = {
      'williamboman/mason.nvim',
      -- 'mfussenegger/nvim-dap',
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function()
      local jdtls = require 'jdtls'

      local jdtls_path = require 'mason-registry'.get_package 'jdtls':get_install_path()

      local function get_cmd(workspace_dir)
        return {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx3g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          -- '-javaagent:' .. lombok,
          '-jar',
          vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
          '-configuration',
          jdtls_path .. '/config_' .. vim.uv.os_uname().sysname:lower(),
          '-data',
          workspace_dir
        }
      end

      local settings = {
        java = {
          format = {
            enabled = true
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

      local init_options = {
        bundles = {},
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
      }

      local function on_attach(_, bufnr)
        print("Hello from JDTLS on_attach!")
      end

      local function setup()
        vim.opt_local.shiftwidth = 4

        local root_dir = vim.fn.getcwd()

        local workspace_dir = root_dir .. '/.jdtls'

        jdtls.start_or_attach {
          cmd = get_cmd(workspace_dir),
          root_dir = root_dir,
          settings = settings,
          capabilities = capabilities,
          init_options = init_options,
          on_attach = on_attach
        }
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("JDTLS", {}),
        pattern = "java",
        callback = setup,
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

  {
    'williamboman/mason.nvim',
    lazy = true,
    opts = {}
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim'
    },
    opts = {
      ensure_installed = { 'jdtls', 'zls' }
    }
  }
}
