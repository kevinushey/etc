#!/usr/bin/env sh

## This script installs the latest R devel, using clang, the latest
## version of gfortran, and also OpenBLAS for faster matrix operations.
##
## Note: this script will install Homebrew, a Mac package manager,
## for easy downloading of gfortran, OpenBLAS, LAPACK.

OWD="$(pwd)"
CLANG=clang

## check if homebrew is installed
echo "Checking for Homebrew..."
if command -v brew > /dev/null 2>&1 ; then
    echo "> Homebrew already installed."
else
    echo "> Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
fi

export TMP=~/.tmp
mkdir ${TMP} 2> /dev/null

missing () {
    if ! test -z `brew ls | grep ^$1$`; then
        echo 1
    fi
}

install () {
    if test -z `missing $1`; then
        brew install $1
        brew link $1
    fi
}

## make sure we have the necessary taps
brew tap homebrew/science 2> /dev/null
brew tap homebrew/dupes 2> /dev/null

## use homebrew to install openblas, lapack, gfortran
install openblas
install lapack
install texinfo
install coreutils # greadlink

## Make sure the gfortran libraries get symlinked
if command -v gfortran 2> /dev/null; then
	GFORTRAN=gfortran
elif command -v gfortran-4.9 2> /dev/null; then
	GFORTRAN=gfortran-4.9
fi

GFORTRAN_BINPATH=`which ${GFORTRAN} | xargs greadlink -f | xargs dirname`
GFORTRAN_LIBPATH=${GFORTRAN_BINPATH}/../lib/gcc/4.9/
GFORTRAN_LIBPATH=`greadlink -f ${GFORTRAN_LIBPATH}`

for file in ${GFORTRAN_LIBPATH}/libgfortran*; do
    echo Symlinking file: ${file##*/}
    rm /usr/local/lib/${file##*/} 2> /dev/null
    ln -fs "${file}" /usr/local/lib/${file##*/}
done;

## some other things we need
install jpeg

## We need to link in Cairo
install cairo

## Download R-devel from SVN
cd ~
mkdir R-devel 2> /dev/null
cd R-devel
echo "Checking out latest R..."
svn checkout https://svn.r-project.org/R/trunk/
cd trunk

## After downloading the R sources you should also download
## the recommended packages by entering the R source tree and running
echo "Syncing recommended R packages..."
./tools/rsync-recommended

echo Adding a missing extern in 'Rinterface.h'...
sed -i '' 's/^int R_running_as_main_program/extern int R_running_as_main_program/g' include/Rinterface.h
sed -i '' 's/^int R_running_as_main_program/extern int R_running_as_main_program/g' src/include/Rinterface.h


## For some reason, there is trouble in locating Homebrew Cairo;
## we have to make sure pkg-config looks in the right place
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig

## Use a faster version of R_IsNA -- ie, we just check if the
## value of the double is one of the two 'possible' values for NA
echo Using a faster version of R_IsNA, R_IsNaN...
cd ..
if test ! -f "new_NA_behavior.diff"; then
    wget https://raw.githubusercontent.com/kevinushey/etc/master/R/new_NA_behavior.diff
fi;
cd trunk

## apply the patch -- okay if this fails, but we should figure out
## how to do so more gracefully
patch -p0 -f -s -i ../new_NA_behavior.diff > /dev/null
if test -e "src/main/arithmetic.c.rej"; then
    rm "src/main/arithmetic.c.rej"
fi;
echo Patch applied.

## modify config.site so that it gets the appropriate compilers etc
rm config.site
touch config.site
echo CC=\"${CLANG}\" >> config.site
echo CFLAGS=\"-g -O3 -march=native\" >> config.site
echo CXX=\"${CLANG}++\" >> config.site
echo CXXFLAGS=\"-g -O3 -march=native\" >> config.site
echo F77=\"gfortran\" >> config.site
echo FFLAGS=\"-g -O3\" >> config.site
echo FC=\"gfortran\" >> config.site
echo FCFLAGS=\"-g -O3\" >> config.site
echo OBJC=\"${CLANG}\" >> config.site
echo OBJCFLAGS=\"-g -O3\" >> config.site
echo MAKE=\"make\" >> config.site
echo MAKEFLAGS=\"-j10\" >> config.site

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
    --without-internal-tzcode

make clean
make -j10
sudo make install

echo Installation completed successfully\!
cd ${OWD}

