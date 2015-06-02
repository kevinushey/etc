#!/usr/bin/env bash
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

if [ -n "$(lsb_release --id | grep Ubuntu)" ]; then
	echo "Linux Type: Ubuntu"
	IS_UBUNTU=yes
fi

if [ -n "${IS_UBUNTU}" ]; then
	./apply-ubuntu.sh
fi

## Set the 'bash' dotfile path
if [ -n "${IS_LINUX}" ]; then
    BASH_DOTFILE_PATH="${HOME}/.bashrc"
else
    BASH_DOTFILE_PATH="${HOME}/.bash_profile"
fi

ln -fs ${PWD}/Bash/.bash_profile "${BASH_DOTFILE_PATH}"

## R
ln -fs ${PWD}/R/.Rprofile ~/.Rprofile

## go
# echo "Installing Go utilities..."
# go get -u github.com/nsf/gocode
# go get -u code.google.com/p/go.tools/cmd/goimports
# go get -u code.google.com/p/rog-go/exp/cmd/godef
# go get -u code.google.com/p/go.tools/cmd/godoc
# go get -u code.google.com/p/go.tools/cmd/vet

## Emacs
ln -fs ${PWD}/Emacs/.emacs ~/.emacs

mkdir -p ~/.emacs.d
ln -fs ${PWD}/Emacs/snippets ~/.emacs.d/snippets

if [ -n "${IS_DARWIN}" ]; then
	cp "${PWD}/Mac/Emacs/Emacs Daemon.app" "/Applications/Emacs Daemon.app"
fi

## Vim
mkdir -p ~/.vim
rm -f ~/.vim/startup
ln -fs $PWD/Vim/startup ~/.vim/startup
ln -fs $PWD/Vim/.vimrc ~/.vimrc
ln -fs $HOME/.vimrc $HOME/.nvimrc

## tig
ln -fs ${PWD}/.tigrc ~/.tigrc

## Git
git config --global core.editor "vi"
git config --global user.name "Kevin Ushey"
git config --global push.default simple

## Qt Creator
mkdir -p ~/.config/QtProject/qtcreator/styles
mkdir -p ~/.config/QtProject/qtcreator/schemes
mkdir -p ~/.config/QtProject/qtcreator/snippets

cp ${PWD}/QtCreator/styles/*.xml ~/.config/QtProject/qtcreator/styles/
cp ${PWD}/QtCreator/snippets/snippets.xml ~/.config/QtProject/qtcreator/snippets/snippets.xml
cp ${PWD}/QtCreator/schemes/* ~/.config/QtProject/qtcreator/schemes/

## Tmux
ln -fs ${PWD}/tmux/.tmux.conf* ~/

