Plug 'zchee/deoplete-jedi', LoadIf(g:CompletionEngine ==# 'deoplete')

if g:CompletionEngine !=# 'deoplete'
	finish
endif

