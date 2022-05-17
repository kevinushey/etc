#!/usr/bin/env bash

if [ "$(uname)" = "Darwin" ]; then
	if [ "$(uname -m)" = "arm64" ]; then
		PATH="/opt/homebrew/bin:${PATH}"
	else
		PATH="/usr/local/bin:${PATH}"
	fi
fi

