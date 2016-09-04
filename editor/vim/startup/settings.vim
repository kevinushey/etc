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

set background=dark
highlight Normal ctermfg=15 ctermbg=16
highlight Search cterm=NONE ctermfg=white ctermbg=12
ColorScheme wombat256mod slate default

if has('autocmd')
    autocmd BufEnter * set t_ut=
    autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
    autocmd BufWinEnter * call RestoreCursorPosition()
    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    autocmd FileType html imap <buffer><expr><Tab> HtmlTab()
    autocmd FileType r set commentstring=##\ %s
    autocmd VimEnter * silent! AirlineTheme dark
    autocmd VimEnter * silent! AirlineToggleWhitespace
    autocmd VimEnter,BufEnter,BufWinEnter * redraw!
endif

" Clipboard settings
if has('clipboard')
    if has('unnamedplus')
	set clipboard=unnamed,unnamedplus
    else
	set clipboard=unnamed
    endif
endif

" Disable menu-stuff (for GUIs)
if has("gui_running")
    " Hide the menu bar.
    set guioptions -=m

    " Hide the toolbar.
    set guioptions -=T
endif

set autoindent
set cinoptions=N-s,g0,m1,(s
set cursorline
set expandtab
set foldenable
set formatoptions+=j
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set iskeyword-=#
set iskeyword-=-
set iskeyword-=.
set linespace=0
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set nojoinspaces
set nolist
set nospell
set nowrap
set number
set pastetoggle=<F12>
set scrolljump=5
set scrolloff=3
set shellslash
set shiftwidth=4
set shortmess+=filmnrxoOtT
set showmatch
set smartcase
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set textwidth=0
set undolevels=1000 
set undoreload=10000
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=onemore
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set wildmode=list:longest,full
set winminheight=0
set wrap
