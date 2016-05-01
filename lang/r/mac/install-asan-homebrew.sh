# Try to use the development version of clang if available
if [ -f "/usr/local/llvm/bin/clang" ]; then
    CLANG=/usr/local/llvm/bin/clang
else
    CLANG=clang
fi

# Preferred settings
: ${PREFIX="$HOME/r-san"}
: ${ENABLE_R_FRAMEWORK="no"}
: ${CC_SANFLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer"}
: ${CXX_SANFLAGS="-fsanitize=address,undefined -fno-omit-frame-pointer"}

# Set up compiler variables
CC="${CLANG} -std=gnu99 ${CC_SANFLAGS}"
CFLAGS="-g -Wall -pedantic -mtune=native"
CXX="${CLANG}++ ${CXX_SANFLAGS}"
CXXFLAGS="-g -Wall -pedantic -mtune=native"
F77="gfortran"
FC="gfortran"
MAIN_LD="${CLANG}++ -fsanitize=undefined"

# Invoke install homebrew script with these variables
. ./install-homebrew.sh
