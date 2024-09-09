return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    opts = {
      history = true,
      update_events = 'TextChanged,TextChangedI',
      delete_check_events = 'TextChanged',
    },
    keys = {
      {
        '<c-j>',
        mode = { 'i', 's' },
        function()
          local ls = require 'luasnip'
          if ls.jumpable(-1) then ls.jump(-1) end
        end,
      },
      {
        '<c-k>',
        mode = 'i',
        function()
          local ls = require 'luasnip'
          if ls.expand_or_jumpable() then ls.expand_or_jump() end
        end,
      },
      {
        '<c-k>',
        mode = 's',
        function()
          local ls = require 'luasnip'
          if ls.jumpable(1) then ls.jump(1) end
        end,
      },
      {
        '<c-l>',
        mode = 'i',
        function()
          local ls = require 'luasnip'
          if ls.choice_active() then ls.change_choice(1) end
        end,
      }
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
      local cmp = require 'cmp'
      return {
        completion = {
          autocomplete = false,
        },
        snippet = {
          expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<c-d>'] = cmp.mapping.scroll_docs(-4),
          ['<c-f>'] = cmp.mapping.scroll_docs(4),
          ['<c-space>'] = cmp.mapping.complete(),
          ['<cr>'] = cmp.mapping.confirm { select = true },
        }),
        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
          },
          {
            { name = 'emoji', option = { insert = true, }, },
            { name = 'path' },
            { name = 'buffer' },
          }
        ),

        experimental = {
          -- native_menu = false,
          ghost_text = true,
        }
      }
    end
  }
}
