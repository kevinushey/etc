setlocal

REM Store some useful variables.
set "PWD=%cd%"
set "HOME=%USERPROFILE%"

REM Make a symlink for .emacs
set "EMACS_DOTFILE_FROM=%PWD%\editor\emacs\.spacemacs"
set "EMACS_DOTFILE_TO=%HOME%\AppData\Roaming\.spacemacs"

if exist "%EMACS_DOTFILE_TO%" del "%EMACS_DOTFILE_TO%"

REM Would prefer symlink here but that requires admin privileges,
REM something not supplied on non-professional Windows installs.
mklink /H "%EMACS_DOTFILE_TO%" "%EMACS_DOTFILE_FROM%"

REM Set up Git.
set "OLDPATH=%PATH%"
set "PATH=C:\Program Files (x86)\Git\bin;%PATH%"
git config --global user.name "Kevin Ushey"
git config --global user.email "kevinushey@gmail.com"
git config --global push.default simple
git config --global credential.helper wincred

REM Set up _vimrc.
if not exist "%HOME%\.vim" mkdir "%HOME%\.vim"
set "VIMRC_DOTFILE_FROM=%PWD%\dotfiles\.vimrc"
set "VIMRC_DOTFILE_TO=%HOME%\_vimrc"

rm "%VIMRC_DOTFILE_TO%"
mklink /H "%VIMRC_DOTFILE_TO%" "%VIMRC_DOTFILE_FROM%"
mklink /H "%HOME%\.vimrc" "%VIMRC_DOTFILE_TO%"

REM Link in other supporting Vim files.
set "VIM_STARTUP_DIR=%PWD%\editor\vim\startup"
mklink /J "%HOME%\.vim\startup" "%VIM_STARTUP_DIR%"

REM Copy over Qt Creator related items.
set "QT_CREATOR_DIR=%HOME%\AppData\Roaming\QtProject\qtcreator"

mkdir "%QT_CREATOR_DIR%\styles"
mkdir "%QT_CREATOR_DIR%\schemes"
mkdir "%QT_CREATOR_DIR%\snippets"

copy "%PWD%\editor\qt\schemes\keyboard.kms" "%QT_CREATOR_DIR%\schemes\keyboard.kms"
copy "%PWD%\editor\qt\snippets\snippets.xml" "%QT_CREATOR_DIR%\snippets\snippets.xml"
copy "%PWD%\editor\qt\styles\Tomorrow-Night-Bright.xml" "%QT_CREATOR_DIR%\styles\Tomorrow-Night-Bright.xml"

REM AutoHotkey.
copy "%PWD%\platform\windows\AutoHotkey.ahk" "%USERPROFILE%\Documents\AutoHotkey.ahk"

PAUSE

