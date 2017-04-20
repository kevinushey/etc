#!/usr/bin/env bash

for FILE in ~/.login/bash/bash-*
do
    . "${FILE}"
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

