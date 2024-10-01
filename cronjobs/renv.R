library(renv)

# renv:::renv_p3m_database_sync_all()
src <- renv:::renv_p3m_database_path()
tgt <- "s3://rstudio-buildtools/renv/package-manager/packages.rds"

# aws sso login
args <- c("s3", "cp", "--acl", "public-read", shQuote(src), shQuote(tgt))
system2("aws", args)

