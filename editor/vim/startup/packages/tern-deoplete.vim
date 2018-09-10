Plug 'carlitux/deoplete-ternjs', LoadIf(g:CompletionEngine == 'deoplete' && executable('tern'))

let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#case_insensitive = 1

