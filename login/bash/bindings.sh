#!/usr/bin/env bash

if [ -t 1 ]; then
	bind '"\ef": "vim-find "'
	bind '"\ev": " \C-e\C-u\C-y\ey\C-u`__fzf_up__`\e\C-e\er\C-m"'
	bind '"\e ": " \C-e\C-u\C-y\ey\C-u`__fzf_history__`\e\C-e\er\e^"'
fi

__fzf_up__ () {

	declare -a directories
	declare path=$(pwd)

	while [ "${path}" != "/" ]; do
		directories+=("${path}")
		path="$(dirname "${path}")"
	done

	declare selection="$(printf '%s\n' "${directories[@]}" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse ${FZF_DEFAULT_OPTS} ${FZF_ALT_C_OPTS}" $(__fzfcmd) +m)"
	printf 'cd %q' "${selection}"

}
