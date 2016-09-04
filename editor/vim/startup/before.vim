set number

" Ensure some commonly used directories are available.
EnsureDirectory "~/.vim/startup"
EnsureDirectory "~/.vim/swapfiles"
EnsureDirectory "~/.vim/backup"
EnsureDirectory "~/.vim/views"
EnsureDirectory "~/.vim/undo"

" Ensure that helptags are generated for the vim help directory
let g:DocPath = expand("$VIMRUNTIME/doc")
let g:DocTags = join([g:DocPath, "tags"], "/")
if !filereadable(g:DocTags)
	execute join(["helptags", g:DocPath])
endif

" Set up directories for swapfiles and backup files
" (so that they don't pollute the filesystem otherwise)
set undofile
set directory=~/.vim/swapfiles//
set backupdir=~/.vim/backup//
set viewdir=~/.vim/views//
set undodir=~/.vim/undo//

