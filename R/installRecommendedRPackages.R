installed_pkgs <- unname(installed.packages()[,1])

## First, we install packages on CRAN
pkgs <- c(
  "car",
  "data.table",
  "devtools",
  "ggplot2",
  "gridExtra",
  "knitr",
  "latticeExtra",
  "lme4",
  "microbenchmark",
  "plyr",
  "rbenchmark",
  "Rcpp",
  "RcppArmadillo",
  "RCurl",
  "rJava",
  "roxygen2",
  "shiny",
  "stringr",
  "testthat",
  "xlsx",
  "XML"
)

to_install <- pkgs[ !(pkgs %in% installed_pkgs) ]
if (length(to_install))
  install.packages(to_install)

## Next, we install packages on Bioconductor
if (!("BiocInstaller" %in% installed_pkgs)) {
  source("http://bioconductor.org/biocLite.R")
}

biocLite()

## Finally, some packages that are on GitHub
install_if <- function(pkg, ...) {
  if (!(pkg %in% installed.packages()[,1]))
    install_github(repo=pkg, ...)
}

library(devtools)

install_if("Kmisc", "kevinushey")
install_if("data.table.extras", "kevinushey")
install_if("rCharts", "ramnathv")
