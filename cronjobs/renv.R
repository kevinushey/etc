library(renv)

updated <- any(
  renv:::renv_mran_database_sync("windows", "4.2"),
  renv:::renv_mran_database_sync("macosx", "4.2"),
  renv:::renv_mran_database_sync("macosx/big-sur-arm64", "4.2")
)

if (updated || "--force" %in% commandArgs(TRUE)) {

  src <- renv:::renv_mran_database_path()
  tgt <- "s3://rstudio-buildtools/renv/mran/packages.rds"

  Sys.setenv(AWS_PROFILE = "kevin")
  args <- c("s3", "cp", "--acl", "public-read", shQuote(src), shQuote(tgt))
  system2("aws", args)

}

