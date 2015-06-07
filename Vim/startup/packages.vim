EnsureDirectory "~/.vim/bundle"

" Use neobundle to manage packages
if !IsDirectory("~/.vim/bundle/neobundle.vim")
        let DestinationPath = expand('~/.vim/bundle/neobundle.vim')
        let Command = '!git clone ' .
        \ 'https://github.com/Shougo/neobundle.vim ' .
        \ DoubleQuotedEscaped(DestinationPath)
        echomsg 'Installing NeoBundle...'
        execute Command
endif

filetype plugin off
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle'))

" NOTE: The package names _must_ be supplied with single quotes!
" I guess it might be related to the fact that in vimscript,
" single-quoted strings are 'literal' strings (ie with no escapes)
" but still that's a pretty lame user experience, especially because
" the error message is not helpful. (This was true when I
" was using 'vundle'; I am not sure if it is still true.)
NeoBundle 'shougo/neobundle.vim'

" Utilites for deferring command execution.
NeoBundle 'kevinushey/vim-deferred'

" NERDTree gives us a nice tree-based view of files and a nice interface for
" interacting with said tree.
NeoBundleLazy 'scrooloose/nerdtree', {'augroup' : 'NERDTree'}

" 'ag' is grep on steroids and goes a long ways towards understanding which
" files you probably care about (and excludes files you don't care about)
NeoBundle 'rking/ag.vim'

" This gives me my favourite color scheme 'Tomorrow Night Bright'.
NeoBundle 'flazz/vim-colorschemes'

" Auto-pairing of delimiters. Unfortunately this does not play nicely with
" neocomplete out of the box and so we need to disable autopair's handling of
" CR.

" I briefly considered using 'powerline' here. It was a bad decision. I just
" want to make a nice status bar, I shouldn't have to opt into a JSON-based
" framework of insanity to make it happen. Let's use 'vim-airline' as it:
"
"    1. 'Just Works' (TM), and
"    2. The defaults are _really_ nice. So nice that I don't even feel like
"       bothering with configuration.
"
" TODO: Magically install powerline-ready fonts, so we get nice symbols.
" However, since I'm probably using Vim from a terminal I'm not sure how
" much utility there will be.
Define g:airline#extension#tagbar#enabled = 0
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'

" CTRL + P for quick file searching is wonderful.
let g:ctrlp_follow_symlinks = 1
NeoBundle 'ctrlpvim/ctrlp.vim'

" Not sure if I need this TBH.
NeoBundle 'tacahiroy/ctrlp-funky'

" Terry Ma's plugins are surprisingly nice -- using 'vim-expand-region' with
" hotkeys for 'v' and '<S-v>' makes expanding/contracting regions very nice.
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'terryma/vim-expand-region'

" Show substitution results as they're typed (e.g. for '%s|foo|bar|g')
NeoBundle 'osyo-manga/vim-over'

" Tim Pope is my hero. Unfortunately I have a hard time remembering what each
" plugin does because the plugin names are too clever for me. But they are
" clever.

" Fix-up common spelling mistakes.
NeoBundle 'tpope/vim-abolish'

" Make '.' work better with plugin maps.
NeoBundle 'tpope/vim-repeat'

" Automagically infer shiftwidth, expandtab.
NeoBundle 'tpope/vim-sleuth'

" Surround various word objects with stuff.
NeoBundle 'tpope/vim-surround'

" Utility keybindings for moving around buffers and so on.
" Mainly keyed off of '[' and ']'.
"
" In particular, I really like the 'file' movement commands; '[f' and ']f'.
NeoBundle 'tpope/vim-unimpaired'

" Very nice 'git' interface from vim.
NeoBundle 'tpope/vim-fugitive'

" Automagically add 'end*' when appropriate.
NeoBundle 'tpope/vim-endwise'

" Autocompletion of various pairs.
NeoBundle 'jiangmiao/auto-pairs'

" Comment management.
NeoBundle 'tpope/vim-commentary'

" Use 'syntastic' for linting etc. I only really use this
" in JavaScript.
NeoBundleLazy 'scrooloose/syntastic'
autocmd FileType javascript NeoBundleSource "scrooloose/syntastic"

" Nice vertical alignment. Although the package hasn't been updated in a
" while, it seems to have 'solved' this particular problem.
NeoBundle 'godlygeek/tabular'

if executable('ctag')
	NeoBundle 'majutsushi/tagbar'
endif

" Use Shougo's autocompletion. Because it requires a lot
" of configuration to make sure it works well, everything is
" moved to a separate file.
Source "~/.vim/startup/extra/neocomplete.vim"

" Easy-motion. Like Ace jump. I don't know who came first.
NeoBundle 'Lokaltog/vim-easymotion'

NeoBundle 'nathanaelkane/vim-indent-guides'


" Python-related stuff. Note that I don't write python very often.
NeoBundleLazyFiletype 'davidhalter/jedi-vim' 'python'

" JavaScript.
NeoBundleLazyFiletype 'jelera/vim-javascript-syntax'  'javascript'

" Autocompletion for JavaScript using Tern.
if (!IsWindows())
    if !IsDirectory("~/.vim/bundle/tern_for_vim/node_modules")
        !cd ~/.vim/bundle/tern_for_vim && npm install
    endif
    NeoBundleLazyFiletype 'marijnh/tern_for_vim'          'javascript'
endif

call neobundle#end()
filetype plugin indent on

