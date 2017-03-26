if IsWindows() || !executable('tern')
    finish
endif

" Build node modules folder for tern as needed
if IsDirectory("~/.vim/bundle/tern_for_vim/")
    if !IsDirectory("~/.vim/bundle/tern_for_vim/node_modules")
        !cd ~/.vim/bundle/tern_for_vim && npm install
    endif
endif

Plug 'ternjs/tern_for_vim'
