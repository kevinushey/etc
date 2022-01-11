if !has('nvim')
	finish
endif

Plug 'neoclide/coc-neco', LoadIf(g:CompletionEngine ==# 'coc')
Plug 'neoclide/coc.nvim', LoadIf(g:CompletionEngine ==# 'coc', {'branch': 'release'})

