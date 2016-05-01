# TODO: relax requirement when Apple clang has sanitizers
: ${CLANG="/usr/local/llvm/bin/clang"}
: ${CC_SANFLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer"}
: ${CXX_SANFLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer"}

## R configure settings
: ${PREFIX="$HOME/r-san"}
: ${ENABLE_R_FRAMEWORK="no"}
: ${R_NO_BASE_COMPILE="yes"}

## R compilation flags
: ${MAIN_LD="${CLANG}++ -fsanitize=undefined -L/usr/local/llvm/lib/clang/3.8.0/lib/darwin -lclang_rt.asan_osx_dynamic"}


## Set up compiler variables
CC="${CLANG} -std=gnu99 ${CC_SANFLAGS}"
CFLAGS="-g -Wall -pedantic -mtune=native"
CXX="${CLANG}++ ${CXX_SANFLAGS}"
CXXFLAGS="-g -Wall -pedantic -mtune=native"
F77="gfortran"
FC="gfortran"

## Invoke install homebrew script with these variables
. ./install-homebrew.sh
