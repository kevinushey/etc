" Use completion engine appropriate for the version of Vim
" currently being used.
if v:version < 800 && has('lua')
    let g:CompletionEngine = 'neocomplete'
elseif v:version >= 800 && has('python3') && has('timers')
    let g:CompletionEngine = 'deoplete'
else
    let g:CompletionEngine = 'none'
endif
