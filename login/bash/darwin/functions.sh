#!/usr/bin/env bash

r-switch () {

	if [ "$#" -ne 1 ]; then
		echo "Usage: r-switch [version]"
		return
	fi

	VERSION="$1"

	local VERSIONS_PATH
	VERSIONS_PATH=/Library/Frameworks/R.framework/Versions
	if ! [ -e "${VERSIONS_PATH}/${VERSION}" ]; then
		echo "R ${VERSION} is not installed in '${VERSIONS_PATH}'"
		return 1
	fi

	sudo rm -f "${VERSIONS_PATH}/Current"
	sudo ln -nfs "${VERSION}" "${VERSIONS_PATH}/Current"

	local BINDIR
	BINDIR="/opt/local/bin"
	mkdir -p "${BINDIR}"

	local RESOURCES_PATH
	RESOURCES_PATH=/Library/Frameworks/R.framework/Resources
	for BINARY in R Rscript; do
		sudo ln -fs "${RESOURCES_PATH}/bin/${BINARY}" "${BINDIR}/${BINARY}"
	done

	local R_SESSION_INFO
	R_SESSION_INFO="$("${BINDIR}/R" --vanilla --slave -e "utils::sessionInfo()")"
	echo "${R_SESSION_INFO}" | head -n 3
}

r-switch-homebrew () {

	local BINDIR
	BINDIR="/opt/local/bin"
	mkdir -p "${BINDIR}"

	local HOMEBREW_PREFIX
	HOMEBREW_PREFIX="$(brew --prefix)"
	for BINARY in R Rscript; do
		ln -nfs "${HOMEBREW_PREFIX}/bin/${BINARY}" "${BINDIR}/${BINARY}"
	done
	
	local R_SESSION_INFO
	R_SESSION_INFO="$("${BINDIR}/R" --vanilla --slave -e "utils::sessionInfo()")"
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

