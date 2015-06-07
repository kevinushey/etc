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

Source "~/.vim/startup/before.vim"

" Set up meta-data re: what system we're running on.
Source "~/.vim/startup/platform.vim"

" Begin with vim-sensible
Source "~/.vim/startup/sensible.vim"

" Source package-management related stuff
Source "~/.vim/startup/packages.vim"

" spf13 .vimrc
if !filereadable(expand("~/.vim/startup/spf13.vim"))
	let SPF13URL = 'https://raw.githubusercontent.com/spf13/spf13-vim/3.0/.vimrc'
	let Destination = '~/.vim/startup/spf13.vim'
	silent call Download(SPF13URL, Destination)
endif

" Turn off spf13 bundles -- we  do our own bundle management.
let g:override_spf13_bundles = 1
let g:spf13_bundle_groups = []

" This one actually breaks the behaviour of Ctrl + V block
" selection. :/
let g:spf13_no_wrapRelMotion = 1

" Far too destrucive to remove trailing whitespace by
" default (leads to noisy diffs in projects that don't
" enforce this)
let g:spf13_keep_trailing_whitespace = 1

" The most annoying spf13 feature. Just respect my own
" mapleader!
let g:spf13_leader = "\<Space>"

" Disable spf-13's omnicompletion mappings -- I find them
" annoying.
let g:spf13_no_omni_complete = 1

" Need to ensure all packages have finished loading before
" calling these functions.
autocmd VimEnter * Defer
            \ :call Source('~/.vim/startup/spf13.vim') |
            \ :call Source('~/.vim/startup/global.vim') |
            \ redraw

" Global overrides
if filereadable(expand("~/.vimrc.after"))
	source ~/.vimrc.after
endif

Source "~/.vim/startup/after.vim"
