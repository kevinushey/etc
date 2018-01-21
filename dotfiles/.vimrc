" Global overrides
if filereadable(expand('~/.vimrc.before'))
	source ~/.vimrc.before
endif

source ~/.vim/startup.vim

" Global overrides
if filereadable(expand('~/.vimrc.after'))
	source ~/.vimrc.after
endif

