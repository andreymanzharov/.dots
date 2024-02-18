local leet_arg = 'leetcode'

return {
  {
    'kawre/leetcode.nvim',
    lazy = leet_arg ~= vim.fn.argv()[1],
    build = ':TSUpdate html',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
      'MunifTanjim/nui.nvim',
    },
    opts = {
      arg = leet_arg,
      lang = 'c',
      storage = {
        home = vim.fn.getcwd(),
      },
    },
    config = function(_, opts)
      require 'leetcode'.setup(opts)
      vim.keymap.set('n', '<leader>lc', '<cmd>Leet console<cr>')
      vim.keymap.set('n', '<leader>lt', '<cmd>Leet tabs<cr>')
      vim.keymap.set('n', '<leader>lr', '<cmd>Leet run<cr>')

      local ls = require 'luasnip'
      local c = ls.choice_node
      local f = ls.function_node
      local i = ls.insert_node
      local t = ls.text_node
      ls.add_snippets('c', {
        ls.snippet('#min', {
          t {
            '#define min(a, b)                                                                                  \\',
            '  ({                                                                                               \\',
            '    __typeof__(a) _a = (a);                                                                        \\',
            '    __typeof__(b) _b = (b);                                                                        \\',
            '    _a < _b ? _a : _b;                                                                             \\',
            '  })',
          }
        }),
        ls.snippet('#max', {
          t {
            '#define max(a, b)                                                                                  \\',
            '  ({                                                                                               \\',
            '    __typeof__(a) _a = (a);                                                                        \\',
            '    __typeof__(b) _b = (b);                                                                        \\',
            '    _a > _b ? _a : _b;                                                                             \\',
            '  })',
          }
        }),
        ls.snippet('compare', {
          t { 'static int', '' },
          t 'compare_',
          c(1, { t 'int', t 'double' }),
          t { 's(void const* a, void const* b)', '' },
          t { '{', '' },
          t '  return *(',
          f(function(args) return args[1] end, { 1 }),
          t ' const*)a - *(',
          f(function(args) return args[1] end, { 1 }),
          t { ' const*)b;', '' },
          t '}',
        }),
        ls.snippet('sort', {
          t 'qsort(',
          i(1, 'nums'),
          t ', ',
          f(function(args) return args[1] end, { 1 }),
          t '_size, sizeof(',
          c(2, { t 'int', t 'double' }),
          t '), compare_',
          f(function(args) return args[1] end, { 2 }),
          t 's);',
        }),
        ls.snippet('#heap', {
          t {
            '#define HEAP_S(type, field)                                                                        \\',
            '  static void swap_##type(type* a, int i, int j)                                                   \\',
            '  {                                                                                                \\',
            '    type t = a[i];                                                                                 \\',
            '    a[i] = a[j];                                                                                   \\',
            '    a[j] = t;                                                                                      \\',
            '  }                                                                                                \\',
            '  static void sift_up_##type(type* a, int i)                                                       \\',
            '  {                                                                                                \\',
            '    while (a[i] field < a[(i - 1) / 2] field) {                                                    \\',
            '      swap_##type(a, i, (i - 1) / 2);                                                              \\',
            '      i = (i - 1) / 2;                                                                             \\',
            '    }                                                                                              \\',
            '  }                                                                                                \\',
            '  static void sift_down_##type(type* a, int n, int i)                                              \\',
            '  {                                                                                                \\',
            '    while (2 * i + 1 < n) {                                                                        \\',
            '      int l = 2 * i + 1, r = 2 * i + 2;                                                            \\',
            '      int j = l;                                                                                   \\',
            '      if (r < n && a[r] field < a[l] field)                                                        \\',
            '        j = r;                                                                                     \\',
            '      if (a[i] field < a[j] field)                                                                 \\',
            '        break;                                                                                     \\',
            '      swap_##type(a, i, j);                                                                        \\',
            '      i = j;                                                                                       \\',
            '    }                                                                                              \\',
            '  }',
            '#define HEAP(type) HEAP_S(type, )',
          }
        })
      })
    end,
  }
}
