vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'gQ', '<nop>')

vim.keymap.set({ 'n', 'v' }, ';', ':')

vim.keymap.set({ 'n', 'i' }, '<f2>', '<cmd>update<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>update<cr>')

vim.keymap.set('n', '<leader>cd', '<cmd>lcd %:h<cr>')

if vim.fn.has('unix') == 1 then
  vim.keymap.set('n', '<leader>md', '<cmd>!mkdir -p %:p:h<cr>')
  vim.keymap.set('n', '<leader>x', '<cmd>!chmod u+x %<cr>')
end

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])
vim.keymap.set('n', '<leader>P', [["+P]])

for _, d in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<c-' .. d .. '>', '<c-w>' .. d)
end

vim.keymap.set('t', '<esc>', [[<c-\><c-n>]])
vim.keymap.set('t', '<c-j>', [[<c-\><c-n>]])
for _, d in ipairs({ 'h', 'l' }) do
  vim.keymap.set('n', '<c-' .. d .. '>', [[<c-\><c-n><c-w>]] .. d)
end

vim.keymap.set('n', 'M', '<cmd>make<cr>')

vim.keymap.set('n', '<c-a-j>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<c-a-k>', '<cmd>cprev<cr>')

vim.keymap.set('c', '<c-j>', function() return vim.fn.wildmenumode() == 1 and '<c-n>' or '<c-j>' end, { expr = true })
vim.keymap.set('c', '<c-k>', function() return vim.fn.wildmenumode() == 1 and '<c-p>' or '<c-k>' end, { expr = true })
vim.keymap.set('c', '<c-h>', function() return vim.fn.wildmenumode() == 1 and '<up>' or '<c-h>' end, { expr = true })
vim.keymap.set('c', '<c-l>', function() return vim.fn.wildmenumode() == 1 and '<down>' or '<c-l>' end, { expr = true })
