if (interactive()) {

  .Start.time <- as.numeric(Sys.time())
  
  .__Rprofile.env__. <- new.env()
  
  ## ensure user library
  local({
    userLibs <- Sys.getenv("R_LIBS_USER")
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
  })
  
  ## use https repos
  options(repos = c(CRAN = "https://cran.rstudio.org"))
  
  ## if using 'curl', ensure stderr redirected
  local({
    method <- getOption("download.file.method")
    if (is.null(method) && Sys.which("curl") != "") {
      options(download.file.method = "curl")
      options(download.file.extra = "-L -f --stderr -")
    }
  })
  
  ## always run Rcpp tests
  Sys.setenv(RunAllRcppTests = "yes")
  
  ## ensure custom library path available
  if (Sys.info()[["sysname"]] == "Darwin") {
    local({
      rVersion <- unclass(getRversion())[[1]]
      string <- paste(rVersion[1], rVersion[2], sep = ".")
      libPath <- file.path("~/Library/R", string, "library")
      if (!file.exists(libPath))
        dir.create(libPath, recursive = TRUE)
    })
  }
  
  try_library <- function(x) {
    tryCatch(
      library(match.call()$x),
      warning = function(x)
        invisible(NULL),
      error = function(x)
        invisible(NULL)
    )
  }
  
  tryGet <- function(...) {
    lapply(list(...), function(package) {
      if (!suppressMessages(suppressWarnings(require(package, character.only = TRUE)))) {
        warning("Could not load '", package, "'! Trying to install...")
        utils::install.packages(package, repos = "http://cran.rstudio.org")
        if (!suppressMessages(require(package, character.only = TRUE))) {
          warning("Failed to install and load package.")
        }
      }
    })
  }

  tryGet("devtools", "knitr", "testthat")
  rm(tryGet)

  ig <- devtools::install_github

  ## auto-completion of package names in `require`, `library`
  utils::rc.settings(ipck = TRUE)

  ## no tcltk
  options(menu.graphics = FALSE)

  ## browser tweaks
  options(browserNLdisabled = TRUE)

  ## warn on partial matches
  # options(warnPartialMatchArgs = TRUE) ## too noisy
  options(warnPartialMatchAttr = TRUE)
  options(warnPartialMatchDollar = TRUE)

  ## warn right away
  options(warn = 1)

  ## custom defaults for knitr
  if (!suppressMessages(require(knitr)))
    message("Warning: 'knitr' could not be loaded!")

  opts_chunk$set(
    fig.height = 5,
    fig.width  = 7.5,
    out.extra  = '',
    tidy       = FALSE,
    results    = "asis"
  )

  ## .Rprofile opens .Rprofile for editing
  .Rprofile <- ''
  attr(.Rprofile, "class") <- "__Rprofile__"
  print.__Rprofile__ <- function(x, ...) {
    file.edit("~/.Rprofile", ...)
  }
  assign(".Rprofile", .Rprofile, envir = .__Rprofile.env__.)
  assign("print.__Rprofile__", print.__Rprofile__, envir = .__Rprofile.env__.)

  ## .CSS opens markdown.css for knitr docs
  .CSS <- ''
  attr(.CSS, "class") <- "__CSS__"
  print.__CSS__ <- function(x, ...) {
    file.edit("~/Dropbox/R/kPackages/Kmisc/inst/resources/css/Kmisc.css", ...)
  }
  assign(".CSS", .CSS, envir = .__Rprofile.env__.)
  assign("print.__CSS__", print.__CSS__, envir = .__Rprofile.env__.)

  ## .template opens markdown_html_template.html for knitr docs
  .template <- ''
  attr(.template, "class") <- "__template__"
  print.__template__ <- function(x, ...)
    file.edit("~/Dropbox/R/kPackages/Kmisc/inst/resources/markdown_HTML_template.html", ...)
  
  assign(".template", .template, envir = .__Rprofile.env__.)
  assign("print.__template__", print.__template__, envir = .__Rprofile.env__.)

  ## Makevars opens the R version Makevars.site file
  Makevars <- ''
  attr(Makevars, "class") <- "__Makevars__"
  print.__Makevars__ <- function(x, ...) {
    utils::file.edit( file.path( Sys.getenv("R_HOME"), "etc", "Makevars.site" ), ...)
  }
  assign("Makevars", Makevars, envir = .__Rprofile.env__.)
  assign("print.__Makevars__", print.__Makevars__, envir = .__Rprofile.env__.)

  ## Some git aliases for doing git stuff from the command line
  git <- function(...) system(paste("git", ...))
  assign("git", git, envir = .__Rprofile.env__.)

  ## git status
  git_status <- ''
  attr(git_status, "class") <- "__git_status__"
  print.__git_status__ <- function(x, ...) system("git status")
  assign("git_status", git_status, envir = .__Rprofile.env__.)
  assign("print.__git_status__", print.__git_status__, envir = .__Rprofile.env__.)

  ## print the names of a nested list as a tree
  nametree <- function(X, prefix1 = "", prefix2 = "", prefix3 = "", prefix4 = "", max.nest=3) {
    if (is.list(X) && !is.data.frame(X)) {
      for (i in seq_along(X)) {
        nm <- names(X)[i]
        if (is.null(nm)) nm <- "."
        cat( if(i<length(X)) prefix1 else prefix3, nm, "\n", sep="" )
        prefix <- if( i<length(X) ) prefix2 else prefix4
        if (max.nest>0) {
          nametree(
            X[[i]],
            paste0(prefix, "├──"),
            paste0(prefix, "│  "),
            paste0(prefix, "└──"),
            paste0(prefix, "   "),
            max.nest-1
          )
        }
      }
    }
  }

  ## clean up all of the dot functions generated earlier
  .First <- function() {

    NAME <- paste(collapse = "", intToUtf8(
      multiple = TRUE,
      c(75L, 101L, 118L, 105L, 110L, 32L, 85L, 115L, 104L, 101L, 121L)
    ))

    EMAIL <- paste(collapse = "", intToUtf8(
      multiple = TRUE,
      c(107L, 101L, 118L, 105L, 110L, 117L, 115L, 104L,
        101L, 121L, 64L, 103L, 109L, 97L, 105L, 108L,
        46L, 99L, 111L, 109L)
    ))

    ## I prefer using my own browser
    options(shiny.launch.browser = TRUE)

    ## NOTE: For R color output in console
    ##  setOutputColors256(normal = 6,
    ##                     number = 51,
    ##                     negnum = 183,
    ##                     string = 79,
    ##                     const = 75,
    ##                     error = 160,
    ##                     verbose = FALSE
    ##  )


    msg <- if (length(.libPaths()) > 1)
      "Using libraries at paths:\n"
    else
      "Using library at path:\n"
    libs <- paste("-", .libPaths(), collapse = "\n")
    message(msg, libs, sep = "")

    wrap_cb <- function(width = 80) {
      tmp <- "%%__NEWLINE__TMP__%%"
      txt <- Kmisc::scan.cb()
      pasted <- paste(txt, collapse = "\n")
      subbed <- gsub("\n\n", tmp, pasted)
      subbed <- gsub("\n", " ", subbed)
      subbed <- gsub(tmp, "\n\n", subbed)
      Kmisc::cat.cb(Kmisc::wrap(subbed, width = width))
    }

    rm(.CSS, envir = .GlobalEnv)
    rm(print.__CSS__, envir = .GlobalEnv)
    
    rm(.Rprofile, envir = .GlobalEnv)
    rm(print.__Rprofile__, envir = .GlobalEnv)
    
    rm(.template, envir = .GlobalEnv)
    rm(print.__template__, envir = .GlobalEnv)
    
    rm(Makevars, envir = .GlobalEnv)
    rm(print.__Makevars__, envir = .GlobalEnv)
    
    rm(nametree, envir = .GlobalEnv)
    
    rm(try_library, envir = .GlobalEnv)
    rm(ig, envir = .GlobalEnv)
    
    ## clean up the git statu
    rm(git, envir = .GlobalEnv)
    
    rm(git_status, envir = .GlobalEnv)
    rm(print.__git_status__, envir = .GlobalEnv)

    assign("sfgrep", function(x) system(paste('fgrep', x, '-r *')), envir = .__Rprofile.env__.)
    assign("ag", envir = .__Rprofile.env__., function(x) {
      system(paste("ag", x))
    })

    attach(.__Rprofile.env__.)

    options("devtools.desc" = list(
      Author = NAME,
      Maintainer = paste(NAME, "<", EMAIL, ">", sep = ""),
      License = "MIT + file LICENSE",
      Version = "0.0.1"
    ))
    options("devtools.name" = NAME)

    if (exists("NAME", environment()))
      rm(NAME, envir = environment())

    if (exists("EMAIL", environment()))
      rm(EMAIL, envir = environment())

    # Clean up extra loaded .__Rprofile__.'s
    addTaskCallback(function(...) {

      while (TRUE) {
        matches <- which(search() == ".__Rprofile.env__.")
        if (length(matches) <= 1)
          break

        detach(pos = matches[length(matches)])
      }

      return(FALSE)
    })

    on.exit(rm(.First, envir = .GlobalEnv))

  }

  .Last <- function() {
    while (".__Rprofile.env__." %in% search()) {
      detach(".__Rprofile.env__.")
    }
  }

  assign("ig", ig, envir = .__Rprofile.env__.)

}
