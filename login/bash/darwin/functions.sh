#!/usr/bin/env bash

Emacs () {
	"/Applications/Emacs.app/Contents/MacOS/Emacs" "$@" &
}

r-switch () {

	if test "$#" -ne 1
	then
		echo "Usage: r-switch [version]"
		return
	fi

	VERSION="$1"

	local VERSIONS_PATH
	VERSIONS_PATH=/Library/Frameworks/R.framework/Versions
	if [ ! -e "${VERSIONS_PATH}/${VERSION}" ]; then
		echo "R ${VERSION} is not installed in '${VERSIONS_PATH}'"
		return 1
	fi

	sudo rm -f "${VERSIONS_PATH}/Current"
	sudo ln -nfs "${VERSION}" "${VERSIONS_PATH}/Current"

	local RESOURCES_PATH
	RESOURCES_PATH=/Library/Frameworks/R.framework/Resources
	for BINARY in R Rscript; do
		sudo ln -fs "${RESOURCES_PATH}/bin/${BINARY}" /usr/local/bin/"${BINARY}"
	done

	local R_SESSION_INFO
	R_SESSION_INFO="$(/usr/local/bin/R --vanilla --slave -e "utils::sessionInfo()")"
	echo "${R_SESSION_INFO}" | head -n 3
}

rstudio-dev () {
	local OWD
	OWD="$(pwd)"
	cd ~/rstudio/src/xcode-build || return
	./desktop-mac/Debug/RStudio.app/Contents/MacOS/RStudio "$@" &
	cd "${OWD}" || return
}

codesign-verify () {
	codesign -dv --verbose=4 "$1"
}

