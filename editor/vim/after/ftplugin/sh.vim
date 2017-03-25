function! GetShIndentWrapper()
    let Syntax = synIDattr(synID(line("."), col("."), 1), "name")
    if Syntax =~ "HereDoc"
        return indent(line("."))
    endif

    return GetShIndent()
endfunction

" Ensure '-' is treated as part of identifier

" Preserve indentation within heredocs
setlocal iskeyword=@,48-57,_,192-255,#,.,-
setlocal indentexpr=GetShIndentWrapper()

" Don't expand tabs in shell scripts (for heredoc)
setlocal noexpandtab
setlocal copyindent
setlocal preserveindent
setlocal softtabstop=0
setlocal shiftwidth=4
setlocal tabstop=4
setlocal list

