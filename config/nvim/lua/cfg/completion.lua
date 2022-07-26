local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

return function ()
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
      ['<c-b>'] = cmp.mapping.scroll_docs(-4),
      ['<c-f>'] = cmp.mapping.scroll_docs(4),
      ['<c-space>'] = cmp.mapping.complete(),
      ['<c-e>'] = cmp.mapping.abort(),
      ['<cr>'] = cmp.mapping.confirm({ select = true }),
      ['<tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif ls.expand_or_jumpable() then
          ls.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<s-tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }),
    experimental = {
      native_menu = false,
      ghost_text = true,
    }
  }
end
