#!/usr/bin/env sh

check () {
if test $? -ne 0; then
	echo "$@"
	exit $?
fi
}

## Install the various dependencies
sudo apt-get install -y -q \
	libncurses5-dev \
	libgnome2-dev \
	libgnomeui-dev \
	libgtk2.0-dev \
	libatk1.0-dev \
	libbonoboui2-dev \
	libcairo2-dev \
	libx11-dev \
	libxpm-dev \
	libxt-dev \
	python-dev \
	ruby-dev \
	mercurial

## Remove the old version(s) of Vim
echo "Purging old versions of Vim..."
sudo apt-get remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common

## Download the sources
echo "Downloading Vim sources..."
mkdir -p ~/.vim/sources
cd ~/.vim/sources
hg clone https://code.google.com/p/vim/
cd vim

# Install luajit, and create symlinks so Vim can find it
sudo apt-get install -y -q "libluajit-5.1.2" "luajit"
sudo ln -fvs /usr/include/luajit-2.0/*.h /usr/local/include/

echo "Configuring Vim..."
make distclean
make clean

./configure \
	--with-features=huge \
	--enable-fail-if-missing \
	--enable-multibyte \
	--enable-largefile \
	--enable-luainterp \
	--with-luajit \
	--with-lua-prefix=/usr/local \
	--enable-rubyinterp \
	--enable-pythoninterp \
	--with-python-config-dir=/usr/lib/python2.7/config \
	--enable-gui=gtk2 \
	--enable-cscope \
	--prefix=/usr/local

check "Configure FAILED!"

echo "Making Vim..."
make VIMRUNTIMEDIR=/usr/share/vim/vim74
check "make FAILED!"

echo "Installing Vim..."
sudo make install
check "install FAILED!"

echo "Updating alternatives..."
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

echo "Done!"
