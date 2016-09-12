for Path in split(globpath("~/.vim/startup/language", "*.vim"), '\n')
    execute join(['source', Path], ' ')
endfor

