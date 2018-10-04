" Execute the current visual selection.
function! VimExecuteSelection()
    return "\"zy:@z\<CR>"
endfunction

" Source the current file.
function! VimExecuteFile()
    write
    execute join(['source', fnameescape(expand('%:p'))], ' ')
endfunction

vnoremap <buffer> <silent> <expr> <CR> VimExecuteSelection()
nnoremap <buffer> <silent> <expr> <CR> VimExecuteFile()

