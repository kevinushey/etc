scriptencoding utf-8

ColorScheme wombat256mod slate default
highlight Search cterm=NONE ctermfg=white ctermbg=12

if has('autocmd')
    autocmd BufEnter,BufWrite * set nospell
    autocmd VimEnter * silent! AirlineTheme dark
    autocmd VimEnter * silent! AirlineToggleWhitespace
    autocmd VimEnter,BufEnter,BufWinEnter * redraw!
    autocmd FileType html imap <buffer><expr><Tab> HtmlTab()
    autocmd FileType r set commentstring=##\ %s
    autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} \
        setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
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
set undofile
set undolevels=1000 
set undoreload=10000

