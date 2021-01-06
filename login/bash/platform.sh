#!/usr/bin/env bash

platform () {

	# Detect macOS variants
	if [ "$(uname)" = "Darwin" ]; then
		echo "darwin"
		return 0
	fi

	# Detect platform ID using /etc/os-release when available
	if [ -f /etc/os-release ]; then
		local ID
		ID="$(. /etc/os-release; echo "$ID")"
		if [ -n "${ID}" ]; then
			echo "${ID}"
			return 0
		fi
	fi

	# Detect platform using /etc/redhat-release when available
	if [ -f /etc/redhat-release ]; then

		local PLATFORMS=("centos" "fedora")
		for PLATFORM in "${PLATFORMS[@]}"; do
			if grep -siq "${PLATFORM}" /etc/redhat-release; then
				echo "$PLATFORM"
				return 0
			fi
		done

		# Warn about other RedHat flavors we don't yet recognize
		echo "unrecognized redhat variant '$(cat /etc/redhat-release)'"
		return 1
	fi

	echo "unrecognized platform detected"
	return 1
}

ubuntu-codename () {

	local CODENAME
	CODENAME="$(. /etc/os-release; echo "${UBUNTU_CODENAME}")"

	if [ -n "${CODENAME}" ]; then
		echo "${CODENAME}"
		return 0
	fi

	# hard-coded values for older Ubuntu
	case "$(os-version)" in

	12.04) echo "precise" ;;
	12.10) echo "quantal" ;;
	13.04) echo "raring"  ;;
	13.10) echo "saucy"   ;;
	14.04) echo "trusty"  ;;
	14.10) echo "utopic"  ;;
	15.04) echo "vivid"   ;;
	15.10) echo "wily"    ;;
	16.04) echo "xenial"  ;;
	*)     echo "unknown" ;;

	esac

	return 0
}

# Get the operating system version (as a number)
os-version () {

	if [ -f /etc/os-release ]; then
		local VERSION_ID
		VERSION_ID="$(. /etc/os-release; echo "${VERSION_ID}")"
		if [ -n "${VERSION_ID}" ]; then
			echo "${VERSION_ID}"
			return 0
		fi
	fi

	if [ -f /etc/redhat-release ]; then
		grep -oE "[0-9]+([_.-][0-9]+)+" /etc/redhat-release
		return 0
	fi

	if has-command sw_vers; then
		sw_vers -productVersion
		return 0
	fi

	echo "failed to infer OS version for platform '$(platform)'"
	return 1

}

os-version-part () {

	local VERSION
	VERSION="$(os-version | cut -d"." -f"$1")"

	if [ "${VERSION}" = "${VERSION}" ]; then
		[ "$1" = "1" ] && echo "${VERSION}"
		return 0
	fi

	if [ -n "${VERSION}" ]; then
		echo "${VERSION}"
		return 0
	fi

	echo "0"
	return 0
}

os-version-major () {
	os-version-part 1
}

os-version-minor () {
	os-version-part 2
}

os-version-patch () {
	os-version-part 3
}


is-darwin () {
	[ "$(uname)" = "Darwin" ]
}

is-linux () {
	[ "$(uname)" = "Linux" ]
}

is-debian () {
	[ -f /etc/debian_version ]
}

is-redhat () {
	[ -f /etc/redhat-release ]
}

is-ubuntu () {
	[ "$(platform)" = "ubuntu" ]
}

is-centos () {
	[ "$(platform)" = "centos" ]
}

is-fedora () {
	[ "$(platform)" = "fedora" ]
}

is-opensuse () {
	[ "$(platform)" = "opensuse" ]
}

if is-darwin; then
	for SCRIPT in ~/.login/bash/darwin/*.sh; do . "${SCRIPT}"; done
fi

if is-linux; then
	for SCRIPT in ~/.login/bash/linux/*.sh; do . "${SCRIPT}"; done
fi

