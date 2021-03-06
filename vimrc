set number

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%80v.\+/

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

hi Visual term=None cterm=None ctermbg=darkred ctermfg=black

autocmd FileType tex setlocal fo+=t
autocmd FileType tex setlocal tw=79

autocmd FileType rst setlocal fo+=t
autocmd FileType rst setlocal tw=79

autocmd FileType gitcommit setlocal fo+=t
autocmd FileType gitcommit setlocal tw=72
