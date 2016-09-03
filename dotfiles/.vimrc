" Global overrides
if filereadable(expand("~/.vimrc.before"))
	source ~/.vimrc.before
endif

execute join(['source', '~/.vim/startup/functions.vim'], ' ')

Source "~/.vim/startup/before.vim"
Source "~/.vim/startup/platform.vim"
Source "~/.vim/startup/sensible.vim"
Source "~/.vim/startup/packages.vim"
Source "~/.vim/startup/spf13.vim"
Source "~/.vim/startup/settings.vim"
Source "~/.vim/startup/bindings.vim"
Source "~/.vim/startup/after.vim"

" Global overrides
if filereadable(expand("~/.vimrc.after"))
	source ~/.vimrc.after
endif

