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
Plugin 'ctrlpvim/ctrlp.vim'

" Not sure if I need this TBH.
Plugin 'tacahiroy/ctrlp-funky'

" I like auto-pairing but I am scared because with spf13 this didn't play well
" with neocomplete. But that may just be the fault of neocomplete. We'll see.
Plugin 'jiangmiao/auto-pairs'

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

" Automagically add 'end*' when appropriate
Plugin 'tpope/vim-endwise'

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

" Use Shougo's autocompletion.
" TODO: Move all of the configuration stuff to a separate file.
Bundle 'Shougo/neocomplete.vim.git'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'honza/vim-snippets'

" Set up a basic configuration for 'Neocomplete'.
" Copied + modified from 'https://github.com/Shougo/neocomplete.vim'.

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Python-related stuff. Note that I don't write python very often.

" TODO: Does this play well with 'neocomplete'?
Plugin 'davidhalter/jedi-vim'

" JavaScript.
Plugin 'jelera/vim-javascript-syntax'
Plugin 'marijnh/tern_for_vim'

call vundle#end()
filetype plugin on

