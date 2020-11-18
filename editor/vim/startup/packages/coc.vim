Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', LoadIf(g:CompletionEngine ==# 'coc', {'branch': 'release'})

if !has('nvim')
	finish
endif

