#!/usr/bin/env bash
PWD=`pwd`

if [ $(uname) = "Linux" ]; then
	./apply-ubuntu.sh
fi

## Bash
if [ $(uname) = "Linux" ]; then
    BASHRC="${HOME}/.bashrc"
else
    BASHRC="${HOME}/.bash_profile"
fi

ln -fs ${PWD}/Bash/.bash_profile "${BASHRC}"
source ~/.bash_profile

## R
ln -fs ${PWD}/R/.Rprofile ~/.Rprofile

## go
echo "Installing Go utilities..."
go get -u github.com/nsf/gocode
go get -u code.google.com/p/go.tools/cmd/goimports
go get -u code.google.com/p/rog-go/exp/cmd/godef
go get -u code.google.com/p/go.tools/cmd/godoc
go get -u code.google.com/p/go.tools/cmd/vet

## Emacs
ln -fs ${PWD}/Emacs/.emacs ~/.emacs
ln -fs ${PWD}/Emacs/snippets ~/.emacs.d/snippets

## Vim
if [ ! -e "${HOME}/.spf13-vim-3" ]; then
   echo "Installing SPF-13 vim..."
   curl http://j.mp/spf13-vim3 -L -o - | sh
fi

ln -fs ${PWD}/Vim/.vimrc.before.local ~/.vimrc.before.local
ln -fs ${PWD}/Vim/.vimrc.bundles.local ~/.vimrc.bundles.local
ln -fs ${PWD}/Vim/.vimrc.local ~/.vimrc.local
ln -fs ${PWD}/Vim/.vimrc.sensible ~/.vimrc.sensible

## tmux
ln -fs ${PWD}/tmux/.tmux.conf ~/.tmux.conf

## tig
ln -fs ${PWD}/.tigrc ~/.tigrc

## Git
git config --global core.editor "vim -Nu ~/.vimrc.sensible"
git config --global user.name "Kevin Ushey"
git config --global push.default simple
