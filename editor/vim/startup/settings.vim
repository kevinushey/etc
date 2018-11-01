scriptencoding utf-8

" Ensure some commonly used directories are available.
EnsureDirectory "~/.vim/startup"
EnsureDirectory "~/.vim/swapfiles"
EnsureDirectory "~/.vim/backup"
EnsureDirectory "~/.vim/views"
EnsureDirectory "~/.vim/undo"

" Ensure that helptags are generated for the vim help directory
let g:DocPath = expand('$VIMRUNTIME/doc')
let g:DocTags = join([g:DocPath, 'tags'], '/')
if !filereadable(g:DocTags)
    execute join(['helptags', g:DocPath])
endif

" Set up directories for swapfiles and backup files
" (so that they don't pollute the filesystem otherwise)
set directory=~/.vim/swapfiles//
set backupdir=~/.vim/backup//
set viewdir=~/.vim/views//
if exists('+undofile')
    set undofile
    set undodir=~/.vim/undo//
endif

set background=dark
highlight Normal ctermfg=15               ctermbg=16
highlight Search cterm=NONE ctermfg=white ctermbg=12
ColorScheme wombat256mod slate default

augroup dotVimRc
    autocmd!
    autocmd BufEnter * set t_ut=
    autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
    autocmd BufEnter * call UpdateFileType()
    autocmd BufWinEnter * call RestoreCursorPosition()
    autocmd BufWritePost * call UpdateFileType()
    autocmd BufEnter,CursorHold,CursorHoldI,FocusGained * checktime
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    autocmd FileType html imap <buffer><expr><Tab> HtmlTab()
    autocmd FileType r  setlocal commentstring=#\ %s
    autocmd FileType vimscript setlocal omnifunc=vimcom
    autocmd VimEnter * silent! AirlineTheme dark
    autocmd VimEnter * silent! AirlineToggleWhitespace
augroup END

" Clipboard settings
if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
    else
        set clipboard=unnamed
    endif
endif

" Disable menu-stuff (for GUIs)
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
endif

let g:vim_indent_cont = 0
let g:is_posix        = 1

set autoindent
set autoread
set belloff=all
set cinoptions=:0,g0,N-s,E-s,t0,+s,(0,u0,Us,Ws
set completeopt=menuone,noinsert
set expandtab
set exrc
set foldenable
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set iskeyword-=#
set iskeyword-=-
set iskeyword-=.
set linespace=0
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set mouse=a
set noerrorbells
set novisualbell
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
set shortmess=A
set showmatch
set smartcase
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set textwidth=0
set undolevels=1000 
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=onemore
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set wildmode=list:longest,full
set winminheight=0

if v:version > 703
    set formatoptions+=j
    set undoreload=10000
endif

silent! set cryptmethod=blowfish
silent! set cryptmethod=blowfish2
silent! set ttymouse=xterm2

