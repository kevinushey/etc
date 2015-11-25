#!/usr/bin/env sh
PWD=`pwd`

## Some initial setup to figure out who we are
UNAME=`uname`
if [ "${UNAME}" = "Linux" ]; then
    echo "System: Linux"
    IS_LINUX=yes
elif [ "${UNAME}" = "Darwin" ]; then
    echo "System: Darwin"
    IS_DARWIN=yes
fi

if [ -n "${IS_LINUX}" ]; then
    if [ -f "/etc/redhat-release" ]; then
	echo "Linux Type: Red Hat"
	IS_REDHAT=yes
    elif [ -n "$(lsb_release --id | grep Ubuntu)" ]; then
	echo "Linux Type: Ubuntu"
	IS_UBUNTU=yes
    fi
fi

if [ -n "${IS_UBUNTU}" ]; then
    ./apply-ubuntu.sh
fi

if [ -n "${IS_REDHAT}" ]; then
    ./apply-redhat.sh
fi

## Symlink all dotfiles
ln -fs ${PWD}/misc/.[^.]* ~/
ln -fs ~/.bash_profile ~/.bashrc

## R
ln -fs ${PWD}/lang/r/.Rprofile ~/.Rprofile

## Emacs
ln -fs ${PWD}/editor/emacs/.spacemacs ~/.spacemacs
mkdir -p ~/.emacs.d
ln -fs ${PWD}/editor/emacs/snippets ~/.emacs.d/snippets

## Vim
mkdir -p ~/.vim
rm -rf ~/.vim/startup
ln -fs ${PWD}/editor/vim/startup ~/.vim/startup
ln -fs ~/.vimrc ~/.nvimrc

## Git
git config --global core.editor "vim"
git config --global user.name "Kevin Ushey"
git config --global push.default simple

## Qt Creator
mkdir -p ~/.config/QtProject/qtcreator/styles
mkdir -p ~/.config/QtProject/qtcreator/schemes
mkdir -p ~/.config/QtProject/qtcreator/snippets

cp ${PWD}/editor/qt/styles/*.xml ~/.config/QtProject/qtcreator/styles/
cp ${PWD}/editor/qt/snippets/snippets.xml ~/.config/QtProject/qtcreator/snippets/snippets.xml
cp ${PWD}/editor/qt/schemes/* ~/.config/QtProject/qtcreator/schemes/

