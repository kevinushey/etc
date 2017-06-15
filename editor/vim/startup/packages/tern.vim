let TernLoadable = !IsWindows() && executable('tern')
Plug 'ternjs/tern_for_vim', LoadIf(TernLoadable)

" Build node modules folder for tern as needed
if IsDirectory("~/.vim/bundle/tern_for_vim/") && executable('npm')
    if !IsDirectory("~/.vim/bundle/tern_for_vim/node_modules")
        !cd ~/.vim/bundle/tern_for_vim && npm install
    endif
endif

