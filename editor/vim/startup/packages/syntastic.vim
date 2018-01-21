Plug 'scrooloose/syntastic', LoadIf(v:version >= 704)

if executable('vint')
    let g:syntastic_vim_checkers = ['vint']
endif
