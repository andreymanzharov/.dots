vim.opt.autowrite = true
vim.opt.breakindent = true
vim.opt.breakindentopt = 'sbr,list:-1'
vim.opt.colorcolumn = '+1'
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
vim.opt.cpoptions:append '$'
vim.opt.cursorline = true
vim.opt.cursorlineopt = { 'number' }
vim.opt.fixeol = false
vim.opt.formatoptions:append 'nro'
vim.opt.gdefault = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = '→ ', trail = '·', eol = '¬', nbsp = '␣', extends = '…' }
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.path:append '**'
vim.opt.pumblend = 17
vim.opt.relativenumber = true
vim.opt.shortmess:append 'c'
vim.opt.signcolumn = 'number'
vim.opt.smartcase = true
vim.opt.showbreak = '> '
vim.opt.splitright = true
vim.opt.title = true
vim.opt.updatetime = 300
vim.opt.virtualedit = 'onemore'
vim.opt.visualbell = true
if vim.fn.has('nvim-0.8') == 1 then
  vim.opt.winbar = '%=%m %f'
end
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.winwidth = 80
vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = -1

vim.opt.keymap = 'russian-jcukenwin'
vim.opt.iminsert = 0
vim.opt.imsearch = -1

local undo_dir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, 0700)
end
vim.opt.undodir = undo_dir
vim.opt.undofile = true
