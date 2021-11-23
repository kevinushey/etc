#!/usr/bin/env bash

export AWS_PROFILE=kevin
export BASH_SILENCE_DEPRECATION_WARNING=1

TERM=xterm-256color
export TERM

if [ -f /usr/local/etc/profile.d/bash_completion.sh ]; then
    . /usr/local/etc/profile.d/bash_completion.sh
fi

for FILE in ~/.login/bash/*.sh; do
    . "${FILE}"
done

read -r -d '' ASAN_OPTIONS_LIST <<- EOF
check_initialization_order=1
detect_odr_violation=1
detect_stack_use_after_return=1
halt_on_error=0
strict_init_order=1
strict_string_checks=1
EOF

ASAN_OPTIONS="$(printf '%s' "${ASAN_OPTIONS_LIST}" | tr '\n' ':')"
export ASAN_OPTIONS

read -r -d '' UBSAN_OPTIONS_LIST <<- EOF
print_stacktrace=1
EOF

UBSAN_OPTIONS="$(printf '%s' "${UBSAN_OPTIONS_LIST}" | tr '\n' ':')"
export UBSAN_OPTIONS

path-prepend                  \
    "${HOME}/bin"             \
    "/usr/local/opt/curl/bin" \
    "/Library/TeX/texbin"     \
    "/opt/homebrew/bin"       \
    "/usr/local/bin"

SHELLCHECK_OPTS="-e SC1090 -e SC2006 -e SC2155 -e SC2164"
export SHELLCHECK_OPTS

RIPGREP_CONFIG_PATH=~/.ripgreprc
export RIPGREP_CONFIG_PATH

[ -d ~/.cabal/bin ] && export PATH="$HOME/.cabal/bin:$PATH"
[ -d ~/projects/depot_tools ] && export PATH="$PATH:$HOME/projects/depot_tools"
[ -f "${BASH_COMPLETION}" ] && source "${BASH_COMPLETION}"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if has-command ninja; then
    export CMAKE_GENERATOR=Ninja
fi

PYTHON_CONFIGURE_OPTS="--enable-shared"
export PYTHON_CONFIGURE_OPTS

if is-darwin; then

    if [ "$(arch)" = "arm64" ]; then
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        HOMEBREW_PREFIX="/usr/local"
    fi

    export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"

    shopt -s nullglob
    for FILE in "${HOMEBREW_PREFIX}"/etc/profile.d/*.sh; do
        source "${FILE}"
    done
    for FILE in "${HOMEBREW_PREFIX}"/etc/bash_completion.d/*.sh; do
        source "${FILE}"
    done
    shopt -u nullglob

fi

export PATH="${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${PATH}"
export PATH="${HOME}/opt/anaconda3/condabin:${PATH}"
export FUZZBUCKET_URL=https://wftmlggzd5.execute-api.us-west-2.amazonaws.com/prod/


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kevin/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kevin/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/kevin/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kevin/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

