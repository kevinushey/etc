#!/usr/bin/env bash

# `git checkout <branch>` / `git switch <branch>`: when <branch> is already
# checked out in another worktree, cd there instead of failing. Interactive
# only, so scripts that source these files keep plain git.
case "$-" in *i*)

git () {

	if [ "$#" -eq 2 ] && { [ "$1" = checkout ] || [ "$1" = switch ]; }; then

		# -z: without it, paths with unusual characters come back C-quoted
		local FIELD CANDIDATE WORKTREE PREFIX
		while IFS= read -r -d '' FIELD; do
			case "${FIELD}" in
			"worktree "*)
				CANDIDATE="${FIELD#worktree }"
				;;
			"branch refs/heads/$2")
				WORKTREE="${CANDIDATE}"
				break
				;;
			esac
		done < <(command git worktree list --porcelain -z 2> /dev/null)

		if [ -n "${WORKTREE}" ] && [ "${WORKTREE}" != "$(command git rev-parse --show-toplevel)" ]; then
			PREFIX="$(command git rev-parse --show-prefix)"
			cd "${WORKTREE}/${PREFIX}" 2> /dev/null || cd "${WORKTREE}" || return
			echo "-> ${PWD}" >&2
			return
		fi

	fi

	command git "$@"

}

;;
esac
