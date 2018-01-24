" TODO: Can we make this faster and less resource-hungry?
finish

Plug 'lyuts/vim-rtags'

function! RTagsEnsureDaemon()

   if system('pgrep rdm')
      return
   endif

   call system('rdm &')

endfunction

function! RTagsGenerateCompileDatabase(force)

   let Root = ProjectRoot()
   let OWD = getcwd()

   " Check to see if we have a CMakeLists.txt to use
   let CMakeLists = join([Root, 'CMakeLists.txt'], '/')
   if !filereadable(CMakeLists)
      return
   endif

   " Bail if compile_commands.json already exists
   let CompileCommandsJSON = join([Root, 'compile_commands.json'], '/')
   if !a:force && filereadable(CompileCommandsJSON)
      return
   endif

   " Move to temporary directory
   let TempDir = tempname()
   call mkdir(TempDir, 'p')
   execute join(['cd', fnameescape(TempDir)], ' ')

   " Invoke CMake to generate compile commands
   call system(join(['cmake', '-DCMAKE_EXPORT_COMPILE_COMMANDS=Yes', shellescape(Root)], ' '))

   " Copy the generated compile_commands.json database
   call system(join(['cp', 'compile_commands.json', shellescape(Root)], ' '))

   " Go home
   execute join(['cd', fnameescape(OWD)], ' ')

endfunction

function! RTagsIndexProject()

   call system(join(['rc', '-J', shellescape(ProjectRoot())], ' '))

endfunction

function! RTagsInit()

   call RTagsEnsureDaemon()
   call RTagsGenerateCompileDatabase(0)
   call RTagsIndexProject()

   if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
   endif

   let l:cpp_patterns='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
   let g:neocomplete#sources#omni#input_patterns.cpp = l:cpp_patterns 
   set completeopt+=longest,menuone 

endfunction

augroup RTags
   autocmd FileType c,cpp call RTagsInit()
augroup END
