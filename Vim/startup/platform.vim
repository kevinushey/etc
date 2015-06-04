" Source platform-specific configuration files.
let g:system_name = "unknown"

" The most common conflicts occur as a result of Windows vs. non-Windows, so
" provide 'escape hatches' for each case.
if has("win32") || has("win64") || has("win16")
    let g:system_name = "Windows"
    let g:is_windows_system = 1
    Source "~/.vim/startup/platform/windows.vim"
else
    Source "~/.vim/startup/platform/non-windows.vim"
endif

" Figure out who we are for non-Windows platforms.
if executable("uname")
	let g:system_name = substitute(system("uname -s"), '\n', '', '')
endif

if g:system_name == "Darwin"
	let g:is_darwin_system = 1
	Source "~/.vim/startup/platform/darwin.vim"
elseif g:system_name == "Linux"
	let g:is_linux_system = 1
	Source "~/.vim/startup/platform/linux.vim"
elseif g:system_name == "SunOS"
	let g:is_garbage_system = 1
	" TODO: nuke OS and install something reasonable.
	" If running on SPARC, consider setting machine on fire.
endif


