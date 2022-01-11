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
detect_leaks=1
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


path-prepend                  \
	"${HOME}/bin"             \
	"/usr/local/opt/curl/bin" \
	"/Library/TeX/texbin"     \
	"/opt/local/bin"          \
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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


