"" Utility functions (also exported as commands) to use at startup

" Ensure that a directory exists.
" The system 'mkdir' is called and so the directory passed in will be
" double-quoted and escaped.
function! EnsureDirectory(path)
	let l:mkdir_command = "mkdir -p"
	if exists("g:is_windows_system")
		let l:mkdir_command = "mkdir"
	endif
	execute join(["silent", "!" . l:mkdir_command, DoubleQuotedEscaped(expand(a:path))], " ")
endfunction

function! IsDirectory(path)
	return isdirectory(expand(a:path))
endfunction

" Call 'EnsureDirectory' as a command. The use of '<args>' ensures that
" variables will be expanded.
" 
"     EnsureDirectory "~/.vim"
"     EnsureDirectory g:directory_path
command! -nargs=+ -complete=file EnsureDirectory call EnsureDirectory(<args>)

" Source a file (if it exists).
" Does nothing if the file does not exist.
function! Source(path)
	if filereadable(expand(a:path))
		execute "source " expand(a:path)
	endif
endfunction
command! -nargs=+ -complete=file Source call Source(<args>)

" Utility function to allow the definition of a 'Define' command. The command
" is passed in as-is, and is expected in the form:
"
"     <name> = <value>
"
" If no variable of the name <name> exists, then the command is executed. This
" can be used to define variables that have not yet been defined, e.g.
"
"     Define g:foo = 1  " defines `g:foo` as 1
"     let g:bar = 2     " `g:bar` is 2
"     Define g:bar = 3  " no change as `g:bar` is already defined
"
function! DefineCommand(command)
	let l:index = stridx(a:command, " ")
	let l:name = strpart(a:command, 0, l:index)
	if !exists(l:name)
		execute join(["let", a:command], " ")
	endif
endfunction
command! -nargs=+ -complete=var Define call DefineCommand(<q-args>)

" Form a file path. Uses '/' slashes.
function! FilePath(...)
	return join(a:000, "/")
endfunction

" Select a colorscheme. The first discovered colorscheme is used. Useful
" for when I forget to install Tomorrow Night Bright but want a nice fallback.
function! ColorScheme(...)
	for item in a:000
		if !empty(globpath(&rtp, FilePath("colors", item . ".vim")))
			execute join(["colorscheme", item], " ")
			break
		endif
	endfor
endfunction
command! -nargs=+ -complete=color ColorScheme call ColorScheme(<f-args>)

" Execute a command in a directory.
function! InDir(directory, command)
	let l:directory = $PWD
	execute "cd " . a:directory
	execute command
	execute "cd " . l:directory
endfunction

function! BackQuoted(string)
	return "`" . a:string . "`"
endfunction

function! SingleQuoted(string)
	return "'" . a:string . "'"
endfunction

function! DoubleQuoted(string)
	return "\"" . a:string . "\""
endfunction

function! DoubleQuotedEscaped(string)
	return "\"" . substitute(a:string, "\"", "\\\\\"", "g") . "\""
endfunction

