local cmp = require'cmp'
local ls = require'luasnip'
cmp.setup{
  completion = {
    autocomplete = false,
  },
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
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
    },
    {
      { name = 'luasnip' },
      { name = 'emoji' },
      { name = 'buffer' },
    }
  ),

  experimental = {
    -- native_menu = false,
    ghost_text = true,
  }
}
