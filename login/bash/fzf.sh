#!/usr/bin/env bash

# Preview contents with Ctrl+T with fzf
if has-command fzf; then

    if has-command rg; then
        FZF_DEFAULT_COMMAND='rg --files --hidden --no-follow --no-ignore-parent --glob "!.git/*"'
    elif has-command ag; then
        FZF_DEFAULT_COMMAND='ag -g ""'
    fi

    if [ -n "${FZF_DEFAULT_COMMAND}" ]; then
        export FZF_DEFAULT_COMMAND
    fi


    FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
    export FZF_CTRL_T_COMMAND

    FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
    export FZF_CTRL_T_OPTS


    FZF_ALT_C_COMMAND='find . -type d -mindepth 1 | cut -b3-'
    export FZF_ALT_C_COMMAND

    FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
    export FZF_ALT_C_OPTS


    # Use Alt-; to trigger fzf's autocompletion behavior
    bind '"\e;": "**	"'

fi
