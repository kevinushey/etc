let mapleader="\<Space>"
set timeoutlen=500

function! InitBindings()

    " Remap leader + direction to choose window
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        execute join(['nnoremap', '<Leader>' . key, '<C-W>' . key], ' ')
    endfor

    noremap <C-C> <Esc>
    map <Leader><Leader> <Plug>(easymotion-prefix)

    noremap <silent> <Up>   gk
    noremap <silent> <Down> gj

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

    nnoremap <silent> <Leader>T :call RegenerateTags()<CR>
    xnoremap <silent> <Leader>T :call RegenerateTags()<CR>

    nnoremap <silent> [g :tabprevious<CR>
    nnoremap <silent> ]g :tabnext<CR>

    vnoremap . :normal .<CR>
    vnoremap < <gv
    vnoremap > >gv

    vnoremap <silent> <expr> p 'Pgv"' . v:register . 'y'
    vnoremap <silent> <expr> P 'Pgv"' . v:register . 'y'

    inoremap <silent> OA <C-R>=InsertModeUp()<CR>
    inoremap <silent> OB <C-R>=InsertModeDown()<CR>
    inoremap <silent> OC <Right>
    inoremap <silent> OD <Left>

    inoremap <silent> <Up>   <C-R>=InsertModeUp()<CR>
    inoremap <silent> <Down> <C-R>=InsertModeDown()<CR>
    inoremap <silent> <Esc>  <C-R>=InsertModeEscape()<CR>
    inoremap <silent> <C-A>  <C-R>=InsertModeCtrlA()<CR>
    inoremap <silent> <C-C>  <C-R>=InsertModeCtrlC()<CR>
    inoremap <silent> <C-E>  <C-R>=InsertModeCtrlE()<CR>

    inoremap <silent> <expr> <buffer> <Tab> InsertModeTab()
    inoremap <silent> <expr> <buffer> <CR>  InsertModeCR()

    cnoremap q: :q
    cnoremap <C-A> <Home>
    cnoremap <C-E> <End>
    cnoremap <C-B> <S-Left>
    cnoremap <C-F> <S-Right>

    map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

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
        nnoremap <Leader>f :Rg<Space>
        xnoremap <Leader>f ""y:<C-U>Ag -Q -- ''<Left><C-R>"<CR>
        nnoremap <Leader>h :History<CR>
        nnoremap <Leader>H :Helptags<CR>
        nnoremap <Leader>j :Jumps<CR>
        nnoremap <Leader>l :Lines<CR>
        nnoremap <Leader>L :Locate ''<Left>
        nnoremap <Leader>m :Marks<CR>
        nnoremap <Leader>o :Files<CR>
        nnoremap <Leader>p :ProjectFiles<CR>
        nnoremap <Leader>s :Rg <C-R>=expand("<cword>")<CR><CR>
        xnoremap <Leader>s ""y:<C-U>Rg <C-R>"<CR>
        nnoremap <Leader>t :Tags <C-R>=expand("<cword>")<CR><CR>
        xnoremap <Leader>t ""y:<C-U>Tags <C-R>"<CR>
        nnoremap <Leader>w :Windows<CR>
    endif

    if isdirectory(expand('~/.vim/bundle/nerdtree'))
        noremap <Leader>n :NERDTreeToggle<CR>
    endif

    if isdirectory(expand('~/.vim/bundle/LanguageClient-neovim'))
        nnoremap <silent> <Leader>ld :call LanguageClient#textDocument_definition()<CR>
        nnoremap <silent> <Leader>lf :call LanguageClient#textDocument_references()<CR>
        nnoremap <silent> <Leader>lh :call LanguageClient#textDocument_hover()<CR>
        nnoremap <silent> <Leader>lr :call LanguageClient#textDocument_rename()<CR>
        nnoremap <silent> <Leader>l. :call LanguageClient#workspace_symbol()<CR>
        nnoremap <silent> <Leader>ll :call LanguageClient_contextMenu()<CR>
    endif

    if isdirectory(expand('~/.vim/bundle/coc.nvim'))

        nmap <silent> ]w <Plug>(coc-diagnostic-next)
        nmap <silent> [w <Plug>(coc-diagnostic-prev)

        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        nmap <silent> K :call CocShowDocumentation()<CR>

        nmap <Leader>rn <Plug>(coc-rename)

        nmap <Leader>= <Plug>(coc-format-selected)
        xmap <Leader>= <Plug>(coc-format-selected)

        nmap <Leader>a <Plug>(coc-codeaction-selected)
        xmap <Leader>a <Plug>(coc-codeaction-selected)

        nmap <Leader>qf <Plug>(coc-fix-current)


    endif

endfunction

augroup Bindings
    autocmd!
    autocmd BufEnter * call InitBindings()
augroup END

