#!/usr/bin/env bash

import                                     \
	~/google-cloud-sdk/path.bash.inc       \
	~/google-cloud-sdk/completion.bash.inc

defvar \
	NAME               "$(rot13 'Xriva Hfurl')"          \
	EMAIL              "$(rot13 'xrivahfurl@tznvy.pbz')" \
	EDITOR             "vim"                             \
	GNUTERM            "x11"                             \
	color_prompt       "yes"                             \
	force_color_prompt "yes"                             \
	CLICOLORS          "1"                               \
	LSCOLORS           "ExFxBxDxCxegedabagacad"          \
	PYTHONSTARTUP      "${HOME}/.pythonstartup.py"       \
	NODE_PATH          "/usr/local/lib/node"

# Ensure that LANG is set, for the rare instance where
# I'm working on a machine without LANG statement.
if test -z "${LANG}"; then
	LANG="en_US.UTF-8"
	export LANG
fi

# Initialize 'fasd' if installed.
has-command fasd && eval "$(fasd --init auto)"

