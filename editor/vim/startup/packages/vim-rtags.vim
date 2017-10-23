finish

Plug 'lyuts/vim-rtags'

function! RTagsEnsureDaemon()

   let pid = system("pgrep rdm")
   if pid
      return
   endif

   system("rdm &")

endfunction

function! RTagsIndex()
   
   system("rc -J .")

endfunction

function! RTagsInit()

    setlocal omnifunc=RtagsCompleteFunc

   if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let l:cpp_patterns='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.cpp = l:cpp_patterns 
    set completeopt+=longest,menuone 

endfunction

autocmd FileType c,cpp call RTagsInit()
