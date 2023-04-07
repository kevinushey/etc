#!/usr/bin/env bash

export AWS_PROFILE=kevin
export BASH_SILENCE_DEPRECATION_WARNING=1

TERM=xterm-256color
export TERM

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

read -r -d '' LSAN_OPTIONS_LIST <<- EOF
suppressions=/etc/lsan.d/suppressions
EOF

LSAN_OPTIONS="$(printf '%s' "${LSAN_OPTIONS_LIST}" | tr '\n' ':')"
export LSAN_OPTIONS

if [ "$(uname -m)" = "arm64" ]; then
	BINDIR="/opt/local/bin"
	HOMEBREW_PREFIX="/opt/homebrew"
else
	BINDIR="/usr/local/bin"
	HOMEBREW_PREFIX="/usr/local"
fi

path-prepend                  \
	"${HOME}/bin"             \
	"${HOME}/.local/bin"      \
	"/usr/local/opt/curl/bin" \
	"/Library/TeX/texbin"     \
	"${BINDIR}"               \
	"${HOMEBREW_PREFIX}/bin"

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

	shopt -s nullglob
	for FILE in "${HOMEBREW_PREFIX}"/etc/profile.d/*.sh; do
		source "${FILE}"
	done
	for FILE in "${HOMEBREW_PREFIX}"/etc/bash_completion.d/*.sh; do
		source "${FILE}"
	done
	shopt -u nullglob

fi

# download git completion script appropriate to the version of git installed
# (apparently needs to come after we've sourced other profile scripts?)
GIT_VERSION="$(git --version | cut -d' ' -f3)"
GIT_COMPLETION_BASH="$HOME/.local/share/git/.git-completion-${GIT_VERSION}.bash"
mkdir -p "$(dirname "${GIT_COMPLETION_BASH}")"
if ! [ -f "${GIT_COMPLETION_BASH}" ]; then
	GIT_COMPLETION_URL="https://raw.githubusercontent.com/git/git/v${GIT_VERSION}/contrib/completion/git-completion.bash"
	download "${GIT_COMPLETION_URL}" "${GIT_COMPLETION_BASH}"
fi
import "${GIT_COMPLETION_BASH}"

# yarn stuff
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if is-darwin && [ "$(uname -m)" = "arm64" ]; then
	PATH="${PATH//\/usr\/local\/bin/}"
else
	PATH="${PATH//\/opt\/homebrew\/bin/}"
	PATH="${PATH//\/opt\/local\/bin/}"
fi

# clean up path
path-clean

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export GIT_CACHE_PATH="${HOME}/.git-cache"
mkdir -p "${GIT_CACHE_PATH}"

[ -e "${HOME}/.cargo/env" ] && source "${HOME}/.cargo/env"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PYENV="${PYENV_ROOT}/bin/pyenv"
if [ -e "${PYENV}" ]; then
	export PATH="${PYENV_ROOT}/bin:${PATH}"
	eval "$("${PYENV}" init -)"
fi

# yarn -- ugh this is disgusting
if is-darwin && has-command yarn; then
	if [ "$(uname -m)" = "arm64" ]; then
		yarn config set prefix /opt/homebrew --global &> /dev/null
	else
		yarn config set prefix /usr/local --global &> /dev/null
	fi
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/kevin/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)


# Setting PATH for Python 3.10
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH
