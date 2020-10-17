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

Plug 'airblade/vim-rooter'
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1

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
  inoremap <silent><expr> <tab>
        \ pumvisible() ? "\<c-n>" :
        \ <SID>check_back_space() ? "\<tab>" :
        \ completion#trigger_completion()
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
  endfunction

  Plug 'nvim-lua/diagnostic-nvim'
  let g:diagnostic_enable_virtual_text = 1
  let g:diagnostic_trimmed_virtual_text = '40'
  let g:space_before_virtual_text = 5
  let g:diagnostic_insert_delay = 1
  autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
  nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
  nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>
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
set smartcase
set splitright
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

set background=dark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
else
  colorscheme base16-gruvbox-dark-hard
endif

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

autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

autocmd BufWritePre * :%s/\s\+$//e

if has('nvim-0.5')
lua << EOF

local nvim_lsp = require'nvim_lsp'
local on_attach = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end

nvim_lsp.rust_analyzer.setup{
  cmd = { "rustup", "run", "nightly", "rust-analyzer" };
  on_attach = on_attach
}
nvim_lsp.clangd.setup{
  on_attach=on_attach
}

EOF
endif
