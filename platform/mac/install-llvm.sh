#!/usr/bin/env sh

## These steps are compiled from the Clang 'getting started' guide at
## http://clang.llvm.org/get_started.html

## Configuration variables
: ${LLVM_BUILD_DIR:="$HOME/.llvm"}
: ${LLVM_INSTALL_DIR:="/usr/local/llvm"}
: ${LLVM_MAKE_SYMLINKS:="no"}
: ${LLVM_SYMLINK_DIR:="/usr/local/bin"}

## Make sure we build things using Apple clang
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

mkdir ${LLVM_BUILD_DIR}

## Checkout LLVM:
cd ${LLVM_BUILD_DIR}
svn co https://llvm.org/svn/llvm-project/llvm/trunk llvm

## Checkout clang
cd ${LLVM_BUILD_DIR}/llvm/tools
svn co https://llvm.org/svn/llvm-project/cfe/trunk clang

## Get the optional Clang tools, as well
cd ${LLVM_BUILD_DIR}/llvm/tools/clang/tools
svn co https://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra

## Checkout Compiler-RT
cd ${LLVM_BUILD_DIR}/llvm/projects
svn co https://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt

## Checkout libc++
## Steps copied from http://libcxx.llvm.org/
cd ${LLVM_BUILD_DIR}
svn co https://llvm.org/svn/llvm-project/libcxx/trunk libcxx

## Build libc++
cd ${LLVM_BUILD_DIR}/libcxx/lib
export TRIPLE=-apple-
./buildit
ln -fs libc++.1.dylib libc++.dylib

## Try building Clang
## Make sure we build the SVN clang using Apple clang
cd ${LLVM_BUILD_DIR}
mkdir build
cd build
../llvm/configure \
    --prefix=${LLVM_INSTALL_DIR} \
    --enable-optimized \
    --enable-libcpp \
    --enable-cxx11 \
    --disable-assertions

make -j10
make install

## Figure out the Clang version
CLANG_VERSION=$(grep "^PACKAGE_VERSION" config.log |
    sed 's/PACKAGE_VERSION=//' |
    sed "s/svn//" |
    sed "s/'//g")

## Copy the libc++ files to a directory where Clang will find it
cp -R ${LLVM_BUILD_DIR}/libcxx/include ${LLVM_INSTALL_DIR}/lib/clang/${CLANG_VERSION}
cp -R ${LLVM_BUILD_DIR}/libcxx/lib ${LLVM_INSTALL_DIR}/lib/clang/${CLANG_VERSION}

## Make some symlinks
if [ "${LLVM_MAKE_SYMLINKS}" = "yes" ]; then
	echo "Symlinking clang utilities to '${LLVM_SYMLINK_DIR}'..."
	ln -fs ${LLVM_INSTALL_DIR}/bin/llvm-config ${LLVM_SYMLINK_DIR}/llvm-config
	ln -fs ${LLVM_INSTALL_DIR}/bin/clang ${LLVM_SYMLINK_DIR}/clang
	ln -fs ${LLVM_INSTALL_DIR}/bin/clang++ ${LLVM_SYMLINK_DIR}/clang++
fi

echo "Installation complete!"

