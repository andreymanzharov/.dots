local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap('n', 'Q', '<nop>', opts)
vim.api.nvim_set_keymap('n', 'gQ', '<nop>', opts)

vim.api.nvim_set_keymap('n', ';', ':', {noremap = true})
vim.api.nvim_set_keymap('v', ';', ':', {noremap = true})

vim.api.nvim_set_keymap('n', '<f2>', '<cmd>update<cr>', opts)
vim.api.nvim_set_keymap('i', '<f2>', '<cmd>update<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>update<cr>', opts)

vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>lcd %:h<cr>', opts)

if vim.fn.has('unix') == 1 then
  vim.api.nvim_set_keymap('n', '<leader>md', '<cmd>!mkdir -p %:p:h<cr>', opts)
  vim.api.nvim_set_keymap('n', '<leader>x', '<cmd>!chmod u+x %<cr>', opts)
end

vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>nohlsearch<cr>', opts)
vim.api.nvim_set_keymap('n', '<cr>', '<cmd>nohlsearch<cr><cr>', opts)

vim.api.nvim_set_keymap('n', '<leader>y', '"+y', opts)
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', opts)
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', opts)
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', opts)
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', opts)

vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', opts)
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', opts)
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', opts)
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', opts)

vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', opts)
vim.api.nvim_set_keymap('t', '<c-j>', '<c-\\><c-n>', opts)
vim.api.nvim_set_keymap('t', '<c-h>', '<c-\\><c-n><c-w>h', opts)
vim.api.nvim_set_keymap('t', '<c-l>', '<c-\\><c-n><c-w>l', opts)

vim.api.nvim_set_keymap('n', 'M', '<cmd>make<cr>', opts)

vim.api.nvim_set_keymap('n', '<c-a-j>', '<cmd>cnext<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-a-k>', '<cmd>cprev<cr>', opts)
