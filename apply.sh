#!/usr/bin/env bash

# shellcheck disable=SC2086,SC2088
ROOT="$(cd "$(dirname "$0")"; pwd -P)"
pushd "${ROOT}" &> /dev/null

# bootstrapping of bash support scripts
for FILE in login/bash/*.sh; do . "${FILE}" &> /dev/null; done

is-darwin && import apply/apply-darwin.sh
is-redhat && import apply/apply-redhat.sh
is-ubuntu && import apply/apply-ubuntu.sh

## Symlink all dotfiles
pushd "${HOME}"
ln -nfs "${ROOT}"/dotfiles/.??*  .
ln -nfs "${ROOT}"/tmux           .tmux
ln -nfs "${ROOT}"/login          .login
ln -nfs .bash_profile            .bashrc
popd

## tmux
mkdir -p ~/projects
git clone https://github.com/kevinushey/tmux-config ~/projects/tmux-config 2> /dev/null
pushd ~/projects/tmux-config
git pull
./tmux-config --bootstrap
popd

# ## Emacs
# if [ ! -d ~/.emacs.d ]; then
# 	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
# fi
# 
# cd ~/.emacs.d
# git fetch && git reset --hard origin/master
# 
# rm -rf ~/.emacs.d/snippets
# rm -rf ~/.emacs.d/private
# 
# pushd "${HOME}"
# ln -nfs "${ROOT}"/editor/emacs/snippets       .emacs.d/snippets
# ln -nfs "${ROOT}"/editor/emacs/private-layers .emacs.d/private
# ln -nfs "${ROOT}"/editor/emacs/user-config.el .emacs.d/user-config.el
# ln -nfs "${ROOT}"/editor/emacs/user-init.el   .emacs.d/user-init.el
# popd

## Vim
pushd "${HOME}"

mkdir -p .vim
rm -rf .vim/startup .vim/after

pushd .vim
for FILE in "${ROOT}"/editor/vim/*; do
	ln -nfs "${FILE}" "$(basename "${FILE}")"
done
popd

mkdir -p ~/.config
ln -nfs ~/.vim ~/.config/nvim
ln -nfs "${ROOT}"/dotfiles/.vimrc ~/.config/nvim/init.vim

popd

## Helper scripts to be put on the PATH (Darwin only)
if is-darwin; then
	SCRIPTS=`find "$(pwd)" -type f -path "*/bin/*"`
	for SCRIPT in $SCRIPTS; do
		sudo ln -nfs "${SCRIPT}" ~/bin/
	done
fi

## Git
git config --global core.editor       "vim"
git config --global core.excludesfile '~/.gitignore'
git config --global diff.noprefix     true
git config --global push.default      current
git config --global user.name         "Kevin Ushey"


## Qt Creator
mkdir -p ~/.config/QtProject/qtcreator/styles
mkdir -p ~/.config/QtProject/qtcreator/schemes
mkdir -p ~/.config/QtProject/qtcreator/snippets

ln -nfs "${ROOT}"/editor/qt/styles/*.xml          ~/.config/QtProject/qtcreator/styles/
ln -nfs "${ROOT}"/editor/qt/snippets/snippets.xml ~/.config/QtProject/qtcreator/snippets/snippets.xml
ln -nfs "${ROOT}"/editor/qt/schemes/*             ~/.config/QtProject/qtcreator/schemes/

## Tools
mkdir -p ~/bin
sudo ln -nfs "${ROOT}"/bin/* ~/bin/

popd &> /dev/null

