
function! InsertModeUp()
 
    if get(g:, "coc_enabled", 0) && coc#pum#visible()
        return coc#pum#prev(0)
    endif

    if pumvisible()
        return "\<C-P>"
    endif

    normal! gk
    return ''

endfunction

function! InsertModeDown()

    if get(g:, "coc_enabled", 0) && coc#pum#visible()
        return coc#pum#next(0)
    endif

    if pumvisible()
        return "\<C-N>"
    endif

    normal! gj
    return ''

endfunction

function! InsertModeEscape()

    if get(g:, "coc_enabled", 0) && coc#pum#visible()
        return coc#pum#cancel()
    endif

    if pumvisible()
        return "\<C-E>"
    endif

    return "\<Esc>"

endfunction

function! InsertModeCtrlC()

    if get(g:, "coc_enabled", 0) && coc#pum#visible()
        return coc#pum#cancel()
    endif

    if pumvisible()
        return "\<C-E>"
    endif

    return "\<Esc>"

endfunction

function! InsertModeTab()

    if get(g:, "coc_enabled", 0) && coc#pum#visible()
        return coc#pum#confirm()
    endif

    if pumvisible()
        return "\<C-Y>"
    endif

    return "\<Tab>"

endfunction

function! InsertModeCR()

    if get(g:, "coc_enabled", 0) && coc#pum#visible()
        return coc#pum#confirm()
    endif

    if pumvisible()
        return "\<C-Y>"
    endif

    let Statement = "\<CR>"
    if exists('g:loaded_endwise')
        let Statement .= "\<C-R>=EndwiseDiscretionary()\<CR>"
    endif

    if exists('g:AutoPairsLoaded')
        let Statement .= "\<C-R>=AutoPairsReturn()\<CR>"
    endif

    return Statement

endfunction

function! CocShowDocumentation()

    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h ' . expand('<cword>')
    else
        call CocAction('doHover')
    endif

endfunction

