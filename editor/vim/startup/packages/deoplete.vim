Plug 'Shougo/deoplete.nvim'    , LoadIf(g:CompletionEngine ==# 'deoplete')
Plug 'roxma/nvim-yarp'         , LoadIf(g:CompletionEngine ==# 'deoplete')
Plug 'roxma/vim-hug-neovim-rpc', LoadIf(g:CompletionEngine ==# 'deoplete')

if g:CompletionEngine !=# 'deoplete'
    finish
endif

let g:HasNeovimModule = 0

" Vim can emit some bogus deprecation warnings when running Python
silent! py3 <<EOF

has_neovim = 0
try:
    import neovim
    has_neovim = 1
except:
    pass

import vim
vim.command("let g:HasNeovimModule = %i" % has_neovim)

EOF

if !g:HasNeovimModule && executable('pip3')
    !pip3 install --upgrade --user neovim
endif

let g:deoplete#enable_at_startup = 1

function! DeopleteInit() abort

    call deoplete#custom#buffer_option({
    \   'auto_complete_delay' : 200,
    \   'auto_refresh_delay'  : 100,
    \   'min_pattern_length'  : 2,
    \   'on_insert_enter'     : v:false,
    \   'refresh_always'      : v:false,
    \   'smart_case'          : v:true,
    \   })

    call deoplete#custom#source('_', 'converters', [
    \ 'converter_auto_delimiter',
    \ 'converter_auto_paren',
    \ 'converter_remove_overlap',
    \ 'converter_truncate_abbr',
    \ 'converter_truncate_menu'
    \ ])

endfunction

augroup DeopleteInit
    autocmd!
    autocmd BufEnter * call DeopleteInit()
augroup END

