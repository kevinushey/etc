
augroup FileTypes
    autocmd!

    autocmd BufRead,BufNewFile .Renviron     set filetype=make
    autocmd BufRead,BufNewFile .Rprofile     set filetype=r
    autocmd BufRead,BufNewFile .eslintrc     set filetype=json
    autocmd BufRead,BufNewFile *.cmake       set filetype=cmake
    autocmd BufRead,BufNewFile *.gyp         set filetype=json
    autocmd BufRead,BufNewFile *.md          set wrap | set linebreak
    autocmd BufRead,BufNewFile *.Rmd         set wrap | set linebreak
    autocmd BufRead,BufNewFile CMake*.txt    set filetype=cmake
    autocmd BufRead,BufNewFile Dockerfile*   set filetype=dockerfile
    autocmd BufRead,BufNewFile Makevars      set filetype=make
    autocmd BufRead,BufNewFile bash-fc*      set filetype=sh
    autocmd BufRead,BufNewFile Jenkinsfile.* set filetype=groovy
    autocmd BufRead,BufNewFile renv.lock     set filetype=json

augroup END

augroup Binary
    autocmd!

    autocmd BufReadPre   *.rds let &bin=1
    autocmd BufReadPost  *.rds if &bin | %!xxd
    autocmd BufReadPost  *.rds set ft=xxd | endif
    autocmd BufWritePre  *.rds if &bin | %!xxd -r
    autocmd BufWritePre  *.rds endif
    autocmd BufWritePost *.rds if &bin | %!xxd
    autocmd BufWritePost *.rds set nomod | endif
    
augroup END
