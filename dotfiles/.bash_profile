#!/usr/bin/env bash

TERM=xterm-256color
export TERM

for FILE in ~/.login/bash/*.sh
do
    . "${FILE}"
done

path-set                    \
    /Library/TeX/texbin     \
    /usr/local/bin          \
    /usr/bin                \
    /bin                    \
    /usr/sbin               \
    /sbin                   \

SHELLCHECK_OPTS="-e SC1090 -e SC2006 -e SC2155 -e SC2164"
export SHELLCHECK_OPTS

RIPGREP_CONFIG_PATH=~/.ripgreprc
export RIPGREP_CONFIG_PATH

BASH_COMPLETION=/usr/local/share/bash-completion/bash_completion

[ -d ~/.cabal/bin ] && export PATH="$HOME/.cabal/bin:$PATH"
[ -d ~/projects/depot_tools ] && export PATH="$PATH:$HOME/projects/depot_tools"
[ -f "${BASH_COMPLETION}" ] && source "${BASH_COMPLETION}"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

