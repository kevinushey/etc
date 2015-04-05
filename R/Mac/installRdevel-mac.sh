#!/usr/bin/env sh

## This script installs the latest R devel, using clang, the latest
## version of gfortran, and also OpenBLAS for faster matrix operations.
##
## Note: this script will install Homebrew, a Mac package manager,
## for easy downloading of gfortran, OpenBLAS, LAPACK.
##
## NOTE: If you get weird linker errors related to `lapack` in grDevices
## on load, it's probably because you updated gcc / gfortran and now
## the lapack / openblas links are broken. You can either fix this
## manually with otool, or be lazy and just reinstall openblas and
## lapack (in that order).
##

## ----- CONFIGURATION VARIABLES ----- ##

# Installation-related
: ${INSTALLDIR:=/Library/Frameworks}        # NOTE: needs 'sudo' on make install
: ${SOURCEDIR:=~/R-devel}                   # checked out R sources will live here
: ${TMP:=${HOME}/tmp}                       # temporary dir used on installation

## Compiler-specific
: ${CC:=clang}
: ${CXX:=clang++}
: ${CFLAGS:=-g -O3 -Wall -pedantic}
: ${CXXFLAGS:=-g -O3 -Wall -pedantic}
: ${FORTRAN:=gfortran}
: ${FFLAGS:=-g -O3} 
: ${OBJC:=clang}
: ${OBJCFLAGS:=${CFLAGS}}
: ${MAKE:=make}
: ${MAKEFLAGS:=-j10}

## ----- END CONFIGURATION VARIABLES ----- ##

OWD=`pwd`

## check if homebrew is installed
echo "Checking for Homebrew..."
if command -v brew > /dev/null 2>&1 ; then
    echo "> Homebrew already installed."
else
    echo "> Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
fi

export TMP=${TMP}
mkdir ${TMP} 2> /dev/null

missing () {
    if ! test -z `brew ls | grep ^$1$`; then
        echo 1
    fi
}

install () {
    if test -z `missing $1`; then
        brew install $1
        brew link --force $1
    fi
}

## make sure we have the necessary taps
brew tap homebrew/science 2> /dev/null
brew tap homebrew/dupes   2> /dev/null

## use homebrew to install openblas, lapack, gfortran

install gcc                        # gfortran
install openblas                   # faster BLAS
install lapack                     # latest lapack
install texinfo                    # vignettes, help
install coreutils                  # greadlink
install jpeg                       # image write support
install cairo                      # image write support

## Make sure the gfortran libraries get symlinked.
if command -v gfortran &> /dev/null; then
	GFORTRAN=gfortran
elif command -v gfortran-4.9 &> /dev/null; then
	GFORTRAN=gfortran-4.9
fi

## Do some path munging and symlink fortran libraries
## to /usr/local/lib
GFORTRAN_BINPATH=`which ${GFORTRAN} | xargs greadlink -f | xargs dirname`
GFORTRAN_LIBPATH=${GFORTRAN_BINPATH}/../lib/gcc/4.9/
GFORTRAN_LIBPATH=`greadlink -f ${GFORTRAN_LIBPATH}`

for FILEPATH in ${GFORTRAN_LIBPATH}/libgfortran*; do
	BASENAME=${FILEPATH##*/}
	LINKEDPATH=/usr/local/lib/${BASENAME}
	if test -e "${LINKEDPATH}"; then
		echo File \'${LINKEDPATH}\' already exists, not symlinking
	else
		echo Symlinking \'${BASENAME}\' to \'${LINKEDPATH}\'
	fi
done;

## Download R-devel from SVN
cd ~
mkdir -p ${SOURCEDIR} &> /dev/null
cd ${SOURCEDIR}
echo "Checking out latest R..."
svn checkout https://svn.r-project.org/R/trunk/
cd trunk

## After downloading the R sources you should also download
## the recommended packages by entering the R source tree and running
echo "Syncing recommended R packages..."
./tools/rsync-recommended

## This was needed for building some applications that included
## 'Rinterface.h' in multiple translation units (we were encountering
## linker errors)
echo Adding a missing extern in 'Rinterface.h'...
sed -i '' 's/^int R_running_as_main_program/extern int R_running_as_main_program/g' src/include/Rinterface.h

## For some reason, there is trouble in locating Homebrew Cairo;
## we have to make sure pkg-config looks in the right place
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig

## modify config.site so that it gets the appropriate compilers etc
cat > config.site <<- EOM
CC="${CC}"
CFLAGS="${CFLAGS}"
CXX="${CXX}"
CXXFLAGS="${CXXFLAGS}"
F77="${FORTRAN}"
FFLAGS="${FFLAGS}"
FC="${FORTRAN}"
FCFLAGS="${FFLAGS}"
OBJC="${OBJC}"
OBJCFLAGS="${OBJCFLAGS}"
MAKE="${MAKE}"
MAKEFLAGS="${MAKEFLAGS}"
EOM

make distclean
make clean

## configure
./configure \
    --with-blas="-L/usr/local/opt/openblas/lib -lopenblas" \
    --with-lapack="-L/usr/local/opt/lapack/lib -llapack" \
    --with-cairo \
    --enable-R-framework \
    --enable-R-shlib \
    --with-readline \
    --enable-R-profiling \
    --enable-memory-profiling \
    --with-valgrind-instrumentation=2 \
    --without-internal-tzcode \
    --prefix=${INSTALLDIR} \
    $@

make -j10

if test "${INSTALLDIR}" = "/Library/Frameworks"; then
	echo Installing to system library: please enter your password
	sudo make install
else
	make install
fi

echo Installation completed successfully\!
cd ${OWD}

