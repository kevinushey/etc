Plug 'Shougo/deoplete.nvim'    , LoadIf(g:CompletionEngine ==# 'deoplete')
Plug 'roxma/nvim-yarp'         , LoadIf(g:CompletionEngine ==# 'deoplete')
Plug 'roxma/vim-hug-neovim-rpc', LoadIf(g:CompletionEngine ==# 'deoplete')
 
if !g:CompletionEngine ==# 'deoplete'
    finish
endif

let g:deoplete#enable_at_startup = 1

