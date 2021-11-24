#!/usr/bin/env bash

# enable bash completion in interactive shells
if ! shopt -oq posix; then
	import \
		/usr/share/bash-completion/bash_completion \
		/etc/bash_completion
fi

