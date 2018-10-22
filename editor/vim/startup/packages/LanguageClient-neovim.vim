Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

let cquery = [
\ 'cquery',
\ '--log-file=/tmp/cquery/cquery.log',
\ '--init={"cacheDirectory":"/tmp/cquery/cache/"}',
\ ]

let g:LanguageClient_serverCommands = {
\ 'c'   : cquery,
\ 'cpp' : cquery,
\ }

let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_settingsPath      = expand('$HOME/.vim/cquery.json')
let g:LanguageClient_loadSettings      = 1
