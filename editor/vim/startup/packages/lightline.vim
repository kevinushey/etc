set noshowmode

let g:lightline =
\ {
\   'active': {
\     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
\   }
\ }

Plug 'itchyny/lightline.vim'
