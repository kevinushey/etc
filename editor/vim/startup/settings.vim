scriptencoding utf-8

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

