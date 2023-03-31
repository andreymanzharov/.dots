vim.opt.background = 'dark'
vim.opt.termguicolors = true

if vim.env.BASE16_THEME and vim.g.colors_name ~= vim.env.BASE16_THEME then
  require('base16-colorscheme').with_config {
    telescope = false,
  }
  vim.g.base16colorspace = 256
  vim.cmd.colorscheme('base16-' .. vim.env.BASE16_THEME)
end

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
