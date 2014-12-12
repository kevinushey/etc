#!/usr/bin/env sh

## These steps are compiled from the Clang 'getting started' guide at
## http://clang.llvm.org/get_started.html

## Make sure we build things using Apple clang
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
INSTALLATION_DIR=/usr/local/llvm
LLVM_HOME=~/.llvm

## We'll put everything in a .llvm folder in the home directory.
mkdir ${LLVM_HOME}

## Checkout LLVM:
cd ${LLVM_HOME}
svn co https://llvm.org/svn/llvm-project/llvm/trunk llvm

## Checkout clang
cd ${LLVM_HOME}/llvm/tools
svn co https://llvm.org/svn/llvm-project/cfe/trunk clang

## Get the optional Clang tools, as well
cd ${LLVM_HOME}/llvm/tools/clang/tools
svn co https://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra

## Checkout Compiler-RT
cd ${LLVM_HOME}/llvm/projects
svn co https://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt

## Checkout libc++
## Steps copied from http://libcxx.llvm.org/
cd ${LLVM_HOME}
svn co https://llvm.org/svn/llvm-project/libcxx/trunk libcxx

## Build libc++
cd ${LLVM_HOME}/libcxx/lib
export TRIPLE=-apple-
./buildit
ln -sf libc++.1.dylib libc++.dylib

## Try building Clang
## Make sure we build the SVN clang using Apple clang
cd ${LLVM_HOME}
mkdir build
cd build
../llvm/configure \
    --prefix=${INSTALLATION_DIR} \
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
cp -R ${LLVM_HOME}/libcxx/include ${INSTALLATION_DIR}/lib/clang/${CLANG_VERSION}
cp -R ${LLVM_HOME}/libcxx/lib ${INSTALLATION_DIR}/lib/clang/${CLANG_VERSION}

## Make some symlinks
ln -fs ${INSTALLATION_DIR}/bin/llvm-config /usr/local/bin/llvm-config

ln -fs ${INSTALLATION_DIR}/bin/clang /usr/local/bin/clang
ln -fs ${INSTALLATION_DIR}/bin/clang++ /usr/local/bin/clang++
