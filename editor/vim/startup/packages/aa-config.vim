" Use completion engine appropriate for the version of Vim
" currently being used.
if has('nvim')
    let g:CompletionEngine = 'deoplete'
elseif has('lua')
    let g:CompletionEngine = 'neocomplete'
else
    let g:CompletionEngine = 'none'
endif

" Use ale with newer Vim; syntastic otherwise
if has('nvim') || v:version >= 800
    let g:LintEngine = 'ale'
else
    let g:LintEngine = 'syntastic'
endif
