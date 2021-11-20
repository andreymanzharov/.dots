local function configure_completion()
  local cmp = require'cmp'
  cmp.setup{
    completion = {
      autocomplete = false,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<c-space>'] = cmp.mapping.complete(),
      ['<cr>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ['<tab>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    }
  }
end

return {
  config = configure_completion
}
