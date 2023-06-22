vim.g.mapleader = ","

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local fish = "fish"
if vim.opt.shell:get():sub(- #fish) == fish then
  vim.opt.shell = "sh"
end

vim.cmd [[
  filetype plugin indent on
  syntax enable
]]

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%substitute/\s\+$//e]],
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", {}),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_user_command('ReloadConfig', function()
  for name, _ in pairs(package.loaded) do
    if name:match('^cfg%.') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.cmd [[runtime! plugin/**/*.lua]]

  vim.notify("Configuration reloaded", vim.log.levels.INFO)
end, {})
vim.keymap.set('n', '<leader>sv', '<cmd>ReloadConfig<cr>')

vim.api.nvim_create_autocmd("FocusLost", {
  group = vim.api.nvim_create_augroup("AutoSave", {}),
  pattern = "*",
  callback = function()
    vim.cmd [[silent! wall]]
  end,
})
