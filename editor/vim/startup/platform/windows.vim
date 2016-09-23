syntax on

" Override the colorscheme to provide slate (much better than the Windows default)
ColorScheme wombat256mod slate default

" Use non-UTF8 characters on Windows
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:~

" Ensure Git is on the PATH
let $PATH .= ';C:\Program Files (x86)\Git\bin'

" Add utility binaries to PATH (e.g. 'wget')
let $PATH .= ';' . substitute(FilePath($HOME, 'bin'), '/', '\\', 'g')

" Ensure a nice font
set guifont=Consolas:h12

