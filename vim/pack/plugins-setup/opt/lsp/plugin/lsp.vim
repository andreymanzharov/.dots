vim9script

g:LspOptionsSet({ 'noNewlineInCompletion': false })

if executable('rust-analyzer')
  g:LspAddServer([{
    filetype: ['rust'],
    path: 'rust-analyzer',
    args: [],
    syncInit: true
  }])
endif
if executable('zls')
  g:LspAddServer([{
    filetype: ['zig'],
    path: 'zls',
    args: [],
    syncInit: true
  }])
endif
if executable('clangd')
  g:LspAddServer([{
    filetype: ['c', 'cpp'],
    path: 'clangd',
    args: ['--background-index', '--clang-tidy']
  }])
endif

def LspMappings()
  nnoremap <silent><buffer> ga <cmd>LspCodeAction<cr>
  nnoremap <silent><buffer> [d <cmd>LspDiagPrev<cr>
  nnoremap <silent><buffer> ]d <cmd>LspDiagNext<cr>
  nnoremap <silent><buffer> <space>e <cmd>LspDiagCurrent<cr>
  nnoremap <silent><buffer> gd <cmd>LspGotoDefinition<cr>
  nnoremap <silent><buffer> gD <cmd>LspGotoDeclaration<cr>
  nnoremap <silent><buffer> <leader>rn <cmd>LspRename<cr>
  nnoremap <silent><buffer> gw <cmd>LspSelectionExpand<cr>
  nnoremap <silent><buffer> gr <cmd>LspShowReferences<cr>
  nnoremap <silent><buffer> <c-p> <cmd>LspShowSignature<cr>
  inoremap <silent><buffer> <c-p> <cmd>LspShowSignature<cr>
  autocmd BufWritePre <buffer> LspFormat
enddef
autocmd User LspAttached LspMappings()
