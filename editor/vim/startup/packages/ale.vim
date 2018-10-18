Plug 'w0rp/ale', LoadIf(g:LintEngine ==# 'ale')

if g:LintEngine ==# 'ale'

	let g:ale_lint_delay = 2000

	let g:ale_linters = {
	\ 'java': [],
	\ }

	noremap ]r :ALENext<CR>
	noremap [r :ALEPrevious<CR>

endif

