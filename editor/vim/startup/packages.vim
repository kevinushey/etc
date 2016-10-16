EnsureDirectory "~/.vim/bundle"

" Use vim-plug to manage packages
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

filetype plugin off
call plug#begin('~/.vim/bundle')

" NERDTree gives us a nice tree-based view of files and a nice interface for
" interacting with said tree.
Plug 'scrooloose/nerdtree'

" Comment / uncomment lines easily.
Plug 'scrooloose/nerdcommenter'

" 'ag' is grep on steroids and goes a long ways towards understanding which
" files you probably care about (and excludes files you don't care about)
Plug 'rking/ag.vim'

" This gives me my favourite color scheme 'Tomorrow Night Bright'.
Plug 'flazz/vim-colorschemes'

" I briefly considered using 'powerline' here. It was a bad decision. I just
" want to make a nice status bar, I shouldn't have to opt into a JSON-based
" framework of insanity to make it happen. Let's use 'vim-airline' as it:
"
"    1. 'Just Works' (TM), and
"    2. The defaults are _really_ nice. So nice that I don't even feel like
"       bothering with configuration.
"
" Unfortunately this is becoming less true as now I need to install
" a separate plugin that provides airline themes, I mean seriously
" I just want a fancy little line thing stop over-engineering it
"
" TODO: Magically install powerline-ready fonts, so we get nice symbols.
" However, since I'm probably using Vim from a terminal I'm not sure how
" much utility there will be.
Define g:airline#extension#tagbar#enabled = 0
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'

" CTRL + P for quick file searching is wonderful.
Source '~/.vim/startup/packages/ctrlp.vim'

" Not sure if I need this TBH.
Plug 'tacahiroy/ctrlp-funky'

" Terry Ma's plugins are surprisingly nice -- using 'vim-expand-region' with
" hotkeys for 'v' and '<S-v>' makes expanding/contracting regions very nice.
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'

" Show substitution results as they're typed (e.g. for '%s|foo|bar|g')
Plug 'osyo-manga/vim-over'

" Tim Pope is my hero. Unfortunately I have a hard time remembering what each
" plugin does because the plugin names are too clever for me. But they are
" clever.

" Fix-up common spelling mistakes.
Plug 'tpope/vim-abolish'

" Make '.' work better with plugin maps.
Plug 'tpope/vim-repeat'

" Automagically infer shiftwidth, expandtab.
Plug 'tpope/vim-sleuth'

" Surround various word objects with stuff.
Plug 'tpope/vim-surround'

" Utility keybindings for moving around buffers and so on.
" Mainly keyed off of '[' and ']'.
"
" In particular, I really like the 'file' movement commands; '[f' and ']f'.
Plug 'tpope/vim-unimpaired'

" Very nice 'git' interface from vim.
Plug 'tpope/vim-fugitive'

" Automagically add 'end*' when appropriate.
Plug 'tpope/vim-endwise'

" Autocompletion of various pairs.
let g:AutoPairsMultilineClose = 0
Plug 'jiangmiao/auto-pairs'

" Comment management.
Plug 'tpope/vim-commentary'

" Use 'syntastic' for linting etc. I only really use this
" in JavaScript.
Plug 'scrooloose/syntastic'

" Nice vertical alignment. Although the package hasn't been updated in a
" while, it seems to have 'solved' this particular problem.
Plug 'godlygeek/tabular'

if executable('ctag')
	Plug 'majutsushi/tagbar'
endif

Source "~/.vim/startup/packages/neocomplete.vim"

" Easy-motion. Like Ace jump. I don't know who came first.
Plug 'Lokaltog/vim-easymotion'

" Python-related stuff. Note that I don't write python very often.
Plug 'davidhalter/jedi-vim'

" JavaScript.
Plug 'jelera/vim-javascript-syntax'

" Autocompletion for JavaScript using Tern.
if (!IsWindows())
    if IsDirectory("~/.vim/bundle/tern_for_vim")
        if !IsDirectory("~/.vim/bundle/tern_for_vim/node_modules")
            !cd ~/.vim/bundle/tern_for_vim && npm install
        endif
        if executable('tern')
            Plug 'ternjs/tern_for_vim'
        endif
    endif
endif

Plug 'kevinushey/vim-deferred'
Plug 'mattn/emmet-vim'
Plug 'derekwyatt/vim-scala'

let g:UltiSnipsSnippetDir = "~/.vim/snippets"
" TODO: Complains that Python's site module is not loadable?
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

call plug#end()
filetype plugin indent on

