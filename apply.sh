#!/usr/bin/env bash

# shellcheck disable=SC2086
ROOT="$(cd "$(dirname "$0")"; pwd -P)"
pushd "${ROOT}" &> /dev/null

RELROOT="${ROOT/$HOME\//}"

# bootstrapping of bash support scripts
for FILE in login/bash/bash*; do . "${FILE}"; done

is-redhat && import apply/apply-redhat.sh
is-ubuntu && import apply/apply-ubuntu.sh

## Symlink all dotfiles
pushd "${HOME}"
ln -nfs "${RELROOT}"/dotfiles/.??*  .
ln -nfs "${RELROOT}"/tmux           .tmux
ln -nfs "${RELROOT}"/login          .login
ln -nfs .bash_profile               .bashrc
popd

## tmux
mkdir -p ~/projects
git clone https://github.com/kevinushey/tmux-config ~/projects/tmux-config 2> /dev/null
pushd ~/projects/tmux-config
git pull
./tmux-config --bootstrap
popd

## Emacs
if [ ! -d ~/.emacs.d ]; then
	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

cd ~/.emacs.d
git fetch && git reset --hard origin/master

rm -rf ~/.emacs.d/snippets
rm -rf ~/.emacs.d/private

pushd "${HOME}"
ln -nfs "../${RELROOT}"/editor/emacs/snippets       .emacs.d/snippets
ln -nfs "../${RELROOT}"/editor/emacs/private-layers .emacs.d/private
ln -nfs "../${RELROOT}"/editor/emacs/user-config.el .emacs.d/user-config.el
ln -nfs "../${RELROOT}"/editor/emacs/user-init.el   .emacs.d/user-init.el
popd

## Vim
pushd "${HOME}"
mkdir -p .vim
rm -rf .vim/startup .vim/after
ln -nfs .vimrc .nvimrc

pushd .vim
for FILE in ../"${RELROOT}"/editor/vim/*; do
	ln -nfs "${FILE}" "$(basename "${FILE}")"
done
popd

popd

## Helper scripts to be put on the PATH (Darwin only)
if is-darwin; then
	SCRIPTS=`find "$(pwd)" -type f -path "*/bin/*"`
	for SCRIPT in $SCRIPTS; do
		sudo ln -nfs "${SCRIPT}" /usr/local/bin/
	done
fi

## Git
git config --global core.editor "vim"
git config --global user.name "Kevin Ushey"
git config --global push.default current
git config --global core.excludesfile '~/.gitignore'

## Qt Creator
mkdir -p ~/.config/QtProject/qtcreator/styles
mkdir -p ~/.config/QtProject/qtcreator/schemes
mkdir -p ~/.config/QtProject/qtcreator/snippets

ln -nfs "${ROOT}"/editor/qt/styles/*.xml          ~/.config/QtProject/qtcreator/styles/
ln -nfs "${ROOT}"/editor/qt/snippets/snippets.xml ~/.config/QtProject/qtcreator/snippets/snippets.xml
ln -nfs "${ROOT}"/editor/qt/schemes/*             ~/.config/QtProject/qtcreator/schemes/

popd &> /dev/null

