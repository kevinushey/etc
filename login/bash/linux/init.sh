#!/usr/bin/env bash

# choose different versions of R
r-switch () {

	if [ "$#" = "0" ]; then
		echo "Usage: r-switch [--list] version"
		echo "version should be the name of a version of R in /opt/R"
		return 0
	fi

	if [ "$1" = "--list" ]; then
		ls /opt/R
		return 0
	fi

	VERSION="$1"
	local R="/opt/R/${VERSION}/bin/R"
	if ! [ -e "${R}" ]; then
		echo "ERROR: ${R} does not exist"
		return 1
	fi

	sudo ln -nfs "${R}" /usr/local/bin/R
	INFO=$(/usr/local/bin/R --vanilla -s -e "utils::sessionInfo()")
	echo "${INFO}" | head -n 3

}

# enable bash completion in interactive shells
if ! shopt -oq posix; then
	import \
		/usr/share/bash-completion/bash_completion \
		/etc/bash_completion
fi
