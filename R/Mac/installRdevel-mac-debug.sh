## install a debugging version of R
cd ~
mkdir .RDebug
cp -Rv . ~/.RDebug
cd ~/.RDebug

make clean

rm config.site
touch config.site
echo CC=\"clang\" >> config.site
echo CFLAGS=\"-g\" >> config.site
echo CXX=\"clang++\" >> config.site
echo CXXFLAGS=\"-g\" >> config.site
echo F77=\"gfortran\" >> config.site
echo FFLAGS=\"-g \" >> config.site
echo FC=\"gfortran\" >> config.site
echo FCFLAGS=\"-g \" >> config.site
echo OBJC=\"clang\" >> config.site
echo OBJCFLAGS=\"-g \" >> config.site

./configure \
    --with-cairo \
    --enable-R-framework \
    --enable-R-shlib \
    --with-readline \
    --enable-R-profiling \
    --enable-memory-profiling \
    --with-valgrind-instrumentation=2 \
    --prefix=/usr/local/RDebug

make -j10
