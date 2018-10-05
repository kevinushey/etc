Plug 'junegunn/fzf',     LoadIf(v:version >= 704, { 'dir': '~/.fzf', 'do': './install --all' })
Plug 'junegunn/fzf.vim', LoadIf(v:version >= 704)

" Prefer 'raw' interface to Ag
command! -bang -nargs=* Ag call fzf#vim#ag_raw(<q-args>, <bang>0)

" Until https://github.com/junegunn/fzf.vim/pull/710/files is merged
if !exists('*fzf#vim#jumps')

	function! s:jump_sink(line)

		let idx = index(s:jumplist, a:line)
		if idx == -1
			return
		endif

		let current = match(s:jumplist, '\v^\s*\>')
		let delta = idx - current
		if delta < 0
			let action = "\<C-O>"
		else
			let action = "\<C-I>"
		endif

		execute 'normal! ' . abs(delta) . action

	endfunction

	function! s:jumps(bang)

		redir => cout
		silent jumps
		redir END

		let s:jumplist = split(cout, '\n')
		return fzf#run(fzf#wrap('jumps', {
		\ 'source'  : extend(s:jumplist[0:0], reverse(s:jumplist[1:])),
		\ 'sink'    : function('s:jump_sink'),
		\ 'options' : '+m -x --ansi --tiebreak=index --layout=reverse-list --header-lines 1 --prompt "Jumps> "',
		\ }, a:bang))

	endfunction

	command! -bar -bang Jumps call <SID>jumps(<bang>0)


endif
