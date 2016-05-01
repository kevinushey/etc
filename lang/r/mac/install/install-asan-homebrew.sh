#!/usr/bin/env bash

## Install clang-3.8.0.
## 
## If you already have a suitable version of clang installed,
## set the LLVM_INSTALL_DIR to point to that directory.
: ${LLVM_DOWNLOAD_URL="http://llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-apple-darwin.tar.xz"}
: ${LLVM_DOWNLOAD_TARGET="$TMPDIR/clang-3.8.0.tar.xz"}
: ${LLVM_INSTALL_DIR_BASE="$HOME/clang"}
: ${LLVM_INSTALL_DIR="${LLVM_INSTALL_DIR_BASE}/3.8.0"}
if [ ! -d "${LLVM_INSTALL_DIR}" ]; then

    echo "Installing clang 3.8.0..."
    mkdir -p "${LLVM_INSTALL_DIR_BASE}"

    wget -c "${LLVM_DOWNLOAD_URL}" -O "${LLVM_DOWNLOAD_TARGET}" || {
	echo "Failed to download clang-3.8.0"
	exit 1
    }

    tar xf "${LLVM_DOWNLOAD_TARGET}" -C "${LLVM_INSTALL_DIR_BASE}" || {
	echo "Failed to unpack archive clang-3.8.0.tar.xz"
	exit 1
    }

    mv \
	"${LLVM_INSTALL_DIR_BASE}/clang+llvm-3.8.0-x86_64-apple-darwin" \
	"${LLVM_INSTALL_DIR}"
fi

## Install clang symlinks
symlink () {
    if [ ! -f "$2" ]; then
	echo "Symlinking '$1' to '$2'"
	if [ -w "`dirname $2`" ]; then
	    ln -fs "$1" "$2"
	else
	    sudo ln -fs "$1" "$2"
	fi
    fi
}

symlink "${LLVM_INSTALL_DIR}/bin/clang"   "/usr/local/bin/clang-3.8"
symlink "${LLVM_INSTALL_DIR}/bin/clang++" "/usr/local/bin/clang++-3.8"

## Compiler + Sanitizer settings
: ${SANFLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer"}

## R configure settings
: ${PREFIX="$HOME/r-san"}
: ${ENABLE_R_FRAMEWORK="no"}
: ${R_NO_BASE_COMPILE="yes"}

## R compilation flags
: ${CC="clang-3.8 -std=gnu99 ${SANFLAGS}"}
: ${CFLAGS="-g -O2 -Wall -pedantic"}
: ${CXX="clang++-3.8 ${SANFLAGS}"}
: ${CXXFLAGS="-g -O2 -Wall -pedantic"}
: ${F77="gfortran"}
: ${FC="gfortran"}

## Make sure that we use the clang++ compiler when building
## the R executable, so that sanitizer machinery gets compiled
## in. Note that we need to use clang++ to enable e.g. the 'vptr'
## sanitizer for C++ code. See:
##
##   https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Using-Undefined-Behaviour-Sanitizer 
##
## for more information.
: ${MAIN_LD="clang++-3.8 -fsanitize=undefined -L\"${LLVM_INSTALL_DIR}/lib/clang/3.8.0/lib/darwin\" -lclang_rt.asan_osx_dynamic"}

## Invoke install homebrew script with these variables
. ./install-homebrew.sh
