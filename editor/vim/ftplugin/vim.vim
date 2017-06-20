" Execute the current visual selection.
function! VimExecuteSelection()
    return "\"zy:@z\<CR>"
endfunction

vnoremap <buffer> <expr> <CR> VimExecuteSelection()

