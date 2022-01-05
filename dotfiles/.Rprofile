invisible(local({

  if (basename(getwd()) == "RcppParallel")
    options(rstudio.indexCpp = FALSE)

  # if this is arm64 macOS, include Homebrew
  info <- as.list(Sys.info())
  if (info$sysname == "Darwin" && info$machine == "arm64") {
    old <- Sys.getenv("PATH")
    new <- paste("/opt/homebrew/bin", old, sep = ":")
    Sys.setenv(PATH = new)
  }

  if (info$sysname == "Darwin") {

    javaHomes <- c(
      "/opt/homebrew/opt/openjdk",
      "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
    )

    for (javaHome in javaHomes) {
      if (file.exists(javaHome)) {
        Sys.setenv(JAVA_HOME = javaHome)
        break
      }
    }

  }

  # set TZ if unset
  if (is.na(Sys.getenv("TZ", unset = NA)))
    Sys.setenv(TZ = "America/Los_Angeles")

  # bail if revo R
  if (exists("Revo.version"))
    return()

  # only run in interactive mode
  if (!interactive())
    return()

  # bail in Docker environments
  if (!is.na(Sys.getenv("DOCKER", unset = NA)))
    return()

  # create .Rprofile env
  .__Rprofile.env__. <- attach(NULL, name = "local:rprofile")

  # helpers for setting things in .__Rprofile.env__.
  set <- function(name, value)
    assign(name, value, envir = .__Rprofile.env__.)

  set(".Start.time", as.numeric(Sys.time()))

  NAME <- intToUtf8(
    c(75L, 101L, 118L, 105L, 110L, 32L, 85L, 115L, 104L, 101L, 121L)
  )

  EMAIL <- intToUtf8(
    c(107L, 101L, 118L, 105L, 110L, 117L, 115L, 104L,
      101L, 121L, 64L, 103L, 109L, 97L, 105L, 108L,
      46L, 99L, 111L, 109L)
  )

  # Ensure that the user library exists and is set, so that we don't install to
  # the system library by default (e.g. on OS X)
  isDevel <-
    identical(R.version[["status"]],   "Under development (unstable)") ||
    identical(R.version[["nickname"]], "Unsuffered Consequences")

  if (!isDevel) {
    userLibs <- strsplit(Sys.getenv("R_LIBS_USER"), .Platform$path.sep)[[1]]
    if (length(userLibs) && is.character(userLibs)) {
      lapply(userLibs, function(lib) {
        if (!file.exists(lib)) {
          if (!dir.create(lib, recursive = TRUE)) {
            warning("failed to create user library '", lib, "'")
          }
        }
      })
    }
    .libPaths(userLibs)
  }

  # Don't use user library path for Homebrew R
  isHomebrew <- grep("Cellar", R.home())
  if (isHomebrew)
    .libPaths(character())

  # Ensure TAR is set (for e.g. Snow Leopard builds of R)
  TAR <- Sys.which("tar")
  if (nzchar(TAR)) Sys.setenv(TAR = TAR)

  # ensure Rtools on PATH for Windows
  isWindows <- info$sysname == "Windows"
  if (isWindows) {
    PATH <- Sys.getenv("PATH", unset = "")
    paths <- strsplit(PATH, .Platform$path.sep, fixed = TRUE)[[1]]
    hasRtools <- any(file.exists(file.path(paths, "Rtools.txt")))
    if (!hasRtools) {

      # construct candidate Rtools paths
      rMajor <- as.numeric(getRversion()[1, 1])
      rMinor <- as.numeric(getRversion()[1, 2])
      candidates <- c(
        sprintf("C:\\RBuildTools\\%s", paste(rMajor, rMinor + 1, sep = ".")),
        "C:\\Rtools"
      )

      discovered <- FALSE
      for (candidate in candidates) {
        if (file.exists(file.path(candidate, "Rtools.txt"))) {

          bitness <- .Machine$sizeof.pointer * 8
          entries <- paste(normalizePath(Filter(file.exists, c(
            file.path(candidate, "bin"),
            if (getRversion() < "3.3.0")
              file.path(candidate, "gcc-4.6.3/bin")
            else
              file.path(candidate, sprintf("mingw_%s/bin", bitness))
          ))), collapse = .Platform$path.sep)

          Sys.setenv(PATH = paste(entries, PATH, sep = .Platform$path.sep))
          discovered <- TRUE
          break
        }
      }
    }
  }

  # prefer source packages for older versions of R
  pkgType <- getOption("pkgType")
  if (getRversion() < "3.3")
    pkgType <- "source"

  options(
    # CRAN
    repos = c(CRAN = "https://cran.rstudio.com"),

    # source packages for older R
    pkgType = pkgType,

    # no tcltk
    menu.graphics = FALSE,

    # don't treate newlines as synonym to 'n' in browser
    browserNLdisabled = TRUE,

    # keep source code as-is for package installs
    keep.source = TRUE,
    keep.source.pkgs = TRUE,

    # no fancy quotes (makes copy + paste a pain)
    useFancyQuotes = FALSE,

    # warn on partial matches
    # warnPartialMatchArgs = TRUE ## too disruptive
    warnPartialMatchAttr = TRUE,
    warnPartialMatchDollar = TRUE,

    # warn right away
    warn = 1,

    # devtools related options
    devtools.desc = list(
      Author = NAME,
      Maintainer = paste(NAME, " <", EMAIL, ">", sep = ""),
      License = "MIT + file LICENSE",
      Version = "0.0.1"
    ),

    # huh?
    timeout = 3600,

    devtools.name = NAME
  )

  # if using 'curl' with RStudio, ensure stderr redirected
  method <- getOption("download.file.method")
  if (is.null(method)) {
     if (getRversion() >= "3.4.0" && capabilities("libcurl")) {
        options(
           download.file.method = "libcurl",
           download.file.extra  = NULL
        )
     } else if (nzchar(Sys.which("curl"))) {
        options(
           download.file.method = "curl",
           download.file.extra = "-L -f -s --stderr -"
        )
     }
  }

  # always run Rcpp tests
  Sys.setenv(RunAllRcppTests = "yes")

  # attempt to set JAVA_HOME if not already set
  if (is.na(Sys.getenv("JAVA_HOME", unset = NA)) &&
      file.exists("/usr/libexec/java_home"))
  {
    JAVA_HOME <- tryCatch(
      system("/usr/libexec/java_home", intern = TRUE),
      error = function(e) ""
    )

    if (nzchar(JAVA_HOME))
      Sys.setenv(JAVA_HOME = JAVA_HOME)
  }

  # auto-completion of package names in `require`, `library`
  utils::rc.settings(ipck = TRUE)

  # generate some useful aliases, for editing common files
  alias <- function(name, action) {
    placeholder <- structure(list(), class = sprintf("__%s__", name))
    assign(name, placeholder, envir = .__Rprofile.env__.)
    assign(sprintf("print.__%s__", name), action, envir = .__Rprofile.env__.)
  }

  # open .Rprofile for editing
  alias(".Rprofile", function(...) file.edit("~/.Rprofile"))
  alias(".Renviron", function(...) file.edit("~/.Renviron"))
  alias(".Home",     function(...) setwd(.rs.getProjectDirectory()))

  # open Makevars for editing
  alias("Makevars", function(...) {
    if (!utils::file_test("-d", "~/.R"))
      dir.create("~/.R")
    file.edit("~/.R/Makevars")
  })

  # simple CLI to git
  git <- new.env(parent = emptyenv())
  commands <- c("clone", "init", "add", "mv", "reset", "rm",
                "bisect", "grep", "log", "show", "status", "stash",
                "branch", "checkout", "commit", "diff", "merge",
                "rebase", "tag", "fetch", "pull", "push", "clean")

  for (command in commands) {

    code <- substitute(
      system(paste(path, "-c color.status=false", command, ...)),
      list(path = quote(shQuote(normalizePath(Sys.which("git")))),
           command = command)
    )

    fn <- eval(call("function", pairlist(... = quote(expr = )), code))

    assign(command, fn, envir = git)

  }

  assign("git", git, envir = .__Rprofile.env__.)

  # tools for munging the PATH
  PATH <- (function() {

    read <- function() {
      strsplit(Sys.getenv("PATH"), .Platform$path.sep, TRUE)[[1]]
    }

    write <- function(path) {
      Sys.setenv(PATH = paste(path, collapse = .Platform$path.sep))
      invisible(path)
    }

    prepend <- function(dir) {
      dir <- normalizePath(dir, mustWork = TRUE)
      path <- c(dir, setdiff(read(), dir))
      write(path)
    }

    append <- function(dir) {
      dir <- normalizePath(dir, mustWork = TRUE)
      path <- c(setdiff(read(), dir), dir)
      write(path)
    }

    remove <- function(dir) {
      path <- setdiff(read(), dir)
      write(path)
    }

    list(
      read = read,
      write = write,
      prepend = prepend,
      append = append,
      remove = remove
    )

  })()
  assign("PATH", PATH, envir = .__Rprofile.env__.)


  # ensure commonly-used packages are installed, loaded
  quietly <- function(expr) {
    status <- FALSE
    suppressWarnings(suppressMessages(
      utils::capture.output(status <- expr)
    ))
    status
  }

  install <- function(package) {

    code <- sprintf(
      "utils::install.packages(%s, lib = %s, repos = %s)",
      shQuote(package),
      shQuote(.libPaths()[[1]]),
      shQuote(getOption("repos")[["CRAN"]])
    )

    R <- file.path(
      R.home("bin"),
      if (info$sysname == "Window") "R.exe" else "R"
    )

    con <- tempfile(fileext = ".R")
    writeLines(code, con = con)
    on.exit(unlink(con), add = TRUE)

    cmd <- paste(shQuote(R), "-f", shQuote(con))
    system(cmd, ignore.stdout = TRUE, ignore.stderr = TRUE)
  }

  if (file.exists("renv/activate.R"))
    return()

  packages <- c()
  invisible(lapply(packages, function(package) {

    if (quietly(require(package, character.only = TRUE, quietly = TRUE)))
      return()

    message("Installing '", package, "' ... ", appendLF = FALSE)
    install(package)

    success <- quietly(require(package, character.only = TRUE, quietly = TRUE))
    message(if (success) "OK" else "FAIL")

  }))

  # clean up extra attached envs
  addTaskCallback(function(...) {
    count <- sum(search() == "local:rprofile")
    if (count == 0)
      return(FALSE)

    for (i in seq_len(count - 1))
      detach("local:rprofile")

    return(FALSE)
  })

  # display startup message(s)
  msg <- if (length(.libPaths()) > 1)
    "Using libraries at paths:\n"
  else
    "Using library at path:\n"
  libs <- paste("-", .libPaths(), collapse = "\n")
  message(msg, libs, sep = "")

}))
