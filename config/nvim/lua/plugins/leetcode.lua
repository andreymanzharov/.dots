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
    end,
  }
}
