" Ensure that a directory exists.
function! EnsureDirectory(path)

    if IsDirectory(a:path)
        return 1
    endif

    let l:mkdir_command = "mkdir -p"
    if has("win16") || has("win32") || has("win64")
        let l:mkdir_command = "mkdir"
    endif

    execute join(["silent!", "!" . l:mkdir_command, DoubleQuotedEscaped(expand(a:path))], " ")
    return IsDirectory(a:path)

endfunction
command! -nargs=+ -complete=file EnsureDirectory call EnsureDirectory(<args>)

function! IsDirectory(path)
    return isdirectory(expand(a:path))
endfunction

function! MarkFileSourced(path)
    let VariableName = LoadedName(a:path)
    execute "let " . VariableName . " = 1"
endfunction

function! LoadedName(path)
    return 'g:loaded_' . substitute(expand(a:path), '[^a-zA-Z0-9_]', '_', 'g')
endfunction

function! IsFileAlreadySourced(path)
    return exists(LoadedName(a:path))
endfunction

" Source a file if it exists. Avoids reloading an already-loaded file.
function! Source(path)

    if IsFileAlreadySourced(a:path)
        return
    endif

    if filereadable(expand(a:path))
        call MarkFileSourced(a:path)
        execute join(["source", expand(a:path)], " ")
    endif

endfunction
command! -nargs=+ -complete=file Source call Source(<args>)

" Lazily source a file.
function! LazySource(path)
    execute "Defer :call Source('" . a:path . "')"
endfunction
command! -nargs=+ -complete=file LazySource call LazySource(<args>)

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
function! Define(command)
    let l:index = stridx(a:command, " ")
    let l:name = strpart(a:command, 0, l:index)
    if !exists(l:name)
        execute join(["let", a:command], " ")
    endif
endfunction
command! -nargs=+ -complete=var Define call Define(<q-args>)

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
command! -nargs=+ ColorScheme call ColorScheme(<f-args>)

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

" Enter normal mode. This is a stupid hack because I couldn't find an
" ex-command to enter normal mode. This may be because I am stupid.
function! EnterNormalMode()
    if mode() != 'n'
        call feedkeys("\<Esc>")
    endif
endfunction

" Put the contents of a variable at the cursor position.
function! Put(variable)
    call feedkeys(":normal! i\<C-R>=" . a:variable . "\<CR>\<Esc>")
endfunction
command! -nargs=+ -complete=var Put call Put(<f-args>)

" Get the (possibly multibyte) character at the cursor
" position.
function! GetCharacterAtCursor()
    let result = matchstr(getline('.'), '\%' . col('.') . 'c.')
    return result
endfunction

function! StrRep(string, times)

    let result = ''

    for i in range(a:times)
        let result .= a:string	
    endfor

    return result

endfunction

function! InsertNewline()
    execute ":normal! i\<CR>"
endfunction

function! GetIndent(string)
    return matchstr(a:string, '^\s*')
endfunction

function! GetCurrentLineIndent()
    return matchstr(getline('.'), '^\s*')
endfunction

command! -nargs=* Echo redraw | echomsg <args>

" Hide this function definition just so that if we try to
" reload this file we don't bump into errors due to an
" attempt to redefine while calling it.
if !exists("g:ReloadDefined")
    let g:ReloadDefined = 1
    function! Reload()
        source %
    endfunction
endif

function! Lazy(call)
    return "\<C-R>=" . a:call . "\<CR>"
endfunction

function! IsWindows()
    return has("win32") || has("win64") || has("win16")
endfunction

function! IsMacintosh()
    return has("mac") || has("macunix")
endfunction

function! IsUnix()
    return has("unix")
endfunction

function! NVMap(expr)
    execute "nmap " . a:expr
    execute "vmap " . a:expr
endfunction
command! -nargs=* NVMap call NVMap(<q-args>)

function! NVNoRemap(expr)
    execute "nnoremap " . a:expr
    execute "vnoremap " . a:expr
endfunction
command! -nargs=* NVNoRemap call NVNoRemap(<q-args>)

function! Download(URL, destination)
    let URL = DoubleQuotedEscaped(URL)
    let destination = DoubleQuotedEscaped(destination)
    execute join(["!wget -c", a:URL, "-O", a:destination], ' ')
endfunction

function! SmartCR()

    if pumvisible()
        return "\<C-y>"
    endif

    let Statement = "\<CR>"
    if exists('g:loaded_endwise')
        let Statement .= Lazy("EndwiseDiscretionary()")
    endif

    if exists('g:AutoPairsLoaded')
        let Statement .= Lazy("AutoPairsReturn()")
    endif

    return Statement

endfunction

" Don't indent namespace and template
function! CppNoNamespaceAndTemplateIndent()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num - 1)
        let l:pline = getline(l:pline_num)
    endwhile
    let l:retv = cindent('.')
    let l:pindent = indent(l:pline_num)
    if l:pline =~# '^\s*template\s*\s*$'
        let l:retv = l:pindent
    elseif l:pline =~# '\s*typename\s*.*,\s*$'
        let l:retv = l:pindent
    elseif l:cline =~# '^\s*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '\s*typename\s*.*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '^\s*namespace.*'
        let l:retv = 0
    endif
    return l:retv
endfunction

" Make tab expand snippets in HTML.
function! HtmlTab()
    if exists('g:loaded_emmet_vim') && emmet#isExpandable()
        return "\<Plug>(emmet-expand-abbr)"
    endif
    return "\<Tab>"
endfunction

" Restore cursor position
function! RestoreCursorPosition()
    if line("'\"") <= line("$")
        silent! normal! g`"
        return 1
    endif
endfunction

