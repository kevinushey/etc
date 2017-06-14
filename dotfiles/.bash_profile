#!/usr/bin/env bash

for FILE in ~/.login/bash/bash-*
do
    . "${FILE}"
done

BASH_COMPLETION=/usr/local/share/bash-completion/bash_completion

if [ -d ~/.cabal/bin ]; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

[ -f "${BASH_COMPLETION}" ] && source "${BASH_COMPLETION}"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

