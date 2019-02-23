let mapleader="\<Space>"
set timeoutlen=500

" Remap leader + direction to choose window
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    execute join(['nnoremap', '<Leader>' . key, '<C-W>' . key], ' ')
endfor

noremap <C-C> <Esc>
map <Leader><Leader> <Plug>(easymotion-prefix)

noremap  <silent> <Up>   gk
noremap  <silent> <Down> gj

inoremap <silent> <expr> <Up>   pumvisible() ? "\<Up>"   : "\<C-o>gk"
inoremap <silent> <expr> <Down> pumvisible() ? "\<Down>" : "\<C-o>gj"

noremap <silent> <Leader>d "+d
noremap <silent> <Leader>P "+P
noremap <silent> <Leader>y "+y
noremap <silent> <Leader>= <C-W>=

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

inoremap <C-A> <C-O>^
inoremap <C-E> <C-O>$

imap <expr> <CR> SmartCR()

cnoremap q: :q
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-B> <S-Left>
cnoremap <C-F> <S-Right>

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
    nnoremap <Leader>b :Buffers<CR>
    nnoremap <Leader>c :Cd<CR>
    nnoremap <Leader>f :Ag -Q -- ''<Left>
    xnoremap <Leader>f ""y:<C-U>Ag -Q -- ''<Left><C-R>"<CR>
    nnoremap <Leader>h :History<CR>
    nnoremap <Leader>H :Helptags<CR>
    nnoremap <Leader>j :Jumps<CR>
    nnoremap <Leader>l :Lines<CR>
    nnoremap <Leader>L :Locate ''<Left>
    nnoremap <Leader>m :Marks<CR>
    nnoremap <Leader>o :Files<CR>
    nnoremap <Leader>p :ProjectFiles<CR>
    nnoremap <Leader>s :Ag -Q -- '<C-R>=expand("<cword>")<CR>'<CR>
    xnoremap <Leader>s ""y:<C-U>Ag -Q -- ''<Left><C-R>"<CR>
    nnoremap <Leader>t :Tags<CR>
    nnoremap <Leader>w :Windows<CR>
endif

if isdirectory(expand('~/.vim/bundle/nerdtree'))
    noremap <Leader>n :NERDTreeToggle<CR>
endif

