" Load the colorscheme and refresh airline.
ColorScheme wombat256mod slate default
autocmd VimEnter * silent! AirlineTheme dark
autocmd VimEnter * silent! AirlineToggleWhitespace

" Override annoying files that try to force spell-checking
autocmd BufEnter,BufWrite * set nospell

scriptencoding utf-8

" Disable menu-stuff (for GUIs)
if has("gui_running")
    " Hide the menu bar.
    set guioptions -=m

    " Hide the toolbar.
    set guioptions -=T
endif

set textwidth=0

" Nicer hlsearch
highlight Search cterm=NONE ctermfg=white ctermbg=12

" Soft tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Soft wrapping
set wrap

" Show line numbers
if !&number
    set number
endif

" Don't show punctuation characters by default.
set nolist

" Don't spellcheck.
set nospell

" Allow buffer switching without saving.
set hidden

" Show the current line.
set cursorline

" Make backups.
set backup
if has('persistent_undo')
    set undofile
    set undolevels=1000 
    set undoreload=10000
endif

" Make tab expand snippets in HTML.
function! HtmlTab()
    let Expression = ''
    if exists('g:loaded_emmet_vim') && emmet#isExpandable()
        return "\<Plug>(emmet-expand-abbr)"
    endif
    return "\<Tab>"
endfunction
autocmd FileType html imap <buffer><expr><Tab> HtmlTab()


" Leader-key related functionality
let mapleader="\<Space>"
set timeoutlen=500

" Remap leader + direction to choose window
let g:ArrowKeys = ['<Up>', '<Down>', '<Left>', '<Right>']
for key in g:ArrowKeys
    execute join(['nnoremap', '<Leader>' . key, '<C-W>' . key], " ")
endfor

nnoremap <Leader>r :call Reload() \| Echo "Reloaded '" . @% . "'."<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>s :nohlsearch<CR>
nnoremap <Leader>l :set list!<CR>

nnoremap <Leader>\ :vsp<CR>
nnoremap <Leader>- :sp<CR>

nnoremap <Leader>/ :OverCommandLine<CR>

map <Leader><Leader> <Plug>(easymotion-prefix)
for i in range(1, 9)
    execute "nnoremap <Leader>" . i . " :b" . i . "<CR>"
endfor

NVMap <leader>y "+y
NVMap <leader>d "+d
NVMap <leader>p "+p
NVMap <leader>P "+P

" Make expand region behave nicely with v, <S-v>
vmap v <Plug>(expand_region_expand)
vmap <S-v> <Plug>(expand_region_shrink)

" Don't let the stupid console thing popup
map q: :q

" Use '## ' for commas in R scripts
if has("autocmd")
	autocmd FileType r set commentstring=##\ %s
endif

" jk to go back to normal mode
inoremap jk <Esc>

function! SmartCR()

    " Allow neocomplete to take over the popup.
    if pumvisible()
        return neocomplete#close_popup()
    endif

    let Statement = "\<CR>"
    if exists('g:loaded_endwise')
        let Statement .= Lazy("EndwiseDiscretionary()")
    endif

    if exists('g:AutoPairsLoaded')
        let Statement .= Lazy("AutoPairsReturn()")
    endif

    return Statement

endfunction

imap <expr><CR> SmartCR()

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

