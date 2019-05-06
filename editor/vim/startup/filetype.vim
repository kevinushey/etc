augroup FileTypes
    autocmd!

    autocmd BufRead,BufNewFile .Rprofile  set filetype=r
    autocmd BufRead,BufNewFile .eslintrc  set filetype=json
    autocmd BufRead,BufNewFile .Renviron  set filetype=sh
    autocmd BufRead,BufNewFile CMake*.txt set filetype=cmake
    autocmd BufRead,BufNewFile bash-fc*   set filetype=sh
    autocmd BufRead,BufNewFile Makevars   set filetype=make

augroup END

