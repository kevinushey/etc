Plug 'Shougo/neocomplete.vim', LoadIf(g:CompletionEngine ==# 'neocomplete')

if g:CompletionEngine !=# 'neocomplete'
    finish
endif

" For the life of me, I cannot get neosnippet to play nicely with endwise
" or autopair. Unfortunately, I like those plugins much more than I like
" snippets.

" Set up a basic configuration for 'Neocomplete'.
" Copied + modified from 'https://github.com/Shougo/neocomplete.vim'.
let g:acp_enableAtStartup                           = 0
let g:neocomplete#auto_complete_delay               = 300
let g:neocomplete#cursor_hold_i_time                = 300
let g:neocomplete#enable_at_startup                 = 1
let g:neocomplete#enable_auto_close_preview         = 1
let g:neocomplete#enable_auto_delimiter             = 1
let g:neocomplete#enable_auto_select                = 1
let g:neocomplete#enable_cursor_hold_i              = 1
let g:neocomplete#enable_smart_case                 = 1
let g:neocomplete#lock_buffer_name_pattern          = '\*ku\*'
let g:neocomplete#max_keyword_width                 = 40
let g:neocomplete#max_list                          = 20
let g:neocomplete#sources#syntax#min_keyword_length = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries =
\ {
\     'default'  : '',
\     'vimshell' : expand('$HOME/.vimshell_hist'),
\     'scheme'   : expand('$HOME/.gosh_completions'),
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable omni completion in various filetypes.
augroup NeocompleteOmniFunc
    autocmd!
    autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

augroup NeocompleteInit
    autocmd!
    autocmd VimEnter call neocomplete#initialize()
augroup END

