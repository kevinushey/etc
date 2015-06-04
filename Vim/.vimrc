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

" Begin with tpope's sensible.vim. Download it if we don't already have it.
Define g:wget = "wget"
Define g:SensibleVimPath = "~/.vim/startup/sensible.vim"
Define g:SensibleVimURL = "https://raw.githubusercontent.com/tpope/vim-sensible/master/plugin/sensible.vim"

if !filereadable(expand(g:SensibleVimPath))
	echo "Downloading sensible.vim from '" . g:SensibleVimURL . "'"
	silent execute "!" . g:wget . " " . g:SensibleVimURL . " -O " . g:SensibleVimPath
endif

Source g:SensibleVimPath

" Source package-management related stuff
Source "~/.vim/startup/packages.vim"

" Source global stuff 
Source "~/.vim/startup/global.vim"

" Source platform-specific configuration files.
" Source it after '.vimrc.local' so it can override if needed.
let g:system_name = "unknown"
if has("win32") || has("win64") || has("win16")
	let g:system_name = "Windows"
	let g:is_windows_system = 1
	Source "~/.vim/startup/windows.vim"
endif

if executable("uname")
	let g:system_name = substitute(system("uname -s"), '\n', '', '')
endif

if g:system_name == "Darwin"
	let g:is_darwin_system = 1
	Source "~/.vim/startup/darwin.vim"
elseif g:system_name == "Linux"
	let g:is_linux_system = 1
	Source "~/.vim/startup/linux.vim"
elseif g:system_name == "SunOS"
	let g:is_garbage_system = 1
	" TODO: nuke OS and install something reasonable.
	" If running on SPARC, consider setting machine on fire.
endif

" Global overrides
if filereadable(expand("~/.vimrc.after"))
	source ~/.vimrc.after
endif

