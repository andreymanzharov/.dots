return {
  { 'nvim-lua/plenary.nvim', lazy = true },

  {
    'tpope/vim-commentary',
    cmd = 'Commentary',
    keys = {
      { 'gc', mode = { 'x', 'n', 'o' } },
      { 'gcc' },
      { 'gcu' },
    }
  },
  {
    'tpope/vim-surround',
    keys = {
      { 'ds' },
      { 'cs' },
      { 'cS' },
      { 'ys' },
      { 'yS' },
      { 'yss' },
      { 'ySs' },
      { 'ySS' },
      { 'S',      mode = 'x' },
      { 'gS',     mode = 'x' },
      { '<c-s>',  mode = 'i' },
      { '<c-g>s', mode = 'i' },
      { '<c-g>S', mode = 'i' },
    }
  }
}
