#!/usr/bin/env bash

## These steps are compiled from the Clang 'getting started' guide at
## http://clang.llvm.org/get_started.html

: ${LLVM_ROOT_DIR="${HOME}"}
: ${LLVM_INSTALL_DIR="/usr/local/llvm"}
: ${LLVM_BRANCH="master"}

command -v "ninja" || {
    echo 'ninja not found on PATH; exiting'
    exit 1
}

enter () {
    echo "* Entering '$1'"
    mkdir -p "$1"
    cd "$1"
}

checkout () {

    if [ ! -e "$1" ]; then
	git clone http://llvm.org/git/$1.git
    fi

    cd "$1"
    git pull --rebase
    cd ..
}

# Checkout LLVM sources
enter "${LLVM_ROOT_DIR}"
checkout llvm

# Checkout clang
enter "${LLVM_ROOT_DIR}/llvm/tools" 
checkout clang
checkout lldb

# Checkout compiler-rt (required for sanitizers)
enter "${LLVM_ROOT_DIR}/llvm/projects"
checkout compiler-rt
checkout openmp
checkout libcxx
checkout libcxxabi

# Enter build directory
enter "${LLVM_ROOT_DIR}/llvm/build"
cmake -G "Ninja" ..                       \
    -DCMAKE_C_COMPILER=/usr/bin/clang     \
    -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
    -DCMAKE_BUILD_TYPE=Release            \
    -DCMAKE_INSTALL_PREFIX="${LLVM_INSTALL_DIR}" || {
	echo 'Failed to configure LLVM!'
	exit 1
    }

cmake --build . || {
    echo 'Failed to build LLVM!'
    exit 1
}

cmake --build . --target install || {
    echo 'Failed to install LLVM!'
    exit 1
}

# discover the clang version
cmakevar () {
    grep "${1}:" "${LLVM_ROOT_DIR}/llvm/build/CMakeCache.txt" | cut -d'=' -f2
}

CLANG_VERSION=`cmakevar "CLANG_EXECUTABLE_VERSION"`

# generate symlinks
symlink () {

    SOURCE=`greadlink -f "${LLVM_INSTALL_DIR}/bin/$1"`

    if [ "$#" = "2" ]; then
	TARGET="/usr/local/bin/$2"
    else
	TARGET="/usr/local/bin/$1-${CLANG_VERSION}"
    fi

    if [ -e "${SOURCE}" ]; then
	echo "Symlinking '${SOURCE}' => '${TARGET}'"
	ln -fs "${SOURCE}" "${TARGET}"
    else
	echo "No file at path '${SOURCE}'"
    fi
}

symlink "clang"
symlink "clang++"
symlink "lldb" "lldb"

