let Paths = globpath(expand('~/.vim/startup'), '*.vim')
for Path in split(Paths, '\n')
	execute join(['source', fnameescape(Path)], ' ')
endfor

