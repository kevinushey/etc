if IsWindows()
    finish
endif

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

let g:LanguageClient_serverCommands = {
\ 'c'   : ['cquery', '--language-server', '--log-file=/tmp/cquery/cquery.log'],
\ 'cpp' : ['cQuery', '--language-server', '--log-file=/tmp/cquery/cquery.log'],
\ }

let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_settingsPath      = expand('$HOME/.vim/cquery.json')
let g:LanguageClient_loadSettings      = 1
