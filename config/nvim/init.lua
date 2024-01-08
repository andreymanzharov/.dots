vim.g.mapleader = ' '

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[%substitute/\s\+$//e]],
})

local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazy_path
  }
end
vim.opt.runtimepath:prepend(lazy_path)

require 'lazy'.setup 'plugins'
