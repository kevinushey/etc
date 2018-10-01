let mapleader="\<Space>"
set timeoutlen=500

" Remap leader + direction to choose window
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    execute join(['nnoremap', '<Leader>' . key, '<C-W>' . key], ' ')
endfor

noremap <C-c> <Esc>
map <Leader><Leader> <Plug>(easymotion-prefix)

noremap <Leader>d "+d
noremap <Leader>P "+P
noremap <Leader>y "+y
noremap <Leader>= <C-w>=

nnoremap <Leader>- :sp<CR>
nnoremap <Leader>/ :OverCommandLine<CR>
nnoremap <Leader>\ :vsp<CR>
nnoremap <Leader>h :tab help
nnoremap <Leader>q :q<CR>
nnoremap <Leader>s :nohlsearch<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>z :tab split<CR>

nnoremap <silent> [g :tabprevious<CR>
nnoremap <silent> ]g :tabnext<CR>

vnoremap . :normal .<CR>
vnoremap < <gv
vnoremap > >gv

vnoremap <Leader>s :!sort<CR>gv

vnoremap <silent> <expr> p 'Pgv"' . v:register . 'y'
vnoremap <silent> <expr> P 'Pgv"' . v:register . 'y'

imap <expr> <CR> SmartCR()

cnoremap q: :q
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>

if isdirectory(expand('~/.vim/bundle/vim-expand-region'))
    vmap v     <Plug>(expand_region_expand)
    vmap <S-v> <Plug>(expand_region_shrink)
endif

if isdirectory(expand('~/.vim/bundle/vim-fugitive'))
    noremap <silent> <Leader>g-      :Gsplit<CR>
    noremap <silent> <Leader>g\      :Gvsplit<CR>
    noremap <silent> <Leader>g<Down> :Gpull<CR>
    noremap <silent> <Leader>g<Up>   :Gpush<CR>
    noremap <silent> <Leader>gb      :Gblame<CR>
    noremap <silent> <Leader>gc      :Gcommit<CR>
    noremap <silent> <Leader>gd      :Gdiff<CR>
    noremap <silent> <Leader>ge      :Gedit<CR>
    noremap <silent> <Leader>gf      :GFiles<CR>
    noremap <silent> <Leader>gg      :Ggrep<CR>
    noremap <silent> <Leader>gi      :Git add -p %<CR>
    noremap <silent> <Leader>gl      :Glog<CR>
    noremap <silent> <Leader>gm      :Gmerge<CR>
    noremap <silent> <Leader>gp      :Git push<CR>
    noremap <silent> <Leader>gq      :q<CR>
    noremap <silent> <Leader>gr      :Gread<CR>
    noremap <silent> <Leader>gs      :Gstatus<CR>
    noremap <silent> <Leader>gw      :Gwrite<CR>
    noremap <silent> <Leader>gz      :Gbrowse<CR>
endif

if isdirectory(expand('~/.vim/bundle/fzf.vim'))
    noremap <Leader>b :Buffers<CR>
    noremap <Leader>f :Ag -Q ''<Left>
    noremap <Leader>l :Lines<CR>
    noremap <Leader>o :Files<CR>
    noremap <Leader>p :ProjectFiles<CR>
endif

if isdirectory(expand('~/.vim/bundle/nerdtree'))
    noremap <Leader>n :NERDTreeToggle<CR>
endif

