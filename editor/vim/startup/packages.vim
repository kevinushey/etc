EnsureDirectory "~/.vim/bundle"

" Use vim-plug to manage packages
if IsWindows()
  let VimPlugDestination = "~/vimfiles/autoload/plug.vim"
elseif has("nvim")
  let VimPlugDestination = "~/.local/share/nvim/site/autoload/plug.vim"
else
  let VimPlugDestination = "~/.vim/autoload/plug.vim"
endif

if empty(glob(VimPlugDestination))
  let VimPlugURL = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  call Download(VimPlugURL, VimPlugDestination)
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
for Module in split(glob('~/.vim/startup/packages/*.vim'), '\n')
  execute join(['source', Module], ' ')
endfor
call plug#end()

