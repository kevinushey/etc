EnsureDirectory "~/.vim/bundle"

" Use Vundle to manage packages
if !IsDirectory("~/.vim/bundle/Vundle.vim")
	!git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
endif

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" NOTE: The package names _must_ be supplied with single quotes!
" I guess it might be related to the fact that in vimscript,
" single-quoted strings are 'literal' strings (ie with no escapes)
" but still that's a pretty lame user experience, especially because
" the error message is not helpful.
Plugin 'gmarik/Vundle.vim'

" NERDTree gives us a nice tree-based view of files and a nice interface for
" interacting with said tree.
Plugin 'scrooloose/nerdtree'

" 'ag' is grep on steroids and goes a long ways towards understanding which
" files you probably care about (and excludes files you don't care about)
Plugin 'rking/ag.vim'

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
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'

" This gives me my favourite color scheme 'Tomorrow Night Bright'.
Plugin 'flazz/vim-colorschemes'

" CTRL + P for quick file searching is wonderful.
let g:ctrlp_follow_symlinks = 1
Plugin 'ctrlpvim/ctrlp.vim'

" Not sure if I need this TBH.
Plugin 'tacahiroy/ctrlp-funky'

" Terry Ma's plugins are surprisingly nice -- using 'vim-expand-region' with
" hotkeys for 'v' and '<S-v>' makes expanding/contracting regions very nice.
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'

" Show substitution results as they're typed (e.g. for '%s|foo|bar|g')
Plugin 'osyo-manga/vim-over'

" Tim Pope is my hero. Unfortunately I have a hard time remembering what each
" plugin does because the plugin names are too clever for me. But they are
" clever.

" Fix-up common spelling mistakes.
Plugin 'tpope/vim-abolish'

" Make '.' work better with plugin maps.
Plugin 'tpope/vim-repeat'

" Automagically infer shiftwidth, expandtab.
Plugin 'tpope/vim-sleuth'

" Surround various word objects with stuff.
Plugin 'tpope/vim-surround'

" Utility keybindings for moving around buffers and so on.
" Mainly keyed off of '[' and ']'.
"
" In particular, I really like the 'file' movement commands; '[f' and ']f'.
Plugin 'tpope/vim-unimpaired'

" Very nice 'git' interface from vim.
Plugin 'tpope/vim-fugitive'

" Automagically add 'end*' when appropriate.
Plugin 'tpope/vim-endwise'

" Autocompletion of various pairs.
Plugin 'jiangmiao/auto-pairs'

" Comment management.
Plugin 'tpope/vim-commentary'

" Use 'syntastic' for linting etc.
Plugin 'scrooloose/syntastic'

" Nice vertical alignment. Although the package hasn't been updated in a
" while, it seems to have 'solved' this particular problem.
Plugin 'godlygeek/tabular'

if executable('ctag')
	Plugin 'majutsushi/tagbar'
endif

" Use Shougo's autocompletion. Because it requires a lot
" of configuration to make sure it works well, everything is
" moved to a separate file.
Source "~/.vim/startup/extra/neocomplete.vim"

" Python-related stuff. Note that I don't write python very often.

" TODO: Does this play well with 'neocomplete'?
Plugin 'davidhalter/jedi-vim'

" JavaScript.
Plugin 'jelera/vim-javascript-syntax'
Plugin 'marijnh/tern_for_vim'

call vundle#end()
filetype plugin on

