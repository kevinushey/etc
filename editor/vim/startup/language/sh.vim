function! InitSh()

    " Ensure '-' is treated as part of identifier
    execute "setlocal iskeyword=" . &iskeyword . ",-"

    " Preserve indentation within heredocs
    setlocal indentexpr=GetShIndentWrapper()

endfunction

function! GetShIndentWrapper()
    let Syntax = synIDattr(synID(line("."), col("."), 1), "name")
    if Syntax =~ "HereDoc"
        return indent(line("."))
    endif

    return GetShIndent()
endfunction

