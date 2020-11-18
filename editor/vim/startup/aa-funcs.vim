
function! InsertModeUp()
    
    if pumvisible()
        return "\<C-P>"
    endif

    normal! gk
    return ''

endfunction

function! InsertModeDown()

    if pumvisible()
        return "\<C-N>"
    endif

    normal! gj
    return ''

endfunction

function! InsertModeEscape()

    if pumvisible()
        return "\<C-E>"
    endif

    return "\<Esc>"

endfunction

function! InsertModeCtrlA()
    normal! ^
    return ''
endfunction

function! InsertModeCtrlC()

    if pumvisible()
        return "\<C-E>"
    endif

    return "\<Esc>"

endfunction

function! InsertModeCtrlE()
    normal! $
    return ''
endfunction

function! InsertModeTab()

    if pumvisible()
        return "\<C-Y>"
    endif

    return "\<Tab>"

endfunction

function! InsertModeCR()

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

