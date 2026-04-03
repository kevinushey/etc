#!/usr/bin/env bash

svn() {
	if [[ "$1" == "diff" ]] && [[ -t 1 ]]; then
		command svn "$@" | delta
	else
		command svn "$@"
	fi
}

if [ "$(uname)" = "Darwin" ]; then
	if [ "$(uname -m)" = "arm64" ]; then
		PATH="/opt/homebrew/bin:${PATH}"
	else
		PATH="/usr/local/bin:${PATH}"
	fi
fi

