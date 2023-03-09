if !has('nvim')
	finish
endif


function! CocCompletionTimerRun(timer)

    " don't run if we already have a popup window visible
    if pumvisible() || coc#pum#visible()
        return
    endif

    " ok, go for it
    call coc#start()

endfunction

function! CocCompletionTimerStart()

	" stop an already-running timer
    call CocCompletionTimerStop()

    " don't run in help buffers (or other buffers with special types)
    if &buftype !=# ''
        return
    endif

    " don't run if we already have a popup window visible
    if pumvisible() || coc#pum#visible()
        return
    endif

    let b:CompletionTimerId = timer_start(300, "CocCompletionTimerRun")

endfun

function! CocCompletionTimerStop()

    if exists("b:CompletionTimerId")
        call timer_stop(b:CompletionTimerId)
        unlet b:CompletionTimerId
    endif

endfun

augroup CocCompletionTimer
    autocmd!
    autocmd InsertLeavePre * call CocCompletionTimerStop()
    autocmd InsertCharPre * call CocCompletionTimerStart()
augroup end

Plug 'neoclide/coc-neco', LoadIf(g:CompletionEngine ==# 'coc')
Plug 'neoclide/coc.nvim', LoadIf(g:CompletionEngine ==# 'coc', {'branch': 'release'})

