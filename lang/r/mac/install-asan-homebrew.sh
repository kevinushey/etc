# Try to use the development version of clang if available
if [ -f "/usr/local/llvm/bin/clang" ]; then
    CLANG=/usr/local/llvm/bin/clang
else
    CLANG=clang
fi

# Preferred settings
: ${PREFIX="$HOME/r-san"}
: ${ENABLE_R_FRAMEWORK="no"}
: ${SANFLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer"}

# Set up compiler variables
CC="${CLANG} -std=gnu99 ${SANFLAGS}"
CFLAGS="-g -Wall -pedantic -mtune=native"
CXX="${CLANG}++ ${SANFLAGS}"
CXXFLAGS="-g -Wall -pedantic -mtune=native"
F77="gfortran"
FC="gfortran"

# Invoke install homebrew script with these variables
. ./install-homebrew.sh
