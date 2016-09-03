" spf13 .vimrc
if !filereadable(expand("~/.vim/startup/spf13/spf13.vim"))
	let SPF13URL = 'https://raw.githubusercontent.com/spf13/spf13-vim/3.0/.vimrc'
	let Destination = '~/.vim/startup/spf13/spf13.vim'
	silent call Download(SPF13URL, Destination)
endif

" Turn off spf13 bundles -- we do our own bundle management.
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
" calling these functions. Also avoid spf13.vim munging the
" runtimepath.
let g:RunTimePath = &rtp
Source "~/.vim/startup/spf13/spf13.vim"
let &runtimepath = g:RunTimePath

