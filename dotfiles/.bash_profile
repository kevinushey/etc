#!/usr/bin/env bash

TERM=xterm-256color
export TERM

PATH=/usr/local/opt/llvm/bin:/usr/local/bin:/Library/TeX/texbin:$PATH

for FILE in ~/.login/bash/bash-*
do
    . "${FILE}"
done

SHELLCHECK_OPTS="-e SC1090 -e SC2006 -e SC2155 -e SC2164"
export SHELLCHECK_OPTS

BASH_COMPLETION=/usr/local/share/bash-completion/bash_completion

[ -d ~/.cabal/bin ] && export PATH="$HOME/.cabal/bin:$PATH"
[ -d ~/projects/depot_tools ] && export PATH="$PATH:$HOME/projects/depot_tools"
[ -f "${BASH_COMPLETION}" ] && source "${BASH_COMPLETION}"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
