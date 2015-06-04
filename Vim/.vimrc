" User overrides -- you can override certain global variables
" used within the script there.
if filereadable(expand("~/.vimrc.before"))
	source ~/.vimrc.before
endif

" Functions used in the startup process. This file must exist!
if !exists('g:StartupFunctionsPath')
	let g:StartupFunctionsPath = '~/.vim/startup/functions.vim'
endif

if filereadable(expand(g:StartupFunctionsPath))
	execute join(["source", g:StartupFunctionsPath], " ")
else
	echo "ERROR: Could not locate startup '" . g:StartupFunctionsPath . "'!"
	finish
endif

" Ensure some commonly used directories are available.
EnsureDirectory "~/.vim/startup"
EnsureDirectory "~/.vim/swapfiles"
EnsureDirectory "~/.vim/backup"

" Set up directories for swapfiles and backup files
" (so that they don't pollute the filesystem otherwise)
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//

" Set up meta-data re: what system we're running on.
Source "~/.vim/startup/platform.vim"

" Begin with vim-sensible
Source "~/.vim/startup/sensible.vim"

" Source package-management related stuff
Source "~/.vim/startup/packages.vim"

" Source global stuff
Source "~/.vim/startup/global.vim"

" Global overrides
if filereadable(expand("~/.vimrc.after"))
	source ~/.vimrc.after
endif

