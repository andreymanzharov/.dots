vim.opt.background = 'dark'
vim.opt.termguicolors = true

require 'tokyonight'.setup {
  styles = {
    keywords = { italic = false }
  }
}

vim.cmd.colorscheme('tokyonight-moon')

require 'lualine'.setup {
  options = {
    icons_enabled = true,
  },
  sections = {
    lualine_c = { {
      'filename',
      path = 1,
    } }
  }
}
