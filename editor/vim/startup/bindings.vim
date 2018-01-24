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

nnoremap <Leader>h :tab help 
nnoremap <Leader>l :set list!<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>s :nohlsearch<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>z :tab split<CR>
nnoremap <Leader>\ :vsp<CR>
nnoremap <Leader>- :sp<CR>
nnoremap <Leader>/ :OverCommandLine<CR>

nnoremap <silent> [g :tabprevious<CR>
nnoremap <silent> ]g :tabnext<CR>

NVMap <Leader>d "+d
NVMap <Leader>P "+P
NVMap <Leader>y "+y
NVMap <Leader>= <C-w>=

vnoremap . :normal .<CR>
vnoremap < <gv
vnoremap > >gv

imap <expr> <CR> SmartCR()

cnoremap q: :q

if isdirectory(expand("~/.vim/bundle/vim-expand-region"))
    vmap v     <Plug>(expand_region_expand)
    vmap <S-v> <Plug>(expand_region_shrink)
endif

if isdirectory(expand("~/.vim/bundle/vim-fugitive"))
    NVMap <silent> <leader>g-      :Gsplit<CR>
    NVMap <silent> <leader>g\      :Gvsplit<CR>
    NVMap <silent> <leader>g<Down> :Gpull<CR>
    NVMap <silent> <leader>g<Up>   :Gpush<CR>
    NVMap <silent> <leader>gb      :Gblame<CR>
    NVMap <silent> <leader>gc      :Gcommit<CR>
    NVMap <silent> <leader>gd      :Gdiff<CR>
    NVMap <silent> <leader>ge      :Gedit<CR>
    NVMap <silent> <leader>gf      :GFiles<CR>
    NVMap <silent> <leader>gg      :Ggrep<CR>
    NVMap <silent> <leader>gi      :Git add -p %<CR>
    NVMap <silent> <leader>gl      :Glog<CR>
    NVMap <silent> <leader>gm      :Gmerge<CR>
    NVMap <silent> <leader>gp      :Git push<CR>
    NVMap <silent> <leader>gq      :q<CR>
    NVMap <silent> <leader>gr      :Gread<CR>
    NVMap <silent> <leader>gs      :Gstatus<CR>
    NVMap <silent> <leader>gw      :Gwrite<CR>
    NVMap <silent> <leader>gz      :Gbrowse<CR>
endif

if isdirectory(expand("~/.vim/bundle/fzf.vim"))
    NVMap <Leader>a :Ag 
    NVMap <Leader>b :Buffers<CR>
    NVMap <Leader>o :Files<CR>
    NVMap <Leader>p :ProjectFiles<CR>
endif

if isdirectory(expand("~/.vim/bundle/nerdtree"))
    NVMap <Leader>n :NERDTreeToggle<CR>
endif

