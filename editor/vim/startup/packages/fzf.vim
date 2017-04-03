Plug 'junegunn/fzf',     LoadIf(v:version >= 704, { 'dir': '~/.fzf', 'do': './install --all' })
Plug 'junegunn/fzf.vim', LoadIf(v:version >= 704)

" Prefer 'raw' interface to Ag
command!      -bang -nargs=* Ag call fzf#vim#ag_raw(<q-args>, <bang>0)
