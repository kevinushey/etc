scriptencoding utf-8

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

highlight Normal ctermfg=15 ctermbg=16
highlight Search cterm=NONE ctermfg=white ctermbg=12
ColorScheme wombat256mod slate default

if has('autocmd')
    autocmd BufEnter * set t_ut=
    autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
    autocmd BufEnter,BufWrite * set nospell
    autocmd FileType html imap <buffer><expr><Tab> HtmlTab()
    autocmd FileType r set commentstring=##\ %s
    autocmd VimEnter * silent! AirlineTheme dark
    autocmd VimEnter * silent! AirlineToggleWhitespace
    autocmd VimEnter,BufEnter,BufWinEnter * redraw!
endif

" Disable menu-stuff (for GUIs)
if has("gui_running")
    " Hide the menu bar.
    set guioptions -=m

    " Hide the toolbar.
    set guioptions -=T
endif

set number
set textwidth=0
set cinoptions=N-s,g0,m1,(s
set formatoptions+=j
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shellslash
set wrap
set number
set nolist
set nospell
set hidden
set cursorline
set backup
set undolevels=1000 
set undoreload=10000

