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

Plug 'qpkorr/vim-bufkill'
let g:BufKillOverrideCtrlCaret = 1

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

Plug 'nvim-treesitter/nvim-treesitter', {
      \ 'branch': '0.5-compat',
      \ 'do': ':TSUpdate'
      \ }

Plug 'rust-lang/rust.vim', {
      \ 'for': 'rust'
      \ }

Plug 'godlygeek/tabular', {
      \ 'for': 'markdown'
      \ }
Plug 'gabrielelana/vim-markdown', {
      \ 'for': 'markdown'
      \ }
autocmd FileType markdown setlocal spell spelllang=en,ru

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
nnoremap <c-n> :Telescope find_files<cr>
nnoremap <c-e> :Telescope buffers<cr>

Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

call plug#end()

filetype plugin indent on
syntax enable

set autowrite
set colorcolumn=+1
set completeopt=menu,menuone,noinsert,noselect
set cpoptions+=$
set formatoptions+=nro
set gdefault
set hidden
set ignorecase
set list
set listchars=tab:→\ ,trail:·,eol:↲,nbsp:␣,extends:…
set number
set numberwidth=3
set path+=**
set pumblend=17
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
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <f2> :up<cr>
nnoremap <leader>w :up<cr>
inoremap <f2> <c-o>:up<cr>

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
tnoremap <expr> <c-h> &filetype == "fzf" ? "<c-h>" : "<c-\><c-n><c-w>h"
tnoremap <expr> <c-l> &filetype == "fzf" ? "<c-l>" : "<c-\><c-n><c-w>l"

nnoremap M :make -j<cr>
nnoremap <c-a-j> :cnext<cr>
nnoremap <c-a-k> :cprev<cr>

autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

autocmd BufWritePre * :%s/\s\+$//e

let g:neovide_cursor_vfx_mode = "pixiedust"
set guifont=monospace:h18

lua << EOF
local cmp = require'cmp'
cmp.setup{
  completion = {
    autocomplete = false,
  },
  mapping = {
    ['<c-space>'] = cmp.mapping.complete(),
    ['<tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
          fallback()
        else
          cmp.complete()
        end
      end
    end,
    ['<s-tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
          fallback()
        else
          cmp.complete()
        end
      end
    end
  },
  sources = {
    { name = 'buffer' },
  }
}

local lspconfig = require'lspconfig'
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<c-p>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  cmp.setup.buffer{
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    },
  }
end

local client_capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.rust_analyzer.setup{
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(client_capabilities)
}
lspconfig.clangd.setup{
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(client_capabilities)
}
lspconfig.gopls.setup{
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(client_capabilities)
}
lspconfig.pylsp.setup{
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(client_capabilities)
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
  ensure_installed = { "c", "cpp", "go", "java", "python", "rust" },
  highlight = {
    enable = true
  }
}

require"telescope".setup{
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = "move_selection_next",
        ["<c-k>"] = "move_selection_previous"
      }
    }
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    },
    git_branches = {
      mappings = {
        i = {
          ["<c-d>"] = "git_delete_branch"
        },
        n = {
          ["<c-d>"] = "git_delete_branch"
        }
      }
    }
  }
}
require'telescope'.load_extension'fzf'

function _G.write_buf_with_sudo()
  if not vim.bo.modified then
    return
  end
  vim.bo.modified = false
  vim.cmd('write !sudo tee > /dev/null "%"')
  if vim.v.shell_error ~= 0 then
    vim.bo.modified = true
  end
end
vim.api.nvim_command[[command W call v:lua.write_buf_with_sudo()]]

EOF
