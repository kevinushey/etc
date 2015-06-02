"" Basic configuration

"Colorschemes (in order of preference)
ColorScheme Tomorrow-Night-Bright default

"Soft tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"Soft wrapping
set wrap

"I don't like seeing punctuation characters
set nolist
set nospell

"Leader-key related functionality
let mapleader="\<Space>"
set timeoutlen=500

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"Make expand region behave nicely with v, <S-v>
vmap v <Plug>(expand_region_expand)
vmap <S-v> <Plug>(expand_region_shrink)

" Don't let the stupid console thing popup
map q: :q

" Use '## ' for commas in R scripts
if has("autocmd")
	autocmd FileType r set commentstring=##\ %s
endif

" jk to go back to normal mode
inoremap jk <esc>

" Mapping <CR> is a pain in the butt. The various plugin authors all attempt
" to make their plugins play nicely with <CR>; unfortunately we will always
" end up with conflicts.
function! SmartCR()

    " If a popup is visible, let neocomplete handle it.
    if pumvisible()
        if neosnippet#expandable()
            return "\<Plug>(neosnippet_expand)" . neocomplete#smart_close_popup()
        else
            return neocomplete#smart_close_popup()
        endif
    endif

    " If auto pairs is loaded, let it attempt to autopair.
    if exists('g:AutoPairsLoaded')
        call AutoPairsReturn()
    endif

    " If endwise is loaded, let it attempt to ... end-wise.
    if exists('g:loaded_endwise')
        execute "<Plug>DiscretionaryEnd"
    endif

endfunction

function! RemapCR()
    " iunmap <CR>
    " iunmap <buffer> <CR>
    " imap <expr><CR> SmartCR()
endfunction
autocmd BufEnter * :call RemapCR()

"" C, C++ related editing stuff
"Don't indent namespaces
set cinoptions=N-s

"Don't indent public:, private:
set cinoptions=g0

" Don't indent namespace and template
function! CppNoNamespaceAndTemplateIndent()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num - 1)
        let l:pline = getline(l:pline_num)
    endwhile
    let l:retv = cindent('.')
    let l:pindent = indent(l:pline_num)
    if l:pline =~# '^\s*template\s*\s*$'
        let l:retv = l:pindent
    elseif l:pline =~# '\s*typename\s*.*,\s*$'
        let l:retv = l:pindent
    elseif l:cline =~# '^\s*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '\s*typename\s*.*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '^\s*namespace.*'
        let l:retv = 0
    endif
    return l:retv
endfunction

if has("autocmd")
    autocmd BufEnter *.{cc,cxx,cpp,h,hh,hpp,hxx} setlocal indentexpr=CppNoNamespaceAndTemplateIndent()
endif

