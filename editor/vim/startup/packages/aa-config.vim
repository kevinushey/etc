" Use completion engine appropriate for the version of Vim
" currently being used.
if has('nvim')
    let g:CompletionEngine = 'deoplete'
elseif has('lua')
    let g:CompletionEngine = 'neocomplete'
else
    let g:CompletionEngine = 'none'
endif

