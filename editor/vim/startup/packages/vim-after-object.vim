Plug 'junegunn/vim-after-object'

augroup VimAfterObject
	autocmd!
	autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
augroup END
