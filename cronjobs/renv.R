library(renv)

updated <- any(
  renv:::renv_mran_database_sync("windows", "4.0"),
  renv:::renv_mran_database_sync("macosx", "4.0")
)

if (updated || "--force" %in% commandArgs(TRUE)) {

  src <- renv:::renv_mran_database_path()
  tgt <- "s3://rstudio-buildtools/renv/mran/packages.rds"

  args <- c("s3", "cp", "--acl", "public-read", shQuote(src), shQuote(tgt))
  system2("/usr/local/bin/aws", args)

}

