Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_working_path_mode = 'ra'

nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>

let g:ctrlp_custom_ignore =
\ {
\   'dir':  '\.git$\|\.hg$\|\.svn$',
\   'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$'
\ }

" On Windows use "dir" as fallback command.
if IsWindows()
    let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
elseif executable('ag')
    let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
elseif executable('ack-grep')
    let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
    let s:ctrlp_fallback = 'ack %s --nocolor -f'
else
    let s:ctrlp_fallback = 'find %s -type f'
endif

if exists("g:ctrlp_user_command")
    unlet g:ctrlp_user_command
endif

let g:ctrlp_user_command =
\ {
\   'types': {
\     1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
\     2: ['.hg', 'hg --cwd %s locate -I .'],
\   },
\   'fallback': s:ctrlp_fallback
\ }

