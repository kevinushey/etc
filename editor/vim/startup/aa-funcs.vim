
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

function! InsertModeCtrlE()
    normal! $
    return ''
endfunction

function! InsertModeTab()

    if pumvisible()
        let item = get(v:, 'completed_item', {})
        if empty(item)
            return "\<C-E>\<Tab>"
        else
            return "\<C-Y>"
        endif
    endif

    return "\<Tab>"

endfunction

function! InsertModeCR()

    if pumvisible()
        let item = get(v:, 'completed_item', {})
        if empty(item)
            return "\<C-E>\<CR>"
        else
            return "\<C-Y>"
        endif
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

