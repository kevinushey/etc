augroup FileTypes
    autocmd!

    autocmd BufRead,BufNewFile .Renviron  set filetype=make
    autocmd BufRead,BufNewFile .Rprofile  set filetype=r
    autocmd BufRead,BufNewFile .eslintrc  set filetype=json
    autocmd BufRead,BufNewFile CMake*.txt set filetype=cmake
    autocmd BufRead,BufNewFile Makevars   set filetype=make
    autocmd BufRead,BufNewFile bash-fc*   set filetype=sh

augroup END

