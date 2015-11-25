#!/usr/bin/env bash

if test "$#" -ne 1; then
	echo "ERROR: Expecting a single argument"
	exit -1
fi

PKG_NAME="$1"
PKG_DIR="${1%.pkg}"
PKG_OUTPUT="${PKG_DIR}-patched.pkg"

if test -e "${PKG_DIR}"; then
	rm -rf "${PKG_DIR}"
fi

echo "Package name: ${PKG_NAME}"
echo "Package dir: ${PKG_DIR}"

pkgutil --expand "${PKG_NAME}" "${PKG_DIR}"

cd "${PKG_DIR}"
sed -i '' '8,13d' Distribution
cd ../

echo Writing output to \'${PKG_OUTPUT}\'
pkgutil --flatten "${PKG_DIR}" "${PKG_OUTPUT}"

