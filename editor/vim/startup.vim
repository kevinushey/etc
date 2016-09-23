" Work around issues on Windows with non-ASCII characters in path
let Directory = getcwd()
execute join(["cd", "~/.vim/startup"], ' ')
for Path in split(globpath(".", "*.vim"), '\n')
    execute join(['source', Path], ' ')
endfor
execute join(["cd", Directory], ' ')

