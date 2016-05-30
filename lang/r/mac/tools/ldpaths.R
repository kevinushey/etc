#!/usr/bin/env Rscript

paths <- list(
  "R" = file.path(R.home("bin"), "exec/R"),
  "libR.dylib" = file.path(R.home("lib"), "libR.dylib"),
  "libRblas.dylib" = file.path(R.home("lib"), "libRblas.dylib")
)

enumerate <- function(x, f, ...) {
  nm <- names(x)
  lapply(seq_along(x), function(i) {
    f(nm[[i]], x[[i]], ...)
  })
}

for (exec in paths) {
  enumerate(paths, function(from, to) {
    fmt <- "install_name_tool -change '%s' '%s' '%s'"
    cmd <- sprintf(fmt, from, to, exec)
    system(cmd)
  })
  system(paste("otool -L", exec))
  cat("\n")
}

shared_objects <- list.files(.libPaths(), pattern = "so$", full.names = TRUE, recursive = TRUE)
for (so in shared_objects) {
  fmt <- "install_name_tool -change '%s' '%s' '%s'"
  cmd <- sprintf(fmt, "libR.dylib", paths[["libR.dylib"]], so)
  system(cmd)
}
