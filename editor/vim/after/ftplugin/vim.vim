" Execute the current visual selection.
function! VimExecuteSelection()
    return '""y:@"' . "\<CR>"
endfunction

" Execute the current line.
function! VimExecuteLine()
    return '""yy:@"' . "\<CR>h^" 
endfunction

vnoremap <buffer> <silent> <expr> <CR> VimExecuteSelection()
nnoremap <buffer> <silent> <expr> <CR> VimExecuteLine()

