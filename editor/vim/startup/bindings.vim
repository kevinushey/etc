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
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>s :nohlsearch<CR>
nnoremap <Leader>l :set list!<CR>
nnoremap <Leader>\ :vsp<CR>
nnoremap <Leader>- :sp<CR>
nnoremap <Leader>/ :OverCommandLine<CR>
nnoremap <Leader>b :Buffers<CR>

NVMap <leader>y "+y
NVMap <leader>d "+d
NVMap <leader>p "+p
NVMap <leader>P "+P

vnoremap . :normal .<CR>
vnoremap < <gv
vnoremap > >gv

vmap v     <Plug>(expand_region_expand)
vmap <S-v> <Plug>(expand_region_shrink)

imap <expr> <CR> SmartCR()

cnoremap q: :q

if isdirectory(expand("~/.vim/bundle/tabular"))
    NVMap <Leader>a&     :Tabularize /&<CR>
    NVMap <Leader>a,     :Tabularize /,<CR>
    NVMap <Leader>a,,    :Tabularize /,\zs<CR>
    NVMap <Leader>a:     :Tabularize /:<CR>
    NVMap <Leader>a::    :Tabularize /:\zs<CR>
    NVMap <Leader>a<Bar> :Tabularize /<Bar><CR>
    NVMap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
    NVMap <Leader>a=>    :Tabularize /=><CR>
    NVMap <Leader>a\     :Tabularize /\\/
endif

if isdirectory(expand("~/.vim/bundle/vim-fugitive"))
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    nnoremap <silent> <leader>gi :Git add -p %<CR>
    nnoremap <silent> <leader>gg :SignifyToggle<CR>
endif

if isdirectory(expand("~/.vim/bundle/fzf.vim"))
    NVMap <Leader>f :ProjectFiles<CR>
    NVMap <Leader>b :Buffers<CR>
endif

