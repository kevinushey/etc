SETLOCAL

REM Store some useful variables.
SET "PWD=%cd%"
SET "HOME=%USERPROFILE%"

REM Make a symlink for .emacs
SET "EMACS_DOTFILE_FROM=%PWD%\Emacs\.emacs"
SET "EMACS_DOTFILE_TO=%HOME%\AppData\Roaming\.emacs"

DEL "%EMACS_DOTFILE_TO%"

REM Would prefer symlink here but that requires admin privileges.
MKLINK /H "%EMACS_DOTFILE_TO%" "%EMACS_DOTFILE_FROM%"

REM Set up Git.
SET "OLDPATH=%PATH%"
SET "PATH=C:\Program Files (x86)\Git\bin;%PATH%"
git config --global user.name "Kevin Ushey"
git config --global user.email "kevinushey@gmail.com"
git config --global push.default simple
git config --global credential.helper wincred

REM Set up _vimrc.
SET "VIMRC_DOTFILE_FROM=%PWD%\Windows\Vim\_vimrc"
SET "VIMRC_DOTFILE_TO=%HOME%\_vimrc"
MKLINK /H "%VIMRC_DOTFILE_TO%" "%VIMRC_DOTFILE_FROM%"

REM Set up useful Vim packages.
SET "OWD=%cd%"
SET "VIM_BUNDLES_DIR=%HOME%\.vim\bundle"

mkdir "%VIM_BUNDLES_DIR%"
cd "%VIM_BUNDLES_DIR%"
if not exist ctrlp.vim (
	git clone https://github.com/kien/ctrlp.vim.git ctrlp.vim
)
cd ctrlp.vim
git pull
cd ..

cd "%OWD%"

REM Copy over Qt Creator related items.
SET "QT_CREATOR_DIR=%HOME%\AppData\Roaming\QtProject\qtcreator"

mkdir "%QT_CREATOR_DIR%\styles"
mkdir "%QT_CREATOR_DIR%\schemes"
mkdir "%QT_CREATOR_DIR%\snippets"

copy "%PWD%\QtCreator\schemes\keyboard.kms" "%QT_CREATOR_DIR%\schemes\keyboard.kms"
copy "%PWD%\QtCreator\snippets\snippets.xml" "%QT_CREATOR_DIR%\snippets\snippets.xml"
copy "%PWD%\QtCreator\styles\Tomorrow-Night-Bright.xml" "%QT_CREATOR_DIR%\styles\Tomorrow-Night-Bright.xml"

REM AutoHotkey.
copy "%PWD%\Windows\AutoHotkey.ahk" "%USERPROFILE%\Documents\AutoHotkey.ahk"

PAUSE

