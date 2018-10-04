Plug 'scrooloose/syntastic', LoadIf(g:LintEngine ==# 'syntastic')

if executable('vint')
	let g:syntastic_vim_checkers = ['vint']
endif
