Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

let g:LanguageClient_serverCommands = {
\ 'c'   : ['cquery'],
\ 'cpp' : ['cquery'],
\ }

let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_settingsPath      = expand('$HOME/.vim/cquery.json')
let g:LanguageClient_loadSettings      = 1

augroup LanguageClient
    autocmd!
augroup END
