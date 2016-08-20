EnsureDirectory "~/.vim/bundle"

" Use dein.vim to manage packages
if !IsDirectory("~/.vim/bundle/dein.vim")
        let DestinationPath = expand('~/.vim/bundle/dein.vim')
        let Command = '!git clone ' .
            \ 'https://github.com/Shougo/dein.vim ' .
            \ DoubleQuotedEscaped(DestinationPath)
        echomsg 'Installing ''dein.vim''...'
        execute Command
endif

filetype plugin off
set runtimepath+=~/.vim/bundle/dein.vim
call dein#begin(expand('~/.vim/bundle'))

call dein#add(expand('~/.vim/bundle/dein.vim'))

" NERDTree gives us a nice tree-based view of files and a nice interface for
" interacting with said tree.
call dein#add('scrooloose/nerdtree')

" 'ag' is grep on steroids and goes a long ways towards understanding which
" files you probably care about (and excludes files you don't care about)
call dein#add('rking/ag.vim')

" This gives me my favourite color scheme 'Tomorrow Night Bright'.
call dein#add('flazz/vim-colorschemes')

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
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('bling/vim-bufferline')

" CTRL + P for quick file searching is wonderful.
Source '~/.vim/startup/package/ctrlp.vim'

" Not sure if I need this TBH.
call dein#add('tacahiroy/ctrlp-funky')

" Terry Ma's plugins are surprisingly nice -- using 'vim-expand-region' with
" hotkeys for 'v' and '<S-v>' makes expanding/contracting regions very nice.
call dein#add('terryma/vim-multiple-cursors')
call dein#add('terryma/vim-expand-region')

" Show substitution results as they're typed (e.g. for '%s|foo|bar|g')
call dein#add('osyo-manga/vim-over')

" Tim Pope is my hero. Unfortunately I have a hard time remembering what each
" plugin does because the plugin names are too clever for me. But they are
" clever.

" Fix-up common spelling mistakes.
call dein#add('tpope/vim-abolish')

" Make '.' work better with plugin maps.
call dein#add('tpope/vim-repeat')

" Automagically infer shiftwidth, expandtab.
call dein#add('tpope/vim-sleuth')

" Surround various word objects with stuff.
call dein#add('tpope/vim-surround')

" Utility keybindings for moving around buffers and so on.
" Mainly keyed off of '[' and ']'.
"
" In particular, I really like the 'file' movement commands; '[f' and ']f'.
call dein#add('tpope/vim-unimpaired')

" Very nice 'git' interface from vim.
call dein#add('tpope/vim-fugitive')

" Automagically add 'end*' when appropriate.
call dein#add('tpope/vim-endwise')

" Autocompletion of various pairs.
let g:AutoPairsMultilineClose = 0
call dein#add('jiangmiao/auto-pairs')

" Comment management.
call dein#add('tpope/vim-commentary')

" Use 'syntastic' for linting etc. I only really use this
" in JavaScript.
call dein#add('scrooloose/syntastic')

" Nice vertical alignment. Although the package hasn't been updated in a
" while, it seems to have 'solved' this particular problem.
call dein#add('godlygeek/tabular')

if executable('ctag')
	call dein#add('majutsushi/tagbar')
endif

" Use Shougo's autocompletion. Because it requires a lot
" of configuration to make sure it works well, everything is
" moved to a separate file.
if has("lua")
    Source "~/.vim/startup/package/neocomplete.vim"
else
    call dein#add('ervandew/supertab')
    let g:SuperTabDefaultCompletionType = "<c-n>"
endif

" Easy-motion. Like Ace jump. I don't know who came first.
call dein#add('Lokaltog/vim-easymotion')

" Python-related stuff. Note that I don't write python very often.
call dein#add('davidhalter/jedi-vim')

" JavaScript.
call dein#add('jelera/vim-javascript-syntax')

" Autocompletion for JavaScript using Tern.
if (!IsWindows())
    if IsDirectory("~/.vim/bundle/tern_for_vim")
        if !IsDirectory("~/.vim/bundle/tern_for_vim/node_modules")
            !cd ~/.vim/bundle/tern_for_vim && npm install
        endif
        call dein#add('marijnh/tern_for_vim')
    endif
endif

call dein#add('kevinushey/vim-deferred')
call dein#add('mattn/emmet-vim')
call dein#add('derekwyatt/vim-scala')

call dein#end()
filetype plugin indent on

