#!/usr/bin/env bash

pushd () {
	command pushd "$@" > /dev/null
}

popd () {
	command popd "$@" > /dev/null
}

is-verbose () {
	[ -n "${VERBOSE}" ] && [ "${VERBOSE}" != "0" ]
}

is-file () {
	[ -f "$1" ]
}

is-dir () {
	[ -d "$1" ]
}

is-empty () {
	[ -z "$1" ]
}

is-nonempty () {
	[ -n "$1" ]
}

import () {
	while [ "$#" -ne 0 ]; do
		if [ -e "$1" ]; then
			. "$1"
		fi
		shift
	done
}

has-command () {
	command -v "$1" &> /dev/null
}

section () {
	echo -e "\033[1;94m==>\033[0m \033[1;97m$1\033[0m"
}

success () {
	echo -e "\033[1;92m==>\033[0m \033[1;97m$1\033[0m"
}

error () {
	echo -e "\033[1;91mERROR: $1\033[0m"
	exit 1
}

joined () {

	if [ "$#" -le 2 ]; then
		echo "Usage: joined delimiter [values...]"
		return 1
	fi

	local SAVEIFS="${IFS}"
	IFS="$1"
	shift
	echo "$*"
	IFS="${SAVEIFS}"
}

defvar () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: defvar [variable value]+"
		return 1
	fi

	while [ "$#" -ge 2 ]; do
		# shellcheck disable=SC2163
		eval "$1='$2'" && export "$1"
		shift 2
	done

}

defjoined () {

	if [ "$#" -le 2 ]; then
		echo "Usage: defjoined variable delimiter [values...]"
		return 1
	fi

	local VARIABLE="$1"
	shift
	defvar "${VARIABLE}" "$(joined "$@")"
}

rot13 () {
	echo "$@" | tr "A-Za-z" "N-ZA-Mn-za-m"
}

extract () {
	local FILE="$1"

	if is-verbose; then
		echo "Extracting '$FILE' ..."
	fi

	case "${FILE}" in

	*.7z)
		7z x -- "${FILE}"
	;;

	*.deb)
		dpkg -x "${FILE}"
	;;

	*.rar)
		unrar x "${FILE}"
	;;

	*.rpm)
		rpm2cpio "${FILE}" | cpio -idmv
	;;

	*.tgz)
		tar xf "${FILE}"
	;;

	*.tar.bz2)
		tar xf "${FILE}"
	;;

	*.tar.gz)
		tar xf "${FILE}"
	;;

	*.tar.xz)
		tar xf "${FILE}"
	;;

	*.whl)
		unzip -o "${FILE}"
	;;

	*.zip)
		unzip -o "${FILE}"
	;;

	*)
		echo "Don't know how to extract file '${FILE}'"
		return 1
	;;

	esac
}

mirror () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: mirror [options] url"
		return 1
	fi

	wget -e robots=off --mirror --convert-links --no-parent --reject="index.html*" "$@"
}

download () {

	if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
		echo "Usage: download url [target]"
		return 1
	fi

	SOURCE="$1"
	TARGET="${2:-$(basename "${SOURCE}")}"

	if [ -e "${TARGET}" ]; then
		return 0
	fi

	if has-command curl; then
		curl --location --fail "${SOURCE}" --output "${TARGET}"
	elif has-command wget; then
		wget --continue -O "${TARGET}" "${SOURCE}"
	fi
}

# Navigate up a number of directories.
up () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: up n"
		return 1
	fi

	COUNT=1
	if [ "$#" -eq 1 ]; then
		COUNT=$1
	fi

	while [ "${COUNT}" -ne 0 ]; do
		cd ..
		let COUNT=COUNT-1
	done
}

# Use ffpmeg to quickly convert a .mov to a .gif.
# Primarily used for quickly converting screencasts
# into gifs (which can then be viewed online easily)
mov2gif () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: mov2gif input [output]"
		return 1
	fi

	if [ "$#" -eq 1 ]; then
		OUTPUT="${1%.mov}".gif
	else
		OUTPUT="$2"
	fi

	ffmpeg -i "$1" -r 20 -f image2pipe -vcodec ppm - | \
		convert -delay 5 -fuzz 1% -layers Optimize -loop 0 - "${OUTPUT}"
}

