return {
  { 'rust-lang/rust.vim',        ft = 'rust' },
  { 'ziglang/zig.vim',           ft = 'zig' },
  { 'lervag/vimtex',             ft = 'tex' },
  { 'dag/vim-fish',              ft = 'fish' },
  { 'gabrielelana/vim-markdown', ft = 'markdown' },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        rust_analyzer = {},
        zls = {},
      }
    }
  }
}
