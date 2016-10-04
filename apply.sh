#!/usr/bin/env sh
set -e

DIR=`pwd`

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
    elif [ -n "`lsb_release --id | grep 'Ubuntu'`" ]; then
	echo "Linux Type: Ubuntu"
	IS_UBUNTU=yes
    fi
fi

if [ -n "${IS_UBUNTU}" ]; then
    ./apply/apply-ubuntu.sh
fi

if [ -n "${IS_REDHAT}" ]; then
    ./apply/apply-redhat.sh
fi

## Symlink all dotfiles
ln -fs ${DIR}/dotfiles/.??* ~/
ln -fs ~/.bash_profile ~/.bashrc

## Emacs
if [ ! -d ~/.emacs.d ]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

cd ~/.emacs.d
git fetch && git reset --hard origin/master
cd ${DIR}

rm -rf ~/.emacs.d/snippets
ln -fs ${DIR}/editor/emacs/snippets ~/.emacs.d/snippets
rm -rf ~/.emacs.d/private
ln -fs ${DIR}/editor/emacs/private-layers ~/.emacs.d/private

ln -fs ${DIR}/editor/emacs/user-config.el ~/.emacs.d/user-config.el
ln -fs ${DIR}/editor/emacs/user-init.el ~/.emacs.d/user-init.el

## Vim
mkdir -p ~/.vim
rm -rf ~/.vim/startup
ln -fs ${DIR}/editor/vim/startup ~/.vim/startup
ln -fs ${DIR}/editor/vim/startup.vim ~/.vim/startup.vim
ln -fs ~/.vimrc ~/.nvimrc

## Scripts
SCRIPT_PATHS=`find ${PWD} -type d -path */bin`
if [ -n "${IS_DARWIN}" ]; then
    OSX_SCRIPT_PATHS=`echo ${SCRIPT_PATHS} | grep /mac/`
    for SCRIPT_PATH in ${OSX_SCRIPT_PATHS}; do
	sudo ln -fs ${SCRIPT_PATH}/* /usr/local/bin/
    done
fi

if [ -n "${IS_LINUX}" ]; then
    LINUX_SCRIPT_PATHS=`echo ${SCRIPT_PATHS} | grep /linux/`
    for SCRIPT_PATH in ${LINUX_SCRIPT_PATHS}; do
	sudo ln -fs ${SCRIPT_PATH}/* /usr/local/bin/
    done
fi

## Git
git config --global core.editor "vim"
git config --global user.name "Kevin Ushey"
git config --global push.default simple
git config --global core.excludesfile '~/.gitignore'

## Qt Creator
mkdir -p ~/.config/QtProject/qtcreator/styles
mkdir -p ~/.config/QtProject/qtcreator/schemes
mkdir -p ~/.config/QtProject/qtcreator/snippets

cp ${DIR}/editor/qt/styles/*.xml ~/.config/QtProject/qtcreator/styles/
cp ${DIR}/editor/qt/snippets/snippets.xml ~/.config/QtProject/qtcreator/snippets/snippets.xml
cp ${DIR}/editor/qt/schemes/* ~/.config/QtProject/qtcreator/schemes/

