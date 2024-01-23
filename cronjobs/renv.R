library(renv)

# renv:::renv_mran_database_sync_all()

src <- renv:::renv_mran_database_path()
tgt <- "s3://rstudio-buildtools/renv/package-manager/packages.rds"

Sys.setenv(AWS_PROFILE = "kevin")
args <- c("s3", "cp", "--acl", "public-read", shQuote(src), shQuote(tgt))
system2("aws", args)

