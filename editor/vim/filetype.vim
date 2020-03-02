
augroup FileTypes
    autocmd!

    autocmd BufRead,BufNewFile .Renviron  set filetype=make
    autocmd BufRead,BufNewFile .Rprofile  set filetype=r
    autocmd BufRead,BufNewFile .eslintrc  set filetype=json
    autocmd BufRead,BufNewFile *.md       set wrap | set linebreak
    autocmd BufRead,BufNewFile *.Rmd      set wrap | set linebreak
    autocmd BufRead,BufNewFile CMake*.txt set filetype=cmake
    autocmd BufRead,BufNewFile Makevars   set filetype=make
    autocmd BufRead,BufNewFile bash-fc*   set filetype=sh
    autocmd BufRead,BufNewFile renv.lock  set filetype=json

augroup END

