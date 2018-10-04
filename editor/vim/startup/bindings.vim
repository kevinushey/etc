let mapleader="\<Space>"
set timeoutlen=500

" Remap leader + direction to choose window
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    execute join(['nnoremap', '<Leader>' . key, '<C-W>' . key], ' ')
endfor

noremap <C-c> <Esc>
map <Leader><Leader> <Plug>(easymotion-prefix)

noremap <silent> <Leader>d "+d
noremap <silent> <Leader>P "+P
noremap <silent> <Leader>y "+y
noremap <silent> <Leader>= <C-w>=

nnoremap <silent> <Leader>- :sp<CR>
nnoremap <silent> <Leader>\ :vsp<CR>
nnoremap <silent> <Leader>h :tab help
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>z :tab split<CR>

nnoremap <silent> [g :tabprevious<CR>
nnoremap <silent> ]g :tabnext<CR>

vnoremap . :normal .<CR>
vnoremap < <gv
vnoremap > >gv

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
    noremap <Leader>h :History<CR>
    noremap <Leader>H :Helptags<CR>
    noremap <Leader>j :Jumps<CR>
    noremap <Leader>l :Lines<CR>
    noremap <Leader>L :Locate ''<Left>
    noremap <Leader>m :Marks<CR>
    noremap <Leader>o :Files<CR>
    noremap <Leader>p :ProjectFiles<CR>
    noremap <Leader>s :Ag -Q '<C-R>=expand("<cword>")<CR>'<CR>
    noremap <Leader>t :Tags<CR>
    noremap <Leader>w :Windows<CR>
endif

if isdirectory(expand('~/.vim/bundle/nerdtree'))
    noremap <Leader>n :NERDTreeToggle<CR>
endif

