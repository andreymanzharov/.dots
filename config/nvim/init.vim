if !filereadable(stdpath('data') . '/site/autoload/plug.vim')
  execute '!curl -fLo' stdpath('data') . '/site/autoload/plug.vim' '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

let s:undodir = stdpath('data') . '/undodir'
if !isdirectory(s:undodir)
  call mkdir(s:undodir, 0700)
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
command! -bang -nargs=? -complete=dir
  \ Files call fzf#vim#files(<q-args>, {'source': 'fd'}, <bang>0)
nnoremap <c-n> :Files<cr>
nnoremap <c-e> :Buffers<cr>

Plug 'qpkorr/vim-bufkill'
let g:BufKillOverrideCtrlCaret = 1

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<nop>"
Plug 'honza/vim-snippets'

if has('nvim-0.5')
  Plug 'neovim/nvim-lspconfig'
  nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> <c-p> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

  Plug 'nvim-lua/completion-nvim'
  inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
  inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
  imap <tab> <plug>(completion_smart_tab)
  imap <s-tab> <plug>(completion_smart_s_tab)
  let g:completion_enable_snippet = 'UltiSnips'

  Plug 'nvim-treesitter/nvim-treesitter'
endif

Plug 'rust-lang/rust.vim', {
      \ 'for': 'rust'
      \ }
let g:rustfmt_autosave = 1

call plug#end()

filetype plugin indent on
syntax enable

set autowrite
set colorcolumn=+1
set completeopt=menuone,noinsert,noselect
set cpoptions+=$
set formatoptions+=nro
set gdefault
set hidden
set ignorecase
set list
set listchars=tab:→\ ,trail:·
set number
set numberwidth=3
set path+=**
set relativenumber
set shortmess+=c
if has('nvim-0.5')
  set signcolumn=number
endif
set smartcase
set splitright
set statusline=%f\ %m%r%h%w%q%=%{&fileformat}\ \|\ %{&fileencoding?&fileencoding:&encoding}\ \|\ %y\ %#CursorColumn#%11l:%-10(%c%V%)\ %-5(%3p%%%)
exe "set undodir=" . s:undodir
set undofile
set updatetime=300
set virtualedit=onemore
set visualbell
set wildmode=full,full
set winwidth=80
set nowrap

set shiftwidth=2
set softtabstop=-1
set expandtab
set autoindent
set shiftround

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=-1

set background=dark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
else
  colorscheme base16-gruvbox-dark-hard
endif
hi Normal ctermbg=none
hi NonText ctermbg=none

let mapleader = ","
let maplocalleader = ","

nnoremap Q <nop>
nnoremap gQ <nop>

nnoremap ; :

nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>

nnoremap <f2> :w<cr>
nnoremap <leader>w :w<cr>
inoremap <f2> <c-o>:w<cr>

nnoremap <silent> <leader>cd :lcd %:h<cr>
if has('unix')
  nnoremap <silent> <leader>md :!mkdir -p %:p:h<cr>
  nnoremap <silent> <leader>x :!chmod u+x %<cr>:e<cr>
endif

nnoremap <silent> <leader>n :nohlsearch<cr>
nnoremap <silent> <cr>      :nohlsearch<cr><cr>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

tnoremap <expr> <esc> &filetype == "fzf" ? "<esc>" : "<c-\><c-n>"
tnoremap <expr> <c-j> &filetype == "fzf" ? "<c-j>" : "<c-\><c-n>"

nnoremap M :make -j<cr>

autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

autocmd BufWritePre * :%s/\s\+$//e

if has('nvim-0.5')
lua << EOF

local lspconfig = require'lspconfig'
local on_attach = function(client)
  require'completion'.on_attach(client)
end

lspconfig.rust_analyzer.setup{
  cmd = { "rustup", "run", "nightly", "rust-analyzer" };
  on_attach = on_attach
}
lspconfig.clangd.setup{
  on_attach = on_attach
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = {
      spacing = 5,
      prefix = '~',
    },
    signs = true,
    update_in_insert = false,
  }
)

require'nvim-treesitter.configs'.setup{
  ensure_installed = { "c", "cpp", "java", "python", "rust" },
  highlight = {
    enable = true
  }
}
EOF

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
nnoremap <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

endif
