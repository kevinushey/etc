for Path in split(globpath("~/.vim/startup", "*.vim"), '\n')
    execute join(['source', Path], ' ')
endfor

