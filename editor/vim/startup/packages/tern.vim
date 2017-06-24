Plug 'ternjs/tern_for_vim', LoadIf(executable('tern'))

" Build node modules folder for tern as needed
let s:InstallTern =
    \ executable("npm") &&
    \ IsDirectory("~/.vim/bundle/tern_for_vim") &&
    \ !IsDirectory("~/.vim/bundle/tern_for_vim/node_modules")

if s:InstallTern
    !cd ~/.vim/bundle/tern_for_vim && npm install
endif

