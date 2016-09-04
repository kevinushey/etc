" The most common conflicts occur as a result of Windows vs. non-Windows, so
" provide 'escape hatches' for each case.
if IsWindows()
    Source "~/.vim/startup/platform/windows.vim"
else
    Source "~/.vim/startup/platform/non-windows.vim"
endif

if IsMacintosh()
    Source "~/.vim/startup/platform/darwin.vim"
elseif IsUnix()
    Source "~/.vim/startup/platform/linux.vim"
endif
