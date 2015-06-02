EnsureDirectory "~/.vim/bundle"

" Use Vundle to manage packages
if !IsDirectory("~/.vim/bundle/Vundle.vim")
	!git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
endif

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin "gmark/Vundle.vim"
Plugin "kien/ctrlp.vim"
Plugin "terryma/vim-expand-region"
Plugin "tpope/vim-sleuth"
Plugin "tpope/vim-surround"
Plugin "tpope/vim-unimpaired"

call vundle#end()
filetype plugin on

