SETLOCAL

REM Store some useful variables.
SET "PWD=%cd%"
SET "HOME=%USERPROFILE%"

REM Make a symlink for .emacs
SET "EMACS_DOTFILE_FROM=%PWD%\Emacs\.emacs"
SET "EMACS_DOTFILE_TO=%HOME%\AppData\Roaming\.emacs"

DEL "%EMACS_DOTFILE_TO%"

REM Would prefer symlink here but that requires admin privileges.
MKLINK /H %EMACS_DOTFILE_TO% %EMACS_DOTFILE_FROM%

REM Set up Git.
SET "OLDPATH=%PATH%"
SET "PATH=C:\Program Files (x86)\Git\bin;%PATH%"
git config --global user.name "Kevin Ushey"
git config --global user.email "kevinushey@gmail.com"
git config --global push.default simple
git config --global credential.helper 'cache --timeout=3600'
SET "PATH=%OLDPATH%"

PAUSE

