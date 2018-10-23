EnsureDirectory "~/.vim/bundle"

" Use vim-plug to manage packages
let Vimfiles = split(&runtimepath, ',')
let AutoloadDirectory = join([Vimfiles[0], 'autoload'], '/')
let VimPlugDestination = join([Vimfiles[0], 'autoload', 'plug.vim'], '/')

EnsureDirectory AutoloadDirectory

if empty(glob(VimPlugDestination))
    let VimPlugURL = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    call Download(VimPlugURL, VimPlugDestination)
    augroup VimPlugInit
        autocmd!
        autocmd VimEnter * PlugInstall | source $MYVIMRC
    augroup END
endif

call plug#begin('~/.vim/bundle')
for Module in split(glob('~/.vim/startup/packages/*.vim'), '\n')
    execute join(['source', fnameescape(Module)], ' ')
endfor
call plug#end()

