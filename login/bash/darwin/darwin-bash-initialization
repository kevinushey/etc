#!/usr/bin/env bash

# download git completion script appropriate to the version of git installed
GIT_VERSION="$(git --version | cut -d' ' -f3)"
GIT_COMPLETION_BASH="$HOME/.git-completion-${GIT_VERSION}.bash"
if [ ! -f "${GIT_COMPLETION}" ]; then
	GIT_COMPLETION_URL="https://raw.githubusercontent.com/git/git/v${GIT_VERSION}/contrib/completion/git-completion.bash"
	download "${GIT_COMPLETION_URL}" "${GIT_COMPLETION_BASH}"
fi
import "${GIT_COMPLETION_BASH}"

