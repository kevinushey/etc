# -*- tab-width: 4, indent-tabs-mode: t -*-

alias t="tmux attach 2> /dev/null || tmux"
alias tc="vim ~/.tmux.conf"
alias v="vim"
alias vi="vim -u ~/.vim/startup/sensible.vim"

alias rgrep="grep -r"
alias untar="tar -xvf"

alias R="R_GC_MEM_GROW=3 R --min-vsize=2048M --min-nsize=20M --no-restore"

if [ -n "${IS_DARWIN}" ]; then
		alias ll='ls -laGFh'
		alias lsregister=/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister
elif [ -n "${IS_LINUX}" ]; then
		alias ls='ls --color'
		alias ll='ls -laGFh --color'
		alias qtcreator="qtcreator -noload Welcome -noload QmlDesigner -noload QmlProfiler"
fi

