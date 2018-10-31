Plug 'w0rp/ale', LoadIf(g:LintEngine ==# 'ale')

if g:LintEngine ==# 'ale'

	let g:ale_linters_explicit = 1
	let g:ale_lint_delay = 2000

	let g:ale_linters = {
	\ 'bash' : ['shellcheck'],
	\ 'sh'   : ['shellcheck'],
	\ 'vim'  : ['vint'],
	\ }

	let g:ale_vim_vint_show_style_issues = 0

	noremap ]r :ALENext<CR>
	noremap [r :ALEPrevious<CR>

endif

