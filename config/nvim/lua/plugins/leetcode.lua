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
      directory = vim.fn.getcwd(),
    },
    config = function(_, opts)
      require'leetcode'.setup(opts)
      vim.keymap.set('n', '<leader>lc', '<cmd>Leet console<cr>')
      vim.keymap.set('n', '<leader>lt', '<cmd>Leet tabs<cr>')
      vim.keymap.set('n', '<leader>lr', '<cmd>Leet run<cr>')

      local ls = require'luasnip'
      local t = ls.text_node
      ls.add_snippets('c', {
        ls.snippet('#min', {
          t {
            '#define min(a, b)            \\',
            '  ({                         \\',
            '    __typeof__(a) _a = (a);  \\',
            '    __typeof__(b) _b = (b);  \\',
            '    _a < _b ? _a : _b;       \\',
            '  })',
          }
        }),
        ls.snippet('#max', {
          t {
            '#define max(a, b)            \\',
            '  ({                         \\',
            '    __typeof__(a) _a = (a);  \\',
            '    __typeof__(b) _b = (b);  \\',
            '    _a > _b ? _a : _b;       \\',
            '  })',
          }
        }),
        ls.snippet('#heap', {
          t {
            'static void',
            'swap(int* a, int i, int j)',
            '{',
            '  int t = a[i];',
            '  a[i] = a[j];',
            '  a[j] = t;',
            '}',
            '',
            'static void',
            'sift_down(int* a, int n, int i)',
            '{',
            '',
            '  while (2 * i + 1 < n) {',
            '    int l = 2 * i + 1, r = 2 * i + 2;',
            '    int j = l;',
            '    if (r < n && a[r] < a[l])',
            '      j = r;',
            '    if (a[i] < a[j])',
            '      break;',
            '    swap(a, i, j);',
            '    i = j;',
            '  }',
            '}',
            '',
            'static void',
            'sift_up(int* a, int i)',
            '{',
            '  while (a[i] < a[(i - 1) / 2]) {',
            '    swap(a, i, (i - 1) / 2);',
            '    i = (i - 1) / 2;',
            '  }',
            '}',
          }
        })
      })
    end,
  }
}
