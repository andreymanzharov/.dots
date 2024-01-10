runtime! syntax/xml.vim

let main_syntax = 'xml'

syn include @JavaScript /usr/share/vim/vim90/syntax/javascript.vim
syn region jsScript start="<!\[CDATA\[" end="\]\]>" keepend contains=@JavaScript

