#!/usr/bin/env Rscript
args <- commandArgs(TRUE)
message <- paste(args, collapse = " ")

status <- system2("git", c("status", "-s"), stdout = TRUE)
files <- gsub(".* ", "", status)
header <- paste(Sys.Date(), "Kevin Ushey", "<kevinushey@gmail.com>", sep = "  ")
message <- c(message, rep("Idem", length(files) - 1))
body <- sprintf("        * %s: %s", files, message)

ChangeLog <- readLines("ChangeLog")
ChangeLog <- c(
    header,
    "",
    body,
    "",
    ChangeLog
)
cat(ChangeLog, file = "ChangeLog", sep = "\n")
