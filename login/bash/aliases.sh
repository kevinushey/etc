#!/usr/bin/env bash

alias rgrep="grep -r"
alias rstudio-mega="ssh kevinushey@rstudio-mega.local"
alias r="R_GC_MEM_GROW=3 R --min-vsize=2048M --min-nsize=20M --no-restore"
alias tc="vim ~/.tmux.conf"
alias untar="tar -xvf"
alias v="vim"
alias vi="vim -u ~/.vim/startup/sensible.vim"

if command -v lsd &> /dev/null; then
	alias ls=lsd
fi

if command -v nvim &> /dev/null; then
	alias v="nvim"
	alias vi="nvim -u NONE"
	alias vim="nvim"
fi

complete -F _todo t

