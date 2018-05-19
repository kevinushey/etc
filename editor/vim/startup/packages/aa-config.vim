" Use completion engine appropriate for the version of Vim
" currently being used.
if v:version >= 800 && has('python3') && has('timers')
    let g:CompletionEngine = 'deoplete'
elseif has('lua')
    let g:CompletionEngine = 'neocomplete'
else
    let g:CompletionEngine = 'none'
endif

