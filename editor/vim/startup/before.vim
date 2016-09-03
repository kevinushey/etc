set number

" Ensure some commonly used directories are available.
EnsureDirectory "~/.vim/startup"
EnsureDirectory "~/.vim/swapfiles"
EnsureDirectory "~/.vim/backup"

" Ensure that helptags are generated for the vim help directory
let g:DocPath = expand("$VIMRUNTIME/doc")
let g:DocTags = join([g:DocPath, "tags"], "/")
if !filereadable(g:DocTags)
	execute join(["helptags", g:DocPath])
endif

" Set up directories for swapfiles and backup files
" (so that they don't pollute the filesystem otherwise)
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backup//

" Set a default background, foreground color.
highlight Normal ctermfg=15 ctermbg=16