## Emacs

e () {
	if [ "$#" -eq 0 ]; then
		ALTERNATE_EDITOR="" emacsclient -t .
	else
		ALTERNATE_EDITOR="" emacsclient -t "$@"
	fi
}

# Open a file using emacsclient.
#
# I wasted way too much time making this work, but apparently
# emacsclient doesn't allow e.g.
#
#	 emacsclient file.txt -c -e "(print \"Sucker\")"
#
# so I ended up pasting the file visiting into the eval statement.
ec () {

	if [ "$#" -ge 1 ]; then

		read -r -d '' EMACSCLIENT_EVAL <<- EOM
		(progn
		(select-frame-set-input-focus (selected-frame))
		(set-frame-font "Droid Sans Mono-14" nil t)
		(find-file "$1")
		)
		EOM

		shift

	else

		read -r -d '' EMACSCLIENT_EVAL <<- EOM
		(progn
		(select-frame-set-input-focus (selected-frame))
		(set-frame-font "Droid Sans Mono-14" nil t)
		)
		EOM

	fi

	ALTERNATE_EDITOR="" emacsclient \
		--create-frame \
		--eval "${EMACSCLIENT_EVAL}"

}

b64encode () {
	openssl base64 -in "$1" | tr -d '\n'
}

backup () {
	mv "$1" "$1.backup"
}

restore () {
	case "$1" in
	*.backup) mv "$1" "${1%.backup}" ;;
	*) echo "cannot restore '$1' (missing .backup extension)" ;;
	esac
}

path-set () {

	local NEWPATH
	for ENTRY in "$@"; do
		if [ -d "${ENTRY}" ]; then
			NEWPATH="${NEWPATH}:${ENTRY}"
		fi
	done

	if [ -n "${NEWPATH}" ]; then
		PATH="${NEWPATH#?}"
		export PATH
	fi

}

pip-upgrade () {
	pip install --upgrade -r <(pip freeze | cut -d'=' -f1)
}

pip3-upgrade () {
	pip3 install --upgrade -r <(pip3 freeze | cut -d'=' -f1)
}

devtools () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: devtools [--vanilla] [command] [args...]"
		return 1
	fi

	local FUNCTION
	FUNCTION="$1"
	shift

	local ARGUMENTS
	ARGUMENTS=("$@")

	for i in "${!ARGUMENTS[@]}"; do
		ARGUMENT="${ARGUMENTS[$i]}"
		if ! [ "${ARGUMENT}" -eq "${ARGUMENT}" ] 2> /dev/null; then
			ARGUMENTS[$i]="\"${ARGUMENT}\""
		fi
	done

	local PASTED
	PASTED="${ARGUMENTS[*]}"
	R --vanilla -e "devtools::${FUNCTION}(${PASTED// /, })"

}

build () {

	local TARGET
	TARGET=all
	if [ -n "$1" ]; then
		TARGET="$1"
		shift
	fi

	local CPUS
	CPUS="$(getconf _NPROCESSORS_ONLN)"

	cmake --build . --target "${TARGET}" -- -j"${CPUS}"
}

t () {

	# When invoked without arguments, launch tmux.
	if [ "$#" = "0" ]; then
		tmux attach 2> /dev/null || tmux
		return 0
	fi

	# Otherwise, delegate to todo.sh.
	todo.sh "$@"

}

vim-find () {

	if has-command rg; then
		vim -c copen -q <(rg -F --vimgrep "$*")
	elif has-command ag; then
		vim -c copen -q <(ag -Q "$*")
	elif has-command grep; then
		vim -c copen -q <(grep -F "$*")
	fi

}

enter () {

	if [ "$#" -ne 1 ]; then
		echo "Usage: enter [directory]"
		return
	fi

	mkdir -p "$1" && cd "$1"

}

