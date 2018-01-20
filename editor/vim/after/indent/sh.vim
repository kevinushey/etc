" We should indent following lines endings with these patterns.
let g:ShBeginParts   = ['\(', '\{', '\[', '<then>', '<do>', '<else>', '<elif>', '<in>', '\S\)']
let g:ShBeginPattern = '\v%(' . join(g:ShBeginParts, '|') . ')\s*%(#.*)=$'

" We should deindent a line beginning with these patterns.
let g:ShEndParts     = ['\)', '\}', '\]', '<else>', '<elif>', '<fi>', '<done>', '<end>', ';;']
let g:ShEndPattern   = '\v^\s*%(' . join(g:ShEndParts, '|') . ')'

function! GetShIndentWrapper()

    " No indent at start
    if v:lnum == 0
        return 0
    endif

    " Preserve indentation within heredocs.
    for Item in synstack(v:lnum, 1)
        if synIDattr(Item, "name") =~? 'heredoc'
            return indent(v:lnum)
        endif
    endfor

    " Handle continuations specially. Find the first non-continuation line,
    " and then add a single shift width.
    let Index = v:lnum - 1
    if getline(Index) =~# '\v\\\s*$'

        " If the continuation line we just examined was part of a string,
        " then use zero indent.
        for Item in synstack(Index, strwidth(getline(Index)))
            if synIDattr(Item, "name") ==# 'shDoubleQuote'
                return 0
            endif
        endfor

        while getline(Index) =~# '\v\\\s*$'
            let Index = Index - 1
        endwhile
        return indent(Index + 1) + shiftwidth()
    endif

    " We'll de-indent lines that match the end pattern.
    let Adjust = getline(v:lnum) =~# g:ShEndPattern ? -shiftwidth() : 0

    while Index > 0
        let Line = getline(Index)

        " Skip comments.
        if Line =~# '\v^\s*#'
            let Index = Index - 1
            continue
        endif

        " Handle 'case in' specially (we prefer not to indent there)
        if Line =~# '\v^\s*<case>' && Line =~# '\v<in>\s*$'
            return indent(Index) + Adjust
        endif

        " If we find a 'begin' pattern, we add an indent.
        if Line =~# g:ShBeginPattern
            return indent(Index) + shiftwidth() + Adjust
        endif

        " If we find an 'end' pattern, we can inherit its indentation.
        if Line =~# g:ShEndPattern
            return indent(Index) + Adjust
        endif

        " Keep going!
        let Index = Index - 1

    endwhile

    " Failed to find anything to motivate indentation; return 0
    return 0

endfunction

" Preserve indentation within heredocs
setlocal indentexpr=GetShIndentWrapper()

