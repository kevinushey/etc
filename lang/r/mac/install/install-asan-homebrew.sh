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
if [ ! -f "/usr/local/bin/clang-3.8" ]; then
    ln -fs "${LLVM_INSTALL_DIR}/bin/clang" "/usr/local/bin/clang-3.8"
fi

if [ ! -f "/usr/local/bin/clang++-3.8" ]; then
    ln -fs "${LLVM_INSTALL_DIR}/bin/clang++" "/usr/local/bin/clang++-3.8"
fi

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
: ${MAIN_LD="${CLANG}++ -fsanitize=undefined -L\"${LLVM_INSTALL_DIR}/lib/clang/3.8.0/lib/darwin\" -lclang_rt.asan_osx_dynamic"}

## Invoke install homebrew script with these variables
. ./install-homebrew.sh
