set noshowmode

if g:CompletionEngine ==# "coc"

	let g:lightline =
	\ {
	\   'active': {
	\     'left': [ [ 'mode', 'paste' ], [ 'cocstatus', 'readonly', 'absolutepath', 'modified' ] ],
	\   },
	\   'component_function': {
	\     'cocstatus': 'coc#status'
	\	},
	\ }

	Plug 'itchyny/lightline.vim'

	if g:CompletionEngine ==# "coc"
		autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
	endif

else

	let g:lightline =
	\ {
	\   'active': {
	\     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
	\   }
	\ }

	Plug 'itchyny/lightline.vim'

endif

