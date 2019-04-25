Plug 'autozimu/LanguageClient-neovim', LoadIf(has('nvim'), { 'branch': 'next', 'do': 'bash install.sh' })

set hidden

let g:LanguageClient_serverCommands = {
\ 'c'   : ['clangd', '-background-index'],
\ 'cpp' : ['clangd', '-background-index'],
\ 'r'   : ['R', '--slave', '-e', 'languageserver::run()'],
\ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_fzfOptions = '+m -x --ansi --tiebreak=index --layout=reverse-list'

