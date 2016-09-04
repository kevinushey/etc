let mapleader="\<Space>"
set timeoutlen=500

" Remap leader + direction to choose window
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
	execute join(['nnoremap', '<Leader>' . key, '<C-W>' . key], " ")
endfor

" Quickly navigate to buffers based on index
for i in range(1, 9)
    execute "nnoremap <Leader>" . i . " :b" . i . "<CR>"
endfor

map <Leader><Leader> <Plug>(easymotion-prefix)

nnoremap <Leader>r :call Reload() \| Echo "Reloaded '" . @% . "'."<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>s :nohlsearch<CR>
nnoremap <Leader>l :set list!<CR>
nnoremap <Leader>\ :vsp<CR>
nnoremap <Leader>- :sp<CR>
nnoremap <Leader>/ :OverCommandLine<CR>

NVMap <leader>y "+y
NVMap <leader>d "+d
NVMap <leader>p "+p
NVMap <leader>P "+P

vmap v <Plug>(expand_region_expand)
vmap <S-v> <Plug>(expand_region_shrink)

cnoremap q: :q

inoremap <expr> <CR> SmartCR()
inoremap jk <Esc>

