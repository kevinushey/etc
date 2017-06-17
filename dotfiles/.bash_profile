#!/usr/bin/env bash

TERM=xterm-256color
export TERM

for FILE in ~/.login/bash/bash-*
do
    . "${FILE}"
done

SHELLCHECK_OPTS="-e SC1090 -e SC2006 -e SC2155"
export SHELLCHECK_OPTS

BASH_COMPLETION=/usr/local/share/bash-completion/bash_completion

[ -d ~/.cabal/bin ] && PATH="$HOME/.cabal/bin:$PATH"
[ -f "${BASH_COMPLETION}" ] && source "${BASH_COMPLETION}"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

