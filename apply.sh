#!/usr/bin/env bash

# shellcheck disable=SC2086
ROOT="$(cd "$(dirname $0)"; pwd -P)"
pushd "${ROOT}" &> /dev/null

# bootstrapping of bash support scripts
for FILE in login/bash/bash*; do . "${FILE}"; done

is-redhat && import apply/apply-redhat.sh
is-ubuntu && import apply/apply-ubuntu.sh

## Symlink all dotfiles
ln -fs "${ROOT}"/dotfiles/.??* ~/
ln -fs "${ROOT}"/tmux ~/.tmux
ln -fs "${ROOT}"/login ~/.login
ln -fs ~/.bash_profile ~/.bashrc

## Emacs
if [ ! -d ~/.emacs.d ]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

cd ~/.emacs.d
git fetch && git reset --hard origin/master

rm -rf ~/.emacs.d/snippets
rm -rf ~/.emacs.d/private
ln -fs "${ROOT}"/editor/emacs/snippets ~/.emacs.d/snippets
ln -fs "${ROOT}"/editor/emacs/private-layers ~/.emacs.d/private
ln -fs "${ROOT}"/editor/emacs/user-config.el ~/.emacs.d/user-config.el
ln -fs "${ROOT}"/editor/emacs/user-init.el ~/.emacs.d/user-init.el

## Vim
mkdir -p ~/.vim
rm -rf ~/.vim/startup ~/.vim/after
ln -fs ~/.vimrc ~/.nvimrc
for FILE in "${ROOT}"/editor/vim/*; do
    ln -fs "${FILE}" ~/.vim/
done

## Helper scripts to be put on the PATH (Darwin only)
if is-darwin; then
    SCRIPTS=`find "$(pwd)" -type f -path "*/bin/*"`
    for SCRIPT in $SCRIPTS; do
    	sudo ln -fs "${SCRIPT}" /usr/local/bin/
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

ln -fs "${ROOT}"/editor/qt/styles/*.xml ~/.config/QtProject/qtcreator/styles/
ln -fs "${ROOT}"/editor/qt/snippets/snippets.xml ~/.config/QtProject/qtcreator/snippets/snippets.xml
ln -fs "${ROOT}"/editor/qt/schemes/* ~/.config/QtProject/qtcreator/schemes/

popd &> /dev/null

