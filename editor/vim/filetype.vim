if exists('did_load_filetypes')
	finish
endif

augroup filetypedetect
	autocmd!

	autocmd BufRead,BufNewFile .Rprofile  set filetype=r
    autocmd BufRead,BufNewFile .eslintrc  set filetype=json
    autocmd BufRead,BufNewFile .Renviron  set filetype=sh
    autocmd BufRead,BufNewFile CMake*.txt set filetype=cmake

augroup END

